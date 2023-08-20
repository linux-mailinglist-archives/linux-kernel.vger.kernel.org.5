Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B3782012
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjHTVIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjHTVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:08:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865994230
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3198d2745feso2389177f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565684; x=1693170484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6qFJPzVrYvXdJFLmkCCK0atIYbjN/54u4wyc75/JBA=;
        b=HgG+fO1k7dm+jpnKvEM5X5dUvf//duLry6vdxj39GAjwCvPChkZJ8V6NrPGsycssq6
         WBi4ahdeVIDEBq2LPdZCZKF8GX++0qJ/OwIiqTxyaKrRo9r4fCKc6TP36YZkImJBVoEJ
         dJz1P3os9ETaqjObgP/XD7xDMyZrScTkZQVQauNzJ8oDELiqWLY07ADiEQ46vCr1fb87
         L/vQ0U8ue4POOVJwDdSSXO/LxX5frec8MHiD8zyKEak7BWWiBFy3X+dKxCBAI8TQCiRl
         DrdistocMSk3YQbjmIpESR5eLSXLmon5CDzSxue3x4M0klKy2wzg+Yp17lhADIZVFX8u
         X32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565684; x=1693170484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6qFJPzVrYvXdJFLmkCCK0atIYbjN/54u4wyc75/JBA=;
        b=OpxAA3gt4jk+sevkIGr2OBewaQjRoa1l9745FyoF4iFKukTDZTvc15EK5u+PIbHzy4
         szCcqy+ElKIW01z3FcrXXn0XXE2tqW5PU+aHc5y2kqzLlkvp+GSYubqjSO7BoNkEWCq+
         gyA/slnJ8m2n1ozuRwumCEWN1p3Txg699lC5727OnvgqldV38yFh4AbaaPzCQttmY9xi
         9wMu7PXTmgTwqa7jdybC0fP21YcM6eQdkcxMflcZS33nKYCeuBMiG8GvRvcj1NqKSQx2
         VDx6E/72gXkTuEDIakrROwE03UcFNqgxjinLcGNi8qR9I0y0hYtdelhxQxGZ09sZDYO9
         T9Hw==
X-Gm-Message-State: AOJu0YyN0uvivWO6yBntzxATvSKPsOvgTrbmXN7uI3+pgt0UKSADawqM
        hExnvS/gDkFwcU6nDcIqDFCbOg==
X-Google-Smtp-Source: AGHT+IGTizLO4t/BYhWwB0zqwdQLDBDyphgkRD7gCuJ1OhbkmLiRC3MOreod/y3MppTTTWxtqnCK6g==
X-Received: by 2002:a5d:4fc6:0:b0:319:5e0d:9b0f with SMTP id h6-20020a5d4fc6000000b003195e0d9b0fmr3356883wrw.33.1692565684026;
        Sun, 20 Aug 2023 14:08:04 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j6-20020adfea46000000b003197a4b0f68sm10336800wrn.7.2023.08.20.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:08:03 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 1/4] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
Date:   Sun, 20 Aug 2023 22:06:37 +0100
Message-Id: <20230820210640.585311-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820210640.585311-1-qyousef@layalina.io>
References: <20230820210640.585311-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are providing headroom for the utilization to grow until the next
decision point to pick the next frequency. Give the function a better
name and give it some documentation. It is not really mapping anything.

Provide a dummy definition for !CONFIG_CPUFREQ which will be required
for later patches.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/energy_model.h     |  2 +-
 include/linux/sched/cpufreq.h    | 27 ++++++++++++++++++++++++++-
 kernel/sched/cpufreq_schedutil.c |  6 +++---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..6ebde4e69e98 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,7 +243,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
 
-	max_util = map_util_perf(max_util);
+	max_util = apply_dvfs_headroom(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..f0069b354ac8 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -29,10 +29,35 @@ static inline unsigned long map_util_freq(unsigned long util,
 	return freq * util / cap;
 }
 
-static inline unsigned long map_util_perf(unsigned long util)
+/*
+ * DVFS decision are made at discrete points. If CPU stays busy, the util will
+ * continue to grow, which means it could need to run at a higher frequency
+ * before the next decision point was reached. IOW, we can't follow the util as
+ * it grows immediately, but there's a delay before we issue a request to go to
+ * higher frequency. The headroom caters for this delay so the system continues
+ * to run at adequate performance point.
+ *
+ * This function provides enough headroom to provide adequate performance
+ * assuming the CPU continues to be busy.
+ *
+ * At the moment it is a constant multiplication with 1.25.
+ *
+ * TODO: The headroom should be a function of the delay. 25% is too high
+ * especially on powerful systems. For example, if the delay is 500us, it makes
+ * more sense to give a small headroom as the next decision point is not far
+ * away and will follow the util if it continues to rise. On the other hand if
+ * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
+ * at a lower frequency if it never goes to idle until then.
+ */
+static inline unsigned long apply_dvfs_headroom(unsigned long util)
 {
 	return util + (util >> 2);
 }
+#else
+static inline unsigned long apply_dvfs_headroom(unsigned long util)
+{
+	return util;
+}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..916c4d3d6192 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -143,7 +143,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
-	util = map_util_perf(util);
+	util = apply_dvfs_headroom(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -406,8 +406,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
-				   map_util_perf(sg_cpu->util), max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, apply_dvfs_headroom(sg_cpu->bw_dl),
+				   apply_dvfs_headroom(sg_cpu->util), max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
-- 
2.34.1

