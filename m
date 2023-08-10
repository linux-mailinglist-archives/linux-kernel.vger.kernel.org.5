Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3577770F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjHJLcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjHJLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:32:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978F26AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:32:30 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230810113228epoutp0353ea1c5f40919f66604117c9e1373a3c~6Ak78ENEk1203712037epoutp03F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230810113228epoutp0353ea1c5f40919f66604117c9e1373a3c~6Ak78ENEk1203712037epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691667148;
        bh=g8Lxf57fHqv4kCM1E5HLaklcJzZdejqXXS0fF7OpMnE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=m2w5cBr03y9nH9CwEAATvEW5c6X3H8yNMb06I3MuhaEXgqfwIzmVWhkZjXHzQkm2I
         PtHa4THSF+cyN65609pvE9rOnROv6JcrQd7kl674Fm72zEQCt5o3EQnEIghEQG/c1l
         H3JcAOrzBtE05WboAo+jDzvQKjTNRM2022nGntlY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810113227epcas5p10c6b3f56410d502ceac812e54a1eb8a0~6Ak7dQ8kK1788917889epcas5p1k;
        Thu, 10 Aug 2023 11:32:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RM4XV43h7z4x9Pr; Thu, 10 Aug
        2023 11:32:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.24.55173.ACAC4D46; Thu, 10 Aug 2023 20:32:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230810113226epcas5p1faf0171fa82a0545d1b7483ca10b4dec~6Ak53hVmJ1291212912epcas5p13;
        Thu, 10 Aug 2023 11:32:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810113226epsmtrp27f06bee621ab183f9cd922bda04c85d9~6Ak52sJhD0983909839epsmtrp2S;
        Thu, 10 Aug 2023 11:32:26 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-47-64d4caca9dbe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.1B.30535.9CAC4D46; Thu, 10 Aug 2023 20:32:25 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810113224epsmtip2c80c389063205761100b68b478c69fa7~6Ak39hRZ-1010310103epsmtip2B;
        Thu, 10 Aug 2023 11:32:23 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-8-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 07/11] clk: samsung: exynos5433: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 17:02:22 +0530
Message-ID: <004a01d9cb7e$56236ba0$026a42e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gMXZR/tAWs6dDauN8OL8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmlu6pU1dSDHYulLNYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwNdy+wF1yKrti2
        qYG9gXGJdxcjB4eEgInEoz28XYxcHEICexglDhxfxA7hfGKUWPZ7FjOE841R4s7Os0xdjJxg
        HQuO9LGC2EICexkl/j22gih6yShx/ckpsCI2AV2JHYvb2EASIgKzWCR+H17NCJLgFHCVOLXz
        EViRsECixLsNZ1hB7mARUJVYfNcfJMwrYCkx//tFZghbUOLkzCcsIDazgLzE9rdzmCGOUJD4
        +XQZ2BEiAk4S3RfPskLUiEu8PHoE7AUJgRMcEuceToS62kVi04dJrBC2sMSr41vYIWwpic/v
        9rJBwsJDYtEfKYhwhsTb5esZIWx7iQNX5rCAlDALaEqs36UPsYpPovf3EyaITl6JjjYhiGpV
        ieZ3V1kgbGmJid3dUEs9JDb9ns4ICbbLjBLvv7BNYFSYheTJWUienIXkmVkIixcwsqxilEot
        KM5NT002LTDUzUsth0d3cn7uJkZwStYK2MG4esNfvUOMTByMhxglOJiVRHhtgy+lCPGmJFZW
        pRblxxeV5qQWH2I0BYb8RGYp0eR8YFbIK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7
        NbUgtQimj4mDU6qBif3PfNVkt0Uav57bdS+zZO9k+npL7fv2bfm+BW5n913wWbg9aB23jf8p
        N7sviwPnP8iIuMw4b33cK06FD0maUieiCh31BMRPfWrNCo39P9Vwbt1Cjf6HYU2ffc92uhez
        bF601+mESdmkpzsSz76KmHq+4ueJJcev3+TYZtj5Y/d0v6nVkyLEb+3N8si+3zp7yr5tzv/q
        9a6ypsS0TmJkEnm/wOJ6/5/upP71izht3jB51CZnOj1KzGJg1zmi8rZpolBMw06eLbYtQguF
        MkQqrvo94Vs7IX+uC0uuRWSDGff1SYJb9/O0LN3Kwue+9eb00y9XOsesSrTIt7DTzohY0fH5
        5/dcc6sNF3RtH1s1KbEUZyQaajEXFScCAINnLCFSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvO7JU1dSDM6dsrZYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAexSXTUpqTmZZapG+
        XQJXxoa7F9gLLkVXbNvUwN7AuMS7i5GTQ0LARGLBkT7WLkYuDiGB3YwSTUcWMkMkpCWub5zA
        DmELS6z895wdoug5o8Si+7eZQBJsAroSOxa3sYEkRASWsEice7yNGaLqPKPExk8HwKo4BVwl
        Tu18BGYLC8RLLH+xFWgUBweLgKrE4rv+IGFeAUuJ+d8vMkPYghInZz5hASlhFtCTaNvICBJm
        FpCX2P52DtRxChI/ny5jBbFFBJwkui+eZYWoEZd4efQI+wRGoVlIJs1CmDQLyaRZSDoWMLKs
        YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkAtrR2Me1Z90DvEyMTBeIhRgoNZSYTX
        NvhSihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MRzS6
        lzyME9NdYyhyl6OoMU26tykkYm33++MzZgWFzdX0lnSrO6LRe7s2bS/blWc3lMOfHDtR7157
        gN3u8l6zPbKCPzU7dNMVJe683z6lKvLeNrWQorYJf19l2vgcWn1VZIsR4+eg/08z/VK8ubmv
        +YXc+CktsdLfTnTVYtdJf94zajrNnOdTw2fGbCKy68glDo1jKgvvGuzT/ZPd9lMzwlTloGmF
        1bd5PxJPJK/pkuN9rtQ22/nY1qZLRj23pRntjtYvLNrXGb69el2goodjpLD2pa2NnB7Cme/M
        XdaJLGp/1/Fz4dcqs6NxLy22SvzeEe3W9cnqxedNAuZGz56HiVc4n40Pemh56GXfv11KLMUZ
        iYZazEXFiQBx8dYKLwMAAA==
