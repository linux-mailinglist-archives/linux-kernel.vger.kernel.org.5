Return-Path: <linux-kernel+bounces-160544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9838B3EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84794282919
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02517166C;
	Fri, 26 Apr 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8NIXUqP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fxADUvuj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CB16F286;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155136; cv=none; b=OAQEkNjnFoKXKqkrc+hpTMPv5by5Je3EXNNnxaNyeCn6y9ltCQGbQLklmoCfP5w57X7p4Yf2nGuAttyxbUiu09j29aEPT7/kFzRb1YGMKzyBBJj83niGZ2AIyuvaUInUFmclIJUBnUcr7ziSxCF4UB6GaLg8Uhf9rENEXukFhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155136; c=relaxed/simple;
	bh=h0b4k/XqMQwgx2DYUqZ6i02mii5cmAvllGU/fiwM2Jo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AeRdFxKvvlKoW1g1+2/mW884bBDnDodHzj/gDLv//4aMdqVS/g1gVL0HPpH/o8g6cC5sILdQ6Kk4JR3xGC+EwnD0c+/PdzYiOa0yDWLD8gtOQeA0Uid2tgK2X4kcvOq6B6z8d4v3p2zk99LeeREwLZ/LjoJCECcT6j/sHZoLlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8NIXUqP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fxADUvuj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J5j1bl4UOmD+ypsjf5YaMXZwvI//YUaWIc4ZlShfPc4=;
	b=A8NIXUqP+0bh8FJG7booEJV+djI48fPKIEs6A58lvYJB59vAm/spBM/DsV5LtVMnQLlRQ/
	YwqLiX2i43qyFJ1Huco7sky6dnN9aL4OmW0PsaLHkvMMESoHsaXTdnODlRyeJbG1hOhWYh
	K11l20b4FfjQM+aBv1fDqbFfpS4J9sFTWqTHlpBdRJJHiYQi3Ece8wAmnTgkh2YPXu2j+D
	eSOq+oogxrn0iYSeOTMBJRcBzi13o+o2DP7pqfTpi+YVvPsR0gGRejltrIIvTco8rqseJe
	n98HQbQ2SkVwOqoiO1Grp17z3k6doB9ttcs9AKryYpXoznxMIXHg49jHn05hEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J5j1bl4UOmD+ypsjf5YaMXZwvI//YUaWIc4ZlShfPc4=;
	b=fxADUvuj9z/KNqMIKIxrQ02g6OXozNOuwFKRzi5gm/a5D6Bz1JDmpBujAsOy52L3toL3+B
	eA5mFiBfFTfySuAA==
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
Message-ID: <171415513097.10875.11017699468785726729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     43e8e0a95a8949a9b498fa1c5e4a25f48862536e
Gitweb:        https://git.kernel.org/tip/43e8e0a95a8949a9b498fa1c5e4a25f48862536e
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:14 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/resctrl: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181514.41848-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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

