Return-Path: <linux-kernel+bounces-159056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99018B28BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F951C21D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F42152503;
	Thu, 25 Apr 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GPLdWEZD"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66939FCF;
	Thu, 25 Apr 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071984; cv=none; b=qLhwjAxMxKurpOhoQgDFUfs664PyEXYXroVnuGTCMxDhFA8lCYQYf8ZuW41CDOjquWp57vz+5LmrT56GWBGxTl6/1jZj0W8I9U6eeDkfUnIaJHpzpzTJeq/tptL3aYVz2AZ8PTSZ7yQXDsXwJirgjH8l37BTGUo8RO+3Vnqubm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071984; c=relaxed/simple;
	bh=rXPHYPL6HdSo2STxUL4eNTS6iDEG81Dn+FvYaRVVUkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZcfy/2buMBvaka9C75AaGm6kDmD778ihSmUJq+l1iThTjMYqqvC1BbJD7Ci73wdm4/crvWk/9ORNqcCuS2f67x+s1cl1c74OFPPLx33AISCZ673EwgSDdfMCs7N87VOyvI6YUoXi1/H4vx9PQs0Wtxe0qvWRAi37r1oTUn89fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GPLdWEZD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id bee14970c5eba1a1; Thu, 25 Apr 2024 21:06:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 27B8C66DF24;
	Thu, 25 Apr 2024 21:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714071979;
	bh=rXPHYPL6HdSo2STxUL4eNTS6iDEG81Dn+FvYaRVVUkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GPLdWEZDTx3IiX3Dr4V+Mt/UsJbSxEJRZ30NvCWvszJRQX79COoTLoPqhQcPh7a9O
	 6Lybs9ENcJDl1bbwnuUY9lX10BRBMgO/3tqq0HA3rz1X+Qu/98+KavrKv1aQDJXeE1
	 y487c8suXY4HQfVMyCfsrgcRWBcS8lOn89SCef1KZ1uGMhdHyhbhjGtHDn4JG0B2V6
	 HXUbparQ1QSOJBjtv/v4oDzM9qSIF1wAykGMtvoVO4QWHzJ5P/7rVgCtZmRuq5i3GB
	 C5yz6QbawqH8GjmRksMKFa9HowN4Td+mn+X9JgYd2MhAg0Gqjb1V6ogXWHWmo5Q5P6
	 obLEv90+1LGzQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [RFC][PATCH v1 2/3] x86/sched: Introduce arch_rebuild_sched_domains()
Date: Thu, 25 Apr 2024 21:04:48 +0200
Message-ID: <3227587.5fSG56mABF@kreacher>
In-Reply-To: <7663799.EvYhyI6sBW@kreacher>
References: <7663799.EvYhyI6sBW@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
 vggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add arch_rebuild_sched_domains() for rebuilding scheduling domains and
updating topology on x86 and make the ITMT code use it.

First of all, this reduces code duplication somewhat and eliminates
a need to use an extern variable, but it will also lay the ground for
future work related to CPU capacity scaling.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/topology.h |    6 ++++--
 arch/x86/kernel/itmt.c          |   12 ++++--------
 arch/x86/kernel/smpboot.c       |   10 +++++++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/arch/x86/include/asm/topology.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/topology.h
+++ linux-pm/arch/x86/include/asm/topology.h
@@ -235,8 +235,6 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
-extern bool x86_topology_update;
-
 #ifdef CONFIG_SCHED_MC_PRIO
 #include <asm/percpu.h>
 
@@ -284,9 +282,13 @@ static inline long arch_scale_freq_capac
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
+
+void arch_rebuild_sched_domains(void);
 #else
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
+
+static inline void arch_rebuild_sched_domains(void) { }
 #endif
 
 extern void arch_scale_freq_tick(void);
Index: linux-pm/arch/x86/kernel/itmt.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/itmt.c
+++ linux-pm/arch/x86/kernel/itmt.c
@@ -54,10 +54,8 @@ static int sched_itmt_update_handler(str
 	old_sysctl = sysctl_sched_itmt_enabled;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
-		x86_topology_update = true;
-		rebuild_sched_domains();
-	}
+	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled)
+		arch_rebuild_sched_domains();
 
 	mutex_unlock(&itmt_update_mutex);
 
@@ -114,8 +112,7 @@ int sched_set_itmt_support(void)
 
 	sysctl_sched_itmt_enabled = 1;
 
-	x86_topology_update = true;
-	rebuild_sched_domains();
+	arch_rebuild_sched_domains();
 
 	mutex_unlock(&itmt_update_mutex);
 
@@ -150,8 +147,7 @@ void sched_clear_itmt_support(void)
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */
 		sysctl_sched_itmt_enabled = 0;
-		x86_topology_update = true;
-		rebuild_sched_domains();
+		arch_rebuild_sched_domains();
 	}
 
 	mutex_unlock(&itmt_update_mutex);
Index: linux-pm/arch/x86/kernel/smpboot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/smpboot.c
+++ linux-pm/arch/x86/kernel/smpboot.c
@@ -39,6 +39,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/export.h>
@@ -125,7 +126,7 @@ static DEFINE_PER_CPU_ALIGNED(struct mwa
 int __read_mostly __max_smt_threads = 1;
 
 /* Flag to indicate if a complete sched domain rebuild is required */
-bool x86_topology_update;
+static bool x86_topology_update;
 
 int arch_update_cpu_topology(void)
 {
@@ -135,6 +136,13 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
+#ifdef CONFIG_X86_64
+void arch_rebuild_sched_domains(void) {
+	x86_topology_update = true;
+	rebuild_sched_domains();
+}
+#endif
+
 static unsigned int smpboot_warm_reset_vector_count;
 
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)




