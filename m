Return-Path: <linux-kernel+bounces-111340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22698886AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB251F23E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09045029;
	Fri, 22 Mar 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWfS+fqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAj5FoBC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C664087A;
	Fri, 22 Mar 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105168; cv=none; b=hEu5e7YjfTEXdnuADXZuUeZTQMm3Mj0V6ATpGpScY0IiXok2oKbugg6iuohmzgfy9VXqsx14Mz/CjRlG6h6239CZLKgNbOIee2OBBJX1FCI+NPvgdC98W6xsTfAwmP9qEPBUApKh98z4mBzTCiS31B3PyTCHeMbBUTjlHtrZ3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105168; c=relaxed/simple;
	bh=L8qApaEcm1Jab7Eb/ytzipWabEj9vH8HAJLX5WXcm8w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ap39xo2P5LzEFNQAHWLqwvJ8ulSQ1nfy9BeYvpkcInQADcgdJE9SjAEO+n3m5hTc+jJ9J/gA3NcJOyOqbWETbfGWUTLRwRcDyqObQzl8BarGon4RjdgjdVxvxaZBEaLDZUXmiqYm10NiNeqV5D0g6qGhHV4jPxgVlyS0hySCsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWfS+fqr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAj5FoBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRfKt+7hzmv05KxTVMNBWwwlVI52HpCdKXBJ1bXzSW4=;
	b=FWfS+fqrLSHRvm5eFASMGt/CypGlh52bVW35V2y260vbv4Tpdirc9/UPb7cQt1+Dbi4fcS
	UacTlDDon4HKX8wgoLhM2t92gA0yVUD7/yU6dwTFDckk8WLi6VJ4cxnQM2wEhvPK6DRZDv
	/JFSIGaVIhI6E1M+10N/f/y7nwt6kdC9PNw1Xd83gx5xVhWMUrrf256bbeXzpv3mQkwWQ7
	E+BshcchCbotmjgqsPIkoKNgN5WzfjPEn46I2yhLXixuxCfdUQwi+FLk3k4sxeL3i30gLW
	zS3Kv1P/V/2irS3qERowF8e+TXGJjtNc3myj7WUYqfkNM7S6XMdiA9V7gWKMSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRfKt+7hzmv05KxTVMNBWwwlVI52HpCdKXBJ1bXzSW4=;
	b=VAj5FoBCcj+sIJsSkJxqSLJod3O8lBrX8W8Vwk1mbivboLKBNhw/yVT1gD1bPAEWZKfWIS
	B8vdSXgyWlIcDiBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu/topology: Add support for the AMD 0x80000026 leaf
Cc: Thomas Gleixner <tglx@linutronix.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240314050432.1710-1-kprateek.nayak@amd.com>
References: <20240314050432.1710-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110516470.10875.12388323344894124687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     63edbaa48a579bb167aa92aa5826888730819fa2
Gitweb:        https://git.kernel.org/tip/63edbaa48a579bb167aa92aa5826888730819fa2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 14 Mar 2024 10:34:32 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:22:14 +01:00

x86/cpu/topology: Add support for the AMD 0x80000026 leaf

On AMD processors that support extended CPUID leaf 0x80000026, use the
extended leaf to parse the topology information. In case of a failure,
fall back to parsing the information from CPUID leaf 0xb.

CPUID leaf 0x80000026 exposes the "CCX" and "CCD (Die)" information on
AMD processors which have been mapped to TOPO_TILE_DOMAIN and
TOPO_DIE_DOMAIN respectively.

Since this information was previously not available via CPUID leaf 0xb
or 0x8000001e, the "die_id", "logical_die_id", "max_die_per_pkg",
"die_cpus", and "die_cpus_list" will differ with this addition on
AMD processors that support extended CPUID leaf 0x80000026 and contain
more than one "CCD (Die)" on the package.

For example, following are the changes in the values reported by
"/sys/kernel/debug/x86/topo/cpus/16" after applying this patch on a 4th
Generation AMD EPYC System (1 x 128C/256T):

  (CPU16 is the first CPU of the second CCD on the package)

		   tip:x86/apic      tip:x86/apic
				     + this patch

  online:              1                  1
  initial_apicid:      80                 80
  apicid:              80                 80
  pkg_id:              0                  0
  die_id:              0                  4       *
  cu_id:               255                255
  core_id:             64                 64
  logical_pkg_id:      0                  0
  logical_die_id:      0                  4       *
  llc_id:              8                  8
  l2c_id:              65535              65535
  amd_node_id:         0                  0
  amd_nodes_per_pkg:   1                  1
  num_threads:         256                256
  num_cores:           128                128
  max_dies_per_pkg:    1                  8       *
  max_threads_per_core:2                  2

