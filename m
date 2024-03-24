Return-Path: <linux-kernel+bounces-114213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24D888FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A26B2A0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747D251169;
	Sun, 24 Mar 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAHubKPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06920137936;
	Sun, 24 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321553; cv=none; b=EuckhKTqLniqPl5ysGflEy8qW7T8wS9KZKt5dOguMIj4naAeV3E3m3/45Kr0jtHkOPWiCwYqi071EOehaiHY44KgpUbZpvr9Ppy5XVHKpdK9nKlApJ4G0qQ/rQCGGRmF+DTGdoWhvXj2yExWW6mtdKr9NROTQ6h/Ja9mpP1x/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321553; c=relaxed/simple;
	bh=fEwnBI35cXTjGoBBgXolNQPB6xmc4Wr8Ex5Lp9+T2DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqVUGeNEBpqYc1rEgF1/ah3PXhtYOECqOeAcFemL10S0QpMptdQS7io2vcMU2aX7aKEA4aHK1ABTt6lMULBMmz59MrjFPMuLg8WfIaiSD416o/0p2jdpDpmJwif6HStiR6fqD+hIsErzciA/FJHFjtzOHHQqNcpepOb8HQbNeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAHubKPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020E9C433C7;
	Sun, 24 Mar 2024 23:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321551;
	bh=fEwnBI35cXTjGoBBgXolNQPB6xmc4Wr8Ex5Lp9+T2DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAHubKPMxnbdN901JwDofDfaaonz3WdiYhPnHre3TiHEWFaferRCgBjS4fU8BmuYb
	 j6wd7PfFsMtEQuWXQRBFUTL2deYcMCeKTHaJgpCXOmDVd++GnbDcbYGISGk+LmvBti
	 Pv7H5mvIYFuQtT8h3KtnwyJPFY6S4v+seqUlAFB05p37EujbCz1XXctryWvClV0QTZ
	 /bBcVKU0hNfYFN7v3i9NFWw5CT9+EmfW4KNg1GC/abBj80eRHDREnPo1GlA2obo301
	 JM88EYx+iDNJZYtdTakOzts/vA+C/I04pTGe3bPiPQNPvOsKCvGFnqac9ZIndE8Z3E
	 aZ1Et+wPnPvvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 280/638] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
Date: Sun, 24 Mar 2024 18:55:17 -0400
Message-ID: <20240324230116.1348576-281-sashal@kernel.org>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit a8037ceb89649659831e86a87a9329d1bb43c735 ]

The rockchip,trcm-sync-tx-only property is at this time only documented
for the tdm variant of Rockchip i2s controllers.

While there was a series [0] adding code and binding for the property,
it doesn't seem to have gone forward back in 2021.

So for now fix the devicetree check by removing the property from rk3588
i2s controllers until support for it gets merged.

[0] https://patchwork.kernel.org/project/linux-rockchip/patch/1629796734-4243-5-git-send-email-sugar.zhang@rock-chips.com/

Fixes: 8ae112a5554f ("arm64: dts: rockchip: Add rk3588s I2S nodes")
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240227164659.705271-2-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 4aa516ff156df..aa18cf1d1afaa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1542,7 +1542,6 @@ i2s2_2ch: i2s@fe490000 {
 		dmas = <&dmac1 0>, <&dmac1 1>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m1_lrck
 			     &i2s2m1_sclk
@@ -1563,7 +1562,6 @@ i2s3_2ch: i2s@fe4a0000 {
 		dmas = <&dmac1 2>, <&dmac1 3>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s3_lrck
 			     &i2s3_sclk
-- 
2.43.0


