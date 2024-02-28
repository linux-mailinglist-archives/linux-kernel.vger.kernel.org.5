Return-Path: <linux-kernel+bounces-84799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F32286ABC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1802889CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112936AE0;
	Wed, 28 Feb 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq6H48DA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28590364A1;
	Wed, 28 Feb 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114243; cv=none; b=sTPYva+Ux7VYIZ+Vzf4MZa0BvGBH/rqGyIJyAZYLGihvSGkaidupe0FrTFYlElytp0LerScjtinFqFQx19puX3fpr7Ihjtbgb2CrvDduTz1GwwEvDrwAyOYlCRKHEVs6rFqHvSY4wcwapVFRxJz0JXJr1n0FFs9XjUbwrpt8qQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114243; c=relaxed/simple;
	bh=WqWwgEoSuM/1pfV16dEakkeAH3YcAqhmmNupq9ppA1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lOAqWDKX/AulS9ojI43sCXvBHxZI9k9adQrs93B7w0h8nLgYg78Jk0/pHP8Ixqr5OWzQhNEQDYlf+fwCX14vx0mEmsRESjnSVZO9lVU2JjZUKQhpBdS0OC7oVBJKxxOEcPgunju7LV+cA2Q8/GRxCNRFuGeBlD1joeGQ9tt5Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq6H48DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8431AC43601;
	Wed, 28 Feb 2024 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709114242;
	bh=WqWwgEoSuM/1pfV16dEakkeAH3YcAqhmmNupq9ppA1Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nq6H48DAVrY/8pkNU5QxJrcv1K3r+3ksrL4PMifDSq+lBu7dReIToJ+O81d0mBho/
	 uJiTik7wFCTrgkS0ApAd0viVsj99JrEpyv309vpGS0iEqob2Yx+OSg3JEfAtaWeqlV
	 kz1jiteAXzVwjY7JN/zZ/ZSmCln8VNTRFMv2LjUm0yB/4RHCQ7pVdzW2rW6M1oUlN8
	 i01xWO9u8sluyVrUo+CQn9IDoKy0lu1UCyO+RCBhW7lO9SsTc0wkngcQX3qoFWzDMv
	 4YesggC4eyEHKWFs2auF6Kuwk+bmlRrRcy2tFglRdF8I69vECLc6BTdoi1LugJ6S5Z
	 +OsnKGo1r4mxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C317C54E41;
	Wed, 28 Feb 2024 09:57:22 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Wed, 28 Feb 2024 17:56:42 +0800
Subject: [PATCH RESEND v2] arm64: dts: qcom: qcm6490-idp: enable pwrkey and
 volume-up/down function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-gpio-keys-v2-1-3beb60225abe@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709114240; l=2151;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=uxn7urf55wldvs+MTDmzxYHE9lWSCWgorQZPNSBSB4Q=;
 b=7Da8as+oy3m1yGMGfVVIbVkvXvAEUqwESMBAZ8FKdwg/rPLTR/zEubfFlBhbBEQzVD9qyJOG/
 iXN3z9sCd3pCNpSg8xSlHYEKKIDKWxw+nfeL1I6MbryL/HosjE0gpGp
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


