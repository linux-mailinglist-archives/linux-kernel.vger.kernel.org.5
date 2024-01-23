Return-Path: <linux-kernel+bounces-35330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98D838F85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A5FB284DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813B604BB;
	Tue, 23 Jan 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyIxKfjN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F5C3Iop1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569D60263
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015424; cv=none; b=KaXtT8tXcJsGCW3U9TavmnRgiKUNOdx1LpjsHn51AANzVcG6HXxMep9XexNH2LRK8MOJibjuhcOMgwMzR85aV7JQwYQsAORvjUyyi7SQijSbC3sE5XUxWahif2mpxYeGmbM9e0VBYqmxvnebZwyH9YQBjxe1whhZ6KW94BqWZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015424; c=relaxed/simple;
	bh=Ya8HI1qzh/dO/xW+mB/76zGK/TYfwJ2VdxGLTPzQff8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=b1tQKPvXZ39ESuJnz16R9ircdZjILL+M6ufIIpiD0mVaMfJeDnVFXSGxbCEBeogG48w34o5KwMNj5LVNTfprYK9qgf3sa396UFHXW2sQW0YKpzsNB6743T6eAJecSCHlzIEBen5AXQk2dDrJChfea2nNGZQksfexFpSUHEGy57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyIxKfjN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F5C3Iop1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.056546175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tu6Txn30UVC3+dGEQgQMvX6BOPv731R38E3MTjuWaBY=;
	b=fyIxKfjNqglhFrmGoknWfSRPU7iMXAfDU9Te8PV5ZUxnEeNMHp2QnxLMqUcFdObedOfu0U
	TOcWuWNtTIFSsEd3/g5aYe+womevcg1mAo9VCly2/TXZv8bCnTjraff4z9nVnI+BRj9r3S
	yorWPP+KiMRILOh4/bmomroZEg/fz/WMcyAr+Ap2NTuQfPxtc4Rg5hh+eWw+fHVEUVusIA
	39D14C7EDw/mFWfMkeg+mGFrRJGr/ArjbII9atYJTTF65vGPj5y6zqtgA6JcaGLJOcwGcK
	ksQGaLSyPWKE3qP97EA0FbxFFxsKHm8WtcN5lryy/m7ozAFiAdnJlcnpV5eGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tu6Txn30UVC3+dGEQgQMvX6BOPv731R38E3MTjuWaBY=;
	b=F5C3Iop1/oQp6DCorH5nmWI+66zNEo0oyrTAggsj111iEOGbQrUENeeLr/REvKQg4lS/Bj
	HrVOcONlSTvU2bCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 11/22] x86/dtb: Rename x86_dtb_init()
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:20 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

x86_dtb_init() is a misnomer and it really should be used as a SMP
configuration parser which is selected by the platform via
x86_init::mpparse:parse_smp_config().

Rename it to x86_dtb_parse_smp_config() in preparation for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/prom.h  |    4 ++--
 arch/x86/kernel/devicetree.c |    2 +-
 arch/x86/kernel/setup.c      |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
---
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,11 +23,11 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_init(void);
+void x86_dtb_parse_smp_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_init(void) { }
+static inline void x86_dtb_parse_smp_config(void) { }
 #define of_ioapic 0
 #endif
 
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -302,7 +302,7 @@ void __init x86_flattree_get_config(void
 }
 #endif
 
-void __init x86_dtb_init(void)
+void __init x86_dtb_parse_smp_config(void)
 {
 	if (!of_have_populated_dt())
 		return;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1131,7 +1131,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	x86_dtb_init();
+	x86_dtb_parse_smp_config();
 
 	/*
 	 * get boot-time SMP configuration:


