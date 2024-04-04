Return-Path: <linux-kernel+bounces-130800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993F897D43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043C01F245C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BAF125B9;
	Thu,  4 Apr 2024 01:03:30 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A69474;
	Thu,  4 Apr 2024 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192609; cv=none; b=GqPyffPBYmeoi9XjkUlEVR5WQ37DYvP3Iv1iWn/ahETeZ420p0L7001Q+R6Bz1SC0x0mPizJaZy3Sy/kSUc6s/gpZ4IxIt2Rrkng6zM05M1L2BtVlcp07qhHBTP07wQSfzWY1OhDvJj4Q4hV9yLLUtPAgNUju0ZbnafQO0kZHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192609; c=relaxed/simple;
	bh=hw0ZgXnZn633Jb7sa9cehqutZWFVRlRXEoTD2rY1i0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+foPIIJBI4zsh/9JD7Yc7QMCNZd2+2eejNmZQe/oxLRSNGjBu0/tSmMWlsgCJa6f5LovTHUVs/POV3w2hK5Bps11jZkx59lWzIZ2vXniFE7ojy9DGftCnIXJ0AjYlTbWAsNBrjBADzOo8DNuW5bjTECXqPlYdDukgYbHMkh1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e0dba0fso21125339f.3;
        Wed, 03 Apr 2024 18:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192605; x=1712797405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqgkjiLPZEySCieINTLvJdfXgLnfsvtRLoK1+mECOEQ=;
        b=M7LNpv/yPcsXt689mWRoQSq6/xFyqphYTiP3CJcEkbQzCdgbq5V2RgA35iv0EE4eUY
         xmYJDA23pxR9D4DTbx7f1szfwn4Entjt13yTbMK4YufdombQZ/w079NuGp5HsDMK33wG
         Tr7DcRbjylYGPtQj4yLmFh1YZvIKxvMiEyj96+K18omzxe42iHhNAsGw+nrZbRC6B54S
         8KfZI2t/skJHfr2LiYWSkKHYk+fZyIQL2osiEUNp5PJwDzoMcDvP7I7ntYK8F3zX03I+
         hbLOjm4XaJgy16Ema4DMEz4xkr1+XktddMpPDsvJ0BHAoSX8GrDIhdtmSk8GmaFeX2A1
         fS0g==
X-Forwarded-Encrypted: i=1; AJvYcCUQgn0+noBhZr6amEmG0dPU0dOx5T4Pg7F+NrA/RjpnbCldAXcNaBuRlIWG8IiJA1Fn5g6cuyOrJLzc6PKUVWsaeen5ynzAbMqLaLJn
X-Gm-Message-State: AOJu0YzITkIrNfth85FECVXp1Qvf46AvqppYqNZ3zbBGUMU+CGDakyPH
	sBclQw7yLbyrlqvq6VjQ+aAIZDNGp6kJLphx6iWkJK41EoJz4V7tO1OcRls3/jw=
X-Google-Smtp-Source: AGHT+IH5qzIJzadOeB7Uvs69Zd8gU3gaydcPSSV5dE3jL/hxKR+3djzl2v+BvXIVEXLmhoY9l42eXA==
X-Received: by 2002:a6b:cf18:0:b0:7d0:85c7:dd61 with SMTP id o24-20020a6bcf18000000b007d085c7dd61mr1416699ioa.7.1712192605140;
        Wed, 03 Apr 2024 18:03:25 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id ay19-20020a056638411300b0047f48f10459sm39881jab.100.2024.04.03.18.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:03:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL
Date: Wed,  3 Apr 2024 20:03:08 -0500
Message-ID: <20240404010308.334604-2-void@manifault.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404010308.334604-1-void@manifault.com>
References: <20240404010308.334604-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, let's
add some selftests that verify as much. As a bonus, let's also verify
that we can't call the progs from raw tracepoints.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
 .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
 .../selftests/bpf/progs/cpumask_common.h      | 19 +++++++++++++++++
 .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
 .../selftests/bpf/progs/cpumask_success.c     |  3 +++
 .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
 .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
 11 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index adda85f97058..73f0ec4f4eb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	RUN_TESTS(cgrp_kfunc_success);
 	RUN_TESTS(cgrp_kfunc_failure);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index d4579f735398..3db4c8601b70 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -94,5 +94,6 @@ void test_task_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	RUN_TESTS(task_kfunc_success);
 	RUN_TESTS(task_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 22914a70db54..b9972ce4e4dc 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -27,6 +27,27 @@ struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+#define CGRP_KFUNC_LOAD_TEST(__name)		\
+int BPF_PROG(cgroup_kfunc_load_test_##__name)	\
+{						\
+	struct cgroup *cgrp, *ref;		\
+						\
+	cgrp = bpf_cgroup_from_id(0);		\
+	if (!cgrp)				\
+		return 0;			\
+	ref = bpf_cgroup_acquire(cgrp);		\
+	if (!ref) {				\
+		bpf_cgroup_release(cgrp);	\
+		return 0;			\
+	}					\
+						\
+	bpf_cgroup_release(ref);		\
+	bpf_cgroup_release(cgrp);		\
+						\
+	return 0;				\
+}
+
+
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
 	s32 id;
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 9fe9c4a4e8f6..ff67d4632dfa 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -245,3 +245,7 @@ int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const char *pat
 
 	return 0;
 }
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+CGRP_KFUNC_LOAD_TEST(raw_tp)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 5354455a01be..ff1beb29f3f5 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_misc.h"
 #include "cgrp_kfunc_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -221,3 +222,6 @@ int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("syscall") __success
+CGRP_KFUNC_LOAD_TEST(syscall)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index c705d8112a35..5178d62c5c9f 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -60,6 +60,25 @@ u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
 void bpf_rcu_read_lock(void) __ksym __weak;
 void bpf_rcu_read_unlock(void) __ksym __weak;
 
+#define CPUMASK_KFUNC_LOAD_TEST(__name)				\
+int BPF_PROG(cpumask_kfunc_load_test_##__name)			\
+{								\
+	struct bpf_cpumask *alloc, *ref;			\
+								\
+	alloc = bpf_cpumask_create();				\
+	if (!alloc)						\
+		return 0;					\
+								\
+	ref = bpf_cpumask_acquire(alloc);			\
+	if (ref)						\
+		bpf_cpumask_release(ref);			\
+	bpf_cpumask_set_cpu(0, alloc);				\
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)alloc);	\
+	bpf_cpumask_release(alloc);				\
+								\
+	return 0;						\
+}
+
 static inline const struct cpumask *cast(struct bpf_cpumask *cpumask)
 {
 	return (const struct cpumask *)cpumask;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index a9bf6ea336cf..55815df8000f 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -190,3 +190,7 @@ int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 c
 
 	return 0;
 }
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+CPUMASK_KFUNC_LOAD_TEST(raw_tp)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 7a1e64c6c065..a4f32a5a26d1 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -525,3 +525,6 @@ int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_fl
 		bpf_cpumask_release(mask2);
 	return 0;
 }
+
+SEC("syscall") __success
+CPUMASK_KFUNC_LOAD_TEST(syscall)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 41f2d44f49cb..2278325ca902 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -26,6 +26,24 @@ struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+#define TASK_KFUNC_LOAD_TEST(__name)			\
+int BPF_PROG(task_kfunc_load_test_##__name)		\
+{							\
+	struct task_struct *current, *ref_1, *ref_2;	\
+							\
+	current = bpf_get_current_task_btf();		\
+	ref_1 = bpf_task_from_pid(current->pid);	\
+	if (!ref_1)					\
+		return 0;				\
+							\
+	ref_2 = bpf_task_acquire(ref_1);		\
+	if (ref_2)					\
+		bpf_task_release(ref_2);		\
+	bpf_task_release(ref_1);			\
+							\
+	return 0;					\
+}
+
 static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
 {
 	s32 pid;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index ad88a3796ddf..57ec25463d80 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -324,3 +324,7 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flag
 
 	return 0;
 }
+
+SEC("raw_tp")
+__failure __msg("calling kernel function")
+TASK_KFUNC_LOAD_TEST(raw_tp)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 70df695312dc..203ff461a92c 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_misc.h"
 #include "task_kfunc_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -314,3 +315,6 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 
 	return 0;
 }
+
+SEC("syscall") __success
+TASK_KFUNC_LOAD_TEST(syscall)
-- 
2.44.0


