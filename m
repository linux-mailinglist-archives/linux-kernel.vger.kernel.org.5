Return-Path: <linux-kernel+bounces-161948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C8E8B53B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95C128121A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402D39AF1;
	Mon, 29 Apr 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsZxqzjm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lU8BlHSt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56E2575A;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381325; cv=none; b=cqzgbAkF98NlBxiI+GN750XjIPmtUtVHNTtHxWoB3KostJNLviM6SNIM0OfPbR4f9w5vNzjZ6OJkbRUnPAiCN6ZiNm/QFoL7NTG07ikQ5xIBrpJ5xIki7wBI/nBCt+l9KTzKs3WAuePQoEcFSovdQ7srWU8tRc4FfRGeVb/H+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381325; c=relaxed/simple;
	bh=km47yHZAoA/epnQOkeA0Be/dmxgj2MffoeyFlLeXKAE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IY/2EB0/iZOkA7xfWsZDOTYZ1/DkKgXGmr3qavKyIixLAC9bH2K3/gRaA6+3OwPMLS2lFxiY50DmsFf0EIyZGR/k8tzDBZi1EY8PQYK/duoy0iZVpapQ4nBLGVhP9K19v74/bdwBdgFzAdMH27nyqyRxw/X5vEuZRJtM5jpRqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsZxqzjm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lU8BlHSt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=POU9AArkYcT0l4St89u2mjb5DTupODgGtAYr+zSUNlg=;
	b=lsZxqzjmrCR4PwGqhFhCGq1mlTEErkpUAldvDSwnktU8yhW1BCOGGTW8cPsq1POzifvnjQ
	YkzSau8q8x4hjXEe5EYiiuff7XFUWe1HYtuA4AiOzBe8fpEEefK8rY0k2Inoh2AJ1IvhiO
	nK8Kzmx0gYeSgFA59mJVwPmi2Hfj+eOeV9OtRi35BzbEvoOOcK3VOPhof+aBUbUk4QEP7K
	u0J5LCxpAaoCB6GsvJfotYkOh+pXQvOS0nSmtDatRSSXocjXuiOU0i84x9oxfJOq7451EN
	3lvaCW/RBH/REwAVmqHulkpX0OCFdQgf7vB81U0eVR0tmtBP9VIk+BoP0ARLBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=POU9AArkYcT0l4St89u2mjb5DTupODgGtAYr+zSUNlg=;
	b=lU8BlHStuvaPdwPnRc+WZNuZQR1V2U5ncYx9u0eh16UCbsh6kO+y51k/88OWBxbvHv2d+0
	fIuTmh0LVgO6LWDQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/microcode/intel: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131436.10875.13016810267578858452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     375a756448e29e2fe8944d0a0596da9300da2c26
Gitweb:        https://git.kernel.org/tip/375a756448e29e2fe8944d0a0596da9300da2c26
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:13 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:26 +02:00

x86/microcode/intel: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

