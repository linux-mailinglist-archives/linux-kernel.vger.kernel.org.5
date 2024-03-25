Return-Path: <linux-kernel+bounces-118006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7288B3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64171B29155
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9625C5E099;
	Mon, 25 Mar 2024 21:03:36 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDD54902;
	Mon, 25 Mar 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400615; cv=none; b=DgfAPax6y91k/OOKZVCwH6YfBIK5H7PEam7TzILebyirCQwnL4m+GSQULcf7Erc/rrq/A4tz2pVbn/wl21cP7C+T6E5wc9+N2aQMqQdE82kEVTNcVjYGtpBtx9GZP3iqlNHQgIGh1MCzng1vm8t5UmeQgxNt/pLNOgrT6zlIJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400615; c=relaxed/simple;
	bh=ssgHvQ3R3Mpu8R/TTz7+YkBqBn4TOTRhLYISdOqAxPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYyMrf45it92zel0gnM+OTMQ5+iHG98B6KFaQmDoR+N679P7McmaCnaa12LTpbdPyfgcvzG89ewG4RoSrZPoO04OJv49KH932FCooKtWARiMCmHn76bXdtpFU1N6inExX2S5wT08zanG5R71x85KSCJwZrR+RBJbb9X6Huvz2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3678421a12.1;
        Mon, 25 Mar 2024 14:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400613; x=1712005413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZOI+hPW8RmYPNaW33K5gzZDR3NImStcasjV31kXcvg=;
        b=NOZ0+ZTacgZSn6b4Rpuo0kwXk8NFAHNa33FguomKL6pbXHp+0KUOAnaBS/QtdNAI+C
         XQumGJ7UBX+wWQN5Zq1IN/c/QvisKBluCnHHkQCQ/2blixNXGrWlAcN8nwM6uo2L6e2y
         6Ypt3GZ8/2NKOqA+zG2IlFZ3DH61mqFt1GAJA36Eu5pPBkXSyZJI+IuR1S46uhIqz1PK
         sKGswnZ/M2uHOGfpPO6JGBMr6zM6UpknU3vTVVejVuBs/sTFhoE4b5zbdB8/aBHmd5g5
         C0VpLIZNnQ+x352SzT9S/p8Pm8IX7jUM5wDzjIqrR2bPgXW/lmOZIld7jgzdTlcVXnTc
         7m4w==
X-Forwarded-Encrypted: i=1; AJvYcCUyeYm2PCCplHVMgeo61hjneOAMTaXF1utLfcedOpK/xyYPNt9W7pgcFelgYmzSW6rQk9Amb79YQ3FkMWaTn8Z5RBdbHl0OwHSJuO9h6Pe78sIFF2HHDM1HrMPrdGkZJaokUpsWq8FfbHPTINKPPDE2HGHejHWmILTOPGEKM1+VMVFEBA==
X-Gm-Message-State: AOJu0Yxqt0RqCzX9gMpm22iHrQUNgHzErRsWGqbetytHAkhphoRO/yD2
	2nz3zAqIHRJrERBdQj+2sN7m7/otmtdD1ZUqkDiYdJ2Il7712OX7yUC/JXaf92lflMnuZmVr4Cl
	BXelw/ZO8EBUsrGVxPqgBJcwa05g=
X-Google-Smtp-Source: AGHT+IGWgVq67HBJtpkYLDDfY4DT0V6z3dimeBRUNhkar5n6YQAN8ma6Oa2q/PXnKWxFi0vqn3a/hEUT8Nzh3ikDbwY=
X-Received: by 2002:a17:90a:f40b:b0:2a0:4e60:ba46 with SMTP id
 ch11-20020a17090af40b00b002a04e60ba46mr10982726pjb.16.1711400613373; Mon, 25
 Mar 2024 14:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 25 Mar 2024 14:03:22 -0700
