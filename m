Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37F76DA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjHBWCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjHBWCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:02:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF391FEF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:02:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so41941cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691013730; x=1691618530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQz3j/HHt2BjyChw+tL3/qGsF5Ut1X3dmU/am228B60=;
        b=4NevuPZ+Z4fT5OUwB+x9L7bro0iKHqiW4GaOBT3ml3++IN1GQxq7HfcFVHy6EIzoUS
         /3NC5OiFe4cLhpLYKwXeyeD6eNqZM4kQRAt6qpwO7JakJkyVEDtkv59l8zVBO9lY5B2F
         EfGN3bruUC7VWdtL22gysaXBczaAiVyJgqEH06/To+sEroBthpsHOsyIZs6Nwgj0g39B
         gEPyKg1Q5SXPJtAOIJaQET+cPTVefOc2tewX8B7BG3mHhxEHAEMKS3/qDiRoN+XtEYh/
         FDg91wUC009ouk08nBSQvRj8aYvGnswqGjwBMBto2zxQ0h+6rmSihGIHTe4H6o7jber8
         QRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013730; x=1691618530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQz3j/HHt2BjyChw+tL3/qGsF5Ut1X3dmU/am228B60=;
        b=hKde3GpkzWbr2wd8FSxVU3D9ddcB/UvfWdM9kgVZfQ4+qdc2ChqDh3MB4F15VamAlc
         CPKqaoNlm1BXiP8IXtN9T2fYd7CoMeiwqhzAGKPgV5kNY+WsOmBZ5JreiBzfeOnLrwlz
         CXwZbR+L2mmJNx7FzpKxWirlGSqkPtg5s+8AoC3w8++TkpTVtniMuuzo8QR++7Tpm/Qb
         4f3hP+EdmzMavVSkujhRvXMnD3SHAErQjTqQUktTn558LLslVkppVn0cnNSmUSG3SF2Z
         P04KRrE9frMlfFZ2Nk64fkG5EhGlgrXzb7ET8XOvz+AlccNMGu+10/aTd/koafnDj8Ep
         HM2g==
X-Gm-Message-State: ABy/qLZnun18nqHu/SNYulyqy5Vd7f6Y1wEWNjMjE4UoeRqtACzqAseG
        GaGhAO6BV1fFWBp5zQr8OB3mtRBA/b8SyPVCQcqEJG/o/pF8EuhWtc7wfQ==
X-Google-Smtp-Source: APBJJlEAKojX9uohWA6DFSYc+dD94zvTXnDvzQIRIYNA+zLVC1mw6U7cGdkj3ZtubdGdZe4ypY1wF0Ugi3+gcdyQZTw=
X-Received: by 2002:a05:622a:1a28:b0:40f:db89:5246 with SMTP id
 f40-20020a05622a1a2800b0040fdb895246mr624917qtb.21.1691013729740; Wed, 02 Aug
 2023 15:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230715035343.46737-1-leo.yan@linaro.org> <CAP-5=fVmBVA5XGac8BZks6UnjGaMv8bx_PhC6_YrWC2TGjw-Fg@mail.gmail.com>
 <20230802170038.GA1306442@leoy-huanghe.lan>
