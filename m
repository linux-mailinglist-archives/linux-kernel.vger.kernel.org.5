Return-Path: <linux-kernel+bounces-160543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C239C8B3EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B45E2843FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4716F835;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BN2FZJY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYlJNLG2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686242230C;
	Fri, 26 Apr 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155135; cv=none; b=jFEeXKRgPYNMw0FwtEeKRKnujYEmr4EOrJUApHUTBFdGjueP5GTJ2fIHkbxTRI0hha9iZFefqxXFFsFmhDi86QQ0YodE1zbK+eSWqM6tHvyQmlRKnBSj5Anu3utTALcyT1jWGW9xYXCawm94M2w3ygY2ZEJorayccr7mxlAG8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155135; c=relaxed/simple;
	bh=9mC17PaoTqsYYkMBmpSDOb65KwsLU3ol0wiKadNdCu4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X0x4/aGjT77hd8NWsIQ2ZB64izhpik/lqaZ/NaJ5vCEbKJ7Kz1nn4LqsSDP9Wmo/GnQZF9uhe6jodKahctOyWzy8pz/nR+TTSjvhqm/4h997gau46whNgwMM599iQpZrhyBczu4agZ/56KdR4zpRwacpZ0WgOQqLPfM34kP7UOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BN2FZJY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYlJNLG2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7MFZexfCvkjl3TTb/z0VEiSw8zoEdo583n/215vhvXg=;
	b=BN2FZJY/bs1IuqznOVNsxJvTD2YAEXyvGpqKMELhrtUqRYDWlRobf9jK8mcufGqdYrwR4r
	p6xHEVJz0FlHSt9hATV+0lwfEABYITgAPIYXm84UH9a+dH1apdPwrYce1ezbc0HACtzFUA
	3Ff4J+jDs8bP4WNU81XP5hldjBEt/v0NdyE8ksm1qCxOMYDwCLLpf8HAWfwbl/n12rOWpV
	0XQqVG/1UR4fEDIKLridddZaATUgc7sQfaPTV65IFfHzR/WVAK/Hdkxhzm9u5eGVnxFXWQ
	DUqH0kd20k6tXV/yl/f7izH1qWJSDGViKpflPumqwMtLynqtIhmb537kuBm1UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7MFZexfCvkjl3TTb/z0VEiSw8zoEdo583n/215vhvXg=;
	b=dYlJNLG2hsFO1tT5VtR2NZLgo0sti6hEFz4DKR7IAfAD9xI8YaM1WRWZslAE3jIrioXsaV
	GFu4/IwytAEcLjBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513061.10875.13842300293014641039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     95be3ccd711c0bf7c6cc6dcc561f6c854dcae4d3
Gitweb:        https://git.kernel.org/tip/95be3ccd711c0bf7c6cc6dcc561f6c854dcae4d3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:17 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 09:11:39 -07:00

x86/tsc: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181517.41907-1-tony.luck%40intel.com
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49..c474514 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -26,7 +26,7 @@
 #include <asm/x86_init.h>
 #include <asm/geode.h>
 #include <asm/apic.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
 
@@ -682,7 +682,7 @@ unsigned long native_calibrate_tsc(void)
 	 * clock.
 	 */
 	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
+			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
@@ -713,7 +713,7 @@ unsigned long native_calibrate_tsc(void)
 	 * For Atom SoCs TSC is the only reliable clocksource.
 	 * Mark TSC reliable so no watchdog on it.
 	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 #ifdef CONFIG_X86_LOCAL_APIC

