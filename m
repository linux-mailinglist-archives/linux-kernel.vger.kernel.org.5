Return-Path: <linux-kernel+bounces-71813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5185AB10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575E91C216B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35D544C8C;
	Mon, 19 Feb 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yw4+WRy3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5piZHYX/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E22E3F0;
	Mon, 19 Feb 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367846; cv=none; b=emOKNlDaIotxclLDK36IW38ajucBCV2EKN1uFjTSmoxfoYpV8Tbc5Bek5gi2oQmoVMQU6r9yR4y1D7Lj3ESN8ZkjqjRoMTpqnfmZHbHMm9F0ZdGlsrE3LqYmqQZTk/wdtA/iyRmB4nKgu1+vr1rLFvV44C0y2gByIisWUVvYAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367846; c=relaxed/simple;
	bh=CsHF8smg0stJA6YPRQRzSA8JXwe+Of6W6x+aRxIpMUs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vDBjudkn4VTP2zclHLXxjphdCeOa2mg9C9qLLFDyL6yCWDZsyat8dwcdCbOKQcO0fOgrZRqXVmeG08skZPAG3/mclm67rD3gfA36R6GWnMdeb6q58aAHWovD5xzKgtEaiyUBJ7X/e1Fk+HwHdR+bVIN5HEmH9JMYfoYSQrl3KIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yw4+WRy3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5piZHYX/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbRZkDz5HwZVrDpQMCIZgrb24WkaZc28u6WKZpX157g=;
	b=yw4+WRy33U0ZyMVyN2JCXWqakMKUIbSkDYDsPmK0XcggF9ZE6A1XhjelgKbfFPBIKKuTpN
	BZ/f3Ma1Knq5whPYI6H4L7I7SSQa6lh4KYF+v3uH2Ip/APMdbOiAfcMyzMacnsRPQzHNTu
	cFcTMtf5mSvtbeEhydBLtAG2m44cq+K0trVigOnEXhPqrZhRkTYqaK8QvQTatp6QwhYqsl
	zH425C2EwH+Xo2cErzg21Z6sxgvdxnsVPLUTV0Yir8d3+M4B3ZvKF4s4VG3bpH4Ii/Klai
	UUo6XUoPDS0HbkyGfReQ8AkthsoNmT3x3xxFLNuhxJ7s54smYfuCSlt80hONzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbRZkDz5HwZVrDpQMCIZgrb24WkaZc28u6WKZpX157g=;
	b=5piZHYX/seFwLICjKOfx2E+cvVFDoHUmmOZ7Wg3tc09yfVAnBYOYsVoHEKpUdEh2vcPVBd
	AU8vUPlp9F5yshAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move domain helper migration into
 resctrl_offline_cpu()
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-24-james.morse@arm.com>
References: <20240213184438.16675-24-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784227.398.16507056859148393452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     eeff1d4f118bdf0870227fee5a770f03056e3adc
Gitweb:        https://git.kernel.org/tip/eeff1d4f118bdf0870227fee5a770f03056e3adc
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:37 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Move domain helper migration into resctrl_offline_cpu()

When a CPU is taken offline the resctrl filesystem code needs to check if it
was the CPU nominated to perform the periodic overflow and limbo work. If so,
another CPU needs to be chosen to do this work.

This is currently done in core.c, mixed in with the code that removes the CPU
from the domain's mask, and potentially free()s the domain.

Move the migration of the overflow and limbo helpers into the filesystem code,
into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before the
architecture code has removed the CPU from the domain mask, the callers need to
be told which CPU is being removed, to avoid picking it as the new CPU. This
uses the exclude_cpu feature previously added.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-24-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 16 ----------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4aedefa..b03a6c6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -580,22 +580,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
-
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			/*
-			 * temporary: exclude_cpu=-1 as this CPU has already
-			 * been removed by cpumask_clear_cpu()d
-			 */
-			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
-		}
-	}
 }
 
 static void clear_closid_rmid(int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5bd3d8f..777e9f6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4029,7 +4029,9 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdtgroup *rdtgrp;
+	struct rdt_domain *d;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -4039,6 +4041,22 @@ void resctrl_offline_cpu(unsigned int cpu)
 			break;
 		}
 	}
+
+	if (!l3->mon_capable)
+		return;
+
+	d = get_domain_from_cpu(cpu, l3);
+	if (d) {
+		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
+			cancel_delayed_work(&d->mbm_over);
+			mbm_setup_overflow_handler(d, 0, cpu);
+		}
+		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
+		    has_busy_rmid(d)) {
+			cancel_delayed_work(&d->cqm_limbo);
+			cqm_setup_limbo_handler(d, 0, cpu);
+		}
+	}
 }
 
 /*

