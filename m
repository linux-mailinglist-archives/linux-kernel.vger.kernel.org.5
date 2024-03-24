Return-Path: <linux-kernel+bounces-114966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1A8892C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBBC1C29A01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED51BF536;
	Mon, 25 Mar 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKtxDzV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67317A934;
	Sun, 24 Mar 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323700; cv=none; b=RL26b7OceEpgaluUoccoD2pBUwbx68PvdEDmNLagaEsyUfOVQEtj1zgcosIOg5DJqDUDI77EJ1lo5dsTSiAZ6zYQGYZoZoq3GQszJQykhQILy+Zzly2sqfZHBOXtF0au71ZmXx/PQDl2sXDMtYdsIQkZPxJg/HkevrO0hcD7C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323700; c=relaxed/simple;
	bh=CoIP5bWI0VIjdjtDRBLAzqY0BhLzkg9Y4oXc5EsY1Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc3uieJ/8EdA9i4sPPO+Sb/f97BWYf7LqJW51eK5Gv+63BcAnetMapEITY/ucwK4ruGing4PqdKrcPgeGh5rBtc5ZD2jMYIRxmp5GOs7wkXTy+DeFczIf0QTfplrHGeDsS/Ks18C6AZIC3B2XMnZt7IR/IfNjk5+6GjqHrb51L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKtxDzV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87EC43399;
	Sun, 24 Mar 2024 23:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323699;
	bh=CoIP5bWI0VIjdjtDRBLAzqY0BhLzkg9Y4oXc5EsY1Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKtxDzV6urA411T2SJQnde9dYn52igK688BFvI12qnu5DqyNOJQENJj/Tx6aO6mtV
	 Z9vPeHuhO8XO9XmNhQCInm79rvj148jKvAlZ9yV4wMDhb4BU0Tc8Dvd8pr/pWNzgeO
	 tziyDoDiV1ajLeZ+0NtJBqOFyEhCg7u1YPL6neEh4S6yne2vbeJ1YZxzlDNeiR9N7i
	 CY+u0pS4e4rBbXq4PG9F+oE/wpvPab+I2V/O5qO6XJ5xosgvS/cC/hzPOtuc2FDKGz
	 CaP/mO6CohMnyh1ej0UDayMfJHCF2/ecIwSINi9hhSBO99/1Fg44ld6lCp9lvHCk83
	 bJVzzJBo+pfiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 072/238] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 19:37:40 -0400
Message-ID: <20240324234027.1354210-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit 3baa4c5143d65ebab2de0d99a395e5f4f1f46608 ]

When the development chip ROM was added, the "direct-mapped" compatible
value was already obsolete.  In addition, the device node lacked the
accompanying "probe-type" property, causing the old physmap_of_core
driver to fall back to trying all available probe types.
Unfortunately this fallback was lost when the DT and pdata cases were
merged.

Fix this by using the modern "mtd-rom" compatible value instead.

Fixes: 5c3f5edbe0a1dff3 ("ARM: realview: add flash devices to the PB1176 DTS")
Fixes: 642b1e8dbed7bbbf ("mtd: maps: Merge physmap_of.c into physmap-core.c")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index f925782f85604..f0be83eebb09d 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -435,7 +435,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
-- 
2.43.0


