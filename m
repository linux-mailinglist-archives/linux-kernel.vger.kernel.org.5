Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5B7776BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHJLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:19:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A02683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230810111914epoutp04c3177b07af065238e5ce7af285f173ff~6AZYS-bkm0571705717epoutp04z
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:19:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230810111914epoutp04c3177b07af065238e5ce7af285f173ff~6AZYS-bkm0571705717epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691666354;
        bh=OG9/Nj4WeQTevWGaAGmOdwL95k+g82XtK/IgZ4YMoxc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=bO/BoosEAUF+V7ECP3rUuubjH5FYpeabLh7B7vI2EP6ONfjnqVFrcYcDyvL8xlDcH
         1uanwi8xynOsYdTeELioKMR122cXA2KppbE/6/rXhRLz+84umxqAwaL7/A75oKzeYM
         ju9SkOSyNxc9A/NuEhIln5PbUL+ebFcnTLSOslwk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230810111913epcas5p36840918dacbf4d5e5ecc88e65d8d9064~6AZXzkRgm2629026290epcas5p3X;
        Thu, 10 Aug 2023 11:19:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RM4FD1XwJz4x9Pv; Thu, 10 Aug
        2023 11:19:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.2F.55522.DA7C4D46; Thu, 10 Aug 2023 20:19:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230810111909epcas5p4d0a3fdd2c5d747d38b9f080dbee4b4c6~6AZUCshov1172611726epcas5p4b;
        Thu, 10 Aug 2023 11:19:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810111909epsmtrp2dcd2040a36157c6e89401ca86c211b56~6AZUBx2uK0141901419epsmtrp2N;
        Thu, 10 Aug 2023 11:19:09 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-10-64d4c7adca5f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.AA.30535.DA7C4D46; Thu, 10 Aug 2023 20:19:09 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810111907epsmtip11f625c8d0e78d6cbaf7603a3725ec840~6AZR7_-bF2588925889epsmtip1j;
        Thu, 10 Aug 2023 11:19:07 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 02/11] clk: samsung: exynos4: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:49:05 +0530
Message-ID: <004501d9cb7c$7b6e26e0$724a74a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gEQFQ52AjeNnPeuQZhYMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmuu7a41dSDL4ftLBYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iw1r+wL/kpUvD89
        k6mB8YlIFyMnh4SAicSU5X+Zuhi5OIQEdjNKTO28zQbhfGKUODVjESuE841R4uLiBqAMB1jL
        i5tsIN1CAnsZJZZ8FoSoeQlkX2xnBkmwCehK7FjcBjZJRGAWi8Tvw6sZQRKcAq4Sa5ctALOF
        BeIkTrx+B2azCKhK7Ni9jhXE5hWwlFjw+BIThC0ocXLmExYQm1lAXmL72znMEHcrSPx8ugys
        XkTASeLu6R42iBpxiZdHj7CDLJYQOMIh8XBrBwtEg4vEs72roJqFJV4d38IOYUtJfH63F+oz
        D4lFf6QgwhkSb5evZ4Sw7SUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTrahCCqVSWa312F
        WiotMbG7mxXC9pBoPDGHERJulxklDlyqm8CoMAvJk7OQPDkLyTOzEBYvYGRZxSiZWlCcm55a
        bFpgmJdaDo/t5PzcTYzghKzluYPx7oMPeocYmTgYDzFKcDArifDaBl9KEeJNSaysSi3Kjy8q
        zUktPsRoCgz5icxSosn5wJyQVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFM
        HxMHp1QDk0DQm7xrAq1M69avt9u2NNyAKXiOtlbm9pjFT2/OKfP/tj9JT1xA2P9dlpwc89wC
        KYmZQiX3fKf/nfxEL3RF0b1VtXmPSoy1n4ms2+P309K77nnnjbMHNP88FwmatM5SeIqi2qq5
        EeFvf1hM71cVWjl1Y6lp5FaBBYztqg3Bx3kbLrdKP2vWsFqzu6p461GPfI+PKzXuijx3ytk2
        f/a53me3rTs43gd9cDVzFgzqbpQNfVyYMsfy4eED/XnLNm4ubdzPvef/u7Qv50X39uoH8eX5
        N7T7Fci2qi25eddG9Gt8/eQ/33UqmEx05q+QLVs6YZfpJeesmD3zyv2NBScpVP1eur1o7+um
        ysg5xjWRSizFGYmGWsxFxYkACjPpy1EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7a41dSDDouSVms2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoErY80r+4K/EhXvT89kamB8ItLFyMEhIWAi8eImWxcjF4eQwG5Gib65J9m7GDmB4tIS1zdO
        gLKFJVb+e84OUfScUaKl/wRYgk1AV2LH4jawbhGBJSwS5x5vY4aoOs8o8WzNOWaQKk4BV4m1
        yxYwgtjCAjESc749AYuzCKhK7Ni9jhXE5hWwlFjw+BIThC0ocXLmExaQ85gF9CTaNoK1MgvI
        S2x/O4cZ4iIFiZ9Pl4G1igg4Sdw93cMGUSMu8fLoEfYJjEKzkEyahTBpFpJJs5B0LGBkWcUo
        mVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERx/Wlo7GPes+qB3iJGJg/EQowQHs5IIr23w
        pRQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamPZrVtR3
        MZilcf5NcuAMbHqUm+nEePNJUkRI1J5Hdb9vMc9WkYj4UCEf7RtT431EJ0T/wj6WkmkVX3s8
        2LawfV+0YdLSdXZHp+sevGjBn/Oz9YiDnmt0Q9ABFpNZuS5S7z9ou57gcVslylFXomLIVtty
        ouDq6T9yKZelVp4SNwtTnSx34KhT+WX2O3Jpk5fW6upcY2U8ncC4cvW1rAD9VQcfSsZeEhZq
        qMqZwFjRv+zOjlUcB8Wj/rCz5ijkVOz0F3VmW9Z5l5nL4ktlwL+V2eEF0wRf/z2io9NvHDMj
        9v6zzB+aoW89yt8eqJi7iX3+ZTabQ7lz5lQu3P//+c3yyBkP9hU4NoYarXjyLptfiaU4I9FQ
        i7moOBEAA5skvC4DAAA=
