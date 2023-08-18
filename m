Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAC78135A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379615AbjHRT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379613AbjHRT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:27:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241474212
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:27:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4103c24a989so8089261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1692386876; x=1692991676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+l/8S1Hd0UUNTGqSSIlC420Xprrl0UIhMrMB52nc7aY=;
        b=QTJt96FENXFcy4eWYCpMS8LJGKreki/Xz/2E1Mt7JcPsxLuLMzvAjn5S3O7Fr0osuH
         ebHXXUByTISJX/xn5fWlfhFQmpr32Nhw8ViyQ1MP3J4v4xKTUKPxsVSBl2BHXpAZ4Qdf
         f4SagOjOY3GVHEJUCwqaCpR49iQ02AQL1qIN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692386876; x=1692991676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l/8S1Hd0UUNTGqSSIlC420Xprrl0UIhMrMB52nc7aY=;
        b=Kwkxnmy2jozgj3l5bnkMfXurs+6tMAEe+3HaQTPj5gSFzSHDJcF/wnWWgQ/F5MUZwG
         sFHf0/Cokm9N9JSnqhj4dGN/tX0hYe+aj9qkhtcV/JLAIeCK+2kk0rDZyR8kBkzpVIx9
         fVJbeqhgQzFws2+2Vh2SRmIllmpVDIjLl4N/wuF8H8myVMTfjWbf59lvwV0D/C/Hjwgf
         YqUDEWDHynsklv9/NrCg1x0HGcASwAm98nyhhLrDxN2IH+nuibFNz/LAvhTsPC2w35t3
         n1M6MvaAGMpdZI7ZyQQD3FERSDE6tod1Qbxd97JRR0hYywqcBFuy4IjjYM4Qpf5btbCG
         JAuQ==
X-Gm-Message-State: AOJu0Yxf9kBLmqYLFB7OPNUGN48PR25f68ZGLUoOnZ6EDm0YIazBh7Fi
        1RA9bhRj9wXbNY94Pl3/jbJylA==
X-Google-Smtp-Source: AGHT+IGoIFdl+2Xrwjq5jJPlikq+AwsbbPGBg77X48ulQfvnAs6c6Lrr3bqYuz3E8I606g389XwcxA==
X-Received: by 2002:a05:622a:489:b0:400:98e9:fd78 with SMTP id p9-20020a05622a048900b0040098e9fd78mr196360qtx.40.1692386876229;
        Fri, 18 Aug 2023 12:27:56 -0700 (PDT)
Received: from sinkpad ([107.159.7.5])
        by smtp.gmail.com with ESMTPSA id bb32-20020a05622a1b2000b00405502aaf76sm714195qtb.57.2023.08.18.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:27:55 -0700 (PDT)
Date:   Fri, 18 Aug 2023 15:27:42 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] sched: ttwu_queue_cond: skip queued wakeups
 across different l2 caches
Message-ID: <20230818192742.GA461596@sinkpad>
References: <20230818153027.202017-1-mathieu.desnoyers@efficios.com>
 <20230818153027.202017-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818153027.202017-3-mathieu.desnoyers@efficios.com>
