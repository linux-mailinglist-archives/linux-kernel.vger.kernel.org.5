Return-Path: <linux-kernel+bounces-113749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FCD888F30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CC7B273FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9212C546;
	Sun, 24 Mar 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+p9x9zL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416771E0647;
	Sun, 24 Mar 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320762; cv=none; b=RBUN2/9OzCnaSyL7qEIHJdV9GJT7WVPJZKySnD9B4Pva1PQApG+fTzjljzMTUbg8vF5usfp2KzbieAKUYryoPcp9zaQaf7M/GCNuhLDUU/nvWGOOmMH8ZV3enLcjxvuojO+fojM4ST8qPnCwO2sFyUbLjvVvQ02L6e0o+t2njHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320762; c=relaxed/simple;
	bh=yG+SnCAZ63RHQ0LSud0TFiCY3rBSvIL15pC7toLImug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcR09DLgp/0wuiJ4oe4V3IcNbH7jSRziDyaBJSFgVtdJudcHNxwVQgA+p3499vP27v1hDV9CmTxVE9PYemO7IwCsIe/24FE7sOtSTi9xSuD3p8kNJVgo71OriO2GZoiw/GuqVaPppPM/aK8sdULyRxhdox54muTe/VhKZSnUT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+p9x9zL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E564C43141;
	Sun, 24 Mar 2024 22:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320761;
	bh=yG+SnCAZ63RHQ0LSud0TFiCY3rBSvIL15pC7toLImug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+p9x9zLAQ611ddU8DNR7HmRRZReY6KBV/FvGHudlaVE/z/xXln6Zmbx92d70xx+x
	 FiSZV1hPK/Ai/rsT28Z3hnZXQWm3LuvTC4ifhGohphspbbdkaYumzgwcSk47RTLJN9
	 X8WYxbxK37Vb+EzVaWtPoDazSmseYegSYTHylqLIkSBuzL/TXlx+SSGH7rYI4a4Rd7
	 KRvIxRIp2tRtGYHDr88BGPgy5mYUbhOWf+IrH7MgE3zqICvsrGfxszaUgh7NB1viTl
	 4SQfARjiSH8JvQFrYGnq8t4IflaRibg71Gq/urSVbFd/G6zrTWix56Wm5dyenub837
	 NmQ+DX+zZLCYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 325/713] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
Date: Sun, 24 Mar 2024 18:40:51 -0400
Message-ID: <20240324224720.1345309-326-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index f9f9749848bd9..1d262cd54c990 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1589,7 +1589,6 @@ i2s2_2ch: i2s@fe490000 {
 		dmas = <&dmac1 0>, <&dmac1 1>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m1_lrck
 			     &i2s2m1_sclk
@@ -1610,7 +1609,6 @@ i2s3_2ch: i2s@fe4a0000 {
 		dmas = <&dmac1 2>, <&dmac1 3>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s3_lrck
 			     &i2s3_sclk
-- 
2.43.0


