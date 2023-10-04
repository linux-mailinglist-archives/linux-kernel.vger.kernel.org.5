Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829BB7B7926
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbjJDHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjJDHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:55:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202F4A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:55:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so1398965a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696406148; x=1697010948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huU9GLUbAyhJezerPvvPuYZjgMHClNgkYZPBCp4Pq+Y=;
        b=S1WfeXR8AImo076v8hdVMpBnk/kNnRjLZHLFlTj2C6AvZxZHxe5ZQohFeuXNhuw+uC
         dgrWWhaJT9EyNU0QqE+1jiGhWDMXH2O+So4mfY1+8mndOCY5to/1R2vbv8DAc3cT9ADb
         +HbJKj3Y33O3J68lsdDV870gJrNstzh5k553X2cEtrToj22nqOUMLYSjEsQSEdd0J5BL
         3loZ/0pwg/jp1cP8CmbuAUZ16AhNPUfr92ie7GmuyuQGjEADZvH9AbqvyhhjJbbONzwq
         BjtR4Bn0qXRWfIiVwqd4T1WMIO8Q12FnvxNxBcH7xSG5v4NcMQw/IoFZt1sUfA9qAvnv
         CWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406148; x=1697010948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huU9GLUbAyhJezerPvvPuYZjgMHClNgkYZPBCp4Pq+Y=;
        b=JXNrsWSSV7fIIWmBpkvsaughEqlsdpD2j7KVW+2VbbvfCS8ubDxbqzEu6OsPq9FvXE
         7IUQiWx4ikj78ppXPnNBtAReM32ncx/uXxBLcjqRrToLQkyIVm5WE87xtU+kbUwYzoPI
         4ITAm1WGx4tjLhs/DUqbFIyRDoxdqMM8FAAW5KBG/tvQoBibB4j96vZrkBvA51Zv1JIO
         a6PTjwW0gN/1FoucoWnRkTwebiNlIISB8miSYbtrxM7LoOr3i2BFqTe/bF/d9Dz+rGIJ
         EJ3BKC7WwwykWcxwU4PyBAmmdj+ujY2x4g0IF98RWUEQ7gDtVgXrRjlNx4pSFBPEDr0M
         +HUQ==
X-Gm-Message-State: AOJu0Yxn977yLM5vkRBl76uQ4RiVViCzlRtXYYc8e/i+5HizYtOYU+LS
        m+xO5yn75CP2lW6jTGGIXzelSA==
X-Google-Smtp-Source: AGHT+IHYri6C7OFNJQ5pfBwP0AN4RO0hD5jinL/XXp9CFPzYNcSt/SJw8CjREvYv8gJeLfBAsQwMnQ==
X-Received: by 2002:aa7:d70b:0:b0:52f:a763:aab4 with SMTP id t11-20020aa7d70b000000b0052fa763aab4mr1234365edq.5.1696406148624;
        Wed, 04 Oct 2023 00:55:48 -0700 (PDT)
Received: from linaro.org ([86.123.99.172])
        by smtp.gmail.com with ESMTPSA id l18-20020a056402345200b005231e3d89efsm1999829edc.31.2023.10.04.00.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:55:48 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:55:46 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/4] clk: imx: Add 1039.5MHz frequency support for imx9
 pll
Message-ID: <ZR0agiulSIHBOPpb@linaro.org>
References: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-12 21:16:46, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> For video pll, it may need to 1039.5MHz clock to fulfill
> the LVDS display 148.5MHz * 7 requirement. So add 1039.5MHz
> frequency config support for i.MX9 video PLL.

Whole series LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-fracn-gppll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> index 44462ab50e51..96105ee4d9ef 100644
> --- a/drivers/clk/imx/clk-fracn-gppll.c
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -78,6 +78,7 @@ struct clk_fracn_gppll {
>   * The Fvco should be in range 2.5Ghz to 5Ghz
>   */
>  static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
> +	PLL_FRACN_GP(1039500000U, 173, 25, 100, 1, 4),
>  	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
>  	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
>  	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
> -- 
> 2.37.1
> 
