Return-Path: <linux-kernel+bounces-144369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271C8A4518
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555F81C20938
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DCE136E32;
	Sun, 14 Apr 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CydMZzOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9JjdBFB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA633987;
	Sun, 14 Apr 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126666; cv=none; b=n8+x/equEM9y5NMjMQb2nE6CEdPO6BB4hQeV4s93rhiJx8cWUuyc5SS5kQXp9Cgho4hTFUyCSJJKsvUwKxKkAX0k5dQL21v4eAJdc6ndgCgd8bT8siBFZXLWiQbznSaJgGMQwVA2TyYt5Dt2VY0eiMeRPi2zEqRHuKwk0y+itO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126666; c=relaxed/simple;
	bh=XVyNXN0mpVSJMNZkcqiI/rgTU+Os5W+Gfry5axilQbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g0102qpszhg8EnDwIHTctI29WWpz5mncorxfQq2eA8aJ3rM/6cVMAoLKkdwBXfU8mwlr45MoYH6jGbN4pCO7fE5hy6RfG53Grr4QeiwrkH3A2Tx7aLSGCm32iJ6/DZVLjKHHQyhkuDBYv0ohcHO+LmnLLFjjYPAvPmLRev/aEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CydMZzOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9JjdBFB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713126661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEWIl4KDqMemR3mndRvBxrWeqsCqBLjmGHnGt/dvOlE=;
	b=CydMZzOLMA5h7PXQNLNOMuaP5pmh0TJd9TGBuQWz7CbYWQKIBzrZPxXw4a2yF3OIJEOEso
	jxQ1MxD0pQ29gPcjUVv581zBE75trRcx/joMvNAGtNs/SIU3Ctxuqnk3GcWugMJGLE86gZ
	hhpnrmEPCIOarBsfNdx0dreJijQvEqg8dadyaUkZ9T8Nc7cyqmwqWrjWyrNbA+HuununmH
	bvREY9qBcgb3yUSLtcKVkJdOtDQx29NdaOfyWOcumkbh6EYah7zUxk8yNiGSIFptdFSkwA
	DnRr2G96UH4fENiDvJS+xVSOJC/yNq3N4h5qz8m16qzrQmA1YiGX2yRQ9xFxdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713126661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEWIl4KDqMemR3mndRvBxrWeqsCqBLjmGHnGt/dvOlE=;
	b=q9JjdBFBUTyNBU+sCN1Ma1qEtLqbTVIUCkxziNrEL8GBV20H/ukB9kHlZQ2IT/wiSGR+aT
	4LvMMsxhJu2E09CA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Use lookup_address_in_pgd_attr() in show_fault_oops()
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412151258.9171-3-jgross@suse.com>
References: <20240412151258.9171-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312666079.10875.8827787983128820816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d29dc5177b7d011377ecf648551027c94d2b1386
Gitweb:        https://git.kernel.org/tip/d29dc5177b7d011377ecf648551027c94d2b1386
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 12 Apr 2024 17:12:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:16:27 +02:00

x86/mm: Use lookup_address_in_pgd_attr() in show_fault_oops()

Fix show_fault_oops() to not only look at the leaf PTE for detecting
NX violations, but to use the effective NX value returned by
lookup_address_in_pgd_attr() instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412151258.9171-3-jgross@suse.com
---
 arch/x86/mm/fault.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 622d12e..6b2ca8b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -514,18 +514,19 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 
 	if (error_code & X86_PF_INSTR) {
 		unsigned int level;
+		bool nx, rw;
 		pgd_t *pgd;
 		pte_t *pte;
 
 		pgd = __va(read_cr3_pa());
 		pgd += pgd_index(address);
 
-		pte = lookup_address_in_pgd(pgd, address, &level);
+		pte = lookup_address_in_pgd_attr(pgd, address, &level, &nx, &rw);
 
-		if (pte && pte_present(*pte) && !pte_exec(*pte))
+		if (pte && pte_present(*pte) && (!pte_exec(*pte) || nx))
 			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
 				from_kuid(&init_user_ns, current_uid()));
-		if (pte && pte_present(*pte) && pte_exec(*pte) &&
+		if (pte && pte_present(*pte) && pte_exec(*pte) && !nx &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
 			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",

