Return-Path: <linux-kernel+bounces-97327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FD8768D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8201F2129B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF511B7E9;
	Fri,  8 Mar 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szq9eLfL"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08E1CF8F;
	Fri,  8 Mar 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916562; cv=none; b=JYB/YkUJu5O30oi97/DrriKtwU+VQsL55Pr+VHJMIJy0xdtu41BM1TWidoEvzZOAp0dzKdaP0yabM5SnssiUUNuYYN4H+IvPQ+r2h7buVWm81mbpfLzZ60qtaREgJWHlrgko4iPjMMdOG5CHzbn4pee5kNWMMDyiymuRU1g5018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916562; c=relaxed/simple;
	bh=S0Dp/WBR/EujGLQqqCGTWW5cVi0WtWTDa9DqA4ijtho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OfAzxeQ6VTlh+Wgr7XVK/GzxiSBYQZtOSGX8PpbHUV9TFyJqqPUrYcEU6lGYrtfzSsZRjezbjdGDhJJkW5liCHw3soZS46W0Blg8Samiz53w2xfIATJdhEjJCorp0E5kRSmZdoGWSfK/6CLoBt71fhtgJaI3q1F1OeM5z9StIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szq9eLfL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1836349a12.2;
        Fri, 08 Mar 2024 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916560; x=1710521360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0nYRWlBOyohOq+wmgk45L39MksWf6aczzJ+KIoLdfo=;
        b=Szq9eLfLmnuaMp/8ey66kKKLbPs9nhVuay/Cc69+GqUJbmnxQrbXXjvTp5DYrkczGW
         BrOaoIv6i93tIqXSwl74e7eUAuTWXvRSNgc24x8Xvw2WWhx/UkDYDhuEi+kkn82T58Id
         iMRbSUeVGGkbg7kakhvk8QISnIb3OPG544Vw8COJpOldYu1K10Em8pFVQM66TMTfPe1R
         +FCoE3pHSlH6fLLQTknndOZuhycYqKIUTKd0+6A9n7NAOTszyZQdQUCaKa+lTqBWWvha
         2L1fajzZTzQUhzKJOa+ZhCRCDZkpkD3Ylu3VADJNpWALmTGWVToLg6ys12JnaoJDFFsA
         d00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916560; x=1710521360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0nYRWlBOyohOq+wmgk45L39MksWf6aczzJ+KIoLdfo=;
        b=gUClNTtf5B1Zb/zv00bTuBgCgSa/+1so1RcM1czoetNdQWtR9VdoqepZjvhF5gyo1l
         wq9lZBuolXJ4/A8lvAfR7YY39n1Q280woCd53pyNO3/BpDKQrmh1wIcNRtzThId19LNO
         YXFYEKnnt7wgU23W2HADbbBL1xI6LEdO8pdRA4JvBpTp6TCAmlt6U3aoW+FN0ypyweHT
         0oFr87YTu/gRb3HL28005yGrhKc20Tx2uWRaEPI0/lxVaj9BBqwNkuYw0SNj1tQ/gFJf
         5KJ2gYxv+FVJFPPTpknil9xk2xolYSL/3k6QSRWzL8q+T+n8Q4lAV01Sdj73qT2Aj4w3
         YUow==
X-Forwarded-Encrypted: i=1; AJvYcCUFeuW+3JKchX3HRfKt6B+0yPLI2UrUd1+RlTT1xfIkhIKd9JXj/kgUJcstuN/+t2Kdr9cZpW8huvBTKzC0mrKRDiOc+VwlZsyLw7S8ObkLBHkQmwf77BgkJU4gZMmKTJes
X-Gm-Message-State: AOJu0YzNDDkzXvyJQUxLLaY19sz0U1OxehfApax6uuVh0Qjsg6emQ7DG
	/EvPM/Ksp0HehWTk7IFDkyV8lHWEgdtDy03DNgJtTVVf26wdrs/Y
X-Google-Smtp-Source: AGHT+IGoXj2uKpQqLd5DtfnhCg/6JNd8Lt1Wdw018u5BYLYSz8lFaPR7sSVCQCTVcuIq4bLALVv3LA==
X-Received: by 2002:a17:90a:de85:b0:29b:a149:2fed with SMTP id n5-20020a17090ade8500b0029ba1492fedmr583646pjv.10.1709916560239;
        Fri, 08 Mar 2024 08:49:20 -0800 (PST)
Received: from localhost ([117.147.31.93])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090a051600b002992f49922csm3689154pjh.25.2024.03.08.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:49:19 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: chen.dylane@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] WIP: bpf: Support lookup_and_delete_elem for stackmap
Date: Sat,  9 Mar 2024 00:49:11 +0800
Message-Id: <20240308164911.118640-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend lookup_and_delete_elem for stackmap, so we can clear the
elem in time in the userspace like the eBPF tool profile in bcc.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/stackmap.c |  8 ++++++--
 kernel/bpf/syscall.c  | 12 +++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 49f8b691496c..11d21e4e861b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2284,7 +2284,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 flags);
 
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
+int bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value, bool delete);
 
 int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 458bb80b14d5..935f537dced0 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -563,7 +563,7 @@ static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall */
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+int bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value, bool delete)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *old_bucket;
@@ -580,7 +580,11 @@ int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	memcpy(value, bucket->data, trace_len);
 	memset(value + trace_len, 0, map->value_size - trace_len);
 
-	old_bucket = xchg(&smap->buckets[id], bucket);
+	if (!delete)
+		old_bucket = xchg(&smap->buckets[id], bucket);
+	else
+		old_bucket = bucket;
+
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
 	return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d77b2f8b9364..77afce8710a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -225,7 +225,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
+		err = bpf_stackmap_copy_and_delete(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
 		err = bpf_fd_array_map_lookup_elem(map, key, value);
 	} else if (IS_FD_HASH(map)) {
@@ -1372,7 +1372,8 @@ struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 }
 EXPORT_SYMBOL_GPL(bpf_map_inc_not_zero);
 
-int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+int __weak bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value,
+										bool delete)
 {
 	return -ENOTSUPP;
 }
@@ -1897,7 +1898,8 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 
 	if (attr->flags &&
 	    (map->map_type == BPF_MAP_TYPE_QUEUE ||
-	     map->map_type == BPF_MAP_TYPE_STACK)) {
+	     map->map_type == BPF_MAP_TYPE_STACK ||
+		 map->map_type == BPF_MAP_TYPE_STACK_TRACE)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1936,6 +1938,10 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 			rcu_read_unlock();
 			bpf_enable_instrumentation();
 		}
+	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
+		bpf_disable_instrumentation();
+		err = bpf_stackmap_copy_and_delete(map, key, value, true);
+		bpf_enable_instrumentation();
 	}
 
 	if (err)
-- 
2.34.1


