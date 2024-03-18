Return-Path: <linux-kernel+bounces-106102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51487E929
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB68B1C21224
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D51381AC;
	Mon, 18 Mar 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PasgsoSL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236F38382;
	Mon, 18 Mar 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763933; cv=none; b=JKWpCfNCTElfzzEOZYFiljsAjrfEwdpAHuqnpPE+GuQewcJEGDfS94N4uC+oKkacaqOufQqyipJ2OI8rrX9IGUguODEQXc5y1KzhBMWM2LaYwHmbunLWABwNTlf9oh21XA9dKAhdjtQLZsE7bRvBvhy6g8S5yw92vgb4W+ToiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763933; c=relaxed/simple;
	bh=qyMSm9yuXlCK1ICWk15XRGC74xl9VS7mkrc7PJHxCUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnPyILkASjhvChX+qt6KaxnEdvm4dGePYZ5Xs1GhdCRvyTVleVrjJHGfro24bmD/PGwK+JBbgKa3P2uCqMyhsymaabiNb6oNh1PDLjLcxOFdJ1xIgRyDkk7kUwMp9rlI/X/8PGnD8Ru2PF5v2lrumG2YxxfL6GBMr/40NfWKiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PasgsoSL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e00b1c2684so9617695ad.0;
        Mon, 18 Mar 2024 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710763931; x=1711368731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81j1Tz/Yqk9Itf6abMwUUdLtUi04c0EJZ65oWIYPoPs=;
        b=PasgsoSLQ/2kZPQr/BXhqFqrWAN7L9RFkIW1PpGr4Z2kzc6fLRM2osDkWdm5QP+bE7
         vqU91vLAyXEAibiZbzvwXilMmdLLSi4rKNlIlVRGOZKXcDBi4CovqRreEU/fTIHl4VPW
         InaGiDvEa59ztCQnBlyZLX4OHZS520qNcN9PtUbm3whtbCvoduJvhmnVhmqFpILR/vVQ
         rXsviQ3i23q+NmrYlZcSdh/d6pji9kAKPaArK8RJK01iXjhY0Y35cwTK8T/jRvYcBzxx
         uIWy2EXyS+O6Efk8RIkJOVX3YfVFu4YtIgBMw08LyvmbXM/LckYdN5T3aca3EQWlgL9G
         6lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710763931; x=1711368731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81j1Tz/Yqk9Itf6abMwUUdLtUi04c0EJZ65oWIYPoPs=;
        b=BtjJ63HywOT37HeXFODN7ApBzZ1mOXSC1nxF1Es7CjoZY0vWpxb9Ca4yeIb6CfUskP
         FKJkndm/Ms7LA3NRKbmu7xbnq2eBPJvqQ1xKXuiaiwTmS7n2MYrRNKy+gzMPGCg584Nv
         JaZYEMzR8KLeuSgEaXgnZyKWNuLodlgghOKxIxH+BV3Ur+zVT+wxJdr/plbhu+r9DXJ/
         424h2iI8Q1wab/G4k1jCQhPrPs66S3FBcBxT07/JK2E7WASbjFwkd0tokq5WSKIjDuYv
         plm/NuF2MP8jZ9VqmUvR6qQWf17CR/j4JFpvDTnunQLo/cido+bpftxBojxOpJovJa8S
         0VAg==
X-Forwarded-Encrypted: i=1; AJvYcCWRK5LJvGafdZ3x2CKGVJxlf+U7rt6DTT691/Zsm4isgnxu0DDRXXVMAlk61gM4688S5NunZVHI3SNhN0H9XxiLwFXPkv7zLzvQsb+6/wi4CLpunGHXqZjzQ7Xwy045m69MJkbVF/tUr+xFwCqZBg==
X-Gm-Message-State: AOJu0Yzcub+Md0Dr8/rKbLTyovbIuyO7HDNBqaHJXJqXnjCt575nMzGm
	Z1IGD7AVo2z/zZgkYlxG1kFecdNwdyCTA333c+2YJntm4GJdxFmx
X-Google-Smtp-Source: AGHT+IG4m45MJ0D7WcceUJLDXwwhF8XuAcMN82ScuuAcZr2qvqDvfyrMu7hXxyWHCtgydnnzHYL/vQ==
X-Received: by 2002:a17:902:d512:b0:1e0:1355:c6b9 with SMTP id b18-20020a170902d51200b001e01355c6b9mr4077784plg.32.1710763931414;
        Mon, 18 Mar 2024 05:12:11 -0700 (PDT)
Received: from pc-mac.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001e01735f74asm2670673plh.128.2024.03.18.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:12:11 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: yangchen11@lixiang.com,
	zhouchunhua@lixiang.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH] perf evlist: Fix the warning logic about warn_user_request_cpu
Date: Mon, 18 Mar 2024 20:11:50 +0800
Message-Id: <20240318121150.1552888-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old logic in evlist__warn_user_requested_cpus incorrectly output
the warning message when I run 'perf record -C xxx' command on my
context(the cpu has 8 performance-cores and 8 efficient-cores.).

The old warning like this:
  # perf record -C 17
  WARNING: A requested CPU in '17' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
  # perf record -C 14
  WARNING: A requested CPU in '14' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  # perf record -C 14-17
  WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'

After patching, the warning is as follows
  # perf record -C 17
  WARNING: A requested CPU '17' in '17' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  # perf record -C 14
  WARNING: A requested CPU '14' in '14' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
  # perf record -C 15-18
  WARNING: A requested CPU '16-18' in '15-18' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
  WARNING: A requested CPU '15' in '15-18' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'

Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..82fee2e29966 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2514,12 +2514,16 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 
 		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
 		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
-		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
-			char buf[128];
 
-			cpu_map__snprint(to_test, buf, sizeof(buf));
-			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
-				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
+		if (intersect && perf_cpu_map__is_subset(user_requested_cpus, intersect)) {
+			char buf_test[128];
+			char buf_intersect[128];
+
+			cpu_map__snprint(to_test, buf_test, sizeof(buf_test));
+			cpu_map__snprint(intersect, buf_intersect, sizeof(buf_intersect));
+			pr_warning("WARNING: A requested CPU '%s' in '%s' is not supported by "
+				   "PMU '%s' (CPUs %s) for event '%s'\n", buf_intersect, cpu_list,
+				   pmu ? pmu->name : "cpu", buf_test, evsel__name(pos));
 		}
 		perf_cpu_map__put(intersect);
 	}
-- 
2.34.1


