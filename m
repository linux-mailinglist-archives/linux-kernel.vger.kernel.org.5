Return-Path: <linux-kernel+bounces-115432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42E889B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4BC1F31896
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC620FABF;
	Mon, 25 Mar 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhyWMkM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989F1DF0E2;
	Sun, 24 Mar 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320742; cv=none; b=ApP3K+HKH3L4ArKt1oTxrt2Q6Tmk5oPiJ9NamwsQzygW4gseJUrIC4nstGyj0Srl6x/dXztAOKCdJwMTFuisN5QMPODqA0xmSPH4iix9IJZ+ohMcHGzz16FnYmRR/HujujdExk24yuJl6lSZPDwq+cfJxryh9xEA0RythdtkFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320742; c=relaxed/simple;
	bh=58B98bGY5tMD2svD0Au4W1Qr/ZKoc4cnw7wxauTqbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6eH+EKv7IQBHlcaMiT+futA8cpKFG+Xszg+H3EjAEA7rN1x/ddHkgmgDOX722jTjliZBl2fCSNPN0/mn+RXigbEIIlAGmY0REszP315UfBWhlOe6TyCgk47MRVN9lC19Y+nb0HYseUd+Xp2YHw2gE2AKe7BMqChxRYmUYujbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhyWMkM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B876C433C7;
	Sun, 24 Mar 2024 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320742;
	bh=58B98bGY5tMD2svD0Au4W1Qr/ZKoc4cnw7wxauTqbjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhyWMkM4uddfmJfbVHLSwZlpfAV95ZhJkDk2jFm4rLa26opZH+riBMsOtwIRE0Ggw
	 vvRYqVWPGsZmudf4ngAooXBipuLDS9vnoSD7Tr2ZTQYANGQ3dVKnGl3MB7Ca4rqEoT
	 BDRha6K20ppxpcyzKrTjUswQd9xKk4AVII3HEcANFQ0Xn6pm/UYOvQf/fhguhHjHeJ
	 g/lzKr8llcySPWjNVJxF/7VWe+2gY/EmMlaL4/moaKhLaJAbjlEyEuCAyLfTtr+2XB
	 PWxKKcMamnOUYtCy44tUHLQwmh2RrOHLcBV28IZXNebmKpAQo2nTTIoRik/G3pIDkV
	 kBQnxnORuJ9FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 306/713] arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 18:40:32 -0400
Message-ID: <20240324224720.1345309-307-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0c51912331f8ba5ce5fb52f46e340945160672a3 ]

All Ethernet AVB instances on R-Car V3U have registers related to UDP/IP
support, but the declared register blocks for the first two instances
are too small to cover them.

Fix this by extending the register block sizes.

Fixes: 5a633320f08b8c9b ("arm64: dts: renesas: r8a779a0: Add Ethernet-AVB support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/ce6ce3c4b1495e02e7c1803fca810a7178a84500.1707660323.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 4e67a03564971..504ac8c93faf5 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -658,7 +658,7 @@ channel7 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
@@ -706,7 +706,7 @@ avb0: ethernet@e6800000 {
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779a0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6810000 0 0x800>;
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


