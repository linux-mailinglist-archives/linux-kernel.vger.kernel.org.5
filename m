Return-Path: <linux-kernel+bounces-133505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47DA89A4A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BFD1C2214A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CF175546;
	Fri,  5 Apr 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV899Q2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA5172BD2;
	Fri,  5 Apr 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343911; cv=none; b=VZqzH+DLWnnsGNgHdDI6wSHZWrYixMt8ZFUvmGrNZR+UHccI3lA2gYrJnq1YK8wLHzqwa4URd74pVYsZUGs/4KQZR2bJkR0STIJPqZSvCH2mPitjO7o55FKnrpa0lkT1w59/z20bU4w2m8e6/Jk/w+HB/O/XvAT8Dx76IRhkzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343911; c=relaxed/simple;
	bh=AdnuFky/1/2v3ByLIl9yjD2A3egAmo1Dae2iLqRUlTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZscdDP3MpASctL4qAHe8sZ49I+piqA0+DSTiPDZzhs4bJMU1b7r9soMecqGUBK4xGbTFZlKYA11Pb2XWiG5x2JpF9MXJ65prIB3KdWXAV8vrMYlWRzGEENhoGuzVAeCqTX21/BkQ5Eh+2GD8Lac+eieOXLsMJl6Gje3XtzXKItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV899Q2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597F4C43394;
	Fri,  5 Apr 2024 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343911;
	bh=AdnuFky/1/2v3ByLIl9yjD2A3egAmo1Dae2iLqRUlTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BV899Q2ZvFTgHPQpP9Fz3pCpUO9M6f+p2ugGaRW0D4vZF/rIw2EExfDyXI39k6FgA
	 Fo33f+a+7f8ZBC7A1fTl3flsoE9GfWPSgwVL0+AjbPU+uLFGwwbmJ6u+2lrb15lEli
	 JVmvMgNrsDtjoWrI+15itMoW75Q/haczLQpup9xUgIEwlLeIfEY5K9LGV0E2ZH9Uzp
	 Ic04q/ILn0/WVKTZqfMSdaMYdgBGlBcaa8MvY2LUphNpBXCAhamT8Ml9cIovwqWyxc
	 hjgaKKM4/kTiSpf6zSHZh1GQ277ldKNOsYg6f5xgn670p+QabclstiTeuAFWeYy/fG
	 bqfbIA87CZAKg==
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
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 08/10] arm64: dts: microchip: sparx5_pcb135: drop LED unit addresses
Date: Fri,  5 Apr 2024 21:04:17 +0200
Message-Id: <20240405190419.74162-8-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405190419.74162-1-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
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

Changes in v2:
1. None
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


