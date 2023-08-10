Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8427776E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjHJL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjHJL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:26:15 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B06268D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:26:14 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230810112612epoutp010914728f9732b62ea4a218bad52e3789~6AfdwLFEU2534025340epoutp015
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:26:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230810112612epoutp010914728f9732b62ea4a218bad52e3789~6AfdwLFEU2534025340epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691666772;
        bh=1EwQ3tvka1tnP4rrf4+fc98Ufzsrq0aQ0THzeIJGJbg=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=AXt12thlu/0DCkmyW/+kv1P1aHuS3k28OA8u5bkEc5Cebsf+ATRolfCzrTTwHWnL2
         YYlpNxcUwE4NdOV7NRnmHA8Oyls/G20F8A3/CJ0Csy/eXQjpc+/LstiRRh2F56++ZO
         UwsH5KA01WtT3gw9ML+RoCEkBOjd5wpZ55nEiL5Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810112611epcas5p130613f0aa1ab87cf8e0a6819224b1dca~6AfdRHV1K0252402524epcas5p1o;
        Thu, 10 Aug 2023 11:26:11 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RM4PG49RSz4x9Pv; Thu, 10 Aug
        2023 11:26:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.0D.44250.259C4D46; Thu, 10 Aug 2023 20:26:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230810112609epcas5p306cfbeb47cedfa0d5c7a8f781a9212a9~6AfbiM3fu2453424534epcas5p3t;
        Thu, 10 Aug 2023 11:26:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810112609epsmtrp294934ad0da7715f45111b43d69a0bc21~6AfbgDe6S0531305313epsmtrp2P;
        Thu, 10 Aug 2023 11:26:09 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-53-64d4c95243d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.EA.30535.159C4D46; Thu, 10 Aug 2023 20:26:09 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810112607epsmtip27f45ee633567ea57110f90fecdb60eb6~6AfZpotTK0095800958epsmtip2K;
        Thu, 10 Aug 2023 11:26:07 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
In-Reply-To: <20230808082738.122804-5-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 04/11] clk: samsung: exynos5260: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:56:06 +0530
Message-ID: <004701d9cb7d$75ee1cb0$61ca5610$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gIOqRLbAgUuauCuOzkwQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmlm7QySspBuc+yFms2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbrz+kFWywrZjce
        Y2tgXKHfxcjJISFgIvHxy3yWLkYuDiGB3YwSz4/MYINwPjFKXDx+C8r5xihxf2krK0zLhBe3
        WUBsIYG9jBIvWjkgil4ySuxau58ZJMEmoCuxY3EbWLeIwCwWid+HVzN2MXJwcAq4SmxvUgSp
        ERZIlDjY/JwNJMwioCpxdJceSJhXwFLi7ddvbBC2oMTJmU/AdjELyEtsfzuHGeIGBYmfT5eB
        3SMi4CRx8dwmNogacYmXR4+wg6yVEDjBIbF6TjsTRIOLxLxDf1kgbGGJV8e3sEPYUhKf3+0F
        u0FCwENi0R8piHCGxNvl6xkhbHuJA1fmsICUMAtoSqzfpQ+xik+i9/cTJohOXomONiGIalWJ
        5ndXoRZJS0zs7oaGmofE576/7JCQuswo0btqN9sERoVZSL6cheTLWUi+mYWweQEjyypGydSC
        4tz01GLTAqO81HJ4bCfn525iBCdkLa8djA8ffNA7xMjEwXiIUYKDWUmE1zb4UooQb0piZVVq
        UX58UWlOavEhRlNgyE9klhJNzgfmhLySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NT
        C1KLYPqYODilGpj6f7qeFlu+y8arZMpmTRf9wmDO2YUl7QsF9e9rvnb7u/H5sfVBGi3q2ocU
        jSvLFTTYb+75E/TC/IvfEfbQA9d4JVdXG3oXb7b7uJrhLzefVLcLf8bOX5ri5/X38dXmnQrL
        Kru1iFP+Z+m+sste2i5L/k1+dSH3mLfIn4grpTHhTNe8Zz7Ilzni9/9jmvF59Y/H1DT3/tHr
        nstXNlPoD2fp4qztzKbTWh8FTmiuFbhw7Z/eWTmP5uorpSL9LOf2aNrf3rf9cfId7n1/lt7f
        MP2SqdtzoTk3dNaohvR2TCvmcMnaa6Gzki9Feeuc66nGsgWOngusGtTyGOe4nkg0a5bUuhSx
        yGaL2oPN1i/tziixFGckGmoxFxUnAgAW9U1UUQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG7gySspBps/6Fqs2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoEr4/Xn9IItlhWzG4+xNTCu0O9i5OSQEDCRmPDiNksXIxeHkMBuRolN746xQCSkJa5vnMAO
        YQtLrPz3nB2i6DmjxJt5T5hBEmwCuhI7FrexgSREBJawSJx7vI0Zouo8o8T3jj1Aozg4OAVc
        JbY3KYI0CAvESyyad5wNJMwioCpxdJceSJhXwFLi7ddvbBC2oMTJmU/AOpkF9CTaNjKChJkF
        5CW2v53DDHGPgsTPp8tYQWwRASeJi+c2sUHUiEu8PHqEfQKj0Cwkk2YhTJqFZNIsJB0LGFlW
        MUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER5+W1g7GPas+6B1iZOJgPMQowcGsJMJr
        G3wpRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmvyXf
        zPTDvk7nFdimFs870XK1Dbe24/lei2jH+VrfulMO8E74v5nPJV3woDMP027m2YUZZY/C4/Wm
        zZWIe6m4fbV9k+N3vudpOZVyDiufKXetVDvl+urPs79TDSLey95hXnhXJvPpkq2NszNcEjav
        3Pt0zssP79+qntqyoKkn6Y78x56Pe+7rFcYdVJuXsuBOvpGq5vYCK+XWm7x7J5hNP/D8zcos
        PYu4Y6sUzs+pPPvYJ+b19SsBO99psyw6olh02rF5wWz12HaDtVYhM6bmi6QXb3sfHDOfhWt+
        Qkf6vQumOR9Xvm5jK3Y+IJHJ41hS3bp+4bFv2TnqJS8e2q6auPmJ07VIjsNz1pao1d07q8RS
        nJFoqMVcVJwIADFqRUQtAwAA
