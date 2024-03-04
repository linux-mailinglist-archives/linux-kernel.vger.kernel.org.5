Return-Path: <linux-kernel+bounces-91158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE39870A33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57A8281B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFC7B3F4;
	Mon,  4 Mar 2024 19:11:03 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9847AE6F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579463; cv=none; b=stEMiZGch1dKBRAqXMtNFdqjkYm9XM89TPtq8HSwUWEVz13/F7A8WuwgT4Ou3QNj4aR5YrUTTs9eP+1a+tggDZ/hTv+UEYBGwjXkZtmyIycETvR76HZ1/M6KoMwwdT3zhRJ1X+dugqOWnDEfsVYXABQBaq3uTsmYYKS+h3w3zQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579463; c=relaxed/simple;
	bh=UgXL7h1cn275yguuSgiJgSKSKNaSdhoQTwdlVguxmNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCM2UsBEEIYgk1ED24ppiG9oSpUkFplrDw667aUdTl+lgxLr4N8Gp8QQvOYjzUv7JeFcGPFM0DvZs8uzGNuQ24N5qLAIk1Ywz+UUGSotaO2BdZhXhiwopollnmyGw/W6d0gruTeKGXOYBbef0mvpnf2PzispaO7Z/WYhNB64dvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by andre.telenet-ops.be with bizsmtp
	id ujAr2B00H2qflky01jArLk; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KKH-Q5;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCd4-Fv;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/7] sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
Date: Mon,  4 Mar 2024 20:10:49 +0100
Message-Id: <cbe9da98a1106cdab686766e2f23f768399dbdbf.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/boards/board-sh7785lcr.c:298:13: warning: no previous prototype for ‘init_sh7785lcr_IRQ’ [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/board-sh7785lcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 77dad1e511b4652b..25c4968f0d8b0e7d 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -295,7 +295,7 @@ static int __init sh7785lcr_devices_setup(void)
 device_initcall(sh7785lcr_devices_setup);
 
 /* Initialize IRQ setting */
-void __init init_sh7785lcr_IRQ(void)
+static void __init init_sh7785lcr_IRQ(void)
 {
 	plat_irq_setup_pins(IRQ_MODE_IRQ7654);
 	plat_irq_setup_pins(IRQ_MODE_IRQ3210);
-- 
2.34.1


