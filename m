Return-Path: <linux-kernel+bounces-94545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60227874133
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6326B226C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DD146E65;
	Wed,  6 Mar 2024 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhXiVV2s"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37E143C59;
	Wed,  6 Mar 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755554; cv=none; b=S0I6i7lS1I0widx9IAxHnIqsz0f9zedp6MKSjPxPOw0fJN6MBG//JzZy3BLY8ZyyX+JmWspmyLzWk/cQEpY0ZsF4ZRfnrZGM1o4unfdmuPABJhrMA79uPKyYcZqzICxK4R2Q8x0DkkzEu4NX3HDFnAVSKthbmWQA2twqP+qKJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755554; c=relaxed/simple;
	bh=o8Z06UqQHpQij/QFSA0wOi1qE/jLPCTw6JsXGHcNP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLagmbpfw0QHQjpA5td25dbytbAM12mCCboqh9DxdnZ19WsIyaMUEskHAJLSTWCMOB/G9s8n484eYKu0vJ0YELFJi4jVoz46TtBh7hseXnwNCSqy96cjd+ciOoyzZhdF0dMJU/gf4Eo6/BRBWXofyXdNu1ny/QU7p6M6RDeD4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhXiVV2s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so1153755ad.2;
        Wed, 06 Mar 2024 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709755551; x=1710360351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX8YkIaogeZn2Ru8WOvguzpBluPt3gWrmRThD9l197w=;
        b=HhXiVV2sp77qhEnPj/wJBy0i29PpXH+F/uUFfAOGgr5zi6S4ded093Ev/4g+VN1NZl
         W3wiEQKjsR2sciYKr15P77h2QEd9LXkwAGiVlLTNwhp7dnZRVYJ7zH7tP4f9mdxgpjGY
         9n/Ck+ULjhZzepe2v+GO06wH74trJCgXCyKQIq41Ad9lAP+LbS/2yiwDHKmaU5rVeloZ
         ZkcVaSeY1/2suzhW3BvthmZL7p4gQGwMDNPv9MuHPDDmF428lF0WpMm9jhirKxLkUqoq
         /hqJZs1hHHPYvkaBn91n4myA6Ql/dVftLAyNpwnMHqtj5CZnvfSuo9PGn8xnsOQes5DL
         Wj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755551; x=1710360351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX8YkIaogeZn2Ru8WOvguzpBluPt3gWrmRThD9l197w=;
        b=EW4XIYuKuNYW7gpgBi8dh/1bxWKuBVrab53DBrIe+X54baQHQS4rAdhKrrN4GqAfVE
         WvdFEIYDWNSJ+snUJY5AsfTDvQcc9sR6+FupJLc+oE7kzFQ7LYkjZ9IbJmyLPDc/H77u
         /SRDJcoAvipvMcJp6GxKu5kasZ4tn2Y1ZDUbQH2oTM0Kjk0LRv2ETYfPKdsoUW/cSK4T
         DusxJCgGay7yETQufFK6P19EDvHhdypNGlix1sJfHY8u6Lp/KjBDRqr+TvQAMeFzks7s
         r7N8L/lkkmldp7zv6ViEy/HpRmjq5jrC01Gp0xqY6GwOzocdGhi+c3SHqDAcTKhs6+A6
         Rd2A==
X-Forwarded-Encrypted: i=1; AJvYcCXXqqNX8NlV1eFd/NWsvOj02pywkr91Rj9xpIKmi5lcxMa2/+JJHdGc8RkDZ3O/0a5BpN4Ds46mjJdBfiMo66cvw8t+xd7uZhUPKn+24STFU5/bYqqlS9Ni46AX+uZU5gs8FaBAv7iyWVlKad1B/3PjhksjT2X57sdDG7ijjrbrXQ==
X-Gm-Message-State: AOJu0YyolmykII+63L4FxjMoKVc1/f/vSr30EU3+FcVZvZFRyZkWDv/p
	zgEB7IaHHFFw50YsObvJua53jVDBleHzDlL//O+H6uhpYmiv3D++
