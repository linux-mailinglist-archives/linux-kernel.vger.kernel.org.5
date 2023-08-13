Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41BC77AA1F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHMQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:43:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34491
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:43:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5657add1073so1300855a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691945012; x=1692549812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vssJJv5bbHKaNNNI58xTLf0nD9mUr+gBqvzgJTi6GU=;
        b=eMDNj1LzYqyfli4Jrdr2fDhB3s7wuW2K0343K2zu1sPMcb+a0Xi1lxX/9tpwIrIxTC
         +X2Nxt5Y3DBcku2Fc85bZM/CSvwl5tZLlXinSmshxRSTBIanY98c8NdY4lvwfEOTvS9q
         NmyvF8TThuHl5jnm5HRrYI/RRwauV0zwwIjTUxf7OHzG60WbtTkRy54aF1BKiN97lpyt
         I63n59+eM5bclQYPRH6XzCrBierIWT2a7jofCRDuz2/D/xWm+UlF74e3jInURthWiGCy
         3XHAdGcFC+s5/OG1akn5bK3E21DUUt5sj4KK6M04w64jmrGTyndg/1xuJMwej7oA1hQS
         wf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691945012; x=1692549812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vssJJv5bbHKaNNNI58xTLf0nD9mUr+gBqvzgJTi6GU=;
        b=T4UqMlKY1iLaPJ2KURWzs9nh0RZ6cH+en/7oM+A4XOhWXI6+yNT+KYNdSI5M0PVhgv
         7pW7y+B6tlvCKWTJKqzJ/oeTPTd61g/6U4IOmxhFCtyV/X7N+zEq/Q7lzT9wgD0tlunz
         d+/uYM2NgKrS3SQuBLd0zwAQ0BXktv1DIM1Sfm67aiS+v79EJP/Zk/UuPxcWzk5kiB5P
         76i2GAdYy7b4n/I0d5vDJd0ewJKw7iaxsUfp7rYErUIUN6gfNVsUbHYlG3hdT//xsMSY
         I57b6LdaskPAmCkPhBeRCprhBzxsE6sOR3PUuwWUoPkkliT2xFV7pNOnYc/uJWjEi9Ph
         ZtFw==
X-Gm-Message-State: AOJu0YzLVK7FiHWuLfOuFVYBeolFVqdfpX9UY93bE3eS5lqoO6OZ18sS
        ikhmjrGpVIvaOuvIZ2ZYbGb0WA==
X-Google-Smtp-Source: AGHT+IFCE18lplunalTH8D1Uq/3UqpKkTA1BTPXxCVc2b/8eXo2Pu8fbSEht3tuYCwNhj9fAppQI6g==
X-Received: by 2002:a17:90a:de0d:b0:268:5aaf:fbe with SMTP id m13-20020a17090ade0d00b002685aaf0fbemr14096248pjv.10.1691945011645;
        Sun, 13 Aug 2023 09:43:31 -0700 (PDT)
Received: from leoy-huanghe ([150.230.248.162])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b00262d6ac0140sm6446518pjb.9.2023.08.13.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:43:31 -0700 (PDT)
Date:   Mon, 14 Aug 2023 00:43:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-doc@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: userspace-api: Document perf ring
 buffer mechanism
Message-ID: <20230813164323.GA2678719@leoy-huanghe>
References: <20230805142905.1852977-1-leo.yan@linaro.org>
 <CAM9d7chruP6-dvP2Xvtr+KDC+Cvzwe36jEenWon9vbt6BinugA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chruP6-dvP2Xvtr+KDC+Cvzwe36jEenWon9vbt6BinugA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Mon, Aug 07, 2023 at 11:01:03PM +0900, Namhyung Kim wrote:
> Hi Leo,
> 
> Thanks a lot for writing this up!

Thanks a lot for review.

> I think this is for kernel API not the perf (tool) implementation
> so it should focus on the stable interface in the uapi header.

This doc does addresses the header include/uapi/linux/perf_event.h,
e.g. perf_event_mmap_page structure is defined in this header.

