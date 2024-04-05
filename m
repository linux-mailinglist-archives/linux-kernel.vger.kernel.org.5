Return-Path: <linux-kernel+bounces-133501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A683C89A498
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A1F1C21990
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C60173353;
	Fri,  5 Apr 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSA2prRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538017332D;
	Fri,  5 Apr 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343888; cv=none; b=bk44zPZGXqMe++SYHs77vo2guGlQNVWrHo4e45o0Aayskusr1opeKgQLu7ghF7B7Mn1fJwtocqGnB0cEBaSabEaMWZrsdeVP7kmelfYX+4WU3i7NAjREPM8csUsG1Amqj9mLND6HiWi8x01aIKn7DbpJaTS0PYKm/H9iQp93Aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343888; c=relaxed/simple;
	bh=6fED8l9iwg6A3Xri4TQG3WFbGK+YljXc/s/W0vXEeWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0g0c4895s0ACrV7xwY9tzGVR17WbCD7w/ovnkdS4SmJAYmCx6f86uh06JjYUgoBNGAI1rZwngluEU3urxK/UTHpS2K+d58AuFYvFxt4uGRFzmIPvqo1WTP+3DJSpLV1DeHbLj/Ixll+K/ft4uCokv1TF/3LkowTxdGs05/wrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSA2prRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB650C43330;
	Fri,  5 Apr 2024 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343888;
	bh=6fED8l9iwg6A3Xri4TQG3WFbGK+YljXc/s/W0vXEeWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSA2prRh3myD93qHIZl+3319MM/V3DFWhTP6eEa5FfdMCa8QzynhTz4VedeEKt7dt
	 RJPAF89uOt4xr02tFX4NwLLvPhITnkuGZPsuIn04jzSE5sGCWyx25hd2uh1/miAN8+
	 QZLQMMcZ+9ZNOMLJYrxYI7kkolFUcg3UGRcdgHSr37hxTtcxiFLDWWP0oA7DiAd4pe
	 jKmeGJTvnf9mAcc0EDBuWlFmGYaaMMMPFH5Uze7x1bvSYeL6vDG+3mtinMdtFzsldf
	 NKo8ZeObGiXx1+dLdUgSPsBf0e78qWrXvO9LnXmc7Qnp40h0FsjqRBSE298hSF4qOT
	 rmBwb8aIiedAw==
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
Subject: [PATCH v2 04/10] arm64: dts: microchip: sparx5_pcb135: add missing I2C mux unit addresses
Date: Fri,  5 Apr 2024 21:04:13 +0200
Message-Id: <20240405190419.74162-4-krzk@kernel.org>
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

The children of I2C mux should be named "i2c", according to DT schema
and bindings, and they should have unit address.

This fixes dtbs_check warnings like:

  sparx5_pcb135.dtb: i2c0-imux@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'i2c_sfp1', 'i2c_sfp2', 'i2c_sfp3', 'i2c_sfp4' were unexpected)

and dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:172.23-180.4: Warning (simple_bus_reg): /axi@600000000/sfp-eth60: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
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


