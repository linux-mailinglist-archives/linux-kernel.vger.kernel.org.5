Return-Path: <linux-kernel+bounces-139272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C525C8A00CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6641F22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4939181BA0;
	Wed, 10 Apr 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3+QjEn9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wcziyeX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF45181338
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778331; cv=none; b=W+BL67U6IgZUYDqGoskoU2K+VGWpldIQ929CKGbiBVEP9KYqPozIIkLOmDBDYctT8SMfokiLxXAMSQ3DUKTKjWcqURr7Oo9vP4HD/xV6tcRRyvuFdYVH9mZfwiWq7nG14uDBYM+IHpKXzATtzmO8pGOn3vPfCAheDHf01DEqSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778331; c=relaxed/simple;
	bh=dZUlHm/b0wE71ot1CLGssUGWsNoWHLI/UCGfl681jac=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=m3E05evtefSuqqlOL+stmgxvCZk3modJGRGToKxYiqNKM/+C+4PQ/56RAL/wGZqmiuG3ktklvVn2pp9eoADi78HX7FWZQpyDOpTIZi9SqeltYJIWTC4i07lUWAVyUp2skHcXTJoY0tvNuRfyjmY17zrowp+QLqlB9uzkxMjJFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3+QjEn9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wcziyeX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410194311.535206450@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712778327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lhSd6tiJE/Sl28VhrdIMe3s1miIhls/aJ5wARsG2IxE=;
	b=3+QjEn9jZCjTc4gpY9d5J3i1tTqPeo401PR5U1j14gouCfZfuGPyC/DkfVFi79YcJMjmE1
	0TtjqzVF7186piq1ARxFf4EPEc24wKGiF0qEvOrufC2/zlRDpzfcw/HkKdJXB0ROuxB7JW
	FNXVGHFIBzR7bom0ZxA08oCPFoP7+f1vFTnd4fxCdwFqybJgolwO/B5SjUg4BlJ9CTb2WT
	BB+Jtd8cCejFRkB7C0SVByPozpFIopsb0oiLAFmn16xog0Bf9yt8oAWtfNZhnVkq/7vB+M
	JrUjwCB1LgQNkKAnZ6n3Pw9WEoIy3A5BV5Th7mAVeY8H9g26ZxnuP8Gpr8N8Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712778327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lhSd6tiJE/Sl28VhrdIMe3s1miIhls/aJ5wARsG2IxE=;
	b=4wcziyeX6iSaCSI9i22IBq8BcRQ5px7EbGpOXZXPzpwRPDXiza5UfhTn1NHkRytC0l7Pwi
	tF5ebepx9e2AYSCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Laura Nao <laura.nao@collabora.com>, x86@kernel.org,
	kernel@collabora.com, regressions@leemhuis.info,
	"regressions@lists.linux.dev" <87il0p2era.ffs@tglx.smtp.subspace.kernel.org>
Subject: [patch 1/2] x86/cpu/amd: Make the CPUID 0x80000008 parser correct
References: <20240410161141.261818-1-laura.nao@collabora.com>
 <87il0p2era.ffs@tglx>
 <20240410194002.909839385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Apr 2024 21:45:27 +0200 (CEST)

CPUID 0x80000008 ECX.cpu_nthreads describes the number of threads in the
package. The parser uses this value to initialize the SMT domain level.

That's wrong because cpu_nthreads does not describe the number of threads
per physical core. So this needs to set the CORE domain level and let the
later parsers set the SMT shift if available.

Preset the SMT domain level with the assumption of one thread per core,
which is correct ifrt here are no other CPUID leafs to parse, and propagate
cpu_nthreads and the core level APIC bitwidth into the CORE domain.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology_amd.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,11 +29,21 @@ static bool parse_8000_0008(struct topo_
 	if (!sft)
 		sft = get_count_order(ecx.cpu_nthreads + 1);
 
-	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
+	/*
+	 * cpu_nthreads describes the number of threads in the package
+	 * sft is the number of APIC ID bits per package
+	 *
+	 * As the number of actual threads per core is not described in
+	 * this leaf, just set the CORE domain shift and let the later
+	 * parsers set SMT shift. Assume one thread per core by default
+	 * which is correct if there are no other CPUID leafs to parse.
+	 */
+	topology_update_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.cpu_nthreads + 1);
 	return true;
 }
 
-static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 node_id)
+static void store_node(struct topo_scan *tscan, u16 nr_nodes, u16 node_id)
 {
 	/*
 	 * Starting with Fam 17h the DIE domain could probably be used to
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_
 	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
 	/*
-	 * If leaf 0xb is available, then SMT shift is set already. If not
-	 * take it from ecx.threads_per_core and use topo_update_dom() -
-	 * topology_set_dom() would propagate and overwrite the already
-	 * propagated CORE level.
+	 * If leaf 0xb is available, then the domain shifts are set
+	 * already and nothing to do here.
 	 */
 	if (!has_0xb) {
+		/*
+		 * Leaf 0x80000008 set the CORE domain shift already.
+		 * Update the SMT domain, but do not propagate it.
+		 */
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);


