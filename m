Return-Path: <linux-kernel+bounces-90550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3386870107
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A81C21992
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE03C47E;
	Mon,  4 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRM7mk6k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxB/8/80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BB3B296;
	Mon,  4 Mar 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554507; cv=none; b=GaSvklAkFQfUvJ91Hl/28MMqyu8fagWA4qvXKzOsOT/MXlEAU9QKQ3EiEGZNVGUJtshehrtu/WqGXO1JstrQdF4ePNeLhieIU1q9iwDxXebkkn/Qhju5Icupla1X7ztwk/YzRA8lN5JO2JjXOgeva4+BDhz4tnJI+5NbuCxlK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554507; c=relaxed/simple;
	bh=myU2MHmyuavQwo0kLcMM2KpnHVDmGR3sl1y7z9EG9PU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eVBbfP4RdjdnsP1O9bp+WxDFC+WbQ4DB9RFw0283dgyXJLZ+es5weVYSBEukkbkBtvq4R4DuJAWbr9EYA+uKpc9CKaxu5mnUxKiaPMckiosrFcL3h9KIll7xnvBRpFjdlSQn9ttlRjjw0Qiia1LQoRUvaLDJgFrIUJGVSUCczME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cRM7mk6k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxB/8/80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9qOOwQmUXP7QrOL2kka5r8Z1g9mVq6jel3jR8Cz0w=;
	b=cRM7mk6kCP9b6RdsVU5yh31Af2O72dq5wkyc+3902sLLm5fCLScG7N6xoE2u4e5oDAgXgU
	jU9994bBFEUj2lxPbOiYwiuo+4ndzmoFaLpJlD8dl3dByO+MorfIfvaqhQ/J8H8f9eLTKm
	ElnmcjkiCtZ0vzKp5s4fLrRoz/v0Sc/14qonsbIxvKgoNX4pteNeUnP94vHglSC9ogjLcU
	FBDrt6efV5wqNLd981KJtPpfjb5kO8zPm4fyJ8uuIxjI1RFfThBtIvoKIJvIGL40Du8TqD
	0xQrdZXJA46v8/mVl2PPBjCb23WWbmypRE4kd6HTnl1b2qEXlPHDitulrNJDdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N9qOOwQmUXP7QrOL2kka5r8Z1g9mVq6jel3jR8Cz0w=;
	b=lxB/8/80AK9dW70tEk2OkQx981Rdm19FOmlxeqLGxyy/gUJ24uIJAwJNU5QpWbJe+GesjS
	WxWajL68/5LTyqCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Provide a declaration for
 itlb_multihit_kvm_mitigation
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.787173239@linutronix.de>
References: <20240304005104.787173239@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450365.398.1226028096148035951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     65efc4dc12c5cc296374278673b89390eba79fe6
Gitweb:        https://git.kernel.org/tip/65efc4dc12c5cc296374278673b89390eba79fe6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:09:13 +01:00

x86/cpu: Provide a declaration for itlb_multihit_kvm_mitigation

Sparse complains rightfully about the missing declaration which has been
placed sloppily into the usage site:

  bugs.c:2223:6: sparse: warning: symbol 'itlb_multihit_kvm_mitigation' was not declared. Should it be static?

Add it to <asm/spec-ctrl.h> where it belongs and remove the one in the KVM code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.787173239@linutronix.de
---
 arch/x86/include/asm/spec-ctrl.h | 2 ++
 arch/x86/kvm/mmu/mmu.c           | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index c648502..658b690 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -96,4 +96,6 @@ static inline void speculative_store_bypass_ht_init(void) { }
 extern void speculation_ctrl_update(unsigned long tif);
 extern void speculation_ctrl_update_current(void);
 
+extern bool itlb_multihit_kvm_mitigation;
+
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2d6cdea..3c89d3e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -53,12 +53,11 @@
 #include <asm/cmpxchg.h>
 #include <asm/io.h>
 #include <asm/set_memory.h>
+#include <asm/spec-ctrl.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
 
-extern bool itlb_multihit_kvm_mitigation;
-
 static bool nx_hugepage_mitigation_hard_disabled;
 
 int __read_mostly nx_huge_pages = -1;