[ prateek: commit log, updated comment in topoext_amd.c, changed has_0xb
  to has_topoext, rebased the changes on tip:x86/apic, tested the
  changes on 4th Gen AMD EPYC system ]

[ mingo: tidy up the changelog a bit more ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240314050432.1710-1-kprateek.nayak@amd.com
---
 arch/x86/kernel/cpu/topology_amd.c | 19 +++++++++++--------
 arch/x86/kernel/cpu/topology_ext.c | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 1a8b3ad..6bc44ab 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -48,7 +48,7 @@ static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 node_
 	tscan->amd_node_id = node_id;
 }
 
-static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
+static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 {
 	struct {
 		// eax
@@ -78,7 +78,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 	 * topology_set_dom() would propagate and overwrite the already
 	 * propagated CORE level.
 	 */
-	if (!has_0xb) {
+	if (!has_topoext) {
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
@@ -137,21 +137,24 @@ static void legacy_set_llc(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_0xb = false;
+	bool has_topoext = false;
 
 	/*
 	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT and CORE shift from leaf 0xb first, then
-	 * try to get the CORE shift from leaf 0x8000_0008.
+	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * CPUID leaf 0x8000_0026 on supported processors first. If
+	 * extended CPUID leaf 0x8000_0026 is not supported, try to
+	 * get SMT and CORE shift from leaf 0xb first, then try to
+	 * get the CORE shift from leaf 0x8000_0008.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_0xb = cpu_parse_topology_ext(tscan);
+		has_topoext = cpu_parse_topology_ext(tscan);
 
-	if (!has_0xb && !parse_8000_0008(tscan))
+	if (!has_topoext && !parse_8000_0008(tscan))
 		return;
 
 	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_0xb))
+	if (parse_8000_001e(tscan, has_topoext))
 		return;
 
 	/* Try the NODEID MSR */
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topology_ext.c
index e477228..467b032 100644
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -13,7 +13,10 @@ enum topo_types {
 	CORE_TYPE		= 2,
 	MAX_TYPE_0B		= 3,
 	MODULE_TYPE		= 3,
+	AMD_CCD_TYPE		= 3,
 	TILE_TYPE		= 4,
+	AMD_SOCKET_TYPE		= 4,
+	MAX_TYPE_80000026	= 5,
 	DIE_TYPE		= 5,
 	DIEGRP_TYPE		= 6,
 	MAX_TYPE_1F		= 7,
@@ -32,6 +35,13 @@ static const unsigned int topo_domain_map_0b_1f[MAX_TYPE_1F] = {
 	[DIEGRP_TYPE]	= TOPO_DIEGRP_DOMAIN,
 };
 
+static const unsigned int topo_domain_map_80000026[MAX_TYPE_80000026] = {
+	[SMT_TYPE]		= TOPO_SMT_DOMAIN,
+	[CORE_TYPE]		= TOPO_CORE_DOMAIN,
+	[AMD_CCD_TYPE]		= TOPO_TILE_DOMAIN,
+	[AMD_SOCKET_TYPE]	= TOPO_DIE_DOMAIN,
+};
+
 static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
 				unsigned int *last_dom)
 {
@@ -56,6 +66,7 @@ static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
 	switch (leaf) {
 	case 0x0b: maxtype = MAX_TYPE_0B; map = topo_domain_map_0b_1f; break;
 	case 0x1f: maxtype = MAX_TYPE_1F; map = topo_domain_map_0b_1f; break;
+	case 0x80000026: maxtype = MAX_TYPE_80000026; map = topo_domain_map_80000026; break;
 	default: return false;
 	}
 
@@ -125,6 +136,10 @@ bool cpu_parse_topology_ext(struct topo_scan *tscan)
 	if (tscan->c->cpuid_level >= 0x1f && parse_topology_leaf(tscan, 0x1f))
 		return true;
 
+	/* AMD: Try leaf 0x80000026 first. */
+	if (tscan->c->extended_cpuid_level >= 0x80000026 && parse_topology_leaf(tscan, 0x80000026))
+		return true;
+
 	/* Intel/AMD: Fall back to leaf 0xB if available */
 	return tscan->c->cpuid_level >= 0x0b && parse_topology_leaf(tscan, 0x0b);
 }

