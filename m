Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAFA777739
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjHJLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjHJLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:36:27 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264326AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:36:26 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230810113624epoutp02853498558899358e365153f81518a3e6~6AoYMSrEm0044600446epoutp02t
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:36:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230810113624epoutp02853498558899358e365153f81518a3e6~6AoYMSrEm0044600446epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691667384;
        bh=gCHj10K34/iF8LnBzO3D8ywW9arsyi0FB3Ed5BWzQIo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=SfeKBd4IZrMTo5Mm6+IKzuvcpfrJ47pcm9PESN3lSdNYuIQMP0htoXoSqLelVdoxN
         Ub9fcd8C9Vq8t701MLlRDVlqVMcVKDnjhAWTp1p0Lf1giagb3PMRiwAlA9j4fEHJRv
         oxTUHzd1rBhd62ruMB+fKDtQruKeF+SQuZiojJJQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230810113624epcas5p2cb21c525b3b36a3cb796f2e96d37b2ce~6AoXqoTRY0111101111epcas5p2-;
        Thu, 10 Aug 2023 11:36:24 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RM4d30bgjz4x9Pt; Thu, 10 Aug
        2023 11:36:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.A4.55173.6BBC4D46; Thu, 10 Aug 2023 20:36:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230810113622epcas5p454ca291673f6021ddce56a2a2472ecd0~6AoV74NAJ1023610236epcas5p4A;
        Thu, 10 Aug 2023 11:36:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810113622epsmtrp10c48fd2bfc28129f305cd884c87f7952~6AoV7GHTZ1393613936epsmtrp1Z;
        Thu, 10 Aug 2023 11:36:22 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-50-64d4cbb637b3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.7E.64355.6BBC4D46; Thu, 10 Aug 2023 20:36:22 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810113620epsmtip15f7bc8b13a13f8cf65eb42b7082c9efd~6AoT12I242893528935epsmtip1C;
        Thu, 10 Aug 2023 11:36:19 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-10-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 09/11] clk: samsung: exynos850: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 17:06:18 +0530
