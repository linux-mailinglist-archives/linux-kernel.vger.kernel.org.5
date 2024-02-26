Return-Path: <linux-kernel+bounces-81341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48D867480
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA251C283C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F2604BE;
	Mon, 26 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Px3a+r85";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DM7HSrcU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35D6027E;
	Mon, 26 Feb 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949568; cv=none; b=ccQTjE3wmVyV/qAM9WidYAJDVpfpes1W31YGOUxnqtp/HYcGe7xl4pKgU4ziQTb8hLjZ0d0a1rMLjmXvx36IlcNecFlhUAQUEME9Tn+ya8uKOlBhhwfWOudV9PLYb0x6K2m/JczY+HlOyFBFY7kgTszh5W6HQhORo86YbFIZ8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949568; c=relaxed/simple;
	bh=mWDVcYPf4K4buLKqQJVFqO0wcp+5c2TANsnglXeQUC8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QgonNLpWX9XB8SxRA7A/PbedFOE6dtI5u+tEZhWaE+y97XCqaeAZiEoC8r303Lsqst3DQw23qwRnFzH6O+EBx0BXoqIEBIDXjTFUCFlOpDURz4CEZunmAhDiTyBz9tk28kc00TpYz7Nz8h901BaFa6CAmhsex+ueEjUshCagRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Px3a+r85; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DM7HSrcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:12:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708949565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdFo9kC6jinpYH6jRd2rYz38dFc64c3+PKmAeRxOHio=;
	b=Px3a+r85l109dlvt0xH30pgaHRJC7AG15Qy7AwkSmYC6xob2vQsKeiDdvbch9IxMieOuXj
	NM2/y8RRpqC1duaC5ZksWktdj9CQrCOAW9/cW8MlxjBhrLhw2SeX6PcPHG3/yXCcWIBEB4
	7l7ntywJHZYl6cMNX5roMVLu3utbK5lcAiTCw2eqc5VX9RBli+zS7i1tVRE6/Pl5bNNCkk
	RzF32EYK3XY7rZ5VYHPEjKvh/3ozv2qkmY+KNg+ckpKkvTjgp8mQzIwHdE8lNgcjtTV7fx
	dfAFhdSFFeQ+qUrOjBvbqghCf3a9CacM2p+jbbetERLqDcrWvvBsC78RF6cbeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708949565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdFo9kC6jinpYH6jRd2rYz38dFc64c3+PKmAeRxOHio=;
	b=DM7HSrcUQA2ia4rDdvcTwIjaDnnMg9vbahBTrdOYchOIZHKqCKCzk0GVe+BStICW+irsAw
	sP0adkPlV18hRHCA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/64: Use RIP_REL_REF() to access early page tables
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221113506.2565718-23-ardb+git@google.com>
References: <20240221113506.2565718-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894956442.398.17374990463017406130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     eb54c2ae4a4825c42a6a2b4022926bda7448f735
Gitweb:        https://git.kernel.org/tip/eb54c2ae4a4825c42a6a2b4022926bda7448f735
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 21 Feb 2024 12:35:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:58:35 +01:00

x86/boot/64: Use RIP_REL_REF() to access early page tables

The early statically allocated page tables are populated from code that
executes from a 1:1 mapping so it cannot use plain accesses from C.
Replace the use of fixup_pointer() with RIP_REL_REF(), which is better
and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240221113506.2565718-23-ardb+git@google.com
---
 arch/x86/kernel/head64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index e2573dd..7e2c9b5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -215,13 +215,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(level3_kernel_pgt, physaddr);
-	pud[510] += load_delta;
-	pud[511] += load_delta;
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
+	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 1].pud += load_delta;
 
-	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
-		pmd[i] += load_delta;
+		RIP_REL_REF(level2_fixmap_pgt)[i].pmd += load_delta;
 
 	/*
 	 * Set up the identity mapping for the switchover.  These
@@ -284,7 +282,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * error, causing the BIOS to halt the system.
 	 */
 
-	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
+	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
 	for (i = 0; i < pmd_index((unsigned long)_text); i++)

