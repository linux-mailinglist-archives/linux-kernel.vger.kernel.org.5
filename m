Return-Path: <linux-kernel+bounces-39555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BE83D2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F40EB22AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77CA95E;
	Fri, 26 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCsRD+i1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33E8F54;
	Fri, 26 Jan 2024 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237821; cv=none; b=Vh7SofvknQRmRcSSydH2beqpEaWHgKG9ZPy7DrUr+uEPm4XCXVqjDmMu+O7Ng75CKVnTz7Y0SvsvpvofYxlvau5Ty9YvayaKIv4fU1T/etzsr2A71hkGfitAr3osg/cI/KYXOvRJDuXEUAwudHEKWOKiMP3qxG0MsxVBVy8H2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237821; c=relaxed/simple;
	bh=ldrUB48xZDazzp/AyajgHeXxDyEX8P50st74ShQc4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yo3Xbfuiojxau+BD+cWfoZ/ddvo2Q7z7jkgcdg07bheWfFpG2JZxEfrVAua8v3tyVgm4arwRFMuPUhn29/tE7Nt6hRBNUKnqvp6BQAXFFAupQ0eXqo4+pmt39UGMWSRG5PxnOf+JTl/93UiC6GJkZT/4/EpbhEt8meHLSBTnAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCsRD+i1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A4DBC433C7;
	Fri, 26 Jan 2024 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706237820;
	bh=ldrUB48xZDazzp/AyajgHeXxDyEX8P50st74ShQc4Ks=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FCsRD+i1iA2L35y9D27Z0A0b2PEdXd8NKCdX+wl+eLWo+epQum8XUt7KYas5ZJIY7
	 UYasEseeOdZDYO9O577kA5fbN44GE6hjPT/d7LKWFw/S7blBwgGAxpM6KsSoIq5zly
	 jrU9NQODq9Cs+ONaCOtt/wDKf9Pb5PzRwXGdPfljc7J+XsabHEupv4Nh7QRFmolSsX
	 AXkKtQYOyuMaAJITXNlmwwjcxXugtM6Q7/l6Fi0ObZe7NPB2g5S6zEouYpmeMD6jfW
	 t5Y+Y6QnGLSBKdSMc8El3soZSc3VI4AJ5qqrO0ysHHg9XmltAZK6Xpjn7rNJND8pNS
	 kzVrdrMSjbf0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714FFC47DDF;
	Fri, 26 Jan 2024 02:57:00 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Fri, 26 Jan 2024 10:56:52 +0800
Subject: [PATCH RESEND v6] arm64: dts: qcom: qcm6490-idp: Add definition
 for three LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-lpg-v6-1-f879cecbce69@quicinc.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706237819; l=2220;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=n8xSHABdt74JEuBzHLY4lYbQGqDaAeo36uTk0NjptXM=;
 b=vbVTdBnFQluBuMBVvOiTZdg7OyY9722Y93b02LAhqFZAgBdNYF3bQpzjNhAENodDDhgmEMiFr
 S8NzMJ1b2UXA+ausNNd3pJt/GqmvxNzo7cEO4BF8MOVi5StH7mSuRLn
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
Changes in v6:
- Updated the seperate LEDs nodes to multi-led setting.
- Link to v5: https://lore.kernel.org/r/20240115-lpg-v5-1-3c56f77f9cec@quicinc.com

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
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 37c91fdf3ab9..c9e7ddcbd259 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
@@ -414,6 +415,33 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&pm8350c_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
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


