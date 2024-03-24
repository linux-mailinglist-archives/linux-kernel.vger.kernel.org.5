Return-Path: <linux-kernel+bounces-115905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A988988F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B4F1F30555
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776F38817F;
	Mon, 25 Mar 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRUAl82f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522961487C7;
	Sun, 24 Mar 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322110; cv=none; b=XZred8QyF24qjw34Rvh6aalS+cPU8GEOF/fa+vazgfBPtYgL0IgGPtzj3+p4BahfCqqV4Zn6NM+ndKU8OCh9BHQXeKmg7fSPHNQEfbkZiaXqfyhaAmYoCljskXJ9Uae8PmyJidxfKQiPU0tpnv94KbMOfIqmxu638OT5Pq3k7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322110; c=relaxed/simple;
	bh=dNHR4eclNy+wmS+rjR+g78dsaberhhM17L5AFfz9j4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbGSTHftc2P+F9njnWWMOGohTGaeLvIs1EDYJSg9FCMDW9SdjtLfkzvUKR4GlK94b/UwCNVJhh9RbNEtw58FrfG0cXegZ3tV60w/OLaukX2zdTU94vl1nF/slaX4mFZyDFy1V6NQFVH1d5hvP9uzddlmZNLl6xaP5ZOD0WjgClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRUAl82f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D0EC43390;
	Sun, 24 Mar 2024 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322109;
	bh=dNHR4eclNy+wmS+rjR+g78dsaberhhM17L5AFfz9j4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRUAl82fdIdI91iPU4F4ll9w/gr3p4EoHgsHqRSpZbKaYwRzNudeB1s/7kjwn69mY
	 HrmLMpvL8AssnurGYRO5aKbK9jgHotM3RXOhLbLBhmuUmAAlCdJKPopKiLK9a9q83k
	 04F18XRbhYhKvk8vWR1Nw7LX2F7xJNoimuHjtvEdnI9sQuNokMheMFWVhWY0fK1giL
	 ghc6Nhfj6UomcY1O3+s2Vpx5Cjj1REdTUdC21gnYTAPp1y5fBaxizB36wIFiTrzU0q
	 JxwWZ7fm12mF3PmabBq4KzOhVqwFXog15LW58ykvtbC4ZKQi2LMhmRBMvA6WCnxqsL
	 aG6kmukoWNJWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 184/451] arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
Date: Sun, 24 Mar 2024 19:07:40 -0400
Message-ID: <20240324231207.1351418-185-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit d1c44d9afa6f89aa0e10a191f30868eb12cd719f ]

The video-codec@fdea0400 was missing the interrupt-names property that is
part of the binding. Add it.

Fixes: 944be6fba401 ("arm64: dts: rockchip: Add VPU support for RK3568/RK3566")
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Acked-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240227173526.710056-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index f4d6dbbbddcd4..99ad6fc51b584 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -596,6 +596,7 @@ vpu: video-codec@fdea0400 {
 		compatible = "rockchip,rk3568-vpu";
 		reg = <0x0 0xfdea0000 0x0 0x800>;
 		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vdpu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "hclk";
 		iommus = <&vdpu_mmu>;
-- 
2.43.0


