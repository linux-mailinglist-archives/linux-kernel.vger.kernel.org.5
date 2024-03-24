Return-Path: <linux-kernel+bounces-113165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C78881FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D221F21A73
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A41741F8;
	Sun, 24 Mar 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXqDI0cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5A1741DD;
	Sun, 24 Mar 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319967; cv=none; b=fyttnbdHIWEtykyCCpYoShZadHvo4ZD/lj43armPU3pLMNE3M8zDbTv2dV5vzcE9PZj0duSliIOLZL1vHBcJD83iA1h5sIJhiFjymyITZwv2+qmb7ipZK3LyooOnxwOg6zin9OgFHTo1kRF99qBMBY6I0z4JEqEjjRFo0ew/gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319967; c=relaxed/simple;
	bh=Cv+D7q9WvVAequB7TUaTMLoBK1zzgqdQ3pgOi7ApiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOVoBaYvPCq4uID8aadXQtM8iqZu/Mud5rdlllvydvgsV5RI6a7nOUNBuXUUDGKnImtvEPq4Pw4STp3Uw8vqdWMzVAo0kyWQaMei8SVNJ8UlYDopn2Z6n7ELfTikvXe9p0nKqMw+GPMSEfHvzN99WwHjYEpU4sK2xbppAEVcr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXqDI0cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ED1C433A6;
	Sun, 24 Mar 2024 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319967;
	bh=Cv+D7q9WvVAequB7TUaTMLoBK1zzgqdQ3pgOi7ApiqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXqDI0czBvwO8qdT0VQo5dE4s60CMH4ArmroutALh1eamfFeXbACfw/zHTReinonL
	 hm+eaH6XPViMwcc9ZkvsNc0eBr2JKutF7PCKDAmxpCrCin70LkkFZRLYzAybO6Jy22
	 K7Wi6tiq6YqiB8Nk4nn6+rQzXEepOM5o/AdYbqopHgQrXkfNw6rbcE2akpRjJs9JXr
	 cMetqW4CPlZC9tp5dfSWWVviASbbqjkI+g8bpX54p6qaz+/eVjveqTBm4GwjAsgANv
	 QrYcwuccYfzuLElXfw5vO4PNeeXWd3wtCt8gS/zWO7VXeXXaIwTvYSksuzk7DQUfUR
	 92r3HuLnqMw/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 274/715] arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
Date: Sun, 24 Mar 2024 18:27:33 -0400
Message-ID: <20240324223455.1342824-275-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index c19c0f1b3778f..6a9bfb0550c04 100644
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


