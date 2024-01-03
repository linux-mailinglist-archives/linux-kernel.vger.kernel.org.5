Return-Path: <linux-kernel+bounces-15165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC628227F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4124CB229E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10A18657;
	Wed,  3 Jan 2024 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eC6YhVvT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAA18640
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdac466edcso9615201276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 21:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258421; x=1704863221; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWXABpo7gjjLxsIx2h9glSNIaYYqxVQN6KNcO9FjYOs=;
        b=eC6YhVvTJzAyr8HNa2Fo6+8vq/i6Waq1kJjJCcsEQ4ipmaJLt2D3KYiq2cYMk4VYVX
         +4y5stFTyWYSWhqoAQov2afrMqmmTEC3NCk/aXV9Dvazsd2qE/Gb6khAwpOzh26Q2I56
         kwWxQ/GMCmMLfi1k+Igqb5JSSL/jZMP3gGm1AYiTtsBit6sYj9+HWUdy/SsrBxsYXN76
         HxS3/L0S/b+zNZZydORmep5UhJUYKRzoYVYUtH8kXKb2Mghi2P1B3qNdn8nnokYYHSv9
         9maIX8NiqbrmJ4TqBwg9jwbm7kzmt0YeZrp1G4S+pQMufClZ4cpx4cAS60KtI2F37+NY
         Ccyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258421; x=1704863221;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWXABpo7gjjLxsIx2h9glSNIaYYqxVQN6KNcO9FjYOs=;
        b=r3w8BYWQ1wqFEz1KrzKgZ+hYDeq2ldBFefm76rQ9hdFRsuj5C54SKhC+MwQctecsR3
         oFIfwC6BI12/UTiN7xh01woyGcE/Aba6YLQLjQQNRP/X6tcKfmhM0GQg/PumSPjHQHX7
         TZeUoZfoOu1I3O2aglK49O7ODXB3LBa1CqzfHq0hE2oZgaqGmn15C6bRpRczhLiFCluR
         n/rl77BIG48uu9A0DJo6ebqk/8KCdFMKHfMb4t7Vbejovrx6dq2qYjPA0xklYJOq1Jzn
         yWiXx3i/GrOQndLzqrkZeT9VnLHoX90ZE4huYOpY6BWqO8RjmNyWZIXxvB43LMirKYt1
         3NnQ==
X-Gm-Message-State: AOJu0YytKkyJ8FWIHEiIKlyT7c1mL/QHhSx3MUiaqktr/XjGK3zqpYO3
	oAwpi6pywa+cvD9Ks3mmqTpXGfpn1GF1vyIo2Gc=
X-Google-Smtp-Source: AGHT+IHUMwHDLuJECA72sU70kX8hzfGaNYfMEJ5he0cP/LCgKp+lHrx9icG52dkE6kWJ4fYLgrnkatpZ9UhP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a25:418b:0:b0:dbe:9dcc:8ba8 with SMTP id
 o133-20020a25418b000000b00dbe9dcc8ba8mr7419yba.6.1704258420783; Tue, 02 Jan
 2024 21:07:00 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:16 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 06/25] perf maps: Locking tidy up of nr_maps
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

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4911734411b5..3da92f18814a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -440,7 +440,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c08e412a4313..cb52de9d6c2a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -528,7 +528,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -852,7 +858,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.472.g3155946c3a-goog