X-Google-Smtp-Source: AGHT+IFcyEHFqWXhZBDtPi0MIYs8Ofqj90k6hm7PQVd4a7TPst+AD3T0SxCfQSfslpMC8GlPYNmpPg==
X-Received: by 2002:a17:902:e74b:b0:1da:22d9:e7fd with SMTP id p11-20020a170902e74b00b001da22d9e7fdmr7091836plf.20.1709755551114;
        Wed, 06 Mar 2024 12:05:51 -0800 (PST)
Received: from mozart.vkv.me ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001dcfc88ccf6sm8869341plf.263.2024.03.06.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:05:50 -0800 (PST)
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/4] selftests/bpf: Support testing the !MODULES case
Date: Wed,  6 Mar 2024 12:05:11 -0800
Message-ID: <0efc2579470afafc8c6ea14ee6f4530dc27a6d65.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709676663.git.jcalvinowens@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symlinks bpf_testmod into the main source, so it can be built-in
for running selftests in the new !MODULES case.

To be clear, no changes to the existing selftests are required: this
only exists to enable testing the new case which was not previously
possible. I'm sure somebody will be able to suggest a less ugly way I
can do this...

Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
---
 include/trace/events/bpf_testmod.h            |  1 +
 kernel/bpf/Kconfig                            |  9 ++++++
 kernel/bpf/Makefile                           |  2 ++
 kernel/bpf/bpf_testmod/Makefile               |  1 +
 kernel/bpf/bpf_testmod/bpf_testmod.c          |  1 +
 kernel/bpf/bpf_testmod/bpf_testmod.h          |  1 +
 kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h    |  1 +
 net/bpf/test_run.c                            |  2 ++
 tools/testing/selftests/bpf/Makefile          | 28 +++++++++++++------
 .../selftests/bpf/bpf_testmod/Makefile        |  2 +-
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  6 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  4 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  2 ++
 tools/testing/selftests/bpf/config            |  5 ----
 tools/testing/selftests/bpf/config.mods       |  5 ++++
 tools/testing/selftests/bpf/config.nomods     |  1 +
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  2 ++
 .../selftests/bpf/progs/btf_type_tag_user.c   |  2 ++
 tools/testing/selftests/bpf/progs/core_kern.c |  2 ++
 .../selftests/bpf/progs/iters_testmod_seq.c   |  2 ++
 .../bpf/progs/test_core_reloc_module.c        |  2 ++
 .../selftests/bpf/progs/test_ldsx_insn.c      |  2 ++
 .../selftests/bpf/progs/test_module_attach.c  |  3 ++
 .../selftests/bpf/progs/tracing_struct.c      |  2 ++
 tools/testing/selftests/bpf/testing_helpers.c | 14 ++++++++++
 tools/testing/selftests/bpf/vmtest.sh         | 24 ++++++++++++++--
 26 files changed, 110 insertions(+), 16 deletions(-)
 create mode 120000 include/trace/events/bpf_testmod.h
 create mode 100644 kernel/bpf/bpf_testmod/Makefile
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.c
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.h
 create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h
 create mode 100644 tools/testing/selftests/bpf/config.mods
 create mode 100644 tools/testing/selftests/bpf/config.nomods

