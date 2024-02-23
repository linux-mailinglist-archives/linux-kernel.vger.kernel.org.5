Return-Path: <linux-kernel+bounces-78203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A925E861035
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644882866D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19299763EF;
	Fri, 23 Feb 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdqA70He"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544735C911;
	Fri, 23 Feb 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687119; cv=none; b=cYHGrb2jPOtyBU+iWm1F9rHZBKP8cfdB5LCFZgervrYhnX9M0JWu5uz6zpGjAPMo5x+5y0jOCzVE3WzTFGV4Bnl/xReWvTGuoZElUvIjPN3pPSTPPydZ48w04vdKWbMXJ4EB0IP7qTVvOByl+9OrNzSkAi2NaHnZDdGFJ/tol3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687119; c=relaxed/simple;
	bh=WqWwgEoSuM/1pfV16dEakkeAH3YcAqhmmNupq9ppA1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ncwOtCz1S2qqkNryx++crP6RXqQ74SNEiagYAfNyGaJzw46Parl21Z9Wq/3AThG0YqHA1BQGb1ruunb2Po/vAQwny3uNw9b842Iqo3MEQWwix10ApI0lEaV+zhTHu5m884wzF8Udg++wsCPTCeJLggSY2CYor56hcSalSDMGUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdqA70He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B557BC433F1;
	Fri, 23 Feb 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708687118;
	bh=WqWwgEoSuM/1pfV16dEakkeAH3YcAqhmmNupq9ppA1Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UdqA70HeRjCxiNtSJmZh3McG5HyShAQSx7OcaEfrQI/wMzmdrz0BOKriZFbwmYnvT
	 0s+yv7HxvsYDMy7aYeixVmfsCfpf3RzLrZ3zjqgrOteT5kbOmgQO5xjdU3iL4ASgK3
	 qFCJz/m65OugLmDtEVOmVEpQbMEFl0OVV7iEm9YW44nvkQrN91O+R9s8dN81c/hOOr
	 rqIvn3m1fWUoKTDdlVds+QymKLUDmgAJkV5rnDZYM205amTstAQh0eWhze+Uztt3PN
	 pr6f65GvM8Fk3xlgqzjnSpRr5Af7EeSGEa1JAJ9/ldHtE0tbRh3ZzkDWn9Wlw0yBbD
	 FEgxR00zo0s/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98738C5478C;
	Fri, 23 Feb 2024 11:18:38 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Fri, 23 Feb 2024 19:18:06 +0800
Subject: [PATCH v2] arm64: dts: qcom: qcm6490-idp: enable pwrkey and
 volume-up/down function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-gpio-keys-v2-1-19f48b3d8762@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO5+2GUC/23MQQ7CIBCF4as0sxYDVFtw5T1MFy1M24kRKiixa
 bi72LXL/+Xl2yBiIIxwqTYImCiSdyXkoQIz925CRrY0SC5PXPKGTQt5dsc1MlGrYbDqzKVWUP5
 LwJE+u3XrSs8UXz6sO53Eb/2nJMEEaxtVt1rbflT2+nyTIWeOxj+gyzl/AbdBbyGkAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708687117; l=2151;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=uxn7urf55wldvs+MTDmzxYHE9lWSCWgorQZPNSBSB4Q=;
 b=gFwfI20rOvMU+88wBhjVvCNwQwZr+PNJ5pJs+3SVsZpZJBYjmgkcPnn+WzZ1ym208s046PcXO
 HN2QoWGkSEkDzkFnRj2GQIpR340qTwpsJkYp9L3kJ0NE+rVE21fPiBP
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received:
 by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>

From: Hui Liu <quic_huliu@quicinc.com>

Add configurations to enable pwrkey, volume-up and volume-down function.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v2:
- Update the commit description.
- Link to v1: https://lore.kernel.org/r/20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index acf145d1d97c..4199ebf667af 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -9,6 +9,7 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
@@ -39,6 +40,24 @@ chosen {
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
@@ -421,6 +440,17 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm7325_gpios {
+	key_vol_up_default: key-vol-up-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+		qcom,drive-strength = <3>;
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


