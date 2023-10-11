Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E17C59D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbjJKRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjJKRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:02:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF67A9;
        Wed, 11 Oct 2023 10:02:36 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BD866CD2DE;
        Wed, 11 Oct 2023 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697043754; bh=4GlqhnwSoaVCgskZeWkPIYoAERkqBHFpwH+J17IutXI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=BmRG3u7tELmvd8FbF3wZZuozjjSvrXOh12tGqRV80/TQOwA8/gD/QYbVFFVGIhMOF
         5UltiGbG+e4kHtfSrtq7vEFJaKq9qxyPXdDip85gAdCEAmF3tOLsYGh+AElixqxmxd
         FVv0DpVx9p6FaglO88Y4QkguSMYUpsVcfp+cGe4I=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 19:02:26 +0200
Subject: [PATCH 3/3] ARM: dts: qcom: Add support for HTC One Mini 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-htc-memul-v1-3-76e57873190c@z3ntu.xyz>
References: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
In-Reply-To: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8613; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4GlqhnwSoaVCgskZeWkPIYoAERkqBHFpwH+J17IutXI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJtUpThPulKXOlf5jfQvrE9vPxaIBhXhFsXs+w
 JUeJVSuQ0qJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbVKQAKCRBy2EO4nU3X
 VkynD/9lHg8ix40KTMOoP9MIo/u5TwsZwkEM9BqmDtZ/u6YHA3H/+VCZnWC4V6MNljijO0Zn6T+
 L8uieixhVVp6u1ShUXL/Dt1XuCDQjavBFE+bCwFy/tFYiiFeZmuN7wd9ecSHwQG0hthjSQgVMoU
 Gj6sk0KCCQGMkDJ6XU88+MCiG3QsZCR77TCW0GKiHw6MndwuO1W/ZUpFy/llMXaOjJ1vlznOXuw
 Dpcm+9T/qs96dTDEgxt1Mml2BFm1rmL9bw6nEkFdk5Btnx3mMdgiOuBVNr0JgiYylI+ojgT4ks9
 8UkuOHd6WdBjuYje4uGs0ayAUF0L6kpzv+azxMBHUQ0D+FmSO/cAoisP9f3onPMI1jcBWWgB2MP
 YK14/SnOLB9zs71kOq7SVUgEg1vHtrzvMvCPBjiqHXOaNon1jfX16Qg+HqyoZVOy1PjlgB+GX9F
 G8+AC3Z24qwqp+6B6ziqPXMI/cRtGh5ZNuIYlYTB4yc/pSfmfeVu/isYjPZBWDRGTrTPzfeIAEN
 m3u1WAKjwGY9cH8lCPMKz8zBXUfTDaRwkO3o3okrhag60k7eIbkK7Bjd7OuLuR5hYyQ+vJ4QxFD
 6HUrPSfNSrI/cIgI3izIG3oisvvVq8phy11toBQmoZ8pFSJ4x3IsqPsREdY8DToA0i/zapJC/5n
 cXTqxTfM5RWmRoQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this smartphone based on the MSM8926 SoC, codenamed
"memul".

Supported functionality:
* Power & volume buttons
* ADSP
* Magnetometer
* Accelerometer
* Touchscreen
* Vibrator
* Internal storage
* SD card
* Charger
* USB

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/Makefile                   |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts | 337 ++++++++++++++++++++++
 2 files changed, 338 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index a3d293e40820..0cb272f4fa45 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8916-samsung-e7.dtb \
 	qcom-msm8916-samsung-grandmax.dtb \
 	qcom-msm8916-samsung-serranove.dtb \
+	qcom-msm8926-htc-memul.dtb \
 	qcom-msm8926-microsoft-superman-lte.dtb \
 	qcom-msm8926-microsoft-tesla.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
new file mode 100644
index 000000000000..b848f0cce3b4
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Luca Weiss <luca@z3ntu.xyz>
+ */
+
+/dts-v1/;
+
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+/delete-node/ &smem_region;
+
+/ {
+	model = "HTC One Mini 2";
+	compatible = "htc,memul", "qcom,msm8926", "qcom,msm8226";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
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
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reserved-memory {
+		unknown@5b00000 {
+			reg = <0x05b00000 0x200000>;
+			no-map;
+		};
+
+		unknown@7a00000 {
+			reg = <0x07a00000 0x100000>;
+			no-map;
+		};
+
+		mpss_region: mpss@8000000 {
+			reg = <0x08000000 0x4f00000>;
+			no-map;
+		};
+
+		unknown@cf00000 {
+			reg = <0x0cf00000 0x200000>;
+			no-map;
+		};
+
+		mba_region: mba@d100000 {
+			reg = <0x0d100000 0x3a000>;
+			no-map;
+		};
+
+		wcnss_region: wcnss@d200000 {
+			reg = <0x0d200000 0x650000>;
+			no-map;
+		};
+
+		adsp_region: adsp@dc00000 {
+			reg = <0x0dc00000 0x1400000>;
+			no-map;
+		};
+
+		venus_region: venus@f500000 {
+			reg = <0x0f500000 0x500000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		unknown@fc00000 {
+			reg = <0x0fc00000 0xa00000>;
+			no-map;
+		};
+	};
+};
+
+&adsp {
+	status = "okay";
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	magnetometer@d {
+		compatible = "asahi-kasei,ak8963";
+		reg = <0x0d>;
+		interrupts-extended = <&tlmm 66 IRQ_TYPE_EDGE_RISING>;
+		vdd-supply = <&pm8226_l19>;
+		vid-supply = <&pm8226_l28>;
+	};
+
+	accelerometer@18 {
+		compatible = "bosch,bma250e";
+		reg = <0x18>;
+		interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
+		vdd-supply = <&pm8226_l19>;
+		vddio-supply = <&pm8226_l28>;
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	/* TFA9887 @ 34 */
+	/* TFA9887 @ 35 */
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8226_l19>;
+
+		syna,startup-delay-ms = <160>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
+
+&blsp1_i2c6 {
+	status = "okay";
+
+	/* NCP6924 Camera Regulators @ 10 */
+	/* PN544 NFC @ 28 */
+	/* TPS61310 Flash/Torch @ 33 */
+};
+
+&pm8226_vib {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
+		};
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+		};
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
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
+	status = "okay";
+};
+
+&smbb {
+	qcom,fast-charge-safe-current = <1750000>;
+	qcom,fast-charge-current-limit = <1750000>;
+	qcom,fast-charge-safe-voltage = <4360000>;
+	qcom,fast-charge-high-threshold-voltage = <4350000>;
+	qcom,auto-recharge-threshold-voltage = <4300000>;
+	qcom,minimum-input-voltage = <4300000>;
+};
+
+&usb {
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};

-- 
2.42.0

