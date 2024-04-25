Return-Path: <linux-kernel+bounces-159070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E628B28E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC041F239F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3270153582;
	Thu, 25 Apr 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="mkBhHeMD"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFE15099C;
	Thu, 25 Apr 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072506; cv=none; b=JBmVLO9ARbL1AWNbwUJLpKkU4prZ3OxA139Zz8vOS4l2HjINSCEACkqlA4mWTeTxUwh8+Bwsp/e9SYpUlE/39/lDR7/SGWSp3hNyndq+VMeXFqf8ov3igLZnqYR9icJtPIERcsH3IByQc/T1d42zfO6bFO3JXZXC5Lj3JBmjUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072506; c=relaxed/simple;
	bh=WFHgedParJiMztTbyoW1ulB0kaEI8f5AmAhdKpkopQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJe0XT3iJ1n1iR6oDAH/VTIq17i7FNGFonZT+7wlRmfDVd2to+wh9IYxB7Po7ES1F7x6VlhJ97x6sdTju+QYTtWpJg557fsY4TUhw/xf8IF7gA5TvCWecx61DfY87Tm/hwhX1HAvKUQBWn/A/lqymQ4ePsyLf8Qu5P0UeIxAesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=mkBhHeMD reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 1aa4fdb3953d0eae; Thu, 25 Apr 2024 21:15:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A994C66DF24;
	Thu, 25 Apr 2024 21:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714072502;
	bh=WFHgedParJiMztTbyoW1ulB0kaEI8f5AmAhdKpkopQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkBhHeMDkFuruz3i4m9nfl4ILiv/W57tM4XRJwYb0D+hzXDHH9pxCrG8BnfpqestL
	 vnCRACGgo0n09Pf6xSzjlVDRO+7ZVaxJtdofIpflk4bMqDhFmtDaixsf39NTfcEsDP
	 H+4JdBO+BP5HcCKosoEK/+TDVx4LZOjx2cZgaw7tda463dnV4x+y+nKfPSe0MorTwB
	 DVWrq6simKnZGkr2yUtNJ/6dhYqJWMRNoIj409KtJ0uH3tNRAr8DEUvEVQYfpTvgVF
	 JcLGaLgLZl87QIJKTuelkbspVSbOO0hyBmBwvsh9hBX2Khr627deOVoj1Xuv0Vn1/l
	 xc2iJMisqmv+A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [RFC][PATCH v1 2/3] x86/sched: Add basic support for CPU capacity scaling
Date: Thu, 25 Apr 2024 21:15:01 +0200
Message-ID: <5784915.DvuYhMxLoT@kreacher>
In-Reply-To: <2738703.mvXUDI8C0e@kreacher>
References:
 <7663799.EvYhyI6sBW@kreacher> <3227587.5fSG56mABF@kreacher>
 <2738703.mvXUDI8C0e@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
 vggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order be able to compute the sizes of tasks consistently across all
CPUs in a hybrid system, it is necessary to provide CPU capacity scaling
information to the scheduler via arch_scale_cpu_capacity().

Add support for it via arch_cpu_scale per-CPU variables that can be set
by whoever has sufficient information on the CPU capacities.

By default, arch_cpu_scale is equal to SCHED_CAPACITY_SCALE for all
CPUs, so this change by itself is not expected to alter the current
behavior of the kernel.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/topology.h |   15 +++++++++++++++
 arch/x86/kernel/smpboot.c       |    3 +++
 2 files changed, 18 insertions(+)

Index: linux-pm/arch/x86/include/asm/topology.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/topology.h
+++ linux-pm/arch/x86/include/asm/topology.h
@@ -280,11 +280,26 @@ static inline long arch_scale_freq_capac
 }
 #define arch_scale_freq_capacity arch_scale_freq_capacity
 
+DECLARE_PER_CPU(unsigned long, arch_cpu_scale);
+
+static inline unsigned long arch_scale_cpu_capacity(int cpu)
+{
+	return READ_ONCE(per_cpu(arch_cpu_scale, cpu));
+}
+#define arch_scale_cpu_capacity arch_scale_cpu_capacity
+
+static inline void arch_set_cpu_capacity(int cpu, unsigned long cap)
+{
+	WRITE_ONCE(per_cpu(arch_cpu_scale, cpu), cap);
+}
+
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
 
 void arch_rebuild_sched_domains(void);
 #else
+static inline void arch_set_cpu_capacity(int cpu, unsigned long cap) { }
+
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
 
Index: linux-pm/arch/x86/kernel/smpboot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/smpboot.c
+++ linux-pm/arch/x86/kernel/smpboot.c
@@ -141,6 +141,9 @@ void arch_rebuild_sched_domains(void) {
 	x86_topology_update = true;
 	rebuild_sched_domains();
 }
+
+/* CPU capacity scaling support */
+DEFINE_PER_CPU(unsigned long, arch_cpu_scale) = SCHED_CAPACITY_SCALE;
 #endif
 
 static unsigned int smpboot_warm_reset_vector_count;