diff --git a/include/trace/events/bpf_testmod.h b/include/trace/events/bpf_testmod.h
new file mode 120000
index 000000000000..ae237a90d381
--- /dev/null
+++ b/include/trace/events/bpf_testmod.h
@@ -0,0 +1 @@
+../../../tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
\ No newline at end of file
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 77df483a8925..d5ba795182e5 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -100,4 +100,13 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_TEST_MODULE
+	bool "Build the module for BPF selftests as a built-in"
+	depends on BPF_SYSCALL
+	depends on BPF_JIT
+	depends on !MODULES
+	default n
+	help
+	  This allows most of the bpf selftests to run without modules.
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..04b3e50ff940 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -46,3 +46,5 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_TEST_MODULE) += bpf_testmod/
diff --git a/kernel/bpf/bpf_testmod/Makefile b/kernel/bpf/bpf_testmod/Makefile
new file mode 100644
index 000000000000..55a73fd8443e
--- /dev/null
+++ b/kernel/bpf/bpf_testmod/Makefile
@@ -0,0 +1 @@
+obj-y += bpf_testmod.o
diff --git a/kernel/bpf/bpf_testmod/bpf_testmod.c b/kernel/bpf/bpf_testmod/bpf_testmod.c
new file mode 120000
index 000000000000..ca3baca5d9c4
--- /dev/null
+++ b/kernel/bpf/bpf_testmod/bpf_testmod.c
@@ -0,0 +1 @@
+../../../tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
\ No newline at end of file
diff --git a/kernel/bpf/bpf_testmod/bpf_testmod.h b/kernel/bpf/bpf_testmod/bpf_testmod.h
new file mode 120000
index 000000000000..f8d3df98b6a5
--- /dev/null
+++ b/kernel/bpf/bpf_testmod/bpf_testmod.h
@@ -0,0 +1 @@
+../../../tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
\ No newline at end of file
diff --git a/kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h b/kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h
new file mode 120000
index 000000000000..fdf42f5eaeb0
--- /dev/null
+++ b/kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -0,0 +1 @@
+../../../tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
\ No newline at end of file
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..33029c91bf92 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -573,10 +573,12 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
 	return a + *b + c + d + (long)e + f + g;
 }
 
+#if !IS_ENABLED(CONFIG_BPF_TEST_MODULE)
 int noinline bpf_fentry_shadow_test(int a)
 {
 	return a + 1;
 }
