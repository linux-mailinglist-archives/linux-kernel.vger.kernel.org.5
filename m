Return-Path: <linux-kernel+bounces-133507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3D89A4A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7301F24BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FE17556B;
	Fri,  5 Apr 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFpJZj0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E484172BDC;
	Fri,  5 Apr 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343923; cv=none; b=MrSsqyqC1aJekQS/jgz9S2dh81477zhnlyV183iMoPx83BsWFwNg7rEWPM6/O9VXsSW+BDqrOra15HUw0FTtNhug2nDrebgYrsNrydRBMb5sU7+LAKBQK2Gnfhyrl1yvbdCLXYB0Oqun8RabKaNUFMwTXgS1V5ouo0cdHba0KK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343923; c=relaxed/simple;
	bh=jwxmmxNHFZOm86tID6RkRH1tX1Y9t5Sx2emFDKwZGDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwFMf8PqQdI37dEpg8ndIQibXzYWCBNgJMVIC5M8NLTIP5k+8YDx3Tiy5D8uudsnKBIa+OlM1jovbZjP2ujwBckVPBa+/HIOnzCV9Obc5Exb6xjmFBER67x04Bt9LBLh+K37TJYAu4RQbsiFYqc7lRXQd/m15x7r0ZkB1tuZTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFpJZj0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F730C43390;
	Fri,  5 Apr 2024 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343923;
	bh=jwxmmxNHFZOm86tID6RkRH1tX1Y9t5Sx2emFDKwZGDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFpJZj0cFqnA3xtAdQ5A3IihPPozY7ZroM/W+XV7jJOOCFEDG/3vWw8UNyZHXhX9N
	 AsuHMXy/Zp4BLim8k3H/8MNbCKSK9mMAokGnccHV0+9xlYcWx3nV59tRyDzj9RaZ//
	 7oTk8Dtg1XHW/Jh56MofSkq4xoaoWlUaNmNT2DRaJV2+KlAG3LeKTnOSIvVFRhwgMo
	 obYRr5RWf57V6hvY1AoTHGxl214PUGbGDxdeX+JPNpHq5Opl0fHrXrmgiULQrEFu+n
	 tBO/dQh9+MSTXUrORv2BMN//cK5iRra/Imne44nTbz8u3g/sJVOlxKMbULQGQ4gSMX
	 DWhk58TqTdVSA==
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
Subject: [RFT PATCH v2 10/10] arm64: dts: microchip: sparx5_pcb135: drop duplicated NOR flash
Date: Fri,  5 Apr 2024 21:04:19 +0200
Message-Id: <20240405190419.74162-10-krzk@kernel.org>
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

Since beginning the DTS extended the SPI0 in two places adding two SPI
muxes, each with same SPI NOR flash.  Both used exactly the same
chip-selects, so this was clearly buggy code.  Then in commit
d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node") one SPI
mux was removed, while keeping the SPI NOR flash node.

This still leaves duplicated SPI nodes under same chip select 0,
reported by dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:92.10-96.4: Warning (unique_unit_address_if_enabled): /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also used in node /axi@600000000/spi@600104000/spi@0)

Steen Hegelund confirmed that in fact there is a SPI mux, thus remove
the duplicated node without the mux.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware

Changes in v2:
1. Remove SPI node without mux.
---
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index 20016efb3656..af2f1831f07f 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -87,15 +87,6 @@ i2cmux_s32: i2cmux-3-pins {
 	};
 };
 
-&spi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <8000000>;
-		reg = <0>;
-	};
-};
-
 &spi0 {
 	status = "okay";
 	spi@0 {
-- 
2.34.1


