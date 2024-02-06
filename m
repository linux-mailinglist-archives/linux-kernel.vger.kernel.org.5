Return-Path: <linux-kernel+bounces-54264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2B84ACF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D791F2417A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C77A720;
	Tue,  6 Feb 2024 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixVwS9m/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9177F2B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190421; cv=none; b=jhU5HpxZB33vjXFrxFqLzQgO2SV/f14ziGFeWZ9Nb9BSvUXhQSALEWgVr8rTQiIVoRJTrNoj/hnJ2a2zCfYpXGrGvkxfaIQjFs9NCL2UOHBqGeKdRxRL/urDm8GFFouvySbioE4bXQPnnEQT+j//Oo/8yKVJCGpVPI2AdeZ5u0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190421; c=relaxed/simple;
	bh=QOZ3AXSow+69/jSpTKwTzsRv+NqoTfrDzrJ1ZUXaoRk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BFl6aMPf3HzFtjHJMSE7ERtDXU5d1y9laws0+mrUGUvAAoQyXk9NO8EJkDOYTen7SezCpxv09VDYVxXKV4glTIBUYgkQRvPaoWQ0cO417bY/3EsBuoW5tJSKs6rVaatPXEtDcheg4N8YWW90oDSUq5R/vxc+fgmFnSJi8LWvt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixVwS9m/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60402c8d651so82838307b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190419; x=1707795219; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvZ5WUWTj8QrlPAJDzYrQkQZ6y0b1KQREpo25gbb83I=;
        b=ixVwS9m/0znAw4QZkK+GbKmrknuOyRgxRPKAwxgz4Pzfd5JnseVblOETA7o0GsOPWJ
         n8Z+kXzC7suudMIuWBKVva54xQ2z2Q1hvaKh+pv1Q6/V5lZizFVEiHVOdB3lT4G3SuXR
         NaJSvfD+2NcfveM1/4UUC44quCuVgFpNlGirB1EknN5317334GM1SJ0At0TJmYSh3+SD
         oNcRHywDuoTW3Fz3vhLwkSTBcgytvJ9Mpfd89YlEsYYvGrRmYx9oMoHi5JhouDHYRJiy
         hoTGDJ8h5LfmHk+4EeyoUnkEV5rF4MQacUR3g80gObvzRJGmgHTf1+RrX8tbeLp1JBNK
         kiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190419; x=1707795219;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvZ5WUWTj8QrlPAJDzYrQkQZ6y0b1KQREpo25gbb83I=;
        b=C07rfP9YYIuIjXiABIzKDgaeTxrMoFFS+/ccFJJL6Gl0YDFTciVcqqh37TXSbLivC7
         Aa7hM0wBBrd+MH1S0wDb3Saqngzu7eUYRQUECJ91dw+Qeo/f6FwqzMNESnCzcGyU2oDH
         vDVSSQwWmeBqlKkWd14a4nnmDgBv66mx/sk6i6hv8o05aT5qWUoSCl3KxW6B8qyBHGo6
         Yz/vtFXUovRLRrCzthMpLHzJnYVQfw30/VUVDaIuG6drZlB5vIG016EvtAXa7QaiL/QA
         bW9ixkDwmeSCSVsOEAzHPkyjm5fwGecNHAOpzrrkffk89slbzs+zw0uN8qk+prXaxwfW
         d2bg==
X-Gm-Message-State: AOJu0YyeCwgOukd3PUxAxDahOMm2qkMMIccqUywUp1E5L2vc8ZNBszcD
	ms97YLICN1PbqU8eI4cE3XubA4g8xga4cqXo02/HH+qzH8EeDC26t+hr9I3SmFKc+Ub8FDG6KxT
	FIM+TQQ==
X-Google-Smtp-Source: AGHT+IFQ5Cjk0u4xcaI5JLcWkiiRAFVFGcAFLgvP/B977DrcT5aY6dBkcszM6l3wtqyHQ4ROSouzvTQuGzhZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a81:9ac1:0:b0:5f9:4fa1:1a0b with SMTP id
 r184-20020a819ac1000000b005f94fa11a0bmr62908ywg.0.1707190418775; Mon, 05 Feb
 2024 19:33:38 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:20 -0800
In-Reply-To: <20240206033320.2657716-1-irogers@google.com>
Message-Id: <20240206033320.2657716-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 6/6] perf maps: Locking tidy up of nr_maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index 0ab19e1de190..e59118648524 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -541,7 +541,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
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
@@ -865,7 +871,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
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
2.43.0.594.gd9cf4e227d-goog


