Return-Path: <linux-kernel+bounces-90113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353486FA81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5012B28162C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C163134C5;
	Mon,  4 Mar 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsID04GF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D412E4F;
	Mon,  4 Mar 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536188; cv=none; b=MjoD0uPcr4rR6Var5iCTgZTgq7gfwFzLiJOJZzbcLG5R37I/9s3o+L/HZZTk+rFBWTiQJqElvvOUe+HyrrFIAyBEXtOWQkf0zSJ6Qz1WvvQc9/0cJYKFew6p6s2coGb1Rvxs2N6d1gX0iTCv/Rzp/7EaAhjOp35gIbK82eh+L0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536188; c=relaxed/simple;
	bh=2ijnbHwObwY7khqqO6e422ywpHeLzyDhZfDGrq2Kusc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PYJ0WRRqp8B0bdCD7GJXJ7SWuFGZ+M31CD8QtcnWptFuZEnqvFod7U/FP/IA1SoyVtdwJt+Plq/y9pNHj3RwwKubry8kURCPFqhPrVS/yqhc/PurPrAlXBgnYaIlZkZ3Iskz9BiqcevGv4AcLrjU2046eqPaAvOz4FOptfIvfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsID04GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA16C433C7;
	Mon,  4 Mar 2024 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709536187;
	bh=2ijnbHwObwY7khqqO6e422ywpHeLzyDhZfDGrq2Kusc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NsID04GFBrFEq2mhYG9GLBxTGuGQzGzgljIvINybpXBcuIdQt6cjjPtGoqSpKAscz
	 mF1foLiiqHrkoRlxRfj2olGQdL2aXk97qrx0PiyvNTeg9+yUE4u6Z0fSbR8CylCpuv
	 5S7A2Gu7HJ2n0bxd/64xyn2iB2Aiza8NHoqkRUPqRWB6f6pQSPynRCs4mLiNxXZt6t
	 24q3AwHf0Fe9bnvey17Kjf4ClDb1HoVroNQRclzWXtPQfmxCxrVScfXjeWi/7iWt7S
	 hXR43HSDfKU3tdmKAVIixf0rDPkyywJekSPH4w9KlfQR3nanE4jiTM3pAUMRDZWZfs
	 awL5kDllj5NCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E4C48BF6;
	Mon,  4 Mar 2024 07:09:47 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Mon, 04 Mar 2024 15:09:34 +0800
Subject: [PATCH v4] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-gpio-keys-v4-1-03604d778c86@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK9z5WUC/23MTQ6CMBCG4auYrq3pH21x5T2MC2gLTIwUW20kh
 Ltb2IjR5TeZ551QdAFcRMfdhIJLEMH3eYj9Dpmu6luHweaNGGGCMCJxO4DHVzdGTLmua6sLwkq
 N8v8QXAOvtXW+5N1BfPgwrulEl+u/SqKYYiU1V2Vpq0bb0/0JBnpzMP6Glk5iG8v41rJsadkIX
 XOrlWS/ln8sJ3RrebamklJYp5UqzLed5/kNFxAXDxwBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709536186; l=2848;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=DmuCpd4eRqEEUGUcUCiLEb7DRgH2P8prW7W/cQOxkwE=;
 b=ihk9653yGVvrrofzSCIhnexlgDvC2L7KUxE6BEDvt1b0oR6rWZCL9f2uoOElF52DUDwDZEz+8
 0i6TwHzZVrTAIe4GKO6UKcwrnD7+T3uB/Km6BZtjs/pio/KVpbPRkl4
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
Changes in v4:
- Switch the order of "pinctrl-0" and "pinctrl-names".
- Update "volume_up" to "Volume_up".
- Remove "linux,input-type", because the default value is 1(EV_KEY).
- Link to v3: https://lore.kernel.org/r/20240301-gpio-keys-v3-1-ca664de8775c@quicinc.com

Changes in v3:
- Update the commit more concise and explicit.
- remove "power-source" property and update the numeric value to defined
name for "qcom,drive-strength".
- Link to v2: https://lore.kernel.org/r/20240223-gpio-keys-v2-1-19f48b3d8762@quicinc.com

Changes in v2:
- Update the commit description.
- Link to v1: https://lore.kernel.org/r/20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index acf145d1d97c..12e162613ed0 100644
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
@@ -39,6 +41,22 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&key_vol_up_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume_up";
+			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
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
@@ -421,6 +439,16 @@ vreg_bob_3p296: bob {
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
 
@@ -448,6 +476,19 @@ led@3 {
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


