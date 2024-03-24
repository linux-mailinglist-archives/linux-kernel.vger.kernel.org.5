Return-Path: <linux-kernel+bounces-114202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4531B888913
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E0C1C27B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0831586F3;
	Sun, 24 Mar 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMqS4Cf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA08137914;
	Sun, 24 Mar 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321536; cv=none; b=nfZbwC8SyXG3uzp1uwYTuh3b18FUXSwhZeXjy1diV0+5zpttv7hM4P67rEK15i2WcQ56eHMEKgsXDbpevtLTd+G5QF7ZNKDxdNyq/Kkj1oEsYySm3M9O4A3TQexbKWyKyC8PEDmUBII8FzqIUOE/hlDDop5XJDEV576usPUV6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321536; c=relaxed/simple;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo2bfwKaHyGyEWZw9PMF2g3dkX5WJ5IHRDBdCRP/J06bq6lWwIuy8vLENL8ndNAgc9L0MNdLmB4XL2guzVbKM7yBDvn+WZpYg5wN+GInFDStw/Wr9FfrEMOiKfTy0dYTY5Y8ZrtNsDKZiaXwm/1SMriel9c1GDnY70I7dUSDLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMqS4Cf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64756C433C7;
	Sun, 24 Mar 2024 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321534;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMqS4Cf9zD8J2Bmio6ZM7rWv+1CBbUmtmL7VeJie1Ynn7vXTcV7iDzL5mGKgji7kK
	 XnNKNNchy5p5KLGapqDrJx6pfb/AqvHIjOZexIruzMWm29ZYY41GyXRvTdbFDF6Fcr
	 RhuU4Kr4HLGeeimSXqCLicNupc3L5dMmUtaxBJm4SNkVJGvYycalfebHmeb05yjvUX
	 XisOEMMMNMzrn0j9/eQRPsnrnwdP0LSQIUb5htWT+7m1LnNyt+3hN1mpTwGqO1yvms
	 d0tk0P2wx6A61yJswaXqrvnebkzIj3qLmkMo5CWXYBSlJublLE+9NbSMKT6SJ7J+07
	 V4Ij8fW4tlNDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 262/638] arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 18:54:59 -0400
Message-ID: <20240324230116.1348576-263-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7edbb5880dc3317a5eaec2166de71ff394598e6b ]

All Ethernet AVB instances on R-Car V4H have registers related to UDP/IP
support, but the declared register blocks for the first two instances
are too small to cover them.

Fix this by extending the register block sizes.

Fixes: 848c82db56923a8b ("arm64: dts: renesas: r8a779g0: Add RAVB nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/83437778614a7c96f4d8f1be98dffeee29bb4a0b.1707660323.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 0c83940b3d8a1..d7677595204dc 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -767,7 +767,7 @@ channel7 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
@@ -814,7 +814,7 @@ avb0: ethernet@e6800000 {
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6810000 0 0x800>;
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


