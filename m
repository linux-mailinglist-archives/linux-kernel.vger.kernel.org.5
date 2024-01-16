Return-Path: <linux-kernel+bounces-27917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE382F7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8441C24B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7912375C;
	Tue, 16 Jan 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZmj+S/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AB1272AC;
	Tue, 16 Jan 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434582; cv=none; b=dVv0SPtAgdxs4lDJ0YnovvUsYN/aHvj8i8Zo2m+dvtFoIgq7XlP/+SF8qzToJR7LTj5qZWpmTIE3PJMqCzQslkDYUGMHwjlJu2awl21sDDmKqIuA8a2eav6OJIPeDHYOwBaMFHKGV9i5c80ckSkhNdkyays/s2bxvtHUavhie2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434582; c=relaxed/simple;
	bh=lXJ0a2Du5lrS2l9vpe0f22MCr97iQ+E8c/SR2dVQCIE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=TC+H0dN9XXLcBB065XXkUpzDgqCMlazS4efABEeFP2BbNX/XphUZ5Z3Ls73e0fQFwoXGko/nrew6rookNyHvnFI4vOO8rZpHefvU6YMWlhwCZkErAvKuzCv6nfu+2AsFrocKadwIp0DcBoaSvEjXh0Hpqf1+qA0XjFFvt/ZQHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZmj+S/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF23C433B1;
	Tue, 16 Jan 2024 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434582;
	bh=lXJ0a2Du5lrS2l9vpe0f22MCr97iQ+E8c/SR2dVQCIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZmj+S/3djWJdOPCwVRkgJGvZYjFOkGlB0g2KuhSusGCdZ/0S6bN3L/K6EFx5iDNv
	 ErVoIVliyXdoYeHvSbt5yZHucUkTsKeQhXRRTQOOU/S2sdx97RwBjTcrgpSPEAOePq
	 x4Q5iCeD0RXHYo+10kgbCsautEWGhcBs7iqVo9IH/M7BVtQjNVwb5q7CRj2AkinALx
	 nGXfSuyVlB8X/sO+xaTqOBPg/cOU0jKVpnOKXT6zrcPvxBaF9Z7Z2hia7wDYHukVwj
	 JJkHG1jKS9S0Bcgs8OROEHndYmQ6EqyKIAu9BsZ16ly9Yryyp3DnrUSBWJWRswRatO
	 XB+wlAQ5Xgv7A==
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
Subject: [PATCH AUTOSEL 6.6 010/104] ARM: dts: qcom: apq8064: fix PMIC node labels
Date: Tue, 16 Jan 2024 14:45:36 -0500
Message-ID: <20240116194908.253437-10-sashal@kernel.org>
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

[ Upstream commit eba2158528b1882055b7fe2b7647820516178f06 ]

Change PM8921 node labels to start with pm8921_ prefix, following other
Qualcomm PMIC device nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230928110309.1212221-9-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 516f0d2495e2..eb12e58911b2 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -292,13 +292,13 @@ scm {
 	 */
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&xoadc 0x00 0x01>, /* Battery */
-			    <&xoadc 0x00 0x02>, /* DC in (charger) */
-			    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
-			    <&xoadc 0x00 0x0b>, /* Die temperature */
-			    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-			    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-			    <&xoadc 0x00 0x0e>; /* Charger temperature */
+		io-channels = <&pm8921_xoadc 0x00 0x01>, /* Battery */
+			      <&pm8921_xoadc 0x00 0x02>, /* DC in (charger) */
+			      <&pm8921_xoadc 0x00 0x04>, /* VPH the main system voltage */
+			      <&pm8921_xoadc 0x00 0x0b>, /* Die temperature */
+			      <&pm8921_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			      <&pm8921_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			      <&pm8921_xoadc 0x00 0x0e>; /* Charger temperature */
 	};
 
 	soc: soc {
@@ -686,7 +686,7 @@ ssbi@500000 {
 			reg = <0x00500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
 
-			pmicintc: pmic {
+			pm8921: pmic {
 				compatible = "qcom,pm8921";
 				interrupt-parent = <&tlmm_pinmux>;
 				interrupts = <74 8>;
@@ -721,7 +721,7 @@ pm8921_mpps: mpps@50 {
 
 				rtc@11d {
 					compatible = "qcom,pm8921-rtc";
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8921>;
 					interrupts = <39 1>;
 					reg = <0x11d>;
 					allow-set-time;
@@ -730,16 +730,16 @@ rtc@11d {
 				pwrkey@1c {
 					compatible = "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8921>;
 					interrupts = <50 1>, <51 1>;
 					debounce = <15625>;
 					pull-up;
 				};
 
-				xoadc: xoadc@197 {
+				pm8921_xoadc: xoadc@197 {
 					compatible = "qcom,pm8921-adc";
 					reg = <197>;
-					interrupts-extended = <&pmicintc 78 IRQ_TYPE_EDGE_RISING>;
+					interrupts-extended = <&pm8921 78 IRQ_TYPE_EDGE_RISING>;
 					#address-cells = <2>;
 					#size-cells = <0>;
 					#io-channel-cells = <2>;
-- 
2.43.0


