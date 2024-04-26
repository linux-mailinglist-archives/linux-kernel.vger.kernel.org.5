Return-Path: <linux-kernel+bounces-160545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06308B3EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A27B24297
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1417107C;
	Fri, 26 Apr 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcWA8zTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/SeJKmx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7E16F299;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155136; cv=none; b=kKvOvjsunV31YdmIZ6CMLYy/bGFmr+LXRP0z+DrYdThbjbFEq0sh9TUrgm7KbYT8VJdafZegfiepTUoJq9FuhzUv61QzNUfLuipT6bkwUXbK/B7YDQCDvg1j/Ldpa0lHoaFrjziT92QT0YM/Z4vGcQttQO3YLK68LdfAYOlQCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155136; c=relaxed/simple;
	bh=gXZK0x2HzsFIoZYil6VLbCneZl5qIOYCWWv1ICpcG2s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ma1X0EAzUw2aXsnT8Q0hty/AoYUCNoJ9637kYDgOt+GzpnhQ4MwEmegXVlAhM8MvjyKMS779Bb05sqq7Opu2e6PkgtaGwujyrpjgNYkU4X61WEZyLvDYTTEmjz+RaHKKTRyKmKwKPvawNhYM28ThhP8XV9dg5vAaGIn/auqDr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcWA8zTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/SeJKmx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cMR3bonZf7Yv98+OzC40yiI1vK8iOBCE/7SqRs2hVfM=;
	b=tcWA8zTjw1RgcxxmTrAN0WIvd3+B/aKPm+Qyq2tV8c1w2T0wNM+Zs792sAoMUs+P2yM+6p
	VvezevxXseGLwuJrEGZXChDXS/qIkhMA+5tgKj8z1lJ3eMNgTQIYNGFTarLJyANiGYBwCZ
	G/O0AILvxEx/szyY+gLnscDv8+9gl2frXtprLppMOD018PjXTQ+lwLqljqVld/AK58v+Zs
	TuaHtz/Pb74xGuVrWynXqUbA33TH0A9jaNcIIetN84/DjXqqTsxkzgSS9yXPt1iKzc9sM0
	DbyfbQKSmNoP8+lo/9dOr2u8ccC2EgUEjzDQwzH81BBWvTDAU1foYpEIntTg0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cMR3bonZf7Yv98+OzC40yiI1vK8iOBCE/7SqRs2hVfM=;
	b=W/SeJKmxfD5R4r2VlknrO2c4HUjPYZUxjDWSMSmuJ/b2YdJ5HDPLkl840e2GJc53iv2XeT
	mLX2Y34jSVh1aOAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/microcode/intel: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513106.10875.15508529151479733444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     173e856a55d095a9ef566f28ac95d0d2255a7073
Gitweb:        https://git.kernel.org/tip/173e856a55d095a9ef566f28ac95d0d2255a7073
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:13 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/microcode/intel: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181513.41829-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5f04144..815fa67 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -21,7 +21,7 @@
 #include <linux/uio.h>
 #include <linux/mm.h>
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
@@ -577,8 +577,7 @@ static bool is_blacklisted(unsigned int cpu)
 	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
 	 * Processor E7-8800/4800 v4 Product Family).
 	 */
-	if (c->x86 == 6 &&
-	    c->x86_model == INTEL_FAM6_BROADWELL_X &&
+	if (c->x86_vfm == INTEL_BROADWELL_X &&
 	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {

