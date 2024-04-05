Return-Path: <linux-kernel+bounces-133115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B6899F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A742841FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AE16F823;
	Fri,  5 Apr 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="a9DQzRfs"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1B16D32D;
	Fri,  5 Apr 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326029; cv=none; b=M8ttRK4jQPnPmb9KtB+ew0GMGp+otB6Av0ExesAqjvAqOidNF8OpQ3Nvqf51FofSmK5THeg/zMpNq6c8F8zYTlySu4S7Jm/1yuP2ESdDWGlbMuAlrF7mg0kXpkiyEghWvgXo29TiyR3ZLzIGyAunDDK82AY3ITppgLsTRr7jpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326029; c=relaxed/simple;
	bh=zMX6/kEpKXg2JJqCO+hct8hxdYhd0CZBG7xGH54MWtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEnZrOA5oqqqgE66hmCdVKAFzr+UbQ7phfPc4ANW9NoeiTuc/ltlnyRmjFjX+2lrn/4yqx52Yahf8C8Ef1pXPV7KTywcSey25HG2zTExYlo6ZyfA+XahcPeTS/SG8emmY9CxcHu2RT5pef8jsvPyPiBj3MLr27ySXep5ncLXYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=a9DQzRfs; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id F3BC741B3D;
	Fri,  5 Apr 2024 19:06:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712326009; bh=zMX6/kEpKXg2JJqCO+hct8hxdYhd0CZBG7xGH54MWtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a9DQzRfsY7LMQCmzdye+cfdnte6tsZzMcE8sEOud3nFUYKnxifR5BD/GFMRN/zdrx
	 o9UjKNDjCvo8O6c1vRvESPpirsGrAg4Tn7rVHg3oQJ1eOYq9uQK8Ttst9BkgHedbYI
	 dAduAiCVQ5KAaK/fJS64Cq4TqkrO6w5gUhdZmLSJH5/iBYfnAs8K0mb4u92kbqz0So
	 r79w4idU306K5j02Mozx1mUpN/O3UNAG63AC4D9P6HNaKibkj7mGF79Dr9kGbYZ6f6
	 mCZHO2axrrDaCqw865v790XuprbLVsrTEM9CVu1uMQ3v1bfSGMJGDTz+lhsVhFq85p
	 3NhmI5AKnB2AA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 05 Apr 2024 19:06:13 +0500
Subject: [PATCH 4/4] arm64: dts: qcom: Add Motorola Moto G 2015 (osprey)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-msm8916-moto-init-v1-4-502b58176d34@trvn.ru>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
In-Reply-To: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
 Martijn Braam <martijn@brixit.nl>, Stephan Gerhold <stephan@gerhold.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=1lxV4kmdpqmEPj0zA90yXKpvEuv1NFWQ2boCZ0RO+Q8=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmEAVz9Gow7um2uy0HXK62Xn8smmZtA4BgR1cVp
 CypqEnMpdiJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZhAFcwAKCRBDHOzuKBm/
 dTDyEACoM7nY2EUtgyBqauzrDYAM+62aHtdOoE0hNSE6Bkbf7MRBP8mtvFK07I9PW4PVv6kiuKl
 ZgC+C+hfNKXFIz4yZqN8EeNIZGjI3sox8NEU/bIktF4xmx0iFRIyxOv+gkPhXKcdzMYFDEZnucO
 NUOAJM3olx+eIOpKwJA7cg9nsaS3bNAMqD6nk+/kfrkUTiXfMH953Rx767+Oi8MImYgMExB5Us2
 5XDB8Z9LOs62ZsrjhqoeaigWO6SFxbB4g/l2YBlr2dJFC1onzAuyfQQDq0rnv+/n+j9/2hiAaoZ
 nat4zaMF6hp50MpDQV08HdAuRyML4cvAufn0rzIlx980XdMGqx4fK0ZDt7jRTlGCMDM8SH9zxpS
 rw5Ljfn61mznLWqo9662qr3yNa7zLU4NJkJ/7ZeqC51RgpuoB5VFrsA/JMagUrVse5C9iQYmbx6
 i61H9Bt2ts6+iilyRnIlJv/WPua8L+QGPkrjW9OqgyOvkBjHPXufM8CQ4kpll8yfM/1X+k7Nsas
 R+G2CtE4XRurCgXZZQSIuvhOn/O+0OqRa7zNRccltEeKBVYPnpUM6WWzCyLos1ojsN3rzdLkZGh
 jsktuv0ThFpBA3JFXDi3Utnvv7Wl+wbb5DcI8OStfbK10ENQ49LXaX9t5cyVkjwpF7r2/rvc1zT
 sERVPPdYGGkvQEA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

From: Martijn Braam <martijn@brixit.nl>

Motorola Moto G 2015 is an msm8916 based smartphone.

Supported features:

- eMMC and SD;
- Buttons;
- Touchscreen;
- USB;
- Fuel Gauge;
- Sound.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Nikita: Use common dtsi]
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/msm8916-motorola-osprey.dts      | 105 +++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index acf3ee316fba..ff23afb1b0db 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-harpia.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-osprey.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-surnia.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
new file mode 100644
index 000000000000..ec5589fc69bd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-motorola-common.dtsi"
+
+/ {
+	model = "Motorola Moto G 2015";
+	compatible = "motorola,osprey", "qcom,msm8916";
+	chassis-type = "handset";
+
+	reg_touch_vdda: regulator-touch-vdda {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_vdda";
+		gpio = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-0 = <&touch_vdda_default>;
+		pinctrl-names = "default";
+		startup-delay-us = <300>;
+		vin-supply = <&pm8916_l16>;
+	};
+};
+
+&blsp_i2c1 {
+	status = "okay";
+
+	battery@36 {
+		compatible = "maxim,max17050";
+		reg = <0x36>;
+
+		interrupts-extended = <&tlmm 49 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&battery_alert_default>;
+		pinctrl-names = "default";
+
+		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,cold-temp = <(-200)>;
+		maxim,dead-volt = <3200>;
+		maxim,over-volt = <4500>;
+
+	};
+};
+
+&blsp_i2c6 {
+	/* magnetometer@c */
+};
+
+&pm8916_codec {
+	qcom,micbias1-ext-cap;
+	qcom,micbias2-ext-cap;
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC3", "MIC BIAS External1";
+};
+
+&touchscreen {
+	interrupts-extended = <&tlmm 21 IRQ_TYPE_EDGE_FALLING>;
+
+	vdd-supply = <&reg_touch_vdda>;
+
+	pinctrl-0 = <&ts_int_default>;
+	pinctrl-names = "default";
+};
+
+&tlmm {
+	battery_alert_default: battery-alert-default-state {
+		pins = "gpio49";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	touch_vdda_default: touch-vdda-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.44.0


