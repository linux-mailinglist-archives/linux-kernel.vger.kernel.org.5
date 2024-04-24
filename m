Return-Path: <linux-kernel+bounces-156877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895538B09C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5891C24285
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B32142E70;
	Wed, 24 Apr 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySRaNXIW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdKLBIJT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4751DFF8;
	Wed, 24 Apr 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962088; cv=none; b=aMAqYzi/WSdcm7pOZYp4KbTRTWquW3nq33b8aRFc/yKPmeJoyup//O47WvuZwQv5O7VQPb5bcDlBfEOnZJRz3msgbWUhN8xmQ3L3J7cNy5hwzUkgB2LSvEAiB9n0/6KhttWMnBlU63gBszy4YC+pa21ScEcwm4Ocb0550LemBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962088; c=relaxed/simple;
	bh=M/CykXs7tLVB+wjotgza7K2AlgcNOsKL5CfCon2EmNI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G1/4L8lmgN/29AL8KdrQtTJFlMdps5abKihc7+q0PULMvSywdcQHPbCtI2b5JQQvJYDTRpn5kHZEfobv8XGa5Fjrqu0Lv1iMhwxHjmFK6LuyNDV2Koh6BEMfdpqcN+PR6h2aY6uMsXhxaAWfxm1Rr/DFHjO71AJKb1rdPYc325c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySRaNXIW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdKLBIJT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 12:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713962085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Avw2ZT5I1sz1g/0+oR3KsqSJGaVsQEsTbl2M9mSNnA=;
	b=ySRaNXIWAmQkQ+j0LwdOEjzsoTNl977x08/NoCFVLMu/vwpxTlo4RIIetHNZwC/c/oOUj2
	eIlZY1Mf3fl1Cn89cQIYT70VPO0LDnTYNzEP/yQLMB0POqlH3470g4HGERAqGidNWjNavY
	vGseF7hd7yo27XDi5NhnEDzXTcar95AHwcs7qOmO75UK5rVILlCpGXWXZxDCNWBnVaeL0t
	o0h4o6F7G2c6v81nSK5h4W0lBt16+YsTFtonvETSBNsDe7CZ1wTthcUZKFWnoaW/V3EOER
	x1XGz+G7ZQG3EmqW/4NutFGG3QbLDvAZxBiJ/nSCce9c5pYabgyl1QBgc3JRRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713962085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Avw2ZT5I1sz1g/0+oR3KsqSJGaVsQEsTbl2M9mSNnA=;
	b=GdKLBIJTQ7FXCjULHS6Sy81mxAgiRYsGCNfO9q7ygpAjNsIEarEhgCDLcHyGS6r7vPJ8tG
	WOIfjY8YYRv0l0DQ==
From: "tip-bot2 for Haifeng Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add tracepoint for llc_occupancy tracking
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Haifeng Xu <haifeng.xu@shopee.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240408092303.26413-3-haifeng.xu@shopee.com>
References: <20240408092303.26413-3-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396208407.10875.3076169183667430328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     931be446c6cbc15691dd499957e961f4e1d56afb
Gitweb:        https://git.kernel.org/tip/931be446c6cbc15691dd499957e961f4e1d56afb
Author:        Haifeng Xu <haifeng.xu@shopee.com>
AuthorDate:    Mon, 08 Apr 2024 17:23:03 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 14:24:48 +02:00

x86/resctrl: Add tracepoint for llc_occupancy tracking

In our production environment, after removing monitor groups, those
unused RMIDs get stuck in the limbo list forever because their
llc_occupancy is always larger than the threshold. But the unused RMIDs
can be successfully freed by turning up the threshold.

In order to know how much the threshold should be, perf can be used to
acquire the llc_occupancy of RMIDs in each rdt domain.

Instead of using perf tool to track llc_occupancy and filter the log
manually, it is more convenient for users to use tracepoint to do this
work. So add a new tracepoint that shows the llc_occupancy of busy RMIDs
when scanning the limbo list.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240408092303.26413-3-haifeng.xu@shopee.com
---
 Documentation/arch/x86/resctrl.rst    |  6 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/trace.h   | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 6c24558..627e238 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -446,6 +446,12 @@ during mkdir.
 max_threshold_occupancy is a user configurable value to determine the
 occupancy at which an RMID can be freed.
 
+The mon_llc_occupancy_limbo tracepoint gives the precise occupancy in bytes
+for a subset of RMID that are not immediately available for allocation.
+This can't be relied on to produce output every second, it may be necessary
+to attempt to create an empty monitor group to force an update. Output may
+only be produced if creation of a control or monitor group fails.
+
 Schemata files - general concepts
 ---------------------------------
 Each line in the file describes one resource. The line starts with
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35e..2345e68 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -24,6 +24,7 @@
 #include <asm/resctrl.h>
 
 #include "internal.h"
+#include "trace.h"
 
 /**
  * struct rmid_entry - dirty tracking for all RMID.
@@ -354,6 +355,16 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			rmid_dirty = true;
 		} else {
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+
+			/*
+			 * x86's CLOSID and RMID are independent numbers, so the entry's
+			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
+			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
+			 * used to select the configuration. It is thus necessary to track both
+			 * CLOSID and RMID because there may be dependencies between them
+			 * on some architectures.
+			 */
+			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);
 		}
 
 		if (force_free || !rmid_dirty) {
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
index 495fb90..2a50631 100644
--- a/arch/x86/kernel/cpu/resctrl/trace.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -35,6 +35,22 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
+	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
+	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
+			     __field(u32, mon_hw_id)
+			     __field(int, domain_id)
+			     __field(u64, llc_occupancy_bytes)),
+	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
+			   __entry->mon_hw_id = mon_hw_id;
+			   __entry->domain_id = domain_id;
+			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
+	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
+		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
+		      __entry->llc_occupancy_bytes)
+	   );
+
 #endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH

