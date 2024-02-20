Return-Path: <linux-kernel+bounces-73113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A268285BDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5957E1F24FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47296A8B8;
	Tue, 20 Feb 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOznktuE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1bQgqf9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B16BB2D;
	Tue, 20 Feb 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437202; cv=none; b=gDYGpCwg4hfz+8KPlesjXXChOIimKkAu1AVd2AEpoD/LECqrfTNY03hNpLFGAvnzaowZPdDHzL4G5PEf01mcI2DgPFBFg+42jSapSG+iOznR4hWfh+GCYnQ0ETfroNzNFgWxDiNVhQoO6XHELMWU/PpmlMopTsP1lWCgYMUQlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437202; c=relaxed/simple;
	bh=F10nFbGUTPjXFdSlvkWXG5Crt8d0YCOIJtrTLvjfk30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QDBvBVU8uc0ALvydVX8KlIs2P0hGZhfmi3BCSpkZUKFJmdp6A/3QztOP7+zv2n59xn1KRRFK5kGGHHFdyt8yapV+TTZV/Nzi6TA/KemzKOOb5BFF07qwPjh69jrH8WNH4L5egYBkaEbdFrsKCahwaMAtIi9qeVJNF+cLSKFMkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOznktuE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1bQgqf9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 13:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708437198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX0qwnAkMiUZDtYX3kWdxqu2YK+FS1rZpMye7v8OPU0=;
	b=aOznktuEu1IKcWrjPohRsN40ufcs3rWAJjYG0PEyETNUuPzFT7wqv5AaN8GVVaTU5O1c56
	AuzPLQaqh0bQPE2q77Ltn9+ESmZ3Ygc90VHgRtzhaL2XwWjrmpVWT9A9WWKStwZtB7AC3q
	Xe6IAUH5ZQMX+sBhg9cvgP826GDEbTzsZEt65BgnsVzhl6J7Noyu6v+grvSewdrKPKWDcs
	9TEFitBqNcpAfzmCPP8y25fKug4w2mNqqa4QKcRTE5TKfYt3r977+3eAmbFl9lLVPm1w7R
	C7JbUO03u82v38b49r8p9viOun1+aRqRo6FJaU7GFu5HdkoMVXn7dO0c6rgs6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708437198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX0qwnAkMiUZDtYX3kWdxqu2YK+FS1rZpMye7v8OPU0=;
	b=a1bQgqf9rp6XLVtKbRf3BSsVHaveFHAXsFsH8uETq0skuEZ6n9ehx0sAMfYO7ThUYCHRqe
	EyHQxHBz3AZ4SACQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/pat: Simplify the PAT programming protocol
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170843719768.398.8004359782631430331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     ffc92cf3db62443c626469ef160f9276f296f6c6
Gitweb:        https://git.kernel.org/tip/ffc92cf3db62443c626469ef160f9276f296f6c6
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 24 Jan 2024 15:06:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 20 Feb 2024 14:40:51 +01:00

x86/pat: Simplify the PAT programming protocol

The programming protocol for the PAT MSR follows the MTRR programming
protocol. However, this protocol is cumbersome and requires disabling
caching (CR0.CD=1), which is not possible on some platforms.

Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
a #VE exception.

It turns out that the requirement to follow the MTRR programming
protocol for PAT programming is unnecessarily strict. The new Intel
Software Developer Manual (http://www.intel.com/sdm) (December 2023)
relaxes this requirement, please refer to the section titled
"Programming the PAT" for more information.

In short, this section provides an alternative PAT update sequence which
doesn't need to disable caches around the PAT update but only to flush
those caches and TLBs.

The AMD documentation does not link PAT programming to MTRR and is there
fore, fine too.

The kernel only needs to flush the TLB after updating the PAT MSR. The
set_memory code already takes care of flushing the TLB and cache when
changing the memory type of a page.

  [ bp: Expand commit message. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240124130650.496056-1-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/cpu/cacheinfo.c |  7 ++++---
 arch/x86/mm/pat/memtype.c       |  9 +++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c131c41..78afad5 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1118,15 +1118,16 @@ static void cache_cpu_init(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	cache_disable();
 
-	if (memory_caching_control & CACHE_MTRR)
+	if (memory_caching_control & CACHE_MTRR) {
+		cache_disable();
 		mtrr_generic_set_state();
+		cache_enable();
+	}
 
 	if (memory_caching_control & CACHE_PAT)
 		pat_cpu_init();
 
-	cache_enable();
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e..0d72183 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -240,6 +240,8 @@ void pat_cpu_init(void)
 	}
 
 	wrmsrl(MSR_IA32_CR_PAT, pat_msr_val);
+
+	__flush_tlb_all();
 }
 
 /**
@@ -296,13 +298,8 @@ void __init pat_bp_init(void)
 	/*
 	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
 	 * supported.
-	 * When running as TDX guest setting the PAT MSR won't work either
-	 * due to the requirement to set CR0.CD when doing so. Rely on
-	 * firmware to have set the PAT MSR correctly.
 	 */
-	if (pat_disabled ||
-	    cpu_feature_enabled(X86_FEATURE_XENPV) ||
-	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		init_cache_modes(pat_msr_val);
 		return;
 	}

