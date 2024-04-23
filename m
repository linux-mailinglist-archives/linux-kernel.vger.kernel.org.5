Return-Path: <linux-kernel+bounces-154495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDFA8ADCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0544E1C21B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882141D52D;
	Tue, 23 Apr 2024 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RC0tUMUV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4881C698
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846382; cv=none; b=oxDpobagAGi5QlinpMfjFxfoSRkjIyplM6k035qRobumsKeVyb2hQGW3hOmqT3rn+bGAKfSCxMfckCAj9N89ldBhERdyeF4FKE7e0DoCY/2XC6GZEIXGob/7KKsEv0YH2q4Es9GOWbwlys+exTOgIP8KDSZbTEO1R6PaHbNvGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846382; c=relaxed/simple;
	bh=LqnW6gujYHUf5oa5lOh/ef6cFvhhvGAk5ZFGJUs3I7s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=E7eBk1fRUsy7UviB3NnXquWcr44TA6yp+GVoGH53Nuq0f/6aAii8azy2bUrWbuCnPlkJiYdAPCT/zFOc8iPoS5G3BBQdl7TCueP2Qjk5WaQuvuElACGJ17q3WNC7DWOIGp9TjnbfJvidviQrG/gOfBN7tGPsrhDANSZ9wQz1bvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RC0tUMUV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61892d91207so101130827b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846380; x=1714451180; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ragptW+RjDhGej+KK6swto1RnOpIQJkFpN4rX92hb68=;
        b=RC0tUMUVChhftAmhqpP8ncTQ8bdCvu/ZztqOyKawVkRE6sXSaKRlBElf43oEi/KAqy
         VnT+qzpOlJxzw00jgvax0VYz8Nhjox4EFYqGlrLO43CLeplz5fe4+zwrFO/8nSfIUys1
         pHYaSY4qw0EqNkNFnksTswzcmjpqIUuTnJZ/4aoKApjTZOkvUVo2utBjXHJqar8xQUBc
         hUBtJVYRq4ySWUhM1qulB9h8RbEw4hnHY7+haMd+42GgH08Zgy/s7bB8QoXIE8x3GsLg
         0zcBB3i4y4UFcwYAzpA0gykx2LigfkjcIHfvxde8fLpAH/+2BjpuTTOvVG2At6ywqrV7
         99JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846380; x=1714451180;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ragptW+RjDhGej+KK6swto1RnOpIQJkFpN4rX92hb68=;
        b=bLd2uAXb7cEbHZExRLio5E+thHnd//en82ooZt8h5o+GxjdBdgsVIalXc8kLLE52YN
         XQOp4/sD7PHmVJwftjUfEbfk844DV4D+U999QG+id2wJFk74FEDjxwyZ7YergN7MygZS
         p8VFjkZ1WVvBmXwkBxVtL0X2p3f1zsGdsMqM3ZUipUmLcrdcA2TCej+1sltp9TA5qmxN
         m+jDYENEeltXBa5d+Rg8Q0WTq7uBPrY3AQy7cFmS4FJLz9i/xFuMC9vhBuwZF/OFVREC
         WSU0ciTXBoMhiK0Pl2nsZVO/72uKnRoPVBk8PblPizKjNficxTMrIoxypafzvWtCrc5V
         8wxw==
X-Forwarded-Encrypted: i=1; AJvYcCWSG0goX1a5GHS7tVzpRHk49ch+OqkzKyn3hyZE/TH7RzJDkz3Y7ES17Gshk+KISjZ+9mTH8Bmbkl38LOH2lAWj7w7KJ+Q0/dhYlwUm
X-Gm-Message-State: AOJu0YzLUtYdgCZ0j5Yfejr9r4Q8z/1UkAKweAHMHO37yxro3E5NMJXH
	lxn85M1CwU2xfAzM0oRwJX00LPR2RexFfNmwmgMGejJOWMQXabdw5AQH0bogXp2cfJ5YsTmI6Pc
	Acjxg7A==
X-Google-Smtp-Source: AGHT+IHoEqmH0b1OtoMqYGx6VdCedgqxbhAr7NLfuRkKchEaULfvUGogUuPmRb7zrClxfhvMDSOx2OiWzsiM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a25:4e41:0:b0:de5:53a9:384a with SMTP id
 c62-20020a254e41000000b00de553a9384amr181684ybb.13.1713846379874; Mon, 22 Apr
 2024 21:26:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:54 -0700
