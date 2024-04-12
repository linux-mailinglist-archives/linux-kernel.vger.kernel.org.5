Return-Path: <linux-kernel+bounces-142456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9228A2BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E456B25C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC953802;
	Fri, 12 Apr 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0uhdpxk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4QxS1la"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E275336D;
	Fri, 12 Apr 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916207; cv=none; b=d/cM/jKIppQRHLKh2ux/+XEY9UwWg6dgfiBJZjMCOok5mM4Tl3PjMVvbIzodzc1W8K2O+CLoPqMrBwrX0O5zUKrdMOt4n7T6PG0S/4zrb2OSwFMj5EDKrRNDV5TntQ1ndP0PiGkiAxNuaNi76fam4Tt+hP7C3PnC71kc7UvArKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916207; c=relaxed/simple;
	bh=SlfQBg5abd0RMkCfAhFl4s4TiMmamNH6Bnlccos89Fg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bOYgh05Zyd0uKEgNJZpP098VepBhbUUrvyRJxRkoGa5vWzVOn1xwr2mPNXVb8bnr4akm9t848zFcqIFdLar+uqdFW42/hzfvrGJ8zAOvJ6EPYLt5aJwhJma953dim3G4VG/TzDpKAppRS69YYW6ROl55iFDxpxuIPzwc8RaGMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0uhdpxk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4QxS1la; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTxRri3cPrvqIKqZ2HXxhxrzVG8Ka6Tj9YlsT9lETdc=;
	b=a0uhdpxkratIBWCtH9vn9tEQq124xEqCq+rUbJZBJW9gjq3E/lH1+oNYP3bURvnjUohdeD
	SGSesJUmSaG5fWsjIBAb4fBVhOgCEyhHNWxtmJlK8KEjD16O9X7iTu73Onj4rZIQwW3ThA
	/DXSgc+ue/XbftJYF14EIGdiFlMBylQ6CYbmozh/sEEYDAbc827sbxNQZ0I/RdKqyxbzC7
	rj6iODdt3CQQCswEcmT0i0ndLLXF5/1m5eEf2zLsemb4kamNpnktJ+zAjz+X2Bhqh6Bhx8
	Q6QwfWA7qLfebCJHP23WbjBgIICI0+mOvmQIcc0vd4He4RD1+fFfP7VM2oCs2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTxRri3cPrvqIKqZ2HXxhxrzVG8Ka6Tj9YlsT9lETdc=;
	b=R4QxS1la8v5T40zZbwxT0oPwl0n6rxaCJ+z0iYJREMSPKJ3CwlMv3LAQ98JKeP/Nd/cxUJ
	X9NQULFn9SbiXnAw==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] selftest/bpf: Test a perf BPF program that
 suppresses side effects
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-8-khuey@kylehuey.com>
References: <20240412015019.7060-8-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620269.10875.2413660529610591477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a265c9f6d52ac760e6e572bac73a11b60b998779
Gitweb:        https://git.kernel.org/tip/a265c9f6d52ac760e6e572bac73a11b60b998779
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:19 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:51 +02:00

selftest/bpf: Test a perf BPF program that suppresses side effects

The test sets a hardware breakpoint and uses a BPF program to suppress the
side effects of a perf event sample, including I/O availability signals,
SIGTRAPs, and decrementing the event counter limit, if the IP matches the
expected value. Then the function with the breakpoint is executed multiple
times to test that all effects behave as expected.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-8-khuey@kylehuey.com
---
 tools/testing/selftests/bpf/prog_tests/perf_skip.c | 137 ++++++++++++-
 tools/testing/selftests/bpf/progs/test_perf_skip.c |  15 +-
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
new file mode 100644
index 0000000..37d8618
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <test_progs.h>
+#include "test_perf_skip.skel.h"
+#include <linux/compiler.h>
+#include <linux/hw_breakpoint.h>
+#include <sys/mman.h>
+
+#ifndef TRAP_PERF
+#define TRAP_PERF 6
+#endif
+
+int sigio_count, sigtrap_count;
+
+static void handle_sigio(int sig __always_unused)
+{
+	++sigio_count;
+}
+
+static void handle_sigtrap(int signum __always_unused,
+			   siginfo_t *info,
+			   void *ucontext __always_unused)
+{
+	ASSERT_EQ(info->si_code, TRAP_PERF, "si_code");
+	++sigtrap_count;
+}
+
+static noinline int test_function(void)
+{
+	asm volatile ("");
+	return 0;
+}
+
+void serial_test_perf_skip(void)
+{
+	struct sigaction action = {};
+	struct sigaction previous_sigtrap;
+	sighandler_t previous_sigio = SIG_ERR;
+	struct test_perf_skip *skel = NULL;
+	struct perf_event_attr attr = {};
+	int perf_fd = -1;
+	int err;
+	struct f_owner_ex owner;
+	struct bpf_link *prog_link = NULL;
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = handle_sigtrap;
+	sigemptyset(&action.sa_mask);
+	if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), "sigaction"))
+		return;
+
+	previous_sigio = signal(SIGIO, handle_sigio);
+	if (!ASSERT_NEQ(previous_sigio, SIG_ERR, "signal"))
+		goto cleanup;
+
+	skel = test_perf_skip__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	attr.type = PERF_TYPE_BREAKPOINT;
+	attr.size = sizeof(attr);
+	attr.bp_type = HW_BREAKPOINT_X;
+	attr.bp_addr = (uintptr_t)test_function;
+	attr.bp_len = sizeof(long);
+	attr.sample_period = 1;
+	attr.sample_type = PERF_SAMPLE_IP;
+	attr.pinned = 1;
+	attr.exclude_kernel = 1;
+	attr.exclude_hv = 1;
+	attr.precise_ip = 3;
+	attr.sigtrap = 1;
+	attr.remove_on_exec = 1;
+
+	perf_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (perf_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
+		printf("SKIP:no PERF_TYPE_BREAKPOINT/HW_BREAKPOINT_X\n");
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(perf_fd < 0, "perf_event_open"))
+		goto cleanup;
+
+	/* Configure the perf event to signal on sample. */
+	err = fcntl(perf_fd, F_SETFL, O_ASYNC);
+	if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
+		goto cleanup;
+
+	owner.type = F_OWNER_TID;
+	owner.pid = syscall(__NR_gettid);
+	err = fcntl(perf_fd, F_SETOWN_EX, &owner);
+	if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
+		goto cleanup;
+
+	/* Allow at most one sample. A sample rejected by bpf should
+	 * not count against this.
+	 */
+	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
+		goto cleanup;
+
+	prog_link = bpf_program__attach_perf_event(skel->progs.handler, perf_fd);
+	if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event"))
+		goto cleanup;
+
+	/* Configure the bpf program to suppress the sample. */
+	skel->bss->ip = (uintptr_t)test_function;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 0, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
+
+	/* Configure the bpf program to allow the sample. */
+	skel->bss->ip = 0;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+	/* Test that the sample above is the only one allowed (by perf, not
+	 * by bpf)
+	 */
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+cleanup:
+	bpf_link__destroy(prog_link);
+	if (perf_fd >= 0)
+		close(perf_fd);
+	test_perf_skip__destroy(skel);
+
+	if (previous_sigio != SIG_ERR)
+		signal(SIGIO, previous_sigio);
+	sigaction(SIGTRAP, &previous_sigtrap, NULL);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/testing/selftests/bpf/progs/test_perf_skip.c
new file mode 100644
index 0000000..7eb8b6d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+uintptr_t ip;
+
+SEC("perf_event")
+int handler(struct bpf_perf_event_data *data)
+{
+	/* Skip events that have the correct ip. */
+	return ip != PT_REGS_IP(&data->regs);
+}
+
+char _license[] SEC("license") = "GPL";