X-CMS-MailID: 20230810113226epcas5p1faf0171fa82a0545d1b7483ca10b4dec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082759epcas5p46b2a5beab6c66bf531b2e67a4f13c3bd
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082759epcas5p46b2a5beab6c66bf531b2e67a4f13c3bd@epcas5p4.samsung.com>
        <20230808082738.122804-8-krzysztof.kozlowski@linaro.org>
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
> Subject: [PATCH 07/11] clk: samsung: exynos5433: do not define number of
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

>  drivers/clk/samsung/clk-exynos5433.c | 65 +++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c
b/drivers/clk/samsung/clk-
> exynos5433.c
> index ed43233649ae..6bfc5d0cd924 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -21,6 +21,29 @@
>  #include "clk-exynos-arm64.h"
>  #include "clk-pll.h"
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP
> 	(CLK_SCLK_HDMI_SPDIF_DISP + 1)
> +#define CLKS_NR_CPIF			(CLK_SCLK_UFS_MPHY + 1)
> +#define CLKS_NR_MIF			(CLK_SCLK_BUS_PLL_ATLAS +
> 1)
> +#define CLKS_NR_PERIC			(CLK_DIV_SCLK_SC_IN + 1)
> +#define CLKS_NR_PERIS			(CLK_SCLK_OTP_CON + 1)
> +#define CLKS_NR_FSYS			(CLK_PCIE + 1)
> +#define CLKS_NR_G2D			(CLK_PCLK_SMMU_G2D + 1)
> +#define CLKS_NR_DISP
> 	(CLK_PHYCLK_MIPIDPHY0_RXCLKESC0_PHY + 1)
> +#define CLKS_NR_AUD			(CLK_SCLK_AUD_I2S + 1)
> +#define CLKS_NR_BUSX			(CLK_ACLK_BUS2RTND_400 +
> 1)
> +#define CLKS_NR_G3D			(CLK_SCLK_HPM_G3D + 1)
> +#define CLKS_NR_GSCL			(CLK_PCLK_SMMU_GSCL2 +
> 1)
> +#define CLKS_NR_APOLLO			(CLK_SCLK_APOLLO + 1)
> +#define CLKS_NR_ATLAS			(CLK_SCLK_ATLAS + 1)
> +#define CLKS_NR_MSCL			(CLK_SCLK_JPEG + 1)
> +#define CLKS_NR_MFC			(CLK_PCLK_SMMU_MFC_0 +
> 1)
> +#define CLKS_NR_HEVC			(CLK_PCLK_SMMU_HEVC_0
> + 1)
> +#define CLKS_NR_ISP			(CLK_SCLK_PIXELASYNCM_ISPC + 1)
> +#define CLKS_NR_CAM0
> 	(CLK_SCLK_PIXELASYNCS_LITE_C_INIT + 1)
> +#define CLKS_NR_CAM1			(CLK_SCLK_ISP_CA5 + 1)
> +#define CLKS_NR_IMEM			(CLK_PCLK_SLIMSSS + 1)
> +
>  /*
>   * Register offset definitions for CMU_TOP
>   */
> @@ -798,7 +821,7 @@ static const struct samsung_cmu_info top_cmu_info
> __initconst = {
>  	.nr_fixed_clks		= ARRAY_SIZE(top_fixed_clks),
>  	.fixed_factor_clks	= top_fixed_factor_clks,
>  	.nr_fixed_factor_clks	= ARRAY_SIZE(top_fixed_factor_clks),
> -	.nr_clk_ids		= TOP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_TOP,
>  	.clk_regs		= top_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
>  	.suspend_regs		= top_suspend_regs,
> @@ -877,7 +900,7 @@ static const struct samsung_cmu_info cpif_cmu_info
> __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(cpif_div_clks),
>  	.gate_clks		= cpif_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(cpif_gate_clks),
> -	.nr_clk_ids		= CPIF_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CPIF,
>  	.clk_regs		= cpif_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cpif_clk_regs),
>  	.suspend_regs		= cpif_suspend_regs,
> @@ -1531,7 +1554,7 @@ static const struct samsung_cmu_info
> mif_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(mif_gate_clks),
>  	.fixed_factor_clks	= mif_fixed_factor_clks,
>  	.nr_fixed_factor_clks	= ARRAY_SIZE(mif_fixed_factor_clks),
> -	.nr_clk_ids		= MIF_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_MIF,
>  	.clk_regs		= mif_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mif_clk_regs),
>  };
> @@ -1730,7 +1753,7 @@ static const struct samsung_cmu_info
> peric_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(peric_div_clks),
>  	.gate_clks		= peric_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peric_gate_clks),
> -	.nr_clk_ids		= PERIC_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERIC,
>  	.clk_regs		= peric_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peric_clk_regs),
>  	.suspend_regs		= peric_suspend_regs,
> @@ -1924,7 +1947,7 @@ static const struct samsung_gate_clock
> peris_gate_clks[] __initconst = {  static const struct samsung_cmu_info
> peris_cmu_info __initconst = {
>  	.gate_clks		= peris_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peris_gate_clks),
> -	.nr_clk_ids		= PERIS_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERIS,
>  	.clk_regs		= peris_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peris_clk_regs),
>  };
> @@ -2336,7 +2359,7 @@ static const struct samsung_cmu_info
> fsys_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(fsys_gate_clks),
>  	.fixed_clks		= fsys_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(fsys_fixed_clks),
> -	.nr_clk_ids		= FSYS_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_FSYS,
>  	.clk_regs		= fsys_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
>  	.suspend_regs		= fsys_suspend_regs,
> @@ -2459,7 +2482,7 @@ static const struct samsung_cmu_info
> g2d_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(g2d_div_clks),
>  	.gate_clks		= g2d_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(g2d_gate_clks),
> -	.nr_clk_ids		= G2D_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_G2D,
>  	.clk_regs		= g2d_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(g2d_clk_regs),
>  	.suspend_regs		= g2d_suspend_regs,
> @@ -2887,7 +2910,7 @@ static const struct samsung_cmu_info
> disp_cmu_info __initconst = {
>  	.nr_fixed_clks		= ARRAY_SIZE(disp_fixed_clks),
>  	.fixed_factor_clks	= disp_fixed_factor_clks,
>  	.nr_fixed_factor_clks	= ARRAY_SIZE(disp_fixed_factor_clks),
> -	.nr_clk_ids		= DISP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_DISP,
>  	.clk_regs		= disp_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(disp_clk_regs),
>  	.suspend_regs		= disp_suspend_regs,
> @@ -3057,7 +3080,7 @@ static const struct samsung_cmu_info
> aud_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
>  	.fixed_clks		= aud_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
> -	.nr_clk_ids		= AUD_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_AUD,
>  	.clk_regs		= aud_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
>  	.suspend_regs		= aud_suspend_regs,
> @@ -3189,7 +3212,7 @@ static const struct samsung_gate_clock
> bus2_gate_clks[] __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(bus##id##_div_clks),	\
>  	.gate_clks		= bus##id##_gate_clks,
> 	\
>  	.nr_gate_clks		= ARRAY_SIZE(bus##id##_gate_clks),	\
> -	.nr_clk_ids		= BUSx_NR_CLK
> +	.nr_clk_ids		= CLKS_NR_BUSX
> 
>  static const struct samsung_cmu_info bus0_cmu_info __initconst = {
>  	CMU_BUS_INFO_CLKS(0),
> @@ -3340,7 +3363,7 @@ static const struct samsung_cmu_info
> g3d_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
>  	.gate_clks		= g3d_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
> -	.nr_clk_ids		= G3D_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_G3D,
>  	.clk_regs		= g3d_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
>  	.suspend_regs		= g3d_suspend_regs,
> @@ -3483,7 +3506,7 @@ static const struct samsung_cmu_info
> gscl_cmu_info __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(gscl_mux_clks),
>  	.gate_clks		= gscl_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(gscl_gate_clks),
> -	.nr_clk_ids		= GSCL_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_GSCL,
>  	.clk_regs		= gscl_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(gscl_clk_regs),
>  	.suspend_regs		= gscl_suspend_regs,
> @@ -3693,7 +3716,7 @@ static const struct samsung_cmu_info
> apollo_cmu_info __initconst = {
>  	.nr_gate_clks	= ARRAY_SIZE(apollo_gate_clks),
>  	.cpu_clks	= apollo_cpu_clks,
>  	.nr_cpu_clks	= ARRAY_SIZE(apollo_cpu_clks),
> -	.nr_clk_ids	= APOLLO_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_APOLLO,
>  	.clk_regs	= apollo_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(apollo_clk_regs),
>  };
> @@ -3938,7 +3961,7 @@ static const struct samsung_cmu_info
> atlas_cmu_info __initconst = {
>  	.nr_gate_clks	= ARRAY_SIZE(atlas_gate_clks),
>  	.cpu_clks	= atlas_cpu_clks,
>  	.nr_cpu_clks	= ARRAY_SIZE(atlas_cpu_clks),
> -	.nr_clk_ids	= ATLAS_NR_CLK,
> +	.nr_clk_ids	= CLKS_NR_ATLAS,
>  	.clk_regs	= atlas_clk_regs,
>  	.nr_clk_regs	= ARRAY_SIZE(atlas_clk_regs),
>  };
> @@ -4112,7 +4135,7 @@ static const struct samsung_cmu_info
> mscl_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(mscl_div_clks),
>  	.gate_clks		= mscl_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(mscl_gate_clks),
> -	.nr_clk_ids		= MSCL_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_MSCL,
>  	.clk_regs		= mscl_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mscl_clk_regs),
>  	.suspend_regs		= mscl_suspend_regs,
> @@ -4220,7 +4243,7 @@ static const struct samsung_cmu_info
> mfc_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(mfc_div_clks),
>  	.gate_clks		= mfc_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(mfc_gate_clks),
> -	.nr_clk_ids		= MFC_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_MFC,
>  	.clk_regs		= mfc_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
>  	.suspend_regs		= mfc_suspend_regs,
> @@ -4330,7 +4353,7 @@ static const struct samsung_cmu_info
> hevc_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(hevc_div_clks),
>  	.gate_clks		= hevc_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(hevc_gate_clks),
> -	.nr_clk_ids		= HEVC_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_HEVC,
>  	.clk_regs		= hevc_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(hevc_clk_regs),
>  	.suspend_regs		= hevc_suspend_regs,
> @@ -4583,7 +4606,7 @@ static const struct samsung_cmu_info isp_cmu_info
> __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(isp_div_clks),
>  	.gate_clks		= isp_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(isp_gate_clks),
> -	.nr_clk_ids		= ISP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_ISP,
>  	.clk_regs		= isp_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(isp_clk_regs),
>  	.suspend_regs		= isp_suspend_regs,
> @@ -5065,7 +5088,7 @@ static const struct samsung_cmu_info
> cam0_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(cam0_gate_clks),
>  	.fixed_clks		= cam0_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(cam0_fixed_clks),
> -	.nr_clk_ids		= CAM0_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CAM0,
>  	.clk_regs		= cam0_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cam0_clk_regs),
>  	.suspend_regs		= cam0_suspend_regs,
> @@ -5440,7 +5463,7 @@ static const struct samsung_cmu_info
> cam1_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(cam1_gate_clks),
>  	.fixed_clks		= cam1_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(cam1_fixed_clks),
> -	.nr_clk_ids		= CAM1_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CAM1,
>  	.clk_regs		= cam1_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cam1_clk_regs),
>  	.suspend_regs		= cam1_suspend_regs,
> @@ -5472,7 +5495,7 @@ static const struct samsung_gate_clock
> imem_gate_clks[] __initconst = {  static const struct samsung_cmu_info
> imem_cmu_info __initconst = {
>  	.gate_clks		= imem_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
> -	.nr_clk_ids		= IMEM_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_IMEM,
>  	.clk_regs		= imem_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
>  	.clk_name		= "aclk_imem_200",
> --
> 2.34.1


