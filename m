Return-Path: <linux-kernel+bounces-113154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDB8881E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA371F20EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7759B40;
	Sun, 24 Mar 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5XBNmww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F258171E6D;
	Sun, 24 Mar 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319957; cv=none; b=c2NTHh4xrMFixFu5BMuwAp8aSDVmvyJf4TrWVjli8EImzCNWOFoAwGpgFkxGrIDu50Zu3Xws8sXYnkMUSWE53WvPOHyNyCv+bY2rkMsexqiK14N6nTgS9pGujIgNGu5Zwy0uHL+c6/761P3m+1+JGPdCq/gaESUyhp/VFU5TN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319957; c=relaxed/simple;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi53VkEsuRisT0jLxe/i+0OgE+2K33XdDagXbo19EiDd7+e1rl0ctcDz23yscTDTF6oIiqc+vdRjZwdkNGY+Rh8bDkfwfhtm2Fiu4igwN7lPcV+eEjMtg2xcwBdcNvCHoSSSDUtyzOjn+6PCsrAJ+TaXS/wdoK8zOgxZvzyq+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5XBNmww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05496C433A6;
	Sun, 24 Mar 2024 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319956;
	bh=PSfaJaGHfeh9RYxvNOEV3FNhCqWgQCV/Di0zLdoOfeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5XBNmww75W2Lkl/E6NK+LmmFY9UYqDSxQk2n2yJ44lgtAUTHaF3gjV7CIeKgQWGu
	 w16R3Cb3GAUVITSUPbCldUNfWIZyfzbzMKafIlvlLIUN6dDYjyhzgHe+Gwj6cYZOAT
	 e8ZwXrcARFjOG1cJrFZmINP4/rRGhQOBzjK/KEW5TEMSW2cH0B9Al4SqGIAIMstop4
	 b7uYKK+afXKTa28iGaJCcEV+rz4AvXosKJo58DMqrRl6IQlQEqwa1Vv9c0lo5rGYhc
	 jFbqAu1kVAMcGTd5UOLqoL0vvEn9P3iIfyhyJcnBjdR6+M2zTWx3yRwQ/Z6GfhMcde
	 ejVFewfbOIZ0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 263/715] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Sun, 24 Mar 2024 18:27:22 -0400
Message-ID: <20240324223455.1342824-264-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


