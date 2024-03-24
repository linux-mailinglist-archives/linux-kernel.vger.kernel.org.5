Return-Path: <linux-kernel+bounces-115915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923048898A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F791C31E28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841AD38A95A;
	Mon, 25 Mar 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWMJrYnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444F1482E2;
	Sun, 24 Mar 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322101; cv=none; b=WyJDR2jve6IMKqgmtLGgLoilTlHIA1IkyB03J9restsB2fg6cuS+M6/ZJLp8ucZmjvlFqWsATPr8xAgJ6hI5Gnmz98zU9ztld+C1m5PP5mYTZ9wcrbka8KjEzuZOhqjaWsMi1EOSq74ltN20Hjt6jeQgwouVSsnet2VkN7NsIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322101; c=relaxed/simple;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpqDSS79V8GFGPX6Pi6D4xeJrawJiE+ATCwSVSQfbk5/zmBEMGoYRRrtq6+ZqDfkC1eC74qqmrnJ6eLbOvmZ3BtRrB1No01e63zTSyPdkf5mfB6oO892rCeu8xP+dSwPuA2GxEUntZCQObZh9GTouSR5lmNMesMe37x0XrOvW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWMJrYnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB374C433C7;
	Sun, 24 Mar 2024 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322100;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWMJrYnwYoSV6o5aFJRkD3htWpEPgEkU62uAx3gA1WCr31kwZTqi4ROP1hsADA3QT
	 4mIe8cmgn3SkF6TGviUS7+PwSMHe7ETU/0Ju5bR/s9O8HKon23oB+VYbzLuiv4/rfS
	 rF3R13EwONV3u9n+o2ivEWa23X+V3d0I+3y6QGtiI/+IFDfAMtAGBcGJ6YENpdUNr9
	 tcHBlXFXl9szD2IhPYqEcjiv8B1d01HJ4dI4JWbcWDLZLSAQ52RKtvACp6U0eqftn6
	 Mb1PQnjSJdepmOct59qC72DbOeKj8usSa0wI9CAD1WoS0RRZ+n+0WDllbi6G+wsH4F
	 y56/W6qMHPRCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/451] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Sun, 24 Mar 2024 19:07:31 -0400
Message-ID: <20240324231207.1351418-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


