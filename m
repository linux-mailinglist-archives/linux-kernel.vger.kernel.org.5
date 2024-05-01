Return-Path: <linux-kernel+bounces-164980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AF8B85D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED81C224C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FD4D9FB;
	Wed,  1 May 2024 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCb3SXEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB204CE0F;
	Wed,  1 May 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546659; cv=none; b=WFhgi8pEHtGMyeE2TKoyx/gT6jl/hMft4IwQXE1YctuoJJ8icWeZxsbC51XI1b7039DZApLScGn9XTYXkhekR9jUD4rfSMn+Pe1D6q5UP0arr2DJJcNkgA2+kymDYGQW4yvXE1tx/xlAiNESN2p5+YPR87XCt8rjnHWGOeXDh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546659; c=relaxed/simple;
	bh=Q21OMTR+3bFPjSrdV+/UGWZc1UlXE8r/kJXDMHXrsLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVV8pBG3jOX6leWAZFprxq/QG6TYkDMNFzvpRwR+yhKWBZS/XdEcn5kTlNMn/mL4GaG1d4MTm4ovF7PCS/qE2YdcPoJoVduo000Z5pQt0A5QWNm1VjMdL1OUhXXcx5Gp2cBSFG0ln4LkQ504r/KW569UYo+ZIj15rOJFUx4xyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCb3SXEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E6BC113CC;
	Wed,  1 May 2024 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714546659;
	bh=Q21OMTR+3bFPjSrdV+/UGWZc1UlXE8r/kJXDMHXrsLM=;
	h=From:To:Cc:Subject:Date:From;
	b=UCb3SXEOtxtPwPO8h1gNFNTaTcR4GShQg9w/pb6z6mLhVKRDvqrIasoadawmYP1hH
	 1br81ujwHjJHtvOD4Fz/RppGGcl/EcuAhIqz53pW9adOFjRVKuMRYLpPlqH//FgKHe
	 6W123AFJ3zxbnV5L5vYbQ1UpSHcLxD6K2bp4fkQ5FAHvTwkX1kMbLWW65YwHqD23Dw
	 hThfbD6tkgAcG0bwIq9gG7qh1Z32MW7EMwJvspEchnPwkUvxwDlvfARUrigfwZw39q
	 aEi1f7i4DKYL7Py9EyQy4kJB+C7MRkYfhHqO3G8pMw6u7I11kXHXJmFcOxxKBdEMXQ
	 OnGZ6Z4bNGePA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s23uO-000000000GS-499k;
	Wed, 01 May 2024 08:57:41 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable USB MP and fingerprint reader
Date: Wed,  1 May 2024 08:56:41 +0200
Message-ID: <20240501065641.965-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the multiport USB controller to which the fingerprint reader in
the X13s power button is connected.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)


Note that this patch depends on first adding the multiport controller
node to sc8280xp.dtsi:

	https://lore.kernel.org/lkml/20240429162048.2133512-2-quic_kriskura@quicinc.com/

Johan


diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 15ae94c1602d..8cf76682b437 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -414,6 +414,13 @@ vreg_s12b: smps12 {
 			regulator-always-on;
 		};
 
+		vreg_l1b: ldo1 {
+			regulator-name = "vreg_l1b";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3b: ldo3 {
 			regulator-name = "vreg_l3b";
 			regulator-min-microvolt = <1200000>;
@@ -464,6 +471,13 @@ vreg_l1c: ldo1 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l8c: ldo8 {
+			regulator-name = "vreg_l8c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l12c: ldo12 {
 			regulator-name = "vreg_l12c";
 			regulator-min-microvolt = <1800000>;
@@ -497,6 +511,13 @@ regulators-2 {
 		vdd-l6-l9-l10-supply = <&vreg_s12b>;
 		vdd-l8-supply = <&vreg_s12b>;
 
+		vreg_l2d: ldo2 {
+			regulator-name = "vreg_l2d";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3d: ldo3 {
 			regulator-name = "vreg_l3d";
 			regulator-min-microvolt = <1200000>;
@@ -525,12 +546,26 @@ vreg_l7d: ldo7 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l8d: ldo8 {
+			regulator-name = "vreg_l8d";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l9d: ldo9 {
 			regulator-name = "vreg_l9d";
 			regulator-min-microvolt = <912000>;
 			regulator-max-microvolt = <912000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_l10d: ldo10 {
+			regulator-name = "vreg_l10d";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
 	};
 };
 
@@ -1168,6 +1203,56 @@ &usb_1_role_switch {
 	remote-endpoint = <&pmic_glink_con1_hs>;
 };
 
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_hsphy0 {
+	vdda-pll-supply = <&vreg_l1b>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l7d>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy1 {
+	vdda-pll-supply = <&vreg_l8d>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l7d>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy2 {
+	vdda-pll-supply = <&vreg_l10d>;
+	vdda18-supply = <&vreg_l8c>;
+	vdda33-supply = <&vreg_l2d>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy3 {
+	vdda-pll-supply = <&vreg_l10d>;
+	vdda18-supply = <&vreg_l8c>;
+	vdda33-supply = <&vreg_l2d>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy0 {
+	vdda-phy-supply = <&vreg_l1b>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy1 {
+	vdda-phy-supply = <&vreg_l8d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
 &vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
-- 
2.43.2


