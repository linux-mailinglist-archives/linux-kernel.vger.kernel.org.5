Return-Path: <linux-kernel+bounces-32396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7A835B30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F36B1F21271
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E09DDB6;
	Mon, 22 Jan 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy3CLvRw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB19F500;
	Mon, 22 Jan 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905867; cv=none; b=Zm8uQ0faxIjUeRp9P+TVPoR0+odT8vhYCi4QyhFrdVz5z/8HWdtzgbKwt8TTxQ8l3zOVOIX5BgDtZcR/3Ek+RvhwXYH7TVP1q51ADrO73hBQRd1ut3JVeH3YLw1oRMgAOhnN38q6DXUCZJNB7/jHyheqTlnkWTKO3n2NNGNqzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905867; c=relaxed/simple;
	bh=ldrUB48xZDazzp/AyajgHeXxDyEX8P50st74ShQc4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AS8kc08U0aaqjXL9oCVwpJI9X7vCUVx4tP4TLb4xY473t7X8+TJXatE2YUs6AwuExH++N2uXYYphZ033e+4FQA/wvqk4pGXvgPUVYolvYpdwwCqNnwz6wnXxajCwHATLCB0L0hr4Oa9wq5EUQCjly8gtXqyFRcURWndIJCVhw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy3CLvRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E1EC433F1;
	Mon, 22 Jan 2024 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705905866;
	bh=ldrUB48xZDazzp/AyajgHeXxDyEX8P50st74ShQc4Ks=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Gy3CLvRwcu6Dbp557Flou6m4aXwteg8Q0YtxqvxEJ84338lRhwyi+hYRtS91Unz8n
	 pluK8+0UJbPidwN818gA8ty4DYszd3HzspIcWTe4Z8OCsgbWvzvTIiCNlnz/nZ3mIE
	 5FMo3lINSWUM2/K/eZmOuEV4fLGn7FdfiY1HnOFyBYd8vYPfaam/86iFcItCJ9L4kl
	 cll8ALoLzoOBFXD3sFgr3aUQ1oMmGyqcV6d5rtsmMrIQ+yAbEh3Dx/360kGRrhz/8O
	 3JRBHvEiZ2gS9VzRFL94S7cjhM90WtEP9r2yivYgq07ARtiteU/CpqPs4HR3DMhGFg
	 28GR3+dzK6H7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3139BC47DAF;
	Mon, 22 Jan 2024 06:44:26 +0000 (UTC)
From: Hui Liu via B4 Relay <devnull+quic_huliu.quicinc.com@kernel.org>
Date: Mon, 22 Jan 2024 14:43:24 +0800
Subject: [PATCH v6] arm64: dts: qcom: qcm6490-idp: Add definition for three
 LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-lpg-v6-1-219737cf5beb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIwOrmUC/2WOzU7DMBAGX6XyuUZe/6XlxHsghJz1OrHUJq1dL
 FCUd8cJVCXi+Ek7szOxTClSZs+7iSUqMcdxqMPudwx7N3TEo6+bSSEVSDD8dOm4ds571egDgGP
 18pIoxM/V8vpWd0jjmd/6RO7BAgh+xfH8fiKfeZEcuELnIbQtWuNerh8R44BP9WRR9jHfxvS1d
 hW1iLcJRVWBJulbgdYHEzaCJaLoO6UFgPyhdKVQC6GFtPZg2/+U+Uv9/jJrrLGhacIRCbfUPM/
 f4giaEkcBAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hui Liu <quic_huliu@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705905864; l=2220;
 i=quic_huliu@quicinc.com; s=20230823; h=from:subject:message-id;
 bh=n8xSHABdt74JEuBzHLY4lYbQGqDaAeo36uTk0NjptXM=;
 b=wTFFnqsHbmf742D/Tk8UBK4kYpSU/L6zoS1MROwEWFyqlYR6qVPBWNWUW7G4QbS2h5T1ra/Tg
 HsC3P6C/DzoCzhq/xfwBkNuCxRRPU2QMgMe+zELya+sidiZeDOvxW3S
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