X-Mailer: Mutt 1.13.2 (2019-12-18)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Aug-2023 11:30:27 AM, Mathieu Desnoyers wrote:
> Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
> cache has a latency of 4-5 cycles, the L2 cache has a latency of at
> least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
> this, I measured the RAM accesses to a latency around 120ns on my
> system [2]. So L3 really is only 2.4x faster than RAM accesses.
> Therefore, with this relatively slow access speed compared to L2, the
> scheduler will benefit from only considering CPUs sharing an L2 cache
> for the purpose of using remote runqueue locking rather than queued
> wakeups.
> 
> Skipping queued wakeups for all logical CPUs sharing an LLC means that
> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
> runqueues within the same group for each wakeup, causing contention on
> the runqueue locks.
> 
> Improve this by only considering logical cpus sharing an L2 cache as
> candidates for skipping use of the queued wakeups.
> 
> This results in the following benchmark improvements:
> 
>     hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> 
> from 49s to 34s. (30% speedup)
> 
> And similarly with perf bench:
> 
>     perf bench sched messaging -g 32 -p -t -l 100000
> 
> from 10.9s to 7.4s (32% speedup)
> 
> I have noticed that in order to observe the speedup, the workload needs
> to keep the CPUs sufficiently busy to cause runqueue lock contention,
> but not so busy that they don't go idle. This can be explained by the
> fact that idle CPUs are a preferred target for task wakeup runqueue
> selection, and therefore having idle cpus causes more migrations, which
> triggers more remote wakeups. For both the hackbench and the perf bench
> sched messaging benchmarks, the scale of the workload can be tweaked by
> changing the number groups.
> 
> This was developed as part of the investigation into a weird regression
> reported by AMD where adding a raw spinlock in the scheduler context
> switch accelerated hackbench. It turned out that changing this raw
> spinlock for a loop of 10000x cpu_relax within do_idle() had similar
> benefits.
> 
> This patch achieves a similar effect without busy waiting nor changing
> anything about runqueue selection on wakeup. It considers that only
> hardware threads sharing an L2 cache should skip the queued
> try-to-wakeup and directly grab the target runqueue lock, rather than
> allowing all hardware threads sharing an LLC to do so.
> 
> I would be interested to hear feedback about performance impact of this
> patch (improvement or regression) on other workloads and hardware,
> especially for Intel CPUs. One thing that we might want to empirically
> figure out from the topology is whether there is a maximum number of
> hardware threads within an LLC below which it would make sense to use
> the LLC rather than L2 as group within which queued wakeups can be
> skipped.

I just tested this patchset with the above perf bench sched on Intel Xeon
Platinum 8358 CPU with 2 sockets, 32 cores (64 hardware threads) by socket.

Here are the results by group size (the -g parameter):
group  A_idle   B_idle   A_avg    A_stdev  B_avg    B_stdev  diff_percent
2      51.9429  50.8     3.45583  0.333    3.5144   0.379    -1.69
4      29.0722  29.475   4.0825   0.067    3.9498   0.049    3.250
6      17.9737  18.7158  4.991    0.026    4.5654   0.051    8.527
8      12.8167  13.1667  5.9366   0.046    5.1026   0.049    14.04
10     9.608    7.08095  6.6506   0.038    5.6814   0.064    14.57
12     6.91034  3.1      7.2526   0.048    6.7408   0.170    7.056
14     5.48333  2.76429  7.9436   0.085    8.1394   0.124    -2.46
16     4.475    3.21562  9.184    0.277    9.544    0.302    -3.91
18     4.60811  2.65588  10.45    0.279    10.46    0.243    -.095
20     4.35349  3.40857  11.7954  0.304    10.9482  0.268    7.182
22     4.63778  3.25714  13.0338  0.294    11.7888  0.302    9.552
24     4.49216  3.5      14.2888  0.251    13.1898  0.344    7.691
26     4.67288  3.42308  15.7286  0.231    14.3678  0.495    8.651
28     4.9375   3.68929  17.4738  0.714    15.3134  0.541    12.36
30     4.65538  4.47286  18.678   0.486    18.2136  1.413    2.486
32     4.28904  4.25479  19.6096  0.168    18.4308  0.778    6.011
34     4.49342  4.09146  20.9478  0.184    21.0388  1.349    -.434
36     4.47439  4.04945  22.3406  0.322    23.606   1.060    -5.66

The avg and stdev are based on 5 runs of perf bench sched.

"A" is the baseline captured on 6.1.42, "B" is 6.1.42 + this patchset.
the _idle columns are a rough sampling of the %idle CPU time while perf
is running.

This is really encouraging and it seems to match an issue I have
observed in production for a while where the scheduling latencies seem
too high proportionally to the %idle on large servers. Those servers are
hypervisors basically running a lot of random workloads in VMs. I am
working on a synthetic test case that could help confirm this is the
same issue or not.

Thanks,

Julien
