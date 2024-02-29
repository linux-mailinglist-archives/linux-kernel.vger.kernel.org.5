Return-Path: <linux-kernel+bounces-86209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22986C1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09459289E24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241D44C9B;
	Thu, 29 Feb 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MEoC6BvP"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3F44C68
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190708; cv=none; b=LgaXpxcfxRd5C0lECDco4qHlfWvzEEXNg6keCdBcaHtF3RiEe4zODJoMCeqz3V7GNZL4jKN6gB8e/hi7Eam+p79zGM+BRnysllesMl0uMh8mi8LRTJpDdVoFsxpsyNlkCjGfPqS3YAIH+WQsIKXTbBZQKt4GleRPdIUAm9fOYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190708; c=relaxed/simple;
	bh=us+gqacdVG7Oi15XSWzY0WXlTnfz2azYJkN3giURvl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZbLZC5MWqCU6AodDPKRbxkw90QtLEHmco2X77NQqYStnXLXys651JZSfXhYR5K5k8+M42kX2B4dm9I7zD8D/urA4I5baXbDGqnvTvupJk0UhI7jqmNQkW3gRZfoLcP29KuvI4i5HGYnt4wZ7yqGyUZi4JqmTOHKNlqRcLa0YpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MEoC6BvP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so470337a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709190707; x=1709795507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnO5BvG6HeINrw7VMlT+vLUyPLlIDJXPbCDlq93Qtkg=;
        b=MEoC6BvPcMpQ3AXGitPp4hfoayKTrRPEOCji/2pvKIfilCLKlnqVAn7sP6IlrmOfB+
         HthbZ5CU1R0tSBXiYkxMIC71bHebeNO2tRWDyKlgn4M3S23zIRgQj/hz/4GWEnsSTVjC
         Ax/aFwDa34C8OnM/gQsyGP1nekgAvaZlL1rfZvNOFpRdmX/PvzXO1S2A6/55z5XJQOiK
         ct7BASjaKYpqFUuX9asmtZqId35ogolL3gY4lUK6QOKYtJGS0SDTu5U21zhgezmxzx1W
         XRg4eTla9opQi1dgaY5XggPNgUc0Ac81ylMP0HFO378MvnpltUhBDkKI0UF6lep3O39M
         r8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709190707; x=1709795507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnO5BvG6HeINrw7VMlT+vLUyPLlIDJXPbCDlq93Qtkg=;
        b=Vrqbb6PUZr8dbno9wB4Tq8j57LRWZvVr62CGM1d5hNFz6sBTQDKoqyfhwwqau0meJk
         cmbmUC+wbGXZ6MiIkBFsK9hFFv//ptbGIZb380t8ZdhWn+80KHCXHJ6Sn0LduZlbAndz
         vJKGhJAKLuSuhEfHjzxZChj/n5bOoYmD+Kh7c2JHyhw7iVK+26S6Kb0b7Oplr61PrZdz
         20Lpe0sCeipcbEce3To6iw5SdTmnSx49UolGvweXXhP664y9w5x6ZkVW4iBJ7dxZBN0O
         CmM7cshFop6EtYx5+gKcIvJtwLY4uVYlKcar++UAhJkhV+oIzuzy7h1PYcx5nceWdC5V
         gpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe73g4/54wZMcDcKRAIxlm0maCMlRgbQ04eJXmJCVcmpSIs5jXzFOTrSyAXNLTxKMHw0ZwozLRSr0F/pY4hU8k4uMsMHMNK7lMLoVq
X-Gm-Message-State: AOJu0YzGC8f2wfKkT9RaGxzEQ1LOBNKSWW/wQpYuKA1nOMUlFZVuOyCa
	bcljzzpHpvOnZGVkcWIfhyoiSLp40sdg6Rs7WtOQ5g1R/bNEX9syH1hkBkRreX8=
X-Google-Smtp-Source: AGHT+IF4K23BVrvxTQpwp+dnlXVx4EGEAkvpwc0L9qSmmWnwHMSkKrnrhlRnv+S7UOj5PLepZu/z9w==
X-Received: by 2002:a17:90b:915:b0:299:bade:ed0b with SMTP id bo21-20020a17090b091500b00299badeed0bmr1295253pjb.45.1709190706843;
        Wed, 28 Feb 2024 23:11:46 -0800 (PST)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id gg12-20020a17090b0a0c00b002995e9aca72sm691659pjb.29.2024.02.28.23.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:11:46 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: james.morse@arm.com,
	fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Date: Thu, 29 Feb 2024 15:11:24 +0800
Message-Id: <20240229071125.100991-2-haifeng.xu@shopee.com>
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

Now only pseudo-locking part uses tracepoints to do event tracking, but
other parts of resctrl may need new tracepoints. It is unnecessary to
create separate header files and define CREATE_TRACE_POINTS in different
c files which fragments the resctrl tracing.

Therefore, give the resctrl tracepoint header file a generic name to support
its use for tracepoints that are not specific to pseudo-locking.

No functional change.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                 | 2 +-
 .../kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h}   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (86%)

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
similarity index 86%
rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/trace.h
index 428ebbd4270b..495fb90c8572 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -2,8 +2,8 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM resctrl
 
-#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_PSEUDO_LOCK_H
+#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RESCTRL_H
 
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


