Return-Path: <linux-kernel+bounces-82938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9F868BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00FD1C21541
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1913664A;
	Tue, 27 Feb 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyVw1IEk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ExSMK4vC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FA135A6A;
	Tue, 27 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025455; cv=none; b=qnC90uPkIphWumZHp+yK5odqYymd1IFT+83+zHswEGJ+Yc0+YTTCplZXdizy/iSfHhP7LNHzjLcwDyYpT+mIM1QZ5xBPwp4uY4RmLFu7czRbCYQ7jQ10/Hyy5t1gvyrBRlIBpMdhIAffhSRyPjI7oEmJSRisgZnA2Fu7aIPcOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025455; c=relaxed/simple;
	bh=k55bHilAyaIlk9wtrJdwgBquS5Dn+sW/L1lBd9Z2+Mo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YD1jjXQgTrIm/MRf1A041vWbErtAIdJwUKCndz7Kwhi19YMTpeZDPyZfe0ZtuWdPyEB7vidxF1oyS7A2UzTjwkkw2dc6nHVszQNZ0sR4vsEMcBVZUjlefRbvtGm1mr2fuSurUZduzsDn55DNCOhdwsr8QkNjdc7sVer/81S0Dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyVw1IEk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ExSMK4vC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 09:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709025450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9fgbmiMWFTH/oklQmtly+YNcKTjM9YSszW1qoUugtUA=;
	b=kyVw1IEk7sxt2vobeSBUh91Y7p/YZ/WuoG5eoRznoPnJCZ4491Q3NxTgguv/Obi9+6pJSp
	0DiBU0sfhOKBS4VqoJzB0Qum6Kfgh973LvGNmEAHul+urOX5p9bWL6AT1MJd89aG669H07
	NvxItAFdsAcj/zEf8B49qOMWKX3fA4a8T0Pvh32ULpk9TTmAoNDst2HxpGxaxMr5Jny3H3
	27eQjqbos69d1fJ89mqfnNDyBHQtNJisasXTj1GrKcdAlsqIjlDevNz1KmTbFkymBJBRB5
	eC+n2aORgijd6RpA2gRfxOcJYZrueGOfBn45WDVsSGOrCyKoPi7FGclKNNYxCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709025450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9fgbmiMWFTH/oklQmtly+YNcKTjM9YSszW1qoUugtUA=;
	b=ExSMK4vCqyOMlqU/IV4xbrUa/iwwFPp//Pnf+2i3cJhAr1SWqFjr8jTbwLfLeHaxkm7Evj
	cM/F5iFsufAKboAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Build the x86 topology enumeration
 functions on UP APIC builds too
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170902544934.398.11994373587542888621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6be4ec29685c216ebec61d35f56c3808092498aa
Gitweb:        https://git.kernel.org/tip/6be4ec29685c216ebec61d35f56c3808092498aa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 26 Feb 2024 12:07:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 27 Feb 2024 10:05:41 +01:00

x86/apic: Build the x86 topology enumeration functions on UP APIC builds too

These functions are mostly pointless on UP, but nevertheless the
64-bit UP APIC build already depends on the existence of
topology_apply_cmdline_limits_early(), which caused a build bug,
resolve it by making them available under CONFIG_X86_LOCAL_APIC,
as their prototypes already are.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 41dd8e0..43650fe 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -344,7 +344,7 @@ void topology_hotunplug_apic(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_LOCAL_APIC
 static unsigned int max_possible_cpus __initdata = NR_CPUS;
 
 /**

