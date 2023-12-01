Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE04801570
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379678AbjLAVdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjLAVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5F10E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:33:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC9C433C7;
        Fri,  1 Dec 2023 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701466400;
        bh=YtF+HG7uyHGCB80zMWlxTQc+O5fEWTNNEjS+VJTvaKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F31NF7i8Qcu+arEuEbKWIVU5oWYsZGlTsBZSWkUo98N8FkrCPbmUOg5rOclyakcJ0
         3LnY8ogh/k+x5iIATms0MN/IFMsaD6p0WE6zCIkpyYS0Zu6iibcaVGXmXU7F5WOqOh
         Bj5/DrPK2aUb7aWZiKvSfIHmzc4bAseovq8gQn2CPbaCrI0CTA/tT0nyQAjFEVfWg6
         ZjAlQApmm1dN0GHUngQAFkbx69l0pGr1L4PAclJw6nIk++qAfKx8DhthObiN65kqrB
         Xk/82YE2Ctd3qRfMWarz8krvjuYStXuxNE9pgcm9vnDQyGhACJgP2siU8Bs2KPAPj7
         94WVkZcZfBoEg==
Date:   Fri, 1 Dec 2023 13:36:47 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: sm4450: correct incorrect address
 offset
Message-ID: <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-5-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130024046.25938-5-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:40:46AM +0800, Tengfei Fan wrote:
> The address offset of 0x100000 is already provided in SM4450 DTSI, so
> subtract 0x100000 from the offset which used by ufs and sdc.
> 

As Konrad points out, please fix the broken patch, don't add a separate
fix in the same series.

> Suggested-by: Can Guo <quic_cang@quicinc.com>

We unfortunately don't have a way to give credit to those providing
review feedback, so omit this when fixing patch #2.

Regards,
Bjorn

> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm4450.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm4450.c b/drivers/pinctrl/qcom/pinctrl-sm4450.c
> index 49e2e3a7a9cb..5496f955ed2a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm4450.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm4450.c
> @@ -936,14 +936,14 @@ static const struct msm_pingroup sm4450_groups[] = {
>  	[133] = PINGROUP(133, _, phase_flag, _, _, _, _, _, _, _),
>  	[134] = PINGROUP(134, tsense_pwm1_out, tsense_pwm2_out, _, _, _, _, _, _, _),
>  	[135] = PINGROUP(135, _, phase_flag, _, _, _, _, _, _, _),
> -	[136] = UFS_RESET(ufs_reset, 0x197000),
> -	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x18c004, 0, 0),
> -	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x18c000, 13, 6),
> -	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x18c000, 11, 3),
> -	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x18c000, 9, 0),
> -	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x18f000, 14, 6),
> -	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x18f000, 11, 3),
> -	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x18f000, 9, 0),
> +	[136] = UFS_RESET(ufs_reset, 0x97000),
> +	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x8c004, 0, 0),
> +	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x8c000, 13, 6),
> +	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x8c000, 11, 3),
> +	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x8c000, 9, 0),
> +	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x8f000, 14, 6),
> +	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x8f000, 11, 3),
> +	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x8f000, 9, 0),
>  };
>  
>  static const struct msm_gpio_wakeirq_map sm4450_pdc_map[] = {
> -- 
> 2.17.1
> 