+#endif
 
 struct prog_test_member1 {
 	int a;
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..12da018c9fc3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -108,9 +108,16 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
-	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features
+	test_lirc_mode2_user xdping test_cpp runqslower bench xskxceiver \
+	xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata xdp_features
+
+RUN_TESTS_WITHOUT_MODULES ?= 0
+TRUNNER_EXTRA_CFLAGS ?=
+
+ifeq ($(RUN_TESTS_WITHOUT_MODULES),0)
+TEST_GEN_PROGS_EXTENDED += bpf_testmod.ko
+TRUNNER_EXTRA_CFLAGS += -DBPF_TESTMOD_EXTERNAL
+endif
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -400,22 +407,22 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $3 - CFLAGS
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 $(TRUNNER_EXTRA_CFLAGS) -O2 --target=bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 $(TRUNNER_EXTRA_CFLAGS) -O2 --target=bpf -c $1 -mcpu=v2 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
+	$(Q)$(CLANG) $3 $(TRUNNER_EXTRA_CFLAGS) -O2 --target=bpf -c $1 -mcpu=v4 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 $(TRUNNER_EXTRA_CFLAGS) -O2 -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -605,7 +612,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 json_writer.c 		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -614,6 +621,11 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
 		       $(wildcard progs/*.bpf.o)
+
+ifeq ($(RUN_TESTS_WITHOUT_MODULES),0)
+TRUNNER_EXTRA_FILES += $(OUTPUT)/bpf_testmod.ko
+endif
+
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
diff --git a/tools/testing/selftests/bpf/bpf_testmod/Makefile b/tools/testing/selftests/bpf/bpf_testmod/Makefile
index 15cb36c4483a..123f161339e4 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
+++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
@@ -10,7 +10,7 @@ endif
 MODULES = bpf_testmod.ko
 
 obj-m += bpf_testmod.o
-CFLAGS_bpf_testmod.o = -I$(src)
+CFLAGS_bpf_testmod.o = -I$(src) -DBPF_TESTMOD_EXTERNAL
 
 all:
 	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 11ee801e75e7..57a9795d814a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2020 Facebook */
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM bpf_testmod
 
@@ -7,7 +8,10 @@
 #define _BPF_TESTMOD_EVENTS_H
 
 #include <linux/tracepoint.h>
+
+#ifdef BPF_TESTMOD_EXTERNAL
 #include "bpf_testmod.h"
+#endif
 
 TRACE_EVENT(bpf_testmod_test_read,
 	TP_PROTO(struct task_struct *task, struct bpf_testmod_test_read_ctx *ctx),
@@ -51,7 +55,9 @@ BPF_TESTMOD_DECLARE_TRACE(bpf_testmod_test_writable_bare,
 
 #endif /* _BPF_TESTMOD_EVENTS_H */
 
+#ifdef BPF_TESTMOD_EXTERNAL
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE bpf_testmod-events
+#endif
 #include <trace/define_trace.h>
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..78769fe1c66b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -12,7 +12,11 @@
 #include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
+#ifdef BPF_TESTMOD_EXTERNAL
 #include "bpf_testmod-events.h"
+#else
+#include "trace/events/bpf_testmod.h"
+#endif
 
 typedef int (*func_proto_typedef)(long);
 typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 7c664dd61059..fe4a67cf04cb 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -26,6 +26,7 @@ struct prog_test_ref_kfunc {
 };
 #endif
 
+#if defined(BPF_TESTMOD_EXTERNAL) || defined(__KERNEL__)
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -63,6 +64,7 @@ struct prog_test_fail3 {
 	char arr1[2];
 	char arr2[];
 };
+#endif
 
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c125c441abc7..b26e79e42fb7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -44,11 +44,6 @@ CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
-CONFIG_MODULE_SIG=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULES=y
-CONFIG_MODVERSIONS=y
 CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
diff --git a/tools/testing/selftests/bpf/config.mods b/tools/testing/selftests/bpf/config.mods
new file mode 100644
index 000000000000..7fc4edb66b35
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.mods
@@ -0,0 +1,5 @@
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
diff --git a/tools/testing/selftests/bpf/config.nomods b/tools/testing/selftests/bpf/config.nomods
new file mode 100644
index 000000000000..aea6afdc0a0b
--- /dev/null
+++ b/tools/testing/selftests/bpf/config.nomods
@@ -0,0 +1 @@
+CONFIG_BPF_TEST_MODULE=y
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 38f78d9345de..b3b52934dd37 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -11,6 +12,7 @@ struct bpf_testmod_btf_type_tag_1 {
 struct bpf_testmod_btf_type_tag_2 {
 	struct bpf_testmod_btf_type_tag_1 *p;
 };
+#endif
 
 __u64 g;
 
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
index 5523f77c5a44..a41cf28ef437 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -11,6 +12,7 @@ struct bpf_testmod_btf_type_tag_1 {
 struct bpf_testmod_btf_type_tag_2 {
 	struct bpf_testmod_btf_type_tag_1 *p;
 };
+#endif
 
 int g;
 
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
index 004f2acef2eb..82deb60ef672 100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -67,9 +67,11 @@ struct __sk_bUfF /* it will not exist in vmlinux */ {
 	int len;
 } __attribute__((preserve_access_index));
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_test_read_ctx /* it exists in bpf_testmod */ {
 	size_t len;
 } __attribute__((preserve_access_index));
+#endif
 
 SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index 3873fb6c292a..39658b05ac1e 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -5,10 +5,12 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_iter_testmod_seq {
 	u64 :64;
 	u64 :64;
 };
+#endif
 
 extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt) __ksym;
 extern s64 *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_module.c b/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
index bcb31ff92dcc..77b2dae54dd5 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
@@ -8,12 +8,14 @@
 
 char _license[] SEC("license") = "GPL";
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_test_read_ctx {
 	/* field order is mixed up */
 	size_t len;
 	char *buf;
 	loff_t off;
 } __attribute__((preserve_access_index));
+#endif
 
 struct {
 	char in[256];
diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
index 2a2a942737d7..f1d7276c6629 100644
--- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -48,9 +48,11 @@ int map_val_prog(const void *ctx)
 
 }
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_struct_arg_1 {
 	int a;
 };
+#endif
 
 long long int_member;
 
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 8a1b50f3a002..772cff1190b1 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -5,7 +5,10 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+
+#ifdef BPF_TESTMOD_EXTERNAL
 #include "../bpf_testmod/bpf_testmod.h"
+#endif
 
 __u32 raw_tp_read_sz = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index 515daef3c84b..3b5c69858feb 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#ifdef BPF_TESTMOD_EXTERNAL
 struct bpf_testmod_struct_arg_1 {
 	int a;
 };
@@ -22,6 +23,7 @@ struct bpf_testmod_struct_arg_4 {
 	u64 a;
 	int b;
 };
+#endif
 
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d2458c1b1671..331be87d74d5 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -342,6 +342,12 @@ int unload_bpf_testmod(bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
+
+	if (access("/proc/modules", F_OK)) {
+		fprintf(stdout, "Modules are disabled, fake unload success\n");
+		return 0;
+	}
+
 	if (delete_module("bpf_testmod", 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
@@ -363,6 +369,14 @@ int load_bpf_testmod(bool verbose)
 	if (verbose)
 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
 
+	if (access("/proc/modules", F_OK)) {
+		if (!access("/sys/kernel/debug/tracing/events/bpf_testmod", F_OK))
+			return 0;
+
+		fprintf(stdout, "Modules are disabled, testmod not built-in\n");
+		return -ENOENT;
+	}
+
 	fd = open("bpf_testmod.ko", O_RDONLY);
 	if (fd < 0) {
 		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 65d14f3bbe30..27e0b1241b16 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -44,11 +44,12 @@ NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
+MODULES="yes"
 
 usage()
 {
 	cat <<EOF
-Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
+Usage: $0 [-i] [-s] [-n] [-d <output_dir>] -- [<command>]
 
 <command> is the command you would normally run when you are in
 tools/testing/selftests/bpf. e.g:
@@ -76,6 +77,7 @@ Options:
 	-s)		Instead of powering off the VM, start an interactive
 			shell. If <command> is specified, the shell runs after
 			the command finishes executing
+	-n)		Run tests with CONFIG_MODULES=n
 EOF
 }
 
@@ -341,7 +343,7 @@ main()
 	local exit_command="poweroff -f"
 	local debug_shell="no"
 
-	while getopts ':hskid:j:' opt; do
+	while getopts ':hskid:j:n' opt; do
 		case ${opt} in
 		i)
 			update_image="yes"
@@ -357,6 +359,9 @@ main()
 			debug_shell="yes"
 			exit_command="bash"
 			;;
+		n)
+			MODULES="no"
+			;;
 		h)
 			usage
 			exit 0
@@ -409,12 +414,27 @@ main()
 
 	echo "Output directory: ${OUTPUT_DIR}"
 
+	if [[ "${MODULES}" == "yes" ]]; then
+		KCONFIG_REL_PATHS+=("tools/testing/selftests/bpf/config.mods")
+	else
+		make_command="${make_command} RUN_TESTS_WITHOUT_MODULES=1"
+		KCONFIG_REL_PATHS+=("tools/testing/selftests/bpf/config.nomods")
+	fi
+
 	mkdir -p "${OUTPUT_DIR}"
 	mkdir -p "${mount_dir}"
 	update_kconfig "${kernel_checkout}" "${kconfig_file}"
 
 	recompile_kernel "${kernel_checkout}" "${make_command}"
 
+	# Touch the opposite mods/nomods config we used to ensure the
+	# kernel is rebuilt when the user adds or drops the -n flag.
+	if [[ "${MODULES}" == "yes" ]]; then
+		touch -m "tools/testing/selftests/bpf/config.nomods"
+	else
+		touch -m "tools/testing/selftests/bpf/config.mods"
+	fi
+
 	if [[ "${update_image}" == "no" && ! -f "${rootfs_img}" ]]; then
 		echo "rootfs image not found in ${rootfs_img}"
 		update_image="yes"
-- 
2.43.0


