Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A46777740
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjHJLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjHJLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:37:32 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8A10D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:37:16 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230810113715epoutp01064f2ef07ed8cf166d58a1b9aea4716c~6ApG_QFyU0304203042epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230810113715epoutp01064f2ef07ed8cf166d58a1b9aea4716c~6ApG_QFyU0304203042epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691667435;
        bh=XsegmZf79XA/azGvRLpK9db7vq2aY68bd5h/fULpGPg=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=R3ExMWUWHcOZ7JBdUdf0QV0hU2JLz8HXRLGCE0fSLo4tBD6Zs0ZqQj44gdVJpVn6W
         qe020TKStbJNQfgu7u4EDjAdbBVtbRtPVr8OAOvXQxWdNQJa0sbdEa0RGJpovW8Rle
         q0AoX/l/f/J3FbNESIOc7G0sJKvDAEfKFyFRkaSU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810113714epcas5p1e913f4a44357bd9e615413d2703ebae4~6ApGWLx6R1480714807epcas5p1B;
        Thu, 10 Aug 2023 11:37:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RM4f04XxBz4x9Pq; Thu, 10 Aug
        2023 11:37:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.48.06099.8EBC4D46; Thu, 10 Aug 2023 20:37:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230810113712epcas5p19138f05ae5d3ed1c3b7d6f25ab9d7082~6ApEW7Iaa2519725197epcas5p12;
        Thu, 10 Aug 2023 11:37:12 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810113712epsmtrp23bbb4f55a44d6724ab507a3755fef5bd~6ApEWK7yu1161711617epsmtrp21;
        Thu, 10 Aug 2023 11:37:12 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-d0-64d4cbe85c7f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.9C.14748.8EBC4D46; Thu, 10 Aug 2023 20:37:12 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810113709epsmtip2383186af5c54326886b2f134a1ae0c88~6ApCSCe6L1081710817epsmtip2P;
        Thu, 10 Aug 2023 11:37:09 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-11-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 10/11] clk: samsung: exynoautov9: do not define number
 of clocks in bindings
