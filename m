Return-Path: <linux-kernel+bounces-126809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F262893CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D151F21E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A254AED7;
	Mon,  1 Apr 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/7RV7tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7E4AEC1;
	Mon,  1 Apr 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985884; cv=none; b=mTD7p5krU9NURun4xM4F/VNwjLbbMIa76yIA8hyUL0+WSDJ8uEn11ndxdvmE/fpuerJg9Kfv4svGWBfQu7HvrSSVU7Fl4Jr6osAUsYPrnn9S6x0ByhHmI38Zg0yFfrO7R0Hln8F1n4whK1aIE3KA0RIRpD/iK9GXWXGraouIDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985884; c=relaxed/simple;
	bh=7q2xemqspPBXGqChYMZhCMJo+TfcjIhLABlWs+4+z6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiJcmEeN37VsjcP9vkY74A48n6mtTLMwpcFCmINT+T9CckrPYGzDHiyXy/5qBrcmYeSWyNWHqAmtLObYrEz4iAzvJINpjBAsAZ4w44eFYbadTElpi8idXLs6pbFzGxATbnsz2iWPRAVSXUEIQKbn6B0R4a3PDFM4G0+XeN6LO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/7RV7tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B917C43390;
	Mon,  1 Apr 2024 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985883;
	bh=7q2xemqspPBXGqChYMZhCMJo+TfcjIhLABlWs+4+z6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/7RV7tnvuRxXD/7aC0U0dHeA3MOsEZGaehhbvz8of2m2cvadYZRe6b2NkUEk1iLz
	 dMUcov0ZQG5B0J9/VTBI7cPuzWfsx5QxkS9I+EdJsYhWFx/38rZIeKcbHf07RbGjqN
	 GCmzV8xW8cyo8xw/3UyDdwvc5iVzG3JkilY4VOT0oiNoJHZ1BIHkYp/40RLPi/ZyD6
	 CeczHEIedCrwO7nZ5NM0RMz499G+B+RFOeai7MOLp9H4yFlhmiTIhSU5NrDFmfe1rj
	 P0oH4V7EbQC1JInpiGDJea7H6M8EalyPR3hQiK5E7ggWIkC27aHYabK2zQX+maSczt
	 x89CId9+14dGw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 04/10] arm64: dts: microchip: sparx5_pcb135: add missing I2C mux unit addresses
Date: Mon,  1 Apr 2024 17:37:34 +0200
Message-Id: <20240401153740.123978-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401153740.123978-1-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The children of I2C mux should be named "i2c", according to DT schema
and bindings, and they should have unit address.

This fixes dtbs_check warnings like:

  sparx5_pcb135.dtb: i2c0-imux@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c_sfp1', 'i2c_sfp2', 'i2c_sfp3', 'i2c_sfp4' were unexpected)

and dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:172.23-180.4: Warning (simple_bus_reg): /axi@600000000/sfp-eth60: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index 82ce007d9959..bf51a6e11cf1 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -146,22 +146,22 @@ &i2c0_imux {
 	pinctrl-2 = <&i2cmux_s31>;
 	pinctrl-3 = <&i2cmux_s32>;
 	pinctrl-4 = <&i2cmux_pins_i>;
-	i2c_sfp1: i2c_sfp1 {
+	i2c_sfp1: i2c@0 {
 		reg = <0x0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp2: i2c_sfp2 {
+	i2c_sfp2: i2c@1 {
 		reg = <0x1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp3: i2c_sfp3 {
+	i2c_sfp3: i2c@2 {
 		reg = <0x2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-	i2c_sfp4: i2c_sfp4 {
+	i2c_sfp4: i2c@3 {
 		reg = <0x3>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


