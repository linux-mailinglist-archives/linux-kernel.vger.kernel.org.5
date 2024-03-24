Return-Path: <linux-kernel+bounces-114806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C2889167
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E4A1C2D246
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EC1B9C5A;
	Mon, 25 Mar 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGxiLTLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090292779C8;
	Sun, 24 Mar 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323411; cv=none; b=iyPPSVk/4fMvVkGz1yhCnUDqUJH9wS4zcIZn6trx+QRQ01nXwD+cMY1xLThUzCPHIxdlDvc4r1ZnHEqMJK2uEjqVfDCXiOrvp5/7ZZjm2bJu7NlS0A7YJcizqJBE4C4kLZAI+tbJtvnMZdjAFQdgn5qmpmApmpvS1/xHVakw9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323411; c=relaxed/simple;
	bh=5kcALfjLxPEpHa0R3Lm1QHZF9d8sF3p8Y5boSEESVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbmd6dnObyxMYG0tkiD2smrCQdcr0lEc0nKOofFfjkAe2bwcKEDWJpaeiw+eMXsppo5ePkLRWmkWeidwzByMeUK6uQ/XM4SeC/Wxt70hk2f2utd4V3gmyA2tbUwLEJOwO7AykJJNyYhIrBi4oQAawFu0YkIu6t4T0ml8UqAvNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGxiLTLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F398C43394;
	Sun, 24 Mar 2024 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323409;
	bh=5kcALfjLxPEpHa0R3Lm1QHZF9d8sF3p8Y5boSEESVuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGxiLTLDFKgFb5WQu2+c2Xy26GEqzUUJVuVnB/ODdLqhsEmWqiNeFgIuHTYAXH8bt
	 H2a9EjcphpcJ6c1YrXd0pbG7PnRDUrwPiZPK9CEL7/8XaL5wyqWbAokzwt/tGe1yBG
	 4jE9oNYFVnZgfY5IUhGwhiSuPJd366E9BnpEW5ULqOuAGHA9kB0lGUmlZ1SP+4lGa4
	 pj4P3GCTSYzjF4Qx6g748dtgaixc0RGSndTrGrwJXlZFHoPElx7saIyPeCd+asr1DW
	 gct9A/kLG/15EAGWO9kQWmG6DB8P+WaKGH9Nen3jAWeMCeiDYCv8wc2bCz+kQbPBN3
	 awW9EM/NhtDWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 111/317] arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 19:31:31 -0400
Message-ID: <20240324233458.1352854-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index c7d1b79692c11..ed71a10d023ee 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -584,7 +584,7 @@ hscif3: serial@e66a0000 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
@@ -632,7 +632,7 @@ avb0: ethernet@e6800000 {
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


