Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D077D94C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbjHPDyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbjHPDyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:54:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818741FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:54:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf3f59905so803406666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692158052; x=1692762852;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qd39vlsN1BuWdE9COw37WfFe0DzwQFXWEWN3mP2Zgmw=;
        b=pPm7rrC+aArZpa6lolm5Mp0t4vCsaqWUZ1rGLHSQCjmzYSYOtXAZcCKOuqxbtAMG3W
         KkqN98e/dmMvECyQNVE8PkXZhIzkBavTzjDNllfp5bsI6w7iQmoEVgSfH6AmNUQfmC5J
         JCgliR1XMCuECuaPc60jvhY2ptRzlJEqX5MOErWfmKBkj79krA3vDN6pxHLJ5cPvxfkT
         jw1pgWI4hdy0hqqxGuY/X58DEZg+S8Xl1209utOoPw9BK4+6xsy/O/mTmkc3l6px7Zxy
         UuScDTNd2AyDVtbAYWFN4Xf9e0T1fnFkQ0tVOV70pPsTv6x9XJB55roGVFuZo6KtbIG5
         gzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692158052; x=1692762852;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd39vlsN1BuWdE9COw37WfFe0DzwQFXWEWN3mP2Zgmw=;
        b=LMWiDMAyDmERsDIfRRnvsqNmG99Z8iEA6jcvnThaZcLqeNWH6ZcbqZ+AgcmMquTnBd
         WOdpeQYvj0vD9FPbSpG35IS694Wv5D6yJNmPhZ7BNijvizoHNeUY5MeAO8ff1v9c38++
         PO47Dkf+Z+SJeWdsNU66dC1YAnkdht8nSZxcLmgoO4fjZ6A8EjczEFu1WnyGYLCYvuPd
         KFFjfSTTt4i2WP3w0lwdChetNiT2l0BqND6KSW/NeOu37w/t7P543/XvzEiZL/V4yRVC
         f6zP5y/3cUNK0i8MSgF3sgJfmQTwOQnSKhyZmY8cgltzb4WVPqB7V3kQGdnNYp81US9j
         2czQ==
X-Gm-Message-State: AOJu0Yz49bV4PQOpdXzzAmSnwJ8arfZXOdbjI+2uuvYkrnyjlv9KWJT0
        jrZ5o2lqw30wcJQpdKzHy91udYIut5c=
X-Google-Smtp-Source: AGHT+IHtnY+3U/eUX4Gva9hoBUlAd+e5l1+L+92pOdymZXNhehcl9Qxv56qpAE/Ezr3oLLudP8gDuA==
X-Received: by 2002:a17:906:4999:b0:999:26d3:b815 with SMTP id p25-20020a170906499900b0099926d3b815mr557145eju.64.1692158051627;
        Tue, 15 Aug 2023 20:54:11 -0700 (PDT)
Received: from homer.fritz.box ([185.221.149.128])
        by smtp.googlemail.com with ESMTPSA id mb8-20020a170906eb0800b00988f168811bsm7947605ejb.135.2023.08.15.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:54:11 -0700 (PDT)
Message-ID: <7af8d19c774b61db98e13dac30312ce2cd3d4e34.camel@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Date:   Wed, 16 Aug 2023 05:54:10 +0200
In-Reply-To: <20230815235201.GH971582@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
         <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
         <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
         <20230814132935.GK776869@hirez.programming.kicks-ass.net>
         <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
         <20230815235201.GH971582@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-16 at 01:52 +0200, Peter Zijlstra wrote:
> On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> 
> > I don't have that phoronix thingy, but the above didn't seem to do
> > anything for hackbench here.
> 
> Yeah, looking at it this is because the lag and the request/slice are on
> the same order of things.
> 
> More thinking required, but perhaps not at 2am.
> 
> > I whack eevdf with the stick below to dampen its scheduling enthusiasm
> > a little, and it did help the hackbench deficit some.
> 
> I'm thinking there's an argument to be had the current WAKEUP_PREEMPTION
> knob is at the wrong place and should be more or less where you put the
> triddle at.

FWIW, the full twiddle also incorporates your XXX wakeup preempt check
as well, which turned too harsh into local keeper.

It turned out that someone at SUSE likes blogbench enough to package
it, so I installed it and took it for a spin.  I don't have near enough
box to be running the thing, the resulting numbers aren't interesting,
but I think the perf sched summaries below are, show that preemption
adjust of some sort (less mallet like) would help that load.

	-Mike