Message-ID: <CAM9d7chqnsDBCVFoK2hSs=22QrXBS=13Px5hGA4hM=ho7CZd2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] dso/dsos memory savings and clean up
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Mar 21, 2024 at 9:03=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> 13 more patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> a near half year old adventure in trying to lower perf's dynamic
> memory use. Bits like the memory overhead of opendir are on the
> sidelines for now, too much fighting over how
> distributions/C-libraries present getdents. These changes are more
> good old fashioned replace an rb-tree with a sorted array and add
> reference count tracking.
>
> The changes migrate dsos code, the collection of dso structs, more
> into the dsos.c/dsos.h files. As with maps and threads, this is done
> so the internals can be changed - replacing a linked list (for fast
> iteration) and an rb-tree (for fast finds) with a lazily sorted
> array. The complexity of operations remain roughly the same, although
> iterating an array is likely faster than iterating a linked list, the
> memory usage is at least reduce by half.
>
> As fixing the memory usage necessitates changing operations like find,
> modify these operations so that they increment the reference count to
> avoid races like a find in dsos and a remove. Similarly tighten up
> lock usage so that operations working on dsos state hold the
> appropriate lock.
>
> Here are some questions (with answers) that I am expecting from reviewers=
:
>
>  - Why not refactor dso with accessors first and then do the other things=
?
>
> My ambition with this change was to lower memory overhead not to
> particularly clean up and fix dso. Fixing the memory overhead, by
> refactoring and changing the internals, showed that locking discipline
> and reference counting discipline was lacking. The later changes try
> to fix these as a service to the community while I am changing the
> code and to also ensure that code is correct (more correct than it was
> wrt locking and reference counting than before the patches).
>
> Reordering the patches to do the refactoring first will be a giant
> pain. It will merge conflict with every other patch in the series and
> is basically a request to reimplement everything from square 1. The
> only thing I'd have in my favor would be how the code should look at
> the end of the series, and reordering patches doesn't change the
> eventual outcome of applying the patches. Note also, were I to send
> the memory saving patches and then a week later send the API clean up
> and reference counting fix patches the patches would be merged in the
> order they are here. I've done my best, I know you may consider that
> I'm adding to your reviewing overhead but I've also got to think about
> the overhead to me.
>
>  - Please break apart this change...
>
> The first changes are moving things, but when a broken API is spotted
> like the missing get on dsos__find I put it in a change to move the
> function and to add the missed get. Could this be two changes? Yes, it
> could. Does moving code materially change the behavior of the tool?
> No. I've done it in one patch to minimize churn and to some extent for
> my sanity. Such changes are less than 100 lines of code and all
> independently tested.
>
>  - The logic in dso around short, long name and id with sorting is weird
>
> Yes, I've tried to make it less weird while retaining the existing
> behavior. It would be easy to make a series of patches just cleaning
> it up but I came here to save memory not change the dso API.
>
>  - Move the fixes in the 12th patch earlier.
>
> This is possible but then impossible to test with reference count
> checking. This does mean there are broken reference counts before the
> patch is applied, but this is generally already the case. Yes, some
> hypothetical person may decide to fork midway through this patch
> series and my order would mean they wouldn't have a fix. I've done my
> best while working within the bounds of my time and trying to avoid
> churn.
>
> v2. Rebases on top of tmp.perf-tools-next resolving merge conflicts.
>
> Ian Rogers (13):
>   perf dso: Reorder variables to save space in struct dso
>   perf dsos: Attempt to better abstract dsos internals
>   perf dsos: Tidy reference counting and locking
>   perf dsos: Add dsos__for_each_dso
>   perf dso: Move dso functions out of dsos
>   perf dsos: Switch more loops to dsos__for_each_dso
>   perf dsos: Switch backing storage to array from rbtree/list
>   perf dsos: Remove __dsos__addnew
>   perf dsos: Remove __dsos__findnew_link_by_longname_id
>   perf dsos: Switch hand code to bsearch
>   perf dso: Add reference count checking and accessor functions
>   perf dso: Reference counting related fixes
>   perf dso: Use container_of to avoid a pointer in dso_data

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/builtin-annotate.c                 |   8 +-
>  tools/perf/builtin-buildid-cache.c            |   2 +-
>  tools/perf/builtin-buildid-list.c             |  18 +-
>  tools/perf/builtin-inject.c                   |  96 +--
>  tools/perf/builtin-kallsyms.c                 |   2 +-
>  tools/perf/builtin-mem.c                      |   4 +-
>  tools/perf/builtin-record.c                   |   2 +-
>  tools/perf/builtin-report.c                   |   6 +-
>  tools/perf/builtin-script.c                   |   8 +-
>  tools/perf/builtin-top.c                      |   4 +-
>  tools/perf/builtin-trace.c                    |   2 +-
>  tools/perf/tests/code-reading.c               |   8 +-
>  tools/perf/tests/dso-data.c                   |  67 ++-
>  tools/perf/tests/hists_common.c               |   6 +-
>  tools/perf/tests/hists_cumulate.c             |   4 +-
>  tools/perf/tests/hists_output.c               |   2 +-
>  tools/perf/tests/maps.c                       |   4 +-
>  tools/perf/tests/symbols.c                    |   8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
>  tools/perf/ui/browsers/annotate.c             |   6 +-
>  tools/perf/ui/browsers/hists.c                |   8 +-
>  tools/perf/ui/browsers/map.c                  |   4 +-
>  tools/perf/util/annotate-data.c               |  14 +-
>  tools/perf/util/annotate.c                    |  47 +-
>  tools/perf/util/auxtrace.c                    |   2 +-
>  tools/perf/util/block-info.c                  |   2 +-
>  tools/perf/util/bpf-event.c                   |   8 +-
>  tools/perf/util/build-id.c                    | 136 ++---
>  tools/perf/util/build-id.h                    |   2 -
>  tools/perf/util/callchain.c                   |   2 +-
>  tools/perf/util/data-convert-json.c           |   2 +-
>  tools/perf/util/db-export.c                   |   6 +-
>  tools/perf/util/dlfilter.c                    |  12 +-
>  tools/perf/util/dso.c                         | 472 +++++++++------
>  tools/perf/util/dso.h                         | 554 +++++++++++++++---
>  tools/perf/util/dsos.c                        | 529 +++++++++++------
>  tools/perf/util/dsos.h                        |  40 +-
>  tools/perf/util/event.c                       |   8 +-
>  tools/perf/util/header.c                      |   8 +-
>  tools/perf/util/hist.c                        |   4 +-
>  tools/perf/util/intel-pt.c                    |  22 +-
>  tools/perf/util/machine.c                     | 192 ++----
>  tools/perf/util/machine.h                     |   2 +
>  tools/perf/util/map.c                         |  82 ++-
>  tools/perf/util/maps.c                        |  14 +-
>  tools/perf/util/probe-event.c                 |  25 +-
>  .../util/scripting-engines/trace-event-perl.c |   6 +-
>  .../scripting-engines/trace-event-python.c    |  21 +-
>  tools/perf/util/session.c                     |  21 +
>  tools/perf/util/session.h                     |   2 +
>  tools/perf/util/sort.c                        |  19 +-
>  tools/perf/util/srcline.c                     |  65 +-
>  tools/perf/util/symbol-elf.c                  | 145 +++--
>  tools/perf/util/symbol-minimal.c              |   4 +-
>  tools/perf/util/symbol.c                      | 186 +++---
>  tools/perf/util/symbol_fprintf.c              |   4 +-
>  tools/perf/util/synthetic-events.c            |  24 +-
>  tools/perf/util/thread.c                      |   4 +-
>  tools/perf/util/unwind-libunwind-local.c      |  18 +-
>  tools/perf/util/unwind-libunwind.c            |   2 +-
>  tools/perf/util/vdso.c                        |  56 +-
>  61 files changed, 1817 insertions(+), 1220 deletions(-)
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

