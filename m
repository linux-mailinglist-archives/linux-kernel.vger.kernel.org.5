Return-Path: <linux-kernel+bounces-701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8E8144D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9B1B22BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2A18AF9;
	Fri, 15 Dec 2023 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNPKVf7v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021021A27A;
	Fri, 15 Dec 2023 09:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 685EEC433C8;
	Fri, 15 Dec 2023 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702633637;
	bh=UplJWH4Q/tqUK9lL0NeQ0i3KjWIEOgUf4v3sM9Fc79Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lNPKVf7v2cnu27ZcpyO4bQM6FKX7jw9BMpAZorhmoXzAaSEXvTqMjXysELQs4tKGF
	 EVEjrNJ2bcHxLNK9PhBPSXHDVD2AcxVLgajBlj5LJsnLJ03/e/jDdLqn/T8bJKDUQ6
	 ByaPiISZPWI1fz0I2L9mkPxfD6shTR4mO4Y6qnJP/CRosOBUrD1463aynQ6Wg2P4Sz
	 iZRmLWULYk9YGyYgzdPbzVwf3fQOSG90KwcHPdGdkJTN1YCpu/UULJFnq6QsQ4XulZ
	 pXoOMIqrr7ZkTBpxLPpfc1FS3n76My/oyuk4EKSZm1nm3fE++7CCSaT6vhcJuoca7A
	 xP6fZKPQdIvLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4744EC4167B;
	Fri, 15 Dec 2023 09:47:17 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Fri, 15 Dec 2023 17:33:32 +0800
Subject: [PATCH v3] arm64: dts: qcom: qcs6490-idp: Add definition for three
 LEDs.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-lpg-v3-1-4e2db0c6df5f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHAdfGUC/0XMQQ6CMBCF4auQWTuGaUGNK+9hjBnaASYBCq0SE
 8Ldbdy4/JL/vQ2SRJUE12KDKKsmDVOGPRTgep46QfXZYEpjyVCNw9xhxey9PVcXIoZczlFa/fx
 e7o/sNoYRX30U/m+JSlxcGJ+D+ISrQULr2FPbNO5U8215q9PJHXMC+/4FmQQtqJgAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702633636; l=1646;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=jkgKPcTHB0LvObnOdM+JMFH2yGRqbzzTL1fwXf6UZho=;
 b=8cRQyf8GFCz6G7Lm8RUia1YB/uRkxLY/eTLY+R57RE12nYTwiZcxIu40k7vqcqHeR5rBPK33r
 b4+KOeOABaKCoioDKb2XNu2GP83ffvmeGQobZ0KgCb0vzcXQ2u/SMUz
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
Changes in v3:
- Rephrased commit text and updated the nodes to qcm6490-idp board file.
- Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/

Changes in v2:
- Rephrased commit text and updated the nodes to board file.
- Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 37c91fdf3ab9..f801144a1556 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
@@ -414,6 +415,30 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm8350c_pwm {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_RED>;
+		label = "red";
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_GREEN>;
+		label = "green";
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_BLUE>;
+		label = "blue";
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


