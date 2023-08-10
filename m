Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFACD77767B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjHJLG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjHJLGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:06:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399EA2130
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:06:46 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230810110644epoutp026aca46019006f7f2022d7b8d96fc6aa5~6AOd8rvlV0889108891epoutp02K
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:06:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230810110644epoutp026aca46019006f7f2022d7b8d96fc6aa5~6AOd8rvlV0889108891epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691665604;
        bh=EMCu6MWi7kUxd9o5JW0PY4A/eRB21rJt9Fheyji3H4A=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=V+BNj57NmkcNzpeJyTD5Ls5x1vpNaP4D5LBCGd6Ewd5ZE7BhFSJFmY0Sh+t5TN1wX
         MDJ4y2eaKSCPm5NVHzsoutZUFPp+lw0DG4HW3GMykq5zmV+LiwRM7twY7E8JKErtYU
         s05hmDR/zneXl+8rxsZawFVgpSPGNukEjAWPsZEg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810110643epcas5p1c9f0793e80159d7834c82aac1224a47a~6AOdgGQ0A2192221922epcas5p1L;
        Thu, 10 Aug 2023 11:06:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RM3yp45mYz4x9Pw; Thu, 10 Aug
        2023 11:06:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.E9.44250.2C4C4D46; Thu, 10 Aug 2023 20:06:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230810110642epcas5p3dc1eac46a5f972debcec44eb86b10723~6AOcCgXQT3014230142epcas5p3F;
        Thu, 10 Aug 2023 11:06:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810110642epsmtrp2f33bfaa7495c2c0b416310b7ebfe583b~6AOcBrToZ2671026710epsmtrp2W;
        Thu, 10 Aug 2023 11:06:42 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-05-64d4c4c20045
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.AB.14748.1C4C4D46; Thu, 10 Aug 2023 20:06:42 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810110640epsmtip2fc6d9a1c1b142b03a4beffc216353013~6AOaEcS-U2681426814epsmtip2a;
        Thu, 10 Aug 2023 11:06:39 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 01/11] clk: samsung: exynos3250: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:36:38 +0530
Message-ID: <000001d9cb7a$bdf0e4f0$39d2aed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gJRntl7AcIuwwyuOzLdAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmuu6hI1dSDHqnyFus2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsazXSfYC9ZJVuze
        s565gbFftIuRg0NCwETifJNtFyMXh5DAbkaJ2bvvMUI4nxgluhdfZYJwvjFKvJ78mq2LkROs
        4+P6JywQib2MEvOnXYVyXjJKHH3yix2kik1AV2LH4jY2kISIwCwWid+HVzOCJDgFXCXWnJnJ
        BrJcWCBRovslH0iYRUBV4vfNa8wgNq+ApcTS5a0sELagxMmZT8BsZgF5ie1v5zBDXKEg8fPp
        MlYQW0TASeLu7AmsEDXiEi+PHmEH2SshcIJDYtHXU4wQDS4Su15sZYKwhSVeHd/CDmFLSXx+
        t5cNEhgeEov+SEGEMyTeLl8P1WovceDKHBaQEmYBTYn1u/QhVvFJ9P5+wgTRySvR0SYEUa0q
        0fzuKguELS0xsbubFcL2kJjQdggaoJcZJXpufWSfwKgwC8mXs5B8OQvJN7MQNi9gZFnFKJla
        UJybnlpsWmCUl1oOj+/k/NxNjOCkrOW1g/Hhgw96hxiZOBgPMUpwMCuJ8NoGX0oR4k1JrKxK
        LcqPLyrNSS0+xGgKDPqJzFKiyfnAvJBXEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZq
        akFqEUwfEwenVANTWbVh3894nZlcrzcvY3tzZavqxPD15q9727qu/5eQv/Z1dQBXpjp3MVOx
        3+/CY483NzW6/zqXwN32SX7xpGIxczOrWN1DDtcm3OI0/PXX6vH9B89DV76oiNzLfu6f76P+
        5a+VG/ZmcE3cfenPpOm2GueaJX+ksdtWTBT8VDOhNE3SxfHf8saDCrd4+SNElzm5V5YmL9vY
        cmhttOfNzUrff/SlCN+9s0hCKkv5T9t9TpYiv9PKHWEebo4eTn4Z550eFVbvajKzObc6/7yK
        9qGFujnZusLrvnDUlrIcZ5nvP2OrR8DMkIlrtlawdJhM47R9/eW+ErdQ3Ip7ay93vS/advxt
        wtriEz33+yUnTQpXYinOSDTUYi4qTgQAJxdsgVMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvO6hI1dSDK7cZbRYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAexSXTUpqTmZZapG+
        XQJXxrNdJ9gL1klW7N6znrmBsV+0i5GTQ0LAROLj+icsXYxcHEICuxkl1hx4wQiRkJa4vnEC
        O4QtLLHy33N2iKLnjBIvz64AK2IT0JXYsbiNDSQhIrCEReLc423MEFXnGSXmffkPVsUp4Cqx
        5sxMoCoODmGBeImNk2JAwiwCqhK/b15jBrF5BSwlli5vZYGwBSVOzgQ5iYODWUBPom0j2BRm
        AXmJ7W/nMEMcpCDx8+kyVhBbRMBJ4u7sCawQNeISL48eYZ/AKDQLyaRZCJNmIZk0C0nHAkaW
        VYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwRGopbGD8d78f3qHGJk4GA8xSnAwK4nw
        2gZfShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qBacWn
        JjPH1lJH2W6BpyL8N1X2Tpjm3cJul7S9cXL5nexOZ4tXfUnfQrk9Og99PFwu9yZLLfBvqqbS
        hg06/fkRjbpPJnxSFmNcz3btvQ9jcvYyXV+l1Pmy0x4f+/BmS5LjyeKpfllaLY76z1UzhXz4
        /85qMU5lW6V9SvBfGNcMa5e2NVcf92vf61ogWuRf6lb6aMKOdQkLMntSxFdc/2h6awXrHfYC
        j+NNTZqnTPqsghykP3kZbru49l3/BeELYVnnXVymWwnoFmxv4Mv9vNIyd62i2+8zJXWOPL/M
        +3/Ottt9Z09zwD6Pg98TNqkJiflt9M/XtVdq6elSmFx79szqa0drZ3lwLT07NddynbcSS3FG
        oqEWc1FxIgAZZi4MLwMAAA==
