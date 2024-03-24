Return-Path: <linux-kernel+bounces-113118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1F88819B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB71C21B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CA15B103;
	Sun, 24 Mar 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGmVaUxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0215AABA;
	Sun, 24 Mar 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319926; cv=none; b=X64y50pHV5jpVi6fZjjQ38NDI0mEX8tHMYUt+rIsCzt/J3paXbOmdEDJkgqI2t4H/LG1va91QiAKtNyJTwQG1dJiRaC/hTE0RsqPSeS86BH3XOkyS9rfi33MCapDP02vSqiMCVBs79PlBhS7PkKnb4fJThHWPU3OWLl605dUo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319926; c=relaxed/simple;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDcb2JVT7J9Px6m1CEfwN7LjMjaQtGsFf+rvyGkOkyoNcsbsmezKfWcJBuO8ZW/1GY3dEnqij3r4PxHNC2kBPzuh+6383YSJ7ALDA/qbuMaJ4q9az7QU9aMkJ04GTnlbrLNZPBPnC5HDnQNMrNjoXPAkhIcBYdEOZuOCTrBPtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGmVaUxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5085CC433F1;
	Sun, 24 Mar 2024 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319925;
	bh=YKVcdpL5+OrlaJ4q8k+EUbtblJGBjMh/yaBxJ7pH7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGmVaUxxH/20XO0jOQdLM+cugdInnVvxqWQ6LBB5DVCfD/2MQ23nIe9H8cWypRua+
	 YTElvjOhfRdMphvmppxjSkypX7z8L9RxIHaLzDmTiLvF+HAKSeF4ZXl1X+PEY4Llkx
	 JhXs/2GSwpq7vOmSnILVHs+6PTFD+m5bKx3uC0ygpPn3RHHkHoQxmiwc5jp/9PIgHY
	 TdPJ//PU4+LL+IXqu2Dx2mddPCXiN/iPJzV8sWaFdrMxjl/6FOon42HdtNu/yd7yaQ
	 UqqAEm/fAn7H2Pyezc9m0jnults5ehcugJejSW451ZUgSZOWWBh7bPvBdAp9IaMv9N
	 TVzFqiB6YxMOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 231/715] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 18:26:50 -0400
Message-ID: <20240324223455.1342824-232-sashal@kernel.org>
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
 arch/arm/boot/dts/arm/arm-realview-pb1176.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
index efed325af88d2..d99bac02232b3 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb1176.dts
@@ -451,7 +451,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
-- 
2.43.0


