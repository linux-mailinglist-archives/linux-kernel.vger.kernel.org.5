Return-Path: <linux-kernel+bounces-161944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB58B53A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736751C21209
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1422EF5;
	Mon, 29 Apr 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shxBtztt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eG7DvdLU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E651B94D;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381322; cv=none; b=muA6MGByJNfgZODCfqQignf0Q51JAcZaA7WYQ7bNodBAXkxaCG30awWjhchsHKs+wPBTvtLUcP9BWtq5Wugw+26BE7p1ME1X7iYvJzybHX3zRXQxhyYR4p8PawgqGvViYhNuoGnkvg1jpwnpsXfEnPG5NNimrvETur9L3pn/PXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381322; c=relaxed/simple;
	bh=VwiSlRRDbWDn6PdVwR+hV6UDvWxYg6QVXvMzs6ZC2xo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X2QQhtDeRhspg2KbW0PzxsWYxsg3q49VCJ9g1TGp5Hkafr4XhWfh5geYPFhBt+AxdIH1Sy9VcvNLIiqa5iHm/b0qjFWPvqAkG+bBEUWpnDWCEMmoP+GPRUkpvZ0X4gnb5VoFNxys17fUb6jK54UxvaylX01y6lmnH5ovJgh2FyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shxBtztt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eG7DvdLU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UBQ3/xFHvmOkKBZDD2JTU+kk6vyyWU5opa7TLojmLdo=;
	b=shxBtzttrWnDEUIckBIG70YY26dh2EmQZur+3za9XpgiJ9z8L4fGAAWR+Ois0u6ONB3KaD
	F68jaN2WiUwEmJMwrj5wXoFb7jYPaMXLDlxTvKRL1FexvjiQzGzkMlPLVjF5iFbRETtNTn
	PrelRL7W/4fvmy/gfVQS9oBxJPIOd+YOV4G8J/zIbiIXClpk5hc3XD9NkUF2Ix6Mzu47Fj
	HuYBNTgTDcAMYQi8Xh4DKH4eLIrxD1RzzA+UO0bfxohGC9Lm26W6376wT2IqlO1WBte1Xb
	hPMmaqMZGJV3J88XbJACvW8h6J6ElCYzPy3lHLR5UrkEjXF6h8QXxBBwHxD5wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UBQ3/xFHvmOkKBZDD2JTU+kk6vyyWU5opa7TLojmLdo=;
	b=eG7DvdLUiWFryJR5XPCa3XoiVDZy0lSLpRfh/izx6qeb/B/J3FQlK/siJz3DFasU8XLGmF
	0P//PXiFh7LCUsBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/resctrl: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131416.10875.10178202659609684261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     db99675e4338e97e1469aeae5564e8242bd8fd6a
Gitweb:        https://git.kernel.org/tip/db99675e4338e97e1469aeae5564e8242bd8fd6a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:14 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:28 +02:00

x86/resctrl: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

  [ bp: Squash two resctrl patches into one. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181514.41848-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 22 +++++++++++-----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e4034..19b4fdb 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/resctrl.h>
 #include "internal.h"
 
@@ -821,18 +821,18 @@ static __init bool get_rdt_mon_resources(void)
 
 static __init void __check_quirks_intel(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_HASWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL_X:
 		if (!rdt_options[RDT_FLAG_L3_CAT].force_off)
 			cache_alloc_hsw_probe();
 		break;
-	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_SKYLAKE_X:
 		if (boot_cpu_data.x86_stepping <= 4)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 		else
 			set_rdt_options("!l3cat");
 		fallthrough;
-	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_BROADWELL_X:
 		intel_rdt_mbm_apply_quirk();
 		break;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e..04584a7 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -23,7 +23,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
@@ -88,8 +88,8 @@ static u64 get_prefetch_disable_bits(void)
 	    boot_cpu_data.x86 != 6)
 		return 0;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_BROADWELL_X:
 		/*
 		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
 		 * as:
@@ -100,8 +100,8 @@ static u64 get_prefetch_disable_bits(void)
 		 * 63:4 Reserved
 		 */
 		return 0xF;
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_PLUS:
 		/*
 		 * SDM defines bits of MSR_MISC_FEATURE_CONTROL register
 		 * as:
@@ -1084,9 +1084,9 @@ static int measure_l2_residency(void *_plr)
 	 *     L2_HIT   02H
 	 *     L2_MISS  10H
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_PLUS:
 		perf_miss_attr.config = X86_CONFIG(.event = 0xd1,
 						   .umask = 0x10);
 		perf_hit_attr.config = X86_CONFIG(.event = 0xd1,
@@ -1123,8 +1123,8 @@ static int measure_l3_residency(void *_plr)
 	 *       MISS      41H
 	 */
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_BROADWELL_X:
 		/* On BDW the hit event counts references, not hits */
 		perf_hit_attr.config = X86_CONFIG(.event = 0x2e,
 						  .umask = 0x4f);
@@ -1142,7 +1142,7 @@ static int measure_l3_residency(void *_plr)
 	 */
 
 	counts.miss_after -= counts.miss_before;
-	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
+	if (boot_cpu_data.x86_vfm == INTEL_BROADWELL_X) {
 		/*
 		 * On BDW references and misses are counted, need to adjust.
 		 * Sometimes the "hits" counter is a bit more than the

