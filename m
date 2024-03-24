Return-Path: <linux-kernel+bounces-113744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98047888E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C946B1C2ADCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F70149C4C;
	Sun, 24 Mar 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9ZVFzCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A41E0633;
	Sun, 24 Mar 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320760; cv=none; b=IJTJ0pg7NIZnZPSSZH7y7Mg0ZUUTo2vrAgQSe9rB9gmwV82dMyd4h2g3votzbApsWMkOOu1xCp38Wef8+8oyJgx0rLaZL0YV7bYQQoXZC9wdDvqIWouNt9wOnqnDFad02+Wue7Cfao+Xx8u+CcJpZLTVaIkBJoDrSm+l0GuSZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320760; c=relaxed/simple;
	bh=Cv+D7q9WvVAequB7TUaTMLoBK1zzgqdQ3pgOi7ApiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxPzL0Mann1L23ex9yN4OUDOI/MM0fdRoW75JYuREPa5R6DKC2p+aqWnLBoY0Ez5tsf1wnPHbZ6EVXU9ai7YADiBYoQ/d8H6ipScP4LO5tqrM6tv/zCHdsuXKRR3kOmjsEuaMIQL9SPse1sNhJfjU6nhGLhA8ZJU0gxwUmUMOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9ZVFzCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED3C43390;
	Sun, 24 Mar 2024 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320759;
	bh=Cv+D7q9WvVAequB7TUaTMLoBK1zzgqdQ3pgOi7ApiqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9ZVFzCOmlqdq8qhhLGeYisyQw+3NFolMjpH0HVyzvIS16PiY9IFGQ7viEe8LaNhR
	 aafjVfnwM4Y42qlkX/o5N/as06FIVesjRKP1/dRYl57HhJFO8gg/45tUD1b/suJfg2
	 AYpE7KAeT9/I2cWFANYlkzCdw7OKHM3HvyRJIzYlmX5zMtp28W52X4zQy9gs4tbkO2
	 oDOokVqXYYz1Fkmpm/yHrUcdxo6bYUmnTl9pyLzcQT3eJl3DzDd55rMLP6CYKIR3yg
	 BlAnxIPAhMGBe2lrprkMRE3R+3UtwGiBIV/p1pSnwFfkgj1i4X0hpyN40SxksAHvmy
	 tUREsdYc4N4wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 323/713] arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
Date: Sun, 24 Mar 2024 18:40:49 -0400
Message-ID: <20240324224720.1345309-324-sashal@kernel.org>
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


