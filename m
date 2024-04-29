Return-Path: <linux-kernel+bounces-162011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A58B54A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AE7282B92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FA37169;
	Mon, 29 Apr 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wknvbaBk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXoDrnZl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3C29417;
	Mon, 29 Apr 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384769; cv=none; b=UzZVgtHp91UONaIcNYIMoZP792KH3rkX4Yq0pD3JZ2yP9xI7Q13shaTLkN6liE3h/HgJS2t+AW+P4cS2nk9KfpyqBZnMG6PZMP29pnaGNsusKIhx7rn6oidlJRtT5xl9pafnzI3gGZWswT4v5LhdD6q7XOSZngOTLWwbK4vBfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384769; c=relaxed/simple;
	bh=618Ht5sQN7cvDQn9y7z/TO5cIwP64Tib06AKDNbinzk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bV2169SwpyCFGWV/7IVy7rVZ73o3zn5ghSs1XR3LG8clmVyXYrcPS7lBWMvKUvwSE+f5tkoShlsjD7ofNrDJpfAlPwzTAGQashgYe7qADgMtxLbnDJa839IUveDaPG1TWM7Ao1fRWD1G1Zlt6ancWBXtL26zKHHu+ePR8kcSXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wknvbaBk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXoDrnZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:59:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714384767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ68DXZweSDumHrrncy9eWT86yysvaQj1x6YgCYqxh4=;
	b=wknvbaBkso0BnWe+NgMo0aECx1Q8tiSzpXuHFp+yti/762bW3c1pLQKaeX7UkZvSV0WoP5
	K3frBH2ZWGk56jP6CULnmMFmUuL4s6DcUd15NNj37fyci6DRro+72RDX5HzzhS7vDvzoNB
	Ut1Nsxvo5QQ7hVxEHmHcChUvZySpTA+DB6knMOCGEMdsOtSlg8csyWGsk/COKeqbVcfIRv
	KYXbvfHlcTbsI/RiS1atm8ngD029/Frdjq5hEpEht19qiQ8GSHJXcqKxXcqLQhay+mVSXO
	qY7FPFF+JTYS5CYDCjLf1ay13BP0Cqi7tMD9nJsB52u5oXqXcqkucs9hdHlC9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714384767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ68DXZweSDumHrrncy9eWT86yysvaQj1x6YgCYqxh4=;
	b=zXoDrnZl4kPwYEy6H1I4zWZTZRtp5loYwTQcRjYop7bCKJEfRnGGOGuvYkCc2Aa+qLZsXr
	Mj8csI5aOz1c9QCw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/e820: Add a new e820 table update helper
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb726af213ad55053f8a7a1e793b01bb3f1ca9dd5=2E17140?=
 =?utf-8?q?90302=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb726af213ad55053f8a7a1e793b01bb3f1ca9dd5=2E171409?=
 =?utf-8?q?0302=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438476660.10875.13006224589084593914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d6d85ac15cce4dcf02cf8c96cb970562be6a3529
Gitweb:        https://git.kernel.org/tip/d6d85ac15cce4dcf02cf8c96cb970562be6a3529
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Fri, 26 Apr 2024 00:41:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 11:15:31 +02:00

x86/e820: Add a new e820 table update helper

Add a new API helper e820__range_update_table() with which to update an
arbitrary e820 table. Move all current users of
e820__range_update_kexec() to this new helper.

  [ bp: Massage. ]

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/b726af213ad55053f8a7a1e793b01bb3f1ca9dd5.1714090302.git.ashish.kalra@amd.com
---
 arch/x86/include/asm/e820/api.h | 1 +
 arch/x86/kernel/e820.c          | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58dd..2e74a7f 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
+extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 
 extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379..68b09f7 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -532,9 +532,10 @@ u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
+				    enum e820_type old_type, enum e820_type new_type)
 {
-	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
+	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
 /* Remove a range of memory from the E820 table: */
@@ -806,7 +807,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 
 	addr = memblock_phys_alloc(size, align);
 	if (addr) {
-		e820__range_update_kexec(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_kexec, addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		pr_info("update e820_table_kexec for e820__memblock_alloc_reserved()\n");
 		e820__update_table_kexec();
 	}

