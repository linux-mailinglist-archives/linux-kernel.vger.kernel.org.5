Return-Path: <linux-kernel+bounces-117406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A703788AAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312581F6429B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197791419B1;
	Mon, 25 Mar 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkOjk/Il"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B113E8A0;
	Mon, 25 Mar 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381680; cv=none; b=TuoP3TSJdOltPTkl10aE5cYmDbhWzmam/DrK6Ny0mD4kwyePsvvk5LnFc6FeZ22GF8h5iXOLHSsdUa52LRwkUK6psFDfKOyvEjZ7zfHjA11CUB8TATDeLAbfgzvDxeVmW+TzwkDXLyn/b4nSSBzfAihmbuhNqM1StTnnZVwoyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381680; c=relaxed/simple;
	bh=mvvdkm7cWc9qKXInCyiVibBC9xDX3H4bRjU01AqzUBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noL/28fI3zjGsDGLTJzzTVhzt2C8mxFRdVIGr33hFuKeKFzu/XTfPPr96V6/1vdJaJ08OPrgEIxAPmOELXWXxk+jN5cRM7W/LOswXysphNYCV12xvIHdzrMnyrioyy3nP/SBtvnMBBORx+Y1QHApi+VKSb3/D+aYHS5rnepuRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkOjk/Il; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0189323b4so33492895ad.1;
        Mon, 25 Mar 2024 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711381678; x=1711986478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zOZsJzIzK5aa7TbeViHBJbBdj6M2gj9ZvGgoPmIol8=;
        b=ZkOjk/IluuqPT0l/GcV4Y+VxBWrzikjdG6iXIapQ6AvPk29QSl48vyY3ANf8WmqZ6N
         jyOJPZkLLTVxuElNAluM6phms0ByJAPMVVsSVDeibfhVJLiBoqxyI5ZuU2cdve4rSNkx
         R6Oy4DkS2K3CKrOG4Y/sbJNK9BsIzidQygvMFqhXIISDPTeFXlXPD7e1i4ddVJu6RoBx
         g/3qNJ82N+tkd7ZiNhYp2m/5Q0M5y23HoY9vUcMsSYt9BZTyiWE87jZJp2DKQgWzFpYb
         tdSrbqdygoJypkJ3I8L2bGIYqwXt/xyuIC1NZRC4LXA+PzkOH/+R9ktZfxGYaD1mohbo
         OaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711381678; x=1711986478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zOZsJzIzK5aa7TbeViHBJbBdj6M2gj9ZvGgoPmIol8=;
        b=NkdGXJQKleS+hvLV+9niVgGGm3xWyz3xZyPFDilLxnqDMziLiTz8O1ccnPu+0fDAL1
         FGyqxQEPrRsVyETs2ik4tLm9hDRfIOxug+JTtdv6M/03VT7WPJpud+o9CzyCbLLvDnMs
         ZwmGLnf+1Y6Pq7ceYVXtwn3jO0UzwXto/XNZUuTDbnGEOEXyWiAS8dkCuaEBvodyMzdB
         rX2ewVFxJEweF7gdgAmvTfJ8ziyj481MH6izxweva7m2C4o70FedGcdHIDDI6Q3x/4RB
         ESclAPSrpTDP+kXCg9oseEqqfQzBvOnxP/vgNNqTZjFBiXPM0dSFuRkxbslueqoxpfUq
         Fipw==
X-Forwarded-Encrypted: i=1; AJvYcCVpKb5UktP8M2SpmjC8ZKoeeIG+6xRtD50SAhh+5m8n/gjI05GeQPnxC4RBcR2Scy/TMALFQ4XRpc/xmnpQCkcUEAqHiL59yEIOzApg
X-Gm-Message-State: AOJu0Yx+5ZRjKaDx/01vrgjnyKR9NhwhF5leG1I6HX6+oYRumSI/Y2C3
	uBdln7iuiedGNQZRIhUlxiOem8MZgrTMCoD9GYN8RWzYcV5oP0gd
X-Google-Smtp-Source: AGHT+IGQfsvLiB+KTGC/1TqedzYxCoTvu8iBsJ79QW4P9osVUJfxem2SCwyMRgk5dQeZdXCKY5MgjA==
X-Received: by 2002:a17:903:1cb:b0:1e0:9c35:e07f with SMTP id e11-20020a17090301cb00b001e09c35e07fmr10097783plh.34.1711381678047;
        Mon, 25 Mar 2024 08:47:58 -0700 (PDT)
Received: from localhost ([106.54.237.100])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001e0d70680acsm442804plh.268.2024.03.25.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:47:57 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [RFC PATCH] libbpf: Add bpf_program__set_section_name api
Date: Mon, 25 Mar 2024 23:47:37 +0800
Message-Id: <20240325154737.3754820-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new api can be used to reset the function we want to trace in
runtime. So we need not to change the code again when we just do
minor changes to the trace function in kprobe or other ebpf event
type. We can replace the old section with new section passed in via
parameter. Maybe the following scenario we can use the api:

1. solve "*.isra.o" issue caused by compiler in new kernel
obj = offcputime_bpf__open();
bpf_program__set_section_name(*(obj->skeleton->obj),
"kprobe/finish_task_switch", "kprobe/finish_task_switch.isra.0");

2. dynamic adjustment for trace function offset
obj = offcputime_bpf__open();
bpf_program__set_section_name(*(obj->skeleton->obj),
"kprobe/finish_task_switch+23", "kprobe/finish_task_switch+45");

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 27 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..94f32e845c61 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8576,6 +8576,30 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 	return prog->sec_name;
 }
 
+int bpf_program__set_section_name(struct bpf_object *obj, const char *old_sec,
+				  const char *new_sec)
+{
+	struct bpf_program *prog = NULL;
+
+	if (obj == NULL || old_sec == NULL || new_sec == NULL)
+		return libbpf_err(-EINVAL);
+
+	do {
+		prog = bpf_object__next_program(obj, NULL);
+		if (prog) {
+			if (strcmp(prog->sec_name, old_sec) == 0) {
+				free(prog->sec_name);
+				prog->sec_name = strdup(new_sec);
+				if (!prog->sec_name)
+					return libbpf_err(-ENOMEM);
+				return 0;
+			}
+		}
+	} while (prog);
+
+	return libbpf_err(-ENOENT);
+}
+
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
 	return prog->autoload;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0e52621cba43..eb620a9c8b8a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -307,6 +307,8 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 
 LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_section_name(struct bpf_object *obj, const char *old_sec,
+					     const char *new_sec);
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..14ac62cff605 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_program__set_section_name;
 } LIBBPF_1.2.0;
-- 
2.34.1


