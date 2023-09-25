Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162397AD6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIYLHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIYLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:07:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD0C0;
        Mon, 25 Sep 2023 04:07:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so93941811fa.3;
        Mon, 25 Sep 2023 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640032; x=1696244832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwoKKDz7PFuhCsGgBGv/macPzEyZeZss0ErZH7Fj3bA=;
        b=Of0JbgjoqhBS1HJaLMOhqYsLB9OhhNq0loBSYrIo1P07eAMsIlFhBNDCgCAKoI8/an
         8gvzrncYhZGmnusFHgv0gHkF78K33vc4PZmQe4/zSWc9VWNTKvYgY6zMmlo3RWHk0Ovf
         IpGaZFTmfU3w2lBRv7EiisKawpfZcovilbQjhMWFEW+qHAUpojoWHdcoDvaoSkf2f6k9
         n6zPHXqtyuBZXOblBV8f/SAKBIr+KdeiNZsPkflBn9PRvL9LgPnPoeB/+O2od3TZcPq5
         jMyXsp+4jMv0ktAba+FlHNILzssMozAnpxaCm64gQ07EITBanDom3yK58qKe72Z3QhUx
         3uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640032; x=1696244832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwoKKDz7PFuhCsGgBGv/macPzEyZeZss0ErZH7Fj3bA=;
        b=TD/tUgoyD09+rxt+T8gZrKwSRL3KWqcMrIaXQUXrtY1JciRi480ltO5SjMeeT6NcBn
         KfmBlM01YHIYQD7HwyL9lUmG0tKpDVhb8oPnFszvc13dTcGRf+B+cj7p5xuZBGmRPVgJ
         TM/hKM9mz8Ox8kHXEHvmNPRxabH50MPYliD/CZpkon/TN05f5RQZ/Ldnj6Po0/WpTGSK
         ZWYXSv1ZGgRdTnbPSnxSI48xQVLXpCS+Z4OFF53QDEr2VsfQ2afK7PYRhFWRbdd7JOyH
         c9G/38Yrx/iDOTBgzx+XyWngup/eXGsWSU0g/XQFT4XqKOksImN03E8XHqa20qEemLxG
         EopA==
X-Gm-Message-State: AOJu0YygWYskLZIuw04gpcgYsY/DrgMHBBht8POWz3D0JNJdhyfKBMlt
        n0/nWrCb4XYvigJWCI0OIqI=
X-Google-Smtp-Source: AGHT+IGgo4ldpuJySiGdM4mYj2o+lTju6PG/SZZ6Y1W43nWulrR8PpEcBgAgQD3tRKGy+KsBVWeuSw==
X-Received: by 2002:a2e:9845:0:b0:2bf:ff17:811e with SMTP id e5-20020a2e9845000000b002bfff17811emr5041152ljj.14.1695640031811;
        Mon, 25 Sep 2023 04:07:11 -0700 (PDT)
Received: from gmail.com (195-38-113-94.pool.digikabel.hu. [195.38.113.94])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b0099bd046170fsm6093814ejr.104.2023.09.25.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:07:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 25 Sep 2023 13:07:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        Mike Galbraith <efault@gmx.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER
 tasks
Message-ID: <ZRFp3EO2JUXtK6XB@gmail.com>
References: <ZQljoiSBhZLEFI/G@gmail.com>
 <202309221758.d655aa5b-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202309221758.d655aa5b-oliver.sang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kernel test robot <oliver.sang@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed a -19.0% regression of stress-ng.filename.ops_per_sec on:

Thanks for the testing, this is useful!

So I've tabulated the results into a much easier to read format:

> | testcase: change | stress-ng: stress-ng.filename.ops_per_sec                                      -19.0% regression
> | testcase: change | stress-ng: stress-ng.lockbus.ops_per_sec                                        -6.0% regression 
> | testcase: change | stress-ng: stress-ng.sigfd.ops_per_sec                                          17.6% improvement
> | testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Masskrug.CPU-only.seconds    -5.3% improvement
> | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec                              11.5% improvement
> | testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Boat.CPU-only.seconds        -3.5% improvement
> | testcase: change | stress-ng: stress-ng.sigrt.ops_per_sec                                         100.2% improvement
> | testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec                                    -93.9% regression
> | testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec                                    -82.1% regression
> | testcase: change | stress-ng: stress-ng.sock.ops_per_sec                                           59.4% improvement
> | testcase: change | blogbench: blogbench.write_score                                               -35.9% regression
> | testcase: change | hackbench: hackbench.throughput                                                 -4.8% regression
> | testcase: change | blogbench: blogbench.write_score                                               -59.3% regression
> | testcase: change | stress-ng: stress-ng.exec.ops_per_sec                                          -34.6% regression
> | testcase: change | netperf: netperf.Throughput_Mbps                                                60.6% improvement
> | testcase: change | hackbench: hackbench.throughput                                                 19.1% improvement
> | testcase: change | stress-ng: stress-ng.dnotify.ops_per_sec                                       -15.7% regression

