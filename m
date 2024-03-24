Return-Path: <linux-kernel+bounces-115907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AB889898
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA4C1C31AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D0388939;
	Mon, 25 Mar 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elIej62i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAD1474C1;
	Sun, 24 Mar 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322097; cv=none; b=ovUXWrv1UHi5+xaLYXCD0+lRVBFUQ60KhNszhmsVToAgnjlWQ1Yfgpok1hz3OBGAgKXmeipXAVKj9Z0jS9YMHhwFqGGh6+9LAFXMs7lhXRMOXPB59CXXfkhn/5WqA4yamkibJ6h52pke+u0SMOOYtpjSEdZabAaDkEtPHA75BpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322097; c=relaxed/simple;
	bh=Y0faMlYlXglp2v24nSVm66zY6wL/DOGxRb/RKeaWVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdfLLZg7IJ7zW/zncFLbVQRM2qKh2IBLSkAW4H+zVaLj6T5ZW2XDuVEfThLY8YS6hkHNak2dMqfwH4P3c7oGqAwwfln3TGITqVrvjXkRrKixLb7Gv7NP9ypj2ka5H5Th0/jo1usjtx4Ewc/lZ5TNdNSnHcBSUAX58KRtWglH9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elIej62i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B46C433F1;
	Sun, 24 Mar 2024 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322095;
	bh=Y0faMlYlXglp2v24nSVm66zY6wL/DOGxRb/RKeaWVZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elIej62iRjNQ2M3Tp+M4uu1PcQX6pA+mHYdDSwVJ2k78eM/9cHXq413+ROEARbQZq
	 4lE/Sse6RMcDBlv3EYFWuI4fwYj1cKAfGw76LjvCheP8glH9UqSvkw+q6VH5pfVm1Y
	 oGRALCAFrS5BwxHuAGUe7vtrD4NeK3gHT8gvGEijT1bhR22W4D1ot9obGSWxlLiAwH
	 3LkYiPCyKt4OqiYEww3DGg+t9ot6JIsu6uaTIkXj9dJIewBiqpdPnlIN+nBJ19eTl3
	 KVOZlZz+TXYfR4tHY15zKIXw3nfvR1lMeEs4tvCKqa021YVMSBaABeCPIpi+qCd0eC
	 EVRndN/b16BJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 170/451] arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 19:07:26 -0400
Message-ID: <20240324231207.1351418-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 41fbb9998cf82..b677ef6705d94 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -657,7 +657,7 @@ channel7 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
@@ -705,7 +705,7 @@ avb0: ethernet@e6800000 {
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


