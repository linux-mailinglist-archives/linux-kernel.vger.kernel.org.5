Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33369777752
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjHJLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjHJLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:39:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7010D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:39:24 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230810113922epoutp01e18f92be2e8d515d76bf1dc660b28356~6Aq9p5oea0337803378epoutp01c
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230810113922epoutp01e18f92be2e8d515d76bf1dc660b28356~6Aq9p5oea0337803378epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691667562;
        bh=/ifOoLIBspuEnq1OaHTIKEchMOOHi4vhSBG5LLZwPP4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ZMCEupE5GIh6bX94AjR7Mk3jXtvPVsYtvcuhU3ya28zliG6rfjxKKlNm7nrISsF76
         pcX9RvMMaqPVd1oNICD3oJhalCP7KwVqGS7Ip0Z+KAtPZtaNkRa5dVFbBSfwGr1p72
         cAPeMBT0n2BOBaTIRFgaKLLwNTDdpjmni57B0hTQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230810113922epcas5p21f64ad584befe593b5acbef2c72bbd03~6Aq9PNl050438104381epcas5p2p;
        Thu, 10 Aug 2023 11:39:22 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RM4hS2wrBz4x9Pp; Thu, 10 Aug
        2023 11:39:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.1C.57354.86CC4D46; Thu, 10 Aug 2023 20:39:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230810113919epcas5p45e026740ac47d1f42ddd2886b76fc13f~6Aq7IvPON1362013620epcas5p4d;
        Thu, 10 Aug 2023 11:39:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810113919epsmtrp1d67a931b847e3b15bf5219d9d402dfae~6Aq7H2pwd1618316183epsmtrp1k;
        Thu, 10 Aug 2023 11:39:19 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-1c-64d4cc68329d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.8E.64355.76CC4D46; Thu, 10 Aug 2023 20:39:19 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810113917epsmtip1bdfab514b907008ff2341a301554a7ab~6Aq5PMSm80668306683epsmtip1j;
        Thu, 10 Aug 2023 11:39:17 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-12-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 11/11] dt-bindings: clock: samsung: remove define with
 number of clocks
Date:   Thu, 10 Aug 2023 17:09:16 +0530
Message-ID: <004e01d9cb7f$4cbf2260$e63d6720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gKSE5zkAZulyOeuOm1UwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmlm7GmSspBhuP8Vis2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbU5qcsBZcmMVZM
        PPSGrYHxSlEXIyeHhICJxPp1N1m6GLk4hAR2M0r8PvcZyvnEKHG7ZxcbnDPv7Ap2mJYJn+6x
        QiR2Mkr031jNDOG8ZJSYuLOJEaSKTUBXYsfiNrB2EYFZLBK/D68GS3AKuElsWfoLaBQHh7BA
        rMTWd8ogYRYBVYk1i3Yzg9i8ApYSm7avYYSwBSVOznzCAmIzC8hLbH87hxniCgWJn0+XsYLY
        IgJOEj33dzJC1IhLvDx6hB1kr4TAEQ6JnoMTmSAaXCQmrW9ghLCFJV4d3wL1jpTEy/42sHsk
        BDwkFv2RgghnSLxdvh6q3F7iwJU5LCAlzAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1V
        FghbWmJidzcrhO0hMa99DhMkqK4wSix8tYNtAqPCLCRfzkLy5Swk38xC2LyAkWUVo2RqQXFu
        emqyaYFhXmo5PMaT83M3MYITs5bLDsYb8//pHWJk4mA8xCjBwawkwmsbfClFiDclsbIqtSg/
        vqg0J7X4EKMpMOgnMkuJJucDc0NeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWp
        RTB9TBycUg1M24NMW/viJYwempi5XGlv42ja9+LGDxGNEG17h5QJYs6bGVf+mnU6eELuE1/5
        YrsonnIL5RBV3TJDucdSsx9UPX8ozJio5uW/eMbuz3WPN23KWpW769amwprg0hL+IxZLltg9
        /9h4/1GJefS/qu19E5I6On4Fxa5PceI6/E9HfcKPmqCtjBpB7kJBGx8Y3Zfa9tEs++oOtm2S
        TL2O/7beqRX5ydvsLy6cabHWYOrjncu6Qz5zXpLiUH63wPfjwYJln3ld6hoMZdZPFzqs+3Dd
        R5N9hv5VjFHGE6cfeT5xrt6ciin/ohd9zFo6r+DGfO57N6dFs24LPd+ZvVbUx1Ti0eGz+QdC
        PIJbrhi9quZTYinOSDTUYi4qTgQAIxVtAVUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG76mSspBgf3q1qs2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoErY2rzU5aCS5MYKyYeesPWwHilqIuRk0NCwERiwqd7rF2MXBxCAtsZJU6cPMYOkZCWuL5x
        ApQtLLHy33N2iKLnjBK/Gj+zgCTYBHQldixuYwNJiAgsYZE493gbM0TVBUaJ+Z+mMINUcQq4
        SWxZ+guonYNDWCBaYv5eT5Awi4CqxJpFu8FKeAUsJTZtX8MIYQtKnJz5hAWknFlAT6JtI1iY
        WUBeYvvbOcwQBylI/Hy6jBXEFhFwkui5vxOqRlzi5dEj7BMYhWYhmTQLYdIsJJNmIelYwMiy
        ilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM49rSCdjAuW/9X7xAjEwfjIUYJDmYlEV7b4Esp
        QrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUyBu7Y/lvQO
        27Bm569D+59/zrV6ae/LM9X94/a92c/1fNK3TPtpvorRnmnWtkYd1fNxoUfLzzG/2+CxJ+nR
        0jN+6xpWF3EslbEqM/3x6rO7+s9ZmQEx7x8tWupsd6zxPuOEydvOvpx1LuBOacJG+zu8q/Lf
        +uxf3BA/36WYcXnCEf3ZXHz/hZUV11yXWfXIsCvsLFtE+aZ2PlO+xznemqePRnxVjj6wTNw7
        tVf/9L4N75UeC5a5L9QVeLjSsPljGD/vJ5+9/BbaC9qbrGwDxMUYphhJdR3r/e/F43ZZn3Od
        1MaN12fNFYk5vz5aRlNEqHd5q51nro7H2RnN9Q96ph6zuKReqW620UFBfPq/t9eUWIozEg21
        mIuKEwHIYHhNLAMAAA==
