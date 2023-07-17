Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612A5755FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGQJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGQJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:47:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA575E52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:47:27 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230717094723epoutp0422f26712c6151736d08994a948e716cf~ynqVYdqqt0348203482epoutp042
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230717094723epoutp0422f26712c6151736d08994a948e716cf~ynqVYdqqt0348203482epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689587243;
        bh=tSxJqs0xAf2OaWmufD5SkySGQ2OZB+41Bzu1pYFCO/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2hAleo3TbGbUabX+MccPJsx3lqY2mfHYuqn/FX/cO/uPYHytuMGNMtn/4Wnal2oG
         j+0uyG6dtsWgoZyikLPHsvrbcBQXL2PVGf1p0sONrsK2NJNEfTSeagWH8zeM67QEU5
         Sj+QoSUJGnieBMzjUkjuPtjNydjfofRCPCRokLi0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230717094722epcas2p123972546ff441247d70cd070d4f83cb4~ynqU69-Kf2919929199epcas2p1b;
        Mon, 17 Jul 2023 09:47:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R4HLL2rgVz4x9Pp; Mon, 17 Jul
        2023 09:47:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.7C.32606.A2E05B46; Mon, 17 Jul 2023 18:47:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230717094722epcas2p4408dc5ab0aca55e1da1a9eafdd3486f7~ynqUR5Qhz3045530455epcas2p4P;
        Mon, 17 Jul 2023 09:47:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230717094722epsmtrp23a4eea313d2fb2f2275cf8364d6081f8~ynqUQfrfj2542125421epsmtrp2N;
        Mon, 17 Jul 2023 09:47:22 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-b3-64b50e2a01c9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.0D.30535.92E05B46; Mon, 17 Jul 2023 18:47:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717094721epsmtip203feedf3fd86cbea3d035970faf9f247~ynqUDYJTk0585405854epsmtip2o;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v4 2/2] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
Date:   Mon, 17 Jul 2023 18:42:02 +0900
Message-Id: <20230717094202.18296-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717094202.18296-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmma4W39YUg+O/hC0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdsaXrJUvCIu+LInpmMDYwP
        ObsYOTgkBEwk+o4YdTFycQgJ7GCUONXewNjFyAnkfGKU2NvuAGF/Y5T42RwEYoPUb172mhmi
        YS+jxM21z9ggij4ySry7qQ5iswloS3xfv5gVxBYRWMgk8ex+GUgDs8BpRom1t56wgCSEBQIk
        GtbsYAKxWQRUJd4tn8sOYvMK2Er833SMBWKbvMTqDQeYQWxOATuJrTdBhnIBxf+ySxx9c5cZ
        oshF4ufTL4wQtrDEq+Nb2CFsKYnP7/ayQdjZEu3T/7BC2BUSFzfMhoobS8x61s4ICgpmAU2J
        9bv0IaGiLHHkFtgJzAJ8Eh2H/7JDhHklOtqEIBrVJO5PPQc1REZi0pGVTBC2h8Sl5a/YIeEz
        kVHi1cRfjBMY5WYhLFjAyLiKUSy1oDg3PbXYqMAYHl3J+bmbGMGJUMt9B+OMtx/0DjEycTAe
        YpTgYFYS4f2+alOKEG9KYmVValF+fFFpTmrxIUZTYNhNZJYSTc4HpuK8knhDE0sDEzMzQ3Mj
        UwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY6s68fLNIccJxg7YFXeuOpkZNFuKYKxV6
        4s/b3LXdvlk8DuK7ja1/yzTn31m8UaSuzSilbfftZTKSdQ+zNwjy7nCxSWz3tZHPEV3ANtef
        d8ONc9U7HsXeldrwd9EtMfXdv+KvxupKfyo6kyCsvvxi1kUt7hVKJWXhUwxUv12aK7JrfW55
        3E8j6/icTx953tSapdhuPbpU9aXQ4h1HKjP+f4i/9NXlqHDq7JBSiW03TKwfSFwsWrBKvLgn
        xkniVOeZjNmTOC71TixwX7qnwOvU4i2LPq6LW8V4+db+t1Nz2kx+vak6L2W77OyFhzdTN6yp
        XX5q5+wCURaxbn65TKmdse857LWVSurfVXesXKH2RYmlOCPRUIu5qDgRAAhQQzoNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvK4m39YUg53TzS0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MrY0
        vWQpeMRdcWTPTMYGxoecXYycHBICJhKbl71m7mLk4hAS2M0oMXHlf2aIhIzE8md9bBC2sMT9
        liOsEEXvGSVuzdvGDpJgE9CW+L5+MVhCRGAxk8Sb7odgDrPARUaJE3+uAFVxcAgL+Ek0rykE
        aWARUJV4t3wuWDOvgK3E/03HWCA2yEus3nAAbDOngJ3E1psgQzmBttlKLHrdyj6BkW8BI8Mq
        RsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg0NXS2sG4Z9UHvUOMTByMhxglOJiVRHi/
        r9qUIsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVANTbnno
        Bbv+2iUdm18e9nVkLF1myPV4uv++I+LivbVfdYyEmx9+feEb010usTaxaG9ZcEEY4xyFi6Zu
        17Yn6npeu8EkrOrCZu3lqdEmobLh28drc+VXTjVdf7PFtFVgz/asqui737om9UxzW7KjgqXj
        0br49wZ6NanpK7aJJXgKsU89GJnaIMjgriP389l5Ft8ug/MG7CeX/hXisgoWXKLLxWFrtXD9
        2vBJX388dFG5f86dd4ZyVbZFFaP8bJlt776uNU1QuJvxoPHQjDWzla8/c+To07m+/sc97nV5
        G0q2HneLvBkqZOWanHFH72iz2uQ0gYtGl71PXtshbfbdTdthjnvV9RDrPbwM1zqvRCuxFGck
        GmoxFxUnAgBbss8wzAIAAA==
X-CMS-MailID: 20230717094722epcas2p4408dc5ab0aca55e1da1a9eafdd3486f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717094722epcas2p4408dc5ab0aca55e1da1a9eafdd3486f7
References: <20230717094202.18296-1-jaewon02.kim@samsung.com>
        <CGME20230717094722epcas2p4408dc5ab0aca55e1da1a9eafdd3486f7@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm node to support fan on exynosautov9-sadk board.
PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
in SADK board.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index 101f51bf565a..bc1815f6ada2 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -49,6 +49,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_tout3>;
+	status = "okay";
+};
+
 &serial_0 {
 	pinctrl-0 = <&uart0_bus_dual>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index d3c5cdeff47f..3b906f4db907 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1560,6 +1560,16 @@
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <1>;
 		};
+
+		pwm: pwm@103f0000 {
+			compatible = "samsung,exynosautov9-pwm",
+				     "samsung,exynos4210-pwm";
+			reg = <0x103f0000 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&xtcxo>;
+			clock-names = "timers";
+		};
 	};
 };
 
-- 
2.17.1

