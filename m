Return-Path: <linux-kernel+bounces-142476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A58A2C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7C51C21C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053054668;
	Fri, 12 Apr 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PeZ4nXUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXgUwQ5H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10B537F0;
	Fri, 12 Apr 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916758; cv=none; b=SkmcfLIAM4AD/Yi1BvCya9F1ZnSJpXmsRawcesbubXZlW71B2LE5Coe0C3kPdX1ozhoLX4c1g9auQ4WgviuEMDiGnOgeklgnf7n3z3PMXeP+TP1XBpRfySsgByPRu/3zD+17gZGVRnI7dEKAFUuyuayg+rkKuPXuvKBzlCrTciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916758; c=relaxed/simple;
	bh=Sv/iz4fsVLN3SDNEaAbHbPFrwBswqXlygCmBS3lc/sI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pHqwejSNrQa8faoVjMrx2J8uFuBDtWJmteLfuHBT5b7+6YdoD2N4gv+MLuHahLVeTdnXMUgH3jOPJ9asPsaLNUMvNqTxmADI55V4RwWy1G6MbbWHPzzmvFS7h7TVEm53p4L4qLcKWTRejNvfBLoqJKoPTOv/JQ3bLCRgvj4DBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PeZ4nXUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXgUwQ5H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW006dSTHfxDSqkDlcxMkyRtDlz6axbhziymCCokkXM=;
	b=PeZ4nXUYkTXJXik0ZaRREkX/ENwajzohzpBnz3Yyxcwszxke3s7g4FYRIgDoDpBX/H3sp3
	5Fl7EdkmUcLunFXaCMWaWv3ea2tS/4kmgVJXteZKZ4wYGnb9m4tz1TRFPOVnA5r9piW/La
	pc/sxSwBi+RqCoVH4dcKCKjQGRdhtgd3T4nmVDFZc60CU6QAJcZWc4+/nU4N62X0DSt2KT
	ITzX8ugkn8Z5ajvEbjMh6DB9PLuqt4SgibKvBXwwnY0EAGZODPeTijznaUwP0DfUs5d6GB
	Xz4chbZ03FML2rsyepW4QRaoQ7KGVAvjsvultRnkAicX7RFQ/xTfBkYXxFpZFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW006dSTHfxDSqkDlcxMkyRtDlz6axbhziymCCokkXM=;
	b=XXgUwQ5HRkglP15W3H2Yby+OvKNUUq5lLYDM3qUPhMJFncBzO28zWODOgX04rl3gahqICg
	Z73DCZDjE6Rm86DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu/amd: Make the CPUID 0x80000008 parser correct
Cc: "kernelci.org bot" <bot@kernelci.org>, Laura Nao <laura.nao@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410194311.535206450@linutronix.de>
References: <20240410194311.535206450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291675496.10875.12934937833830310501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1b3108f6898ef2e03973d65255182792e94e2240
Gitweb:        https://git.kernel.org/tip/1b3108f6898ef2e03973d65255182792e94e2240
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Apr 2024 21:45:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:05:54 +02:00

x86/cpu/amd: Make the CPUID 0x80000008 parser correct

CPUID 0x80000008 ECX.cpu_nthreads describes the number of threads in the
package. The parser uses this value to initialize the SMT domain level.

That's wrong because cpu_nthreads does not describe the number of threads
per physical core. So this needs to set the CORE domain level and let the
later parsers set the SMT shift if available.

Preset the SMT domain level with the assumption of one thread per core,
which is correct ifrt here are no other CPUID leafs to parse, and propagate
cpu_nthreads and the core level APIC bitwidth into the CORE domain.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Laura Nao <laura.nao@collabora.com>
Link: https://lore.kernel.org/r/20240410194311.535206450@linutronix.de

---
 arch/x86/kernel/cpu/topology_amd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 1a8b3ad..79a85a4 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,11 +29,21 @@ static bool parse_8000_0008(struct topo_scan *tscan)
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
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
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

