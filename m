Return-Path: <linux-kernel+bounces-115906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E28894D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169EB1C2F4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EA16EC0C;
	Mon, 25 Mar 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNPQDeoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C81474BE;
	Sun, 24 Mar 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322096; cv=none; b=F9sBOUrD4tL7pct2Vb6rWr3wSz8gYvm1oz/br/EMKhZTxOeXVDKmx5ksVxQ2DdBRWM1Ap3s+RlDUoIz1wnlGMCkV2Rqe7IavSn8ZQr2liZ0NsODr3pLVuxVAAMe3lPdJ7uk9oxpG90NQjtaahLRxaO2CZvHT68SEuv2zkgUskKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322096; c=relaxed/simple;
	bh=eX17tDOpR4/sNwJlQ8hJbVc+M0Lq/73SvbuHje2/F5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awhafaC7egKt4iPWERsIC5C6eIHtqJfFf9AXOZaf7gQGhSHpAiDVu54ekkUccnA/0qwd6kKda/LO1bUQShGoXO7lYbnabZfY2kO1DqEk/MX1vPCrEVVOvpDN+8TvSLej70iX27stIVgQBVkhpqWwM1gc/6WxR1PUoQm6Icw3uAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNPQDeoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D61C43399;
	Sun, 24 Mar 2024 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322096;
	bh=eX17tDOpR4/sNwJlQ8hJbVc+M0Lq/73SvbuHje2/F5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNPQDeoOn1l2nNoQE/u6lJk7mmQooRy1vaxPcAS0CwHMOFZEtllT7lFi/2g5e8FTX
	 44rGncMIuDFOlT5i3yb6lf5qoq7elnn9eGOJbbKTH7+fSzQa2ro/nnolA4QafnZSIw
	 xP+abBOJPdr2IA0CPm+Q+EKoBJnAb8awTzyoYdm/w+2y4DKUo3Wqa+ODTjzHytnKnk
	 H0aq7/mackDDVJXxHDqc8d9MIknyUUXig9QtMZAaU/+fei1wlsttKJGpQeIwDM8e+c
	 xopYrTQcaDvUpb99cEMyDwEVFTHXPisQXXfEEQ+G0eO9OKL3VYe5L4+KOzFCK+qjsY
	 zT5yI77Ci25sA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 171/451] arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 19:07:27 -0400
Message-ID: <20240324231207.1351418-172-sashal@kernel.org>
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

[ Upstream commit 7edbb5880dc3317a5eaec2166de71ff394598e6b ]

All Ethernet AVB instances on R-Car V4H have registers related to UDP/IP
support, but the declared register blocks for the first two instances
are too small to cover them.

Fix this by extending the register block sizes.

Fixes: 848c82db56923a8b ("arm64: dts: renesas: r8a779g0: Add RAVB nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/83437778614a7c96f4d8f1be98dffeee29bb4a0b.1707660323.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index d58b18802cb01..868d1a3cbdf61 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -337,7 +337,7 @@ hscif0: serial@e6540000 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
@@ -384,7 +384,7 @@ avb0: ethernet@e6800000 {
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6810000 0 0x800>;
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


