Return-Path: <linux-kernel+bounces-81084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CEF866FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A221C25A25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDAA60BA8;
	Mon, 26 Feb 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Y0a47c"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB675605BF;
	Mon, 26 Feb 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940633; cv=none; b=XLX5Hxf5FlZkOJ0uiJ2hbhTZpNCy0mZXOpGnseDDaMWpedBd0trYcj/VFR45oZq1iO4C9KDtTXuPKOmS++KYwZhj/hbXhiccT7XDVlAJIcbnjmtG4sUxIerQTolW+jTGBnofN62+tluIUz8ucFb1U7q8S/7L6CEkRTGksALBGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940633; c=relaxed/simple;
	bh=wx6qcLjfOsQ5f26kn1aBWeymF+akqJQOWHEnKood6b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqLoV7sA490rIr367igm8XMK6zpOYDeyE218l2q+Tb1aMFeC1As+T6/z0+qlkw70eh005/9fUeMG4L40xB1sJF7DK7oqx6t/q8g9Bn7ztCe8PwrMXP1Oo8Hv6xDUUrseg8EXxWYE6T7ubW787trDSM3A6DTyM1reTQfpQey/UpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Y0a47c; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2187542a12.2;
        Mon, 26 Feb 2024 01:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940631; x=1709545431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqpalVXYBbAnAdxE01aG7B7dGxizfJoTVD+z7ZQguYE=;
        b=i0Y0a47cNOdv9fAFLixnRQc3GfBw6ldX6PutEKzpmKmpnMl/ZfG9Dn9lrNWmLUFJEE
         4ig5lGf+6AI8eYBs7hHj+Mod0rjcgTuAKCNkA4dofjK8qTgaV+xI/Ja4MN0oHC7uRAMJ
         JDzuT41wFIY6gxm0HwFZ7iS+CQYPu1onuEyRDMQOpDkN0ldwBHXdNDxFNzjM1771BMlr
         GAe28nsphbRvzp44I6Vmx9flH1gh0wmHG0EoMnW4lQAMknfmjrhIycN/V6GXYfzhGmuw
         iYuIp/rakv002WgnIDo6qa9C1oEUCqxMRqQjNvKianosAgXXwWNEb496mQqxb30YHVAt
         jsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940631; x=1709545431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqpalVXYBbAnAdxE01aG7B7dGxizfJoTVD+z7ZQguYE=;
        b=FQxSZXosW7W+hhrvG5WnAx6gX0LjviYXnGDmAa+YjScRtG5Ta2zxMED8WjQjpukp7u
         GN80Q8Rs9732xpFSxjUqf6OuMLxeJEfsLRjAlbR4XHPwTVNQbH+QeNGIOhMhSFmZWf8L
         osxJyXlchJIwbhWTJZ/3GJP40eHL8Jw5ZPpzmk4KbZCdeTiiA1hkxnWfqrpkaoowagw1
         eD3bYZUtoDX5xVeu9La14sBGEGaWbyAEiRNRxs+7ve+fh8JVpySB369kYrfTzdJ+yiXT
         Owea6SCOwPvKjCnLiDKoq3X8l4Os65gQ9fa9YE/rncL5gmwMwpJfl1vgaj6bOT5KANJp
         nlTA==
X-Forwarded-Encrypted: i=1; AJvYcCV/cKLI5sBsvCTJCHrW6LjuPk2G3AytPwigB/dHF2XJlgvA31UV6zByPRg4WnI61blQKoPBzc6/xXPR+cuBpDps8Ht/7qEtWHpBC4TVRBy2jA1AHAx5Jz3UiiSMBTEbfKuM5fp9KRGqLqGXmR762qKAq1ULb7gFBRmecVgI/0VWrembVj3PXEH1BLbXlm5lMMsBYrZm/BclrbdiuDX61LEBJCPMNR4BqnU=
X-Gm-Message-State: AOJu0YxDZizlzRLlnrivRqASNdfqsQ8XecrhJikgosleLThOheDoibuS
	DVN7vMTEkJXNJWtwkrOcRSXen+IjOg2r7zc3ypso1NF12uoFdFRf
X-Google-Smtp-Source: AGHT+IHaEETYLvx63vUgW4mx8iDIKO+7XQPbUO0Oz3DOmt3gdXfISHID2KvvvcZXG4w3BnJgyAy1Ig==
X-Received: by 2002:a05:6a21:1799:b0:19e:48b6:9c43 with SMTP id nx25-20020a056a21179900b0019e48b69c43mr5148618pzb.58.1708940630983;
        Mon, 26 Feb 2024 01:43:50 -0800 (PST)
Received: from localhost.localdomain ([115.187.42.119])
        by smtp.gmail.com with ESMTPSA id y13-20020a62ce0d000000b006e4f1bdff29sm3799164pfg.1.2024.02.26.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:43:50 -0800 (PST)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: krzysztof.kozlowski+dt@linaro.org
Cc: raihan1999ahamed@gmail.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial device tree
Date: Mon, 26 Feb 2024 15:11:04 +0530
Message-ID: <20240226094256.5736-2-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226094256.5736-1-raihan1999ahamed@gmail.com>
References: <a762f756-1a92-4d82-be38-098bacaf25dc@linaro.org>
 <20240226094256.5736-1-raihan1999ahamed@gmail.com>
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


