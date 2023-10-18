Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB17CDBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbjJRMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjJRMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C155112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a98517f3so4691692e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632243; x=1698237043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWeWILwI2zdMvCBwfFkirad+pmRadXyMO1XC1U7cSPY=;
        b=Zrvkc+A9lSYjYxZjIKGuJPydgEtBJzLatvJVnYpKy070XUHS7uKRmQY4uw1sNBw4XP
         YGfT/RzZmMMejV0r6hG2DxN6+6yYvbtPfqIevtn7GbM0VMDns2764Is98ZIZz3CYlZwf
         V7dXAquALwTILU9luYDWqI0KhdWGEL9hv4EieQNcwpGG47kl6MpCl2Tge5BKhkslngSH
         XGooav6AyxD/AFFBOPTzRzqzErWQwu5uwjD5FTFVdQOuuPhhaX8td5LJoIFP+vIa6tkx
         47/ejzASPxXJpeMnO1lDTyvPz+YUERXEasdpTndHQQcxAoeaKTD2464U2EPpbcvo0JYK
         L3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632243; x=1698237043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWeWILwI2zdMvCBwfFkirad+pmRadXyMO1XC1U7cSPY=;
        b=Co3MzMdhB6t3kIz3NVc6r01Z5IEWob38Y5i5xyTJwXEOh/X6E87VXiiffQQzAon8I/
         g+kaz1pvLHttHiYoHBrx1EfXX392Q5jpJ+pSYJ1KcP4gxRZ+7NLxSSRgOLDpPbm9J523
         7hsSpbbFFxFScC0c17XZ8zL/H0PuxdAbW3ogtQ4hbZJ9xbo8HB3aX681ablV83GYvYiW
         UKEeTuvgPX9Hd2V0SGeAIdDoeF8vz5MzISPg6cVerBqj5nH742ZB2BYHcMnL85RTE6hw
         stLWD+KHSorQu3XQCpBYXmRlwcGZ3ATQGC60pZ+6QIP+fZboXPGX3NpL36h4G1vXGqLO
         8dmw==
X-Gm-Message-State: AOJu0YzIH2YworlFBr3tqS8LZGqyWqt78yUdSI1Aen5q8qGT4G6ejACt
        lQh0rZ+pPl7brPs4KvW//K5K/frir14=
X-Google-Smtp-Source: AGHT+IF2rzfbrHmLvjrD+rBsp9oVlWYy0h7jCUsvRZ8fRkk+Tc3RBllIMN8mrsgO8EAhhL/Pcb6Ggw==
X-Received: by 2002:a05:6512:3ba9:b0:507:9701:2700 with SMTP id g41-20020a0565123ba900b0050797012700mr4496087lfv.20.1697632242984;
        Wed, 18 Oct 2023 05:30:42 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:42 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 4/6] arm64: dts: qcom: starqltechn: enable more features
Date:   Wed, 18 Oct 2023 15:30:31 +0300
Message-Id: <20231018123033.301005-5-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018123033.301005-1-dsankouski@gmail.com>
References: <20231018123033.301005-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- enable usb 2.0
- enable debug uart (uart9)
- enable touchscreen
- enable ipa so that we can bring up mobile data

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---

 .../dts/qcom/sdm845-samsung-starqltechn.dts   | 189 +++++++++++++++++-
 1 file changed, 187 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index e9fa230d11ec..3bc9ae5f6213 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -11,11 +11,17 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 
