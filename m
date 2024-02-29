Return-Path: <linux-kernel+bounces-86210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4086C1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFE1F24200
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C545BE4;
	Thu, 29 Feb 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="d6SaeKpo"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A445946
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190712; cv=none; b=CODYvH76OVTDoVUy60CRRRSN5vClYRgQkuQgKchXPMaIwdKg34FUy3WI/jWFHLXnH79fo93CjHnr64nzMtv3Gr3lyukyrDvZPMr3e4vZiy3pWuld6Hs692jXqAbQV0G7Glrlh2+QM046YPnjKKFjrr5kSZwDZ90+L56qeoIUH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190712; c=relaxed/simple;
	bh=Ewl/VKxW/umgKxueyWDskoudQ5FqI/tOTEYi3VSfdmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBbOLb+pvRvdawEaD6vEoE7t0FBIeIWHsb3/dfrmW54PP2jh/njD9IXy0JfWi7igRP6b1FDoLBi2Bn58kIxKvXt9esjChVDRQQBKcsXGjiRp0D2SfD85DfJUw2x7HdTrjEqynkPdxHJsx5i6vt4Rz3WjfykKlLuQvtIcLEO+j6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=d6SaeKpo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so378718a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709190710; x=1709795510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoZ7n8igIv+4DqQuKIGb174Uw0V0LnTg30YXyffisGo=;
        b=d6SaeKpoNcdjUrJ2vXNwu/fh6cOSQFdc85lTTKjOZxPWdDtW6pHQKvJnUvViDt2hTA
         04qnNawTlSpMF89qcrImqv2Uo4TMdO4AhMNNQ+M0NfQUZHuNT+10SMPvAUMLQrcCmTZe
         5j2i5/7js8tKecKqLxkwHXl0RTowqBerxWAEx3GyRHJomMQPrsHvmCnkymcNpRc6B8xy
         7z7DaMeXop3w5D/p4sgHHwkP1pcRWsZ6OagoDkB+RZP8Xkmu11b2BNpzeCLLf+ysT599
         MOfRk2jYejZrca/ILqXBwwlCYyO/DtTSPfyNxgM0Mu2blEHr2CRvnRIUiPpl4OZUN6j/
         cVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709190710; x=1709795510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoZ7n8igIv+4DqQuKIGb174Uw0V0LnTg30YXyffisGo=;
        b=XcxHQc+OgjMLwD1/9k/bq2OJYqN90qpF3rmoOIstJachl6dpJTwmg1MPbPRLGDONAs
         rwW65LYIGN8mfOcbQnBZvVNTGr20KV2eQC3+CBelMsy40jCZwyA0j+h4LvhEfFKx8Rfi
         UNxAiRiIWNvBNjfu3z0sjwp+HQ0zhh4I0bSd0jsiToSqYif83ZFdZ1uLilG+Qnf3VVgn
         XmL7GPwCDb4sg8zXpAC3dvcZ6JLHUjBY95b+BiXW73IcVKddxbGxu2sjemAZSj/sgZtZ
         Q6l0hZeyL7F+nnLFBGj7Ctq9OhFHiDixAeX+yxNqzYHMajCukuh85iVmF3L3dwCx0I6u
         sUrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJrBzeGT9rHuZbYA+MIjqXEF0GP3QLhNgFGQwohHJRXlfucR7Pm+epzZu+vRph65RZb/cFjOmOt+l8yQ/KJj+nu+ntQX/3TrBdFhL4
X-Gm-Message-State: AOJu0Yyx+jYeYKjOikH3tKSdW+9YhYrdzfRfQKxMzUki73zJ68qp620j
	wxKAdUAF88eYPeC8Sc0cr3pZJKSHsIFTadvDRHhCNn3Uq6nx59ZKfMhmX6TMWVg=
X-Google-Smtp-Source: AGHT+IHLL9MB8QqecBJjLftIG23ldEdUBrWI4d7gFbidyeGlwRFpVflmoYxqEY/cs4I/uQtgX7SRBA==
X-Received: by 2002:a17:90a:68c6:b0:29a:9e27:61ee with SMTP id q6-20020a17090a68c600b0029a9e2761eemr1396100pjj.1.1709190710087;
        Wed, 28 Feb 2024 23:11:50 -0800 (PST)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id gg12-20020a17090b0a0c00b002995e9aca72sm691659pjb.29.2024.02.28.23.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:11:49 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: james.morse@arm.com,
	fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] x86/resctrl: Add tracepoint for llc_occupancy tracking
Date: Thu, 29 Feb 2024 15:11:25 +0800
Message-Id: <20240229071125.100991-3-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229071125.100991-1-haifeng.xu@shopee.com>
References: <20240229071125.100991-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, after removing monitor groups, those unused
RMIDs get stuck in the limbo list forever because their llc_occupancy are
always larger than the threshold. But the unused RMIDs can be successfully
freed by turning up the threshold.

In order to know how much the threshold should be, perf can be used to acquire
the llc_occupancy of RMIDs in each rdt domain.

Instead of using perf tool to track llc_occupancy and filter the log manually,
it is more convenient for users to use tracepoint to do this work. So add a new
tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
list.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c |  8 ++++++++
 arch/x86/kernel/cpu/resctrl/trace.h   | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35ec0f03..ada392ca75b2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -24,6 +24,7 @@
 #include <asm/resctrl.h>
 
 #include "internal.h"
+#include "trace.h"
 
 /**
  * struct rmid_entry - dirty tracking for all RMID.
@@ -362,6 +363,13 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 				limbo_release_entry(entry);
 		}
 		cur_idx = idx + 1;
+
+		/* x86's CLOSID and RMID are independent numbers, so the entry's
+		 * closid is a invalid CLOSID. But on arm64, the RMID value isn't
+		 * a unique number for each CLOSID. It's necessary to track both
+		 * CLOSID and RMID because there may be dependencies between each
+		 * other on some architectures */
+		trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);
 	}
 
 	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
index 495fb90c8572..35149a75c951 100644
--- a/arch/x86/kernel/cpu/resctrl/trace.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -35,6 +35,21 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int id, u64 occupancy),
+	    TP_ARGS(ctrl_hw_id, mon_hw_id, id, occupancy),
+	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
+			     __field(u32, mon_hw_id)
+			     __field(int, id)
+			     __field(u64, occupancy)),
+	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
+			   __entry->mon_hw_id = mon_hw_id;
+			   __entry->id = id;
+			   __entry->occupancy = occupancy;),
+	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain=%d llc_occupancy=%llu",
+		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->id, __entry->occupancy)
+	   );
+
 #endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1