X-CMS-MailID: 20230810113919epcas5p45e026740ac47d1f42ddd2886b76fc13f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082806epcas5p1abcab8550ceb2722e9ce70015c033bc0
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082806epcas5p1abcab8550ceb2722e9ce70015c033bc0@epcas5p1.samsung.com>
        <20230808082738.122804-12-krzysztof.kozlowski@linaro.org>
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
> Subject: [PATCH 11/11] dt-bindings: clock: samsung: remove define with
> number of clocks
> 
> Number of clocks supported by Linux drivers might vary - sometimes we add
> new clocks, not exposed previously.  Therefore this number of clocks
should
> not be in the bindings, because otherwise we should not change it.  Remove
> it entirely from the bindings, once Linux drivers stopped using them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  include/dt-bindings/clock/exynos3250.h        | 18 --------
>  include/dt-bindings/clock/exynos4.h           |  5 ---
>  include/dt-bindings/clock/exynos5250.h        |  3 --
>  include/dt-bindings/clock/exynos5260-clk.h    | 25 -----------
>  include/dt-bindings/clock/exynos5410.h        |  2 -
>  include/dt-bindings/clock/exynos5420.h        |  3 --
>  include/dt-bindings/clock/exynos5433.h        | 42 -------------------
>  include/dt-bindings/clock/exynos7885.h        |  4 --
>  include/dt-bindings/clock/exynos850.h         | 10 -----
>  .../dt-bindings/clock/samsung,exynosautov9.h  | 18 --------
>  10 files changed, 130 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-
> bindings/clock/exynos3250.h
> index fe8214017b46..cc7268151843 100644
> --- a/include/dt-bindings/clock/exynos3250.h
> +++ b/include/dt-bindings/clock/exynos3250.h
> @@ -256,12 +256,6 @@
>  #define CLK_SCLK_UART2			248
>  #define CLK_SCLK_MMC2			249
> 
> -/*
> - * Total number of clocks of main CMU.
> - * NOTE: Must be equal to last clock ID increased by one.
> - */
> -#define CLK_NR_CLKS			250
> -
>  /*
>   * CMU DMC
>   */
> @@ -283,12 +277,6 @@
>  #define CLK_DIV_DMCP			19
>  #define CLK_DIV_DMCD			20
> 
> -/*
> - * Total number of clocks of main CMU.
> - * NOTE: Must be equal to last clock ID increased by one.
> - */
> -#define NR_CLKS_DMC			21
> -
>  /*
>   * CMU ISP
>   */
> @@ -344,10 +332,4 @@
>  #define CLK_ASYNCAXIM			46
>  #define CLK_SCLK_MPWM_ISP		47
> 
> -/*
> - * Total number of clocks of CMU_ISP.
> - * NOTE: Must be equal to last clock ID increased by one.
> - */
> -#define NR_CLKS_ISP			48
> -
>  #endif /* _DT_BINDINGS_CLOCK_SAMSUNG_EXYNOS3250_CLOCK_H */ diff
> --git a/include/dt-bindings/clock/exynos4.h b/include/dt-
> bindings/clock/exynos4.h
> index acbfbab875ec..4ebff79ed9e2 100644
> --- a/include/dt-bindings/clock/exynos4.h
> +++ b/include/dt-bindings/clock/exynos4.h
> @@ -239,9 +239,6 @@
>  #define CLK_DIV_GDR		460
>  #define CLK_DIV_CORE2		461
> 
> -/* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		462
> -
>  /* Exynos4x12 ISP clocks */
>  #define CLK_ISP_FIMC_ISP		 1
>  #define CLK_ISP_FIMC_DRC		 2
> @@ -275,6 +272,4 @@
>  #define CLK_ISP_DIV_MCUISP0		29
>  #define CLK_ISP_DIV_MCUISP1		30
> 
> -#define CLK_NR_ISP_CLKS			31
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_4_H */ diff --git a/include/dt-
> bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
> index 4680da7357d3..2337c028bbe1 100644
> --- a/include/dt-bindings/clock/exynos5250.h
> +++ b/include/dt-bindings/clock/exynos5250.h
> @@ -177,7 +177,4 @@
>  #define CLK_MOUT_MPLL		1029
>  #define CLK_MOUT_VPLLSRC	1030
> 
> -/* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		1031
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5250_H */ diff --git a/include/dt-
> bindings/clock/exynos5260-clk.h b/include/dt-bindings/clock/exynos5260-
> clk.h
> index 98a58cbd81b2..dfde40ea40f0 100644
> --- a/include/dt-bindings/clock/exynos5260-clk.h
> +++ b/include/dt-bindings/clock/exynos5260-clk.h
> @@ -137,8 +137,6 @@
>  #define PHYCLK_USBHOST20_PHY_CLK48MOHCI			122
>  #define PHYCLK_USBDRD30_UDRD30_PIPE_PCLK		123
>  #define PHYCLK_USBDRD30_UDRD30_PHYCLOCK			124
> -#define TOP_NR_CLK					125
> -
> 
>  /* List Of Clocks For CMU_EGL */
> 
> @@ -153,8 +151,6 @@
>  #define EGL_DOUT_ACLK_EGL				9
>  #define EGL_DOUT_EGL2					10
>  #define EGL_DOUT_EGL1					11
> -#define EGL_NR_CLK					12
> -
> 
>  /* List Of Clocks For CMU_KFC */
> 
> @@ -168,8 +164,6 @@
>  #define KFC_DOUT_KFC_ATCLK				8
>  #define KFC_DOUT_KFC2					9
>  #define KFC_DOUT_KFC1					10
> -#define KFC_NR_CLK					11
> -
> 
>  /* List Of Clocks For CMU_MIF */
> 
> @@ -200,8 +194,6 @@
>  #define MIF_CLK_INTMEM					25
>  #define MIF_SCLK_LPDDR3PHY_WRAP_U1			26
>  #define MIF_SCLK_LPDDR3PHY_WRAP_U0			27
> -#define MIF_NR_CLK					28
> -
> 
>  /* List Of Clocks For CMU_G3D */
> 
> @@ -211,8 +203,6 @@
>  #define G3D_DOUT_ACLK_G3D				4
>  #define G3D_CLK_G3D_HPM					5
>  #define G3D_CLK_G3D					6
> -#define G3D_NR_CLK					7
> -
> 
>  /* List Of Clocks For CMU_AUD */
> 
> @@ -231,8 +221,6 @@
>  #define AUD_SCLK_AUD_UART				13
>  #define AUD_SCLK_PCM					14
>  #define AUD_SCLK_I2S					15
> -#define AUD_NR_CLK					16
> -
> 
>  /* List Of Clocks For CMU_MFC */
> 
> @@ -241,8 +229,6 @@
>  #define MFC_CLK_MFC					3
>  #define MFC_CLK_SMMU2_MFCM1				4
>  #define MFC_CLK_SMMU2_MFCM0				5
> -#define MFC_NR_CLK					6
> -
> 
>  /* List Of Clocks For CMU_GSCL */
> 
> @@ -272,8 +258,6 @@
>  #define GSCL_CLK_SMMU3_MSCL1				24
>  #define GSCL_SCLK_CSIS1_WRAP				25
>  #define GSCL_SCLK_CSIS0_WRAP				26
> -#define GSCL_NR_CLK					27
> -
> 
>  /* List Of Clocks For CMU_FSYS */
> 
> @@ -295,8 +279,6 @@
>  #define FSYS_CLK_SMMU_RTIC				16
>  #define FSYS_PHYCLK_USBDRD30				17
>  #define FSYS_PHYCLK_USBHOST20				18
> -#define FSYS_NR_CLK					19
> -
> 
>  /* List Of Clocks For CMU_PERI */
> 
> @@ -366,8 +348,6 @@
>  #define PERI_SCLK_SPDIF					64
>  #define PERI_SCLK_I2S					65
>  #define PERI_SCLK_PCM1					66
> -#define PERI_NR_CLK					67
> -
> 
>  /* List Of Clocks For CMU_DISP */
> 
> @@ -406,8 +386,6 @@
>  #define DISP_CLK_DP					33
>  #define DISP_SCLK_PIXEL					34
>  #define DISP_MOUT_HDMI_PHY_PIXEL_USER			35
> -#define DISP_NR_CLK					36
> -
> 
>  /* List Of Clocks For CMU_G2D */
> 
> @@ -423,8 +401,6 @@
>  #define G2D_CLK_SMMU_SSS				10
>  #define G2D_CLK_SMMU_MDMA				11
>  #define G2D_CLK_SMMU3_G2D				12
> -#define G2D_NR_CLK					13
> -
> 
>  /* List Of Clocks For CMU_ISP */
> 
> @@ -461,6 +437,5 @@
>  #define ISP_SCLK_SPI0_EXT				31
>  #define ISP_SCLK_SPI1_EXT				32
>  #define ISP_SCLK_UART_EXT				33
> -#define ISP_NR_CLK					34
> 
>  #endif
> diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-
> bindings/clock/exynos5410.h
> index 86c2ad56c5ef..7a1a93f8df6c 100644
> --- a/include/dt-bindings/clock/exynos5410.h
> +++ b/include/dt-bindings/clock/exynos5410.h
> @@ -61,6 +61,4 @@
>  #define CLK_USBD301		367
>  #define CLK_SSS			471
> 
> -#define CLK_NR_CLKS		512
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5410_H */ diff --git a/include/dt-
> bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 9fffc6ceaadd..73e82527a9e9 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -271,7 +271,4 @@
>  #define CLK_DOUT_PCLK_DREX0	798
>  #define CLK_DOUT_PCLK_DREX1	799
> 
> -/* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		800
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */ diff --git a/include/dt-
> bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
> index 25ffa53573a5..d12c1a963fa1 100644
> --- a/include/dt-bindings/clock/exynos5433.h
> +++ b/include/dt-bindings/clock/exynos5433.h
> @@ -188,8 +188,6 @@
>  #define CLK_SCLK_ISP_SPI0_CAM1		252
>  #define CLK_SCLK_HDMI_SPDIF_DISP	253
> 
> -#define TOP_NR_CLK			254
> -
>  /* CMU_CPIF */
>  #define CLK_FOUT_MPHY_PLL		1
> 
> @@ -200,8 +198,6 @@
>  #define CLK_SCLK_MPHY_PLL		11
>  #define CLK_SCLK_UFS_MPHY		11
> 
> -#define CPIF_NR_CLK			12
> -
>  /* CMU_MIF */
>  #define CLK_FOUT_MEM0_PLL		1
>  #define CLK_FOUT_MEM1_PLL		2
> @@ -396,8 +392,6 @@
>  #define CLK_SCLK_BUS_PLL_APOLLO		199
>  #define CLK_SCLK_BUS_PLL_ATLAS		200
> 
> -#define MIF_NR_CLK			201
> -
>  /* CMU_PERIC */
>  #define CLK_PCLK_SPI2			1
>  #define CLK_PCLK_SPI1			2
> @@ -468,8 +462,6 @@
>  #define CLK_DIV_SCLK_SCI		70
>  #define CLK_DIV_SCLK_SC_IN		71
> 
> -#define PERIC_NR_CLK			72
> -
>  /* CMU_PERIS */
>  #define CLK_PCLK_HPM_APBIF		1
>  #define CLK_PCLK_TMU1_APBIF		2
> @@ -513,8 +505,6 @@
>  #define CLK_SCLK_ANTIRBK_CNT		40
>  #define CLK_SCLK_OTP_CON		41
> 
> -#define PERIS_NR_CLK			42
> -
>  /* CMU_FSYS */
>  #define CLK_MOUT_ACLK_FSYS_200_USER	1
>  #define CLK_MOUT_SCLK_MMC2_USER		2
> @@ -621,8 +611,6 @@
>  #define CLK_SCLK_USBDRD30		114
>  #define CLK_PCIE			115
> 
> -#define FSYS_NR_CLK			116
> -
>  /* CMU_G2D */
>  #define CLK_MUX_ACLK_G2D_266_USER	1
>  #define CLK_MUX_ACLK_G2D_400_USER	2
> @@ -653,8 +641,6 @@
>  #define CLK_PCLK_G2D			25
>  #define CLK_PCLK_SMMU_G2D		26
> 
> -#define G2D_NR_CLK			27
> -
>  /* CMU_DISP */
>  #define CLK_FOUT_DISP_PLL				1
> 
> @@ -771,8 +757,6 @@
>  #define CLK_PHYCLK_MIPIDPHY0_BITCLKDIV8_PHY		114
>  #define CLK_PHYCLK_MIPIDPHY0_RXCLKESC0_PHY		115
> 
> -#define DISP_NR_CLK					116
> -
>  /* CMU_AUD */
>  #define CLK_MOUT_AUD_PLL_USER				1
>  #define CLK_MOUT_SCLK_AUD_PCM				2
> @@ -824,8 +808,6 @@
>  #define CLK_SCLK_I2S_BCLK				46
>  #define CLK_SCLK_AUD_I2S				47
> 
> -#define AUD_NR_CLK					48
> -
>  /* CMU_BUS{0|1|2} */
>  #define CLK_DIV_PCLK_BUS_133				1
> 
> @@ -840,8 +822,6 @@
>  #define CLK_ACLK_BUS2BEND_400				9  /* Only
> CMU_BUS2 */
>  #define CLK_ACLK_BUS2RTND_400				10 /* Only
> CMU_BUS2 */
> 
> -#define BUSx_NR_CLK					11
> -
>  /* CMU_G3D */
>  #define CLK_FOUT_G3D_PLL				1
> 
> @@ -865,8 +845,6 @@
>  #define CLK_PCLK_SYSREG_G3D				18
>  #define CLK_SCLK_HPM_G3D				19
> 
> -#define G3D_NR_CLK					20
> -
>  /* CMU_GSCL */
>  #define CLK_MOUT_ACLK_GSCL_111_USER			1
>  #define CLK_MOUT_ACLK_GSCL_333_USER			2
> @@ -898,8 +876,6 @@
>  #define CLK_PCLK_SMMU_GSCL1				27
>  #define CLK_PCLK_SMMU_GSCL2				28
> 
> -#define GSCL_NR_CLK					29
> -
>  /* CMU_APOLLO */
>  #define CLK_FOUT_APOLLO_PLL				1
> 
> @@ -935,8 +911,6 @@
>  #define CLK_SCLK_HPM_APOLLO				29
>  #define CLK_SCLK_APOLLO					30
> 
> -#define APOLLO_NR_CLK					31
> -
>  /* CMU_ATLAS */
>  #define CLK_FOUT_ATLAS_PLL				1
> 
> @@ -981,8 +955,6 @@
>  #define CLK_ATCLK					38
>  #define CLK_SCLK_ATLAS					39
> 
> -#define ATLAS_NR_CLK					40
> -
>  /* CMU_MSCL */
>  #define CLK_MOUT_SCLK_JPEG_USER				1
>  #define CLK_MOUT_ACLK_MSCL_400_USER			2
> @@ -1016,8 +988,6 @@
>  #define CLK_PCLK_SMMU_JPEG				28
>  #define CLK_SCLK_JPEG					29
> 
> -#define MSCL_NR_CLK					30
> -
>  /* CMU_MFC */
>  #define CLK_MOUT_ACLK_MFC_400_USER			1
> 
> @@ -1040,8 +1010,6 @@
>  #define CLK_PCLK_SMMU_MFC_1				17
>  #define CLK_PCLK_SMMU_MFC_0				18
> 
> -#define MFC_NR_CLK					19
> -
>  /* CMU_HEVC */
>  #define CLK_MOUT_ACLK_HEVC_400_USER			1
> 
> @@ -1064,8 +1032,6 @@
>  #define CLK_PCLK_SMMU_HEVC_1				17
>  #define CLK_PCLK_SMMU_HEVC_0				18
> 
> -#define HEVC_NR_CLK					19
> -
>  /* CMU_ISP */
>  #define CLK_MOUT_ACLK_ISP_DIS_400_USER			1
>  #define CLK_MOUT_ACLK_ISP_400_USER			2
> @@ -1147,8 +1113,6 @@
>  #define CLK_SCLK_PIXELASYNCS_ISPC			76
>  #define CLK_SCLK_PIXELASYNCM_ISPC			77
> 
> -#define ISP_NR_CLK					78
> -
>  /* CMU_CAM0 */
>  #define CLK_PHYCLK_RXBYTEECLKHS0_S4_PHY			1
>  #define CLK_PHYCLK_RXBYTEECLKHS0_S2A_PHY		2
> @@ -1285,8 +1249,6 @@
>  #define CLK_SCLK_PIXELASYNCM_LITE_C_INIT		132
>  #define CLK_SCLK_PIXELASYNCS_LITE_C_INIT		133
> 
> -#define CAM0_NR_CLK					134
> -
>  /* CMU_CAM1 */
>  #define CLK_PHYCLK_RXBYTEECLKHS0_S2B			1
> 
> @@ -1404,12 +1366,8 @@
>  #define CLK_ATCLK_ISP					111
>  #define CLK_SCLK_ISP_CA5				112
> 
> -#define CAM1_NR_CLK					113
> -
>  /* CMU_IMEM */
>  #define CLK_ACLK_SLIMSSS		2
>  #define CLK_PCLK_SLIMSSS		35
> 
> -#define IMEM_NR_CLK			36
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS5433_H */ diff --git a/include/dt-
> bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
> index 8256e7430b63..255e3aa94323 100644
> --- a/include/dt-bindings/clock/exynos7885.h
> +++ b/include/dt-bindings/clock/exynos7885.h
> @@ -69,7 +69,6 @@
>  #define CLK_GOUT_FSYS_MMC_EMBD		58
>  #define CLK_GOUT_FSYS_MMC_SDIO		59
>  #define CLK_GOUT_FSYS_USB30DRD		60
> -#define TOP_NR_CLK			61
> 
>  /* CMU_CORE */
>  #define CLK_MOUT_CORE_BUS_USER			1
> @@ -86,7 +85,6 @@
>  #define CLK_GOUT_TREX_P_CORE_CCLK_P_CORE	12
>  #define CLK_GOUT_TREX_P_CORE_PCLK		13
>  #define CLK_GOUT_TREX_P_CORE_PCLK_P_CORE	14
> -#define CORE_NR_CLK				15
> 
>  /* CMU_PERI */
>  #define CLK_MOUT_PERI_BUS_USER		1
> @@ -132,7 +130,6 @@
>  #define CLK_GOUT_SYSREG_PERI_PCLK	41
>  #define CLK_GOUT_WDT0_PCLK		42
>  #define CLK_GOUT_WDT1_PCLK		43
> -#define PERI_NR_CLK			44
> 
>  /* CMU_FSYS */
>  #define CLK_MOUT_FSYS_BUS_USER		1
> @@ -146,6 +143,5 @@
>  #define CLK_GOUT_MMC_EMBD_SDCLKIN	8
>  #define CLK_GOUT_MMC_SDIO_ACLK		9
>  #define CLK_GOUT_MMC_SDIO_SDCLKIN	10
> -#define FSYS_NR_CLK			11
> 
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */ diff --git a/include/dt-
> bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index afacba338c91..3090e09c9a55 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -88,7 +88,6 @@
>  #define CLK_MOUT_G3D_SWITCH		76
>  #define CLK_GOUT_G3D_SWITCH		77
>  #define CLK_DOUT_G3D_SWITCH		78
> -#define TOP_NR_CLK			79
> 
>  /* CMU_APM */
>  #define CLK_RCO_I3C_PMIC		1
> @@ -115,7 +114,6 @@
>  #define CLK_GOUT_GPIO_ALIVE_PCLK	22
>  #define CLK_GOUT_PMU_ALIVE_PCLK		23
>  #define CLK_GOUT_SYSREG_APM_PCLK	24
> -#define APM_NR_CLK			25
> 
>  /* CMU_AUD */
>  #define CLK_DOUT_AUD_AUDIF		1
> @@ -179,7 +177,6 @@
>  #define IOCLK_AUDIOCDCLK6		59
>  #define TICK_USB			60
>  #define CLK_GOUT_AUD_CMU_AUD_PCLK	61
> -#define AUD_NR_CLK			62
> 
>  /* CMU_CMGP */
>  #define CLK_RCO_CMGP			1
> @@ -197,7 +194,6 @@
>  #define CLK_GOUT_CMGP_USI1_IPCLK	13
>  #define CLK_GOUT_CMGP_USI1_PCLK		14
>  #define CLK_GOUT_SYSREG_CMGP_PCLK	15
> -#define CMGP_NR_CLK			16
> 
>  /* CMU_G3D */
>  #define CLK_FOUT_G3D_PLL		1
> @@ -212,7 +208,6 @@
>  #define CLK_GOUT_G3D_BUSD_CLK		10
>  #define CLK_GOUT_G3D_BUSP_CLK		11
>  #define CLK_GOUT_G3D_SYSREG_PCLK	12
> -#define G3D_NR_CLK			13
> 
>  /* CMU_HSI */
>  #define CLK_MOUT_HSI_BUS_USER		1
> @@ -231,7 +226,6 @@
>  #define CLK_GOUT_HSI_PPMU_ACLK		14
>  #define CLK_GOUT_HSI_PPMU_PCLK		15
>  #define CLK_GOUT_HSI_CMU_HSI_PCLK	16
> -#define HSI_NR_CLK			17
> 
>  /* CMU_IS */
>  #define CLK_MOUT_IS_BUS_USER		1
> @@ -257,7 +251,6 @@
>  #define CLK_GOUT_IS_SYSMMU_IS0_CLK	21
>  #define CLK_GOUT_IS_SYSMMU_IS1_CLK	22
>  #define CLK_GOUT_IS_SYSREG_PCLK		23
> -#define IS_NR_CLK			24
> 
>  /* CMU_MFCMSCL */
>  #define CLK_MOUT_MFCMSCL_MFC_USER		1
> @@ -275,7 +268,6 @@
>  #define CLK_GOUT_MFCMSCL_PPMU_PCLK		13
>  #define CLK_GOUT_MFCMSCL_SYSMMU_CLK		14
>  #define CLK_GOUT_MFCMSCL_SYSREG_PCLK		15
> -#define MFCMSCL_NR_CLK				16
> 
>  /* CMU_PERI */
>  #define CLK_MOUT_PERI_BUS_USER		1
> @@ -312,7 +304,6 @@
>  #define CLK_GOUT_UART_PCLK		32
>  #define CLK_GOUT_WDT0_PCLK		33
>  #define CLK_GOUT_WDT1_PCLK		34
> -#define PERI_NR_CLK			35
> 
>  /* CMU_CORE */
>  #define CLK_MOUT_CORE_BUS_USER		1
> @@ -329,7 +320,6 @@
>  #define CLK_GOUT_SSS_PCLK		12
>  #define CLK_GOUT_GPIO_CORE_PCLK		13
>  #define CLK_GOUT_SYSREG_CORE_PCLK	14
> -#define CORE_NR_CLK			15
> 
>  /* CMU_DPU */
>  #define CLK_MOUT_DPU_USER		1
> diff --git a/include/dt-bindings/clock/samsung,exynosautov9.h
b/include/dt-
> bindings/clock/samsung,exynosautov9.h
> index 42133af6d6b9..3065375c2d8b 100644
> --- a/include/dt-bindings/clock/samsung,exynosautov9.h
> +++ b/include/dt-bindings/clock/samsung,exynosautov9.h
> @@ -166,16 +166,12 @@
>  #define GOUT_CLKCMU_PERIC1_IP		248
>  #define GOUT_CLKCMU_PERIS_BUS		249
> 
> -#define TOP_NR_CLK			250
> -
>  /* CMU_BUSMC */
>  #define CLK_MOUT_BUSMC_BUS_USER		1
>  #define CLK_DOUT_BUSMC_BUSP		2
>  #define CLK_GOUT_BUSMC_PDMA0_PCLK	3
>  #define CLK_GOUT_BUSMC_SPDMA_PCLK	4
> 
> -#define BUSMC_NR_CLK			5
> -
>  /* CMU_CORE */
>  #define CLK_MOUT_CORE_BUS_USER		1
>  #define CLK_DOUT_CORE_BUSP		2
> @@ -183,8 +179,6 @@
>  #define CLK_GOUT_CORE_CCI_PCLK		4
>  #define CLK_GOUT_CORE_CMU_CORE_PCLK	5
> 
> -#define CORE_NR_CLK			6
> -
>  /* CMU_FSYS0 */
>  #define CLK_MOUT_FSYS0_BUS_USER		1
>  #define CLK_MOUT_FSYS0_PCIE_USER	2
> @@ -226,8 +220,6 @@
>  #define CLK_GOUT_FSYS0_PCIE_GEN3A_4L_CLK		35
>  #define CLK_GOUT_FSYS0_PCIE_GEN3B_4L_CLK		36
> 
> -#define FSYS0_NR_CLK			37
> -
>  /* CMU_FSYS1 */
>  #define FOUT_MMC_PLL				1
> 
> @@ -251,8 +243,6 @@
>  #define CLK_GOUT_FSYS1_USB30_0_ACLK		17
>  #define CLK_GOUT_FSYS1_USB30_1_ACLK		18
> 
> -#define FSYS1_NR_CLK				19
> -
>  /* CMU_FSYS2 */
>  #define CLK_MOUT_FSYS2_BUS_USER		1
>  #define CLK_MOUT_FSYS2_UFS_EMBD_USER	2
> @@ -262,8 +252,6 @@
>  #define CLK_GOUT_FSYS2_UFS_EMBD1_ACLK	6
>  #define CLK_GOUT_FSYS2_UFS_EMBD1_UNIPRO	7
> 
> -#define FSYS2_NR_CLK			8
> -
>  /* CMU_PERIC0 */
>  #define CLK_MOUT_PERIC0_BUS_USER	1
>  #define CLK_MOUT_PERIC0_IP_USER		2
> @@ -308,8 +296,6 @@
>  #define CLK_GOUT_PERIC0_PCLK_10		42
>  #define CLK_GOUT_PERIC0_PCLK_11		43
> 
> -#define PERIC0_NR_CLK			44
> -
>  /* CMU_PERIC1 */
>  #define CLK_MOUT_PERIC1_BUS_USER	1
>  #define CLK_MOUT_PERIC1_IP_USER		2
> @@ -354,14 +340,10 @@
>  #define CLK_GOUT_PERIC1_PCLK_10		42
>  #define CLK_GOUT_PERIC1_PCLK_11		43
> 
> -#define PERIC1_NR_CLK			44
> -
>  /* CMU_PERIS */
>  #define CLK_MOUT_PERIS_BUS_USER		1
>  #define CLK_GOUT_SYSREG_PERIS_PCLK	2
>  #define CLK_GOUT_WDT_CLUSTER0		3
>  #define CLK_GOUT_WDT_CLUSTER1		4
> 
> -#define PERIS_NR_CLK			5
> -
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOSAUTOV9_H */
> --
> 2.34.1


