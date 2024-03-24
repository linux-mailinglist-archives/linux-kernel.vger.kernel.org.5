Return-Path: <linux-kernel+bounces-115188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB26888E57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02667B31F38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE530A54C;
	Mon, 25 Mar 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/jMGFHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215A18413E;
	Sun, 24 Mar 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324266; cv=none; b=c6SKBNksOsNz0SCQOelxfIJ6f4/CNJpA/5YG63L7nbhFcpq32HtrPyhc5OkE5q8iMZeuLn3b8NYXATIe629GfD9psjbNLCaMqhgFdnhI3DrN52af+Zu2sPKsFBlbAKf7nM8LMjrnF0juGsuEI04fmwyoJYhYBc8fsWz2Sk0thP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324266; c=relaxed/simple;
	bh=+aq8RLJbLgc5VXsalxjuBQSCjf84gqPif4nLSjN1eYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD/d45iKzh4TqFTNEJGtFdzOGbzzqggLnwOGAnwx91Q6H17cx8aACa6HmLHh+Tz+ms1ju7IjmUt8LMoUclNSeWPj6AkVEaQg0uP7Pg1zbKdo0TVplcZQDTR0epsgnVouPipkzqCxCzg1hxNZyHdj0Kv2xSintsaszmq3nVnXuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/jMGFHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81A2C43390;
	Sun, 24 Mar 2024 23:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324265;
	bh=+aq8RLJbLgc5VXsalxjuBQSCjf84gqPif4nLSjN1eYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/jMGFHBSZ/oQJt1+OUQ4Hs7y0E7EJZIrymcomZt+IfYZqiknljxA8FnFg9dxRzp6
	 9R03o7QgwxI2rUzY5g4P5x3gy1kPd0YY1QRIDtMajqSwxwm8YAMxajxjWrlY+qpzs6
	 Yo6GB5RoHE86w2GV8MRwB8Zus1UYjY/2Iy1G7l+rhjBSrZtXm7oiEnTTw3wq55LqqQ
	 aEP1Lbt6YOkoNhK5yIULnImW/i71Wb8lW7TXMAMXXRKqu/75YojZuuLxKQLupieDQx
	 0fvV/SyDVSNADKhU1rA+rF3iGG4Jf6X/Up2meD35DfWFIyCwKRLfIrkEg6JM8GAu1q
	 tQcZ1mFqjSxWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/148] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 19:48:29 -0400
Message-ID: <20240324235012.1356413-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 83e0fbc4a1a10..350a5dbd36130 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -427,7 +427,7 @@ pb1176_serial3: serial@1010f000 {
 
 		/* Direct-mapped development chip ROM */
 		pb1176_rom@10200000 {
-			compatible = "direct-mapped";
+			compatible = "mtd-rom";
 			reg = <0x10200000 0x4000>;
 			bank-width = <1>;
 		};
-- 
2.43.0


