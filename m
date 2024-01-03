Return-Path: <linux-kernel+bounces-15704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B082309E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8173D285BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0791BDDB;
	Wed,  3 Jan 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwvB7vTC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2B1B284
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbea05a6de5so686582276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704296000; x=1704900800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyqq+fE1NkHrvUhRDNlGH8Dgi07Vh12wXyYd0sabOJE=;
        b=WwvB7vTCtKWxWx4vgepaiaefjGiFoUZQV8k/KXFGYkAKYLhlwz3ein3EAyhlyKYeRd
         mPV6tJXtymGI2OqJpdUvdGAylDoxL+b5r+ANQrdFQKQ8lVARuV8d/kMCU8lUqMVMR4d7
         V3tFSj6xr1dVAeE5+w5JStR+8etD2QoElo7HARbRzHz6+EvfAYcLGU9rZfdKljm11g9A
         5IC83wgsbIcU1uvoAVdTkslCtPAtMuexLQoRsJJVR+sZ/vQiAbhUdJTq0WisaTDlQ743
         NCLgdJx7E52OLGfxsSDBdiCDiUeEHnqZzNau3yzAu01UxYyitGLRVp7CAIUvkGx/Gcu5
         vr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296000; x=1704900800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyqq+fE1NkHrvUhRDNlGH8Dgi07Vh12wXyYd0sabOJE=;
        b=J+889MvF1Qt/a8DLgP5tRylhZTGL5sKXdjx5K3L5zAx5bIM08HugfvBtWHgx0X33aH
         RsuLoqjh6pZ2BF08QPg+V8C2iDsajEDsFmt76QzZ/Dm03EMBEVhqajm/U6+fE9+EIMch
         30tHPmk2v9uceMctPE+m+rqsxyoRcs+S5ksQOh8bL94Qr85G33nSI7fwYS9GRmZjPnd+
         3CYDFpDPghvea+l8LTRprxz33dd8FrpHgZsVreRWWfWTQS5ThAn7zgR8d/vjPS7+nELq
         rD49cRLvlDlE8GUo5xHIfv5ioIMVaAXklnlcIgyrjXKjWVCDRRyJjOQquS+LtX1N22ev
         gDFA==
X-Gm-Message-State: AOJu0YwIlTZXGDh96v2Y4dDkj3mfJ6/xzyePCr+iuIwYqXpQHNT7M3sK
	gG6YpN/EMCeutBI8yGihzyOMvoEtzAKJ3h0=
X-Google-Smtp-Source: AGHT+IF6sM8Lzs882ujLhq7q/bK9uAvKMHC3e/wALAesdwXB1bLYZYP0QlL849nMwejsRip5WOrWHgMU
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:7e71:cfbd:2031:cc52])
 (user=brho job=sendgmr) by 2002:a25:9b09:0:b0:dbd:e996:1944 with SMTP id
 y9-20020a259b09000000b00dbde9961944mr511514ybn.5.1704296000533; Wed, 03 Jan
 2024 07:33:20 -0800 (PST)
Date: Wed,  3 Jan 2024 10:33:01 -0500
In-Reply-To: <20240103153307.553838-1-brho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103153307.553838-1-brho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103153307.553838-2-brho@google.com>
Subject: [PATCH bpf-next 1/2] libbpf: add helpers for mmapping maps
From: Barret Rhoden <brho@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_map__mmap_size() was internal to bpftool.  Use that to make wrappers
for mmap and munmap.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 tools/bpf/bpftool/gen.c  | 16 +++-------------
 tools/lib/bpf/libbpf.c   | 23 +++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b8000d..a328e960c141 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -453,16 +453,6 @@ static void print_hex(const char *data, int data_sz)
 	}
 }
 
-static size_t bpf_map_mmap_sz(const struct bpf_map *map)
-{
-	long page_sz = sysconf(_SC_PAGE_SIZE);
-	size_t map_sz;
-
-	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map__max_entries(map);
-	map_sz = roundup(map_sz, page_sz);
-	return map_sz;
-}
-
 /* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
@@ -641,7 +631,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
-			       ident, bpf_map_mmap_sz(map));
+			       ident, bpf_map__mmap_size(map));
 		codegen("\
 			\n\
 				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
@@ -723,7 +713,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 					goto cleanup;			    \n\
 				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
 			}						    \n\
-			", ident, bpf_map_mmap_sz(map));
+			", ident, bpf_map__mmap_size(map));
 	}
 	codegen("\
 		\n\
@@ -780,7 +770,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
 			",
-		       ident, bpf_map_mmap_sz(map), mmap_flags);
+		       ident, bpf_map__mmap_size(map), mmap_flags);
 	}
 	codegen("\
 		\n\
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ebcfb2147fbd..171a977cb5fd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9830,6 +9830,29 @@ void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 	return map->mmaped;
 }
 
+size_t bpf_map__mmap_size(const struct bpf_map *map)
+{
+	long page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t map_sz;
+
+	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) *
+		bpf_map__max_entries(map);
+	map_sz = roundup(map_sz, page_sz);
+	return map_sz;
+}
+
+void *bpf_map__mmap(const struct bpf_map *map)
+{
+	return mmap(NULL, bpf_map__mmap_size(map),
+		    PROT_READ | PROT_WRITE, MAP_SHARED,
+		    bpf_map__fd(map), 0);
+}
+
+int bpf_map__munmap(const struct bpf_map *map, void *addr)
+{
+	return munmap(addr, bpf_map__mmap_size(map));
+}
+
 bool bpf_map__is_internal(const struct bpf_map *map)
 {
 	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6cd9c501624f..148f4c783ca7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -996,6 +996,12 @@ LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
+/* get the mmappable size of the map */
+LIBBPF_API size_t bpf_map__mmap_size(const struct bpf_map *map);
+/* mmap the map */
+LIBBPF_API void *bpf_map__mmap(const struct bpf_map *map);
+/* munmap the map at addr */
+LIBBPF_API int bpf_map__munmap(const struct bpf_map *map, void *addr);
 
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 91c5aef7dae7..9e44de4fbf39 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,4 +411,8 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
+		bpf_map__mmap_size;
+		bpf_map__mmap;
+		bpf_map__munmap;
 } LIBBPF_1.3.0;
-- 
2.43.0.472.g3155946c3a-goog


