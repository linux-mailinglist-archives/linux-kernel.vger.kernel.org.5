Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C58807CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443064AbjLGALL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442984AbjLGAKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:10:55 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34419E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:10:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50beed2a46eso1555e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701907858; x=1702512658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbCbrg3j+n6hw5FDSN3XVi+GFi+VbZZ8w/r4cs8ioZQ=;
        b=rT+rO/bXh2nN64lz61CjjPbjxKDpz24iGdjty9mzXty5XJX+Bglm8i7kNV5hcN1yVr
         NLE5+Srm1TbbkcxH7pWnixlGccADMiKmiKffW+RwA87ODtmA3WQj2bADhTxnANBguLOh
         5SNu+1sKH6Z75YIfcoIOLW5GoqIuwV4Q/EG0ZReQ+JS2wItsmXoQGljhxbjkSweMfqou
         uKr8FJ3xzg6f91vjp6Cmf2w9jHN1X9EGwQBtSViORW1hvMeceIIRRlnSXgyY09crQ2+g
         Hjgkdqkp1wJ7+pIkrNrJYhvhfKDz1LBaK/aS9jI/rZrcvTlTxnklp1JYZjPQiJzSIh2U
         tSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907858; x=1702512658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbCbrg3j+n6hw5FDSN3XVi+GFi+VbZZ8w/r4cs8ioZQ=;
        b=sLTOQ9v2Rx6rKSFc5K+vOCEfJmifZ9vWi1RZi86il2scsHG8R/WvPLxftDbKrzDEaz
         aihQ7jR2ye1ujKJ5sAR5gyxZMM7KGMBvNj5sxuzQ5tVFdAJnx3KqlvC5i1kB3nGY4Nsa
         Zs2S4Z3WDGxVJonB7zFZUg/qei4X0vdoXqccvlbm5qT1/JabHIEMitAree9NvZUAUV32
         uAoBMQHKutPQrBl5DHuevVDGDFqKQnGW1sVA/hlk3H5C3VQ5g74FlWriNM4NsPhm+WmH
         DOn/cbw1mDWuw0xExNxfBiOE/RSdEMpIpMRD0/mUuH87dsBjRcAc960XxxGP+b2B6kuI
         8Pvw==
X-Gm-Message-State: AOJu0Ywu5XPX+hIrFJxbWMRIaDFhHwkKCPGsfvJNEVFkymxKBkWZi5QW
        vyEJ1e8nrzL8tqxfSPdc8sqBO4OyTP17dap2cVrSbg==
X-Google-Smtp-Source: AGHT+IFg1ac9j2r6/2y83W0CvJi1XAwztyQwncd0PTTzJmU5zazDspM8OtPA7mjIAyAPYJI0IttDjqTgjSLhmWcLtnw=
X-Received: by 2002:ac2:4c8b:0:b0:50b:fa8d:f28b with SMTP id
 d11-20020ac24c8b000000b0050bfa8df28bmr76181lfl.1.1701907857604; Wed, 06 Dec
 2023 16:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <CAM9d7cj=ojxxdbT095UiwaP+WCRCHMGCU_JYQCWBD-vGiKScjA@mail.gmail.com>
