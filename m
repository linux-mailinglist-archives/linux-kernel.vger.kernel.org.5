Return-Path: <linux-kernel+bounces-25819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9782D653
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9734F1C21611
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDBE568;
	Mon, 15 Jan 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY1l8xIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D9D2F5;
	Mon, 15 Jan 2024 09:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D03C433C7;
	Mon, 15 Jan 2024 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705312130;
	bh=D8eqyGJBMl/zmbPd8uMuLY2qesCRT+s4btQ/GCmYQIw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CY1l8xIAPtPo9+Fb87monGh/dYTtJV0bz1NnwXnv1dTNX3G3sZ9onMjIsIVPD9i6Z
	 OXZpWO7S7dlklPmF7/3paM/CDcWUaVtTqkAbodn9yVUt6oV+XiaCENuRyfkKD1tihD
	 jVS+TeaGLiuyOWFxn6TFRygg5j0O5pVwhxaMWUKOFMz0DuqEHg3QpzeSdyL+5vmPR8
	 shz8enDRn+9udYvY4fNRR+ZwkR63vBawu2oBYmMEmdxjbMm8jIqtQCOCeg0hG54gY6
	 GGFyPXrPXrk5aWSW1FTj5Vn2z0NUbfSiDBJlOv4Z5yQWoBzZlih/RHAvs0bdyYlG2x
	 nQ8fu4aNSA1Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66438C3DA79;
	Mon, 15 Jan 2024 09:48:50 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Mon, 15 Jan 2024 17:48:37 +0800
Subject: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for three
 LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-lpg-v5-1-3c56f77f9cec@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHX/pGUC/1WO3wqCMBxGXyV23WK/bS7pqveIiLk/OlCnm41Cf
 PemEeHlge8cvhlFE5yJ6HKYUTDJRef7DMXxgFQj+9pgpzMjSigDCgVuhxpzKbVmZ14CSJSXQzD
 WvbbK7Z7ZBt/hqQlG/l0Agkflu0drdMSJYsBMSQ22qpQo5HV8OuV6dcqTNdm4OPnw3n4ltob3F
 xLLAW6orogS2hZ2F1hPJP6zOAGgX4tnS3FCOKFClKLaW8uyfAB9zWyOEQEAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705312129; l=1982;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=kbl/RWkKCwiC9v8FHJS+qQTVX4k0SVTLaRWOhdD+XYo=;
 b=MmaOYHX12oex5H21exM2lmlZ4WrwfDdHYzPHMkIFWMZ1AxXDFqLJij+2eCSpU4ch55er29s/g
 vqBq9BNnFCHCEAUOtlyLRS4z8evAdZzlIb06UWqF1W7sBA1IAbH+sSv
X-Developer-Key: i=quic_huliu@quicinc.com; a=ed25519;
 pk=1z+A50UnTuKe/FdQv2c0W3ajDsJOYddwIHo2iivhTTA=
X-Endpoint-Received:
 by B4 Relay for quic_huliu@quicinc.com/20230823 with auth_id=80
X-Original-From: Hui Liu <quic_huliu@quicinc.com>
Reply-To: <quic_huliu@quicinc.com>

From: Hui Liu <quic_huliu@quicinc.com>

Add definition for three LEDs to make sure they can
be enabled base on QCOM LPG LED driver.

Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
---
Changes in v5:
- Rephrased commit text, replaced qcs6490-idp to qcm6490-idp.
- Removed the unnecessary full.
- Link to v4: https://lore.kernel.org/r/20240112-lpg-v4-1-c4004026686b@quicinc.com

Changes in v4:
- Removed "label" definition and added "function" definition.
- Link to v3: https://lore.kernel.org/r/20231215-lpg-v3-1-4e2db0c6df5f@quicinc.com

Changes in v3:
- Rephrased commit text and updated the nodes to qcm6490-idp board file.
- Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/

Changes in v2:
- Rephrased commit text and updated the nodes to board file.
- Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 37c91fdf3ab9..8268fad505e7 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
@@ -414,6 +415,28 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm8350c_pwm {
+	function = LED_FUNCTION_STATUS;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_RED>;
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_GREEN>;
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_BLUE>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
change-id: 20231215-lpg-4aadd374811a

Best regards,
-- 
Hui Liu <quic_huliu@quicinc.com>


