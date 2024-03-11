Return-Path: <linux-kernel+bounces-98681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA0B877DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F237B21D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D282DF84;
	Mon, 11 Mar 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se+w522M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA74182A1;
	Mon, 11 Mar 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151872; cv=none; b=GpYbGSJi2Ynj7sShQjnZalLIjJA7JwpmqX3dABXmAh9uUp6TU0TwpWLolPrirNL9oizGv3PAvc8fqOZlcfSjOboC44PL7K0R9tauMEx1Zn0S0W0ykQIfwpkf0uV5iwBHvziJyCOut/jNMeht9BrqBkep40veTXq4nZGdJt+qVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151872; c=relaxed/simple;
	bh=I6gW/BhVUudvPkte5swzIwXeljQnXcB+mOb7zYQvmFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SOEbxeqM/Rc1MobyyWpqZYNcx6FrzAqVFbY9uTXgdOwH+nPTJj0tZU5T6MOR34j7+Ns6/MUSzYu/LZYBzeyt7vUSpgkapxCERs5Usjk6PZWejdWF2KJ15VjKW3nlT6xhB7M0wMvwx5uJi8MJl/ZN1BrAmSch+gg6PDHrjrQqudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se+w522M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C3BC433C7;
	Mon, 11 Mar 2024 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710151872;
	bh=I6gW/BhVUudvPkte5swzIwXeljQnXcB+mOb7zYQvmFU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Se+w522M2QblUu7GUAiHxGhY54wouba/GQuvUpweNvdlq13UD9VjeCdyUAhgju9nE
	 5pXkiM/JhO3+cIkY/O4dZ0ZRkiXgUzObblZ1Zi5TgWqKBvrb3N5Zzwr3mwfRiQv/V2
	 etUXRynOdZSMgO6sR9KvXsf+GVsNFcoBZJ/3dlj7d9j66AOKzWLuvFWr2Orj5SDJ/7
	 GCTBGJjQtXWhCn+wIBqUNUURjA826UhbeEsx8PFC5SyFz/EDluGrhqGHwTOAGx40Ln
	 DRog57///x/78w5hHq/OzNOY4noB/i5nxIyr8AogrcKj8VafARO1jfxdWLyWFqlerH
	 GtxL3GxwbLRAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D268C54E58;
	Mon, 11 Mar 2024 10:11:12 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Mon, 11 Mar 2024 18:09:31 +0800
Subject: [PATCH v5] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-gpio-keys-v5-1-08823582f6c9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGDY7mUC/23MTQ6CMBCG4auQrq3pH+3gynsYF9AWmRgpUiUaw
 90tbKzR5TeZ532R6Ef0keyKFxn9hBFDn0a5KYjt6v7kKbq0iWBCMcE0PQ0Y6Nk/I+USmsZByUQ
 FJP0Po2/xsbYOx7Q7jLcwPtf0xJfrv8rEKadGgzRV5eoW3P56R4u93dpwIUtnEpkVMrciWV61C
 hrpwGjxa+XHSsZzK5O1tdbKeTCmtL9W5VblViXLpGbKGQMW9Led5/kNMvYqhVgBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710151870; l=2997;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=P49AauHmA6KJoQvdRRaGDstedPDavIC2nds8wmnutYE=;
 b=03Wz5EeAwzrpIdHG6XXQbaisCr4nHg3GdAT6B7ypyIHxfudc4Nx9fJWoORpCeNxkq6pe7htPr
 hjwB5uUJ1b0AuKECDnFsM4EWhMV1VfMQqhv+CE1woGdo4tqj9t2Y91U
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
Changes in v5:
- Removed the status setting for pmk8350_pon, because the default
status is "okay".
- Link to v4: https://lore.kernel.org/r/20240304-gpio-keys-v4-1-03604d778c86@quicinc.com

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
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index acf145d1d97c..a4a7d55fb45c 100644
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
 
@@ -448,6 +476,15 @@ led@3 {
 	};
 };
 
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


