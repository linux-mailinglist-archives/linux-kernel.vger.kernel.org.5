Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3D784162
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjHVM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbjHVM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C6CD4;
        Tue, 22 Aug 2023 05:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4873765633;
        Tue, 22 Aug 2023 12:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32EDC433C7;
        Tue, 22 Aug 2023 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692709131;
        bh=ouJsox1dbFodWlwTb64apxEwUqHQswiCqUxFBwL0Plg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TjQkRAk5xWRCLsWrlWRCgn/FFZnH2SGAAUBxVWjdJkfQ9zEu8ZFw28GolATRmVlPR
         CxI40I+WDWoUpx8lyiJ1U8UdB9eFh4GwDa8SvH7kolJtzGeB3Q08hrMzCNt1SUU66N
         KnXEZ+sVjoXyNYhqktyTCglgA59BDcFMrV2CRnapTrQCE+4/GG+VOnJ0xownMuu4mc
         ltCMZ+DDtAukOBTowEyArTgJg3tTmt9pAPrY9vZT22xuzXut9mgkxe6+dT/H/W3Ft+
         8P2LfPJGlkl3lNWRlAOl2RdX5ac73Y9JH1avw2+vQoBZOYNLabbPsrHQTyN9m/q+2m
         OsoQhclu5QUGw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH net-next 1/2] wifi: ath11k: fix
 Wvoid-pointer-to-enum-cast warning
References: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
Date:   Tue, 22 Aug 2023 15:58:47 +0300
In-Reply-To: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Thu, 10 Aug 2023 11:12:23 +0200")
Message-ID: <87jztni67s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> 'hw_rev' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
>
>   h11k/ahb.c:1124:11: error: cast to smaller integer type 'enum ath11k_hw_rev' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

ath11k patches go to my ath.git tree, not net-next. But no need to
resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
