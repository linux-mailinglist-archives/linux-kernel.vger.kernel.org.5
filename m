Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78365760C21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGYHl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjGYHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:41:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D81BF0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:40:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-993a37b79e2so830244466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690270800; x=1690875600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrHfPZx3m7ETdKsggeDbNp4hUSj5sbEikKTzBEPpJZo=;
        b=M4BL6Vzj6qPiA0kpPiwDs5DA8QbI7iWtNGRxzHNfKLOm90271SME9alsDDcYQFxwv3
         KZ1isUhITNnPXPuQo9iQuee381kWbfyMI7XN7jQRSP/vJEhgr2PQDXBjlHd8nNATY0r5
         E1/h71XLyIVU6nEoYker+c7vep4pEOA7L2IodD2p72vG1jFaaolXLBy9IOS1/2zhkQgG
         ofuUOnTfJkIZ5RIZKtUX3diBDAL8FFXlh2cuMWLTmKbGpgVJIHQhvLQ3goWTb4+ZzlwW
         xK8d5Vzgw4Xvn9L2qiwaB4W38T71zYvGVJRQVW7pAaqgj1c5BqT6QvNF96XXx18Z3MC1
         J9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270800; x=1690875600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrHfPZx3m7ETdKsggeDbNp4hUSj5sbEikKTzBEPpJZo=;
        b=Bd/wtSGsXa1R9TCJPxuGo/u1K+hjEnyQxlemgQxfhA/Jc1SU/atOqaSDR9CLcZ7ndn
         OezFQbPG6phleTLm0GOo9ga9x5pfYTHT2xj8DQbPleZLiZTxXek78JGouIP0eosjIDOM
         t2/zz8EqojRmqCa+HmBrlfwxgItQF0towfoSNHJwkQUlwqtYVydrwHUR0d29frnV0Iig
         TrQMf6HPmjC17nje1gsqDenttRebGYgGh8OOzreldKlmASKj1ZuPQiqjpTRyh4Ht4JBH
         BF5A1esxEpdnB/NZTmQtOnZwMEBwhOHtmuBobus3PyV3drAbrMmndI4hkhNkADCnMhPn
         8bcA==
X-Gm-Message-State: ABy/qLaEogHoyISgKUPt/SsjUTojqrZK+DkVF3onFZ/kcXEfaxgSN61N
        Ad8lfH7OTp9sY+grlb26fSNBuQ==
X-Google-Smtp-Source: APBJJlFEWtBoJHCaLUCiJnxrCzyyTztNzwfHwUzo9iTlF+mQeheI/8NYatU7cCMbzB3HSzm8DvyVNQ==
X-Received: by 2002:a17:906:8476:b0:994:54af:e27d with SMTP id hx22-20020a170906847600b0099454afe27dmr11362150ejc.29.1690270800268;
        Tue, 25 Jul 2023 00:40:00 -0700 (PDT)
