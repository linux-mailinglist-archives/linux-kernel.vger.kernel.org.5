Return-Path: <linux-kernel+bounces-113747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55907888E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878981C2B18A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF421EE68D;
	Sun, 24 Mar 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UedNUTZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F111E063C;
	Sun, 24 Mar 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320761; cv=none; b=Z0QMgymdaKXwTgeS/7ow0G/ZLH/LEPoyFdvK1JyJup6yWaSx7qcLHGrJhNM/U9paIjYXzH0dByxZPkeaLPOP6FWsShMCN5iJQe3Ri/yXRklLGBadRv9kvMcSiOfidn1Fc1MwTUdrkpOlZUQdXgzabQnYzzDkW7ZqkmfwHHa1hUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320761; c=relaxed/simple;
	bh=3amgfx0AshjHIMz2Es+2BaOqMWFTibDYt+16ztnBPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6EdmR1K4apuHxUBrUUFLoKj6V1aNYCdjQcBKEyavVA1tjDtrhAoJ/QDxUzRO1BhLzywhgc8xAH6h6u38YzS2tpIflh+reQXsSpn0kgOUFX+LadpOSTO781zHakk4MBlDpIaUVemL4YDUKlM7u9QE5DNwrHdhQLcTVO9w4BCgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UedNUTZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5475FC433F1;
	Sun, 24 Mar 2024 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320760;
	bh=3amgfx0AshjHIMz2Es+2BaOqMWFTibDYt+16ztnBPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UedNUTZ0w6AhTw76ew0X2RN3dY/0tXb9AcjxZxjlmxz/QS2EsieD25Ghi6Czi++bT
	 46xHf/w4vfO1+nEUPlQknXKMgr+vGvqO20+2oyHUZ5BtH1Krpii45By0PVMHqa0MlF
	 Wz+AMTiZ4KUN01TvWfElcWYiNPc7TFzX4oPfMcX/ppG9sQacqgZlmKCH/QRqfvypdV
	 aPHClp+Pl4r1bQL0pqGc8iVZZTb2uXmhV9unlgU9AcDzrWzwrIzeYjqjpJIRbZX0iY
	 T44z8qlQIdKeMAi1IA3D2FlfvCesD87NOn7M8gGoPkJKXF2NKcb4KsrBE0kjQfr39y
	 RwZ8SpVjt78iA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 324/713] arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
Date: Sun, 24 Mar 2024 18:40:50 -0400
Message-ID: <20240324224720.1345309-325-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 0fc19ab75acde78558bd0f6fe3e5f63cf8ee88b0 ]

The dtbscheck reports a warning for a wrong reset-names property for
the i2s2 controller on rk356x socs.

The other controllers on the soc provide tx and rx directions and hence
two resets and separate clocks for each direction, while i2s2 only
provides one reset. This was so far named just "m" which isn't part of
the binding.

The clock-names the controller uses all end in "tx", so use the matching
"tx-m" reset-name for the i2s controller.

Fixes: 755f37010f3e ("arm64: dts: rockchip: RK356x: Add I2S2 device node")
Acked-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240227173526.710056-2-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 6a9bfb0550c04..92f96ec01385d 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1124,7 +1124,7 @@ i2s2_2ch: i2s@fe420000 {
 		dmas = <&dmac1 4>, <&dmac1 5>;
 		dma-names = "tx", "rx";
 		resets = <&cru SRST_M_I2S2_2CH>;
-		reset-names = "m";
+		reset-names = "tx-m";
 		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m0_sclktx
-- 
2.43.0


