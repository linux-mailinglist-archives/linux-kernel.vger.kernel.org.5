Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E565F777725
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjHJLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjHJLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:34:58 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B471268A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:34:58 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230810113456epoutp02d653d0996e1bb361326cf3202c7f942d~6AnF0Gwgx0039900399epoutp02M
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:34:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230810113456epoutp02d653d0996e1bb361326cf3202c7f942d~6AnF0Gwgx0039900399epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691667296;
        bh=YCgIEUllV7DIten5NJvTJem/PLvbE2DpdO5yd9PynAU=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=UEruw8/+vuX54VgatPsF11hjga6DWseRIcT+baHrexiTCf3e9no8DyRBW8tWXYQ5j
         02TlYmnQDWSJivP/ThtxvEkGbjacv+eMxRI6egsGMgfYiQTQNKjW/xjCS+Z0ourVU2
         O6pC4fJEL89EYBI+ut0NtleL3KtHFN6Kgk8MKUc8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810113455epcas5p1b175015db95cc926a851c1d0dc93186a~6AnFXyHiZ0670006700epcas5p1C;
        Thu, 10 Aug 2023 11:34:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RM4bL4V0tz4x9Pr; Thu, 10 Aug
        2023 11:34:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.E7.06099.E5BC4D46; Thu, 10 Aug 2023 20:34:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230810113454epcas5p424802323a20c5231ad2cd16f594f92c4~6AnDq4JB21369113691epcas5p4b;
        Thu, 10 Aug 2023 11:34:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810113454epsmtrp13c0ade2eced953d56d87863815d513a1~6AnDp_u7W1389713897epsmtrp12;
        Thu, 10 Aug 2023 11:34:54 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-08-64d4cb5ea2e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.7E.64355.D5BC4D46; Thu, 10 Aug 2023 20:34:53 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810113452epsmtip10ef8fb35b0d0296fbb7490d15f490292~6AnB2F84q0052600526epsmtip1B;
        Thu, 10 Aug 2023 11:34:51 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-9-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 08/11] clk: samsung: exynos7885: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 17:04:50 +0530
Message-ID: <004b01d9cb7e$ae660660$0b321320$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gI5RjbIAqjFz/uuNMlqcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhm7c6SspBqf3yVqs2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsahtp+sBStkK/7u
        9mlgXC3RxcjJISFgInHx6T72LkYuDiGB3YwSS1+9YoZwPjFKHN2/ghHOOfPlJgtMy8ynO1gh
        EjsZJRa2v2aCcF4ySmz9cpUJpIpNQFdix+I2NpCEiMAsFonfh1cDzeLg4BRwlTh60hmkRlgg
        UWLF1ztgU1kEVCVmXGlhBrF5BSwl/t5ohLIFJU7OfAJWwywgL7H97RxmiCsUJH4+XcYKYosI
        OElcXjePCaJGXOLl0SNgD0kIHOCQ2PD3NhtEg4tEz8WNUC8IS7w6voUdwpaSeNnfxg5ym4SA
        h8SiP1IQ4QyJt8vXM0LY9hIHrsxhASlhFtCUWL9LH2IVn0Tv7ydMEJ28Eh1tQhDVqhLN765C
        LZKWmNjdzQphe0h83jwLGrqXGSUm/7vGNIFRYRaSL2ch+XIWkm9mIWxewMiyilEytaA4Nz21
        2LTAOC+1HB7fyfm5mxjBSVnLewfjowcf9A4xMnEwHmKU4GBWEuG1Db6UIsSbklhZlVqUH19U
        mpNafIjRFBj0E5mlRJPzgXkhryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKY
        PiYOTqkGplP+9QeSpgv/Ozr/sihP54pNabMvxklt7Of4sNFERXoDs7f+cbuOb1U/j5yfNiek
        UyT3vOjt2nXdzlYMqZzKIXNSfp1bVLnkXP9fts23nUv4Q88FbGWc8C9IM+PPf7VQ1jDOB+LZ
        fofVRa99uLk6+cy5uvjLtimnjF6YTXzptLetoPNy+xKNqc15+nKLJv7fKHCGe+uS0vD+mbxi
        73mOzz97VN7neJ1y0z3RtPW3f8VwyFoaVP0r2mP8Jam+67Oubq3vrcZZlRxfX75b/ebEnPt3
        Xyn7XNM1yy0UWjM70E/3iXxVWEVv3eYb2m+PLKnvDTun3BZ9NvhdF0Ph8iku9YUszzxeVrL/
        M6j9cv3JBSWW4oxEQy3mouJEAIjsibBTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnG7s6SspBk9/W1is2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoEr41DbT9aCFbIVf3f7NDCuluhi5OSQEDCRmPl0B2sXIxeHkMB2RonuWYsZIRLSEtc3TmCH
        sIUlVv57zg5R9JxR4uCJKcwgCTYBXYkdi9vYQBIiAktYJM493sYMUXWeUeLC1FdALRwcnAKu
        EkdPOoM0CAvES3T+fg02lUVAVWLGlRawQbwClhJ/bzRC2YISJ2c+YQFpZRbQk2jbCHYQs4C8
        xPa3c5ghDlKQ+Pl0GSuILSLgJHF53TwmiBpxiZdHj7BPYBSahWTSLIRJs5BMmoWkYwEjyypG
        0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4LjTCtrBuGz9X71DjEwcjIcYJTiYlUR4bYMvpQjx
        piRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwme8MXdSt+KmG
        v2fd+vhY3/mb+K7/jVLPZFzNtzza2/yffNmvz/dKHXh5Il/bav/4d+C0xvlHJtqqrskXlB5n
        pajt4J+QHnD0XauyyeYvXtvnvTp0cpII9+uaslvq0VzGOUlXV/L9n1PMZmeTyORTITjz94y3
        vzqcGrc4Fq7fcP28t5DFpGMs3rVny3YeKHMLv2nuPF2uVme7KvsrgWnaV6+/25go/Onw27mb
        5eLXSubPmh/fduzup/6VL7JOrfXSV07laXLcF1B37tnPdu8pc8oLRBQVPxfYqly7KJL7zeSf
        +AK72vl7/7yN1Z8VIWJ98n3KQ4nsg63T3/DOFXJ+HHr64ZWpPO+qjJx0a694KbEUZyQaajEX
        FScCAIEqAIsqAwAA
