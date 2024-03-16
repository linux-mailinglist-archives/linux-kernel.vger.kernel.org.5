Return-Path: <linux-kernel+bounces-105031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6587D7D9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20381C21188
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBA1C27;
	Sat, 16 Mar 2024 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuOmhsgu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60F17E9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554288; cv=none; b=mKyWgcmLdwUHHQR73Bj5rV79pIT4BJT+LWDO4QlDWKkW0Pihe3XvpM/wYufqBc8ZimwWJAaA4ko+OWVe5pqGAgdzyaO3QyjjHBRLIaVdFz/sI1JtGtRxgG0XfvwxPzp10svhGp9liJyeO5ugrsBmDd3t/yCCdQ84qR+Nz16QCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554288; c=relaxed/simple;
	bh=aUUK1f7m/VOQ2n5+Z0YNpJ/VO1faVhBvtbBDCJbp2JY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=glu0V1T056uio4H0ZRj3mlJ79cu2FS+xAs+82x/rk4lcmX5RqRqaJ4XK0iWiG4aWvYDuiK7wF+CaPR33TYZUv/rRuMjP9djvjloQ4BfC+p27ZvUGpQ2dkgneaSvko36KEqFFGv0abtHHndS6uRidJZ4R8NPyuHBXHib7OlrzOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuOmhsgu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a629e2121so48433427b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710554286; x=1711159086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nz/rmcCjj7pCrgBiVdioT3UkYrnHawa2JdhbUXSYaXE=;
        b=WuOmhsgukkj9RPHyfSej1xNUhg1zvlD/9BbWqpJp94AA/XwczxoaRs9M1JfX7c5U5x
         l6V+pENvwT4m0vpc7pfLHYBg+KsAqtdlTVBEM27LZFAb+AfZXyTHMTOx4BHseHwNtsEJ
         wgFdU4/lFRi1xpTNqyNYMPJ0vOFm4k5XNOe1P9detQqWKbKsp17Mpdq4GO4C8a4OAwsF
         sqElxKl5ZPEePxa6nLqN+ik9f5lfJaudgX9fifkV9UvxPoehUMztQKQNbl4IPF9ZdiQP
         qa/RlHez9bFUN4lad3PWzt2221PLwmI4D8TWhVIIK847Ayo25Lv8P7EC8jRFh9OBF1HP
         A1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710554286; x=1711159086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nz/rmcCjj7pCrgBiVdioT3UkYrnHawa2JdhbUXSYaXE=;
        b=YpnM/uqGGgiAVq90JAuOzA5VgQTYPVOVjyckrgwNzVU32WoSiojve/W6bBV6nVfleq
         L7OoG4SItwKIzNPDIMGWq2qyQfpvLOQH3QdxDwwLFtqVvxjBrApgpfym4ikBDTEfsngE
         HJ5kbrDmlgFHjWkDKrbW10h3oN7caW3CYuLH+4aYqh3ZfByGzxc2Sr/f6P3JRYXC+cff
         Tlf8ecljQmywDqHGGkkE/sSpSWvl0UOruvHplKmTtPGTunvU2fSuWSyrVJMGX9M73kno
         jU+fLN0mNgDLtttSqfmI31k1SC2il3adPf9+qaO7seMPSPy0oYJB3p0Y9se8BTUnkLHv
         3bHA==
X-Forwarded-Encrypted: i=1; AJvYcCWE4tY45/2MPUALgFIi1Rn744Ksi0B/VTEB0PR8NZVthJJVHK++0/uUSVz+X9n1dMYmIMW83Bb8i4RZcQw8ENM7o6568HOZALJ9khFn
X-Gm-Message-State: AOJu0Yydi9RF36daqAy50sjiysU+YZsvfBWYZLQfNkS4pc0IfZPCxu3Q
	dtJlL95C35IApVrC/vgeVmZx5dmeTxielR0pkjLgvlYw9dpLLUTfc29S6T+r10pSYgpgi7yA+m7
	m51b00uVEFKSW6fTW5g==
X-Google-Smtp-Source: AGHT+IGmRUBmhZYJ4tRjAVcL7DY6ga9tWCPr/y80MXCGP3YTBlk6hr1HiyCUa9cZ20xmmsx/xGgByCG91hqdia4A
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e813:0:b0:609:25d1:ea9a with SMTP
 id r19-20020a0de813000000b0060925d1ea9amr1600283ywe.9.1710554285742; Fri, 15
 Mar 2024 18:58:05 -0700 (PDT)
Date: Sat, 16 Mar 2024 01:58:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240316015803.2777252-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: add NULL check to obj_cgroup_put()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

9 out of 16 callers perform a NULL check before calling
obj_cgroup_put(). Move the NULL check in the function, similar to
mem_cgroup_put(). The unlikely() NULL check in current_objcg_update()
was left alone to avoid dropping the unlikey() annotation as this a fast
path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  3 ++-
 kernel/bpf/memalloc.c      |  6 ++----
 mm/memcontrol.c            | 18 ++++++------------
 mm/zswap.c                 |  3 +--
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 394fd0a887ae7..b6264796815d4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -818,7 +818,8 @@ static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
 
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
-	percpu_ref_put(&objcg->refcnt);
+	if (objcg)
+		percpu_ref_put(&objcg->refcnt);
 }
 
 static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 550f02e2cb132..a546aba46d5da 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -759,8 +759,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
-		if (ma->objcg)
-			obj_cgroup_put(ma->objcg);
+		obj_cgroup_put(ma->objcg);
 		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 	if (ma->caches) {
@@ -776,8 +775,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
-		if (ma->objcg)
-			obj_cgroup_put(ma->objcg);
+		obj_cgroup_put(ma->objcg);
 		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 138bcfa182344..aab3f5473203a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2370,8 +2370,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	if (old)
-		obj_cgroup_put(old);
+	obj_cgroup_put(old);
 }
 
 /*
@@ -3147,8 +3146,7 @@ static struct obj_cgroup *current_objcg_update(void)
 		if (old) {
 			old = (struct obj_cgroup *)
 				((unsigned long)old & ~CURRENT_OBJCG_UPDATE_FLAG);
-			if (old)
-				obj_cgroup_put(old);
+			obj_cgroup_put(old);
 
 			old = NULL;
 		}
@@ -3420,8 +3418,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	if (old)
-		obj_cgroup_put(old);
+	obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -3548,8 +3545,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	if (old)
-		obj_cgroup_put(old);
+	obj_cgroup_put(old);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
@@ -5470,8 +5466,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int node;
 
-	if (memcg->orig_objcg)
-		obj_cgroup_put(memcg->orig_objcg);
+	obj_cgroup_put(memcg->orig_objcg);
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
@@ -6622,8 +6617,7 @@ static void mem_cgroup_exit(struct task_struct *task)
 
 	objcg = (struct obj_cgroup *)
 		((unsigned long)objcg & ~CURRENT_OBJCG_UPDATE_FLAG);
-	if (objcg)
-		obj_cgroup_put(objcg);
+	obj_cgroup_put(objcg);
 
 	/*
 	 * Some kernel allocations can happen after this point,
diff --git a/mm/zswap.c b/mm/zswap.c
index e0ec91995f4e3..3c2f960a789ba 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1533,8 +1533,7 @@ bool zswap_store(struct folio *folio)
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
-	if (objcg)
-		obj_cgroup_put(objcg);
+	obj_cgroup_put(objcg);
 check_old:
 	/*
 	 * If the zswap store fails or zswap is disabled, we must invalidate the
-- 
2.44.0.291.gc1ea87d7ee-goog


