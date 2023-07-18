Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB8757280
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjGRDrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRDrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:47:32 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC822132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:47:28 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230718034725epoutp018417850c11cc65bffad35d3d10685435~y2ZVgjd9G0215402154epoutp01K
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230718034725epoutp018417850c11cc65bffad35d3d10685435~y2ZVgjd9G0215402154epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689652045;
        bh=tSxJqs0xAf2OaWmufD5SkySGQ2OZB+41Bzu1pYFCO/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCuDX7kR0/o8m4QSWvWluh/iIWX95+4OaSh+yL4MyFA/ZI1b+ijsdBKL76Wiw2IpW
         L4lFv8CFIxjEmrK6laqQ6UO+d8Ev/JHhoI0M/EfLEz1th8NLV76A9J7kZdQP4NOgIw
         YXUP0ZXpEr2PTXbCL5VA5O93ahyyenTw8dLEaatU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230718034725epcas2p2f1d5bc519b331eba4b8411b25db56864~y2ZU-7INq0276202762epcas2p2s;
        Tue, 18 Jul 2023 03:47:25 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4lJX6kl3z4x9Q0; Tue, 18 Jul
        2023 03:47:24 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.F1.29526.C4B06B46; Tue, 18 Jul 2023 12:47:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a~y2ZTw1Z962503525035epcas2p3N;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718034723epsmtrp14272200f11328471aa854323ef32883b~y2ZTwDb5y2910429104epsmtrp1T;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
X-AuditID: b6c32a4d-853ff70000047356-d0-64b60b4c0c3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.2E.30535.B4B06B46; Tue, 18 Jul 2023 12:47:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epsmtip139f202407c47967a4b07ef91488358e1~y2ZTjdTV32248222482epsmtip1p;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
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
Subject: [PATCH v5 2/2] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
Date:   Tue, 18 Jul 2023 12:42:01 +0900
Message-Id: <20230718034201.136800-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718034201.136800-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqa4P97YUgzkzTS0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdsaXrJUvCIu+LInpmMDYwP
        ObsYOTkkBEwk9s6cxtzFyMUhJLCHUeLIhb1sEM4nRokfKy6yglQJCXxjlLgzURqm4/yB6cwQ
        8b2MEr095hANHxklnl/8xQaSYBPQlvi+fjFYs4jAQiaJZ/fLQIqYBU4zSqy99YQFJCEsECAx
        s70FqIiDg0VAVeL3JmMQk1fATuLU9CCIXfISqzccANvFKWAvMWH3HnaQMRICf9klJl+/yAhR
        5CJx6P12NghbWOLV8S3sELaUxMv+Nig7W6J9+h9WCLtC4uKG2VD1xhKznrUzguxlFtCUWL9L
        H8SUEFCWOHIL7EhmAT6JjsN/2SHCvBIdbUIQjWoS96eegxoiIzHpyEomCNtD4uTVblZIiExi
        lJjw/Sf7BEa5WQgLFjAyrmKUSi0ozk1PTTYqMNTNSy2HR1lyfu4mRnBC1PLdwfh6/V+9Q4xM
        HIyHGCU4mJVEeL+v2pQixJuSWFmVWpQfX1Sak1p8iNEUGHoTmaVEk/OBKTmvJN7QxNLAxMzM
        0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmG7EZOakHU1RM52Z18tZzNDw8re84
        8ayxVqTgofmSQQ6Lf291XCpf9P/c7i2bKiKyCw0blb2djDQWL5a51bbzdmXqxR0LHJ/vcHRz
        eSFQvPtUpW5kBvOJz7lne/jkdkju+L+F6Tm34NQTSzP8+WfNfiTBIn/sxK7H/zoNdZds/Bs3
        8+uzqMvBX9hZVPpE7/d/6HqVZxSaF2X3yM1p950HV/UOqG6f638heK3F5SoXOduG60z3r7e2
        vP4vbfIq8f3b69+2GyusOaZ+Yfdsgw72PU2L5b7YZZu+nSM6mWt9Qmy7nGdYwgsvkz06Z2Z3
        TnOeLM/Kq3p48++smNluKuu+hoe9l6gSFEnMzPAIP1ujxFKckWioxVxUnAgAS1ZPQhEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnK4397YUg2PPjCwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MrY0
        vWQpeMRdcWTPTMYGxoecXYycHBICJhLnD0xn7mLk4hAS2M0o8Xv/HlaIhIzE8md9bBC2sMT9
        liOsEEXvGSUabn8FS7AJaEt8X78YLCEisJhJ4k33QzCHWeAio8SJP1fYQaqEBfwk2q5sAdrB
        wcEioCrxe5MxiMkrYCdxanoQxAJ5idUbDjCD2JwC9hITdu8B6xQCKvm49BvjBEa+BYwMqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxggNXS2sH455VH/QOMTJxMB5ilOBgVhLh/b5q
        U4oQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTBO5C+8F
        TXJKDfjy+8bpQ3l31/efZWvdFnyyRPmbyvTU1za/vqS7VH36sMIo+YSym6+ig65P/Fa1NIMs
        xY93TF5fmststfaC4S/DR+9y03wn7L2WMePa/SXOtTuffPukuupsmKv42RyHJM+TNSxiS7cl
        dG6a2hY2i8voV9iTiqB7z+ddCyvoYVCz+/P9tOrNMuVui4qX55Y2tNRtCX8+LSWkwnRj0JfG
        6M11b1k43j9jnXpBTCk6flLik0+zs911zrPbCdU9l5qy99yhXTZLH/w7PeGy65HHJ7JyuLS2
        hzs11s37n8Ka5HvXwUde6p+buNq8ScbMEdnuzE3V15/8m+V/eXZtfnXQ4caYT7t/3VZiKc5I
        NNRiLipOBAC31DPfywIAAA==
X-CMS-MailID: 20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
        <CGME20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

