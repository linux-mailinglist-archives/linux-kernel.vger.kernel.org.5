Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3527D68D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjJYKf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbjJYKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1B10C6;
        Wed, 25 Oct 2023 03:35:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44581C433C8;
        Wed, 25 Oct 2023 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698230102;
        bh=58+Mou08nY22qSI2kcR2X7ao1pMoXvcAK23BpqCVe88=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I/jJU600/ucSi3pl2JckyZP+QNnU8dUO4msq+9w2vatOjNPDIsEJWD933yb9yGyYj
         IPdm5HNN5cL6GTuN+1KRN24kah4UKuWRcK+IRbWJZJw10o7kHIAsco6nNiscrO0VVY
         /yNTFNH5Vd82k+klWbVmoOvXXHfgsik7SEOv6dj80tlFITQc+5leWRdK/mqrGlFo6p
         clKq2eMG+YzKsz6+ZnsewS8LtRT0Eg1QMIgRr7aAJxVJD1UYDK17NtsVWkhYNB9onP
         oUoSTeAtrw5ZpzuqZCuUWUkjwGcFMoXWEcfG4UYJRq67OA9yWk+m8BJxE5Mhuk+Ei6
         faVRMQwnyx2wQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Introduce and use ath12k_sta_to_arsta()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019-upstream-ath12k_sta_to_arsta-v1-1-06f06f693338@quicinc.com>
References: <20231019-upstream-ath12k_sta_to_arsta-v1-1-06f06f693338@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169823009956.891844.2307289880340272431.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 10:35:01 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently, the logic to return an ath12k_sta pointer, given a
> ieee80211_sta pointer, uses typecasting throughout the driver. In
> general, conversion functions are preferable to typecasting since
> using a conversion function allows the compiler to validate the types
> of both the input and output parameters.
> 
> ath12k already defines a conversion function ath12k_vif_to_arvif() for
> a similar conversion. So introduce ath12k_sta_to_arsta() for this use
> case, and convert all of the existing typecasting to use this
> function.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9ef118152ee0 wifi: ath12k: Introduce and use ath12k_sta_to_arsta()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019-upstream-ath12k_sta_to_arsta-v1-1-06f06f693338@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

