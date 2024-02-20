Return-Path: <linux-kernel+bounces-72962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9F85BB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7D1F213DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270167E98;
	Tue, 20 Feb 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="Dod3ezI8"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264467C59;
	Tue, 20 Feb 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430250; cv=none; b=cekms1HH2OPk2wgM9dh2r/IQNtonWcABpTwjz4S+jHyDCsqrkEDfYxuYTZ1UqICKqKsqA5lDqZq1qA4NZh/zhzfXcUB1AtNChwOLri38RZ4+h2TJGEsZ1TIC8dd6f/K7O1cEESUHY6cMuP43DqvQOXeTWmdGIsb+W7KU6pDBGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430250; c=relaxed/simple;
	bh=BzuLtBM8Z955dJErgJ+79DGZL/rifhrYOSOpQyKhbDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GV7bL4BxzA4qZXVq3LXRr5FlrQy8uGARrCmEyZJpJ7e/vInJ47xAKercddvrhKZc5Rit3WJt4BXrjw0DJe3bq7wuvP88a3mFTfnimm865Tku7r0x0IJBgm5JBGC4RH0ACVTKT2aHc+WRjoLo6e6kM2MKn60rz8nJbA076WZV9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=Dod3ezI8; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 9350341992;
	Tue, 20 Feb 2024 16:57:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708430241; bh=BzuLtBM8Z955dJErgJ+79DGZL/rifhrYOSOpQyKhbDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dod3ezI8NPNkKSgyjKhyoAEC3W/EwbKKvEAXC2uWJNCYUnv5hTAo3voBQjd+lL7wl
	 W8K8HT+Z46XdoLM9NqmhB2F0K8omb0VZMBQyIiTEL9xrDjcpaffzhF2tDL9c7x01+j
	 QbnxWIqB/XryCEj4NgD+p1vDEaH9/tTfnEi36hfwrXip4XJIry29LzVdDqyIOlNQ1V
	 iSIMvlOEQwRKDakdwwhQ2I/hyC9ofwWnv/EIJS6O2bV9q/62XdxSJ46l7ug4ecoMao
	 /LhUA9JSYhbbRihEZatFeVwQCAGdHJQzllPNVDIWgTpgqbChzyqYDnHJlsFWV3I7/D
	 /CGGlknIXD1qQ==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 20 Feb 2024 16:57:14 +0500
Subject: [PATCH v3 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-aspire1-ec-v3-3-02cb139a4931@trvn.ru>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
In-Reply-To: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=BzuLtBM8Z955dJErgJ+79DGZL/rifhrYOSOpQyKhbDM=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl1JOdjLtKA3uU7iIhdumgBqrkzI7Uw5sUxb96W
 o37TfbdKbKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZdSTnQAKCRBDHOzuKBm/
 dUbEEACAB+i9Da8rjWBs0JGWrRLqj/dgFcl7yoFZP4q9MMYU/DN6F5HoIeOeI4EG6bghw8BGzvb
 ANZsLaNzdoWYZ4IyfGvUKbp1lKtxHZyFhbv/gdl1+bZqjmi6aHtV53u048MgLtWEsfP/ROnTv1Q
 XMJ739Z8W5I9aR5LcKk9gJYonV/SE+LgeuXP5C1oVC3ajt9gXoB/JRZjEg2+x+TBrZczFH/Xi1l
 51iW7trLU6efxIanKJXiNH8XHWkq9i/OJFy81BEt29kcJlNl5s6bIiKLZXHieWetXwOdlKcS5mE
 JTDH+AluSkRFMEQZzmua/+IMmh8vKIPpLyIhDNFhsTrwQqIrutrZMvDb0zH+zG1OF4RzPeJwqKd
 26Cm3HtGflYycQon8BmK+9SRYHmP93iiBm5SZmxjjO6WSXCpbIEEtpjjXgA/j13Y0Wrf1jChrwv
 Xn9e9X4mOi/svkdQOYEiQkdphedPPpfHoBY7lyPZHLNo/+lOvLXd2ajkfiXH3z/PpWpZbztMy2m
 IEt6/XHcgZrhVRBYWfBPynsFMZ38YeSnAe8IMYsba/XK5xRbb9vbXS8K09qCtKHBIVLnofcHsBR
 sgxVTPFNrrzKvjRSYOcRvQbABf7iUoesJgAI7bmDMhMZS6A+M3pnfnoeLPLKJZvKbQFHb5HdGH3
 V/1jZDGBvnzXUIQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 5afcb8212f49..3f0d3e33894a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -255,7 +255,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -419,6 +437,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -857,6 +888,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.43.0


