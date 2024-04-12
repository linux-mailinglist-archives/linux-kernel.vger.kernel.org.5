Return-Path: <linux-kernel+bounces-142485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9F8A2C33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2962866F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DE53E18;
	Fri, 12 Apr 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxHbU8kK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yt8J73xq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD653811;
	Fri, 12 Apr 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917271; cv=none; b=N9v5LYE4EWiaZTHEtVmP0bU7ZNW6DZpjMl338CzNF25M9s4PY+LF2yZCcwrJ9V4s5UwrT4ZKSouyHimsTMpuxES2StB2bTY6meFUkktglbK9y1NmbATNH3sE5AZJH1OthAZ1g281Vpdh+mq/idDZBJqO/egA+YOFzHmmq/hEFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917271; c=relaxed/simple;
	bh=JVyKZModDr1qU8aaxNP3qEOapE9YnY6EJSdPKWcfdLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=guHkqP9+kzUcBr4iL5n51I0TtKD7iWEaDLkyAzj1qjOCvpo/UmL3QMwAV6fhI+xvBJV5zbAQcx6kphNkjVeUK7jQHNhVxTXoza7wqxPKzmyTknVkCFshghxIXZnFIMamRnVlcrSCpf915jIUq3L0buY73ss9GJneul5Rmo6FtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxHbU8kK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yt8J73xq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712917268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQPgZXmmmqsPeLKY0b46Knt9me/j1y2tQ4a5ceDyRQM=;
	b=kxHbU8kKTiyHNB6xvgoXoZxFqJBxxKsdbLVMpfgKrw5UxQ/XiRAwG5WKfRMFBd+zunQCjF
	MtXyl3OPGj3m2BrzRu3fWXFKsC4lV98gRNUgOu5pFoqS8RyxXzcNYb1bqoUprceLU7jd24
	7byF8KI3UB4Js82oYoHgrvQOnJjbS0h5q7R1zvOJbH+bgANvHTMB4Q/UyPrY/GEmEnPhzB
	HSr4ZAZCqSYu9PiRcwiIThQrW652mElv+LL2jvy3bYN13W8EVQWX8blTW3Xh26nvVBuriz
	Z5Yw9K1q92WhR7fe/I8itOdMxZDsr1r8D9qEJ9JnAdCXOJpNuZcVSq26bH3buA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712917268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQPgZXmmmqsPeLKY0b46Knt9me/j1y2tQ4a5ceDyRQM=;
	b=yt8J73xqA9J2wOqH+b/qKLKNC8jVK4jhWjyJrlN0V+uSG1felY6/Wbj9bhZGZSFDTfJPKn
	a2cPTbZMEddEF8CA==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/sev: Take NUMA node into account when allocating
 memory for per-CPU SEV data
Cc: Li RongQing <lirongqing@baidu.com>, Ingo Molnar <mingo@kernel.org>,
 Nikunj A Dadhania <nikunj@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412030130.49704-1-lirongqing@baidu.com>
References: <20240412030130.49704-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291726722.10875.2860391498584400458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     90167e96588df747c9b47a04ebac59b71e3b413f
Gitweb:        https://git.kernel.org/tip/90167e96588df747c9b47a04ebac59b71e3b413f
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Fri, 12 Apr 2024 11:01:30 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:12:11 +02:00

x86/sev: Take NUMA node into account when allocating memory for per-CPU SEV data

per-CPU SEV data is dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240412030130.49704-1-lirongqing@baidu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 38ad066..995f944 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -938,7 +938,7 @@ static int snp_set_vmsa(void *va, bool vmsa)
 #define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
 #define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
 
-static void *snp_alloc_vmsa_page(void)
+static void *snp_alloc_vmsa_page(int cpu)
 {
 	struct page *p;
 
@@ -950,7 +950,7 @@ static void *snp_alloc_vmsa_page(void)
 	 *
 	 * Allocate an 8k page which is also 8k-aligned.
 	 */
-	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	p = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
 	if (!p)
 		return NULL;
 
@@ -1019,7 +1019,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	 * #VMEXIT of that vCPU would wipe out all of the settings being done
 	 * here.
 	 */
-	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page();
+	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page(cpu);
 	if (!vmsa)
 		return -ENOMEM;
 
@@ -1341,7 +1341,7 @@ static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
 
-	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
+	data = memblock_alloc_node(sizeof(*data), PAGE_SIZE, cpu_to_node(cpu));
 	if (!data)
 		panic("Can't allocate SEV-ES runtime data");
 

