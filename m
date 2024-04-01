Return-Path: <linux-kernel+bounces-126815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D0893CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E8D283040
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE784654F;
	Mon,  1 Apr 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjVuAT65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C451021;
	Mon,  1 Apr 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985915; cv=none; b=bvZncEItJZyYuEmtJdYBUzj0gqk/bKoPphWv81aQZ+pFlKi5Ev+TRzPQzp34I4boaKL+InY55y0nAp4K4TyiKA8EBPP3lkKvdLiVqvOQaC6S7UmSJZC577nRNkHa8lX+3W6wxacFblDx675hU4+BN0C/9GAAReTCFerB6tj51ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985915; c=relaxed/simple;
	bh=JgLPnjcMi+cgOhiaoTMdhKoBzbHBbs/okfQQvGNTcdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsAYIPjqvZ82ZBM1znHdvmXUukw7kyyb3jsOCzS9y3LZdoT3Xz2rnfHpDz7NkdJm1J1lI6HKcyjfxhEKb51k+8mqLUJsff3GVQt7kT86UctDZ9Y8yspUFh3DrLGUjBqnEpVbtQRqzGTcHLn2N+PUAVuSpPl9x5WNuMxa1IW/OZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjVuAT65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A64C433F1;
	Mon,  1 Apr 2024 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985914;
	bh=JgLPnjcMi+cgOhiaoTMdhKoBzbHBbs/okfQQvGNTcdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjVuAT65buqs99kvAaD4vV94P1Z5W+QmUpw+nssp3dWlIHCTFraFjdqPWWxVQRGw3
	 m3lUXSpzMVIk6ozny/7UwF2viG+zgGQtd+fGPLA4vaqg1C+8iVV+7wt5MofHNXZwW4
	 CoL6sFuScW9fV+I+45WhBZ/yg3rRAjXCHJvyajrbeOtHlmFwdouhYy1fqGwDq8iTsW
	 7WBET5EkFWOoZujUtfi0s4NpRcp5vk93+WdHm443aqw0rK7OU1bS8fbman6M4eOc36
	 pp7Dp6yOI1+ieVWPUXOj4hAvphsLiK/zsHx34SDS2WWQNAE0WWu6EJk+ynNlsteIH1
	 jX7CX5Zq5WG6g==
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
Subject: [PATCH RFT 10/10] arm64: dts: microchip: sparx5_pcb135: drop duplicated NOR flash
Date: Mon,  1 Apr 2024 17:37:40 +0200
Message-Id: <20240401153740.123978-10-krzk@kernel.org>
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

Since beginning the DTS extended the SPI0 in two places adding two SPI
muxes, each with same SPI NOR flash.  Both used exactly the same
chip-selects, so this was clearly buggy code.  Without checking in
datasheet, assume device has only one SPI NOR flash, so code was
duplicated.

Fixes dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:92.10-96.4: Warning (unique_unit_address_if_enabled): /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also used in node /axi@600000000/spi@600104000/spi@0)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware
---
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi  | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index 20016efb3656..d64e642e3873 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -96,22 +96,6 @@ flash@0 {
 	};
 };
 
-&spi0 {
-	status = "okay";
-	spi@0 {
-		compatible = "spi-mux";
-		mux-controls = <&mux>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0>; /* CS0 */
-		flash@9 {
-			compatible = "jedec,spi-nor";
-			spi-max-frequency = <8000000>;
-			reg = <0x9>; /* SPI */
-		};
-	};
-};
-
 &sgpio1 {
 	status = "okay";
 	microchip,sgpio-port-ranges = <24 31>;
-- 
2.34.1


