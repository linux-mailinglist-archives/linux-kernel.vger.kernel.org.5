Return-Path: <linux-kernel+bounces-115659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB746889D16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8239B1F36801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142511EB1DD;
	Mon, 25 Mar 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOUgBjsJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC920896F;
	Sun, 24 Mar 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321550; cv=none; b=D2wZJbqo/eOw9kuCy9t/49jp1ddHLDfZWRlAMQp7dLppPTk/MK9HUZtXYINgC7POMzYS9wD8EcbeSsBgAEVzHEDz/0jzc6nDrqAi/gVMTQzLIg7tMDjR4YFW37Jyauh9147yVx45CWw7XN8Y3A9NCdGYcZrZoGn9Nh2YqH/LctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321550; c=relaxed/simple;
	bh=z901vsT93gAMo7P7wHc1SqImBhKlT8ttrHj/M2zhTDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO1vJef3FyEHLyaAsi+fIDXsZIrR3YvihwPAhIltlHpbKmha8EVDfGVOll4w69BsP1BoRmTQ3EW9ObhHZBdm2nIidcwNGxHK1TnGrJtBiPmL/6ARUUzViIMYh/2hfTxYL0MT1+B6TJK9+afytFBv0+Z7r08Sto9PkkbIeVoFiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOUgBjsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB5C43399;
	Sun, 24 Mar 2024 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321549;
	bh=z901vsT93gAMo7P7wHc1SqImBhKlT8ttrHj/M2zhTDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOUgBjsJGZouvLfUQmxd+Jo1ylI/Tt2QL4Isv9UFPmlUGhBqKfXD6B8+c/z7aAWRF
	 8aQSaAv4ZV8L4/h78LDdlnx2FP8V+kvPuPJgyjcPAI8tjBwTGGUlb04qMQcUhIhcvD
	 FcabbLY36Bk7QyX1Fvm/sPUyC0boQPoSzcn43E6o2p5m9dCn8sM757W0dkvblwrNnP
	 UuA6wLB/jxYCny5GfW09nPGsNlT90byMV5X0eJXMmixtHrAtBDJSDYeFXoGs5BYBDn
	 i4PnRwDdaimE73LhyiuZEjBEN9fhEmKFk2YMEUeXp5oNB2nN3c0Vh6WcvUrbxJxcTj
	 ePAc732GWh9Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 278/638] arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
Date: Sun, 24 Mar 2024 18:55:15 -0400
Message-ID: <20240324230116.1348576-279-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index b7e2b475f0707..3cd097adb3686 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -597,6 +597,7 @@ vpu: video-codec@fdea0400 {
 		compatible = "rockchip,rk3568-vpu";
 		reg = <0x0 0xfdea0000 0x0 0x800>;
 		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vdpu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "hclk";
 		iommus = <&vdpu_mmu>;
-- 
2.43.0


