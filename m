Return-Path: <linux-kernel+bounces-136136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450A89D063
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55521F24F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D455E6C;
	Tue,  9 Apr 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtHKB4cu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815454BEF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629946; cv=none; b=LQHv3QHJHlz3pEmUPLNgfR0YusuU72HaDTi9iALFcN85F30XcqnKrMqTw5b6ijoBXF41ZzmM6dAaZyRsfxgCt5D6A3DFfoIWGlHEBM8Mxhbz5NCPdzdkdPFjOSHLy31I+LdTaoJJ/6LyTTyIJhOlBp2S7C6ewwwYnF7ZKNoObmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629946; c=relaxed/simple;
	bh=g5FISTb0SUz4N5bO73qDIESdt6Zvkkf5ticX23tz8Bc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u0UgGpaBnTyPnSnmyno3c/35AvBsvpuM/1+jzFKQwFNbl5h9FYIdLWDvYk2plYqezpJNpD593zLCFF5WZo9SUCOg9dmp+C+JYGJoU+Yol7JaL5yV1n7TQsTnDtsmqs7rOXaYpy4N4eB8wqInsyKWyqmuLmvRqt61/DWvdAqkJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtHKB4cu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ff1816749so75605977b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629944; x=1713234744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUCLlDEOF+eDEIPKja8ueM/Rrqkxl5/XYQOKdkpQkzo=;
        b=rtHKB4cu7defFE4KGVpxM94EV2s7SxXiEi5eWRjTaKIJXmgdqcZI8c2QdnkZY586En
         62t4x2Y6ISckkcB1H77Jx/IcN6HQUMxNijUJWysA/fLdebJ/kTJxbYi/5fkLroiJ/UAt
         hqKjiCzJoC6kZ+QyrEAN28Ulv1RKlFUSZe4Xiq/OcvDOi9YHM5Y5EwdySOzQ1H6UfX7i
         nV7PDdH3Pn0lZ1i+19V4G60gbvQfgZZzpQOYuPv70MLKaYbT/gyjDoQ4gFtxf4tSLfUo
         RCdXcoIALCPq17t459Q41kCkS2MA2Z6e9QI2yB+ptre0ZhO1UvxCymnG+QUmQ0qYLu9J
         ZD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629944; x=1713234744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUCLlDEOF+eDEIPKja8ueM/Rrqkxl5/XYQOKdkpQkzo=;
        b=KAN3alZBpzdlG+XSASk1NAN2b1nm+gjfKEITq96i75IWxNk86crXIpgmivyeRR7Qpd
         Vqud2/fenMgxDmoAUhmPrYbKqOdlkqIrqd0yZyxMLyTRzj0sGAjcN3x7NK7PGqCF8FUj
         J8F+3FHZuX1Q/7Vdg7IdngC9cMveGIcCQTItM0aWKWN7PziptVk2pwZW2/hxUb6VHz3S
         hRqpRsoJFJCgON7+3vJbdH33/2JBO1weBn9hBIKsX1MgZ3VkcYGxhmoC03/dKZbx/IEY
         NF/xcIvt/bB6OArJAHHgwwIntfoNAtO0S61GKsTb7eRpe+63ICrohRNCgw/t371DdmUh
         UIOA==
X-Forwarded-Encrypted: i=1; AJvYcCUfQ1GXuoyO1OLEAM1PIJ75z+7Q115pSGyZ25i6+7aPkpvEL8qwObwIGX1FzzNvmxbWqvX0qZIReW/kIjTgWuMEzTVPtoS0ZjHQYh6D
X-Gm-Message-State: AOJu0Yylzvz3k1mnuED1r3TGc92rGc+qsEH1wzdaYqO9EKPkUd78F8W/
	eGHXUxB/cz482d/RybxVlgooT6f0/niwO4LnLzRDsSC5XYREOaPMU0vNFiMoR/jBbIAJMghjQNa
	FtM6R4A==
X-Google-Smtp-Source: AGHT+IGvQTYCP5+xDoLlENaNXCS0algoYiy4sK2dX6WUL4feZ6IfsnScgDm7nhrevc/FNjddvi6LrIbefbqr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a05:6902:727:b0:dcc:8927:7496 with SMTP id
 l7-20020a056902072700b00dcc89277496mr873262ybt.5.1712629944477; Mon, 08 Apr
 2024 19:32:24 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:14 -0700
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Message-Id: <20240409023216.2342032-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409023216.2342032-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 2/4] perf arch x86: Add shellcheck to build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shellcheck for:
tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
Address a minor quoting issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/Build                     | 14 ++++++++++++++
 tools/perf/arch/x86/tests/Build               | 14 ++++++++++++++
 tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index a7dd46a5b678..ed37013b4289 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -1,2 +1,16 @@
 perf-y += util/
 perf-y += tests/
+
+ifdef SHELLCHECK
+  SHELL_TESTS := entry/syscalls/syscalltbl.sh
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index b87f46e5feea..c1e3b7d39554 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -10,3 +10,17 @@ perf-$(CONFIG_AUXTRACE) += insn-x86.o
 endif
 perf-$(CONFIG_X86_64) += bp-modify.o
 perf-y += amd-ibs-via-core-pmu.o
+
+ifdef SHELLCHECK
+  SHELL_TESTS := gen-insn-x86-dat.sh
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
index 0d0a003a9c5e..89c46532cd5c 100755
--- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
+++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.sh
@@ -11,7 +11,7 @@ if [ "$(uname -m)" != "x86_64" ]; then
 	exit 1
 fi
 
-cd $(dirname $0)
+cd "$(dirname $0)"
 
 trap 'echo "Might need a more recent version of binutils"' EXIT
 
-- 
2.44.0.478.gd926399ef9-goog