In-Reply-To: <CAM9d7cj=ojxxdbT095UiwaP+WCRCHMGCU_JYQCWBD-vGiKScjA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 16:10:46 -0800
Message-ID: <CAP-5=fWbsCaQi1XAzCqr0Rr1AtMZUBaECE+BgZsqzcRneBsegw@mail.gmail.com>
Subject: Re: [PATCH v5 00/50] Improvements to memory use
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Fix memory leaks detected by address/leak sanitizer affecting LBR
> > call-graphs, perf mem and BPF offcpu.
> >
> > Make branch_type_stat in callchain_list optional as it is large and
> > not always necessary - in particular it isn't used by perf top.
> >
> > Make the allocations of zstd streams, kernel symbols and event copies
> > lazier in order to save memory in cases like perf record.
> >
> > Handle the thread exit event and have it remove the thread from the
> > threads set in machine. Don't do this for perf report as it causes a
> > regression for task lists, which assume threads are never removed from
> > the machine's set, and offcpu events, that may sythensize samples for
> > threads that have exited.
> >
> > Avoid using 8kb buffers for filename__read_str which is excessive for
> > reading CPU maps. Add io_dir as an allocation free readdir
> > replacement, opendir allocating 32kb by default and the code uses it
> > recursively.
> >
> > Shrink perf map using a two value byte to replace two function
> > pointers. Modify the implementation of maps to not use an rbtree as
> > the container for maps, instead use a sorted array. Improve locking
> > and reference counting issues.
> >
> > Similar to maps separate out and reimplement threads to use a hashmap
> > for lower memory consumption and faster look up. The fixes a
> > regression in memory usage where reference count checking switched to
> > using non-invasive tree nodes.  Reduce its default size by 32 times
> > and improve locking discipline. Also, fix regressions where tids had
> > become unordered to make `perf report --tasks` and
> > `perf trace --summary` output easier to read.
> >
> > Better encapsulate the dsos abstraction. Remove the linked list and
> > rbtree used for faster iteration and log(n) lookup to a sorted array
> > for similar performance but half the memory usage per dso. Improve
> > reference counting and locking discipline, adding reference count
> > checking to dso. Experimented with, but abandoned, a hashmap
> > implementation due to the need for extra storage and the keys not
> > being stable.
> >
> > The overall effect is to reduce memory consumption significantly for
> > perf top - with call graphs enabled running longer before 1GB of
> > memory is consumed. For a perf record of 'true', the memory
> > consumption goes from 39912kb max resident to 20096kb max resident -
> > nearly halved. perf inject with -b of a system wide perf record of
> > 'true' reduces the max resident by roughly 4.5% (3.4% in v4 due to
> > branch_type_stat changes being merged). This is while improving
> > correctness with locking discipline and reference count checking.
> >
> > Patch organization (v5):
> >  - 50 patches is a lot, the patches aren't divided as they merge confli=
ct and
> >    later patches, for example in dsos, rely on the changes and fixes to=
 maps.
>
> You don't need to do it all at once.  AFAIK the io_dir changes are indepe=
ndent
> and you can separate map/maps changes from others.  Maybe you can wait
> for map changes merged before working on the dso changes.  I know it'd ta=
ke
> more time but it'd be easier to deal with smaller patches focusing on a s=
ingle
> factor both for you and the reviewers.

Agreed on the io_dir changes, they were intentionally first so they
were easy to take, but I can make them their own series.
The dsos changes are only asan clean with the maps changes, so I
prefer to keep these two longer series together.

Thanks,
Ian

> p.s. I know I also have a set of ~50 patches and feel sorry about saying
> like this. ;-p  Maybe I need to split the data type profiling series too.
>
> Thanks,
> Namhyung
>
>
> >  - the dso reference count checking patch is larger due to switch use o=
f dso to
> >    be by accessors, to encapsulate the reference count checker macros. =
The
> >    reference count checking changes within this largely mechanical chan=
ge amount
> >    to a few lines and so weren't separated.
> >  - the first patch contains a build fix if the rwsem error checking is
> >    enabled missed from v3.
> >  - the next patches are an assortment of memory size fixes.
> >  - the next patches are the refactoring of maps.
> >  - the next patches are the refactoring of threads.
> >  - the next patches are the refactoring of dsos.
> >  - finally reference count checking is added to dso and some lock/refer=
ence
> >    count issues are resolved. This is done after changing the data stru=
ctures,
> >    for example, as the single pointer on an array is easier to add refe=
rence
> >    count checking to compared to the 5 previous pointers.
> >
> > v5: 3 patches were merged. 2nd patch addressed feedback from
> >     namhyung@kernel.org and Guilherme Amadio <amadio@gentoo.org>. 4th
> >     patch rename function to getdelim as suggested by
> >     namhyung@kernel.org. 5 patch adds the missing sysfs mountpoint as
> >     suggested by namhyung@kernel.org. 49th patch fix a missed put in
> >     the dso_data tests.
> > v4: Rebased as 11 changes moved to perf-tools-next. Address comments
> >     from v3 such as error checking on zstd streams. Improve the
> >     dsos/dso in ways similar to threads and maps, with the addition of
> >     reference count checking on dso.
> > v3: Additional memory/speed improvements, in particular for maps and
> >     threads. Address review comments from namhyung@kernel.org and
> >     adrian.hunter@intel.com.
> > v2: Add additional memory fixes on top of initial LBR and rc check
> >     fixes.
> >
> > Ian Rogers (50):
> >   perf comm: Use regular mutex
> >   libperf: Lazily allocate/size mmap event copy
> >   perf mmap: Lazily initialize zstd streams
> >   tools api fs: Switch filename__read_str to use io.h
> >   tools api fs: Avoid reading whole file for a 1 byte bool
> >   tools lib api: Add io_dir an allocation free readdir alternative
> >   perf maps: Switch modules tree walk to io_dir__readdir
> >   perf record: Be lazier in allocating lost samples buffer
> >   perf pmu: Switch to io_dir__readdir
> >   perf header: Switch mem topology to io_dir__readdir
> >   perf events: Remove scandir in thread synthesis
> >   perf map: Simplify map_ip/unmap_ip and make map size smaller
> >   perf maps: Move symbol maps functions to maps.c
> >   perf thread: Add missing RC_CHK_EQUAL
> >   perf maps: Add maps__for_each_map to call a function on each entry
> >   perf maps: Add remove maps function to remove a map based on callback
> >   perf debug: Expose debug file
> >   perf maps: Refactor maps__fixup_overlappings
> >   perf maps: Do simple merge if given map doesn't overlap
> >   perf maps: Rename clone to copy from
> >   perf maps: Add maps__load_first
> >   perf maps: Add find next entry to give entry after the given map
> >   perf maps: Reduce scope of map_rb_node and maps internals
> >   perf maps: Fix up overlaps during fixup_end
> >   perf maps: Switch from rbtree to lazily sorted array for addresses
> >   perf maps: Get map before returning in maps__find
> >   perf maps: Get map before returning in maps__find_by_name
> >   perf maps: Get map before returning in maps__find_next_entry
> >   perf maps: Hide maps internals
> >   perf maps: Locking tidy up of nr_maps
> >   perf dso: Reorder variables to save space in struct dso
> >   perf report: Sort child tasks by tid
> >   perf trace: Ignore thread hashing in summary
> >   perf machine: Move fprintf to for_each loop and a callback
> >   perf threads: Move threads to its own files
> >   perf threads: Switch from rbtree to hashmap
> >   perf threads: Reduce table size from 256 to 8
> >   perf dsos: Attempt to better abstract dsos internals
> >   perf dsos: Tidy reference counting and locking
> >   perf dsos: Add dsos__for_each_dso
> >   perf dso: Move dso functions out of dsos
> >   perf dsos: Switch more loops to dsos__for_each_dso
> >   perf dsos: Switch backing storage to array from rbtree/list
> >   perf dsos: Remove __dsos__addnew
> >   perf dsos: Remove __dsos__findnew_link_by_longname_id
> >   perf dsos: Switch hand code to bsearch
> >   perf dso: Add reference count checking and accessor functions
> >   perf dso: Reference counting related fixes
> >   perf dso: Use container_of to avoid a pointer in dso_data
> >   perf env: Avoid recursively taking env->bpf_progs.lock
> >
> >  tools/lib/api/Makefile                        |    2 +-
> >  tools/lib/api/fs/fs.c                         |   80 +-
> >  tools/lib/api/io.h                            |   11 +-
> >  tools/lib/api/io_dir.h                        |   75 +
> >  tools/lib/perf/include/internal/mmap.h        |    3 +-
> >  tools/lib/perf/mmap.c                         |   21 +-
> >  tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
> >  tools/perf/arch/x86/util/event.c              |  103 +-
> >  tools/perf/builtin-annotate.c                 |    6 +-
> >  tools/perf/builtin-buildid-cache.c            |    2 +-
> >  tools/perf/builtin-buildid-list.c             |   18 +-
> >  tools/perf/builtin-inject.c                   |   96 +-
> >  tools/perf/builtin-kallsyms.c                 |    2 +-
> >  tools/perf/builtin-mem.c                      |    4 +-
> >  tools/perf/builtin-record.c                   |   57 +-
> >  tools/perf/builtin-report.c                   |  243 ++--
> >  tools/perf/builtin-script.c                   |    8 +-
> >  tools/perf/builtin-top.c                      |    4 +-
> >  tools/perf/builtin-trace.c                    |   41 +-
> >  tools/perf/tests/code-reading.c               |    8 +-
> >  tools/perf/tests/dso-data.c                   |   67 +-
> >  tools/perf/tests/hists_common.c               |    6 +-
> >  tools/perf/tests/hists_cumulate.c             |    4 +-
> >  tools/perf/tests/hists_output.c               |    2 +-
> >  tools/perf/tests/maps.c                       |   64 +-
> >  tools/perf/tests/symbols.c                    |    2 +-
> >  tools/perf/tests/thread-maps-share.c          |    8 +-
> >  tools/perf/tests/vmlinux-kallsyms.c           |  181 +--
> >  tools/perf/ui/browsers/annotate.c             |    6 +-
> >  tools/perf/ui/browsers/hists.c                |    8 +-
> >  tools/perf/ui/browsers/map.c                  |    4 +-
> >  tools/perf/util/Build                         |    1 +
> >  tools/perf/util/annotate.c                    |   44 +-
> >  tools/perf/util/auxtrace.c                    |    2 +-
> >  tools/perf/util/block-info.c                  |    2 +-
> >  tools/perf/util/bpf-event.c                   |   17 +-
> >  tools/perf/util/bpf-event.h                   |   12 +-
> >  tools/perf/util/bpf_lock_contention.c         |   10 +-
> >  tools/perf/util/build-id.c                    |  136 +-
> >  tools/perf/util/build-id.h                    |    2 -
> >  tools/perf/util/callchain.c                   |    4 +-
> >  tools/perf/util/comm.c                        |   10 +-
> >  tools/perf/util/compress.h                    |    6 +-
> >  tools/perf/util/data-convert-json.c           |    2 +-
> >  tools/perf/util/db-export.c                   |    6 +-
> >  tools/perf/util/debug.c                       |   22 +-
> >  tools/perf/util/debug.h                       |    1 +
> >  tools/perf/util/dlfilter.c                    |   12 +-
> >  tools/perf/util/dso.c                         |  468 ++++---
> >  tools/perf/util/dso.h                         |  544 ++++++--
> >  tools/perf/util/dsos.c                        |  529 ++++---
> >  tools/perf/util/dsos.h                        |   40 +-
> >  tools/perf/util/env.c                         |   53 +-
> >  tools/perf/util/env.h                         |    4 +
> >  tools/perf/util/event.c                       |   12 +-
> >  tools/perf/util/header.c                      |   47 +-
> >  tools/perf/util/hist.c                        |    4 +-
> >  tools/perf/util/intel-pt.c                    |   22 +-
> >  tools/perf/util/machine.c                     |  652 +++------
> >  tools/perf/util/machine.h                     |   32 +-
> >  tools/perf/util/map.c                         |   93 +-
> >  tools/perf/util/map.h                         |   83 +-
> >  tools/perf/util/maps.c                        | 1239 +++++++++++++----
> >  tools/perf/util/maps.h                        |   95 +-
> >  tools/perf/util/mmap.c                        |    5 +-
> >  tools/perf/util/mmap.h                        |    1 -
> >  tools/perf/util/pmu.c                         |   48 +-
> >  tools/perf/util/pmus.c                        |   30 +-
> >  tools/perf/util/probe-event.c                 |   62 +-
> >  tools/perf/util/rb_resort.h                   |    5 -
> >  .../scripting-engines/trace-event-python.c    |   21 +-
> >  tools/perf/util/session.c                     |   21 +
> >  tools/perf/util/session.h                     |    2 +
> >  tools/perf/util/sort.c                        |   19 +-
> >  tools/perf/util/srcline.c                     |   65 +-
> >  tools/perf/util/symbol-elf.c                  |  138 +-
> >  tools/perf/util/symbol.c                      |  521 ++-----
> >  tools/perf/util/symbol.h                      |    1 -
> >  tools/perf/util/symbol_fprintf.c              |    4 +-
> >  tools/perf/util/synthetic-events.c            |  156 ++-
> >  tools/perf/util/thread.c                      |   48 +-
> >  tools/perf/util/thread.h                      |    6 -
> >  tools/perf/util/threads.c                     |  186 +++
> >  tools/perf/util/threads.h                     |   35 +
> >  tools/perf/util/unwind-libunwind-local.c      |   50 +-
> >  tools/perf/util/unwind-libunwind.c            |    9 +-
> >  tools/perf/util/vdso.c                        |   89 +-
> >  tools/perf/util/zstd.c                        |   63 +-
> >  88 files changed, 4101 insertions(+), 2827 deletions(-)
> >  create mode 100644 tools/lib/api/io_dir.h
> >  create mode 100644 tools/perf/util/threads.c
> >  create mode 100644 tools/perf/util/threads.h
> >
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