And then sorted them along the regression/improvement axis:

> | testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec                                    -93.9% regression
> | testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec                                    -82.1% regression
> | testcase: change | blogbench: blogbench.write_score                                               -59.3% regression
> | testcase: change | blogbench: blogbench.write_score                                               -35.9% regression
> | testcase: change | stress-ng: stress-ng.exec.ops_per_sec                                          -34.6% regression
> | testcase: change | stress-ng: stress-ng.filename.ops_per_sec                                      -19.0% regression
> | testcase: change | stress-ng: stress-ng.dnotify.ops_per_sec                                       -15.7% regression
> | testcase: change | stress-ng: stress-ng.lockbus.ops_per_sec                                        -6.0% regression
> | testcase: change | hackbench: hackbench.throughput                                                 -4.8% regression
> | testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Masskrug.CPU-only.seconds    +5.3% improvement
> | testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Boat.CPU-only.seconds        +3.5% improvement
> | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec                              11.5% improvement
> | testcase: change | stress-ng: stress-ng.sigfd.ops_per_sec                                          17.6% improvement
> | testcase: change | hackbench: hackbench.throughput                                                 19.1% improvement
> | testcase: change | stress-ng: stress-ng.sock.ops_per_sec                                           59.4% improvement
> | testcase: change | netperf: netperf.Throughput_Mbps                                                60.6% improvement
> | testcase: change | stress-ng: stress-ng.sigrt.ops_per_sec                                         100.2% improvement

Testing results notes:

    - the '+' denotes an inverted improvement. The mixing of signs in the output of the 
      ktest robot is arguably confusing.

    - Any hope getting similar summary format by default? It's much more informative than 
      just picking up the biggest regression, which wasn't even done correctly AFAICT.

Summary:

While there's a lot of improvements, it is primarily the nature of performance
regressions that dictate the way forward:

 - stress-ng.sigsuspend.ops_per_sec regressions, -93%:

    Clearly signal delivery performance hurts from delayed preemption, but
    that should be straightforward to resolve, if we are willing to commit
    to adding a high-prio insta-wakeup variant API ...

 - stress-ng.exec.ops_per_sec -34% regression:

    Likewise this possibly expresses that it's better to immediately reschedule
    during exec() - but maybe it's more and reflects some unfavorable migration,
    as suggested by the NUMA locality figures:

                     %change         %stddev
                        |                \                                         
  79317172           -34.2%   52217838 ±  3%  numa-numastat.node0.local_node
  79360983           -34.2%   52240348 ±  3%  numa-numastat.node0.numa_hit                            
  77971050           -33.2%   52068168 ±  3%  numa-numastat.node1.local_node
  78009071           -33.2%   52089987 ±  3%  numa-numastat.node1.numa_hit
     88287           -45.7%      47970 ±  2%  vmstat.system.cs

 - 'blogbench' regression of -59%:

    It too has a very large reduction in context switches:

         %stddev     %change         %stddev
             \          |                \  
     30035           -49.7%      15097 ±  3%  vmstat.system.cs
   2243545 ±  2%      -4.1%    2152228        blogbench.read_score
  52412617           -28.3%   37571769        blogbench.time.file_system_outputs
   2682930           -74.1%     694136        blogbench.time.involuntary_context_switches
   2369329           -50.0%    1184098 ±  5%  blogbench.time.voluntary_context_switches
      5851           -35.9%       3752 ±  2%  blogbench.write_score

    It's unclear to me what's happening with this one, just from these stats,
    but it's "write_score" that hurts most.
 
 - 'stress-ng.filename.ops_per_sec' regression of -19%:

    This test suffered from an *increase* in context-switching, and a large
    increase in CPU-idle:

         %stddev     %change         %stddev
             \          |                \  
   4641666           +19.5%    5545394 ±  2%  cpuidle..usage
     90589 ±  2%     +70.5%     154471 ±  2%  vmstat.system.cs
    628439           -19.2%     507711        stress-ng.filename.ops
     10317           -19.0%       8355        stress-ng.filename.ops_per_sec

    171981           -59.7%      69333 ±  3%  stress-ng.time.involuntary_context_switches
    770691 ±  3%    +200.9%    2319214        stress-ng.time.voluntary_context_switches

Anyway, it's clear from these results that while many workloads hurt
from our notion of wake-preemption, there's several ones that benefit
from it, especially generic ones like phoronix-test-suite - which have
no good way to turn off wakeup preemption (SCHED_BATCH might help though).

One way to approach this would be to instead of always doing
wakeup-preemption (our current default), we could turn it around and
only use it when it is clearly beneficial - such as signal delivery,
or exec().

The canonical way to solve this would be give *userspace* a way to
signal that it's beneficial to preempt immediately, ie. yield(),
but right now that interface is hurting tasks that only want to
give other tasks a chance to run, without necessarily giving up
their own right to run:

        se->deadline += calc_delta_fair(se->slice, se);

Anyway, my patch is obviously a no-go as-is, and this clearly needs more work.

Thanks,

	Ingo