Message-ID: <004c01d9cb7e$e2f19020$a8d4b060$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gIIIWp/ApyNlhuuNrU/wA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmpu6201dSDDZssbBYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ix/j1qZChrMK7oX
        NzA1MM7V7WLk5JAQMJFY+OAKSxcjF4eQwB5Gidf/Z7NBOJ8YJZZ9WcoO5zzadpgJpuXI3AZm
        iMRORok/r98zQTgvGSXOHbjODlLFJqArsWNxG9gsEYFZLBK/D69mBElwCrhJTFy7nBnEFhZI
        kNh1bD8LiM0ioCrxdM4dNhCbV8BSYtG0DYwQtqDEyZlPwGqYBeQltr+dwwxxhoLEz6fLWEFs
        EQEnidNrL7BD1IhLvDx6BOxuCYEjHBK/N1xkhGhwkTh7dwsrhC0s8er4FnYIW0riZX8bkM0B
        ZHtILPojBRHOkHi7fD1Uq73EgStzWEBKmAU0Jdbv0odYxSfR+/sJE0Qnr0RHmxBEtapE87ur
        LBC2tMTE7m6opR4SC97DwvoKo8T1fTfYJzAqzELy5SwkX85C8s0shM0LGFlWMUqlFhTnpqcm
        mxYY6uallsOjPDk/dxMjODVrBexgXL3hr94hRiYOxkOMEhzMSiK8tsGXUoR4UxIrq1KL8uOL
        SnNSiw8xmgLDfiKzlGhyPjA75JXEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE
        08fEwSnVwKTutHlVxGnP1kcXTp2yfCqdvmbD7Y45/zOX//ks4J0qkTrbnr3XTe6xtZe5cdZR
        v2/RT6Wef7jruuKQ6QW1ddZ1d7+9ODgxpuGiBU/34rONmw+HTV5dvDMs8sMmlZmNXc55/Xsq
        3BzilD8Vf7d8uHStbquI2BYeof+bPgTNF1SWNFrCGrUv8dBmxnnh0mnp+l/Ka4/c6Q+r5bzF
        U/jVeqVwpoCyBM++FM/n7+UVvx/ddFP9ul66zZ/v5w4lGEmluRvJa7/i4H0tPFfx7izOXQxn
        XUWE1vyful+Hv0L/tEjbNIb/ulveide+vLvFNk5x//boMDmfs6c/dbO851DId3n6ijMpdqfe
        B7l9OgvfaSixFGckGmoxFxUnAgCS9e6TVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO6201dSDL5c5bFYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAexSXTUpqTmZZapG+
        XQJXxr9HrUwFDeYV3YsbmBoY5+p2MXJySAiYSByZ28DcxcjFISSwnVHiyvxXTBAJaYnrGyew
        Q9jCEiv/PWeHKHrOKHHiwT8WkASbgK7EjsVtbCAJEYElLBLnHm+DGnWBUWL7wa9sIFWcAm4S
        E9cuZwaxhQXiJFZen8cKYrMIqEo8nXMHrIZXwFJi0bQNjBC2oMTJmU+ANnBwMAvoSbRtBAsz
        C8hLbH87hxniIgWJn0+XgY0REXCSOL32AjtEjbjEy6NH2CcwCs1CMmkWwqRZSCbNQtKxgJFl
        FaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZw7GkF7WBctv6v3iFGJg7GQ4wSHMxKIry2wZdS
        hHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpjUxBteyR0s
        ZH00U+NtxSw106v8EcZ7W8w03uwQT4v0YN2YvfZB8szKz6vvxYVv95r1R4E/ZIHnEXOHk2Gs
        7z68MF8SWfvtyMwNs9dWK1dePOl79ealrVa7xO/dLSltDor+1pIZ9ffCg29VN5RF2qyXWxa8
        5gqZHP14rqSfY5DCxI7iYxx9R7/m1ZQYhsaktO1/+uteSv2MEza8K6XFAsX2yO3c0/jw25Lq
        8k9XPt53SG5d8dxH1Xh3wY9zXhpcvlfzjfj+5GRwZ66c79D4g+1IQf33vx/VZjyTPiRzwEym
        YNO/2cfvPexx22OgzckbskRkukv6k6jSl5dVftwvOm4RdaNnXeP+Hxx3+N5evqelxFKckWio
        xVxUnAgAWJtp3SwDAAA=
X-CMS-MailID: 20230810113622epcas5p454ca291673f6021ddce56a2a2472ecd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082806epcas5p4cd7bacc5cf861c2275dc1272025d3df8
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082806epcas5p4cd7bacc5cf861c2275dc1272025d3df8@epcas5p4.samsung.com>
        <20230808082738.122804-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
> Subject: [PATCH 09/11] clk: samsung: exynos850: do not define number of
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

