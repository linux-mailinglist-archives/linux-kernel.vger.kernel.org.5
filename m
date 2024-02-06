Return-Path: <linux-kernel+bounces-54143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28F84AB72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D93F287120
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C151361;
	Tue,  6 Feb 2024 01:14:04 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C534A06;
	Tue,  6 Feb 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182044; cv=none; b=BFl26vgpeR2x+r+7sxU7IATasAXhbhTf8uTfv+BjrRMf5vreNSsna0vdhJdD1UOrBoxy+ZXpNXviVuCle+hw0PAvgXVOTf2cK9qnKeyOOkJRxhA64dv1zONw1e72hA76dMj7t0Cbosj9yAzz3n+Cryl2A8kkgrtoBUQGNYi136Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182044; c=relaxed/simple;
	bh=pMhiY7dOHzMLKuexGo6Y2Dvwut2S7WBuuFy0mbEgBbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcvEKzUW5/Lh9hCb9p+dYyHC/6LQl/mE2BecoL8dI6WDsm6Vn4043I860pG2i++fOi6/ntLhonmzQ4fpYDV+7wRqeqzyUyf/8n+/Lz1Au3TxBkpfO3isKJtG19aH5Gp/12LgqTfQoL9ALCIRYh9ZoRNBb5RyFJIryOEsfYwK78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4574871a12.0;
        Mon, 05 Feb 2024 17:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707182042; x=1707786842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3L7hTGKnHQO1yhpr6n5deEhCG4zJbFmaDzbOK4JnIok=;
        b=HqujMMnlYOZpymxPiSSN6PwsGKKJtO5OO/2sBTPyt8yyJm1+C/tu5w4eAMRCHtX6Lz
         iKHPsowpMhBXJBGPyN1aVIh+ie+v0lhUMwlRpoX2bc7ya1sItm2rHbW5HWKQ+VxzhA1v
         Q4apdBAOEsX7loTk4BKrkjAALReKlvkVV+oGRKMnUh/gTYQE56i8a2ggmxwEjECj8c4d
         8GQEj16bjLy3i0vBfQfUEqx08uS0GfMlc9ixNvv8QlORDcXe+vcmkcYFk/qPc2yzHOu9
         ewhvoq39i53tMHAwJcKAWLnXrZHTRsYFDLzNZHuHQaX4iyY9EEkW5mGL08hyMVD1DdZs
         etfA==
X-Gm-Message-State: AOJu0Yz6rjHU9bKnbq4tJe4Ys10kiA2La+v44TcE4o68A2hgyeHLRkzA
	4jzNHOyLJRPoXpJcmIMUL7W7XSsr5wUi5mh6kaH1vsra86uFI4xB9a+ecFcJaJW+8c+s0j/PDPr
	/scNfK5HkmmYk3LCcYDvv3p/KDSI=
X-Google-Smtp-Source: AGHT+IGRKIKutnhyB/UfAu1pKRjuW5LRocoRpDq2a8zfi4eTsJCQt4qBIdFARW444kVJa5dXmg7Pt71F8keah2xVI+s=
X-Received: by 2002:a05:6a20:9012:b0:19c:881d:78e6 with SMTP id
 d18-20020a056a20901200b0019c881d78e6mr165482pzc.42.1707182041636; Mon, 05 Feb
 2024 17:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 17:13:50 -0800
Message-ID: <CAM9d7cgeEmoKmk3qCUdxsCRRx1mUERf6Mz6PgRtsaY+7+F9FhQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] maps/threads/dsos memory improvements and fixes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Modify the implementation of maps to not use an rbtree as the
> container for maps, instead use a sorted array. Improve locking and
> reference counting issues.
>
> Similar to maps separate out and reimplement threads to use a hashmap
> for lower memory consumption and faster look up. The fixes a
> regression in memory usage where reference count checking switched to
> using non-invasive tree nodes.  Reduce its default size by 32 times
> and improve locking discipline. Also, fix regressions where tids had
> become unordered to make `perf report --tasks` and
> `perf trace --summary` output easier to read.
>
> Better encapsulate the dsos abstraction. Remove the linked list and
> rbtree used for faster iteration and log(n) lookup to a sorted array
> for similar performance but half the memory usage per dso. Improve
> reference counting and locking discipline, adding reference count
> checking to dso.
>
> v8:
>  - in "perf maps: Switch from rbtree to lazily sorted array for
>    addresses" use accessors and remove some duplicative invariant checks =
as
>    requested by Namhyung.
>
> v7:
>  - rebase to latest perf-tools-next where 22 patches were applied by Arna=
ldo.
>  - resolve merge conflicts, in particular with fc044c53b99f ("perf
>    annotate-data: Add dso->data_types tree") that required more dso
>    accessor functions.
>
> v6 series is here:
> https://lore.kernel.org/lkml/20231207011722.1220634-1-irogers@google.com/
>
> Ian Rogers (25):
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps

Can you please send patch 1-6 separately with my Ack? - provided
you fixed the issue in the patch 1.

For patch 1-6:

Acked-by: Namhyung Kim <namhyung@kernel.org>

I'll review others later.

Thanks,
Namhyung


>   perf dso: Reorder variables to save space in struct dso
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
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
>
>  tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
>  tools/perf/builtin-annotate.c                 |    8 +-
>  tools/perf/builtin-buildid-cache.c            |    2 +-
>  tools/perf/builtin-buildid-list.c             |   18 +-
>  tools/perf/builtin-inject.c                   |   96 +-
>  tools/perf/builtin-kallsyms.c                 |    2 +-
>  tools/perf/builtin-mem.c                      |    4 +-
>  tools/perf/builtin-record.c                   |    2 +-
>  tools/perf/builtin-report.c                   |  209 +--
>  tools/perf/builtin-script.c                   |    8 +-
>  tools/perf/builtin-top.c                      |    4 +-
>  tools/perf/builtin-trace.c                    |   43 +-
>  tools/perf/tests/code-reading.c               |    8 +-
>  tools/perf/tests/dso-data.c                   |   67 +-
>  tools/perf/tests/hists_common.c               |    6 +-
>  tools/perf/tests/hists_cumulate.c             |    4 +-
>  tools/perf/tests/hists_output.c               |    2 +-
>  tools/perf/tests/maps.c                       |    7 +-
>  tools/perf/tests/symbols.c                    |    2 +-
>  tools/perf/tests/thread-maps-share.c          |    8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   16 +-
>  tools/perf/ui/browsers/annotate.c             |    6 +-
>  tools/perf/ui/browsers/hists.c                |    8 +-
>  tools/perf/ui/browsers/map.c                  |    4 +-
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/annotate-data.c               |    6 +-
>  tools/perf/util/annotate.c                    |   45 +-
>  tools/perf/util/auxtrace.c                    |    2 +-
>  tools/perf/util/block-info.c                  |    2 +-
>  tools/perf/util/bpf-event.c                   |    9 +-
>  tools/perf/util/bpf_lock_contention.c         |    8 +-
>  tools/perf/util/build-id.c                    |  136 +-
>  tools/perf/util/build-id.h                    |    2 -
>  tools/perf/util/callchain.c                   |    4 +-
>  tools/perf/util/data-convert-json.c           |    2 +-
>  tools/perf/util/db-export.c                   |    6 +-
>  tools/perf/util/dlfilter.c                    |   12 +-
>  tools/perf/util/dso.c                         |  469 +++---
>  tools/perf/util/dso.h                         |  549 ++++++-
>  tools/perf/util/dsos.c                        |  529 ++++---
>  tools/perf/util/dsos.h                        |   40 +-
>  tools/perf/util/event.c                       |   12 +-
>  tools/perf/util/header.c                      |    8 +-
>  tools/perf/util/hist.c                        |    4 +-
>  tools/perf/util/intel-pt.c                    |   22 +-
>  tools/perf/util/machine.c                     |  570 +++-----
>  tools/perf/util/machine.h                     |   32 +-
>  tools/perf/util/map.c                         |   73 +-
>  tools/perf/util/maps.c                        | 1298 +++++++++++------
>  tools/perf/util/maps.h                        |   65 +-
>  tools/perf/util/probe-event.c                 |   26 +-
>  tools/perf/util/rb_resort.h                   |    5 -
>  .../util/scripting-engines/trace-event-perl.c |    6 +-
>  .../scripting-engines/trace-event-python.c    |   21 +-
>  tools/perf/util/session.c                     |   21 +
>  tools/perf/util/session.h                     |    2 +
>  tools/perf/util/sort.c                        |   19 +-
>  tools/perf/util/srcline.c                     |   65 +-
>  tools/perf/util/symbol-elf.c                  |  132 +-
>  tools/perf/util/symbol.c                      |  217 +--
>  tools/perf/util/symbol_fprintf.c              |    4 +-
>  tools/perf/util/synthetic-events.c            |   24 +-
>  tools/perf/util/thread.c                      |    8 +-
>  tools/perf/util/thread.h                      |    6 -
>  tools/perf/util/threads.c                     |  186 +++
>  tools/perf/util/threads.h                     |   35 +
>  tools/perf/util/unwind-libunwind-local.c      |   20 +-
>  tools/perf/util/unwind-libunwind.c            |    9 +-
>  tools/perf/util/vdso.c                        |   56 +-
>  69 files changed, 3143 insertions(+), 2160 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>
>

