Return-Path: <linux-kernel+bounces-80573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA18669C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78841F22130
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D031BC39;
	Mon, 26 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEB0Qrhx"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BA1802E;
	Mon, 26 Feb 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927021; cv=none; b=uwu4n7t67H5aR1hL0h8VSwj4BeF99sfyX/Dbwnbp2yVbfVN11wETElVys1g0zodjmyQEgs8EfZG+6O2Tjx5aVIJWZtZx81MICj0i2yvfN6YMWXQA28XdGgii1yhOHv0yoN2ZIa+OBjjKQNXL7dXzYVYHEiCrdrfAHaDDx9zNKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927021; c=relaxed/simple;
	bh=OD61sqYHXm1jSGLlEinUOHdglfSSEaDeo8V8wcqBC9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKJ1WYxg0mkhy2+K4tkSulZ2s3OX4dIjOcpauIYx2uVUHR1GiogEzagbzK5pO6FimSiNIfSVMXjMhbQ9KACTxMsKQ6EEc9QfaBUD70oIN3dyodVXfFQUSJK+Q2b3ULZTiT3XaP25D0Ugtfy84HfhntN1AjKw046twBpKwXOGY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEB0Qrhx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c199237eaeso1189928b6e.0;
        Sun, 25 Feb 2024 21:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708927019; x=1709531819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGFrdHM3G/5t2T8ZvOHKM53CfUGS1QDwXMQcIm3VM/g=;
        b=eEB0QrhxQUd6ewIohVLgnr0y4huQwLzY8rfpN+LcK5CGilWNTIbzvnYaWJkJDLSouO
         JbnV5mnTiHQ4D8yH094uxICm3XeID0Nm7a6j4ZUK0cx814T6/HJUz9RQC+8Xq63N2pMZ
         4UBxOuvVzEBRlsiw8OE9B+TWvUtQaRix/t6BfJgleMZYCf5IBvp1LtmRb6TNRHC2M8+b
         qZ6c1P4f4f5IdO8JuO1DiDt738BY9Ufbw5HZBNKDulw1f4YQC9Vjmqt5oLtU4r/aVXZ6
         eEM4LbcPo2Zti6ga7Bef2KkdQTyXPBCXiP1DNR3iyH8YtkglO1sPDHtfU0PP53lGHCQK
         57fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708927019; x=1709531819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGFrdHM3G/5t2T8ZvOHKM53CfUGS1QDwXMQcIm3VM/g=;
        b=VSurPFcv6CthWIKXg31o9u/cFwGVGIAwsiqKc61Lb4+v5nzba34lGWh4XuIluPlk0j
         91zLFtXdbbd0/cWP4LtPI8+OcsU1JhdlGxqHLzss1LUNVnMUjhPgU+rp91h75Nu2F0hq
         cucTEfrTosKzvKNQ/BSme5AxoGpXPnXutrbEVcVuUn9CEWtqfmAvBDta9s8ikFWJ7FyI
         r1vhr1sNxSRSEgi6jGBj9skFoV5fmOCn/lAdxDPV8xD0XGpewZGFpagU4uhPhuFdZcnb
         mCnvpVTdgKud2k4MKpRdMoARSaGfxCgvsX3WXnxt+fek6Z5DZH/x0mGdQGkkDjeVhBSo
         rrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkgF1phb3lWg14ffJyePSFFNDHOhtB8LNXo9C/yNiTvbJwNNa/xxxgrwg4juhHbUEopeeKjUuu7k9F4GUZ1m65g7bUjgu5WUV9Xy/DNFeS1lBm2N1KXkplW660hleP2EZcqPpNUel8jgrEnby95tOl4YBmldaWsGLJNZZ5KlL5ClE3QG68ASb6SrJ3SUJLED5n5nwqW+W/dyh/vHHKA4oMVQ0A2orQECo=
X-Gm-Message-State: AOJu0YzcW4MPZWK6c7wxACwW9Px8K/7Tbr8CW5zUSQ7TiwZXHlsRcDcx
	Kyl4AqoBsvU7mK2LvM1hkvvnQ4Pw4b0c09xb3Qq07euq+nIc322yU4ZxBTCWJAwd+g==
X-Google-Smtp-Source: AGHT+IFKs2m5kw3I1l7sEjWzLUndTl0FNnzpmNHBRd/Ca5q7cLMIYz82sOQdu4IOtifdGp9N/o2tEQ==
X-Received: by 2002:aca:280e:0:b0:3bf:e478:6f41 with SMTP id 14-20020aca280e000000b003bfe4786f41mr5951840oix.14.1708927019316;
        Sun, 25 Feb 2024 21:56:59 -0800 (PST)
Received: from localhost.localdomain ([115.187.42.119])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b006e4195cccb5sm625865pfr.133.2024.02.25.21.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 21:56:58 -0800 (PST)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: 
Cc: raihan1999ahamed@gmail.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial device tree
Date: Mon, 26 Feb 2024 11:25:56 +0530
Message-ID: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo P2 is a handset using the MSM8953 SoC released in 2016

Add a device tree for with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- WCNSS (WiFi/BT)
- Regulators

Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8953-lenovo-kuntao.dts   | 240 ++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 39889d5f8e12..aebfb1ae728c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-lenovo-kuntao.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
new file mode 100644
index 000000000000..2fd6345bbe15
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024, Raihan Ahamed <raihan1999ahamed@gmail.com>
+ */
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Lenovo P2";
+	compatible = "lenovo,kuntao", "qcom,msm8953";
+	chassis-type = "handset";
+	qcom,msm-id = <0x125 0x00>;
+	qcom,board-id = <0x41 0x82b1 0x41 0x83b0>;
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_key_default>;
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reserved-memory {
+		qseecom_mem: qseecom@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		ramoops@8ee00000 {
+			compatible = "ramoops";
+			reg = <0x0 0x8ee00000 0x0 0x80000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x15000>;
+			record-size = <0x5000>;
+			pmsg-size = <0x2000>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&hsusb_phy {
+	vdd-supply = <&pm8953_l3>;
+	vdda-pll-supply = <&pm8953_l7>;
+	vdda-phy-dpdm-supply = <&pm8953_l13>;
+
+	status = "okay";
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_l1-supply = <&pm8953_s3>;
+		vdd_l2_l3-supply = <&pm8953_s3>;
+		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+		pm8953_s1: s1 {
+			regulator-min-microvolt = <863000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1224000>;
+		};
+
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1896000>;
+			regulator-max-microvolt = <2048000>;
+		};
+
+		pm8953_l1: l1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8953_l2: l2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm8953_l3: l3 {
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+
+		pm8953_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm8953_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8953_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8953_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l11: l11 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3125000>;
+		};
+
+		pm8953_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l17: l17 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8953_l22: l22 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8953_l23: l23 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1225000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8953_l8>;
+	vqmmc-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
+
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <135 4>;
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&wcnss {
+	vddpx-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+
+	vddxo-supply = <&pm8953_l7>;
+	vddrfa-supply = <&pm8953_l19>;
+	vddpa-supply = <&pm8953_l9>;
+	vdddig-supply = <&pm8953_l5>;
+};
-- 
2.43.2


