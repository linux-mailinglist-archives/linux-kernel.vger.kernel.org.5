Return-Path: <linux-kernel+bounces-75389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0485E7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29831C250C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0812EBD4;
	Wed, 21 Feb 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mW3f2ty+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02912DD95
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544481; cv=none; b=rjuuuy2iALMgiogbtkWZOgIyy0IKNQSvFeybz6G+wJSCoIzlESJZOl1QtHRKYiGevO6jo0cR1Ckg7khJV+IIN479sylSSuK9mi6S5Pmxs8VONsHaeIgJM7IQkgiK1Q0z29FeCUdEMZ10lpRf7A3++wBM2cNL+kfMH4NL6bWzt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544481; c=relaxed/simple;
	bh=48u9wnCjX1Vp+hvel6V9WbCDlLBP+PhlThbka3Wzfzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jupXFAWM9RO9tBM0VdbcS3QZPcaexIKkVU2nIo9GDy1YaAizpPv9pNS+jCxMmCUrinkeW80F9DOFUconOQdRZUYuQAiDrbmrWZtWFbAIOhK+p3CXAt95yr5OjINcZ0yRr0LFMT1V2N0bmG2pHwcPwylvq0VJmMbwdgzesoUNaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mW3f2ty+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so148533276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544478; x=1709149278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUIa2LF9EHhDqysRu/yxXfpC6tMV2p9GldnGdUYEsQ=;
        b=mW3f2ty+FZRjvu/gb4dEiiEXz54c0wOF4ApMcOrS7ThSMuzZeUS8Jj0OtMAbfvevHS
         CnGcCmFpjTyc4ZY3qnLxuBP7fn2iQ+raUx2/ILx7wiOEU90Vy9mF1HAUBWGNp1nAhxTW
         TdyTnlUAnaPv2bUQTIalXzQQng98tAx6z7bo08vjTCIY9P4mX6gtl9Vex5ZmEaZze81X
         lz/U2SYJwHIMef/Tulny+5Xl1N17Ula2y82LWyBm4vm8A0ZwLgSogmYaXyaGlQSU6KeM
         msuZP15exzk54RfowlihqsbJ1SCn7A2uZBjPn2WsQN1mgVU6jgaVixDo1e+yUHl0R0Nn
         8vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544478; x=1709149278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUIa2LF9EHhDqysRu/yxXfpC6tMV2p9GldnGdUYEsQ=;
        b=ZutdnFFXyngf4oDBJHo9L0W/xIHlzIB/tAFR9deRMlLkID9pEZcBlwe7EVmU/Km+FY
         sags6y1FKPbGnWbI3u+1k1bBPV+x9KhZVxLdv9OO/sh7DBrf2dx189YZtHSMRnff/66O
         I2SkKRJnAEgWXi6CO0sPub1nz56nlEiQ0DwZlkWGQAQpZju6R1E41A/++MpXS7w+dD9F
         Jb2XB6wsN60D79cKlx7ulJbW+sXtmYCDz5Mw8U9+aBX5rSZUHiBsBIMG1mI7DOyjxNjP
         bZdgDNtLkly5AN5kgjkzuLFzHxe6/B4s2ut6+YoTdqtHKtBoEaqTKUwnP9SOx/nXTvP/
         zpMw==
X-Forwarded-Encrypted: i=1; AJvYcCV+/eQsSm+UBXR9sNpbv5UGfsMwifQMX4ZhifOgnOY2UCpnJZBe7SE7RX7fqSPRAITFhpQ5MaYqU0MGjt2EiKNaBo79NkHTeZC2Da63
X-Gm-Message-State: AOJu0YyVcYeqAMczowx/u7PRIbD/bAGeBh7K5yiQyQr6ENd2abTC4b3q
	NWsVHrDJSzVC1hlxNLWAIRsZzUTnNHVg7PqMb2wGPhWOKqxcFooGiqiNO54hRvLDo9ExmRBQChe
	APQ==
X-Google-Smtp-Source: AGHT+IEwwSNQL7Uk2yZ0VknWIStJpVKOxx3COiSHNCEPyEAxFFFoBLgf8pA7JP3oX0B0ao2tWkEzMtP+Sno=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:3f06:0:b0:dcc:2267:796e with SMTP id
 m6-20020a253f06000000b00dcc2267796emr31950yba.2.1708544478455; Wed, 21 Feb
 2024 11:41:18 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:23 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-11-surenb@google.com>
Subject: [PATCH v4 10/36] slab: objext: introduce objext_flags as extension to page_memcg_data_flags
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
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce objext_flags to store additional objext flags unrelated to memcg.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/memcontrol.h | 29 ++++++++++++++++++++++-------
 mm/slab.h                  |  4 +---
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index eb1dc181e412..f3584e98b640 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -356,7 +356,22 @@ enum page_memcg_data_flags {
 	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
 };
 
-#define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
+#define __FIRST_OBJEXT_FLAG	__NR_MEMCG_DATA_FLAGS
+
+#else /* CONFIG_MEMCG */
+
+#define __FIRST_OBJEXT_FLAG	(1UL << 0)
+
+#endif /* CONFIG_MEMCG */
+
+enum objext_flags {
+	/* the next bit after the last actual flag */
+	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+};
+
+#define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
+
+#ifdef CONFIG_MEMCG
 
 static inline bool folio_memcg_kmem(struct folio *folio);
 
@@ -390,7 +405,7 @@ static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -411,7 +426,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
-	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -468,11 +483,11 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
 
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 		return obj_cgroup_memcg(objcg);
 	}
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -511,11 +526,11 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
 
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 		return obj_cgroup_memcg(objcg);
 	}
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
diff --git a/mm/slab.h b/mm/slab.h
index 7f19b0a2acd8..13b6ba2abd74 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -560,10 +560,8 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 							slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 
-	return (struct slabobj_ext *)(obj_exts & ~MEMCG_DATA_FLAGS_MASK);
-#else
-	return (struct slabobj_ext *)obj_exts;
 #endif
+	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-- 
2.44.0.rc0.258.g7320e95886-goog


