Return-Path: <linux-kernel+bounces-82272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F15868187
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE128949E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EA1130AFB;
	Mon, 26 Feb 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpSzIKnS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D512FF9E;
	Mon, 26 Feb 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977386; cv=none; b=iT9ZQ32AIPneCXmx96USYx2xQI12JTaFTyZhXuuYFaS2DltAjXGJDQRRxiA/ND1U0lj5Nte4DIzQ/3+PmGncss1tqWthT05wjCxYJEyuW6CerpBn05CDm+kq+H8tEtLP1JDbfGRL9qjXWFQlKj+0ZJ3RdOUxAPI9Q+23PhhJXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977386; c=relaxed/simple;
	bh=/G5Xcjt9DpQIpFujmOFL81Rzk5FMJiFHkDe2rqYgaqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKuEw6KKluSxcwZXAcW/M1wSNXCTJ9A06ArFVwx5SKizGy+oHP49q1HcaAXcT39VriX2rgQc0He8uG/pvJVFhiQUh4r0/nUPxnwMyj/rqNdMKlQLuNRIeRWF8KeojzI3LhGC1Vcp/ARm2PubVtl8MCGUrypaW6RV9j5QQn0nZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpSzIKnS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso1649302b3a.1;
        Mon, 26 Feb 2024 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708977383; x=1709582183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piiO1zG/NEyGjBvF6JpiWMw12Z2gcvqjlJIRmy0vf0A=;
        b=QpSzIKnSACMfGeufXdhTqM11abLALgN2QqkEkXwqazS1Vvks/3h0L+kJpLzERVFWJL
         ceUGQ2OR+uJ6ptGrY7zYsEdV8T49dHhPuLjUDCeusLYiCjJNz/ECLZzfSwRBtggm/NId
         SpHXQ1oIc9se/L+1DS74q0GO+xzmtDfZITxvNAGM51COjXR3xs1Dml23NnoSJNfA9a0W
         A4FhUs4OgmJp0GQhneE2rKPKldzqzrQyz6LLB2LNQptU5XpsF+Gg8W9twCXvU4RG3YuF
         3+MWwqOsoRF8Aor8apL4XBGm4Y1cIQaFHMqtuPbivLvoAH7Eb7LotlUDiIN2fQIrCe0x
         tgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977383; x=1709582183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piiO1zG/NEyGjBvF6JpiWMw12Z2gcvqjlJIRmy0vf0A=;
        b=hr4+gVQx2c8RuPi5EczqPHWI5shJHcFLh7wONdj93g/UE1f0Swo+rfYeoWJ1GPG55I
         WCRYxUiK4/N78uyVN49EGqxixHJTUydWyr4tOYD6KSnB7Lg28cxQ4mxJdJWchLjCvXCY
         SWUaCTWHu5bYWAj7199kW2+pEMOVdfmuyoZ2z5IvadIA38hCgUf2PgmP6C8TzUU8RFTq
         79gdq+8YVzchCUnBF6mL5akr3IG9C3jZcActmpJYpdth6FufGljMrFmGKZ+lLlj3vo+i
         MVex+3zB9Qy71emI84814OUVfi+PAmBtcaEvm/NxCXxazEK5/wLEiYhW813RzlCoVT/I
         hKiw==
X-Forwarded-Encrypted: i=1; AJvYcCWClfmfWTXmKVU0a7V8rk4NKDlVPsNUUiWtOTZx7aYKSipjIeABQxNzjq3M+GzT0/XvGH4qUH1oC640u7E4TIiSJRUES0DWJHsAngu1Jpu4kbN7q2LDGQksvisJ2CA0pmz3+X62LZYUtXrkREpZr0AriC6T9tFmQlpvmuXLqc+AbZnMb2xj62WCAE984GhZMAStAQuKhmdS0nU3VJH2h13nMqSNpd2r7uA=
X-Gm-Message-State: AOJu0YyLD68KS8WHREhlA6RKCpam6JYRMDaVp2dlpLQBZ71fz+C4HhhC
	SDjCZb1z82bqsvggvg+kL/k+VrUB3gpfgXKFjM4vCDRAoO2zDkZ2
X-Google-Smtp-Source: AGHT+IFZOhr9vha+K5NAVVea7wzHRu1H1zzAOxRwLY3aM2LlzonK98Dmo354mPPnG4wkIr7XrO0WtQ==
X-Received: by 2002:a05:6a21:1506:b0:1a0:96cd:39f3 with SMTP id nq6-20020a056a21150600b001a096cd39f3mr213812pzb.0.1708977382781;
        Mon, 26 Feb 2024 11:56:22 -0800 (PST)
Received: from localhost.localdomain ([115.187.42.119])
        by smtp.gmail.com with ESMTPSA id ls25-20020a056a00741900b006e532495091sm1902252pfb.73.2024.02.26.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:56:22 -0800 (PST)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org
Cc: raihan1999ahamed@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial device tree
Date: Tue, 27 Feb 2024 01:24:42 +0530
Message-ID: <20240226195516.174737-2-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226195516.174737-1-raihan1999ahamed@gmail.com>
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
 <20240226195516.174737-1-raihan1999ahamed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo P2 is a handset using the MSM8953 SoC released in 2016

Add a device tree with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- WCNSS (WiFi/BT)
- Regulators

Acked-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.44.0