X-CMS-MailID: 20230810111909epcas5p4d0a3fdd2c5d747d38b9f080dbee4b4c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082750epcas5p431c7e1ea425819cbc510324042093971
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082750epcas5p431c7e1ea425819cbc510324042093971@epcas5p4.samsung.com>
        <20230808082738.122804-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
> Subject: [PATCH 02/11] clk: samsung: exynos4: do not define number of
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

>  drivers/clk/samsung/clk-exynos4.c        | 5 ++++-
>  drivers/clk/samsung/clk-exynos4412-isp.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-
> exynos4.c
> index 43207257a9cc..4ec41221e68f 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -135,6 +135,9 @@
>  #define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
>  #define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR					(CLK_DIV_CORE2 + 1)
> +
>  /* the exynos4 soc type */
>  enum exynos4_soc {
>  	EXYNOS4210,
> @@ -1275,7 +1278,7 @@ static void __init exynos4_clk_init(struct
> device_node *np,
>  	if (!reg_base)
>  		panic("%s: failed to map registers\n", __func__);
> 
> -	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
> +	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
>  	hws = ctx->clk_data.hws;
> 
>  	samsung_clk_of_register_fixed_ext(ctx,
> exynos4_fixed_rate_ext_clks, diff --git a/drivers/clk/samsung/clk-
> exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
> index 1470c15e95da..a70c2b06a61a 100644
> --- a/drivers/clk/samsung/clk-exynos4412-isp.c
> +++ b/drivers/clk/samsung/clk-exynos4412-isp.c
> @@ -22,6 +22,9 @@
>  #define E4X12_GATE_ISP0		0x0800
>  #define E4X12_GATE_ISP1		0x0804
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_ISP		(CLK_ISP_DIV_MCUISP1 + 1)
> +
>  /*
>   * Support for CMU save/restore across system suspends
>   */
> @@ -121,7 +124,7 @@ static int __init exynos4x12_isp_clk_probe(struct
> platform_device *pdev)
>  	if (!exynos4x12_save_isp)
>  		return -ENOMEM;
> 
> -	ctx = samsung_clk_init(dev, reg_base, CLK_NR_ISP_CLKS);
> +	ctx = samsung_clk_init(dev, reg_base, CLKS_NR_ISP);
> 
>  	platform_set_drvdata(pdev, ctx);
> 
> --
> 2.34.1


