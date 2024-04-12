Return-Path: <linux-kernel+bounces-142414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E65E8A2B38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2531C230FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB750A6C;
	Fri, 12 Apr 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6xx9wWV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yh8Ud/Ts"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0A17742;
	Fri, 12 Apr 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914248; cv=none; b=HQdK6wr8c1jvP30c0S7bKfx6GScW19SgzbXyHdpWwrEraAeyj0m1NdJn/Kzc9rzddlBGwvdForzBskIpIYI5YuoN2//GPQ18dJnTb2hrxUwYAStPdXXPN8q7/MgJ7cCZT263j2nRb+xR773hwT7TJOMgar37xM9+jKyKMOmbHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914248; c=relaxed/simple;
	bh=KXBKsENv3/qYMNG6XcbGWAoRgPxC+ZNfUnRYJJFEX4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eAS27HYGCzQop++vBejS6Zs5YvyVDLEXGAg4FS1TgO2ldDR5nZJVbVIUO7icU3ZoJN2BSPlrWQpQEnE0kva664m0J4IIwjpQhQVfOnS2P94Ijn2roNCHIxbMJH+aYeEbl4NzKp2U7g7vrtLCwJIDuma4lvtMEVfDM9X7/XCermw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6xx9wWV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yh8Ud/Ts; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:30:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712914244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWU+2DOu8uZaUnaW9pfGZZkuf1OU8vCAAv51aFmuGkI=;
	b=N6xx9wWV5kuHyma8pwVuJKk9rcfPkfBeaLGZ0H/DpADIFxmXVXHu6K5bTHSqbjjDzFEJbN
	WHypUTshKg1Zb6G9XJg8OZq8hYSD9qBkd8gtlBNuekBeF5LBeFIX+4Kd96XDqLhDLptBZt
	6rtPPSRVDj9C9lzgA7M18Ppz1tjpGyQdRvg0r9Ql2A4nu7vnmpxcrOOCNlRiugkkkx6Kgj
	Zac0jAIO6ugrnWYectIUtKicI8Fe/fco9bRwK+OtT0cR03EjwfY3PyRhxP+hKFOFO0RE4T
	B2HTZhUODQDl8xbDDFNXrKaKAgREYVVLEex7mVPsTTSo6x2L8kKCwRismIQoIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712914244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWU+2DOu8uZaUnaW9pfGZZkuf1OU8vCAAv51aFmuGkI=;
	b=yh8Ud/Ts44+VgUOIfF66WRUHE7+002SYmUTpcpdCIqpwJxI4aN03Ho8zRNZUz1xXsuJYYT
	zl0jt+4AjvQ6ZGBA==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/sev: Take NUMA node into account when allocating
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
Message-ID: <171291424272.10875.9437012394556385229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     426565279f161631cbb4b925660540bdb65f2201
Gitweb:        https://git.kernel.org/tip/426565279f161631cbb4b925660540bdb65f2201
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Fri, 12 Apr 2024 11:01:30 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:25:26 +02:00

x86/sev: Take NUMA node into account when allocating memory for per-CPU SEV data

per-CPU SEV data is dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240412030130.49704-1-lirongqing@baidu.com
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
 