X-CMS-MailID: 20230810110642epcas5p3dc1eac46a5f972debcec44eb86b10723
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082748epcas5p28ebacab566626323d38ac977610855f0
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082748epcas5p28ebacab566626323d38ac977610855f0@epcas5p2.samsung.com>
        <20230808082738.122804-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, August 8, 2023 1:57 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sylwester
> Nawrocki <s.nawrocki@samsung.com>; Tomasz Figa
> <tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Alim
> Akhtar <alim.akhtar@samsung.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: [PATCH 01/11] clk: samsung: exynos3250: do not define number of
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

>  drivers/clk/samsung/clk-exynos3250.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos3250.c
b/drivers/clk/samsung/clk-
> exynos3250.c
> index 6cc65ccf867c..a02461667664 100644
> --- a/drivers/clk/samsung/clk-exynos3250.c
> +++ b/drivers/clk/samsung/clk-exynos3250.c
> @@ -100,6 +100,11 @@
>  #define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
>  #define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_MAIN				(CLK_SCLK_MMC2 +
> 1)
> +#define CLKS_NR_DMC				(CLK_DIV_DMCD + 1)
> +#define CLKS_NR_ISP				(CLK_SCLK_MPWM_ISP + 1)
> +
>  static const unsigned long exynos3250_cmu_clk_regs[] __initconst = {
>  	SRC_LEFTBUS,
>  	DIV_LEFTBUS,
> @@ -807,7 +812,7 @@ static const struct samsung_cmu_info cmu_info
> __initconst = {
>  	.nr_fixed_factor_clks	= ARRAY_SIZE(fixed_factor_clks),
>  	.cpu_clks		= exynos3250_cpu_clks,
>  	.nr_cpu_clks		= ARRAY_SIZE(exynos3250_cpu_clks),
> -	.nr_clk_ids		= CLK_NR_CLKS,
> +	.nr_clk_ids		= CLKS_NR_MAIN,
>  	.clk_regs		= exynos3250_cmu_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(exynos3250_cmu_clk_regs),
>  };
> @@ -923,7 +928,7 @@ static const struct samsung_cmu_info dmc_cmu_info
> __initconst = {
>  	.nr_mux_clks		= ARRAY_SIZE(dmc_mux_clks),
>  	.div_clks		= dmc_div_clks,
>  	.nr_div_clks		= ARRAY_SIZE(dmc_div_clks),
> -	.nr_clk_ids		= NR_CLKS_DMC,
> +	.nr_clk_ids		= CLKS_NR_DMC,
>  	.clk_regs		= exynos3250_cmu_dmc_clk_regs,
>  	.nr_clk_regs		=
> ARRAY_SIZE(exynos3250_cmu_dmc_clk_regs),
>  };
> @@ -1067,7 +1072,7 @@ static const struct samsung_cmu_info isp_cmu_info
> __initconst = {
>  	.nr_div_clks	= ARRAY_SIZE(isp_div_clks),
>  	.gate_clks	= isp_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(isp_gate_clks),
> -	.nr_clk_ids	= NR_CLKS_ISP,
> +	.nr_clk_ids	= CLKS_NR_ISP,
>  };
> 
>  static int __init exynos3250_cmu_isp_probe(struct platform_device *pdev)
> --
> 2.34.1


