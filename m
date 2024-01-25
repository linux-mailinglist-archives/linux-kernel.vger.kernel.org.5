Return-Path: <linux-kernel+bounces-39102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1483CAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D11C224C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DB13BE94;
	Thu, 25 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AIJmbITq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGDFY4Tw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F454137C58;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206896; cv=none; b=Fj+FfbvBQyXz2GoUZlK9v5YXH2qZ9ilNLzNrK77qifGzRqBz/Itb7IAtP5EI4r3yOrmxClJu7Nn0kl+adCIaFPMMjcuUJwRryn+B75tdQ6S9Dm2P7UyVuagUMuyvLc35GESN5ymYZlNpNqZg+nrLp2UajJoN8JGNtv2tYkswUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206896; c=relaxed/simple;
	bh=tbVOLeeEOgHLi1PrtjmUtl7bQetxPuEHxll43T7DTzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KmF7nsn5C0lJChOd0Dqa99xcBnzA8bHWXmM+0peVEuHiE2SB9cXPJn7abZzUZNSGrW/bcX3Eipr3PjpNa+cKpLdlQHGKyE3IHW/mAmplwOM95qnAGn9s6yWuNTNFkSbkCffHFroD1j/S7tt1Z38bT99NyYqRqZPCKeBxg3SLSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AIJmbITq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGDFY4Tw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srO66qthsmGSXUgWMTcyGFhQLd+PWyCi6PXet+gYTkc=;
	b=AIJmbITqRq2nQR/74GtL6pEkGF+XP5p79jheKm+w5tab4yWXbj2cfIYkCndxAcrWiljd7q
	td2ZbwMe9woiUJRn5YUQ2akD5M1Hs++mrQBrur+aPKmMMqk6t+9yatsmuTv3S+bO2CPrgk
	N+MoJYJgJ6q7TYuEgZNcrXhKUOChO5h8AbPZ0F8J805FatDhR+YPz5qFOYqN/KSKkR3Y+o
	F+wRaIykaTOT4I1RvjyvRFM3ega9gNGWm2JZaok1ULnWk8puce3cL3Ug/fwGW4cMeswBch
	eYPAHL21l5n8nsrJa5iUZ9+ue0CxpTKcUjiyy2O7dYsckbukUX9su+AFZFll1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srO66qthsmGSXUgWMTcyGFhQLd+PWyCi6PXet+gYTkc=;
	b=pGDFY4TwdlxHSmEwnrqcwZMDHsGplG21x3RKM01sPHscDNPPzTsKyetfGvo+Wm6XHkdYZr
	rFWifXCrgXLxpNDQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Update MSR_IA32_FRED_RSP0 during task switch
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-18-xin3.li@intel.com>
References: <20231205105030.8698-18-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688878.398.1673947562730698297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     7a8aa729761a43528db58e73cf2cea938045991d
Gitweb:        https://git.kernel.org/tip/7a8aa729761a43528db58e73cf2cea938045991d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:06 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: Update MSR_IA32_FRED_RSP0 during task switch

MSR_IA32_FRED_RSP0 is used during ring 3 event delivery, and needs to
be updated to point to the top of next task stack during task switch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-18-xin3.li@intel.com

---
 arch/x86/include/asm/switch_to.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index f42dbf1..c3bd0c0 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,9 +70,13 @@ static inline void update_task_stack(struct task_struct *task)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/* Xen PV enters the kernel on the thread stack. */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		/* WRMSRNS is a baseline feature for FRED. */
+		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
+	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
+	}
 #endif
 }
 

