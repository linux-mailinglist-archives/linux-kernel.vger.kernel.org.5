Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38097756EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGQV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGQV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:27:28 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD2126
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:27:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403f21d3c2dso34041cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689629244; x=1692221244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKdlOHDa4fEHl29V1QTlvk5W+YWKwsKmFrds0ThRdHc=;
        b=042A08V+lJJ/1Q65TMGmvVeBrlm0C1SUfq4uxzZUzCFkwFVeUP0rKffHbctf6gJbgD
         mmTHErTQr9wWphFY6Wwa+e/v+awtV3BvpICOj0wU3iEr+QWINDzvGoY5JSjefSRdlyqY
         VW+kFDm5NSXNTPYMx+0gCtNgQzoqFBuw7oxY+wzHB8NWhTYUCDzWF5Ed1uwzVEGx+ppk
         mtKGvSU22rjRkkf952i6g03ck7DG6um0OxdoIFZ1Iq0PXN5dzsAB5CoI26Q9hUiBaJC3
         B4kWN5FdLkIgubsHpAFUGNJ9yyVX2ceg+Fj6eGlMSzqyvzjFg4AExoSyj53+qIRdNBze
         LTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689629244; x=1692221244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKdlOHDa4fEHl29V1QTlvk5W+YWKwsKmFrds0ThRdHc=;
        b=JHxHMpzE6lCFW0JdHE0xWgbPBgmIwKCUPiL7ols5b74qnoxGQ+wiGM0HrKui4XvfNE
         9aAB40koy1baTgicUmFECVEN5rlQ9XzblaEcLvJyZ7dd5eDWXSUHUpL0bQjMo/m+VhFk
         wH/AwQLxUEKj/gaRAZEBWk0GIRp4FCFsROjPp/iRL9BlzODur5ZTu5JqgMYQzq9WImvg
         IqoWgVYnE/rcAkrMQARsvpMrqcF/BtM7Kgow2VVVhkilyLBgX1qViJjVM3Oc1B7aU0YU
         jVIhNWWdlKCkR9iS/4JAaGOUbYDjfVrNEDZxtvtQ2OLo6R+kjTjx9AcZQz6QbIFgbiXi
         Prcg==
X-Gm-Message-State: ABy/qLb3cXqFIpi6/StzA0IGxOdqgW7SBhkRBwM/GxKg++4TwcAcwP3z
        cp3c11axh0DyV4zaTUMbemHiBh4VVfH6927kpH/15A==
X-Google-Smtp-Source: APBJJlFfxS+YUIGc47g6ZqJz2jUCBEeXln1VMEvCSVAx3HE9vxLrqfTf7oQb5Gzy8zofH2txMam8jYHs2BFxh+o18Ws=
X-Received: by 2002:ac8:7d8c:0:b0:3e0:c2dd:fd29 with SMTP id
 c12-20020ac87d8c000000b003e0c2ddfd29mr87154qtd.4.1689629243354; Mon, 17 Jul
 2023 14:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230715035343.46737-1-leo.yan@linaro.org>
In-Reply-To: <20230715035343.46737-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jul 2023 14:27:11 -0700
Message-ID: <CAP-5=fVmBVA5XGac8BZks6UnjGaMv8bx_PhC6_YrWC2TGjw-Fg@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:53=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote:
>
> In the Linux perf tool, the ring buffer serves not only as a medium for
> transferring PMU event data but also as a vital mechanism for hardware
> tracing using technologies like Intel PT and Arm CoreSight, etc.
>
> Consequently, the ring buffer mechanism plays a crucial role by ensuring
> high throughput for data transfer between the kernel and user space
> while avoiding excessive overhead caused by the ring buffer itself.
>
> This commit documents the ring buffer mechanism in detail.  It provides
> an in-depth explanation of the implementation of both the generic ring
> buffer and the AUX ring buffer.  Additionally, it covers how these ring
> buffers support various tracing modes and explains the synchronization
> with memory barriers.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>
> Thanks Ian's suggestion for upstreaming this documentation into Linux
> source code tree at the Jan of this year, also thanks my son Rowan for
> correcting me some grammer errors in this summer holiday.  Finally I
> heavily refactored this documentation and I think it's ready for
> reviewing.

This is awesome, thanks Leo for taking the time to do this! I've done
some readability nits

