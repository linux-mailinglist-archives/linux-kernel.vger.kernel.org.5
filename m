Return-Path: <linux-kernel+bounces-15163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F508227ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192191F239F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABE182DA;
	Wed,  3 Jan 2024 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gtgb+4Q9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67D182A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e744f7ca3bso151045387b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 21:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258416; x=1704863216; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDc8U8CcTfXk6/xIXhbcXcxIlZrCEy1yfrH0rSN6Nbc=;
        b=Gtgb+4Q9xwIphF8/8mfvogKyMwRh0Di3byJfqsGDfslLmpiC9vheU0Cg0LyZn+FWGq
         k3ztS05mrQiyz4fVwnVitZ6N9CQ7MVV8VGwuYblBWa5oCLHQ3D94Ki2jMI0MTsaY3FSI
         LKTx4U4oFZAuSVHT7pPH0JQRfqU5rMWZ4Ec9CxsH1FikfV+4D2t//YH4DoLTOgIsHQZ1
         229yQfUQ3KdwUkIHTdL2m8mI2xV5UIEkUAYutz7NmmXknsDtgJnslG0yd9PbKB/kApPm
         V5PMWW+FtEdBVds/azg7XYqGRKVgyvYdFc1Kw2xxJpZOsWhhOaxxJncv7iI52zXIda51
         Sweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258416; x=1704863216;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDc8U8CcTfXk6/xIXhbcXcxIlZrCEy1yfrH0rSN6Nbc=;
        b=oxI0lWcJp+XlMfnRBo9IgSwFdOM4uWjfL/6Iq06GhyfwtqaNDrMjzWZz6ZAT01VukL
         vpQw0tc3IfXPfa18o1l4NB4LZ8tAvuxamNno+iXcQYYBYRirvc75R67yWd5yZjUes1mW
         4Xq/CRKDvfc16Fkr80gfIH2ca0Gbj/V2wCz0NhNgZF5GE/bitklmSD8/xTaJmPIdEUt8
         Lw5eYJRRutBuA70xJuM090t7u7bo6/hhVsh/HIqCH3YUGFXNx7vuWl/2nC4DWyKRigR2
         KJCTkhBRfwvPQeIP2O2lMBciOYjnis/aDFC91GV6XzAnPT1a66kx7CuvgOFOxsPAnMWN
         4gQQ==
X-Gm-Message-State: AOJu0YywePRygVXmTenM4+aJl2a0JlBOsRWFnAKqozlt49Z0BkyGgRt7
	h5satVOEyAtmui03AHjysAO6G7qLf24Z+SbBi3c=
X-Google-Smtp-Source: AGHT+IEWQozhVRYwGCCAlT1qAhGP5s8IvwEvk0gRqu/SXQlWuFk1hq7ijyvYo99OzzTD24b/L7tp9ntzLYE+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:b83:b0:5ca:5fcd:7063 with SMTP id
 ck3-20020a05690c0b8300b005ca5fcd7063mr8363427ywb.3.1704258416086; Tue, 02 Jan
 2024 21:06:56 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:14 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 04/25] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index b85147cc8723..0438c417ee44 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -943,7 +943,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.472.g3155946c3a-goog


