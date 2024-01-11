Return-Path: <linux-kernel+bounces-23551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A7282AE58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AA01F23558
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58C3D56A;
	Thu, 11 Jan 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUHgcmRR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B3D560
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9bee259c5so3248977b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704974506; x=1705579306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIff4/qjqGgbNQHbzuveiRWYcCPjJbqX4XzT3I6acIw=;
        b=kUHgcmRR2kka1rZ0EiqaPf1wlTY3imJ5skDtxXUgs5yvce3fW5YLPXDtk5E25HmMiF
         nuI6ptdEbML3oSB60R56JRseb8xBIiX29x7mx7CS3RCa02QaddWxMrKgg8anrBSUryE7
         w0izwuXw4nedKPY8XbfCNMrDIGHL8Ta8ZHnZM8SgBGaNOSH0ipZyxeNa1hNCHIs1zqZG
         qQfrpYZRwmgpBRVqp/+JdJFfoDwnGgGRW9surTXUryewsxMJC1YriejHd7wJErhlol17
         ST7bPy0/LaCNd/XBeiblWi+AZcRPF9Q7KMVa/SiO2zdRMQWyAtX4vsv9fziTwNVR5YVe
         bXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704974506; x=1705579306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIff4/qjqGgbNQHbzuveiRWYcCPjJbqX4XzT3I6acIw=;
        b=J88HV5JBdfXzPMoeSmn3ZyUZmO1M79zZ6P78dTwEfEaKBcizMSPq6PYPlvYJzwvYO8
         6PNzeQS6PZCSk7JEf8vQRSgeQZadii21Y4kmEoy4Pox0qRCGtvKhgvLENDIRkAytBA67
         UIOSoze06UrtXXAQL4QmrVzywGyROBY4WGV2t73Ndxox7nLUXEEO+M4aoltSNZ7b9OlU
         UMMhvcB3L9R8r2T5vIdTYPFsfJm2lxVY5rNCDQ0V9CQD+6b1BNT101YZLivNWdzk4wt+
         4rt5CIREHxcuvrFVlXGK+H6ghuYGX5YdokcbAc+oeTI+C4QUqanp54MH09jpTSsjDgFE
         lthQ==
X-Gm-Message-State: AOJu0YwcMMnf1uJIHdhRGrPvW24JMm3JkFam6IwWmNMv8zyAo0LajK9M
	aM9BPHnnYck9D8QGPIXFGME=
X-Google-Smtp-Source: AGHT+IHIwcpVsvRffzzdKcMfwKpuXiYqxFHzK5mVY0BtKkUvUjWJ2r8wXmQ6FYk/oEAHBWPPRoZSWQ==
X-Received: by 2002:a05:6a00:301b:b0:6d9:8e17:2ff3 with SMTP id ay27-20020a056a00301b00b006d98e172ff3mr1303063pfb.32.1704974505455;
        Thu, 11 Jan 2024 04:01:45 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.googlemail.com with ESMTPSA id kr12-20020a056a004b4c00b006ce95e37a40sm976696pfb.111.2024.01.11.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:01:45 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice as explicit time quanta
Date: Thu, 11 Jan 2024 06:57:46 -0500
Message-ID: <20240111115745.62813-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AFAIS, We've overlooked what role of the concept of time quanta plays
in EEVDF. According to Theorem 1 in [1], we have

	-r_max < log_k(t) < max(r_max, q)

cleary we don't want either r_max (the maximum user request) or q (time
quanta) to be too much big.

To trade for throughput, in [2] it chooses to do tick preemtion at
per request boundary (i.e., once a cetain request is fulfilled), which
means we literally have no concept of time quanta defined anymore.
Obviously this is no problem if we make

	q = r_i = sysctl_sched_base_slice

just as exactly what we have for now, which actually creates a implict
quanta for us and works well.

However, with custom slice being possible, the lag bound is subject
only to the distribution of users requested slices given the fact no
time quantum is available now and we would pay the cost of losing
many scheduling opportunities to maintain fairness and responsiveness
due to [2]. What's worse, we may suffer unexpected unfairness and
lantecy.

For example, take two cpu bound processes with the same weight and bind
them to the same cpu, and let process A request for 100ms whereas B
request for 0.1ms each time (with HZ=1000, sysctl_sched_base_slice=3ms,
nr_cpu=42).  And we can clearly see that playing with custom slice can
actually incur unfair cpu bandwidth allocation (10706 whose request
length is 0.1ms gets more cpu time as well as better latency compared to
10705. Note you might see the other way around in different machines but
the allocation inaccuracy retains, and even top can show you the
noticeble difference in terms of cpu util by per second reporting), which
is obviously not what we want because that would mess up the nice system
and fairness would not hold.

			stress-ng-cpu:10705	stress-ng-cpu:10706
---------------------------------------------------------------------
Slices(ms)		100			0.1
Runtime(ms)		4934.206		5025.048
Switches		58			67
Average delay(ms)	87.074			73.863
Maximum delay(ms)	101.998			101.010

In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
in this patch gives us a better control of the allocation accuracy and
the avg latency:

			stress-ng-cpu:10584	stress-ng-cpu:10583
