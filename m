Return-Path: <linux-kernel+bounces-130799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A74897D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02868B2788A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C986848A;
	Thu,  4 Apr 2024 01:03:27 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE684C7D;
	Thu,  4 Apr 2024 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192606; cv=none; b=ucUhqeBAE/E7bry/VDYTSTkVm0kxS1dL4awgjC6pqnZTML1c8O6sRollN7vOlox3YO9DH9xcliz9MZgppP80mmvAxOIrdCF9kP7Ziq+guvHxAvO3Mv+AC8FooYsWGUEu8ldpvEUDviOx/Fp9bKQMgRChyrgfmhTgeAqR+Iy/UHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192606; c=relaxed/simple;
	bh=LGd6saAhTNRNk6SUdRvYglHLJ9GcARn88XlV4Fy2oe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4/aDxOU01nI0pmhdEeA66b29u3GUZ6d/TZ6HOPzpAnWC6D4ZsBviXxl+iCNaSbAbsmC5KcZ1LOoVPBxufQhDJTLPeXxVjtCyffKVALTBucv8SNH3qQLgGQQPhAgty7qFPNxHeSfBt6g9h5o8E47IQlAAQ9zCEd5F55gSXIe62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c89cd8df36so14454939f.1;
        Wed, 03 Apr 2024 18:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192603; x=1712797403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6vxAkr4s6qgE7mbwQ5Lwv040fqC5GXe0Ujo9eHHndY=;
        b=NT74vLcIT4iO54SVR8NL0G6kkftLRnxzYj4qhv8hN04e8QUzWenY3d9Q3GJPDx+ezT
         vXgk1kxZg8l5LE5RljDYT3vW93fW3TqlN8sPtxV5o18W5lZEe2Rw/Tzy95svAMKx5iIt
         7/XcZ70Hh3pi93OV4rVy4n7l2F4c/djUIvkTh+XdTan8LKbXSisWJRJSD5H5hK2WCeiU
         wRPA08eIF8hZLPlqYxIRkp/BlxWRxJg2gau6niV9985+z0WTt5DI5zoxymUMj1GvjzZR
         1p55AmaGbplhLamYx9uzD+j+svst2uPgmSHnjZBOnYrtn6QLSR2mfDI/Vigi1X4D+6zH
         UYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYo9VxQm3vvYg9gGI9FSH0NEcc4E2bvJ7s+JF9GShZjPKrUwgXmz0IYyRYXM+WTb2cIEI16zx2pDGkG1yI49p1gcnUs1fEYvs4Xa+7
X-Gm-Message-State: AOJu0Yxhufz21zniE7aE/ihY7faYTWSb0+lkcY86tEORO+mg92IvmYqY
	OpCxpuR4IbrM+94P9bURsn/iXZB8l4X8rGWZg1rDCpxaZKBtcewe5NnyhBzNi68=
X-Google-Smtp-Source: AGHT+IHod2TfUcFpAwmb9wyGSXQqLBEZQypuU88VQILclSgT27zEVtPrfMXvG4Qt52wNhtvfP/Nutw==
X-Received: by 2002:a05:6602:2195:b0:7d0:895b:5352 with SMTP id b21-20020a056602219500b007d0895b5352mr1414812iob.10.1712192603593;
        Wed, 03 Apr 2024 18:03:23 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id f23-20020a056638023700b00476def848f1sm4132719jaq.131.2024.04.03.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:03:23 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
Date: Wed,  3 Apr 2024 20:03:07 -0500
Message-ID: <20240404010308.334604-1-void@manifault.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
programs. The whitelist approach taken for enabling kfuncs makes sense:
it not safe to call these kfuncs from every program type. For example,
it may not be safe to call bpf_task_acquire() in an fentry to
free_task().

BPF_PROG_TYPE_SYSCALL, on the other hand, is a perfectly safe program
type from which to invoke these kfuncs, as it's a very controlled
environment, and we should never be able to run into any of the typical
problems such as recursive invoations, acquiring references on freeing
kptrs, etc. Being able to invoke these kfuncs would be useful, as
BPF_PROG_TYPE_SYSCALL can be invoked with BPF_PROG_RUN, and would
therefore enable user space programs to synchronously call into BPF to
manipulate these kptrs.

This patch therefore enables invoking the aforementioned core kfuncs
from BPF_PROG_TYPE_SYSCALL progs.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 1 +
 kernel/bpf/helpers.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index dad0fb1c8e87..33c473d676a5 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -474,6 +474,7 @@ static int __init cpumask_kfunc_init(void)
 	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
 						   ARRAY_SIZE(cpumask_dtors),
 						   THIS_MODULE);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d9e7aca8ae9e..8cde717137bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2653,6 +2653,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.44.0