After reading your below comments, I think I understand what you mean.
Let's see what we can improve for this :)

[...]

> > +Perf uses the same way to manage its ring buffer.  In the implementation
> > +there are two key data structures held together in a set of consecutive
> > +pages, the control structure and then the ring buffer itself.  The page
> > +with the control structure in is known as the "user page".  Being held
> > +in continuous virtual addresses simplifies locating the ring buffer
> > +address, it is in the pages after the page with the user page.
> > +
> > +The control structure is named as ``perf_event_mmap_page``, it contains a
> > +head pointer ``data_head`` and a tail pointer ``data_tail``.  When the
> > +kernel starts to fill records into the ring buffer, it updates the head
> > +pointer to reserve the memory so later it can safely store events into
> > +the buffer; on the other side, the perf tool updates the tail pointer
> > +after consuming data from the ring buffer.
> 
> This assumes a writable mapping with PROT_WRITE.
> It cannot update the data_tail on read-only mappings.

Will rephrase as:

... on the other side, when the user page is a writable mapping, the perf tool
has the permission to update the tail pointer after consuming data from the
ring buffer.  There has a special case for the the user page's read-only
mapping, which will be addressed in detail in the section 2.3.2 "Writing
samples into buffer".

> > +
> > +::
> > +
> > +          user page                          ring buffer
> > +    +---------+---------+   +---------------------------------------+
> > +    |data_head|data_tail|...|   |   |***|***|***|***|***|   |   |   |
> > +    +---------+---------+   +---------------------------------------+
> > +        `          `----------------^                   ^
> > +         `----------------------------------------------|
> > +
> > +              * : the data is filled by the writer.
> > +
> > +                Figure 2. Perf ring buffer
> > +
> > +When using the ``perf record`` tool, we can specify the ring buffer size
> > +with option ``-m`` or ``--mmap-pages=``, the given size will be rounded up
> > +to a power of two that is a multiple of a page size.  Though the kernel
> > +allocates at once for all memory pages, it's deferred to map the pages
> > +to VMA area until the perf tool accesses the buffer from the user space.
> > +In other words, at the first time accesses the buffer's page from user
> > +space in the perf tool, a data abort exception for page fault is taken
> > +and the kernel uses this occasion to map the page into process VMA, thus
> > +the perf tool can continue to access the page after returning from the
> > +exception.
> > +
> > +The function ``perf_mmap_fault()`` is for handling the page fault, which
> > +invokes ``perf_mmap_to_page()`` to figure out which page should be mapped.
> > +The structure ``vm_fault`` has a field ``pgoff`` to indicate which page
> > +should be mapped, if ``pgoff`` is zero it maps the ring buffer's user
> > +page, otherwise, the ring buffer's page is mapped with index ``pgoff-1``
> > +(since the first page in VMA is for user page, so we need to decrease 1
> > +to get the ring buffer's page index).
> 
> Looks like too much information of kernel implementation.
> It's not a user API so functiona/data can change later.

I will drop above paragraph, but I'd like to meantion perf_mmap_fault() as it's
the main function to handle the page fault.  This can allow readers to easily
connect doc with the source code.  So I will update the last sentence of the
previous paragraph:

... and the kernel uses this occasion to map the page into process VMA
(see ``perf_mmap_fault()``), thus the perf tool ...


> > +
> > +2.2 Ring buffer for different tracing modes
> > +-------------------------------------------
> > +
> > +The perf profiles programs with different modes: default mode, per thread
> > +mode, per cpu mode, and system wide mode.  This section describes these
> > +modes and how the ring buffer meets requirements for them.  At last we
> > +will review the race conditions caused by these modes.
> 
> I think it's better to focus how it opens the perf event
> with CPU and PID params.

Agreed.

> > +
> > +2.2.1 Default mode
> > +^^^^^^^^^^^^^^^^^^
> > +
> > +Usually we execute ``perf record`` command followed by a profiling program
> > +name, like below command::
> > +
> > +        perf record test_program
> > +
> > +This command doesn't specify any options related with ring buffer mode,
> > +it's called default mode.
> 
> It'd be CPU >= 0 and PID >= 0 and attr.inherit = 1 case.

Will supplement:

This command doesn't specify any options for CPU and thread modes, the perf
tool will apply the default mode on the perf event.  It maps all the CPUs in the
system and the profiled program's PID on the perf event, and it enables
inheritance mode on the event so that child tasks inherits the events.  As a
result, the perf event is attributed as::

  evsel::cpus::map[]    = { 0 .. _SC_NPROCESSORS_ONLN-1 }
  evsel::threads::map[] = { pid }
  evsel::attr::inherit  = 1

These attributions finally reflect on how to deploy the ring buffers.  As shown
below ....

> > +
> > +As shown below, the perf tool allocates individual ring buffers for each
> > +CPU, but it only enables events for the profiled program rather than for
> > +all threads in the system.  The *T1* thread represents the thread context
> > +of the 'test_program', whereas *T2* and *T3* are irrelevant threads in the
> > +system.   The perf samples are exclusively collected for the *T1* thread
> > +and stored in the ring buffer associated with the CPU on which the *T1*
> > +thread is running.
> > +
> > +::
> > +
> > +              T1                      T2                 T1
> > +            +----+              +-----------+          +----+
> > +    CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> > +            +----+--------------+-----------+----------+----+-------->
> > +              |                                          |
> > +              v                                          v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 0                      |
> > +            +-----------------------------------------------------+
> > +
> > +                   T1
> > +                 +-----+
> > +    CPU1         |xxxxx|
> > +            -----+-----+--------------------------------------------->
> > +                    |
> > +                    v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 1                      |
> > +            +-----------------------------------------------------+
> > +
> > +                                        T1              T3
> > +                                      +----+        +-------+
> > +    CPU2                              |xxxx|        |xxxxxxx|
> > +            --------------------------+----+--------+-------+-------->
> > +                                        |
> > +                                        v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 2                      |
> > +            +-----------------------------------------------------+
> > +
> > +                              T1
> > +                       +--------------+
> > +    CPU3               |xxxxxxxxxxxxxx|
> > +            -----------+--------------+------------------------------>
> > +                              |
> > +                              v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 3                      |
> > +            +-----------------------------------------------------+
> > +
> > +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> > +           x: Thread is in running state
> > +
> > +                Figure 3. Ring buffer for default mode
> > +
> > +2.2.2 Per-thread mode
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +By specifying option ``--per-thread`` in perf command, the ring buffer is
> > +allocated for every profiled thread.  An example command is:
> > +
> > +::
> > +
> > +        perf record --per-thread test_program
> 
> It'd be CPU == -1 and PID >= 0 and attr.inherit = 0 case.

Will supplement:

By specifying option ``--per-thread`` in perf command, e.g.

::

        perf record --per-thread test_program

The perf event doesn't map to any CPUs and is only bound to the
profiled process, thus, the perf event's attributions are::

        evsel::cpus::map[0]   = { -1 }
        evsel::threads::map[] = { pid }
        evsel::attr::inherit  = 0

In this mode, a ring buffer is allocated for the profiled thread; when
a profiled thread is scheduled on a CPU ...

> > +
> > +In this mode, a profiled thread is scheduled on a CPU, the events on
> > +that CPU will be enabled; and if the thread is scheduled out from the
> > +CPU, the events on the CPU will be disabled.  When the thread is
> > +migrated from one CPU to another, the events will be disabled on the
> > +previous CPU and enabled on the next CPU correspondingly.
> > +
> > +::
> > +
> > +              T1                      T2                 T1
> > +            +----+              +-----------+          +----+
> > +    CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> > +            +----+--------------+-----------+----------+----+-------->
> > +              |                                           |
> > +              |    T1                                     |
> > +              |  +-----+                                  |
> > +    CPU1      |  |xxxxx|                                  |
> > +            --|--+-----+----------------------------------|---------->
> > +              |     |                                     |
> > +              |     |                   T1            T3  |
> > +              |     |                 +----+        +---+ |
> > +    CPU2      |     |                 |xxxx|        |xxx| |
> > +            --|-----|-----------------+----+--------+---+-|---------->
> > +              |     |                   |                 |
> > +              |     |         T1        |                 |
> > +              |     |  +--------------+ |                 |
> > +    CPU3      |     |  |xxxxxxxxxxxxxx| |                 |
> > +            --|-----|--+--------------+-|-----------------|---------->
> > +              |     |         |         |                 |
> > +              v     v         v         v                 v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer                        |
> > +            +-----------------------------------------------------+
> > +
> > +           T1: Thread 1
> > +           x: Thread is in running state
> > +
> > +                Figure 4. Ring buffer for per-thread mode
> > +
> > +When perf runs in per-thread mode, a ring buffer is allocated for the
> > +profiled thread *T1*.  The ring buffer is dedicated for thread *T1*, if the
> > +thread *T1* is running, the perf events will be recorded into the ring
> > +buffer; when the thread is sleeping, all associated events will be
> > +disabled, thus no trace data will be recorded into the ring buffer.
> > +
> > +2.2.3 Per-CPU mode
> > +^^^^^^^^^^^^^^^^^^
> > +
> > +The option ``-C`` is used to collect samples on the list of CPUs, the ring
> > +buffers are allocated for the specified CPUs.  For the example in below
> > +command, the perf command receives option ``-C 0,2``, as the result, two
> > +ring buffers serve CPU0 and CPU2 separately::
> > +
> > +       perf record -C 0,2 test_program
> 
> It'd be CPU >=0 and PID == -1 case.  I don't think the test_program is
> the target of perf event and it just controls the period of perf record.

Will amend as:

The option ``-C`` is used to collect samples on the list of CPUs, for example
in below command, the perf command receives option ``-C 0,2``::

       perf record -C 0,2 test_program

It maps the perf event to CPUs 0 and 2, and the event is not associated to any
PID.  The perf event attributions are set as::

        evsel::cpus::map[0]   = { 0, 2 }
        evsel::threads::map[] = { -1 }
        evsel::attr::inherit  = 0

This results in the session of ``perf record`` will sample all threads on CPU0
and CPU2, and be terminated until test_program exits.  In this example, even
there have tasks running on CPU1 and CPU3 ...

> > +
> > +In this example, even there have tasks running on CPU1 and CPU3, since
> > +the ring buffer is absent for them, any activities on these two CPUs
> > +will be ignored.  A usage case is to combine the options for per-thread
> > +mode and per-CPU mode, e.g. the options ``–C 0,2`` and ``––per–thread`` are
> > +specified together, the samples are recorded only when the profiled
> > +thread is scheduled on any of the listed CPUs.
> > +
> > +::
> > +
> > +              T1                      T2                 T1
> > +            +----+              +-----------+          +----+
> > +    CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> > +            +----+--------------+-----------+----------+----+-------->
> > +              |                       |                  |
> > +              v                       v                  v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 0                      |
> > +            +-----------------------------------------------------+
> > +
> > +                   T1
> > +                 +-----+
> > +    CPU1         |xxxxx|
> > +            -----+-----+--------------------------------------------->
> > +
> > +                                        T1              T3
> > +                                      +----+        +-------+
> > +    CPU2                              |xxxx|        |xxxxxxx|
> > +            --------------------------+----+--------+-------+-------->
> > +                                        |               |
> > +                                        v               v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 1                      |
> > +            +-----------------------------------------------------+
> > +
> > +                              T1
> > +                       +--------------+
> > +    CPU3               |xxxxxxxxxxxxxx|
> > +            -----------+--------------+------------------------------>
> > +
> > +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> > +           x: Thread is in running state
> > +
> > +                Figure 5. Ring buffer for per-CPU mode
> > +
> > +2.2.4 System wide mode
> > +^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +By using option ``–a`` or ``––all–cpus``, perf collects samples on all CPUs
> > +for all tasks, we call it as the system wide mode, the command is::
> > +
> > +        perf record -a test_program
> 
> Should be same as per-CPU mode.

Will change to:

Similar to the per-CPU mode, the perf event doesn't bind to any PID, but it maps
all CPUs in the system rather than selected CPUs::

        evsel::cpus::map[]    = { 0 .. _SC_NPROCESSORS_ONLN-1 }
        evsel::threads::map[] = { -1 }
        evsel::attr::inherit  = 0

> > +
> > +In the system wide mode, every CPU has its own ring buffer, all threads
> > +are monitored during the running state and the samples are recorded into
> > +the ring buffer belonging to the CPU which the events occurred on.
> > +
> > +::
> > +
> > +              T1                      T2                 T1
> > +            +----+              +-----------+          +----+
> > +    CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> > +            +----+--------------+-----------+----------+----+-------->
> > +              |                       |                  |
> > +              v                       v                  v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 0                      |
> > +            +-----------------------------------------------------+
> > +
> > +                   T1
> > +                 +-----+
> > +    CPU1         |xxxxx|
> > +            -----+-----+--------------------------------------------->
> > +                    |
> > +                    v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 1                      |
> > +            +-----------------------------------------------------+
> > +
> > +                                        T1              T3
> > +                                      +----+        +-------+
> > +    CPU2                              |xxxx|        |xxxxxxx|
> > +            --------------------------+----+--------+-------+-------->
> > +                                        |               |
> > +                                        v               v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 2                      |
> > +            +-----------------------------------------------------+
> > +
> > +                              T1
> > +                       +--------------+
> > +    CPU3               |xxxxxxxxxxxxxx|
> > +            -----------+--------------+------------------------------>
> > +                              |
> > +                              v
> > +            +-----------------------------------------------------+
> > +            |                  Ring buffer 3                      |
> > +            +-----------------------------------------------------+
> > +
> > +           T1: Thread 1; T2: Thread 2; T3: Thread 3
> > +           x: Thread is in running state
> > +
> > +                Figure 6. Ring buffer for system wide mode
> > +
> > +2.3 Accessing buffer
> > +--------------------
> > +
> > +Based on the understanding of how the ring buffer is allocated in
> > +various modes, this section explains access the ring buffer.
> > +
> > +2.3.1 Producer-consumer model
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +In the Linux kernel, the PMU events can produce samples which are stored
> > +into the ring buffer; the perf command in user space consumes the
> > +samples by reading out data from the ring buffer and finally saves the
> > +data into the file for post analysis.  It’s a typical producer-consumer
> > +model for using the ring buffer.
> > +
> > +The perf process polls on the PMU events and sleeps when no events are
> > +incoming.  To prevent frequent exchanges between the kernel and user
> > +space, the kernel event core layer introduces a watermark, which is
> > +stored in the ``perf_buffer::watermark``.  When a sample is recorded into
> > +the ring buffer, and if the used buffer exceeds the watermark, the
> > +kernel wakes up the perf process to read samples from the ring buffer.
> > +
> > +::
> > +
> > +                       Perf
> > +                       / | Read samples
> > +             Polling  /  `--------------|               Ring buffer
> > +                     v                  v    ;---------------------v
> > +    +----------------+     +---------+---------+   +-------------------+
> > +    |Event wait queue|     |data_head|data_tail|   |***|***|   |   |***|
> > +    +----------------+     +---------+---------+   +-------------------+
> > +             ^                  ^ `------------------------^
> > +             | Wake up tasks    | Store samples
> > +          +-----------------------------+
> > +       |  Kernel event core layer    |
> > +          +-----------------------------+
> > +
> > +              * : the data is filled by the writer.
> > +
> > +                Figure 7. Writing and reading the ring buffer
> > +
> > +When the kernel event core layer notifies the user space, because
> > +multiple events might share the same ring buffer for recording samples,
> > +the core layer iterates every event associated with the ring buffer and
> > +wakes up tasks waiting on the event.  This is fulfilled by the kernel
> > +function ``ring_buffer_wakeup()``.
> > +
> > +After the perf process is woken up, it starts to check the ring buffers
> > +one by one, if it finds any ring buffer containing samples it will read
> > +out the samples for statistics or saving into the data file.  Given the
> > +perf process is able to run on any CPU, this leads to the ring buffer
> > +potentially being accessed from multiple CPUs simultaneously, which
> > +causes race conditions.  The race condition handling is described in the
> > +section :ref:`memory_synchronization`.
> > +
> > +2.3.2 Writing samples into buffer
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +When a hardware event counter overflows, a sample will be taken and
> > +saved into the ring buffer; the function ``__perf_event_output()`` is used
> > +to fill samples into the ring buffer, it calls the below sub functions:
> > +
> > +- The sub function ``perf_prepare_sample()`` prepares sample fields based on
> > +  the sample type;
> > +- ``output_begin()`` is a function pointer, it’s passed dynamically via the
> > +  argument for different writing directions, its purpose is to prepare
> > +  the info for writing ring buffer, when the function returns back the
> > +  ring buffer info is stored in structure ``perf_output_handle``;
> > +- ``perf_output_sample()`` outputs the sample into the ring buffer;
> > +- ``perf_output_end()`` updates the head pointer for user page so perf tool
> > +  can see the latest value.
> > +
> > +Let’s examine ``output_begin()`` in detail.  As the ring buffer allows
> > +writing in two directions: backward or forward, the function pointer for
> > +``output_begin()`` is assigned according to the writing type of the buffer,
> > +it can be ``perf_output_begin_forward()`` or ``perf_output_begin_backward()``.
> > +
> > +In the case of the backward ring buffer, where the user page is mapped
> > +without ``PROT_WRITE``, the tool in user space is unable to update the
> > +tail pointer.  As a result, only the head pointer is accessed in this
> > +scenario, and the tail pointer is not used in perf tool.  The head
> > +pointer indicates the beginning of a sample, perf tool can read out the
> > +samples one by one based on sample’s event size.
> 
> Fundamentally, I think mmap has two mode - RDWR and RDONLY.
> The RDWR mode requires user space to update the data_tail while
> RDONLY doesn't.  The RDONLY mode is also called as overwrite mode.
> 
> When consumer doesn't keep up with the producer, it'd lose some data.
> And there's a difference how they handle it.  In RDWR mode, kernel
> keeps how many records it lost and generates PERF_RECORD_LOST
> next time it finds a space in the ring buffer (i.e. after user space updates
> data_tail).
> 
> In RDONLY (overwrite) mode, it'd overwrite existing data with new one
> and won't generate the PERF_RECORD_LOST records.
> 
> Here the write direction matters, forward writing saves the data from
> the beginning of the ring buffer and the data_head keeps the position
> to write the next data.  Which means it only knows position of the end
> of the current data.  And it'd be hard to find where the previous data
> starts.
> 
> OTOH, backward writing saves the data from the end of the ring buffer
> and the data_head keeps the position of current data.  So it always
> knows where it starts to read.  IIUC that's why perf tool uses the
> backward writing for overwrite mode.

I rework it as:

"Ring buffers are mapped as read-write mode or read-only mode, which is
used for a normal ring buffer and an overwritable ring buffer respectively.

The ring buffer in the read-write mode is mapped with the property
``PROT_READ | PROT_WRITE``.  With the write permission, the perf tool updates
the ``data_tail`` to indicate the data start position.  Combining with the
head pointer ``data_head``, which works as the end position of the current
data, the perf tool can easily know where read out the data from.  Alternatively,
in the read-only mode, only the kernel keeps to update the ``data_head`` while
the user space cannot access the ``data_tail`` due to the mapping property
``PROT_READ``.

Furthermore, the write direction matters.  The forward writing starts to save data
from the beginning of the ring buffer and wrap around when overflow, which is used
in the normal ring buffer with the read-write mode.  On the other hand, backward
writing saves the data from the end of the ring buffer and the ``data_head`` keeps
the position of current data, perf always knows where it starts to read and until
the end of the ring buffer, thus it don't need the ``data_tail``.  This is why the
perf uses the backward writing with the read-only mode for the overwritable ring
buffer."


Will refine a bit and send new patch out as ready.

Thanks a lot for suggestions!

Leo