>  tools/perf/Documentation/perf-ring-buffer.txt | 663 ++++++++++++++++++
>  1 file changed, 663 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-ring-buffer.txt
>
> diff --git a/tools/perf/Documentation/perf-ring-buffer.txt b/tools/perf/D=
ocumentation/perf-ring-buffer.txt
> new file mode 100644
> index 000000000000..15c191c04498
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-ring-buffer.txt
> @@ -0,0 +1,663 @@
> +perf-ring-buffer(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +perf-ring-buffer - Introduction for perf ring buffer mechanism

nit: s/for/to the/

> +
> +Introduction
> +------------
> +Ring buffer is a fundamental mechanism for data transferring.  perf uses

nit: s/Ring/The ring/
nit: s/transferring/transfer/

> +ring buffer to transfer event data from kernel to user space, another

nit: s/buffer/buffers/

> +kind of ring buffer which is so called auxiliary (AUX) ring buffer also
> +plays an important role for hardware tracing with Intel PT, Arm
> +CoreSight, etc.
> +
> +The ring buffer implementation is critical but it's also a very challeng=
e

nit: s/challenge/challenging/

> +work.  On one hand, the kernel and perf tool in the user space use the

nit: s/one/the one/

> +ring buffer to exchange data and stores data into data file, thus the
> +ring buffer needs to transfer data with high throughput; on the other
> +hand, the ring buffer management should avoid significant overload to
> +distract profiling results.
> +
> +This documentation dives into the details for perf ring buffer with two
> +parts: firstly it explains the perf ring buffer implementation, then in
> +the second part discusses the AUX ring buffer mechanism.
> +
> +Ring buffer implementation
> +--------------------------
> +
> +Basic algorithm
> +~~~~~~~~~~~~~~~
> +
> +That said, a typical ring buffer is managed by a head pointer and a tail
> +pointer; the head pointer is manipulated by a writer and the tail
> +pointer is updated by a reader respectively.
> +
> +            +---------------------------+
> +            |   |   |***|***|***|   |   |
> +            +---------------------------+
> +                  `-> Tail    `-> Head
> +
> +            * : the data is filled by the writer.
> +           Figure 1: Ring buffer
> +
> +Perf uses the same way to manage its ring buffer.  In implementation
> +there have two actors: a page contains a control structure and ring
> +buffer; the page containing the control structure is named as "user
> +page", the user page and the ring buffer are mapped into user space
> +with the continuous virtual address, since the user page and the ring
> +buffer are consecutive, from the control structure pointer it's
> +easily to know the ring buffer address.

nit: Perhaps reword a little as:
Perf uses the same way to manage its ring buffer. In the
implementation there are two key data structures held together in a
set of consecutive pages, the control structure and then the ring
buffer itself. The page with the control structure in is known as the
"user page". Being held in continuous virtual addresses simplifies
locating the ring buffer address, it is in the pages after the page
with the user page.

Off-topic: seems wasteful to allocate a full page for this.

> +
> +The control structure is named as `perf_event_mmap_page`, it contains a
> +head pointer `data_head` and a tail pointer `data_tail`.  When kernel

nit: s/kernel/the kernel/

> +starts to fill records into the ring buffer, it updates the head pointer
> +to reserve the memory so later can safely store events into the buffer;

nit: s/later can/later it can/

> +on the other side, the perf tool updates the tail pointer after consumes

nit: s/consume/consuming/

> +data from the ring buffer.
> +
> +        user page                          ring buffer
> +  +---------+---------+   +---------------------------------------+
> +  |data_head|data_tail|...|   |   |***|***|***|***|***|   |   |   |
> +  +---------+---------+   +---------------------------------------+
> +      `          `--------------^                   ^
> +       `--------------------------------------------|
> +
> +            * : the data is filled by the writer.
> +           Figure 2: Perf ring buffer
> +
> +When using 'perf record' tool, we can specify the ring buffer size with

nit: s/using/using the/

> +option '-m' or '--mmap-pages=3D', finally the size will be rounded up to

nit: s/finally the size/the given size/

> +power of two with page unit.  Though the kernel allocates at once for

nit: s/power of two with page unit/a power of two that is a multiple
of a page size/

Off-topic-ish: Perhaps it is worth motivating why the page size must
be a power of 2. I'm guessing it is because this means that when
moving the pointers/indices they can be masked to cause wrapping,
rather than using division/modulus. Fwiw, I think this could also be
solved with a comparison, and the performance overhead could be
insignificant compared to the memory savings.

> +all memory pages, it's deferred to map the pages to VMA area until
> +the perf tool accesses the buffer from the user space.  In other words,
> +at the first time accesses the buffer's page from user space in the perf
> +tool, a data abort exception for page fault is taken and the kernel
> +uses this occasion to map the page into process VMA, thus the perf tool
> +can continue to access the page after returning from exception.

nit: s/exception/the exception/

Off topic: Should the perf tool use something like the MAP_POPULATE
flag to reduce page faults, given the pages were allocated already in
the kernel? Tweaking tools/lib/perf/mmap.c to do this and running
"time perf record -a sleep 1" shows the minor page fault count going
from 7700 to 9700, so it seems like a bad idea.

> +
> +The function perf_mmap_fault() is for handling page fault, which invokes

nit: s/handling page/handling the page/

> +perf_mmap_to_page() to figure out which page should be mapped.  The
> +structure 'vm_fault' has a field 'pgoff' to indicate which page should
> +be mapped, if 'pgoff' is zero it maps the ring buffer's user page,
> +otherwise, the ring buffer's page is mapped with index 'pgoff-1' (since
> +the first page in VMA is for user page, so we need to decrease 1 to get
> +the ring buffer's page index).
> +
> +Ring buffer for different tracing modes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Perf profiles programs with different modes: per thread mode, per cpu
> +mode, and system wide mode.  This section describes what's these modes
> +and how the ring buffer meets requirements for them.  At last we will
> +review the race conditions caused by these modes.
> +
> +Per-thread mode
> +
> +By specifying option '--per-thread' in perf command, the ring buffer is
> +allocated for every profiled thread.  In this mode, a profiled thread is
> +scheduled on a CPU, the events on that CPU will be enabled; and if the
> +thread is scheduled out from the CPU, the events on the CPU will be
> +disabled.  When the thread is migrated from one CPU to another, the
> +events will be disabled on the previous CPU and enabled on the next CPU
> +correspondingly.
> +
> +            T0                                         T1
> +          +----+                                     +----+
> +  CPU0    |xxxx|                                     |xxxx|
> +          +----+-------------------------------------+----+-------->
> +            |    T1                                    |
> +            |  +-----+                                 |
> +  CPU1      |  |xxxxx|                                 |
> +          --|--+-----+---------------------------------|----------->
> +            |     |                   T1               |
> +            |     |                 +----+             |
> +  CPU2      |     |                 |xxxx|             |
> +          --|-----|-----------------+----+-------------|----------->
> +            |     |         T1        |                |
> +            |     |  +--------------+ |                |
> +  CPU3      |     |  |xxxxxxxxxxxxxx| |                |
> +          --|-----|--+--------------+-|----------------|----------->
> +            |     |         |         |                |
> +            v     v         v         v                v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer                        |
> +          +-----------------------------------------------------+
> +
> +           T1: Thread 1
> +           x: Thread is in running state
> +           Figure 3: Ring buffer for per-thread mode
> +
> +When perf runs in per-thread mode, a ring buffer is allocated for the
> +profiled thread T1.  The ring buffer is dedicated for thread T1, if the
> +thread T1 is running, the perf events will be recorded into the ring
> +buffer; when the thread is sleeping, all associated events will be
> +disabled, thus no any trace data will be recorded into the ring buffer.

nit: s/no any/no/

> +
> +Per-CPU mode
> +
> +The option '-C' is used to collect samples on the list of CPUs, the ring
> +buffers are allocated for the specified CPUs.  For the example in below
> +figure, the perf command receives option '-C 0,2', as the result, two
> +ring buffers serve CPU0 and CPU2 separately.
> +
> +            T0                      T2                 T1
> +          +----+              +-----------+          +----+
> +  CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> +          +----+--------------+-----------+----------+----+-------->
> +            |                       |                  |
> +            v                       v                  v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 0                      |
> +          +-----------------------------------------------------+
> +
> +                 T1
> +               +-----+
> +  CPU1         |xxxxx|
> +          -----+-----+--------------------------------------------->
> +
> +                                      T1              T3
> +                                    +----+        +-------+
> +  CPU2                              |xxxx|        |xxxxxxx|
> +          --------------------------+----+--------+-------+-------->
> +                                      |               |
> +                                      v               v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 1                      |
> +          +-----------------------------------------------------+
> +
> +                            T1
> +                     +--------------+
> +  CPU3               |xxxxxxxxxxxxxx|
> +          -----------+--------------+------------------------------>
> +
> +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> +           x: Thread is in running state
> +           Figure 4: Ring buffer for per-CPU mode
> +
> +In above example, even there have tasks running on CPU1 and CPU3, since
> +the ring buffer is absent for them, any activities on these two CPUs
> +will be ignored.  A usage case is to combine the options for per-thread
> +mode and per-CPU mode, e.g. the options '=E2=80=93C 0,2' and '=E2=80=93=
=E2=80=93per=E2=80=93thread' are
> +specified together, the samples are recorded only when the profiled
> +thread is scheduled on any of the listed CPUs.
> +
> +System wide mode
> +
> +By default if without specifying mode, or explicitly using option '=E2=
=80=93a'
> +or '=E2=80=93=E2=80=93all=E2=80=93cpus', perf collects samples on all CP=
Us in the system wide
> +mode.
> +
> +In this mode, every CPU has its own ring buffer; all threads are
> +monitored during the running state and the samples are recorded into the

This doesn't cover the case of:
$ perf record benchmark
Where there will be a ring buffer on every CPU but events/sampling
will only be enabled for benchmark's threads, ie not all threads.

> +ring buffer belonging to the CPU which the events occurred on.
> +
> +            T0                      T2                 T1
> +          +----+              +-----------+          +----+
> +  CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> +          +----+--------------+-----------+----------+----+-------->
> +            |                       |                  |
> +            v                       v                  v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 0                      |
> +          +-----------------------------------------------------+
> +
> +                 T1
> +               +-----+
> +  CPU1         |xxxxx|
> +          -----+-----+--------------------------------------------->
> +                  |
> +                  v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 1                      |
> +          +-----------------------------------------------------+
> +
> +                                      T1              T3
> +                                    +----+        +-------+
> +  CPU2                              |xxxx|        |xxxxxxx|
> +          --------------------------+----+--------+-------+-------->
> +                                      |               |
> +                                      v               v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 2                      |
> +          +-----------------------------------------------------+
> +
> +                            T1
> +                     +--------------+
> +  CPU3               |xxxxxxxxxxxxxx|
> +          -----------+--------------+------------------------------>
> +                            |
> +                            v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 3                      |
> +          +-----------------------------------------------------+
> +
> +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> +           x: Thread is in running state
> +           Figure 5: Ring buffer for system wide mode
> +
> +Accessing buffer
> +~~~~~~~~~~~~~~~~
> +
> +Base on the understanding of how the ring buffer is allocated in various

nit: s/Base/Based/

> +modes, this section will explain the accessing the ring buffer.
> +
> +Producer-consumer model
> +
> +In the Linux kernel, the PMU events can produce samples which are stored
> +into the ring buffer; the perf in user space consumes the samples by

nit: s/perf/perf command/

> +reading out data from the ring buffer and finally save the data into the

nit: s/save/saves/

> +file for post analysis.  It=E2=80=99s a typical producer-consumer model =
for
> +using the ring buffer.
> +
> +Perf process polls on the PMU events and sleeps when no any incoming

nit: s/Perf/The perf/
nit: s/no any incoming events/no events are incoming/

> +events.  When a sample is recorded into the ring buffer, the kernel even=
t
> +core layer will wake up the perf process to read samples from the ring
> +buffer.

It isn't always necessary to wake the perf tool process. There is a
little bit more detail on different polling modes in the
perf_event_open man page in the section on "Overflow handling":
https://github.com/mkerrisk/man-pages/blob/master/man2/perf_event_open.2#L3=
062

> +
> +                     Perf
> +                     / | Read samples
> +           Polling  /  `--------------|               Ring buffer
> +                   v                  v    ;-------------------v
> +  +----------------+     +---------+---------+   +-------------------+
> +  |Event wait queue|     |data_head|data_tail|   |***|***|   |   |***|
> +  +----------------+     +---------+---------+   +-------------------+
> +           ^                  ^ `----------------------^
> +           | Wake up tasks    | Store samples
> +        +-----------------------------+
> +       |  Kernel event core layer    |
> +        +-----------------------------+
> +
> +            * : the data is filled by the writer.
> +           Figure 6: Writing and reading the ring buffer
> +
> +Because multiple events might share the same ring buffer for recording
> +samples, when any event sample is stored into the ring buffer, the
> +kernel event core layer iterates every event associated to the ring
> +buffer and wake up tasks on the wait queue of the events.  This is
> +fulfilled by the kernel function ring_buffer_wakeup().

I'm not sure about the use of "event" here. If you do:
$ perf stat -e "cycles,instructions"
Then cycles and instructions will each have a ring buffer, I'm not
sure it is possible to get them to share a ring buffer. I think here
you may be referring to side band events, like mmap2.

> +
> +After perf process is woken up, it starts to check the ring buffers one

nit: s/perf/the perf/

> +by one, if finds any ring buffer contains samples it will read out the

nit: s/if finds/if it finds/

> +samples for statistics or saving into the data file.  Given the perf
> +process is possible to run on any CPUs, this leads to the ring buffer

nit: s/possible/able/
nit: s/CPUs/CPU/

> +can be accessed from multiple CPUs simultaneously, which causes race

nit: s/can be/potentially being/

> +conditions.  The race condition handling is described in the section
> +"Reading samples from buffer".
> +
> +Writing samples into buffer
> +
> +When a hardware event counter is overflow, a sample will be taken and

nit: s/is overflow/overflows/

> +saved into the ring buffer; the function __perf_event_output() is used
> +to fill samples into the ring buffer, it calls below sub functions:

nit: s/below/the below/

> +
> +- The sub function perf_prepare_sample() prepares sample fields based on
> +  the sample type;
> +- output_begin() is a function pointer, it=E2=80=99s passed dynamically =
via the
> +  argument for different writing directions, its purpose is to prepare
> +  the info for writing ring buffer, when the function returns back the
> +  ring buffer info is stored in structure perf_output_handle;
> +- perf_output_sample() outputs the sample into the ring buffer;
> +- perf_output_end() updates the head pointer for user page so perf tool
> +  can see the latest value.
> +
> +Let=E2=80=99s examine output_begin() in detail.  As the ring buffer allo=
ws
> +writing in two directions: backward or forward, the function pointer for
> +output_begin() is assigned according to the writing type of the buffer,
> +it can be perf_output_begin_forward() or perf_output_begin_backward().
> +
> +In the case of the backward ring buffer, where the user page is mapped
> +without =E2=80=99PROT_WRITE=E2=80=99, the tool in user space is unable t=
o update the
> +tail pointer.  As a result, only the head pointer is accessed in this
> +scenario, and the tail pointer is not used in perf tool.  The head
> +pointer indicates the beginning of a sample, perf tool can read out the
> +samples one by one based on sample=E2=80=99s event size.
> +
> +Alternatively, the forward ring buffer uses both head pointer and tail
> +pointer for the buffer management.  This method is more commonly used in
> +perf tool, to simplify the description, the following explanation
> +focuses on the forward ring buffer.
> +
> +    struct perf_output_handle       /---->  struct perf_buffer
> +  +---------------------------+     |     +--------------------+
> +  |           *rb;            |-----|     |   local_t head;    |
> +  +---------------------------+           +--------------------+
> +  |        int page;          |           |    *user_page;     |
> +  +---------------------------+           +--------------------+
> +  |       void *addr;         |                      |
> +  +---------------------------+                      v
> +  |   unsigned long size;     |         struct perf_event_mmap_page
> +  +---------------------------+           +--------------------+
> +                                          |   __u64 data_head; |
> +                                          +--------------------+
> +                                          |   __u64 data_tail; |
> +                                          +--------------------+
> +
> +           Figure 7: Data structures for writing ring buffer
> +
> +In Linux kernel, the event core layer uses the structure perf_buffer to
> +track the buffer=E2=80=99s latest header, and it keeps the information f=
or
> +buffer pages.  The structure perf_buffer manages ring buffer during its
> +life cycle, it is allocated once the ring buffer is created and released
> +when the ring buffer is destroyed.
> +
> +It=E2=80=99s possible for multiple events to write buffer concurrently. =
 For
> +instance, a software event and a hardware PMU event both are enabled for
> +profiling, when the software event is in the middle of sampling, the
> +hardware event maybe be overflow and its interrupt is triggered in this
> +case.  This leads to the race condition for updating perf_buffer::head.
> +In __perf_output_begin(), Linux kernel uses compare-and-swap atomicity
> +local_cmpxchg() to implement the lockless algorithm for protecting
> +perf_buffer::head.

In the case of:
$ perf record -e "instructions,faults"
faults is a software event but it won't share the ring buffer with
instructions. I think the atomicity exists for the side band events.

> +
> +The structure perf_output_handle serves as a temporary context for
> +tracking the information related to the buffer.  For instance, the
> +perf_output_handle::rb field points to the global perf_buffer structure.
> +Additionally, the perf_output_handle::addr field, based on the lockless
> +algorithm, specifies the destination address where the sample data is to
> +be stored.
> +
> +The advantages of the perf_output_handle structure is that it enables
> +concurrent writing to the buffer by different events.  For the previous
> +example, two instances of perf_output_handle serve as separate contexts
> +for software events and hardware events.  This allows each event to
> +reserve its own memory space within the out_begin() function, and
> +perf_output_handle::addr is used for populating the specific event.
> +
> +Once the sample data has been successfully stored in the buffer, the
> +header of the ring buffer is synced from perf_buffer::head to
> +perf_event_mmap_page::data_head, which is fulfilled in the function
> +perf_output_end().  This synchronization indicates to the perf tool that
> +it is now safe to read the newly added samples from the user space.
> +
> +Reading samples from buffer
> +
> +In the user space, perf tool utilizes the perf_event_mmap_page structure

nit: s/perf/the perf/

> +to handle the head and tail of the buffer.  It also uses perf_mmap
> +structure to keep track of a context for the ring buffer, this context
> +includes information about the buffer's starting and ending addresses.
> +Additionally, the mask value can be utilized to compute the circular
> +buffer pointer even for an overflow.
> +
> +Similar to the kernel, the perf tool in the user space firstly reads
> +out the recorded data from the ring buffer, and then updates the
> +buffer's tail pointer perf_event_mmap_page::data_tail.
> +
> +Memory synchronization
> +
> +The modern CPUs with relaxed memory model cannot promise the memory
> +ordering, this means it=E2=80=99s possible to access the ring buffer and=
 the
> +perf_event_mmap_page structure out of order.  To assure the specific
> +sequence for memory accessing perf ring buffer, memory barriers are
> +used to assure the data dependency.  The rationale for the memory
> +synchronization is as below:
> +
> +  Kernel                          User space
> +
> +  if (LOAD ->data_tail) {         LOAD ->data_head
> +                   (A)            smp_rmb()        (C)
> +    STORE $data                   LOAD $data
> +    smp_wmb()      (B)            smp_mb()         (D)
> +    STORE ->data_head             STORE ->data_tail
> +  }
> +
> +The comments in tools/include/linux/ring_buffer.h gives nice description
> +for why and how to use memory barriers, here we will just provide an
> +alternative explanation:
> +
> +(A) is a control dependency so that CPU assures order between checking
> +pointer perf_event_mmap_page::data_tail and filling sample into ring
> +buffer;
> +
> +(D) pairs with (A).  (D) separates the ring buffer data reading from
> +writing the pointer data_tail, perf tool firstly consumes samples and
> +then tells the kernel that the data chunk has been released.  Since
> +a reading operation is followed by a writing operation, thus (D) is a
> +full memory barrier.
> +
> +(B) is a writing barrier in the middle of two writing operations, which
> +makes sure that recording a sample must be prior to updating the head
> +pointer.
> +
> +(C) pairs with (B).  (C) is a read memory barrier to ensure the head
> +pointer is fetched before reading samples.
> +
> +To implement the above algorithm, the perf_output_put_handle() function
> +in the kernel and two helpers ring_buffer_read_head() and
> +ring_buffer_write_tail() in the user space are introduced, they rely
> +on memory barriers as described above to ensure the data dependency.
> +
> +Some architectures support one-way permeable barrier with load-acquire
> +and store-release operations, these barriers are more relaxed with less
> +performnace penalty, so (C) and (D) can be optimized to use barriers

nit: s/performnace/performance/

> +smp_load_acquire() and smp_store_release() respectively.
> +
> +If an architecture doesn=E2=80=99t support load-acquire and store-releas=
e in its
> +memory model, it will roll back to the old fashion of memory barrier
> +operations.  In this case, smp_load_acquire() encapsulates READ_ONCE() +
> +smp_mb(), since smp_mb() is costly, ring_buffer_read_head() doesn't
> +invoke smp_load_acquire() and it uses the barrieres READ_ONCE() +

nit: s/barrieres/barriers/

> +smp_rmb() instead.
> +

Again, this is great! I got this far before and will follow up with
more comments, but I wanted to send out what I had review wise.

Thanks!
Ian

> +The mechanism of AUX ring buffer
> +--------------------------------
> +
> +In this chapter, we will explain the implementation of the AUX ring
> +buffer.  In the first part it will discuss the connection between the
> +AUX ring buffer and the generic ring buffer, then the second part will
> +examine how the AUX ring buffer co-works with the generic ring buffer,
> +as well as the additional features introduced by the AUX ring buffer for
> +the sampling mechanism.
> +
> +The relationship between AUX and generic ring buffers
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Generally, the AUX ring buffer is an auxiliary for the generic ring
> +buffer.  The generic ring buffer is primarily used to store the event
> +samples, and every event fromat complies with the definition in the
> +union perf_event; the AUX ring buffer is for recording the hardware
> +trace data, and the trace data format is hardware IP dependent.  The
> +advantage of the AUX ring buffer is that it can de-couple the data
> +transferring between the generic perf events and the hardware tracing.
> +
> +The AUX ring buffer reuses the same algorithm with the generic ring
> +buffer for the buffer management.  The control structure
> +perf_event_mmap_page extends the new fields aux_head and aux_tail for
> +the head and tail pointers of the AUX ring buffer.
> +
> +During the AUX trace initialisation, record_opts::auxtrace_mmap_pages
> +is set for the AUX buffer size in page unit, otherwise, this option is
> +the default value '0' which means a perf session is not attached to any
> +AUX trace.
> +
> +When record_opts::auxtrace_mmap_pages is a non-zero value, the
> +auxtrace_mmap__mmap() function invokes rb_alloc_aux() in the kernel for
> +allocating kernel pages; these pages will be deferred to map into VMA
> +when handling the page fault, which is the same lazy mechanism with the
> +generic ring buffer.
> +
> +The AUX event and AUX trace data are two different things.  Likewise the
> +PMU events, the AUX event will be saved into the generic ring buffer
> +while the AUX trace data is stored in the AUX ring buffer.  As a result,
> +the generic ring buffer and the AUX ring buffer are allocated in pairs,
> +even if only one hardware trace event is enabled.
> +
> +Now let's see the AUX ring buffer deployment in the perf modes.  For
> +per-thread mode, perf tool allocates only one generic ring buffer and on=
e
> +AUX ring buffer for the whole session; for the system wide mode, perf
> +allocates the generic ring buffer and the AUX ring buffer per CPU wise.
> +
> +The below figure demonstrates the buffers' layout in the system wide
> +mode; if there are any activities on one CPU, the AUX event samples and
> +the hardware trace data will be recorded into the dedicated buffers for
> +the CPU.
> +
> +            T0                      T2                 T1
> +          +----+              +-----------+          +----+
> +  CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> +          +----+--------------+-----------+----------+----+-------->
> +            |                       |                  |
> +            v                       v                  v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 0                      |
> +          +-----------------------------------------------------+
> +            |                       |                  |
> +            v                       v                  v
> +          +-----------------------------------------------------+
> +          |               AUX Ring buffer 0                     |
> +          +-----------------------------------------------------+
> +
> +                 T1
> +               +-----+
> +  CPU1         |xxxxx|
> +          -----+-----+--------------------------------------------->
> +                  |
> +                  v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 1                      |
> +          +-----------------------------------------------------+
> +                  |
> +                  v
> +          +-----------------------------------------------------+
> +          |               AUX Ring buffer 1                     |
> +          +-----------------------------------------------------+
> +
> +                                      T1              T3
> +                                    +----+        +-------+
> +  CPU2                              |xxxx|        |xxxxxxx|
> +          --------------------------+----+--------+-------+-------->
> +                                      |               |
> +                                      v               v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 2                      |
> +          +-----------------------------------------------------+
> +                                      |               |
> +                                      v               v
> +          +-----------------------------------------------------+
> +          |               AUX Ring buffer 2                     |
> +          +-----------------------------------------------------+
> +
> +                            T1
> +                     +--------------+
> +  CPU3               |xxxxxxxxxxxxxx|
> +          -----------+--------------+------------------------------>
> +                            |
> +                            v
> +          +-----------------------------------------------------+
> +          |                  Ring buffer 3                      |
> +          +-----------------------------------------------------+
> +                            |
> +                            v
> +          +-----------------------------------------------------+
> +          |               AUX Ring buffer 3                     |
> +          +-----------------------------------------------------+
> +
> +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> +           x: Thread is in running state
> +           Figure 6: AUX ring buffer for system wide mode
> +
> +AUX events
> +~~~~~~~~~~
> +
> +Similar to perf_output_begin() and perf_output_end()'s working for the
> +generic ring buffer, perf_aux_output_begin() and perf_aux_output_end()
> +serve for the AUX ring buffer for processing the hardware trace data.
> +The structure perf_output_handle is used as a context to track the AUX
> +buffer=E2=80=99s info.
> +
> +perf_aux_output_begin() initializes the structure perf_output_handle.
> +It fetches the AUX head pointer and assigns to perf_output_handle::head,
> +afterwards, the low level driver uses perf_output_handle::head as the
> +start address for storing hardware trace data.
> +
> +Once the hardware trace data is stored into AUX ring buffer, the
> +function perf_aux_output_end() finishes two things:
> +
> +- It fills an event PERF_RECORD_AUX into the generic ring buffer, this
> +event delivers the information of the start address and data size for a
> +chunk of hardware trace data has been stored into the AUX ring buffer;
> +
> +- Since the hardware trace driver has stored new trace data into the AUX
> +ring buffer, the argument 'size' indicates how many bytes have been
> +consumed by the hardware tracing, thus perf_aux_output_end() updates the
> +header pointer perf_buffer::aux_head to reflect the latest buffer usage.
> +
> +The event PERF_RECORD_AUX presents an AUX event which is handled in the
> +kernel, but it lacks the information for saving the AUX trace data in
> +the perf file.  When the perf tool copies the trace data from AUX ring
> +buffer to the perf data file, it synthesizes a PERF_RECORD_AUXTRACE
> +event which includes the offest and size of the AUX trace data in the
> +perf file.  Afterwards, the perf tool reads out the AUX trace data from
> +the perf file based on the PERF_RECORD_AUXTRACE events, and the
> +PERF_RECORD_AUX event is used to decode a chunk of data by correlating
> +with time order.
> +
> +Snapshot mode
> +~~~~~~~~~~~~~
> +
> +Perf supports snapshot mode for AUX ring buffer, in this mode, users
> +only record AUX trace data at a specific time point which users are
> +interested in.  E.g. below gives an example of how to take snapshots
> +with 1 second interval with Arm CoreSight:
> +
> +  perf record -e cs_etm/@tmc_etr0/u -S -a program &
> +  PERFPID=3D$!
> +  while true; do
> +      kill -USR2 $PERFPID
> +      sleep 1
> +  done
> +
> +The main flow for snapshot mode is:
> +
> +- Before a snapshot is taken, the AUX ring buffer acts in free run mode.
> +During free run mode the perf doesn't record any of the AUX events and
> +trace data;
> +
> +- Once the perf tool receives the USR2 signal, it triggers the callback
> +function auxtrace_record::snapshot_start() to deactivate hardware
> +tracing.  The kernel driver then populates the AUX ring buffer with the
> +hardware trace data, and the event PERF_RECORD_AUX is stored in the
> +generic ring buffer;
> +
> +- Then perf tool takes a snapshot, record__read_auxtrace_snapshot()
> +reads out the hardware trace data from the AUX ring buffer and saves it
> +into perf data file;
> +
> +- After the snapshot is finished, auxtrace_record::snapshot_finish()
> +restarts the PMU event for AUX tracing.
> +
> +The perf only accesses the head pointer perf_event_mmap_page::aux_head
> +in snapshot mode and doesn=E2=80=99t touch tail pointer aux_tail, this i=
s
> +because the AUX ring buffer can overflow in free run mode, the tail
> +pointer is useless in this case.  Alternatively, the callback
> +auxtrace_record::find_snapshot() is introduced for making the decision
> +of whether the AUX ring buffer has been wrapped around or not, at the
> +end it fixes up the AUX buffer's head which are used to calculate the
> +trace data size.
> +
> +As we know, the buffers' deployment can be per-thread mode, per-CPU
> +mode, or system wide mode, and the snapshot can be applied to any of
> +these modes.  Below is an example of taking snapshot with system wide
> +mode.
> +
> +                                         Snapshot is taken
> +                                                 |
> +                                                 v
> +                        +------------------------+
> +                        |  AUX Ring buffer 0     | <- aux_head
> +                        +------------------------+
> +                                                 v
> +                +--------------------------------+
> +                |          AUX Ring buffer 1     | <- aux_head
> +                +--------------------------------+
> +                                                 v
> +    +--------------------------------------------+
> +    |                      AUX Ring buffer 2     | <- aux_head
> +    +--------------------------------------------+
> +                                                 v
> +         +---------------------------------------+
> +         |                 AUX Ring buffer 3     | <- aux_head
> +         +---------------------------------------+
> +
> +           Figure 7: Snapshot with system wide mode
> --
> 2.34.1
>