>  drivers/clk/samsung/clk-exynos850.c | 35 ++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c
b/drivers/clk/samsung/clk-
> exynos850.c
> index c32b2e6451a0..bdc1eef7d6e5 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -16,6 +16,19 @@
>  #include "clk.h"
>  #include "clk-exynos-arm64.h"
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP			(CLK_DOUT_G3D_SWITCH +
> 1)
> +#define CLKS_NR_APM
> 	(CLK_GOUT_SYSREG_APM_PCLK + 1)
> +#define CLKS_NR_AUD
> 	(CLK_GOUT_AUD_CMU_AUD_PCLK + 1)
> +#define CLKS_NR_CMGP
> 	(CLK_GOUT_SYSREG_CMGP_PCLK + 1)
> +#define CLKS_NR_G3D
> 	(CLK_GOUT_G3D_SYSREG_PCLK + 1)
> +#define CLKS_NR_HSI			(CLK_GOUT_HSI_CMU_HSI_PCLK +
> 1)
> +#define CLKS_NR_IS			(CLK_GOUT_IS_SYSREG_PCLK + 1)
> +#define CLKS_NR_MFCMSCL
> 	(CLK_GOUT_MFCMSCL_SYSREG_PCLK + 1)
> +#define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
> +#define CLKS_NR_CORE
> 	(CLK_GOUT_SYSREG_CORE_PCLK + 1)
> +#define CLKS_NR_DPU
> 	(CLK_GOUT_DPU_SYSREG_PCLK + 1)
> +
>  /* ---- CMU_TOP
------------------------------------------------------------- */
> 
>  /* Register Offset definitions for CMU_TOP (0x120e0000) */ @@ -485,7
> +498,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst
> = {
>  	.nr_div_clks		= ARRAY_SIZE(top_div_clks),
>  	.gate_clks		= top_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
> -	.nr_clk_ids		= TOP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_TOP,
>  	.clk_regs		= top_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
>  };
> @@ -625,7 +638,7 @@ static const struct samsung_cmu_info apm_cmu_info
> __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(apm_gate_clks),
>  	.fixed_clks		= apm_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(apm_fixed_clks),
> -	.nr_clk_ids		= APM_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_APM,
>  	.clk_regs		= apm_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
>  	.clk_name		= "dout_clkcmu_apm_bus",
> @@ -908,7 +921,7 @@ static const struct samsung_cmu_info aud_cmu_info
> __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
>  	.fixed_clks		= aud_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
> -	.nr_clk_ids		= AUD_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_AUD,
>  	.clk_regs		= aud_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
>  	.clk_name		= "dout_aud",
> @@ -1011,7 +1024,7 @@ static const struct samsung_cmu_info
> cmgp_cmu_info __initconst = {
>  	.nr_gate_clks		= ARRAY_SIZE(cmgp_gate_clks),
>  	.fixed_clks		= cmgp_fixed_clks,
>  	.nr_fixed_clks		= ARRAY_SIZE(cmgp_fixed_clks),
> -	.nr_clk_ids		= CMGP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CMGP,
>  	.clk_regs		= cmgp_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cmgp_clk_regs),
>  	.clk_name		= "gout_clkcmu_cmgp_bus",
> @@ -1107,7 +1120,7 @@ static const struct samsung_cmu_info
> g3d_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
>  	.gate_clks		= g3d_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
> -	.nr_clk_ids		= G3D_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_G3D,
>  	.clk_regs		= g3d_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
>  	.clk_name		= "dout_g3d_switch",
> @@ -1209,7 +1222,7 @@ static const struct samsung_cmu_info hsi_cmu_info
> __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(hsi_mux_clks),
>  	.gate_clks		= hsi_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(hsi_gate_clks),
> -	.nr_clk_ids		= HSI_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_HSI,
>  	.clk_regs		= hsi_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(hsi_clk_regs),
>  	.clk_name		= "dout_hsi_bus",
> @@ -1341,7 +1354,7 @@ static const struct samsung_cmu_info is_cmu_info
> __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(is_div_clks),
>  	.gate_clks		= is_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(is_gate_clks),
> -	.nr_clk_ids		= IS_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_IS,
>  	.clk_regs		= is_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(is_clk_regs),
>  	.clk_name		= "dout_is_bus",
> @@ -1450,7 +1463,7 @@ static const struct samsung_cmu_info
> mfcmscl_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(mfcmscl_div_clks),
>  	.gate_clks		= mfcmscl_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(mfcmscl_gate_clks),
> -	.nr_clk_ids		= MFCMSCL_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_MFCMSCL,
>  	.clk_regs		= mfcmscl_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mfcmscl_clk_regs),
>  	.clk_name		= "dout_mfcmscl_mfc",
> @@ -1625,7 +1638,7 @@ static const struct samsung_cmu_info
> peri_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(peri_div_clks),
>  	.gate_clks		= peri_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peri_gate_clks),
> -	.nr_clk_ids		= PERI_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERI,
>  	.clk_regs		= peri_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
>  	.clk_name		= "dout_peri_bus",
> @@ -1732,7 +1745,7 @@ static const struct samsung_cmu_info
> core_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
>  	.gate_clks		= core_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
> -	.nr_clk_ids		= CORE_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CORE,
>  	.clk_regs		= core_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
>  	.clk_name		= "dout_core_bus",
> @@ -1806,7 +1819,7 @@ static const struct samsung_cmu_info
> dpu_cmu_info __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(dpu_div_clks),
>  	.gate_clks		= dpu_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(dpu_gate_clks),
> -	.nr_clk_ids		= DPU_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_DPU,
>  	.clk_regs		= dpu_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(dpu_clk_regs),
>  	.clk_name		= "dout_dpu",
> --
> 2.34.1


