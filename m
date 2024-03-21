Return-Path: <linux-kernel+bounces-110371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90D885E28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823C51F2690D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AC113173A;
	Thu, 21 Mar 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZLKKUlE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4833137934
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039068; cv=none; b=KqJp/DR5ZIrnLEuYVv6PfrpF0elAuKM3sG8M4ZFESj4VrdYYlf5OWJQkHHslXEGlG/MMWe+PEGzMLED3vcdnIk16bgjT/VsP9Dj8rDiXHRIbTM7mjnbqIRv95y2fHGHo6v4Q2KsDvzghfzwXR3bV2ie5x1MonGvzdz6HmgkUgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039068; c=relaxed/simple;
	bh=z2eJy0t2bdkmakMZRyMHx8Zh+sPp3sJo51GJl0bffFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkGbzA7Br9qvw3vJOfJSATsDFiQosZVRSbHMkv8KHy5fsKTEcPEjQPMZ0qq3cODFUgIks4X6p1jN+q8LtUPmshvj1tuaTzxbaYqaQbyAqLsyNFf2yCKAOYvP+HKp3n9J/rFPsDZsH045a7lhOXL6mv9DflGDB5/NBfHR2ChR43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZLKKUlE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ab69a9e6fso28861547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039065; x=1711643865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=UZLKKUlElHdKoVJnA/LuY9jg0NkLB6vwXGStqPA0YRImOU2pNXToNXs195ZQ14UFnE
         6onBZfh8TAgJmvp8XA/p2OGTeR/GUt/kR8bCSNWH92aBG2quY3p/Qi1ZSC8mtE6ZBO3l
         K1XRas9hGxHmr5SkJoIRnY6GEBSo4iulor1QSg5BgONy/LA8s3mCAKHtpsC5J03hx/I4
         nwK3N0U94Fg0Qb4tcU98nek/fDUhyCE5I21YMkIf4aY59K9MsfCjo0xN+JfnPhpoOgVT
         27QbJ+Ck8zsrqK4prKa0qFBd6qQdXFiUfIPyvdszYIbAtOHnH0V8/QuVgJUo4e5Pe0Gj
         Kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039065; x=1711643865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=NH9IT/XDffC7UhlFNZn9+x5J14yGzM1E2DlPprrRx6WT7VOQB/loaFfeVVNrhIn/wx
         Pybu6EEaddnBEpoR0FVGOnmpaVuFhc936sfJUVxtrS8m5EyW+nNJST7JYzRVywp2W3Aw
         V+HZ5nwrCDAha1Q0hp9StqloqojQjWQi0oWjLy/LfqA0ubKD2eBbXD/NNNtdekt1TQX/
         P738MPjMa6HKQZC4DFX+p/RIx3CEOGG3nncgN2kkx32IcBs/qeMPcaUOZ61O29EMq2/3
         MHUzKlatiTqGL+3wKMhl35dUDWksIijxXh3lsHhsoZQQC4ug0SgB5Qbt+lM5EaGHwJl6
         TRMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnfrwgbhzUSMC0tYz5/KjWP/vn+BL/UuV3w4gM9+vHnAmu4x8IGTNPQf+by9TLJGS9q+/BvcDynPmRyydHzgYPDVCGQZL6fg69uUHO
X-Gm-Message-State: AOJu0YwllXHtjSvLzpMwBgco1IkVsERBAkJ6RQEo5yYs5t0y2eCKBBUR
	CLZv/ybWU9+LBMMmw1mHe6KkxYuUcQVGAdmHMJa2tAmkO89Aw8IhsyOYQmi64S71LrnKO3LBD2x
	mWQ==
X-Google-Smtp-Source: AGHT+IEpbeHGmaH4ZP6HrzXLjRbRGOQFlxFrFvHpCJT+qt/SUASA+RVr+wlFFHpwWsqOIXtYDNaLSozJTUQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:b06:b0:60c:cf91:53e0 with SMTP id
 cj6-20020a05690c0b0600b0060ccf9153e0mr3628ywb.1.1711039064823; Thu, 21 Mar
 2024 09:37:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:38 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-17-surenb@google.com>
Subject: [PATCH v6 16/37] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.44.0.291.gc1ea87d7ee-goog


