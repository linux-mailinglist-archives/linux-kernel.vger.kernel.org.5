Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519687E1691
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKEUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKEUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:48:13 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF2EEB;
        Sun,  5 Nov 2023 12:48:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A051A5C00FF;
        Sun,  5 Nov 2023 15:48:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Nov 2023 15:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1699217289; x=1699303689; bh=sgzYHG1hAVyH/B+YWF4v1clWClEXAJUPjY6
        dr/SBeXU=; b=ACdVh4do4kXfQD4oqUd7b/W1+75uTi8IE/wO7kA7G98cIB0S4Wf
        w75/bDIAWAnfG0/cpkfdazeI5TaDIDG3IgCai4OR8i8m6ga8YZ2rfbbtKq65VHab
        0IeYoF61KFMNU5rZ6bvonCZAG4JfvIc3ZZlpULFGxZlxgY6RDle/6BVdT6h1qnUr
        accqq7vL9d+b8wmJvjULqg5mVjYfy2VW4y03HN6NBYeAhn+L5qRjwL1bbsuqIGYV
        yE8VahuQ6CFWU5C2ccvOKjD4w8qJ/wEyjYlqTJNpCtswwjwot6VN9l/8CoN1Wf8X
        UxEPhsRWwD5DcVDjy6KXBMQP4rx1sUTml1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699217289; x=
        1699303689; bh=sgzYHG1hAVyH/B+YWF4v1clWClEXAJUPjY6dr/SBeXU=; b=l
        /zfO728CemDpp+jyXr6gEH/pa+PP60KQaQMkA4v9EXbo/7AU3/MoGvAvm7hshfjo
        184Okx4WTPhG+McPVTtinkkmvCAvOLwv/JsuRCBLSzql/nB+aH//j1XQ6HmPTY3A
        CO2QxMVQcazM4KVdv7i/5kGHL9KqXj208GuMFTuVQ03EdBZH1MonUO489g+QoV35
        Nk1NBSL6AbhuNfaXPJ8V4LdfFz2ZHefwn3OwBAFsP3vJMkF3UaNyA3tADmQBMD8Z
        3ThEQgnOt44QYjbEWHZtQFFCtrRXW5Dt3zZGZbeuFH1kCAnY2cf7vLK6lQ7zB1yx
        ara7BZqgeLFboAJ9ciHXg==
X-ME-Sender: <xms:if9HZdNeJENnLVb9TDKI7quoOUyEd3rkqe47QyuB4TDdB093JhM68g>
    <xme:if9HZf8NKPBHcC_ZpgUEJJH1XGKThcIsatjPAbSBPOlLyHU1p1Wd18yMHcyJ8WSNL
    5q2N0JbISoGcAWvug>
X-ME-Received: <xmr:if9HZcRnFT6WAuiea3LsZvri_ZHrSvY8S9cB8ZcLhRKctNfRISfyDCd0SuarEIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeurhih
    rghnthcuofgrihhrshcuoegsrhihrghnthesmhgrihdrrhhsqeenucggtffrrghtthgvrh
    hnpeejkeelffehjedvgedvffetfefgjeduiedvveejkeekueekfefhleduueevjeektden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrhihrg
    hnthesmhgrihdrrhhs
X-ME-Proxy: <xmx:if9HZZuy6o8AMDmaT0Hi_gPKnAlp4Np1-6v4SNsge5FjLFuo87-rpA>
    <xmx:if9HZVcSjXATcyg35KURIAv9jcnV0teumaRiSQDATla25IcC5Iaojw>
    <xmx:if9HZV2VpYW19TVNEO9kq5hUzqvIHa_-YRxFkO2Ga98gRweGkwbpJw>
    <xmx:if9HZWXoyC1DzECWmA-5E9xc7FZzbEWQ_Br2sbpNUCZUs0GL8APEww>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Nov 2023 15:48:07 -0500 (EST)
From:   Bryant Mairs <bryant@mai.rs>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 3/7] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0 Wi-Fi
Date:   Sun,  5 Nov 2023 21:46:18 +0100
Message-ID: <20231105204759.37107-4-bryant@mai.rs>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105204759.37107-1-bryant@mai.rs>
References: <20231105204759.37107-1-bryant@mai.rs>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this tablet based on the MSM8226 SoC, codenamed
"milletwifi".

Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 543 ++++++++++++++++++
 2 files changed, 544 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index a3d293e40820..8726f44ba5dc 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8026-huawei-sturgeon.dtb \
 	qcom-apq8026-lg-lenok.dtb \
 	qcom-apq8026-samsung-matisse-wifi.dtb \