X-CMS-MailID: 20230810112609epcas5p306cfbeb47cedfa0d5c7a8f781a9212a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082754epcas5p20b51ec73e6c0714491da48eafa3b13e8
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082754epcas5p20b51ec73e6c0714491da48eafa3b13e8@epcas5p2.samsung.com>
        <20230808082738.122804-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, August 8, 2023 1:58 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sylwester
> Nawrocki <s.nawrocki@samsung.com>; Tomasz Figa
> <tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Alim
> Akhtar <alim.akhtar@samsung.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: [PATCH 04/11] clk: samsung: exynos5260: do not define number of
> clocks in bindings
> 
> Number of clocks supported by Linux drivers might vary - sometimes we add
> new clocks, not exposed previously.  Therefore this number of clocks
should
> not be in the bindings, because otherwise we should not change it.
> 
> Define number of clocks per each clock controller inside the driver
directly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/clk/samsung/clk-exynos5260.c | 41 +++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5260.c
b/drivers/clk/samsung/clk-
> exynos5260.c
> index e05d7323669a..16da6ef5ca0c 100644
> --- a/drivers/clk/samsung/clk-exynos5260.c
> +++ b/drivers/clk/samsung/clk-exynos5260.c
> @@ -15,6 +15,21 @@
> 
>  #include <dt-bindings/clock/exynos5260-clk.h>
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP
> 	(PHYCLK_USBDRD30_UDRD30_PHYCLOCK + 1)
> +#define CLKS_NR_EGL			(EGL_DOUT_EGL1 + 1)
> +#define CLKS_NR_KFC			(KFC_DOUT_KFC1 + 1)
> +#define CLKS_NR_MIF
> 	(MIF_SCLK_LPDDR3PHY_WRAP_U0 + 1)
> +#define CLKS_NR_G3D			(G3D_CLK_G3D + 1)
> +#define CLKS_NR_AUD			(AUD_SCLK_I2S + 1)
> +#define CLKS_NR_MFC			(MFC_CLK_SMMU2_MFCM0
> + 1)
> +#define CLKS_NR_GSCL			(GSCL_SCLK_CSIS0_WRAP +
> 1)
> +#define CLKS_NR_FSYS			(FSYS_PHYCLK_USBHOST20 +
> 1)
> +#define CLKS_NR_PERI			(PERI_SCLK_PCM1 + 1)
> +#define CLKS_NR_DISP
> 	(DISP_MOUT_HDMI_PHY_PIXEL_USER + 1)
> +#define CLKS_NR_G2D			(G2D_CLK_SMMU3_G2D + 1)
> +#define CLKS_NR_ISP			(ISP_SCLK_UART_EXT + 1)
> +
>  /*
>   * Applicable for all 2550 Type PLLS for Exynos5260, listed below
>   * DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL, BUS_PLL, MEDIA_PLL, G3D_PLL.
> @@ -135,7 +150,7 @@ static const struct samsung_cmu_info aud_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(aud_div_clks),
>  	.gate_clks	= aud_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(aud_gate_clks),
> -	.nr_clk_ids	= AUD_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_AUD,
>  	.clk_regs	= aud_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(aud_clk_regs),
>  };
> @@ -325,7 +340,7 @@ static const struct samsung_cmu_info disp_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(disp_div_clks),
>  	.gate_clks	= disp_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(disp_gate_clks),
> -	.nr_clk_ids	= DISP_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_DISP,
>  	.clk_regs	= disp_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(disp_clk_regs),
>  };
> @@ -389,7 +404,7 @@ static const struct samsung_cmu_info egl_cmu
> __initconst = {
>  	.nr_mux_clks	= ARRAY_SIZE(egl_mux_clks),
>  	.div_clks	= egl_div_clks,
>  	.nr_div_clks	= ARRAY_SIZE(egl_div_clks),
> -	.nr_clk_ids	= EGL_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_EGL,
>  	.clk_regs	= egl_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(egl_clk_regs),
>  };
> @@ -489,7 +504,7 @@ static const struct samsung_cmu_info fsys_cmu
> __initconst = {
>  	.nr_mux_clks	= ARRAY_SIZE(fsys_mux_clks),
>  	.gate_clks	= fsys_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(fsys_gate_clks),
> -	.nr_clk_ids	= FSYS_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_FSYS,
>  	.clk_regs	= fsys_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(fsys_clk_regs),
>  };
> @@ -580,7 +595,7 @@ static const struct samsung_cmu_info g2d_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(g2d_div_clks),
>  	.gate_clks	= g2d_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(g2d_gate_clks),
> -	.nr_clk_ids	= G2D_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_G2D,
>  	.clk_regs	= g2d_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(g2d_clk_regs),
>  };
> @@ -643,7 +658,7 @@ static const struct samsung_cmu_info g3d_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(g3d_div_clks),
>  	.gate_clks	= g3d_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(g3d_gate_clks),
> -	.nr_clk_ids	= G3D_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_G3D,
>  	.clk_regs	= g3d_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(g3d_clk_regs),
>  };
> @@ -776,7 +791,7 @@ static const struct samsung_cmu_info gscl_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(gscl_div_clks),
>  	.gate_clks	= gscl_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(gscl_gate_clks),
> -	.nr_clk_ids	= GSCL_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_GSCL,
>  	.clk_regs	= gscl_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(gscl_clk_regs),
>  };
> @@ -895,7 +910,7 @@ static const struct samsung_cmu_info isp_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(isp_div_clks),
>  	.gate_clks	= isp_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(isp_gate_clks),
> -	.nr_clk_ids	= ISP_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_ISP,
>  	.clk_regs	= isp_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(isp_clk_regs),
>  };
> @@ -959,7 +974,7 @@ static const struct samsung_cmu_info kfc_cmu
> __initconst = {
>  	.nr_mux_clks	= ARRAY_SIZE(kfc_mux_clks),
>  	.div_clks	= kfc_div_clks,
>  	.nr_div_clks	= ARRAY_SIZE(kfc_div_clks),
> -	.nr_clk_ids	= KFC_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_KFC,
>  	.clk_regs	= kfc_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(kfc_clk_regs),
>  };
> @@ -1015,7 +1030,7 @@ static const struct samsung_cmu_info mfc_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(mfc_div_clks),
>  	.gate_clks	= mfc_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(mfc_gate_clks),
> -	.nr_clk_ids	= MFC_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_MFC,
>  	.clk_regs	= mfc_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(mfc_clk_regs),
>  };
> @@ -1164,7 +1179,7 @@ static const struct samsung_cmu_info mif_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(mif_div_clks),
>  	.gate_clks	= mif_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(mif_gate_clks),
> -	.nr_clk_ids	= MIF_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_MIF,
>  	.clk_regs	= mif_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(mif_clk_regs),
>  };
> @@ -1370,7 +1385,7 @@ static const struct samsung_cmu_info peri_cmu
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(peri_div_clks),
>  	.gate_clks	= peri_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(peri_gate_clks),
> -	.nr_clk_ids	= PERI_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_PERI,
>  	.clk_regs	= peri_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(peri_clk_regs),
>  };
> @@ -1826,7 +1841,7 @@ static const struct samsung_cmu_info top_cmu
> __initconst = {
>  	.nr_gate_clks	= ARRAY_SIZE(top_gate_clks),
>  	.fixed_clks	= fixed_rate_clks,
>  	.nr_fixed_clks	= ARRAY_SIZE(fixed_rate_clks),
> -	.nr_clk_ids	= TOP_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_TOP,
>  	.clk_regs	= top_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(top_clk_regs),
>  };
> --
> 2.34.1


