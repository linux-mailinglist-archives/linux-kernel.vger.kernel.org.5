Return-Path: <linux-kernel+bounces-133502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30989A49A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD5A1C22D98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9893D174ECE;
	Fri,  5 Apr 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXRjSfTN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA308172BA8;
	Fri,  5 Apr 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343892; cv=none; b=b6l8P7h1E+K0ZBR+iXL3BObzLO56Xu7hCDFgf2688x/0KfgBa4S3Wxlf/LdtNVp1rhHedlwO2fR1foddC6rats2bKLfPhe3xwWzC7GmZEfomjCUe43D+CO31VRSBJRnCZ+xWSHpzokYD8m+b9szk14BTlQ7cFfI+sKlPcyE31aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343892; c=relaxed/simple;
	bh=kl4IBGAeN92GKiU9xTK5c4s6q/xqFWZru2zTgyoG2Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raD9zpGWtd/YdZ2OPRhJhRJyoEF8UK+rfTzgj29xt2MY3PF7VPw4PK783Su7ym36A/zGNArb6ZCIHQXyJ8dviTw9kYWSZGjAPDYrJO730iPO2v5tNXKF9NFCL56bN8DWs0oo+fUqrwOpat+1EA2xcU0KKyI1ljZQ1EE0z0PcH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXRjSfTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7B7C433F1;
	Fri,  5 Apr 2024 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343892;
	bh=kl4IBGAeN92GKiU9xTK5c4s6q/xqFWZru2zTgyoG2Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXRjSfTNIdtntMaq3Z+Z6Ah/e1tAvyxELWy7JT//08nBWwhWDo7JaNunE95vx5Mr/
	 amGl7DlV06L3ja1HtK3M5Z9Mq1FA8xbXdtMFbls5vA+1TmAOCDb4y5Fs/C0MlLUm0o
	 1B8fjS2logm71203cnIWyrq2nR9cX3Q4WHpOkwv+5pxLI+Ts20W927EXsLaoVHb9OZ
	 A/juhYjfnWkSqKkHIJfkMONvqLgxowc/l+CPxPLmr1Ht/dpAZzKqbwL4fN9nakIcm1
	 Wp6QSjg0ibDFgIwMLM97qXGjxCmr58Bk9wA+BVB2D/mjBza1/zp6XZNkfAGlA6Vpfj
	 ACrA6geufKrYA==
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
Subject: [PATCH v2 05/10] arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with bindings
Date: Fri,  5 Apr 2024 21:04:14 +0200
Message-Id: <20240405190419.74162-5-krzk@kernel.org>
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

DT schema expects node names to match certain.  This fixes dtbs_check
warnings like:

  sparx5_pcb134_emmc.dtb: i2c0-emux@0: $nodename:0: 'i2c0-emux@0' does not match '^(i2c-?)?mux'

and dtc W=1 warnings:

  sparx5_pcb134_board.dtsi:398.25-403.4: Warning (unique_unit_address_if_enabled): /axi@600000000/i2c0-imux@0: duplicate unit-address (also used in node /axi@600000000/i2c0-emux@0)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
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


