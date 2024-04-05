Return-Path: <linux-kernel+bounces-133159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7E899FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C872E1C22FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C516EC02;
	Fri,  5 Apr 2024 14:30:49 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37116F287;
	Fri,  5 Apr 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327449; cv=none; b=m0/ogDpwOJjr5h4s6T11g7s3BINlJdZSMyOgLRWyuQrVVr8vCbQ6sm7Q65uNqPxho3hiPcNRsJLErJKaKX0FLN9kk52CB0p1aLadZhNEGQo+vDZCnhqsjD+sFcUm7fvJIR7aY5gzGc8h4IbwAeweI8MmmUII4BglEIhyt3hSQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327449; c=relaxed/simple;
	bh=Af7RfGng24yIeWpBRm0kOdGB8o4WJWgS/TCB+Uarq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJRXXgUkUs/fhwZ3h3ZvEB+HbpV9ftN1ITsIQugmJU30y0/mhLDPrPNS3n0PlWqrI+c1ObRH6ciczAH5ipdzrr6HZKLH84ROYuv1DvYcJVCIJCq14bS0Mn+xZB3p5nzNc0hL/b0jFjZa+jg3Ffvu2k9BJaEseezXglTz6ed0Zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0486e3250so97924239f.1;
        Fri, 05 Apr 2024 07:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327446; x=1712932246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRdyQGjH5h8G6pfTdtidr525YhFZdrjl1y7kv2e1qZU=;
        b=vHvUwNxf2DtwtBcgkk1RyYJC3jpG3OfbjyOIVKTMyKKENdCGVN9R7b8k9pEJ7Ar0YY
         olU+V+0BsvNNic/F5DZkq3WoSIc1GR3i7lOqYvW42wwA+zaC3tDTSnkue+o/d4TfVmnc
         2l1Tm/r4VVk3xfYdojelUnlfGlNK1oTPGHrJ5vppDpkAZgAKlWEsgZpvLYT3IUvJD8hB
         ZwvihycTE3psYphLnpezGEEpYEepW1b9jlB8l8wfKbANXqSvR2VOeGwvaS9FnlqgrMM7
         0CtuD+ovG1CRQdr3NHNWtAw6qSrZS4dHKt2Pf2Gg99CI37Zzc6hvJP50kflE8uezzwTw
         TAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUoOKwmU2ts2m0mi2fqCrzzsoz5rSYWJEmKI5slbGG4AiSwq8QCgfgXUzTPei0SEe0W8hxVrl+3QoxkBX3RtZ+cMJPr8Y1Mxxlbx499
X-Gm-Message-State: AOJu0YytjDwk9BukpZYWoEvqPD9k79ImpVwg1LHQs1N8HWeQXCokBjMM
	cm6VLf0JKj7sYEPngpLTwlr/YqY7qFBFe72U6yvYSTmELSoEazStVaVWVshWp6o=
X-Google-Smtp-Source: AGHT+IHwCpC+nlq92i3i64MzB7M2JZOQULTAu4iHJxah0OkDaWK28l6hGw6L6Xzey5XCVLCxEJqL0w==
X-Received: by 2002:a6b:e704:0:b0:7d3:3e0d:9daa with SMTP id b4-20020a6be704000000b007d33e0d9daamr1706139ioh.7.1712327446257;
        Fri, 05 Apr 2024 07:30:46 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id x25-20020a6b6a19000000b007d35949850asm527741iog.26.2024.04.05.07.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:30:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL
Date: Fri,  5 Apr 2024 09:30:41 -0500
Message-ID: <20240405143041.632519-3-void@manifault.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405143041.632519-1-void@manifault.com>
References: <20240405143041.632519-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, let's
add some selftests that verify as much. As a bonus, let's also verify
that we can't call the progs from raw tracepoints. Do do this, we add a
new selftest suite called verifier_kfunc_prog_types.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 .../prog_tests/verifier_kfunc_prog_types.c    |  11 ++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |   2 +-
 .../selftests/bpf/progs/task_kfunc_common.h   |   2 +-
 .../bpf/progs/verifier_kfunc_prog_types.c     | 119 ++++++++++++++++++
 4 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
new file mode 100644
index 000000000000..3918ecc2ee91
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+
+#include "verifier_kfunc_prog_types.skel.h"
+
+void test_verifier_kfunc_prog_types(void)
+{
+	RUN_TESTS(verifier_kfunc_prog_types);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 22914a70db54..73ba32e9a693 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -13,7 +13,7 @@ struct __cgrps_kfunc_map_value {
 	struct cgroup __kptr * cgrp;
 };
 
-struct hash_map {
+struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
 	__type(value, struct __cgrps_kfunc_map_value);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 41f2d44f49cb..6720c4b5be41 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -13,7 +13,7 @@ struct __tasks_kfunc_map_value {
 	struct task_struct __kptr * task;
 };
 
-struct hash_map {
+struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
 	__type(value, struct __tasks_kfunc_map_value);
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
new file mode 100644
index 000000000000..b7f17c6b3443
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "cgrp_kfunc_common.h"
+#include "cpumask_common.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+/***************
+ * Task kfuncs *
+ ***************/
+
+static inline void task_kfunc_load_test(void)
+{
+	struct task_struct *current, *ref_1, *ref_2;
+
+	current = bpf_get_current_task_btf();
+	ref_1 = bpf_task_from_pid(current->pid);
+	if (!ref_1)
+		return;
+
+	ref_2 = bpf_task_acquire(ref_1);
+	if (ref_2)
+		bpf_task_release(ref_2);
+	bpf_task_release(ref_1);
+}
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+int BPF_PROG(task_kfunc_raw_tp)
+{
+	task_kfunc_load_test();
+	return 0;
+}
+
+SEC("syscall") __success
+int BPF_PROG(task_kfunc_syscall)
+{
+	task_kfunc_load_test();
+	return 0;
+}
+
+/*****************
+ * cgroup kfuncs *
+ *****************/
+
+static inline void cgrp_kfunc_load_test(void)
+{
+	struct cgroup *cgrp, *ref;
+
+	cgrp = bpf_cgroup_from_id(0);
+	if (!cgrp)
+		return;
+
+	ref = bpf_cgroup_acquire(cgrp);
+	if (!ref) {
+		bpf_cgroup_release(cgrp);
+		return;
+	}
+
+	bpf_cgroup_release(ref);
+	bpf_cgroup_release(cgrp);
+}
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+int BPF_PROG(cgrp_kfunc_raw_tp)
+{
+	cgrp_kfunc_load_test();
+	return 0;
+}
+
+SEC("syscall") __success
+int BPF_PROG(cgrp_kfunc_syscall)
+{
+	cgrp_kfunc_load_test();
+	return 0;
+}
+
+/******************
+ * cpumask kfuncs *
+ ******************/
+
+static inline void cpumask_kfunc_load_test(void)
+{
+	struct bpf_cpumask *alloc, *ref;
+
+	alloc = bpf_cpumask_create();
+	if (!alloc)
+		return;
+
+	ref = bpf_cpumask_acquire(alloc);
+	bpf_cpumask_set_cpu(0, alloc);
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)ref);
+
+	bpf_cpumask_release(ref);
+	bpf_cpumask_release(alloc);
+}
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+int BPF_PROG(cpumask_kfunc_raw_tp)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
+
+SEC("syscall") __success
+int BPF_PROG(cpumask_kfunc_syscall)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
-- 
2.44.0