---------------------------------------------------------------------
Slices(ms)		100			0.1
Runtime(ms)		4980.309		4981.356
Switches		1253			1254
Average delay(ms)	3.990			3.990
Maximum delay(ms)	5.001			4.014

Furthmore, with sysctl_sched_base_slice = 10ms, we might benefit from
less switches at the cost of worse delay:

			stress-ng-cpu:11208	stress-ng-cpu:11207
---------------------------------------------------------------------
Slices(ms)		100			0.1
Runtime(ms)		4983.722		4977.035
Switches		456			456
Average delay(ms)	10.963			10.939
Maximum delay(ms)	19.002			21.001

By being able to tune sysctl_sched_base_slice knob, we can achieve
the goal to strike a good balance between throughput and latency by
adjusting the frequency of context switches, and the conclusions are
much close to what's covered in [1] with the explicit definition of
a time quantum. And it aslo gives more freedom to choose the eligible
request length range(either through nice value or raw value)
without worrying about overscheduling or underscheduling too much.

Note this change should introduce no obvious regression because all
processes have the same request length as sysctl_sched_base_slice as
in the status quo. And the result of benchmarks proves this as well.

schbench -m2 -F128 -n10	-r90	w/patch	tip/6.7-rc7
Wakeup  (usec): 99.0th:		3028	95
Request (usec): 99.0th:		14992	21984
RPS    (count): 50.0th:		5864	5848

hackbench -s 512 -l 200 -f 25 -P	w/patch	 tip/6.7-rc7
-g 10 					0.212	0.223
-g 20					0.415	0.432
-g 30				 	0.625	0.639
-g 40					0.852	0.858

[1]: https://dl.acm.org/doi/10.5555/890606
[2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.programming.kicks-ass.net/T/#u

Signed-off-by: Ze Gao <zegao@tencent.com>
---

Hi peter,

I've been attempting to figure out how eevdf works and how the
idle of latency-nice would fit in it in future.

After reading [1], code and all the disscusions you guys make, I
find out the current implemention deliberately does not embrace
the concept of 'time quanta' mentioned in the paper in [2] and I
see some likely risks ( or not ?) if we are going to bring in
custom slices ( raw value or latency nice) support by not having
one.

Getting my hand dirty gives me some experimental results and it
shows that user specified slices can actually hurt fairness.

So I decide to engage in and propose this patch to explicitly use
the tunable knob sysctl_sched_base_slice as time quanta. The
benchmarks shows no regression as expected though.

Still this is just an immature idea and there should be things I
am blind of or overlook. IOW I'm unsure if it is a real
problem indeed. Hope to get some sage insights from you.

Regards,
                Ze
 kernel/sched/fair.c | 47 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..1746b224595b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -694,12 +694,13 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  */
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	s64 lag, limit;
+	s64 lag, limit, quanta;
 
 	SCHED_WARN_ON(!se->on_rq);
 	lag = avg_vruntime(cfs_rq) - se->vruntime;
 
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	quanta = max_t(u64, TICK_NSEC, sysctl_sched_base_slice);
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, quanta), se);
 	se->vlag = clamp(lag, -limit, limit);
 }
 
@@ -1003,25 +1004,47 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+	u64 delta_exec;
 
 	/*
-	 * For EEVDF the virtual time slope is determined by w_i (iow.
-	 * nice) while the request time r_i is determined by
-	 * sysctl_sched_base_slice.
+	 * To allow wakeup preemption to happen in time, we check to
+	 * push deadlines forward by each call.
 	 */
-	se->slice = sysctl_sched_base_slice;
+	if ((s64)(se->vruntime - se->deadline) >= 0) {
+		/*
+		 * For EEVDF the virtual time slope is determined by w_i (iow.
+		 * nice) while the request time r_i is determined by
+		 * sysctl_sched_base_slice.
+		 */
+		se->slice = sysctl_sched_base_slice;
+		/*
+		 * EEVDF: vd_i = ve_i + r_i / w_i
+		 */
+		se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+	}
+	/*
+	 * Make sysctl_sched_base_slice as the size of a 'quantum' in EEVDF
+	 * so as to avoid overscheduling or underscheduling with arbitrary
+	 * request lengths users specify.
+	 *
+	 * IOW, we now change to make scheduling decisions at per
+	 * max(TICK, sysctl_sched_base_slice) boundary.
+	 */
+	delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+	if (delta_exec < sysctl_sched_base_slice)
+		return;
 
 	/*
-	 * EEVDF: vd_i = ve_i + r_i / w_i
+	 * We can come here with TIF_NEED_RESCHED already set from wakeup path.
+	 * Check to see if we can save a call to pick_eevdf if it's set already.
 	 */
-	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+	if (entity_is_task(se) && test_tsk_need_resched(task_of(se)))
+		return;
 
 	/*
-	 * The task has consumed its request, reschedule.
+	 * The task has consumed a quantum, check and reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
+	if (cfs_rq->nr_running > 1 && pick_eevdf(cfs_rq) != se) {
 		resched_curr(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
 	}
-- 
2.41.0