+/delete-node/ &rmtfs_mem;
+
 / {
 	chassis-type = "handset";
 	model = "Samsung Galaxy S9 SM-G9600";
 	compatible = "samsung,starqltechn", "qcom,sdm845";
 
+	aliases {
+		serial0 = &uart9;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -63,6 +69,96 @@ memory@a1300000 {
 			ftrace-size = <0x40000>;
 			pmsg-size = <0x40000>;
 		};
+
+		/* The rmtfs_mem needs to be guarded due to "XPU limitations"
+		 * it is otherwise possible for an allocation adjacent to the
+		 * rmtfs_mem region to trigger an XPU violation, causing a crash.
+		 */
+		rmtfs_lower_guard: memory@fde00000 {
+			no-map;
+			reg = <0 0xfde00000 0 0x1000>;
+		};
+
+		rmtfs_mem: rmtfs-mem@fde01000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xfde01000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		rmtfs_upper_guard: rmtfs-upper-guard@fe001000 {
+			no-map;
+			reg = <0 0xfe001000 0 0x1000>;
+		};
+
+		/*
+		 * It seems like reserving the old rmtfs_mem region is also needed to prevent
+		 * random crashes which are most likely modem related, more testing needed.
+		 */
+		removed_region: removed-region@88f00000 {
+			no-map;
+			reg = <0 0x88f00000 0 0x1c00000>;
+		};
+	};
+
+	i2c@21 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 127 0x0>;
+		scl-gpios = <&tlmm 128 0x0>;
+		#i2c-gpio,delay-us = <0x2>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c21_sda &i2c21_scl>;
+
+		regulator@60 {
+			compatible = "samsung,s2dos05";
+			reg = <0x60>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&s2dos05_irq>;
+			s2dos05,s2dos05_int = <&tlmm 0x31 0x0>;
+
+			regulators {
+				s2dos05_ldo1: s2dos05-ldo1 {
+					regulator-name = "s2dos05-ldo1";
+					regulator-min-microvolt = <0x16e360>;
+					regulator-max-microvolt = <0x1e8480>;
+					regulator-active-discharge = <0x1>;
+				};
+
+				s2dos05_ldo2: s2dos05-ldo2 {
+					regulator-name = "s2dos05-ldo2";
+					regulator-min-microvolt = <0x1b7740>;
+					regulator-max-microvolt = <0x1b7740>;
+					regulator-active-discharge = <0x1>;
+					regulator-boot-on;
+				};
+
+				s2dos05_ldo3: s2dos05-ldo3 {
+					regulator-name = "s2dos05-ldo3";
+					regulator-min-microvolt = <0x2dc6c0>;
+					regulator-max-microvolt = <0x2dc6c0>;
+					regulator-active-discharge = <0x1>;
+					regulator-boot-on;
+				};
+
+				s2dos05_ldo4: s2dos05-ldo4 {
+					regulator-name = "s2dos05-ldo4";
+					regulator-min-microvolt = <0x2932e0>;
+					regulator-max-microvolt = <0x399a18>;
+					regulator-active-discharge = <0x1>;
+				};
+
+				s2dos05_buck1: s2dos05-buck1 {
+					regulator-name = "s2dos05-buck1";
+					regulator-min-microvolt = <0xcf850>;
+					regulator-max-microvolt = <0x200b20>;
+					regulator-active-discharge = <0x1>;
+				};
+			};
+		};
 	};
 };
 
@@ -130,8 +226,6 @@ vdda_pll_cc_ebi23:
 		vdda_sp_sensor:
 		vdda_ufs1_core:
 		vdda_ufs2_core:
-		vdda_usb1_ss_core:
-		vdda_usb2_ss_core:
 		vreg_l1a_0p875: ldo1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
@@ -152,6 +246,7 @@ vreg_l3a_1p0: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vdda_usb1_ss_core:
 		vdd_wcss_cx:
 		vdd_wcss_mx:
 		vdda_wcss_pll:
@@ -360,6 +455,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&gpi_dma1 {
+	status = "okay";
+};
+
 &uart9 {
 	status = "okay";
 };
@@ -386,13 +485,50 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&i2c11 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <120 0x0>;
+		vdd-supply = <&s2dos05_ldo2>;
+		avdd-supply = <&s2dos05_ldo3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_irq>;
+	};
+};
+
+/* Modem/wifi*/
+&mss_pil {
+	status = "okay";
+	firmware-name = "qcom/sdm845/starqltechn/mba.mbn", "qcom/sdm845/starqltechn/modem.mbn";
+};
+
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/starqltechn/ipa_fws.mbn";
+	status = "okay";
+};
+
 &usb_1 {
 	status = "okay";
+	/*
+	 * disable USB3 clock requirement as the device only supports
+	 * USB2.
+	 */
+	qcom,select-utmi-as-pipe-clk;
 };
 
 &usb_1_dwc3 {
 	/* Until we have Type C hooked up we'll force this as peripheral. */
 	dr_mode = "peripheral";
+
+	maximum-speed = "high-speed";
 };
 
 &usb_1_hsphy {
@@ -444,4 +580,53 @@ sd_card_det_n_state: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	s2dos05_irq: s2dos05_irq {
+		pinmux {
+			pins = "gpio49";
+			drive-strength = <0x2>;
+			bias-disable;
+		};
+	};
+
+	gpio_i2c21_default: gpio-i2c21-default {
+		pinmux {
+			pins = "gpio127", "gpio128";
+			function = "gpio";
+		};
+
+		i2c21_sda: i2c_sda {
+			pins = "gpio127";
+			drive-strength = <0x2>;
+			bias-disable;
+		};
+
+		i2c21_scl: i2c_scl {
+			pins = "gpio128";
+			drive-strength = <0x2>;
+			bias-disable;
+		};
+	};
+
+	touch_irq: touch-irq {
+		pins = "gpio120";
+		function = "gpio";
+		bias-disable;
+		input-enable;
+	};
+};
+
+&qup_uart9_tx {
+	drive-strength = <0x2>;
+	bias-pull-up;
+};
+
+&qup_uart9_rx {
+	drive-strength = <0x2>;
+	bias-pull-up;
+};
+
+&qup_i2c11_default {
+	drive-strength = <2>;
+	bias-disable;
 };
-- 
2.39.2

