Return-Path: <linux-kernel+bounces-126810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DB893CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620EA1F22AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385F4778B;
	Mon,  1 Apr 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFRKQa4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A14C62A;
	Mon,  1 Apr 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985888; cv=none; b=bn2/iKUAMiyA0ZKYvoXtmRhlM6nzpfJB7QDZ4WfYcrTnqCSPpW08/eaX93a9gFzt/v8NjZYRZBLqar/7IFjPXag0A56SGqKn0ivuaA427KamjTkhFhlngkR5/PwGM+mmAYWE7MhNH4otpsnxfYJlCndk5N2kqMktvsBZcydsG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985888; c=relaxed/simple;
	bh=1zF10p+hIOOzeGD/w2eifp2BzHYMkKJyko8PrOd/szw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADWZ7fAdQQsUf02extZiYBL/gv1tI5RUQJexXYE2C5ERxc7goKxcRzUiulHIywS8Dy6+OXcLksjaTv9XZfQdL73ZnY+tvNfCEGqSnsLjTucRfMv6SmsflhNk6aDUwV16iaknOn1c5ogsOCQmZbUcWh1srH88sKnyNsldbhq5EU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFRKQa4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C82C433C7;
	Mon,  1 Apr 2024 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985888;
	bh=1zF10p+hIOOzeGD/w2eifp2BzHYMkKJyko8PrOd/szw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFRKQa4Iy1sbx3ViCQAhaFMKGofoa6+TvIEnAgQixYAsBa3o3lLfERIpvzN1M/j2U
	 hHzws3RAYU0QPpKLDLfy+tL2ImIaQNqKH7LzrYnFbhgP5yFSgoDvf33gKPJWHQiZXE
	 Pwd8fVW4G93VFw0h8wNmXNbkwZZ9/1Yx9DHUMEZuEu+uLyxWGaj9pujbaOu08cpm4f
	 7RBevZ72M6Pyj3Hqr7p1416ZHnXLquTLYu7k2cytMxvxIIZF7Uu/B6MI+IemI2XOxB
	 +e/3SsOZtqeuhyqM4DDTiEIkLXVU+9ISvZvJJpqLz30QRy2P7X6U1BGtsrgKBQjapx
	 XjvsK5ixJXNeg==
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
Subject: [PATCH 05/10] arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with bindings
Date: Mon,  1 Apr 2024 17:37:35 +0200
Message-Id: <20240401153740.123978-5-krzk@kernel.org>
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

DT schema expects node names to match certain.  This fixes dtbs_check
warnings like:

  sparx5_pcb134_emmc.dtb: i2c0-emux@0: $nodename:0: 'i2c0-emux@0' does not match '^(i2c-?)?mux'

and dtc W=1 warnings:

  sparx5_pcb134_board.dtsi:398.25-403.4: Warning (unique_unit_address_if_enabled): /axi@600000000/i2c0-imux@0: duplicate unit-address (also used in node /axi@600000000/i2c0-emux@0)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index e816e6e9d62d..cafec6ef0d0f 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -395,13 +395,13 @@ i2cmux_11: i2cmux-11-pins {
 };
 
 &axi {
-	i2c0_imux: i2c0-imux@0 {
+	i2c0_imux: i2c-mux-0 {
 		compatible = "i2c-mux-pinctrl";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-parent = <&i2c0>;
 	};
-	i2c0_emux: i2c0-emux@0 {
+	i2c0_emux: i2c-mux-1 {
 		compatible = "i2c-mux-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


