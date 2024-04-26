Return-Path: <linux-kernel+bounces-160540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E482D8B3EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BD0284AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92516EC1E;
	Fri, 26 Apr 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzJPoru4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImqY97hf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AD16D9D9;
	Fri, 26 Apr 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155134; cv=none; b=V6bETizMYYr0+s+zlGmgR1GWDJMVaoc6WnmKvHscIPeIJ4kbdeOUZL9Oi64Zu4uRc1JREFr+pYzNwa3UV58ofSpCM8YzUEJXJ4XIoKN9nSsijr6s2M5kdZRBeZnbZMek1fpKvlqydg0n/KKJL/qzm/0a2OV9MBDyiv9nJgtVKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155134; c=relaxed/simple;
	bh=2SxsM9/KTiM2rDJjZRYusx4RJqELJKDeOLSUfqsmCHM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IMBt30yI7jmfIj2KTF0/O01PYp/GjuRIbtf1gJR44vHA5hs7AX/tbe3FmJcErovcBLsHG9nkUVHfsO/nOweW6EAB7NiKJxKpagczdYR2rEFG/ININK16zLJ/E0NElPxYJy4FvyQa2A7sahsweTciXuzAmBsivmTxr427UYxgcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MzJPoru4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ImqY97hf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B4+uymQV0xm4ulP/bIWXMI+SuZQlTKv7YrsIdT3m9pY=;
	b=MzJPoru4/yyimy+1er5JjSgctNEIzsP6MzKtco73zPLnet0P52Gno+NQgDdJ4+RWGnXo57
	agFOu3GaKPfuyH2LWt5WGfcXRJuwD6+SQCPOyYMsXMaGszo5ePMVe73rIjXWLGR2QdqUHw
	37NMWrc1+xRLycQLBU2r//pT3412TzTZTAsM2gP9gh2uYki7ndiR6sbevDUaLNwKqf6kdH
	aYPXLhaTqLnyl7sEJkW4swA3Hf/Na7S/LXR+s5KtKfAkK+G9PiP5Ld8FeHbawEaZCYf9DB
	PFlFk/+wBA+MZcltKNw1ri3G8Qb4WqFg5wvGVbHTQobqTct8Zt4Hj35xfQaUuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B4+uymQV0xm4ulP/bIWXMI+SuZQlTKv7YrsIdT3m9pY=;
	b=ImqY97hfBBJbydNZ3ull0UaheY/idI2T0Wc6jEsCGcz/jO/xJ90Azb9vVeiNROohUpG8TM
	ruGgdneSTboU4FCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/resctrl: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513086.10875.477919485403694317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     343ec8beae3088478b5b742971dd1d4939223eff
Gitweb:        https://git.kernel.org/tip/343ec8beae3088478b5b742971dd1d4939223eff
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:14 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:25 -07:00

x86/resctrl: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181514.41867-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

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

