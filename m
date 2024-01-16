Return-Path: <linux-kernel+bounces-27918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9E82F7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669FE1C2343E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339E1272DB;
	Tue, 16 Jan 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6dNqtts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC41272C4;
	Tue, 16 Jan 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434584; cv=none; b=PRSOj5Q9gIjNf+7pFhk+YxRu98a3MU2Pu3T3TSOPi5xLP6XLSO0zCAyQJkg1FHIvM6XKvn6bNWJt3JqIRLe4kuopKOlqLO+8Eg1aL2Yd1UPwmdLbOTKbbkWDrjq61bAn8TX0O11QdFof/0sZ+Gldll4ocL9RY+jmBmrzE/6bNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434584; c=relaxed/simple;
	bh=raTfgeTLJJ57vvSGEdnlG0PeFMAEwRd+42RLCFWdrec=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=QDI7k9EW+slJRoChZZ5e4x/uMCKJXNNKS5gNPuxEPqP8Nw5SQpz+bqTm7hBoX+L5cEcEmhofpUdFCeJb7yQ2LUrYAJ3LVrMvheBaVvN3DB5zwUyWI5++vPDu0z+LlXPODHwZQcQqaXOhacMI5xUR4juKXVflUURG4kdLq8XiTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6dNqtts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19CBC43390;
	Tue, 16 Jan 2024 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434584;
	bh=raTfgeTLJJ57vvSGEdnlG0PeFMAEwRd+42RLCFWdrec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6dNqtts7lbLvsu+1/godQDvlxF72i5lUKKWs/EmSAHquoA+lxpoaFt21wI3/B6VD
	 PYY3YWqxyiOzLJJgu1/jouXhlJIdwd7+R7YZYVq1fI8hehkg4r1rQYvwpEqkO6AjJ/
	 senY/fEX2aaJ0j+fxMTD3xaz/oMIE5yKTpROO2Vr3gAFDvdkA7Wh5MEw4Rpu+IA3O6
	 GLRoRgSU+MnQ9++Guz63es90lGcVJvck/9suOzjOBtakUqxZYed07cRi8loltbY1Vk
	 NWuFRsaFGazx6LDRPP9aP0JxsQK1foH9qmDBRX9sDussS246ifBvTQED5q4yHuHo6N
	 U7W4yba2q2AoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 011/104] ARM: dts: qcom: mdm9615: fix PMIC node labels
Date: Tue, 16 Jan 2024 14:45:37 -0500
Message-ID: <20240116194908.253437-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 0e4688cd4ee6efbeae2b31f75e16961fd7f72735 ]

Change PM8018 node labels to start with pm8018_ prefix, following other
Qualcomm PMIC device nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230928110309.1212221-10-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi |  2 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi        | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
index 92c8003dac25..dac3aa793f71 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
@@ -76,7 +76,7 @@ reset-out-pins {
 	};
 };
 
-&pmicgpio {
+&pm8018_gpio {
 	usb_vbus_5v_pins: usb-vbus-5v-state {
 		pins = "gpio4";
 		function = "normal";
diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
index 63e21aa23642..c0a60bae703b 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
@@ -261,7 +261,7 @@ qcom,ssbi@500000 {
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
 
-			pmicintc: pmic {
+			pm8018: pmic {
 				compatible = "qcom,pm8018", "qcom,pm8921";
 				interrupts = <GIC_PPI 226 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
@@ -272,38 +272,38 @@ pmicintc: pmic {
 				pwrkey@1c {
 					compatible = "qcom,pm8018-pwrkey", "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8018>;
 					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
 						     <51 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15625>;
 					pull-up;
 				};
 
-				pmicmpp: mpps@50 {
+				pm8018_mpps: mpps@50 {
 					compatible = "qcom,pm8018-mpp", "qcom,ssbi-mpp";
 					interrupt-controller;
 					#interrupt-cells = <2>;
 					reg = <0x50>;
 					gpio-controller;
 					#gpio-cells = <2>;
-					gpio-ranges = <&pmicmpp 0 0 6>;
+					gpio-ranges = <&pm8018_mpps 0 0 6>;
 				};
 
 				rtc@11d {
 					compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8018>;
 					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 					reg = <0x11d>;
 					allow-set-time;
 				};
 
-				pmicgpio: gpio@150 {
+				pm8018_gpio: gpio@150 {
 					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
 					reg = <0x150>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
 					gpio-controller;
-					gpio-ranges = <&pmicgpio 0 0 6>;
+					gpio-ranges = <&pm8018_gpio 0 0 6>;
 					#gpio-cells = <2>;
 				};
 			};
-- 
2.43.0


