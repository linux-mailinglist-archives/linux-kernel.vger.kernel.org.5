Return-Path: <linux-kernel+bounces-27782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DC482F5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2919B1C20B38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7D20B22;
	Tue, 16 Jan 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2ak3oW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E220B0E;
	Tue, 16 Jan 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434188; cv=none; b=V48kV0BimGqOrURK5sKtEm5RCM3msbaesvTA9rR7XJhwpeNLFeI+R7h+8QG4QJBPjV8eopYp99SHNaTWZNMhXNqj86My7YsxRvyyLrbi/lAY51pYcZcooVVbucC59vbbNwpeL0F6OW50Pih+P9VfFU4XHSsbupEfc+dW+EgrMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434188; c=relaxed/simple;
	bh=PvkQu7hnWEMWKWtvMiUHmMo7pn2qNOuCciykCXtXZbQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=E0Uq+5PZL5Hr+Zw7hikb+QCWaLvf5hgH+KGcMICspd+2RhjP+sRqCk83lU2ubnZOvWYpkGamYqTW7gD5yDXGLjsXTeq3obqGit4VkEtOZM2lU+fSPZuyplEc/nFvdQH5uqnYRILadQ0ri4wAihVgjwjBZQwAqdhZ9OBLLzCtAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2ak3oW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264A8C43390;
	Tue, 16 Jan 2024 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434188;
	bh=PvkQu7hnWEMWKWtvMiUHmMo7pn2qNOuCciykCXtXZbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2ak3oW1LDw/eRrg9p5Llhdx93/5peViVwZZmFbc1zCEjLKQxpMlS0MSJdhbxZJsp
	 a6HEgNBQfFuOVwJdmxkNl8rrI/+kTrP2KgdGsQZBpVkbrnBzv8JQJdxvfrNZYoKAkx
	 BXEosrDzCWAPjZx6ZXiE43aRK+M8TLO5x1tpviCad8/trHIZ77J+PDcPW0h94fInev
	 aAISSyp/TSeiF0IeRlHhg9sbpmVqCphbAxK7PooUzT4wgbYV/i457Z0ead5A2UiM+x
	 7X2uuW6Ov/NTQFk/GgjEnAGAdNs0iEzoDQPnno0/N9RnaWUhIpHphvXSNcIjsXbzjj
	 EuOF8qjtorlOw==
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
Subject: [PATCH AUTOSEL 6.7 012/108] ARM: dts: qcom: msm8660: fix PMIC node labels
Date: Tue, 16 Jan 2024 14:38:38 -0500
Message-ID: <20240116194225.250921-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit c6d86aa8a12194d1c9c2f9108910a46c8a3ddc90 ]

Change PM8058 node labels to start with pm8058_ prefix, following other
Qualcomm PMIC device nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230928110309.1212221-11-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/qcom/qcom-apq8060-dragonboard.dts   |  4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi         | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
index 569cbf0d8df8..94351c9bf94b 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
@@ -71,7 +71,7 @@ cm3605 {
 		/* Trig on both edges - getting close or far away */
 		interrupts-extended = <&pm8058_gpio 34 IRQ_TYPE_EDGE_BOTH>;
 		/* MPP05 analog input to the XOADC */
-		io-channels = <&xoadc 0x00 0x05>;
+		io-channels = <&pm8058_xoadc 0x00 0x05>;
 		io-channel-names = "aout";
 		pinctrl-names = "default";
 		pinctrl-0 = <&dragon_cm3605_gpios>, <&dragon_cm3605_mpps>;
@@ -944,7 +944,7 @@ irq-pins {
 	};
 };
 
-&xoadc {
+&pm8058_xoadc {
 	/* Reference voltage 2.2 V */
 	xoadc-ref-supply = <&pm8058_l18>;
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index 78023ed2fdf7..9217ced108c4 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -80,13 +80,13 @@ sleep-clk {
 	 */
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&xoadc 0x00 0x01>, /* Battery */
-			    <&xoadc 0x00 0x02>, /* DC in (charger) */
-			    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
-			    <&xoadc 0x00 0x0b>, /* Die temperature */
-			    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-			    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-			    <&xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
+		io-channels = <&pm8058_xoadc 0x00 0x01>, /* Battery */
+			      <&pm8058_xoadc 0x00 0x02>, /* DC in (charger) */
+			      <&pm8058_xoadc 0x00 0x04>, /* VPH the main system voltage */
+			      <&pm8058_xoadc 0x00 0x0b>, /* Die temperature */
+			      <&pm8058_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			      <&pm8058_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			      <&pm8058_xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
 	};
 
 	soc: soc {
@@ -390,7 +390,7 @@ pm8058_keypad: keypad@148 {
 					row-hold = <91500>;
 				};
 
-				xoadc: xoadc@197 {
+				pm8058_xoadc: xoadc@197 {
 					compatible = "qcom,pm8058-adc";
 					reg = <0x197>;
 					interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
-- 
2.43.0


