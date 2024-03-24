Return-Path: <linux-kernel+bounces-113149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F38881DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8746F2845C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937F170EBE;
	Sun, 24 Mar 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6rhIyMu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BAE129E8C;
	Sun, 24 Mar 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319953; cv=none; b=Dm4wcpNzs3O5QdBOBg6vAhwCsvDoOYEj4mGga4u5p/KrY63+kM80FphEkKm0ZJUYPuNq9lRA/84WTCb5NXdSdzuX9klKylHKLzOlizZPEHkitkKR16LIEbelZjGBN3ODZJRD4WcFUt6ZzvK9Dl1EQK9oa92VGoOz8liu8zkMrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319953; c=relaxed/simple;
	bh=58B98bGY5tMD2svD0Au4W1Qr/ZKoc4cnw7wxauTqbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf6yboOTFHWVkJyyFQda0aJJ0K1B53Jni+d2lAdcyD2+v5EvqHbpKXagd9FJ6z3EYusUopZaNiaaeFeRtFlUlt9I508D3miy6FSt7VIDDfCRQUYZpPCfIr7pzCBj+nD1fgJLLcxwKXAdhaL7JjZXIkpJs5cu1u4HZbRWK75YUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6rhIyMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885F0C43399;
	Sun, 24 Mar 2024 22:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319953;
	bh=58B98bGY5tMD2svD0Au4W1Qr/ZKoc4cnw7wxauTqbjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6rhIyMusr/uE3RQY7dnt40RZZIeQOy/gamFqFqiK5/0c/7TrNpghEroeqUq6ViGn
	 iaX9qLyhUxM83qop8f5E17bB6VTKF8Iif5R7itG0ngXOByOe4RS1gpsrPIt067lPSJ
	 pOp3k9q37xKIhOcY1o4pS4n2QNvmHFu1O+12vxXMGObi4A02lT/0Hmr5gS4gH4OX6b
	 vAiQrV88SPnVKvhdsEQkBQMICyGOAjgqgaWKw0LYhXLv8KnE+R63yMw4nTuNht4PHo
	 54LWyNcgNKVwbfrorcnmGc/CWCgf+G7spq9DQkVzctKvX9LisVUQ7USr72K+tNhehM
	 3OM21ZWPm1L+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 259/715] arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 18:27:18 -0400
Message-ID: <20240324223455.1342824-260-sashal@kernel.org>
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


