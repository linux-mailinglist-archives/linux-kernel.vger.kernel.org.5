Return-Path: <linux-kernel+bounces-71816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE985AB17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A6F283254
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFF9487A4;
	Mon, 19 Feb 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jo3USZYp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Eq2INjj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E54205E;
	Mon, 19 Feb 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367849; cv=none; b=hC9wMo804oBScwPvHB+OVtoZbUhIjnD8Ggjn9pGdbmHBCFLHx56K8a9haHc88qn8F/mLeUtLH3DSQJYQY1ucwot+ggZiN9XwtA4dgXad/fkD32wHVtRtkxnTu2r4jxRio6y/kL/TH74Rz/r0jb78hUX7DWZG/9NA2JwXx8fosAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367849; c=relaxed/simple;
	bh=B8IFfRq58UyVjexHBkD0EypTaxsVDPPKe/vxth21M5k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y2LuQoAzoo3xO58aruFXr902EOjOSS9vmAfkSdDhTR8VZaW0OG5b/6ScsIDbDrUy+AB9+Klr3lKf3u9F6KcqEVvD2dGa7SwQghbg6YigXYSEs51rqpdM1lqP1h+L87bEHR4xaIT8GXyGIYI3WQrWKM4k9wlYttpixzzugMur44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jo3USZYp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Eq2INjj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im4eTnxYe/dWpIGVIntP3uihfKLk3cmjCJyiwPazH7I=;
	b=jo3USZYp6hviOrlZGAXqA6q2+IsvVEx7jQbsGEixQoEe9HHL5yYYDyuuIe/cg8g+uNooWl
	FWj+GBMWda4rgZQ+X02vGtJVsN2u/jFihO2Gjio1PHGxKeWss9drSHWQIXtyjmqLf8RYfA
	tN/vlpVYM63wr+Eu2JNCrbQERjv8BsS4qW+hxSS120eZ4ffPLQ+/97Px4gexjGOkkkRRNS
	1wMWpza9qnGaJTIsnVhv2odtJziNPa93m+e6EKE/JIC+ZsEqZWA9ABWx/sF+FkktAa7eyx
	jaP9rsgQR9krbaQeV7aW6AIsAkCqJYLMQPzXZxVIkKKjcfIYvMkshy2AEFpecw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im4eTnxYe/dWpIGVIntP3uihfKLk3cmjCJyiwPazH7I=;
	b=1Eq2INjjahEyWU1h1nPmj8PaQNwfrP5215KKjVsExucdSqwtLns+6QniatncqlmCKuAb69
	nQRB7inyHdpvGtDg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add CPU online callback for resctrl work
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-21-james.morse@arm.com>
References: <20240213184438.16675-21-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784496.398.6142470608838836705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     1b3e50ce7f5001f1e0edaf7d6abea43b264db7ee
Gitweb:        https://git.kernel.org/tip/1b3e50ce7f5001f1e0edaf7d6abea43b264db7ee
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:34 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Add CPU online callback for resctrl work

The resctrl architecture specific code may need to create a domain when a CPU
comes online, it also needs to reset the CPUs PQR_ASSOC register.  The resctrl
filesystem code needs to update the rdtgroup_default CPU mask when CPUs are
brought online.

Currently, this is all done in one function, resctrl_online_cpu().  It will
need to be split into architecture and filesystem parts before resctrl can be
moved to /fs/.

Pull the rdtgroup_default update work out as a filesystem specific cpu_online
helper. resctrl_online_cpu() is the obvious name for this, which means the
version in core.c needs renaming.

resctrl_online_cpu() is called by the arch code once it has done the work to
add the new CPU to any domains.

In future patches, resctrl_online_cpu() will take the rdtgroup_mutex itself.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-21-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++++
 include/linux/resctrl.h                | 1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d1dc80a..4627d44 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -606,16 +606,16 @@ static void clear_closid_rmid(int cpu)
 	      RESCTRL_RESERVED_CLOSID);
 }
 
-static int resctrl_online_cpu(unsigned int cpu)
+static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
-	/* The cpu is set in default rdtgroup after online. */
-	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
 	clear_closid_rmid(cpu);
+
+	resctrl_online_cpu(cpu);
 	mutex_unlock(&rdtgroup_mutex);
 
 	return 0;
@@ -967,7 +967,7 @@ static int __init resctrl_late_init(void)
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
-				  resctrl_online_cpu, resctrl_offline_cpu);
+				  resctrl_arch_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ed5fc67..38d3b19 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4007,6 +4007,14 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+void resctrl_online_cpu(unsigned int cpu)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* The CPU is set in default rdtgroup after online. */
+	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bf460c9..4c4bad3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -223,6 +223,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_online_cpu(unsigned int cpu);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid

