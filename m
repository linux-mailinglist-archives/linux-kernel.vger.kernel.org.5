Return-Path: <linux-kernel+bounces-111579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552B886E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9536B1F22BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E8482CF;
	Fri, 22 Mar 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaYwqF8K"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BE46521;
	Fri, 22 Mar 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116527; cv=none; b=RVpjBjN0SAn/KiI3HT2R1n0YQOu0DwM2WkTM0Trqp2RS8CreubhCJVeNnuco9dJdXOKJvrf7OG2twX+7FwKThfBoLtFMdyNQQTrKCjomFytn7STt7CBlUhTRRvJX9TOVfpsuipe854xPWHBnA9RYPnwc4iNuBj6/vY5id8tUrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116527; c=relaxed/simple;
	bh=Bwz5RcwiuCpAzYmrEv7NZcbjbycUeN5g3JVLZ8o/qaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rShtUbcnskV+7ph7mjcIEymayDFHhav0ljDyixpZb4/7uN69EwCpxygbo6GHBGGxVAnU/xSwilASX2gSBw948qa6uV0uLFihvrKMoLB0mEvGGyYRhRhMrcUTSizLpwVsbjRQNStmbbMQvN4Vz13pQt2ACKlBSSAMwYHPXqUxCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaYwqF8K; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789db18e169so162094885a.1;
        Fri, 22 Mar 2024 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116524; x=1711721324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X4/2Xm3PbRw8DKV5QisHNANeMPm8iTDsE53VCImsrM=;
        b=OaYwqF8KTB0Z29hICt3nuyrxhK9vj50H0te8sm0kb1x1EoGQDx+m9d5s3L7bmIguAk
         eMRE0rUgFVkMla3o1qBLCUSf3ZNafx45sf6QKCG+iaBcNSrPFQC1w4cuMuoSMJIJdkjv
         7pM0yhMMrdrO0xFPXKaDeGia0bxDYU1RBqqnMA+0gG+xL8PmUlJ+EfCm6bYkJZhARAUr
         MQMK4/LtZWuig9FXN13uibNu6ML891MeJQsgUMrh9NfPbqD6Ru5jt0evT2jF6PIkOud6
         RHYv/Sl0Snv/6xqpze41LhhHOKfIQEbZ9Hth21UXnA5zlK76IAkFlyvxd/Qpx868ilXh
         aXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116524; x=1711721324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X4/2Xm3PbRw8DKV5QisHNANeMPm8iTDsE53VCImsrM=;
        b=JIRptaMAGGsanFiSMy4utBBi//jdUQmlFJ3V0IbmPW1Dp+ysO3CVF5sIvj7boXgl0d
         lal0eBbD2DLCet5GxZOwCoCmkNgn2EXqayQH1FaEQrHWIcS0uUcUR/Y4OZysrhu/SLYB
         f5+kxl4AD5SmdBi4jzySOjHM9XNsrSjPEJoKqwQlqMuCRA8pv78KHpDILnhw/FzPMLUw
         9pT7hpXswa4v+hZx8KSKUeWM5df3+htK67nuxbdHjLhqhIt4KZSCc+9KuFoVCHsq0nxr
         3xREQMEmWAZ8B5RxMeh64atcMXm/HyRKQtvyZHaMzT4yyfCFVmHQlAgs3SpfhOCpnHK2
         0TXg==
X-Forwarded-Encrypted: i=1; AJvYcCWjM5xlAk0T8JIyR6Xo3SfGdPBuw7Ak1ONpjIH7FBvU38TMQSA9GxHiTvPV8cYGcL9PvyudGUVBt/7HhqYU7+fzeCxQ6+cNlJ0+bgkiqxzL8WQYYWXmvRY+EajR2SMo1eXzqVkuzJ/Ueu89GKL+esjQKZgzM2m26bWPkAHXbw==
X-Gm-Message-State: AOJu0YxjT5FBLL7ZyxfPJ7HDM8nOHZwr0Td6grzCUJeVODQdyZEcQaWW
	TB91rbQxqsJ6049+L+t+S8Vq0NxXG87Y9U78dJ/Z7tAFlWch+Nx1
X-Google-Smtp-Source: AGHT+IFCYvlYKOKP9CKwLzd8AxesuhdY5oIXXHnN1fgoahG82YiWCA22iRstrQb1bDoSG/c4e2wu2A==
X-Received: by 2002:a05:6214:4005:b0:690:d7dc:df9d with SMTP id kd5-20020a056214400500b00690d7dcdf9dmr2635918qvb.13.1711116524597;
        Fri, 22 Mar 2024 07:08:44 -0700 (PDT)
Received: from l1441l.thefacebook.com ([2620:10d:c091:600::1:b4ee])
        by smtp.gmail.com with ESMTPSA id kc22-20020a056214411600b0069124fff14esm1099508qvb.138.2024.03.22.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:08:44 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: ast@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Subject: [PATCH 2/3] selftests/bpf: Add selftests for bpf led programs
Date: Fri, 22 Mar 2024 10:08:15 -0400
Message-ID: <f3167326546a28cb9cfbf347cc98436bfced6210.1711113657.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for led trigger bpf programs. To run the tests use the
"test_progs -t ledtrig_bpf" helper.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/progs/ledtrig_bpf.c | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ledtrig_bpf.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 01f241ea2c67..17a027905dcd 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -42,6 +42,7 @@ CONFIG_IPV6_SEG6_BPF=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
+CONFIG_LEDS_TRIGGER_BPF=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
 CONFIG_MODULE_SIG=y
diff --git a/tools/testing/selftests/bpf/progs/ledtrig_bpf.c b/tools/testing/selftests/bpf/progs/ledtrig_bpf.c
new file mode 100644
index 000000000000..8bf1044e6896
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ledtrig_bpf.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+
+extern void bpf_ledtrig_blink(unsigned long delay_on, unsigned long delay_off,
+		int invert) __weak __ksym;
+
+
+SEC("perf_event")
+int perf_blink(void)
+{
+	bpf_ledtrig_blink(30, 30, 0);
+	return 0;
+}
+
+
+SEC("syscall")
+int fork_blink(void)
+{
+	bpf_ledtrig_blink(30, 30, 0);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


