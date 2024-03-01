Return-Path: <linux-kernel+bounces-88013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4486DC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6802128427C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969769962;
	Fri,  1 Mar 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCBYd8Im"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5566200C3;
	Fri,  1 Mar 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278675; cv=none; b=GLLaok+uYxraBYCIJ/cP+mwpUZcowBIAeuN56yMna4Wqh21b1P4xtG7CSMDhXw/sHRBKezCnm+EdBVloB25k9rkiPvr2jOQbv4P18waU0t7RmmUFTyYsa6iki9Odggd05EXt82ATSCA3zsSO4wsgFLnKlnG3DcCgEHueg8/eJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278675; c=relaxed/simple;
	bh=S41V4Rg+5A+/H6j5q+KJKdnhp7A+2pV2Ka4RM2AmyGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a+powcHdFzhceJunp/K7Zq2sT3nhErgpGLCFB/Eyu+PZ2RcDnxUbGZ2MNrfusGlP8R5LCyX1bdWLk2opMvszYwR6B6SMjyp87xNWhwLXiaRKX4w0WVU1vN7XDado1wzrjyUAwQQJW6la1NAZK62rT7cyh/YuOVcwSNHl4JvK/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCBYd8Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA0AC433F1;
	Fri,  1 Mar 2024 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709278674;
	bh=S41V4Rg+5A+/H6j5q+KJKdnhp7A+2pV2Ka4RM2AmyGw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DCBYd8ImUE5PBwPUzAzWb2ntH/DUQHhzZjZaKG/4aKp6UQ8gosU++rcy9oJmxSix+
	 FHTBZ9+HOzDRJKGidozF5gPkqPcRO0auGm0d0cLFd8EmHlALgV/QPBS7SD7qfdMpuv
	 ur0XlMMeE5cOKvQJz/Mc0NDhT+rZR0i2rOt9+FAAq1LVKBwcQApE+3crSfU9ozJcLm
	 eo7mxwOAhdIggs8LPpVw+kRPruTbOv54y5HHb8AFaG6ULU1hwkM2ZYAhr7pvtqXKAU
	 R9Nd/+yJMc7xm+L8ZWvCtJ0AjLYvUZyL8D9S/UdEnPw8SNRNE4vC4da2zLZoeg6I7R
	 VQXUbz7DQpuHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A698C5475B;
	Fri,  1 Mar 2024 07:37:54 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Fri, 01 Mar 2024 15:16:33 +0800
Subject: [PATCH v3] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-gpio-keys-v3-1-ca664de8775c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANGA4WUC/22M0Q6CIBhGX8VxHQ1+TKGr3qN1oYD6ryUGxXKOd
 w+9sq3L8+07ZyHBerSBnIuFeBsxoBsziENB9NCMvaVoMhNgUDJgFe0ndPRu50C5kG1r5ImBkiT
 /J287/Gyt6y3zgOHl/LylI1/Xf5XIKad1JUWtlGk6aS7PN2oc9VG7B1k7EXYuiL0L2eWqK2Urj
 Kwr+HVTSl8XNyPY4AAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709278672; l=2630;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=Vp4G+fbSlkb2JMufpBHQUvIun8hxc98pkwDSckQhTpA=;
 b=adwBBQ0ZZt/zCSk4WrpPjo2YcwF+PcjY3Mpz6Xj/DW0QpvmkQ1r+8O5jnrwjrLA1H1KJ/DfgV
 ggFdU7Xh3HZAkx4pQygcYIG/Fl+nJXs77c5ibMkB4z/atJiSiWJz7SC
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received:
 by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>

From: Hui Liu <quic_huliu@quicinc.com>

The Volume Down & Power buttons are controlled by the PMIC via
the PON hardware, and the Volume Up is connected to a PMIC gpio.

Enable the necessary hardware and setup the GPIO state for the
Volume Up gpio key.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v3:
- Update the commit more concise and explicit.
- remove "power-source" property and update the numeric value to defined
name for "qcom,drive-strength".
- Link to v2: https://lore.kernel.org/r/20240223-gpio-keys-v2-1-19f48b3d8762@quicinc.com

Changes in v2:
- Update the commit description.
- Link to v1: https://lore.kernel.org/r/20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index acf145d1d97c..cf8f6d48bfc2 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -9,7 +9,9 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
@@ -39,6 +41,24 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_vol_up_default>;
+
+		key-volume-up {
+			label = "volume_up";
+			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+			linux,can-disable;
+		};
+	};
+
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
 			reg = <0x0 0x80700000 0x0 0x100000>;
@@ -421,6 +441,16 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm7325_gpios {
+	key_vol_up_default: key-vol-up-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
+};
+
 &pm8350c_pwm {
 	status = "okay";
 
@@ -448,6 +478,19 @@ led@3 {
 	};
 };
 
+&pmk8350_pon {
+	status = "okay";
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
change-id: 20240206-gpio-keys-138bbd850298

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>


