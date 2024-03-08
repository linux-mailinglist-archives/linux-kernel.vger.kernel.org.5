Return-Path: <linux-kernel+bounces-96595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424A875EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1721F232CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB65026F;
	Fri,  8 Mar 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MzdQGpyf"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FF4F5ED
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883713; cv=none; b=GxoWXzJnmEN6pVUQhdhr1C7Es5RccCzBktX/ieQkzUXlY7ou4RIuoc4Qv2sd1P0f8Ck7orFvdZOJtH0HGsOYHCu1MZ6CtpekgnqRnC3Dd+IYuF81kQUZlnOwcAV7LE82wYy0kFOB8ZHE0EVgcPmfkNbHKa1TniqWcPIthJCpeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883713; c=relaxed/simple;
	bh=MA0DxG8bRrDPES7N5MFpH/L+LhBYNxe9zPtGQO6dSek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/zLysPeFFaEwsvWFDCivizConWkin49r7ZGcjxoUYXy51dk0O405QaoJKk5fvNtZ5gdg1p8NOn1uGu2SqH+dW6m6u0iT2161TdIBwaelsSWuzUTSZwTdimWHve8Uo+3OgoFEuqpyeFYIVjJiW2Js4tdyzHJj0otaRLQy00FAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MzdQGpyf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd5df90170so9656635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709883712; x=1710488512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfomRvH8ULPC5eeUCXao/k9/srrLuDto1N2pX2K7uu0=;
        b=MzdQGpyfWG3haqHticPP3nXd9FeD+A5rNfpL2ABkCGXH3VdR2F5LXfb8phSjSL2UVC
         d/IJJJ6iS+/mzdXNLVhVT2+YAnrXGUxpQ/SWSsoXU3rfAlAKWO7avnaYRi5BjYXgNG4m
         sjnyFplbMsn6cnHM1X/9wTAE/LPPIKBHTOD0xLAdeqly9cT3+Z8ffADRzn9mEzMlUEFz
         tthMB2KIESYPxN+YzSTWNT70/DN34awPAD7EdK8Y7181X+urydc+nbY+3fWjozItXhef
         7pWL+rVVO+6b5bTNALuSoD563g9JqOheXeU2+vETw43iSQZnKj9X53DvOqM0R/1rvtNo
         OHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883712; x=1710488512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfomRvH8ULPC5eeUCXao/k9/srrLuDto1N2pX2K7uu0=;
        b=Evzp8OA2WJoIAVA/zn1htS19ryS+cWG/ZF8SuH3VSbfDDV/HEBOG4y35CDQ88YFpMu
         U34ePbacDMK8KfqoSOcR+7uFdJWc8kVJmlt+4jm1tbgzUkKwHs2jXxfveUoXxQMNtQqZ
         SdBS7cTPHNMDAgOqUFhN2BxIdP6RXRcYsg6Dt09nrgiKetMjoSjwSRIFAvJVEqxbhXYu
         NkV7V3cOjmNKTYpTLsTOd4itEVWxzAzMe3QPuSClZGGqMHKfR/F4OKaNKSjtkR6yq0YW
         aL3Cp/oXtrdDM7UYsfDLeswGXlVrhye5HugwLdw8G0lF2eplZFJ0A0CMMsHH+PyFzQtR
         GucQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM7EvGWF/bEsLdO6wyIPvuItIGiOTQYsI4APQHHnZLotwnUAOgzoyZxM7X2f7dJ0gvlaynraa9KdhATpAQ3zEvhdzkwSKU+6FSnMy+
X-Gm-Message-State: AOJu0Yxu5ouSW+0ZSAxYrmB6IDUQDmiRgueTwDxJ1JwzC4PZkwElWt5o
	gixE6GcCMxGXsixY3cHo6Kqu3gCgbbbZAkoRMr3FmrQFzUSwTgDXkKuOxtJzgMI=
X-Google-Smtp-Source: AGHT+IFqnES2kOURkr/nX8hXmitatnlV4O2f70hxTHEHJYlann0cSpoXZviHFntlYOuNPpA8kLnm0g==
X-Received: by 2002:a17:902:da8b:b0:1dc:6071:60ad with SMTP id j11-20020a170902da8b00b001dc607160admr5844088plx.24.1709883711738;
        Thu, 07 Mar 2024 23:41:51 -0800 (PST)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001db45bae92dsm15769210plg.74.2024.03.07.23.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 23:41:51 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v5 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Date: Fri,  8 Mar 2024 15:41:31 +0800
Message-Id: <20240308074132.409107-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308074132.409107-1-haifeng.xu@shopee.com>
References: <20240308074132.409107-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now only pseudo-locking part uses tracepoints to do event tracking, but
other parts of resctrl may need new tracepoints. It is unnecessary to
create separate header files and define CREATE_TRACE_POINTS in different
c files which fragments the resctrl tracing.

Therefore, give the resctrl tracepoint header file a generic name to
support its use for tracepoints that are not specific to pseudo-locking.

No functional change.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                   | 2 +-
 .../x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (88%)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e25141..492c8e28c4ce 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -31,7 +31,7 @@
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-#include "pseudo_lock_event.h"
+#include "trace.h"
 
 /*
  * The bits needed to disable hardware prefetching varies based on the
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/trace.h
similarity index 88%
rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/trace.h
index 428ebbd4270b..ed5c66b8ab0b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -2,7 +2,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM resctrl
 
-#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_PSEUDO_LOCK_H
 
 #include <linux/tracepoint.h>
@@ -35,9 +35,9 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
-#endif /* _TRACE_PSEUDO_LOCK_H */
+#endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE pseudo_lock_event
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
-- 
2.25.1