+	qcom-apq8026-samsung-milletwifi.dtb \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
new file mode 100644
index 000000000000..545992091c6b
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ * Copyright (c) 2023, Bryant Mairs <bryant@mai.rs>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+/delete-node/ &mba_region;
+/delete-node/ &mpss_region;
+/delete-node/ &smem_region;
+/delete-node/ &wcnss_region;
+
+/ {
+	model = "Samsung Galaxy Tab 4 8.0 Wi-Fi";
+	compatible = "samsung,milletwifi", "qcom,apq8026";
+	chassis-type = "tablet";
+
+	aliases {
+		display0 = &framebuffer0;
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <800>;
+			height = <1280>;
+			stride = <(800 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Cover";
+			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-home {
+			label = "Home";
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&backlight_i2c_default_state>;
+		pinctrl-names = "default";
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+			enable-supply = <&reg_backlight_vddio>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+
+			/*
+			 * Change transition duration: 200ms, Change transition strength: heavy,
+			 * PWM hysteresis: 1-bit w/ 8-bit resolution
+			 */
+			rom-a3h {
+				rom-addr = /bits/ 8 <0xa3>;
+				rom-val = /bits/ 8 <0x5e>;
+			};
+
+			/*
+			 * PWM phase configuration: 3-phase/3 drivers (0, 120deg, 240deg, -, -, -),
+			 * PWM frequency: 9616Hz (10-bit)
+			 */
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x34>;
+			};
+
+			/* Enable LED drivers 2 & 3, Boot inductor current limit: 1.5A/2.6A */
+			rom-a7h {
+				rom-addr = /bits/ 8 <0xa7>;
+				rom-val = /bits/ 8 <0xfa>;
+			};
+		};
+	};
+
+	reg_backlight_vddio: regulator-backlight-vddio {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight_vddio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_vddio_default_state>;
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_en1_default_state>;
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_en_default_state>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		mpss_region: mpss@8400000 {
+			reg = <0x08400000 0x1f00000>;
+			no-map;
+		};
+
+		mba_region: mba@a300000 {
+			reg = <0x0a300000 0x100000>;
+			no-map;
+		};
+
+		reserved@cb00000 {
+			reg = <0x0cb00000 0x700000>;
+			no-map;
+		};
+
+		wcnss_region: wcnss@d200000 {
+			reg = <0x0d200000 0x700000>;
+			no-map;
+		};
+
+		adsp_region: adsp@d900000 {
+			reg = <0x0d900000 0x1800000>;
+			no-map;
+		};
+
+		venus@f100000 {
+			reg = <0x0f100000 0x500000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x260000>;
+			no-map;
+		};
+
+		rfsa@fd60000 {
+			reg = <0x0fd60000 0x20000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-0 = <&accel_int_default_state>;
+		pinctrl-names = "default";
+
+		st,drdy-int-pin = <1>;
+
+		vdd-supply = <&pm8226_l19>;
+		vddio-supply = <&pm8226_lvs1>;
+
+		mount-matrix = "0", "1", "0",
+			       "-1", "0", "0",
+			       "0", "0", "1";
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	muic: usb-switch@25 {
+		compatible = "siliconmitus,sm5502-muic";
+		reg = <0x25>;
+
+		interrupts-extended = <&tlmm 67 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&muic_int_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "melfas,mms252", "melfas,mms114";
+		reg = <0x48>;
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <1280>;
+		avdd-supply = <&reg_tsp_3p3v>;
+		vdd-supply = <&reg_tsp_1p8v>;
+
+		pinctrl-0 = <&tsp_int_rst_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+			regulator-always-on;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&sdhc2_default_state>, <&sdc2_cd_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&tlmm {
+	accel_int_default_state: accel-int-default-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_vddio_default_state: backlight-vddio-default-state {
+		pins = "gpio74";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	muic_int_default_state: muic-int-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sdc2_cd_default_state: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en_default_state: tsp-en-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en1_default_state: tsp-en1-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default_state: tsp-int-rst-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	extcon = <&muic>, <&muic>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&muic>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.41.0

