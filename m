Return-Path: <linux-kernel+bounces-156878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C748B09C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA4E1F25883
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7825156C68;
	Wed, 24 Apr 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuhHpR5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUTSysvO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907E33989;
	Wed, 24 Apr 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962089; cv=none; b=cinQm/zVj2VhCAd0BrHaYaMP+PbyxDsjgeoF3yX9Wgu0F2eR+2aHFFUzaxTe+OwnZHwLc0woisTANXTZ37lkL1Gd0gDn0kNsCTL3HZLGv7TFt8OQVq3HGm1GM/Z/Tec/urTIKK7qCIZ6zV7w46jQlr7T0p4Ih1DxacCkkQ4LQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962089; c=relaxed/simple;
	bh=qvWgH3Eg2eutKsA2pwGOrL1sidyh1jKJzWnrInmDbDU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N+NCF9LTX37UvjheE8IKODfsfHvbe9i7BxW14ssGCWsuzC5T1dw+ZgQT/5EV063kbZInv4iFsL22u0TFcIMP4sj0CAZhmXjK5dzcf11Uzw+fYJuByslRfPemdS27VsTnpMlIBMFAwIjKcWdI4O/ZzY6dmLoCNbpld82LFn+6LH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BuhHpR5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUTSysvO; arc=none smtp.client-ip=193.142.43.55
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
	bh=6LERzDCLsrx3pz0VEZC0VBNna78Rj6XPMvnu7VS1lz4=;
	b=BuhHpR5VznouFQp1B/JobD/bcKiue2ATFVWOtxtyF3wyOUv9AHFC+nR+pM7fOnhOYalQoS
	pzDpKChuDCkDgZKW0xnPi7ZKNcbUzp3gOBPDTcFo5tfJHh44wXwLrcAbrU0IDMNk/srJ7q
	seQnW3TrUlQwbReIi2rlrL3y4Xd5y3i7CvOpnN7ltZP2vd/VzB5+LTJC55RICQmagwm3Ch
	+Exe20SYHrX/HxXEgz9uNxpo5z1sdJvxhXbVkW5yFav/iFrG7Xdgux99GwU4oQvf8hxc5G
	fpco9m/cVGxr78fyC2yYWgRuE7xxwe31aUXT0A98R1NhFIFLpCqCWTFkgogc6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713962085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LERzDCLsrx3pz0VEZC0VBNna78Rj6XPMvnu7VS1lz4=;
	b=kUTSysvOj+n8TQYAsj2PYqmlgxdPHkjvJG0LnDMtpfSGUxGvHKhfJqsVqdtImzZ/NSAhqw
	x/cyEulP0vOaJeAg==
From: "tip-bot2 for Haifeng Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Haifeng Xu <haifeng.xu@shopee.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408092303.26413-2-haifeng.xu@shopee.com>
References: <20240408092303.26413-2-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396208486.10875.16574665789731843201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     87739229485ac724849178eb6c35e38c6161eb77
Gitweb:        https://git.kernel.org/tip/87739229485ac724849178eb6c35e38c6161eb77
Author:        Haifeng Xu <haifeng.xu@shopee.com>
AuthorDate:    Mon, 08 Apr 2024 17:23:02 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 14:21:52 +02:00

x86/resctrl: Rename pseudo_lock_event.h to trace.h

Now only the pseudo-locking part uses tracepoints to do event tracking,
but other parts of resctrl may need new tracepoints. It is unnecessary
to create separate header files and define CREATE_TRACE_POINTS in
different c files which fragments the resctrl tracing.

Therefore, give the resctrl tracepoint header file a generic name to
support its use for tracepoints that are not specific to pseudo-locking.

No functional change.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240408092303.26413-2-haifeng.xu@shopee.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c       |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h | 43 +----------------
 arch/x86/kernel/cpu/resctrl/trace.h             | 43 ++++++++++++++++-
 3 files changed, 44 insertions(+), 44 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
 create mode 100644 arch/x86/kernel/cpu/resctrl/trace.h

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e..492c8e2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -31,7 +31,7 @@
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-#include "pseudo_lock_event.h"
+#include "trace.h"
 
 /*
  * The bits needed to disable hardware prefetching varies based on the
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
deleted file mode 100644
index 428ebbd..0000000
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_PSEUDO_LOCK_H
-
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(pseudo_lock_mem_latency,
-	    TP_PROTO(u32 latency),
-	    TP_ARGS(latency),
-	    TP_STRUCT__entry(__field(u32, latency)),
-	    TP_fast_assign(__entry->latency = latency),
-	    TP_printk("latency=%u", __entry->latency)
-	   );
-
-TRACE_EVENT(pseudo_lock_l2,
-	    TP_PROTO(u64 l2_hits, u64 l2_miss),
-	    TP_ARGS(l2_hits, l2_miss),
-	    TP_STRUCT__entry(__field(u64, l2_hits)
-			     __field(u64, l2_miss)),
-	    TP_fast_assign(__entry->l2_hits = l2_hits;
-			   __entry->l2_miss = l2_miss;),
-	    TP_printk("hits=%llu miss=%llu",
-		      __entry->l2_hits, __entry->l2_miss));
-
-TRACE_EVENT(pseudo_lock_l3,
-	    TP_PROTO(u64 l3_hits, u64 l3_miss),
-	    TP_ARGS(l3_hits, l3_miss),
-	    TP_STRUCT__entry(__field(u64, l3_hits)
-			     __field(u64, l3_miss)),
-	    TP_fast_assign(__entry->l3_hits = l3_hits;
-			   __entry->l3_miss = l3_miss;),
-	    TP_printk("hits=%llu miss=%llu",
-		      __entry->l3_hits, __entry->l3_miss));
-
-#endif /* _TRACE_PSEUDO_LOCK_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE pseudo_lock_event
-#include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
new file mode 100644
index 0000000..495fb90
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RESCTRL_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(pseudo_lock_mem_latency,
+	    TP_PROTO(u32 latency),
+	    TP_ARGS(latency),
+	    TP_STRUCT__entry(__field(u32, latency)),
+	    TP_fast_assign(__entry->latency = latency),
+	    TP_printk("latency=%u", __entry->latency)
+	   );
+
+TRACE_EVENT(pseudo_lock_l2,
+	    TP_PROTO(u64 l2_hits, u64 l2_miss),
+	    TP_ARGS(l2_hits, l2_miss),
+	    TP_STRUCT__entry(__field(u64, l2_hits)
+			     __field(u64, l2_miss)),
+	    TP_fast_assign(__entry->l2_hits = l2_hits;
+			   __entry->l2_miss = l2_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l2_hits, __entry->l2_miss));
+
+TRACE_EVENT(pseudo_lock_l3,
+	    TP_PROTO(u64 l3_hits, u64 l3_miss),
+	    TP_ARGS(l3_hits, l3_miss),
+	    TP_STRUCT__entry(__field(u64, l3_hits)
+			     __field(u64, l3_miss)),
+	    TP_fast_assign(__entry->l3_hits = l3_hits;
+			   __entry->l3_miss = l3_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l3_hits, __entry->l3_miss));
+
+#endif /* _TRACE_RESCTRL_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>