Date:   Thu, 10 Aug 2023 17:07:08 +0530
Message-ID: <004d01d9cb7f$00bd6e80$02384b80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gIdp3efAvbTNqquMzcwUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmlu6L01dSDF7NUbRYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Izd6/6zFqwwrFjY
        NpepgfGLRhcjJ4eEgInEyf5ZrF2MXBxCArsZJQ5/vMoM4XxilDj3dy8ThPONUWLxl0+MMC1r
        l2xhh0jsZZR4v/QbI4TzklGip/0QE0gVm4CuxI7FbWwgCRGBWSwSvw+vBmvnFHCTaOy+xgpi
        CwskSVyavwTI5uBgEVCVaL0ZARLmFbCUmPn2BROELShxcuYTFhCbWUBeYvvbOcwQVyhI/Hy6
        DGyMiICTxPdbW9kgasQlXh49AnadhMAJDolHjzexQDS4SDz6PJcVwhaWeHUc5AUQW0ri87u9
        bCA3SAh4SCz6IwURzpB4u3w91Mf2EgeuzGEBKWEW0JRYv0sfYhWfRO/vJ0wQnbwSHW1CENWq
        Es3vrkItlZaY2N0NtdRD4tXu3dAAvcIo0bl3NcsERoVZSL6cheTLWUi+mYWweQEjyypGydSC
        4tz01GLTAuO81HJ4hCfn525iBKdlLe8djI8efNA7xMjEwXiIUYKDWUmE1zb4UooQb0piZVVq
        UX58UWlOavEhRlNgyE9klhJNzgdmhrySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NT
        C1KLYPqYODilGpgEYg8UvugWbHY84/LK6eySDc1tmiYifc3R7RZuwusylCMSNrBEr/Dg6nm0
        qGPO/d8nal7KVzjn9JW8+Jwdv7ptV0jgvRW3NW/H8XSdv2Lrv7rMUO5L1R3xqN/6X6dqL151
        ar2IZGbAnu9qE96wRz/4t12Ez0nN4LUXz1SR+/28GlPf5j0Tb595baJLsHTMuQK27z/PNxst
        nCgitZjjWYTb9J9Zbw/OOlvPe+We/YSouIldCrsuXIw/9auN0cK6RoXnWKbTDJaf6e6OuUoX
        XEt0lF/tWLjt2ZE5bf7fI18e3MH0aaKf+o9tbes9D2xR6Uu84xrecdGfXW9XQK7+z8uTY8pM
        K0Iuz9oXZHNVKUyJpTgj0VCLuag4EQCTIWctVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO6L01dSDP7dYrVYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAexSXTUpqTmZZapG+
        XQJXxu51/1kLVhhWLGyby9TA+EWji5GTQ0LARGLtki3sXYxcHEICuxklVvbsYYJISEtc3ziB
        HcIWllj57zmYLSTwnFFi03JREJtNQFdix+I2NpBmEYElLBLnHm9jhph0gVHidss+NpAqTgE3
        icbua6wgtrBAgsTzOw+Bijg4WARUJVpvRoCEeQUsJWa+fcEEYQtKnJz5hAWkhFlAT6JtIyNI
        mFlAXmL72znMEPcoSPx8ugxsooiAk8T3W1vZIGrEJV4ePcI+gVFoFpJJsxAmzUIyaRaSjgWM
        LKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYLjT0tjB+O9+f/0DjEycTAeYpTgYFYS
        4bUNvpQixJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA5NE
        Q1wi31OhYoPHkuW+fX9/LpWZUvl+RWgy2xTLnUZe3tt6OWd+VYi8FnKDY1NV4Otlz252nCnL
        iJFkZc7M2nR2eRfH+8YHfwI5H7+4vHCKkMmX9tvaWrq3jX49O5McP/nIncTEhW4GJ46yFTl5
        MPKnp8lxC2+OeHwncfonvs8/FNv52HdIsu34cy8zn0v314o7fBuyU36kFqwutNtS8U+Rx4th
        8RTXRRJHdtnLvLQ8nrgvKHT9zht96quP2M5dX3U94Ppi6fSX7AcZJs9sDTbVSTjh/P2pU5J1
        tl/qa1GbtY3VGXJ9G9cvTb2pYBHTusCIt7Hn2A3uv58OZm3zUFuzksdZ/SOn8hWu1acDxZRY
        ijMSDbWYi4oTAZ0bm8kuAwAA
X-CMS-MailID: 20230810113712epcas5p19138f05ae5d3ed1c3b7d6f25ab9d7082
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082806epcas5p39cdfb291da6706cb92897978822eb674
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082806epcas5p39cdfb291da6706cb92897978822eb674@epcas5p3.samsung.com>
        <20230808082738.122804-11-krzysztof.kozlowski@linaro.org>
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
> Subject: [PATCH 10/11] clk: samsung: exynoautov9: do not define number of
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

>  drivers/clk/samsung/clk-exynosautov9.c | 29 ++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynosautov9.c
> b/drivers/clk/samsung/clk-exynosautov9.c
> index ddef546be545..e9c06eb93e66 100644
> --- a/drivers/clk/samsung/clk-exynosautov9.c
> +++ b/drivers/clk/samsung/clk-exynosautov9.c
> @@ -16,6 +16,17 @@
>  #include "clk.h"
>  #include "clk-exynos-arm64.h"
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP			(GOUT_CLKCMU_PERIS_BUS
> + 1)
> +#define CLKS_NR_BUSMC
> 	(CLK_GOUT_BUSMC_SPDMA_PCLK + 1)
> +#define CLKS_NR_CORE
> 	(CLK_GOUT_CORE_CMU_CORE_PCLK + 1)
> +#define CLKS_NR_FSYS0
> 	(CLK_GOUT_FSYS0_PCIE_GEN3B_4L_CLK + 1)
> +#define CLKS_NR_FSYS1
> 	(CLK_GOUT_FSYS1_USB30_1_ACLK + 1)
> +#define CLKS_NR_FSYS2
> 	(CLK_GOUT_FSYS2_UFS_EMBD1_UNIPRO + 1)
> +#define CLKS_NR_PERIC0			(CLK_GOUT_PERIC0_PCLK_11
> + 1)
> +#define CLKS_NR_PERIC1			(CLK_GOUT_PERIC1_PCLK_11
> + 1)
> +#define CLKS_NR_PERIS			(CLK_GOUT_WDT_CLUSTER1
> + 1)
> +
>  /* ---- CMU_TOP
------------------------------------------------------------ */
> 
>  /* Register Offset definitions for CMU_TOP (0x1b240000) */ @@ -941,7
> +952,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst
> = {
>  	.nr_fixed_factor_clks	= ARRAY_SIZE(top_fixed_factor_clks),
>  	.gate_clks		= top_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
> -	.nr_clk_ids		= TOP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_TOP,
>  	.clk_regs		= top_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
>  };
> @@ -1001,7 +1012,7 @@ static const struct samsung_cmu_info
> busmc_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(busmc_div_clks),
>  	.gate_clks		= busmc_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(busmc_gate_clks),
> -	.nr_clk_ids		= BUSMC_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_BUSMC,
>  	.clk_regs		= busmc_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(busmc_clk_regs),
>  	.clk_name		= "dout_clkcmu_busmc_bus",
> @@ -1059,7 +1070,7 @@ static const struct samsung_cmu_info
> core_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
>  	.gate_clks		= core_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
> -	.nr_clk_ids		= CORE_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CORE,
>  	.clk_regs		= core_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
>  	.clk_name		= "dout_clkcmu_core_bus",
> @@ -1299,7 +1310,7 @@ static const struct samsung_cmu_info
> fsys0_cmu_info __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(fsys0_mux_clks),
>  	.gate_clks		= fsys0_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(fsys0_gate_clks),
> -	.nr_clk_ids		= FSYS0_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_FSYS0,
>  	.clk_regs		= fsys0_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys0_clk_regs),
>  	.clk_name		= "dout_clkcmu_fsys0_bus",
> @@ -1426,7 +1437,7 @@ static const struct samsung_cmu_info
> fsys1_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(fsys1_div_clks),
>  	.gate_clks		= fsys1_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(fsys1_gate_clks),
> -	.nr_clk_ids		= FSYS1_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_FSYS1,
>  	.clk_regs		= fsys1_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys1_clk_regs),
>  	.clk_name		= "dout_clkcmu_fsys1_bus",
> @@ -1493,7 +1504,7 @@ static const struct samsung_cmu_info
> fsys2_cmu_info __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(fsys2_mux_clks),
>  	.gate_clks		= fsys2_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(fsys2_gate_clks),
> -	.nr_clk_ids		= FSYS2_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_FSYS2,
>  	.clk_regs		= fsys2_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys2_clk_regs),
>  	.clk_name		= "dout_clkcmu_fsys2_bus",
> @@ -1748,7 +1759,7 @@ static const struct samsung_cmu_info
> peric0_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(peric0_div_clks),
>  	.gate_clks		= peric0_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peric0_gate_clks),
> -	.nr_clk_ids		= PERIC0_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERIC0,
>  	.clk_regs		= peric0_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peric0_clk_regs),
>  	.clk_name		= "dout_clkcmu_peric0_bus",
> @@ -2003,7 +2014,7 @@ static const struct samsung_cmu_info
> peric1_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(peric1_div_clks),
>  	.gate_clks		= peric1_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peric1_gate_clks),
> -	.nr_clk_ids		= PERIC1_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERIC1,
>  	.clk_regs		= peric1_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peric1_clk_regs),
>  	.clk_name		= "dout_clkcmu_peric1_bus",
> @@ -2050,7 +2061,7 @@ static const struct samsung_cmu_info
> peris_cmu_info __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(peris_mux_clks),
>  	.gate_clks		= peris_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peris_gate_clks),
> -	.nr_clk_ids		= PERIS_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERIS,
>  	.clk_regs		= peris_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peris_clk_regs),
>  	.clk_name		= "dout_clkcmu_peris_bus",
> --
> 2.34.1


