Return-Path: <linux-kernel+bounces-115656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A3889D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F0C1F30235
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335116AFDE;
	Mon, 25 Mar 2024 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6uzc96q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03542081DC;
	Sun, 24 Mar 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321538; cv=none; b=VUmeFvCtVLP2PQS1RuL67UZcM7n8j506SR74eYvZxTKucItULk46vCAYAztrlcMfrwW/HroNFYZAOKfK/zX5ceJ24nYkZVuFZv0dG/1qonCr/ax2wHg00ms8nVf/8scNouSa5glLCF881+PAUA8ETVgi0LHJc5O8Gwgl9fRSYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321538; c=relaxed/simple;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKpZxkxQlhFHpauQYN0rSb6+Hsull7X2l40gT4bxw+rm9EnafqfsEBaCT7dIMIEJTc0ZEBcwINJ9xiAHaFoGks/0GeAZLHZZMhzI8PIUo9l6EEY0Fk1tNHyjTcxxC52/PrCdKz+BHneHZ+Ceh25cQVJLlI2J0hw33uQfAWFPUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6uzc96q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A833C43394;
	Sun, 24 Mar 2024 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321538;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6uzc96q7+idQJ76ZOcqXXWYFmAOGqI85rfmD3xZERWNTAD4XN7fgGQdwEQrV4ji1
	 lbbvsNSzOclNTOZn1Pnq8XVaOnop7cv2LFiOtMXt2L+wNVZIIc4VFjN/9dhXGQNFgA
	 rQpohrh4u0Sh4LmxcAa7uglZQNBZ/AMR933SATd/v4UGMbPvGkVSTPnIW14d+iKUoP
	 nsBODQ7u3gIjggBJp9rQXOwpOmPl5gcVIjet8kWyTEHhrYGPwFiGK/KXsOkXozNKXB
	 lRkw1R9qYGW3uM565k3tPJRMW29wwq5cZx64Qk7AXe6TYNNz/3XPleNcbkuNDFunCT
	 nglKmVrGQu9aA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 266/638] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Sun, 24 Mar 2024 18:55:03 -0400
Message-ID: <20240324230116.1348576-267-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 7b59348c11f3355e284d77bbe3d33632ddadcfc2 ]

The SPDIF hardware found on the H6 supports both transmit and receive
functions. However it is missing the RX DMA channel.

Add the SPDIF hardware block's RX DMA channel. Also remove the
by-default pinmux, since the end device can choose to implement
either or both functionalities.

Fixes: f95b598df419 ("arm64: dts: allwinner: Add SPDIF node for Allwinner H6")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20240127163247.384439-6-wens@kernel.org
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi      | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi            | 7 +++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 9ec49ac2f6fd5..381d58cea092d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -291,6 +291,8 @@ sw {
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index 4903d6358112d..855b7d43bc503 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -166,6 +166,8 @@ &r_ir {
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index ca1d287a0a01d..d11e5041bae9a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -406,6 +406,7 @@ spi1_cs_pin: spi1-cs-pin {
 				function = "spi1";
 			};
 
+			/omit-if-no-ref/
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PH7";
 				function = "spdif";
@@ -655,10 +656,8 @@ spdif: spdif@5093000 {
 			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			resets = <&ccu RST_BUS_SPDIF>;
-			dmas = <&dma 2>;
-			dma-names = "tx";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spdif_tx_pin>;
+			dmas = <&dma 2>, <&dma 2>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.43.0