Received: from linaro.org ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00992b2c55c67sm7862383ejb.156.2023.07.25.00.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:39:59 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:39:58 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range
Message-ID: <ZL98Tgpb29HLXYDr@linaro.org>
References: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-25 20:33:39, Peng Fan (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> The SPLL2 on iMX8ULP is different with other frac PLLs, it can
> support VCO from 650Mhz to 1Ghz. According to RM, the MULT is
> using a range from 27 to 54, not some fixed values. If using
> current PLL implementation, some clock rate can't be supported.
> 
> Fix the issue by adding new type for the SPLL2 and use MULT range
> to replace MULT table
> 
> Fixes: 5f0601c47c33 ("clk: imx: Update the pllv4 to support imx8ulp")
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-pllv4.c | 46 +++++++++++++++++++++++++++++--------
>  drivers/clk/imx/clk.h       |  1 +
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
> index 6e7e34571fc8..9b136c951762 100644
> --- a/drivers/clk/imx/clk-pllv4.c
> +++ b/drivers/clk/imx/clk-pllv4.c
> @@ -44,11 +44,15 @@ struct clk_pllv4 {
>  	u32		cfg_offset;
>  	u32		num_offset;
>  	u32		denom_offset;
> +	bool		use_mult_range;
>  };
>  
>  /* Valid PLL MULT Table */
>  static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
>  
> +/* Valid PLL MULT range, (max, min) */
> +static const int pllv4_mult_range[] = {54, 27};
> +
>  #define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
>  
>  #define LOCK_TIMEOUT_US		USEC_PER_MSEC
> @@ -94,17 +98,30 @@ static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
>  static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
>  				 unsigned long *prate)
>  {
> +	struct clk_pllv4 *pll = to_clk_pllv4(hw);
>  	unsigned long parent_rate = *prate;
>  	unsigned long round_rate, i;
>  	u32 mfn, mfd = DEFAULT_MFD;
>  	bool found = false;
>  	u64 temp64;
> -
> -	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> -		round_rate = parent_rate * pllv4_mult_table[i];
> -		if (rate >= round_rate) {
> +	u32 mult;
> +
> +	if (pll->use_mult_range) {
> +		temp64 = (u64)rate;
> +		do_div(temp64, parent_rate);
> +		mult = temp64;
> +		if (mult >= pllv4_mult_range[1] &&
> +		    mult <= pllv4_mult_range[0]) {
> +			round_rate = parent_rate * mult;
>  			found = true;
> -			break;
> +		}
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +			round_rate = parent_rate * pllv4_mult_table[i];
> +			if (rate >= round_rate) {
> +				found = true;
> +				break;
> +			}
>  		}
>  	}
>  
> @@ -138,14 +155,20 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return round_rate + (u32)temp64;
>  }
>  
> -static bool clk_pllv4_is_valid_mult(unsigned int mult)
> +static bool clk_pllv4_is_valid_mult(struct clk_pllv4 *pll, unsigned int mult)
>  {
>  	int i;
>  
>  	/* check if mult is in valid MULT table */
> -	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> -		if (pllv4_mult_table[i] == mult)
> +	if (pll->use_mult_range) {
> +		if (mult >= pllv4_mult_range[1] &&
> +		    mult <= pllv4_mult_range[0])
>  			return true;
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +			if (pllv4_mult_table[i] == mult)
> +				return true;
> +		}
>  	}
>  
>  	return false;
> @@ -160,7 +183,7 @@ static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  	mult = rate / parent_rate;
>  
> -	if (!clk_pllv4_is_valid_mult(mult))
> +	if (!clk_pllv4_is_valid_mult(pll, mult))
>  		return -EINVAL;
>  
>  	if (parent_rate <= MAX_MFD)
> @@ -227,10 +250,13 @@ struct clk_hw *imx_clk_hw_pllv4(enum imx_pllv4_type type, const char *name,
>  
>  	pll->base = base;
>  
> -	if (type == IMX_PLLV4_IMX8ULP) {
> +	if (type == IMX_PLLV4_IMX8ULP ||
> +	    type == IMX_PLLV4_IMX8ULP_1GHZ) {
>  		pll->cfg_offset = IMX8ULP_PLL_CFG_OFFSET;
>  		pll->num_offset = IMX8ULP_PLL_NUM_OFFSET;
>  		pll->denom_offset = IMX8ULP_PLL_DENOM_OFFSET;
> +		if (type == IMX_PLLV4_IMX8ULP_1GHZ)
> +			pll->use_mult_range = true;
>  	} else {
>  		pll->cfg_offset = PLL_CFG_OFFSET;
>  		pll->num_offset = PLL_NUM_OFFSET;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index af19d9f6aed0..adb7ad649a0d 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -45,6 +45,7 @@ enum imx_pll14xx_type {
>  enum imx_pllv4_type {
>  	IMX_PLLV4_IMX7ULP,
>  	IMX_PLLV4_IMX8ULP,
> +	IMX_PLLV4_IMX8ULP_1GHZ,
>  };
>  
>  enum imx_pfdv2_type {
> -- 
> 2.37.1
> 
