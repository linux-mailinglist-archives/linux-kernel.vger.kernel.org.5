Return-Path: <linux-kernel+bounces-133114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E50899F08
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C38428500C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143E16F27A;
	Fri,  5 Apr 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="IvlCUuGe"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9716E894;
	Fri,  5 Apr 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326020; cv=none; b=DKjdZvh12svD6qe8DvYVGM+UwRF/iseD7gwZkt5LYdwnU35oATbnUP2s3lflsI74l4nsn9MSBJBUfxJ6/swaCjccbnMSJImlk3LW/gtyXhViPDJOttqnv5UCIoiNfr5KpEvFT6o0iz967NkUc/TV6Wm54WIUhxV9tsm1STv9xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326020; c=relaxed/simple;
	bh=myeprIocEwJnt1Y+8P46ayf0z1f5oJlFug4gelU9BI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pW0uBXUZHE6Ipm0umMOavCDaLKo9xcW9/XspNYLSmAcxdtg9oRhqNbDIQQ9jaoPr45TYBiV8Xldr/Bbzq7Bzb6lFMVDxT65UJrGwh9kPj95rfi3Pyhoaqsjbz50oKe0xKtyvgZ0LvmaMyzQVuz5PrAnj0PH9Ve/cSdT3vPES2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=IvlCUuGe; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 4EA5041A4D;
	Fri,  5 Apr 2024 19:06:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712326008; bh=myeprIocEwJnt1Y+8P46ayf0z1f5oJlFug4gelU9BI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IvlCUuGeadufUJ/6DeuxtziKSg1G7Tu+etneMxNP9zky33OBTZmlvt0ecFSwVLFPl
	 AIOKUrB56mKXBtmPFrFJmDHVsAcIsg78dpuZKFtB3bf28Y/ZehNjHf7DGh9LfTj5jg
	 6p0/C2oR2/zw9cSUJbNwYXXyr9YEWRCN0JsS2QDQjDx1HWWrCHD+i+lFPy87Bu8bPo
	 LdCiVeLjzvYynehg/ituTJfGs7rVAiGKbdEfyzCCE4Z2JCvlBKbqDeIavNYgXgzgyM
	 xyVmyIuC/urCN4w1lG9yN7CNq7L3IeLnksA80Um2GzeZ7u7/lxvDFt+MGwkyLKt+nH
	 l3vDqaONVvHCA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 05 Apr 2024 19:06:12 +0500
Subject: [PATCH 3/4] arm64: dts: qcom: Add Motorola Moto E 2015 LTE
 (surnia)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-msm8916-moto-init-v1-3-502b58176d34@trvn.ru>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
In-Reply-To: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
 =?utf-8?q?Wiktor_Strz=C4=99ba=C5=82a?= <wiktorek140@gmail.com>, 
 =?utf-8?q?Val=C3=A9rie_Roux?= <undev@unixgirl.xyz>, 
 Stephan Gerhold <stephan@gerhold.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=O5advYnXYUZahl22INbfyk1zYJZUHbTDIKFIs+rPPD0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmEAVzceLAvKWU7a4AXv6PDEP2i/1IEMHfsmVMY
 eqQqt/0Q1iJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZhAFcwAKCRBDHOzuKBm/
 dYimD/4sexl4vL8UfjfkYIb9EpVT8ucsqlYhxhUadY7X75hyH8YH4vweiOa2J3UvtoWql5cEKnG
 7f0qqi+adEJX5Vd/SfrdMe4PwjSssGMuSkwBo6Dx+Hu0sadfARJ//p2gMV+CXibERnS5yQaAuOy
 a0YlhwU7uvBuWw56c57P0M6g02sXc+vV8jeNKmzOwUPbtpgsAIfUppRGuoqKTkkSJD99zGfYGle
 X+QgJbYFL726KnmGI8XO+6tiN6C6oSjHegX+vVDhdHb/i5Wz+01jjhAi2j4k1LlfbO3pixLiNUb
 8FHwfWuI9Vlp63tnK9X5TKpfELoiBdE3FYbVjoaLZvGkQvOH8G10U03odnujYE44ujGSeBqsK1x
 CDkn3JmA6xQvk3/KvzWGo72h+AfWoEnCTZd8n8Kvnbp/+j6AdLIEDsMvtKx32FixZr//csQABJe
 jgXUwVLQqUz6lS170c+FBKmd7IMK2UmEB0/BqjFx04qRgj9/DozUuxc/fHu76EuNhpmFpS5s1Oj
 UAAz2Kp6Uz7cb8DodSYa7Y0y9g5HGq3cEl6HT0tK5x/0qI9CIyEEhQBWiFOed8eLJ7TjwXDR0qt
 gcXsEWajKA6tSo/KFcwzw1PQobkrpyEDfxsRL+QXwxd5pnpHzALgmQ8c0kY1OfVtIGdlSFfFaqx
 f111eMc5WRrIr1A==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

From: Wiktor Strzębała <wiktorek140@gmail.com>

Motorola Moto E 2015 LTE is an msm8916 based smartphone.

Supported features:

- eMMC and SD;
- Buttons;
- Touchscreen;
- USB;
- Fuel Gauge;
- Sound.

Signed-off-by: Wiktor Strzębała <wiktorek140@gmail.com>
[Valérie: Sound and modem]
Co-developed-by: Valérie Roux <undev@unixgirl.xyz>
Signed-off-by: Valérie Roux <undev@unixgirl.xyz>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Nikita: Use common dtsi]
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/msm8916-motorola-surnia.dts      | 83 ++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 8d3fc7cb7a4d..acf3ee316fba 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-harpia.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-surnia.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
new file mode 100644
index 000000000000..eecf78ba45bb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-motorola-common.dtsi"
+
+/ {
+	model = "Motorola Moto E 2015 LTE";
+	compatible = "motorola,surnia", "qcom,msm8916";
+	chassis-type = "handset";
+};
+
+&blsp_i2c4 {
+	status = "okay";
+
+	battery@36 {
+		compatible = "maxim,max17050";
+		reg = <0x36>;
+
+		interrupts-extended = <&tlmm 12 IRQ_TYPE_EDGE_FALLING>;
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
+	vdd-supply = <&pm8916_l16>;
+
+	pinctrl-0 = <&ts_int_default>;
+	pinctrl-names = "default";
+};
+
+&tlmm {
+	battery_alert_default: battery-alert-default-state {
+		pins = "gpio12";
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
+};

-- 
2.44.0