for i in `seq 3`
do
	rm -r /usr/local/blogbench/*
	blogbench -i 5 -r 10 -d /usr/local/blogbench 2>&1|grep Final
done

Full warmup, repeat for numbers, then perf sched record an instance.

6.4.10-cfs                                                   avg
Final score for writes:          4834     4900     4945     4893
Final score for reads :        189432   202455   199513   197133

6.4.10-eevdf virgin                                                vs cfs
Final score for writes:          3729*    4354     4309     4130     .844
Final score for reads :        171679*  210588   192533   191600     .971
                               
6.4.10-eevdf WAKEUP_DEADLINE
Final score for writes:          3890*    4319     4473     4227     .863
Final score for reads :        200479   245808*  209308   218531    1.108

6.4.10-eevdf WAKEUP_DEADLINE XXX
Final score for writes:          4913     4912     4993     4939    1.009
Final score for reads :        204454   198320   204883   202552    1.027

6.4.10-eevdf RUN_TO_PARITY (full hacklet below)
Final score for writes:          4942     4786     4788     4838     .988
Final score for reads :        199547   226007   203031   209528    1.062

6.4.10-cfs
 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  blogbench:4184        |  18113.843 ms |    11542 | avg:   0.295 ms | max:  40.177 ms | sum: 3401.177 ms |
  blogbench:4185        |  16225.865 ms |    10951 | avg:   0.276 ms | max:  39.698 ms | sum: 3021.575 ms |
  blogbench:4181        |  16348.799 ms |    10064 | avg:   0.285 ms | max:  39.266 ms | sum: 2871.963 ms |
  blogbench:4176        |  15557.432 ms |     8826 | avg:   0.381 ms | max:  37.174 ms | sum: 3366.757 ms |
  blogbench:4182        |  19597.634 ms |    12680 | avg:   0.289 ms | max:  36.001 ms | sum: 3669.867 ms |
  blogbench:4179        |  17484.541 ms |    10899 | avg:   0.327 ms | max:  32.517 ms | sum: 3565.309 ms |
  blogbench:4183        |  15369.613 ms |    11474 | avg:   0.256 ms | max:  32.484 ms | sum: 2934.823 ms |
  blogbench:4180        |  17114.917 ms |     7941 | avg:   0.408 ms | max:  32.041 ms | sum: 3242.867 ms |
  blogbench:4175        |  10835.899 ms |     3204 | avg:   0.356 ms | max:  29.878 ms | sum: 1141.257 ms |
  blogbench:4173        |  11471.599 ms |     2938 | avg:   0.392 ms | max:  28.987 ms | sum: 1153.089 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                | 265634.961 ms |   506626 |                 |       40.177 ms |     49808.651 ms |
 ----------------------------------------------------------------------------------------------------------

6.4.10-eevdf virgin
 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  blogbench:6759        |   4969.658 ms |     3906 | avg:   0.732 ms | max:  27.500 ms | sum: 2860.151 ms |
  blogbench:6770        |  23275.253 ms |    14462 | avg:   0.321 ms | max:  20.348 ms | sum: 4642.321 ms |
  blogbench:6764        |  10269.476 ms |     3651 | avg:   0.444 ms | max:  20.153 ms | sum: 1621.928 ms |
  blogbench:6762        |  10399.828 ms |     3555 | avg:   0.475 ms | max:  20.087 ms | sum: 1689.091 ms |
  blogbench:6776        |  21011.106 ms |    15849 | avg:   0.290 ms | max:  19.485 ms | sum: 4598.075 ms |
  kworker/u16:1-e:5339  |   5160.247 ms |    82402 | avg:   0.056 ms | max:  19.024 ms | sum: 4626.026 ms |
  blogbench:6760        |   4907.866 ms |     3742 | avg:   0.716 ms | max:  18.101 ms | sum: 2679.361 ms |
  blogbench:6758        |   4937.399 ms |     3963 | avg:   0.677 ms | max:  17.450 ms | sum: 2682.504 ms |
  blogbench:6767        |  18588.108 ms |    10497 | avg:   0.430 ms | max:  17.372 ms | sum: 4515.504 ms |
  blogbench:6771        |  19485.111 ms |    10453 | avg:   0.391 ms | max:  17.009 ms | sum: 4084.894 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                | 296257.549 ms |   586072 |                 |       27.500 ms |     78716.789 ms |
 ----------------------------------------------------------------------------------------------------------

6.4.10-eevdf WAKEUP_DEADLINE
 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  blogbench:7137        |  25101.783 ms |    14411 | avg:   0.310 ms | max:  41.585 ms | sum: 4472.840 ms |
  blogbench:7143        |  22564.665 ms |    13603 | avg:   0.311 ms | max:  41.051 ms | sum: 4235.135 ms |
  blogbench:7138        |  23607.049 ms |    14775 | avg:   0.276 ms | max:  24.185 ms | sum: 4075.245 ms |
  blogbench:7133        |  10642.876 ms |     3114 | avg:   0.594 ms | max:  21.304 ms | sum: 1849.157 ms |
  blogbench:7126        |   4900.276 ms |     3188 | avg:   0.855 ms | max:  21.100 ms | sum: 2725.992 ms |
  blogbench:7131        |  10280.962 ms |     3209 | avg:   0.591 ms | max:  20.345 ms | sum: 1897.020 ms |
  kworker/1:0H-kb:5226  |   1059.870 ms |    89053 | avg:   0.019 ms | max:  18.226 ms | sum: 1657.880 ms |
  blogbench:7140        |  22845.026 ms |    13193 | avg:   0.345 ms | max:  18.215 ms | sum: 4548.112 ms |
  blogbench:7141        |  22977.420 ms |    14292 | avg:   0.330 ms | max:  17.376 ms | sum: 4717.075 ms |
  blogbench:7135        |  22996.398 ms |    12226 | avg:   0.337 ms | max:  16.682 ms | sum: 4118.248 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                | 312915.682 ms |   571062 |                 |       41.585 ms |     81987.387 ms |
 ----------------------------------------------------------------------------------------------------------

6.4.10-eevdf WAKEUP_DEADLINE XXX
 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  blogbench:4462        |  19047.513 ms |    10408 | avg:   0.374 ms | max:  23.974 ms | sum: 3894.010 ms |
  blogbench:4464        |  18542.851 ms |     8309 | avg:   0.461 ms | max:  22.786 ms | sum: 3833.045 ms |
  blogbench:4454        |   5168.071 ms |     1892 | avg:   0.774 ms | max:  19.453 ms | sum: 1463.996 ms |
  blogbench:4469        |  18260.551 ms |     9593 | avg:   0.390 ms | max:  18.606 ms | sum: 3742.130 ms |
  blogbench:4467        |  18285.308 ms |     9095 | avg:   0.444 ms | max:  18.176 ms | sum: 4041.126 ms |
  blogbench:4461        |  16543.137 ms |     8470 | avg:   0.432 ms | max:  18.155 ms | sum: 3656.709 ms |
  blogbench:4470        |  16395.913 ms |     8358 | avg:   0.454 ms | max:  17.316 ms | sum: 3795.385 ms |
  kworker/u16:6-e:67    |   3952.031 ms |    33202 | avg:   0.101 ms | max:  17.238 ms | sum: 3344.452 ms |
  blogbench:4453        |   5281.302 ms |     1755 | avg:   0.872 ms | max:  16.601 ms | sum: 1530.829 ms |
  blogbench:4465        |  17635.375 ms |     6986 | avg:   0.551 ms | max:  16.107 ms | sum: 3848.489 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                | 272453.638 ms |   427507 |                 |       23.974 ms |     68015.737 ms |
 ----------------------------------------------------------------------------------------------------------

6.4.10-eevdf RUN_TO_PARITY
 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  kworker/7:2H-tt:4421  |    360.323 ms |    35601 | avg:   0.040 ms | max:  29.541 ms | sum: 1433.946 ms |
  kthreadd:4527         |   3680.986 ms |    33028 | avg:   0.095 ms | max:  29.180 ms | sum: 3147.411 ms |
  blogbench:4520        |  17032.741 ms |     7149 | avg:   0.360 ms | max:  20.841 ms | sum: 2575.967 ms |
  blogbench:4518        |  16433.272 ms |     6425 | avg:   0.462 ms | max:  20.177 ms | sum: 2967.848 ms |
  blogbench:4517        |  16930.930 ms |     7137 | avg:   0.443 ms | max:  18.468 ms | sum: 3158.274 ms |
  blogbench:4515        |  17921.101 ms |     6469 | avg:   0.454 ms | max:  18.389 ms | sum: 2937.433 ms |
  kworker/u16:4-e:65    |   4764.526 ms |    36137 | avg:   0.099 ms | max:  17.966 ms | sum: 3571.866 ms |
  blogbench:4523        |  18151.172 ms |     9356 | avg:   0.306 ms | max:  17.855 ms | sum: 2866.256 ms |
  blogbench:4506        |   5139.457 ms |     1653 | avg:   0.945 ms | max:  17.768 ms | sum: 1562.387 ms |
  blogbench:4524        |  16104.410 ms |     7232 | avg:   0.414 ms | max:  15.995 ms | sum: 2992.634 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                | 269989.455 ms |   410693 |                 |       29.541 ms |     62477.554 ms |
 ----------------------------------------------------------------------------------------------------------

WAKEUP_DEADLINE XXX
---
 kernel/sched/fair.c     |   10 ++++++++++
 kernel/sched/features.h |    1 +
 2 files changed, 11 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7959,6 +7959,16 @@ static void check_preempt_wakeup(struct
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
+	if (sched_feat(WAKEUP_DEADLINE)) {
+		/*
+		 * Only allow preemption if the virtual deadline of the next
+		 * task in line is earlier than that of the current task.
+		 */
+		if (deadline_gt(deadline, se, pick_eevdf(cfs_rq)))
+			goto preempt;
+		return;
+	}
+
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -25,6 +25,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  * Allow wakeup-time preemption of the current task:
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
+SCHED_FEAT(WAKEUP_DEADLINE, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)


RUN_TO_PARITY hacklet.
---
 kernel/sched/fair.c     |   12 ++++++++++++
 kernel/sched/features.h |    1 +
 2 files changed, 13 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
+	/*
+	 * Once selected, run the task to parity to avoid overscheduling.
+	 */
+	if (sched_feat(RUN_TO_PARITY) && curr)
+		return curr;
+
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
 
@@ -7959,6 +7965,12 @@ static void check_preempt_wakeup(struct
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
+	if (sched_feat(RUN_TO_PARITY)) {
+		if (pick_eevdf(cfs_rq) != se)
+			goto preempt;
+		return;
+	}
+
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_FUDGE, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed

