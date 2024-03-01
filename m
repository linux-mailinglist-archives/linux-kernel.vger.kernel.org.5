Return-Path: <linux-kernel+bounces-88023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0286DC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F111F21B64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113FE69D29;
	Fri,  1 Mar 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FlNYgO2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC469970
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279226; cv=none; b=BRS66o2/xwg3OVrSx6KD8/kBjrQIMb8Ud97tWuR+liV+BLjQpFCblofKx9qMv3bCwtFivcnNJEk/7Ehm/yeThtnILDMZ9h0gGHBActmXPsKWr9SF3zWikm3+qVPGXOZeBFKCNYFnlPJL1Bj/0ktv6XxfY0/Glz0qkLDlkh+9i0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279226; c=relaxed/simple;
	bh=VOm7IPIBVo5PZ4RqJQ+la336Qu+bZ3B28KGc7lbQY1c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k6E+JbUBzTNXwWfANvzhKQoscXMyFAsjY60rPkW11hzbWxsaRAChEMHcXJnWMr+nL3N2qRmcxR7wI2Rh75UInpZNxuYqO5rs819hXUDdadrs6GicLVjHAxJZP8/BGt4e88Ec2J2UJ+fWhctWjxdq2ELVa8Zv+cBBK+tD24NuDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FlNYgO2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso38366467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279224; x=1709884024; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hog9+5whTjGin5G0M4AR3EFSxPaJm96RaOiuDoEPKc=;
        b=0FlNYgO2kqOhGSyfpAQQBJL1dd7rKBTXhz3pINcsFfaMqmJcqnTG38B6jaOJlZXlQY
         WlsuBT/nNTGPGC//5tqc4rpTUVLgYs4rpPPNsIzpypx8lnlebYPINeUbAMKDXKQ29chz
         LmHhrF1YPf+sJ4JZiSSvs1CnCaeR+eszxK/wEI/buDluavltGj5Zp0Ht9VOag+wmoP5l
         VDoLtK/uit8Qwl7HUGHYZa0xIVsnJ23fCW6CxulTSv6DVMQdI+l5fAmJTaQz5xPSYsXV
         NstLWqmsKtuX1zhq9l/EYAI9DC1uZmnzCfFvv/fUdPRFx4qfsdp+2pFqqs9yh4+jcOSO
         oIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279224; x=1709884024;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hog9+5whTjGin5G0M4AR3EFSxPaJm96RaOiuDoEPKc=;
        b=jxpYR512aQ9Ry06nij2TG7O7f9Vx+KFnYcphBe8WDw0kYv3HpXtsOcEYnmMBaL9fmV
         zEXOmxZfOp8e8b9qQTh7AGiiHD2jUHJEXWZdC3UkJYo+8cmFi9h/zpy31y7fav5y6oH8
         slbTzH446S7/2X6QiyhblVUSgli9GcPGv+X0ICkYG5QMrnYztdhOa8FoAUTRH/Al9dCk
         9RhVhE/UBS/xrWt9DLXc+CP4/6LUqaWA4/8kfWSaDoD72PENeetzaFEHRL38DICN/ngr
         LHP+4lwvjJ6GjF9ziQBHlUPDbrvGwiwk67FAhPLw/cOz7/f1vvUc9JWL+1VK0oYV5AuE
         kq+g==
X-Forwarded-Encrypted: i=1; AJvYcCUylwMOVbFJDHR9Lry3Y3jNauVWE5piRr5WrX9upD5UhOsVHOVnu05vA4oszmPcw/8QzzHr/eiBkJFEcOecCjjBAuWrO3ieU4XKhPZP
X-Gm-Message-State: AOJu0YxizHplgQCGm/QIl0UsnS4KRDWC7QWkG3yvZ4K5tgEdLXAw0GCg
	t+HO5WuIW19WQQlZcbQxNfMD2gXntQ0DtoSb4iQDAG555YBhssy1viIcXAlWIJene/SE9LytBpW
	cx9g3jg==
X-Google-Smtp-Source: AGHT+IHKnx/facVcMyKr/hM0f0jmf4jq5UVVg3iquQ7IDVrMzo2HlC4fnlqQ5hwy6KtgmHf4sM/6I4lkCclf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1249:b0:dc7:7655:46ce with SMTP
 id t9-20020a056902124900b00dc7765546cemr280153ybu.2.1709279223896; Thu, 29
 Feb 2024 23:47:03 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:37 -0800
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
Message-Id: <20240301074639.2260708-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 2/4] perf test: stat output per thread of just the parent process
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Per-thread mode requires either system-wide (-a), a pid (-p) or a tid
(-t). The stat output tests were using system-wide mode but this is
racy when threads are starting and exiting - something that happens a
lot when running the tests in parallel (perf test -p). Avoid the race
conditions by using pid mode with the pid of the parent process.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh  | 2 +-
 tools/perf/tests/shell/stat+json_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c81d6a9f7983..9a176ceae4a3 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -79,7 +79,7 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat --per-thread -a $2 true
+	perf stat --per-thread -p $$ $2 true
 	commachecker --per-thread
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2b9c6212dffc..6b630d33c328 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -105,7 +105,7 @@ check_per_thread()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -a -o "${stat_output}" true
+	perf stat -j --per-thread -p $$ -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
-- 
2.44.0.278.ge034bb2e1d-goog


