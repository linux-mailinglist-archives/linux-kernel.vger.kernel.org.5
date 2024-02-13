Return-Path: <linux-kernel+bounces-64244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C790A853C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661D51F2814E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A23626AB;
	Tue, 13 Feb 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzy2ZvOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dL335nHV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073362156
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858249; cv=none; b=U5wXBWlDuf39qFsDhvL7QQWLBTN2gNRZaP3uFaGV3t+B6RD0sSkLgw6e7wR+ly9Vd81fI/FakJVKCs5m/HtRFLMLtmf206ZvCd5dA96/+fsTas6A8WFW37i/Omwhdn6QBtjnm9ZbTCzSWjllXzqOXQl5kHKQqi4oG502KmQK5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858249; c=relaxed/simple;
	bh=Llmx1y+tansg1E/Nq2ZhT8Zi+oyVTBjaKh4Q99ryi8Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sR8Bm5Z3BcWDRAyPRUDefsc1rR52Xd0cUyq3ljteeUolUa2tY5scUBXg83h6fWmahLcb3s9HnDt1sZJyg+chy/bl5lmKTW8nH333ZM/Xl41g8toA89jYZTqEVec4Iv5wcWjAETBVJ3WdQPQa1+Y946MsvKtbYaiGcAKUywnwEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzy2ZvOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dL335nHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153624.768188958@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZRJkzOwB5/1YL71AgKNjiEjK5SJG7QnNpgljQo39jQw=;
	b=bzy2ZvOGowCps5I9bCqO5rtcFKyjSdrmAPi4IYLghO9yV4JQ/o+AY4Q1QWra0oosFL61ER
	7ZKZ45RMv9Qcc+H81K/z6amDNvuOYDH8/+a1fjMyvhpcB8YyS+2FGv/ER8dF6Qp2zMKAA8
	IQVwedCgDmaJhqKlUnc5JecmHde6M7QuxCut7HKGQqCpwgGttPAPI9bjaxwAUbHkxHBS6M
	4cMB6wS34GCK5dpq1pkhAfKuorwqnl6VD3U2kS9TUPZ4zdMoT1tPI2Eobe1C/ltRKKGdgp
	mj9A800W/I5GCZhLpjOMYQMgsdS5WS79LhfoAyjfeaRq+67xN5Oxthu+G7SUqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZRJkzOwB5/1YL71AgKNjiEjK5SJG7QnNpgljQo39jQw=;
	b=dL335nHVU9/g+Tgf6/Cvgd3H3oXjShjugxT2iwKIxe6J3f+GIPshUIb5kyaeaX9eWtPh6p
	X29I5lEUmnkLihBQ==
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
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 05/19] x86/cpu: Move __max_die_per_package to common.c
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:05 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation of a complete replacement for the topology leaf 0xb/0x1f
evaluation, move __max_die_per_package into the common code.

Will be removed once everything is converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/kernel/cpu/common.c   |    3 +++
 arch/x86/kernel/cpu/topology.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)
---

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -75,6 +75,9 @@ u32 elf_hwcap2 __read_mostly;
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
+unsigned int __max_die_per_package __read_mostly = 1;
+EXPORT_SYMBOL(__max_die_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -25,9 +25,6 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-unsigned int __max_die_per_package __read_mostly = 1;
-EXPORT_SYMBOL(__max_die_per_package);
-
 #ifdef CONFIG_SMP
 /*
  * Check if given CPUID extended topology "leaf" is implemented




