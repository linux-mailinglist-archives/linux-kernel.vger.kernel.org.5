Return-Path: <linux-kernel+bounces-35269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF3838EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9AE1C22F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFF5FBA0;
	Tue, 23 Jan 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/oJxVld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQdvtvy2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5C5F866
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014421; cv=none; b=CyHXYp04A71m3Pl0l3dQoqZeI/Vnl04gjw+hvL6+zuVffig75Yhff9ZFIAljvU96Fiuf3Q96pxo48rn6iQvueYozVtXL6lAbW/QO0IRkIThcbCCUr1vnx5tmlBtaiwtFjvWXTQl8aPOcJu2cpHPLgSY5ywAE1bz/Pzy58M0Jwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014421; c=relaxed/simple;
	bh=4HZ2n8xBznhGrWWyNa9CZ7scSju09FL9B9OOA/nZ0Pw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=j3GB0NYeaFLzIvDd6xNyVZdutTePzAEwAvmwNHPC0XJc9XhqSAQ/buHXc1Cv8jO1b8FLz15jKUdSsr68BESyHEIU5oXyJivXnsCmki9LkUftv3AwoZPAGX9CFt2bqmiSwzI4M2T2gZKbTA+gvPlbOkAT6ZHkMlnCi3NmDSBlZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/oJxVld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQdvtvy2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.608449830@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5SkHGXX2iNobIfvEprLaCMhF0AA0+N9lS14uXgc9Oxo=;
	b=x/oJxVldzzIyWd9ZZhwZhssdZKDrRgfxNHcYnKG/3GrGMwMZPNRatO+NrqBmIZ0uoyGtL2
	brfSjrt0/B9WMLStSX8TZvDoXpyVQopg/COt5eOV2O92qQ4TInF4kTKd5AeY/TvWQ691RB
	KdhNzTCV3BglPj4vcgMZiiR7trTSDgLBRY6I/dAYGIQqivX2Lp7fSaT7LZxXn186Kn4yvv
	aVvq/4TeXYNHQ9hYPsPWaPapwe/bhB60eiMK12IOtYL6jAUd7v9zmAlZ5kM831j4TgdJXA
	4hM6+GkQLNd0jU8G3QY9WIHvF2IjOzl45XulfQtI4WD7ZVfM4ZMUTnydEX4kNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5SkHGXX2iNobIfvEprLaCMhF0AA0+N9lS14uXgc9Oxo=;
	b=sQdvtvy2kaOWzsmDxl+ZpL18NeCsTTrWDpPeVJYlmnDXHk0M7M6l9w1+tP4r++lryZxQMn
	63IppdJg/LznmTAQ==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 05/19] x86/cpu: Move __max_die_per_package to common.c
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:37 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation of a complete replacement for the topology leaf 0xb/0x1f
evaluation, move __max_die_per_package into the common code.

Will be removed once everything is converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


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


