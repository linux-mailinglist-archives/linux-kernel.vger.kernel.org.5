Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F380E7BCD87
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjJHJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:32:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D3B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:32:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso632837766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696757576; x=1697362376; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vMfnLNNge0Egvi2PdzjDXEK3R3wR5gsgC/C7t5aFptQ=;
        b=OcLWAtrkxKMFjCGcRhFa8/WttZDffykVvnyZlVzoOrczTe2pl7Cxy9+ah3QnDxcWSi
         QUFrd4qAe3nUM46xztkmYtM7kx/PtrqDQ6d28Mt0tlNCDgC0q4W/j+xJmbHPfhueLEY8
         MXkiPuit1Xul+wvfQDh7bXroazB9dgCLAqTTSgj0ugGBU4fholJSMaXWDk0GYUD9czvr
         /vA9Cn7LyyZXVOat4phuascMrwlC1bjcwqdi/tnxn0anRWjpbbO928F0Lt9QDzRllzX5
         dUV4bJydGVRd9V35URbHhe+y/YeTS9jzSvvx+5ekm5Suztu6YEFyirkB2cyZ2aVCuEzA
         tn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696757576; x=1697362376;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMfnLNNge0Egvi2PdzjDXEK3R3wR5gsgC/C7t5aFptQ=;
        b=lmSkkmDrw/ATU6pqBSOG4V3hsBnsWL5wC1Frzju132gSl6TGni8KDshKY24lpNwH+U
         VJC6eetYwNU5vI/h7+MYkukj6ZIYlHbV1DlatjhvZn3goyN9CZwNekNuRt7x9Ys83pvW
         fdIIP+nEqh9zmh0CLZvHhZQx+5G5YdMC/nUPU2ArXNz7mR038kK8JiDe/cu/tuYfj9Ab
         cWhPCfg6mAr4aKzdvR+lE1b0uwSPduNRARlEfcuFtREj0pkAmOAAXB57ki6pmEmKiHQE
         aj5hEnJBLkhdB7h54PxCrJNxXG6pdkqfrLK8gjH0ZxmweDz8Nz7kkMMOSgjXHa93BPlw
         UHgw==
X-Gm-Message-State: AOJu0YzGxzp7ftilqdRbnvunPZwZEenSQewu5MCgjAz9qZaDeqfDnLdt
        I+7u7B6/0iJcuYKT4mNyug0=
X-Google-Smtp-Source: AGHT+IFJYDgU61vkxe3RE1ySUSdcrnp+QTPNm/gU6yFaBAB4w+oci0fmd19Rl5WZ15CF8eRDfcH0oA==
X-Received: by 2002:a17:906:30db:b0:9ae:41db:c27f with SMTP id b27-20020a17090630db00b009ae41dbc27fmr12211947ejb.10.1696757576413;
        Sun, 08 Oct 2023 02:32:56 -0700 (PDT)
Received: from gmail.com (195-38-113-164.pool.digikabel.hu. [195.38.113.164])
        by smtp.gmail.com with ESMTPSA id qb40-20020a1709077ea800b009b9af27d98csm3894797ejc.132.2023.10.08.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:32:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 8 Oct 2023 11:32:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZSJ3RN+kA91R8+f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-08

   # HEAD: 9e0bc36ab07c550d791bf17feeb479f1dfc42d89 cpufreq: schedutil: Update next_freq when cpufreq_limits change

Misc fixes:

 - Two EEVDF fixes: one to fix sysctl_sched_base_slice propagation,
   and to fix an avg_vruntime() corner-case.

 - A cpufreq frequency scaling fix

 Thanks,

	Ingo

------------------>
Peter Zijlstra (2):
      sched/eevdf: Also update slice on placement
      sched/eevdf: Fix avg_vruntime()

Xuewen Yan (1):
      cpufreq: schedutil: Update next_freq when cpufreq_limits change


 kernel/sched/cpufreq_schedutil.c |  3 ++-
 kernel/sched/fair.c              | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..458d359f5991 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	 * Except when the rq is capped by uclamp_max.
 	 */
 	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..ef7490c4b8b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -664,6 +664,10 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
 }
 
+/*
+ * Specifically: avg_runtime() + 0 must result in entity_eligible() := true
+ * For this to be so, the result of this function must have a left bias.
+ */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -677,8 +681,12 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		load += weight;
 	}
 
-	if (load)
+	if (load) {
+		/* sign flips effective floor / ceil */
+		if (avg < 0)
+			avg -= (load - 1);
 		avg = div_s64(avg, load);
+	}
 
 	return cfs_rq->min_vruntime + avg;
 }
@@ -4919,10 +4927,12 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	u64 vslice = calc_delta_fair(se->slice, se);
-	u64 vruntime = avg_vruntime(cfs_rq);
+	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
+	se->slice = sysctl_sched_base_slice;
+	vslice = calc_delta_fair(se->slice, se);
+
 	/*
 	 * Due to how V is constructed as the weighted average of entities,
 	 * adding tasks with positive lag, or removing tasks with negative lag
