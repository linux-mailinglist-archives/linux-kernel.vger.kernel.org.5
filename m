Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F259D785A39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHWOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjHWOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B110D5;
        Wed, 23 Aug 2023 07:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0380D66029;
        Wed, 23 Aug 2023 14:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B95C433C8;
        Wed, 23 Aug 2023 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692800186;
        bh=DwblRXD6m9eIyN8zoYD7uuOYKE0IACRN+MXuDnwh9FM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O/7IdDqg83TzmzT2Xyv8WFenhvoYt95gTfhv7jrSe4hrMFQpZRh9cRbZOya4N2Nrn
         6k+vDISw6wis98y8w9azDrmV1DgtjwYD9/LgywIQ68iSeAB7N2M2syj/u94lvVJDzH
         89A3zMDaLDpO3lqHUtMUctIEItctTBratk4onh744T593Gi6N6sQLi+epV2ZgU/mR+
         GVgwM2jOPTUXdgzy9FxTB10mnMvIYkR2iBH1k8SVQtrMhhAv7BnP2kMzN6vZrzNsxi
         oliTIGa/ZnXVDwgwJ3pVEp5zXSRkH6xxa7PdzkmR0U3cackoxwoNPJh0qccH/mBYF+
         pdzlHkbdxWDHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath5k: fix WARNING opportunity for swap.
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230815040819.649455-1-mahmoudmatook.mm@gmail.com>
References: <20230815040819.649455-1-mahmoudmatook.mm@gmail.com>
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169280018252.1336947.9195494625523438821.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:16:24 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mahmoud Maatuq <mahmoudmatook.mm@gmail.com> wrote:

> coccinielle reported the following:
> ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()
> 
> while trying to fix the above warning, it reveals that ath5k_hw_get_median_noise_floor()
> had open-coded sort() functionality. Since ath5k_hw_get_median_noise_floor() only
> executes once every 10 seconds, any extra overhead due to sort() calling
> its "compare" and "swap" functions can be ignored, so replace the
> existing logic with a call to sort().
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e10ec6ea612c wifi: ath5k: ath5k_hw_get_median_noise_floor(): use swap()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230815040819.649455-1-mahmoudmatook.mm@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

