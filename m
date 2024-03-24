Return-Path: <linux-kernel+bounces-115079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26607888DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494D9B31DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7091C3A38;
	Mon, 25 Mar 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raH6Tslo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4455180B74;
	Sun, 24 Mar 2024 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324059; cv=none; b=XJnTaQEsEDyK66VOQ87MRbl1qdp1LQFcToNrXfYgviAg1pJeTqm/MWyzhsjC/QobG/MoUIKFLSGgKj44T+qponFRwhspW+DK0xzG61S/qoC2qZyHa8+LIIUTd8Ii4FGdEEtO+5tvgJRIVmMe8FPs9MqPIZXQWN/+72u0c9pwg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324059; c=relaxed/simple;
	bh=acSYC8qx6Eqvje3K7lC9u19vwV0fg/4u9bafU49h0t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieoCOVq/qi8+3plGbbNCJZO7OIAzW5JasCZCMlEYRkVNse0KZ0RRMuNr/0KcZSwq+l2eE5SBQBPGp8PtbEdkEp3wlGOP/8YNuUBh9qPTjfxdJBh0+FHhkcZapPo2+/aKWzGofpkaAEkx79bfqp4InGzZ0erHl3T8q6g7PAL+lFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raH6Tslo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D41DC43390;
	Sun, 24 Mar 2024 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324058;
	bh=acSYC8qx6Eqvje3K7lC9u19vwV0fg/4u9bafU49h0t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raH6TslomEhjOWWYXqvt5URMGDvfb/2J/73Uk7dYtkTlSkcJVnmxD0ANDwPO7gI20
	 aMDNm1vJQfjx12uB8BEDQi86tOukXureO96AVBhjfG5Ve9RB08Th2w3aWQnD8JIJAN
	 5fmJ5DIM1vkU2nLvbaeXEdav0Ej4F43nJQA+hOyOxc++NE4fgvPJrh3nLJMVivnkOX
	 Dw3kgiIt6JgTIYRzvSWr8OV8DAINLTU8nRKnx/R4zqRIlS6dKkXF3khN7tJUEvO3Up
	 pVutA/CKpZ9NQIuGTEsmTH1ttMkajVE8d858AYp11pMQpy8BkW3VNaCR7USQLYhuY7
	 aIAuVIwgEc38A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 059/183] ARM: dts: arm: realview: Fix development chip ROM compatible value
Date: Sun, 24 Mar 2024 19:44:32 -0400
Message-ID: <20240324234638.1355609-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 2625ce66f8e7e..673c6e5b2f565 100644
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


