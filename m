Return-Path: <linux-kernel+bounces-152318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E28ABC4A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB531F2141A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF839AF1;
	Sat, 20 Apr 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SH9g2KgJ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF062942C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628762; cv=none; b=shw7i6QMg1mVgdnQPXix25lD0hd1WWG71rVI/u3w7KUmud1xMOWp8mteJxgmjidinObtiS5f3TTa26hVYXquyIHkF/BcUVtdYZn+JTa/Gg1UcLGrvRG6Ka9GcWqx6ZRCGokg2c1mCjbi64BxJ3hgbm69rQsaizMrrB6+WEJM31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628762; c=relaxed/simple;
	bh=nNRohb4TCqxwIK1Y/PiM1fnTGVi7tniX1l39w0EWGdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQcJPwo/noWw/NVRPw+cqquVh+KFQrhR2ZTfPDBSOzupHb9G8Euyg+fymQ/r3GI3Qy6WgaB8YMcN2bOkKOXekmzEOC1pcxE6UbEEoAG6pqS4itHABBu5CF1X06gwoQuehpvN5PaM1WIWDFTZaAf1f2dTO8EL6dbYo29Un3HarK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SH9g2KgJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 133423FB72
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713628756;
	bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=SH9g2KgJiyUDSWcIBeId96ayRFyrakyYYtXcU9TQFyDFJK64B9nHVU6QTS3bPEeWs
	 NTwv1B/izOImAXXKrMvT2StC9ILyi/+VZsah5Xrfk9l5YIw30ZhVLXnICZ+3pMi3Yi
	 AFRhnpQywR0VV/YjekCy1oq4yGa5CqK4Zr8AoOC0UeDfDddUzB1wDqQnum63ZBxZT0
	 aOyPVWtmIjmU6nvLjozieRilX4whjgs0dkCPhNorNfxYwjqTLDgUYljgbdZEZkMjuM
	 4d2SqMKMArUMQWcKb+jDcaWBg7lxfSd34e2RUyYwZvnOsrEsSZAdJslSywOO+Tj5jB
	 ubRVlU53w6WsA==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417de456340so17746755e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713628755; x=1714233555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
        b=IHb98NAH9KEbEcLNn9YuKVtJ+zCYh+BGEM+bkBjq0uAJBHIDAzbMije7YE9yEhogk4
         zoHYPMIcvr39WCza/K/KEM7ry0hiLikYK3j8peyHOPILcjXJXu/GnazT8VCW/NlwR057
         A4qaVWFTbeEvOrO4xQK+86M0/hgfG5g7BPvCpputwfHetoeZKsbSd1dz/g6SDibk+oaL
         ax0buwtzMhoYMomXgwHYOSCXcpUjNvDKJbCpCXJMICW3N5mB90UhuVBar1HcEFnOEUJ+
         BTtSu343mLFxrc0ZrGJ4f/7EhJteeI9Ywh6fNvFUdUxJXXLa5f5DAZhte3cVOKm73vWQ
         8Heg==
X-Forwarded-Encrypted: i=1; AJvYcCXbnKyg8ivT1JL8vjRNw3Ac4hEUm5W/4kf+1KCF4HRh8CSuaiEwKPT3KqisuhjnYEItL+UASDJU8QZO/jx3kHqGCfkDNHZMvksqQp+D
X-Gm-Message-State: AOJu0Yw7HeZwuXhpSfUoNaVV+b6q4EtMJKMZY6GxCtKQtkqj5ULpe/gd
	+v8pQ9X/7W5vKAsyllIBekjtVO0mieimRKJmddnpDVt5O+ZvanDaNR2+Z1OnEgJlMeZFG8ivw67
	xr0hGllBco4/cQSRv5LqhPUmSrbhyUryZJ9x6yB3oho/0rvKP1vMagA7sgWBfRrgq9C0uHDDtjz
	3TIw==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064595wmr.12.1713628755022;
        Sat, 20 Apr 2024 08:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1yNyzlrb+9WaiK0MZQfB1d9PfHUIaT+JsnQy9N4roDXlEI01EQiBXdSmC1jsqyYTOTc6dQ==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064560wmr.12.1713628754198;
        Sat, 20 Apr 2024 08:59:14 -0700 (PDT)
Received: from gpd.. ([151.57.165.71])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d6950000000b003477d26736dsm7154350wrw.94.2024.04.20.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 08:59:13 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Date: Sat, 20 Apr 2024 17:59:04 +0200
Message-ID: <20240420155904.1450768-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testcase for the ring_buffer__consume_n() API.

The test produces multiple samples in a ring buffer, using a
sys_getpid() fentry prog, and consumes them from user-space in batches,
rather than consuming all of them greedily, like ring_buffer__consume()
does.

Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 52 +++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..6332277edeca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -455,7 +455,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_map_key.c
+	test_ringbuf_n.c test_ringbuf_map_key.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..7e085bfce9b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 
 #define EDONE 7777
@@ -60,6 +61,7 @@ static int process_sample(void *ctx, void *data, size_t len)
 }
 
 static struct test_ringbuf_map_key_lskel *skel_map_key;
+static struct test_ringbuf_n_lskel *skel_n;
 static struct test_ringbuf_lskel *skel;
 static struct ring_buffer *ringbuf;
 
@@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
 	test_ringbuf_lskel__destroy(skel);
 }
 
+/*
+ * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
+ * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
+ */
+#define N_TOT_SAMPLES	32
+#define N_SAMPLES	4
+
+/* Sample value to verify the callback validity */
+#define SAMPLE_VALUE	42L
+
+static int process_n_sample(void *ctx, void *data, size_t len)
+{
+	struct sample *s = data;
+
+	CHECK(s->value != SAMPLE_VALUE,
+	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
+
+	return 0;
+}
+
+static void ringbuf_n_subtest(void)
+{
+	int err, i;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_n_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
+	skel->bss->value = SAMPLE_VALUE;
+	for (i = 0; i < N_TOT_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
+	for (i = 0; i < N_TOT_SAMPLES; i += err) {
+		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
+		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
+	}
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
 	struct sample *s;
@@ -384,6 +447,8 @@ void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
 		ringbuf_subtest();
+	if (test__start_subtest("ringbuf_n"))
+		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
new file mode 100644
index 000000000000..b98b5bb20699
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
+
+#include <linux/bpf.h>
+#include <sched.h>
+#include <unistd.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_COMM_LEN 16
+
+struct sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int pid = 0;
+long value = 0;
+
+/* inner state */
+long seq = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_n(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->pid = pid;
+	sample->seq = seq++;
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


