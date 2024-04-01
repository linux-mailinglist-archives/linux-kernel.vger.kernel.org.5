Return-Path: <linux-kernel+bounces-126814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE7893CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37F01F22AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287354F200;
	Mon,  1 Apr 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvCtQKXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FA4F897;
	Mon,  1 Apr 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985910; cv=none; b=Q5FGoeCppYwItcXYnnkHeADl9Ot7wRg+6souu4bUDrCkPQlJOSsBY2F+jx/WR0k4wB9qEMzE8ov9ICxOFnLWfI4J9LvXg5RBiqNJoPdHUaf6PAEIzZ18KlOISfeLqsL8aFaCjMyBRIUxW/blkT2I/eCNdqxuZlWzEUUXbFeek8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985910; c=relaxed/simple;
	bh=aCit6vORDAYB870bYOiXT5ndGlqhSP/fqB0fbs8e4P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4SDv0PxR2XwTjQgMM3RGUXoFEZPzpkxzElXW5mLngmC5rdfTXwevqT3EsaKgzsL+IBopa1hVFpZ7Zd07Oey4bxWRIyIhu70SdsbAKUiXzzawoE97Etu7oaGs141enyizs5T0GYkr764j6VMh3tfMxSHMta9xNdjDoGlnrUayXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvCtQKXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B5C433A6;
	Mon,  1 Apr 2024 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985910;
	bh=aCit6vORDAYB870bYOiXT5ndGlqhSP/fqB0fbs8e4P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvCtQKXE8ZHNsVUuGOJRaM7sOvx5VVg+yyHmMZ9kkhIWh1IWHq5UKrBdigG6sks2X
	 WLH60WjmwVHrb3BUQnmySGAHzuDBNG6Pl9bIFZDmc5H2D4XBenV68YNIk2y32z2lZQ
	 DhI2or0xTlJXdD73Uv4/Rs4LlwzCz0dd/xjH185pmsBk90Zaw/+Eo7MYoDYmTUt4vY
	 BI4gobZV/Jvhei8xhYYoAqK3AD/+JIL065ZlkUqaE6ohq+CLA3PGa8hDxjd83PJ/Pm
	 N+rEAUUlPQS6ObspFYY6K5ztxZnAGboevD75NJQj/hlMTSjw/jWlTAW2mwzfvL0wC2
	 4jccThBFhXA1A==
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
Subject: [PATCH RFT 09/10] arm64: dts: microchip: sparx5_pcb134: drop duplicated NOR flash
Date: Mon,  1 Apr 2024 17:37:39 +0200
Message-Id: <20240401153740.123978-9-krzk@kernel.org>
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

  sparx5_pcb134_board.dtsi:277.10-281.4: Warning (unique_unit_address_if_enabled): /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also used in node /axi@600000000/spi@600104000/spi@0)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware
---
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi  | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index f165a409bc1d..dc7b59dfcb40 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -281,22 +281,6 @@ flash@0 {
 	};
 };
 
-&spi0 {
-	status = "okay";
-	spi@0 {
-		compatible = "spi-mux";
-		mux-controls = <&mux>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0>;	/* CS0 */
-		flash@9 {
-			compatible = "jedec,spi-nor";
-			spi-max-frequency = <8000000>;
-			reg = <0x9>;	/* SPI */
-		};
-	};
-};
-
 &sgpio0 {
 	status = "okay";
 	microchip,sgpio-port-ranges = <8 15>;
-- 
2.34.1


