Return-Path: <linux-kernel+bounces-113167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08258881FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D159B21B50
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F717496F;
	Sun, 24 Mar 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhayWkFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC245A0F1;
	Sun, 24 Mar 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319969; cv=none; b=TxiPyzbSVI7ghyFqGMFGZC9AqnoORkih4+C3iAHo4sn58Y6L5JfTbqfuHMLgSUHko7ZFSe84Dd9t51VSq8cfaiWLzu+60YhXZFrzgprd7sokXQMluJ1z8dybyAcr9eokWhQpF8LXamIsqRyynDBsWhYdtLaFdEXy3Jp8ePWRGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319969; c=relaxed/simple;
	bh=Kh7U/mKHQ+anKiD0Nygr9rYXgz72DaOZ679gP3rRRg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiDZKnXL5dNMIT1+AOcL1ZNLNDS3V+kIFflalGsok0Awx1ZMu2Wr48KLIFAQnvxyfCnaqu1daorZ4rbazuM2ngrkdyUdsOPArbKJlF3T7m7OPMN/JEmknV59G0agFNVD2lQNlt1rPOGHw3LAZl6Y6XjmSeihWMeiz0dk012pqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhayWkFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8B7C43399;
	Sun, 24 Mar 2024 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319969;
	bh=Kh7U/mKHQ+anKiD0Nygr9rYXgz72DaOZ679gP3rRRg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhayWkFMj+KE2xlal/WhTMyfU2EMIt83LWBhSCDsm+eI0BgYSY8gvoc0UvVEigII7
	 /PgDyv4wcpO0VBZyCn7ysGn+M/7UHeLhRMRRi8/g8KYwN+NCNlZsHVAeb4dURgEQx1
	 6S6+qJUhfTck7+Zv17ElxdUvjx4UtltIzV5BCklAjaEwljEoGG2aXy6AjIEUvgpHRP
	 TCAWr9IgTmcion2ffyAyRG3DRYWptuBw5gUiaAdnRUMszyNdQqHX9clMopNbBXcgjU
	 C8jILnbyGXrcSqpL/8FNlWvxM2tJOhSQLWEmDRpc/L67pxyJIfUzDAfuTstqnBFcLR
	 ScGkDvgYNd+pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 276/715] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
Date: Sun, 24 Mar 2024 18:27:35 -0400
Message-ID: <20240324223455.1342824-277-sashal@kernel.org>
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
index 36b1b7acfe6a1..82350ddb262f2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1704,7 +1704,6 @@ i2s2_2ch: i2s@fe490000 {
 		dmas = <&dmac1 0>, <&dmac1 1>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m1_lrck
 			     &i2s2m1_sclk
@@ -1725,7 +1724,6 @@ i2s3_2ch: i2s@fe4a0000 {
 		dmas = <&dmac1 2>, <&dmac1 3>;
 		dma-names = "tx", "rx";
 		power-domains = <&power RK3588_PD_AUDIO>;
-		rockchip,trcm-sync-tx-only;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s3_lrck
 			     &i2s3_sclk
-- 
2.43.0