Message-Id: <20240423042601.2009469-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 0/7] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

7 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. Bits like the memory overhead of opendir are on the
sidelines for now, too much fighting over how
distributions/C-libraries present getdents. These changes are more
good old fashioned replace an rb-tree with a sorted array and add
reference count tracking.

The changes migrate dsos code, the collection of dso structs, more
into the dsos.c/dsos.h files. As with maps and threads, this is done
so the internals can be changed - replacing a linked list (for fast
iteration) and an rb-tree (for fast finds) with a lazily sorted
array. The complexity of operations remain roughly the same, although
iterating an array is likely faster than iterating a linked list, the
memory usage is at least reduce by half.

As fixing the memory usage necessitates changing operations like find,
modify these operations so that they increment the reference count to
avoid races like a find in dsos and a remove. Similarly tighten up
lock usage so that operations working on dsos state hold the
appropriate lock.

Here are some questions (with answers) that I am expecting from reviewers:

 - Why not refactor dso with accessors first and then do the other things?

My ambition with this change was to lower memory overhead not to
particularly clean up and fix dso. Fixing the memory overhead, by
refactoring and changing the internals, showed that locking discipline
and reference counting discipline was lacking. The later changes try
to fix these as a service to the community while I am changing the
code and to also ensure that code is correct (more correct than it was
wrt locking and reference counting than before the patches).

Reordering the patches to do the refactoring first will be a giant
pain. It will merge conflict with every other patch in the series and
is basically a request to reimplement everything from square 1. The
only thing I'd have in my favor would be how the code should look at
the end of the series, and reordering patches doesn't change the
eventual outcome of applying the patches. Note also, were I to send
the memory saving patches and then a week later send the API clean up
and reference counting fix patches the patches would be merged in the
order they are here. I've done my best, I know you may consider that
I'm adding to your reviewing overhead but I've also got to think about
the overhead to me.

 - Please break apart this change...

The first changes are moving things, but when a broken API is spotted
like the missing get on dsos__find I put it in a change to move the
function and to add the missed get. Could this be two changes? Yes, it
could. Does moving code materially change the behavior of the tool?
No. I've done it in one patch to minimize churn and to some extent for
my sanity. Such changes are less than 100 lines of code and all
independently tested.

 - The logic in dso around short, long name and id with sorting is weird

Yes, I've tried to make it less weird while retaining the existing
behavior. It would be easy to make a series of patches just cleaning
it up but I came here to save memory not change the dso API.

 - Move the fixes in the 12th patch earlier.

This is possible but then impossible to test with reference count
checking. This does mean there are broken reference counts before the
patch is applied, but this is generally already the case. Yes, some
hypothetical person may decide to fork midway through this patch
series and my order would mean they wouldn't have a fix. I've done my
best while working within the bounds of my time and trying to avoid
churn.

v4. Rebases, dealing with merge conflicts, on tmp.perf-tools-next
    dropping the merged:
  perf dsos: Attempt to better abstract dsos internals
  perf dsos: Tidy reference counting and locking
  perf dsos: Add dsos__for_each_dso
  perf dso: Move dso functions out of dsos
  perf dsos: Switch more loops to dsos__for_each_dso

v3. Rebases and drops merged "perf dso: Reorder variables to save
    space in struct dso"

v2. Rebases on top of tmp.perf-tools-next resolving merge conflicts.

Ian Rogers (7):
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/builtin-annotate.c                 |   6 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  71 ++-
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |   8 +-
 tools/perf/tests/dso-data.c                   |  67 ++-
 tools/perf/tests/hists_common.c               |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/symbols.c                    |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   8 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate-data.c               |  16 +-
 tools/perf/util/annotate.c                    |  17 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    |  38 +-
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/disasm.c                      |  36 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 429 ++++++++-------
 tools/perf/util/dso.h                         | 500 ++++++++++++++++--
 tools/perf/util/dsos.c                        | 286 +++++-----
 tools/perf/util/dsos.h                        |  18 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     |  50 +-
 tools/perf/util/map.c                         |  78 +--
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/print_insn.c                  |   2 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 +--
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++----
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   8 +-
 58 files changed, 1407 insertions(+), 930 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