X-CMS-MailID: 20230810113454epcas5p424802323a20c5231ad2cd16f594f92c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082800epcas5p389baccdbefa935a2d1557750ea2555d8
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082800epcas5p389baccdbefa935a2d1557750ea2555d8@epcas5p3.samsung.com>
        <20230808082738.122804-9-krzysztof.kozlowski@linaro.org>
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
> Subject: [PATCH 08/11] clk: samsung: exynos7885: do not define number of
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

>  drivers/clk/samsung/clk-exynos7885.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos7885.c
b/drivers/clk/samsung/clk-
> exynos7885.c
> index 0c6a84764f7a..f7d7427a558b 100644
> --- a/drivers/clk/samsung/clk-exynos7885.c
> +++ b/drivers/clk/samsung/clk-exynos7885.c
> @@ -16,6 +16,12 @@
>  #include "clk.h"
>  #include "clk-exynos-arm64.h"
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP			(CLK_GOUT_FSYS_USB30DRD
> + 1)
> +#define CLKS_NR_CORE
> 	(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE + 1)
> +#define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
> +#define CLKS_NR_FSYS
> 	(CLK_GOUT_MMC_SDIO_SDCLKIN + 1)
> +
>  /* ---- CMU_TOP
------------------------------------------------------------- */
> 
>  /* Register Offset definitions for CMU_TOP (0x12060000) */ @@ -333,7
> +339,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst
> = {
>  	.nr_div_clks		= ARRAY_SIZE(top_div_clks),
>  	.gate_clks		= top_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
> -	.nr_clk_ids		= TOP_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_TOP,
>  	.clk_regs		= top_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
>  };
> @@ -552,7 +558,7 @@ static const struct samsung_cmu_info peri_cmu_info
> __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(peri_mux_clks),
>  	.gate_clks		= peri_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(peri_gate_clks),
> -	.nr_clk_ids		= PERI_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_PERI,
>  	.clk_regs		= peri_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
>  	.clk_name		= "dout_peri_bus",
> @@ -661,7 +667,7 @@ static const struct samsung_cmu_info core_cmu_info
> __initconst = {
>  	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
>  	.gate_clks		= core_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
> -	.nr_clk_ids		= CORE_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_CORE,
>  	.clk_regs		= core_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
>  	.clk_name		= "dout_core_bus",
> @@ -743,7 +749,7 @@ static const struct samsung_cmu_info fsys_cmu_info
> __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(fsys_mux_clks),
>  	.gate_clks		= fsys_gate_clks,
>  	.nr_gate_clks		= ARRAY_SIZE(fsys_gate_clks),
> -	.nr_clk_ids		= FSYS_NR_CLK,
> +	.nr_clk_ids		= CLKS_NR_FSYS,
>  	.clk_regs		= fsys_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
>  	.clk_name		= "dout_fsys_bus",
> --
> 2.34.1


