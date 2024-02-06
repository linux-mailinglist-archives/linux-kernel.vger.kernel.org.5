Return-Path: <linux-kernel+bounces-54197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3684AC23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4158F1F24605
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838675732C;
	Tue,  6 Feb 2024 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuA5eNF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADB57300;
	Tue,  6 Feb 2024 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186080; cv=none; b=myN+R+rmimOxVbaOHf22akHbZ2yP8oVudiKUfJznnSAKlelMcSKLA7pM+XU+l6qaEJmsFVd3RllmsF5sCAH3jCbQ+I9n9OdeuBMwYmjZXIHKbBbbnj9dn07Ac8QKffPUJD049oFUHD9hX3+WsHSd8UGMY3ngkk3DyJTlEnGDrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186080; c=relaxed/simple;
	bh=YqaP2sUi86aQgnoYv0irulc1gLJ/5wSXYz+6MP0M6Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fHZXT/dD687X9lUGDJkvMyi0MJsIXaKcMXGasC9+nl+JRBdXsC3NGrO+6TopIUJ6WAOlBwfV8zCI6kPqvdqJLaSkW4aMpc4x4TAnp9vJtVYyy1oZ4QWPWzGuIFmNh//akSVfA3X8SGqFagKREy0+qEsNoAbl3+H9zCjvu6AbJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuA5eNF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 238BAC43390;
	Tue,  6 Feb 2024 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707186080;
	bh=YqaP2sUi86aQgnoYv0irulc1gLJ/5wSXYz+6MP0M6Vk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WuA5eNF+MA7MNN4gz2rYsMCMlD3St9eZXDnan5UzMInnODPVcPsHku+cz4KXqH3kf
	 TG6xhpbhZ/+0JPRc6UIBI/+qqI/2GT6TMI1V87psbSTb24eE5IiEW5IaBHq+42KsPt
	 RvFXFB3q02LUtEgvaICWTeRhEGYOmStSi0Cfae3Cqd4IQxOv2t2l6n97BdZI//+ppf
	 n20KMtS5muxtWZ0jPs3Xo/ToBM6nbyK4FnVXvmdl8+3rIT+n525faGyV/C7Xt9guKs
	 9jgB8UIQxWj+X/Vs19pxV99k001UH4GlaNtA69VRSqBE+fUF3gm/CDlIfmrwazB+HV
	 p18OXFBIpeEPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B12EC48260;
	Tue,  6 Feb 2024 02:21:20 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Tue, 06 Feb 2024 10:21:13 +0800
Subject: [PATCH] arm64: dts: qcom: qcm6490-idp: Add configurations for
 gpio-keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJmXwWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMz3fSCzHzd7NTKYl1DY4ukpBQLUwMjSwsloPqCotS0zAqwWdGxtbU
 AgwS/EVsAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707186079; l=2004;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=lvOnmsAUNOMzpmFklkrkm1uAXyOcYWnM0tUChPIUfy4=;
 b=Mr7rYRZPB2Z85vFiulk2wuzYyyb/Tj0QCPYNqaSSMGR6qa2Wn3Kma7VIyJPvdKMc1oo0w+K3P
 IjPWXhabhOACyXRNwElY+0BUl5XCANQZEbwPARiKNujBkQERcMtKbaT
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received:
 by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>

From: Hui Liu <quic_huliu@quicinc.com>

Add configurations for gpio-keys to enable pon_key and pon_resin
key.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
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


