Return-Path: <linux-kernel+bounces-126813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C993893CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EA81F22AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E84E1D2;
	Mon,  1 Apr 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1hBbmB2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BE47A73;
	Mon,  1 Apr 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985905; cv=none; b=PHc3o57OuILhj7J+0HgFHz+aRpQ6NLfrKm/PcLlHOdR7yRTc3uZ4Z7sv9Vk8zg04WF/iOdtDX4FjzuieDy/wv6qlKbrlykHq9aS1ZeDK8wll6TGukOrWmPbvhTsIqUtysg9y4bdAVBboCTTPvdo0iwIckvjBthJdLTAlYCiSHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985905; c=relaxed/simple;
	bh=aRw2iio3uiL4eDYVF2hmmTE3SOu9WI8o8O9ayQO3YVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MssaqpqNCkxNDbPh+XfcXkA3yACDLxNjY3K96gXR72ewLrFvywNRrxbVRj7jPoiNGc7YooP5RJh0sazjkLPbmY1P3XChggH6UQ3MhQCbRuICANGMr6vuiHetim5WCgpz9Rt/TjuTvqAM1lJN4iGuCvxThvJfplcB2BjmutKA5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1hBbmB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0807CC433C7;
	Mon,  1 Apr 2024 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985903;
	bh=aRw2iio3uiL4eDYVF2hmmTE3SOu9WI8o8O9ayQO3YVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1hBbmB2kd+CsaCj2u+Mwi7lwFvMT3EwrQGoCICZ7z51Dap/xipIGqlpdmQ46hcPO
	 8Mpd7T5zehelMiO5cmFR0tjU4MGMm/N/8KmjwWsgOv2b42LmC65jXtNNSw/i7v+qXT
	 oHN9AOSGPIGL10V79IoaTZZWL5Jc/Gduue9l370W/2Sb0H2YrFdSUKmieTjt5LoOMl
	 krkUSKxPzictiJxThP8qTJlCM0CA/JX5+cq1QfRNzG5UCp1visoEPvQR34PwYxQNZl
	 RRcdlqUtvlWzwkpIWIRAPK5HlR0fuAqwcFZYBca0kKttpN2gTBSoPaZXNeLoFd82K1
	 s1H3A//wntwhQ==
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
Subject: [PATCH 08/10] arm64: dts: microchip: sparx5_pcb135: drop LED unit addresses
Date: Mon,  1 Apr 2024 17:37:38 +0200
Message-Id: <20240401153740.123978-8-krzk@kernel.org>
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

GPIO leds should not have unit addresses (no "reg" property), as
reported by dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:18.9-22.5: Warning (unit_address_vs_reg): /leds/led@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index 860975ffe0a1..20016efb3656 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -15,42 +15,42 @@ gpio-restart {
 
 	leds {
 		compatible = "gpio-leds";
-		led@0 {
+		led-0 {
 			label = "eth60:yellow";
 			gpios = <&sgpio_out1 28 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@1 {
+		led-1 {
 			label = "eth60:green";
 			gpios = <&sgpio_out1 28 1 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@2 {
+		led-2 {
 			label = "eth61:yellow";
 			gpios = <&sgpio_out1 29 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@3 {
+		led-3 {
 			label = "eth61:green";
 			gpios = <&sgpio_out1 29 1 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@4 {
+		led-4 {
 			label = "eth62:yellow";
 			gpios = <&sgpio_out1 30 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@5 {
+		led-5 {
 			label = "eth62:green";
 			gpios = <&sgpio_out1 30 1 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@6 {
+		led-6 {
 			label = "eth63:yellow";
 			gpios = <&sgpio_out1 31 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-		led@7 {
+		led-7 {
 			label = "eth63:green";
 			gpios = <&sgpio_out1 31 1 GPIO_ACTIVE_LOW>;
 			default-state = "off";
-- 
2.34.1


