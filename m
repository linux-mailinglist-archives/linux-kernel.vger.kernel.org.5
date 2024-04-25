Return-Path: <linux-kernel+bounces-158952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7688B2747
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638F41C24281
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD11514E1;
	Thu, 25 Apr 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emLN7CcV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QquhhDQl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741514E2F9;
	Thu, 25 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065044; cv=none; b=OYVkFfmgAiGgI9uK5usGf40pU1iCCfvVXJ9+jnuJJH0PeQJBqiCGsUfjuERUUL80qsKRIK8GGmcYu2lpeKC6jdY1ogNlrJmZlf4xyqBASdjWluRtDNZUQ6Az7+KeqNH99hyEZTkdFvQRocEGQreaEUMOsaogqxdu2PT2/ZI5QTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065044; c=relaxed/simple;
	bh=3ryby7FrlSdmqF0o+30MAmVhtK9nWVScXXMQ0nrtd04=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MG5+i89HVmmU/b+G6IqE1F7RTUszaz+OhAEmMDr2miqZYxiH4uq3qE/ySkcmZyr110psJ5Xq6e7rQljcLJixAB3JsxQ/ThOT4PPzPfyCiBq4gnnLqYUyppu7RWACX0X0SyZjtr3f3wqWXj4WdlGnVMU1uHB+kRxeTaoN+KH39YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emLN7CcV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QquhhDQl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1+pWFK4hcRAFX69KZLNY+3c2XbvWTuBG9wv0obS/yZo=;
	b=emLN7CcVnbKjlAUO0+CqQ6ORrD88Wfzcr4KyS+qCFRaeQzyfFWNo+7Hd4jFFwKREY61aqK
	f8QQsjUXqmpP/8Lrw7vGt292/WJ74McoczGUdO7mxp5qJN4ikXGT7mj96VCbVSmzW5+i/j
	p4Te/WREk9rk5r9N84PLEe5ru4BhVo6jTROu/2kv4Nm8W2xfJ3YG4QUTqD3W04Bz2xDSd/
	fUy8uD0V7X7l6vLjejvZHPsRKexPdoAO38vDP+ZgXKGsH2b43Ofbh3+FA0bHuJ+zQP3gve
	YOQiIsFtzh51dGwvzzWNozLfJaRqgN6xAxxDy/oH16h3pjnYzoFJS+4HrGIwng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1+pWFK4hcRAFX69KZLNY+3c2XbvWTuBG9wv0obS/yZo=;
	b=QquhhDQlQaHlwXtpOi7B/b0Jq17/DLGW8JEmS8BmtQUpkc7V7sO7FcF2EasOBFQWkQP419
	2YdlV69H3EnSQsAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] perf/x86/lbr: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503678.10875.542718220159370060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0011a51d73d57866c8d7ee8be2ff1e5baa17f6ca
Gitweb:        https://git.kernel.org/tip/0011a51d73d57866c8d7ee8be2ff1e5baa17f6ca
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:32 -07:00

perf/x86/lbr: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181500.41519-1-tony.luck%40intel.com
---
 arch/x86/events/intel/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 78cd508..8627719 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -2,6 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
 
@@ -1457,7 +1458,7 @@ void __init intel_pmu_lbr_init_atom(void)
 	 * to have an operational LBR which can freeze
 	 * on PMU interrupt
 	 */
-	if (boot_cpu_data.x86_model == 28
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_BONNELL
 	    && boot_cpu_data.x86_stepping < 10) {
 		pr_cont("LBR disabled due to erratum");
 		return;