In-Reply-To: <20230802170038.GA1306442@leoy-huanghe.lan>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Aug 2023 15:01:57 -0700
Message-ID: <CAP-5=fUXtNqbDyYUXojPMmfz8ZK9-O7_Jfp8G9D5zWVB-_4eRw@mail.gmail.com>
Subject: Re: [PATCH v1] perf doc: Document ring buffer mechanism
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Wed, Aug 2, 2023 at 10:00=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Ian,
>
> On Mon, Jul 17, 2023 at 02:27:11PM -0700, Ian Rogers wrote:
>
> [...]
>
> > > Thanks Ian's suggestion for upstreaming this documentation into Linux
> > > source code tree at the Jan of this year, also thanks my son Rowan fo=
r
> > > correcting me some grammer errors in this summer holiday.  Finally I
> > > heavily refactored this documentation and I think it's ready for
> > > reviewing.
> >
> > This is awesome, thanks Leo for taking the time to do this! I've done
> > some readability nits
>
> Thanks a lot for review, Ian.
>
> I agreed with most of your comments.  Blow I just keep the comments for
> further discussion or give supplements, otherwise, I remove the rest
> comments and will reflect them in my new patch.
>
> [...]
>
> > > +Perf uses the same way to manage its ring buffer.  In implementation
> > > +there have two actors: a page contains a control structure and ring
> > > +buffer; the page containing the control structure is named as "user
> > > +page", the user page and the ring buffer are mapped into user space
> > > +with the continuous virtual address, since the user page and the rin=
g
> > > +buffer are consecutive, from the control structure pointer it's
> > > +easily to know the ring buffer address.
> >
> > nit: Perhaps reword a little as:
> > Perf uses the same way to manage its ring buffer. In the
> > implementation there are two key data structures held together in a
> > set of consecutive pages, the control structure and then the ring
> > buffer itself. The page with the control structure in is known as the
> > "user page". Being held in continuous virtual addresses simplifies
> > locating the ring buffer address, it is in the pages after the page
> > with the user page.
> >
> > Off-topic: seems wasteful to allocate a full page for this.
>
> Arm CPUs support not only 4KiB page size, but also support 16KiB/64KiB
> page size, it does waste a bit memory for using a page for control
> structure.  But given the control structure need to be mapped to user
> space in page size unit, seems here have no room to optimize it.
>
> [...]
>
> > > +        user page                          ring buffer
> > > +  +---------+---------+   +---------------------------------------+
> > > +  |data_head|data_tail|...|   |   |***|***|***|***|***|   |   |   |
> > > +  +---------+---------+   +---------------------------------------+
> > > +      `          `--------------^                   ^
> > > +       `--------------------------------------------|
> > > +
> > > +            * : the data is filled by the writer.
> > > +           Figure 2: Perf ring buffer
> > > +
> > > +When using 'perf record' tool, we can specify the ring buffer size w=
ith
> >
> > nit: s/using/using the/
> >
> > > +option '-m' or '--mmap-pages=3D', finally the size will be rounded u=
p to
> >
> > nit: s/finally the size/the given size/
> >
> > > +power of two with page unit.  Though the kernel allocates at once fo=
r
> >
> > nit: s/power of two with page unit/a power of two that is a multiple
> > of a page size/
> >
> > Off-topic-ish: Perhaps it is worth motivating why the page size must
> > be a power of 2. I'm guessing it is because this means that when
> > moving the pointers/indices they can be masked to cause wrapping,
> > rather than using division/modulus.
>
> Correct.  The comments in kernel/events/core.c verifies this guessing:
>
> "If we have rb pages ensure they're a power-of-two number, so we
> can do bitmasks instead of modulo."
>
> > Fwiw, I think this could also be
> > solved with a comparison, and the performance overhead could be
> > insignificant compared to the memory savings.
>
> I am not sure if a comparison is sufficient.  As you said, if the page
> number is not a power-of-two number, and page index increases
> monotonically, we need to compute modulus to get the offset.
>
> Agreed with you, we can consider to remove the limitaion of the page
> number must be power-of-two for memory saving and check what's the
> performance penalty.
>
> > > +all memory pages, it's deferred to map the pages to VMA area until
> > > +the perf tool accesses the buffer from the user space.  In other wor=
ds,
> > > +at the first time accesses the buffer's page from user space in the =
perf
> > > +tool, a data abort exception for page fault is taken and the kernel
> > > +uses this occasion to map the page into process VMA, thus the perf t=
ool
> > > +can continue to access the page after returning from exception.
> >
> > nit: s/exception/the exception/
> >
> > Off topic: Should the perf tool use something like the MAP_POPULATE
> > flag to reduce page faults, given the pages were allocated already in
> > the kernel? Tweaking tools/lib/perf/mmap.c to do this and running
> > "time perf record -a sleep 1" shows the minor page fault count going
> > from 7700 to 9700, so it seems like a bad idea.
>
> Hmm ... I got the opposite result, by observing page fault counting, I
> can see the improvement with adding the MAP_POPULATE flag.
>
> Before adding MAP_POPULATE flag:
>
>   # ./perf stat -- ./perf record -a sleep 1
>
>     5,359      page-faults                      #    2.409 K/sec
>     5,353      page-faults                      #    2.415 K/sec
>     5,353      page-faults                      #    2.425 K/sec
>
>   # ./perf stat -- ./perf record -e cs_etm/@tmc_etr0/ -a sleep 1
>
>     2,122      page-faults                      #    2.038 K/sec
>     2,121      page-faults                      #    2.001 K/sec
>     2,121      page-faults                      #    2.015 K/sec
>
> After adding MAP_POPULATE flag:
>
>   # ./perf stat -- ./perf record -a sleep 1
>
>     5,004      page-faults                      #    2.260 K/sec
>     5,002      page-faults                      #    2.253 K/sec
>     5,003      page-faults                      #    2.239 K/sec
>
>   # ./perf stat -- ./perf record -e cs_etm/@tmc_etr0/ -a sleep 1
>
>     1,082      page-faults                      #  856.589 /sec
>     1,082      page-faults                      #    1.002 K/sec
>     1,080      page-faults                      #    1.013 K/sec
>
> [...]

Interesting, I wonder if it is an ARM vs x86 difference?

> > > +System wide mode
> > > +
> > > +By default if without specifying mode, or explicitly using option '=
=E2=80=93a'
> > > +or '=E2=80=93=E2=80=93all=E2=80=93cpus', perf collects samples on al=
l CPUs in the system wide
> > > +mode.
> > > +
> > > +In this mode, every CPU has its own ring buffer; all threads are
> > > +monitored during the running state and the samples are recorded into=
 the
> >
> > This doesn't cover the case of:
> > $ perf record benchmark
> > Where there will be a ring buffer on every CPU but events/sampling
> > will only be enabled for benchmark's threads, ie not all threads.
>
> Correct.  I wrongly thought it's the system-wide mode when don't
> specify option '-a', will add a 'default mode' to address above case.
>
> [...]
>
> > > When a sample is recorded into the ring buffer, the kernel event
> > > +core layer will wake up the perf process to read samples from the ri=
ng
> > > +buffer.
> >
> > It isn't always necessary to wake the perf tool process. There is a
> > little bit more detail on different polling modes in the
> > perf_event_open man page in the section on "Overflow handling":
> > https://github.com/mkerrisk/man-pages/blob/master/man2/perf_event_open.=
2#L3062
>
> Exactly, perf ring buffer uses watermark as threshold, and only when
> cross the threshold the kernel notifies the user space.  I confirmed
> this in the function __perf_output_begin().
>
> So will rephrase as:
>
> "When a sample is recorded into the ring buffer, and the number of
> samples crossing the threshold, the kernel event core layer will wake up
> the perf process to read samples from the ring buffer."

Sounds good.

> > > +
> > > +                     Perf
> > > +                     / | Read samples
> > > +           Polling  /  `--------------|               Ring buffer
> > > +                   v                  v    ;-------------------v
> > > +  +----------------+     +---------+---------+   +------------------=
-+
> > > +  |Event wait queue|     |data_head|data_tail|   |***|***|   |   |**=
*|
> > > +  +----------------+     +---------+---------+   +------------------=
-+
> > > +           ^                  ^ `----------------------^
> > > +           | Wake up tasks    | Store samples
> > > +        +-----------------------------+
> > > +       |  Kernel event core layer    |
> > > +        +-----------------------------+
> > > +
> > > +            * : the data is filled by the writer.
> > > +           Figure 6: Writing and reading the ring buffer
> > > +
> > > +Because multiple events might share the same ring buffer for recordi=
ng
> > > +samples, when any event sample is stored into the ring buffer, the
> > > +kernel event core layer iterates every event associated to the ring
> > > +buffer and wake up tasks on the wait queue of the events.  This is
> > > +fulfilled by the kernel function ring_buffer_wakeup().
> >
> > I'm not sure about the use of "event" here. If you do:
> > $ perf stat -e "cycles,instructions"
> > Then cycles and instructions will each have a ring buffer, I'm not
> > sure it is possible to get them to share a ring buffer. I think here
> > you may be referring to side band events, like mmap2.
>
> Seems to me, this is incorrect.  Since 'perf stat' only read counters
> (via the kernel function perf_read()), it doesn't allocate ring buffer
> at all for events.  By using GDB, I can confirm the function
> perf_mmap__mmap() is never called for 'perf stat' command.
>
> Just clarify, 'perf stat' still mmap the 'user page' for control
> structure and for timer counter accessing, but this is not the same
> thing with ring buffer.

Sorry, I meant record not stat.

> [...]
>
> > > +In Linux kernel, the event core layer uses the structure perf_buffer=
 to
> > > +track the buffer=E2=80=99s latest header, and it keeps the informati=
on for
> > > +buffer pages.  The structure perf_buffer manages ring buffer during =
its
> > > +life cycle, it is allocated once the ring buffer is created and rele=
ased
> > > +when the ring buffer is destroyed.
> > > +
> > > +It=E2=80=99s possible for multiple events to write buffer concurrent=
ly.  For
> > > +instance, a software event and a hardware PMU event both are enabled=
 for
> > > +profiling, when the software event is in the middle of sampling, the
> > > +hardware event maybe be overflow and its interrupt is triggered in t=
his
> > > +case.  This leads to the race condition for updating perf_buffer::he=
ad.
> > > +In __perf_output_begin(), Linux kernel uses compare-and-swap atomici=
ty
> > > +local_cmpxchg() to implement the lockless algorithm for protecting
> > > +perf_buffer::head.
> >
> > In the case of:
> > $ perf record -e "instructions,faults"
> > faults is a software event but it won't share the ring buffer with
> > instructions. I think the atomicity exists for the side band events.
>
> I verified on my Arm64 board and confirmed that hardware events
> (instructions, cycles) share the same ring buffer with software event
> (faults).  Below is the captured log (truncated for more readable):
>
>   ...
>   =3D> __perf_sw_event
>   =3D> do_page_fault
>   =3D> do_translation_fault
>   ...
>   ls-884     [003] ...2.   253.737217: perf_output_begin_forward: __perf_=
output_begin: rb=3D00000000720bac97 page=3D0 offset=3D1688 addr=3D000000001=
9392296 size=3D2408
>
>   ...
>   =3D> __perf_event_overflow
>   =3D> perf_event_overflow
>   =3D> armv8pmu_handle_irq
>   ...
>   ls-884     [003] d.h1.   253.737247: perf_output_begin_forward: __perf_=
output_begin: rb=3D00000000720bac97 page=3D0 offset=3D1736 addr=3D000000009=
e259b5a size=3D2360
>
> We can see for both software event and Armv8 PMU event, both use the
> same rb pointer (0x00000000720bac9), which means the software and
> hardware events store samples into the same ring buffer.  Thus the
> above description is valid.
>
> P.s. maybe the side band events are not a relevant topic, but I can
> see the side band events have dedicated ring buffer.

You're right, the code doing this is using ioctls in particular
PERF_EVENT_IOC_SET_OUTPUT:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n517
The man page mentions "PERF_FLAG_FD_OUTPUT (broken since Linux
2.6.35)" which had confused me.

Thanks,
Ian

> Thanks,
> Leo
