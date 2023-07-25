Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49A760BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGYHeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGYHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:33:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACC3ABF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:30:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e39784a85so1326254066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690270221; x=1690875021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BF2uC5c9tOKGK7l9S99eAFOrdaqXLFdjtMQI23eQj7w=;
        b=lTbzbQyQUnTlDAjfI0Op0YN2Y2bkEPizJaK0wuFwDW4CjCQFzUD0MSVszlWoaZMnyq
         TfoAbbZ4Z16Awyy2Ixt6qO+tsQb4RkOtb9et2nQd+9NQ+1gCwvFj4VZvmmXtDEv/pHOp
         vLf/IfjpsYpGLbEGHOizGAIPlk0fKgpMRiIYJi/VdCOyKti/5gcvFENvliQR0w26KRt+
         FW7zjoYpzaD03m/gon3/LowvZPYOonuC/N2sdn5cWxy0z7Gnzhb7E6cFzGxIzMZjtQC+
         AFFiKt3YDJRVkD6fQAmD/oiu5RKV+z8ql54uFzJ7zrG0ihVM0lZ9Wmr3i3+bv/HOr/bR
         0OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270221; x=1690875021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF2uC5c9tOKGK7l9S99eAFOrdaqXLFdjtMQI23eQj7w=;
        b=HRB93S1eHO4kEJUt4bjGYKqLuMB+z0M9V318DaBKZ6useT0i02Rn2OFc4KRYpxZMq+
         Ng91jaUd6cdPtq95vgnJqx6hSRl+Q0RH0Ydoc9KUjkbelUoT8o6wxO2UCBlVlOv/G7Pl
         37rps889a8dkSCuY+Jjxe/cT/FtirVLgI9rZJQqcYOR/lOCDm869Ez9g+M1SVxScAcgQ
         KffhYKMohsx8nfX3oDYQeIWAilEPiA34qyUDOAdwT7jaTvyVfkSFQEVUOuZuUm1FpMRg
         pmfSiW8wPpnYsx2Wb7Z4vs6CNofQiP3I8UOqds44TtWQSXisXPz67mKPpn0/yAZkE/zp
         1c+g==
X-Gm-Message-State: ABy/qLawOneBsRLzzO1airXbnWVWSEGF/nQ3QLxUSuNV4+DxTjlHjvdU
        vH874KURyHeR7hMcrOAYjoAyFA==
X-Google-Smtp-Source: APBJJlGvfmo2Yl6ar0tqyDOppXT3JcsYsLA0KbWaEqBcJIm4psVlhwo2YOjFg6RH/TkYX9BEkVu0iQ==
X-Received: by 2002:a17:906:7946:b0:98d:ebb7:a8b0 with SMTP id l6-20020a170906794600b0098debb7a8b0mr1785125ejo.14.1690270221274;
        Tue, 25 Jul 2023 00:30:21 -0700 (PDT)
Received: from linaro.org ([82.78.74.213])
        by smtp.gmail.com with ESMTPSA id r7-20020a170906c28700b0099b42c90830sm7757643ejz.36.2023.07.25.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:30:20 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:30:18 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] clk: imx: clk-imx8qxp-lpcg: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZL96ClxGXSSJaXTj@linaro.org>
References: <20230705065313.67043-1-frank.li@vivo.com>
 <20230705065313.67043-8-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705065313.67043-8-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-05 14:53:08, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 5e31a6a24b3a..e0ee9a2572d0 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -183,7 +183,6 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
>  	unsigned int bit_offset[IMX_LPCG_MAX_CLKS];
>  	struct clk_hw_onecell_data *clk_data;
>  	struct clk_hw **clk_hws;
> -	struct resource *res;
>  	void __iomem *base;
>  	int count;
>  	int idx;
> @@ -193,8 +192,7 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
>  	if (!of_device_is_compatible(np, "fsl,imx8qxp-lpcg"))
>  		return -EINVAL;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -- 
> 2.39.0
> 
