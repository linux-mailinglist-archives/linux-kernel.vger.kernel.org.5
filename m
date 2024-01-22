Return-Path: <linux-kernel+bounces-34256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB4837674
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F951F2769D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8E12E64;
	Mon, 22 Jan 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="RKLRbBZI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D110A04
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963391; cv=none; b=mUnnabkywjIqKmWgV7J1sA+5/8MFfylWmibtinl068wuYnkXuJiIS8cKtdT4JYxOKJbsdvsSUgGpqDLu9wseFExEKS5oeL4fV9vn1PV2++HPNXPR10UqJqEAZZSFt7IRVPy/bzcMojSvizHukxi5P3laKN3TGeq+xcmczm2oblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963391; c=relaxed/simple;
	bh=jq6waBdRNkIn/pUr1wxFo1S8k72Er9q9GsNFxc1jCWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8onQy509JzTsZQItC2rj3vyFndXeghTVQatkle9lJN3Y/7MalIzXrRHe/IFk4loZRrOIzqsbDCYIJpkExW/4sbzfdVMqVfMfGPE6OAHUI2UJ3h8advu+thLny6ec/LEqip0yvRK4VUja1/vCbmakwk3qHe9+65D2cyAou1fLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=RKLRbBZI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so47201495e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705963387; x=1706568187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HIAkUY/IV0amVuu3edtawXBj2pvEspdSiVxTepe+1A=;
        b=RKLRbBZIjEezbsnhPUeiat7Q7ReFw7qDQLP8phEw9D8P0JpFxE5I7g5dwxMhxPvDtg
         S3VmKYohHnK3bmepVwnLrOQeygSDPvxtMhdgrjjXx+zR+A2LENyin76l31e2XylenONg
         DCChTSCy8DCJ5P9CaJaEiy20WPlNzc3b6umQV5/hOrKnby+mN/GWCmM+kN09OEja8pXC
         6Fsc2eamPTG2yKVT8TWepatmMuS4yWCHadwYN9wp4Dh/4fv1IyYd1z7ANMfdRDSVAOD+
         26a7nXtV1Z/rVGjT0bOpvZTSkhi4OV2KGc9Usp/nanXXW1rzUHSyeCmdSQfl/fTGiex/
         pN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963387; x=1706568187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HIAkUY/IV0amVuu3edtawXBj2pvEspdSiVxTepe+1A=;
        b=g5MSckpQskrvNyca050dpWeJz/sWF1feaGyptoTvlqnShZ6MCsXCSxw7CWEwdLCT9m
         pfUf1CmpA13O2WPPcUbnNyNIatEc374FOCQ0u7axbdoowmn4TzFpz/3m941mvFXAI/IO
         n/LTfnyFKRHY7HoCMVAX7a8/J2FuI8AD8Xe9hz5gcqFLq1zf/WYH08Z0jokPvMxhkqe0
         k7xLsJshhATvbgHxcPYi6QyfcrSYOSLuk2/HMJUx8OQV0KEimzE9CmCoTJbXj5IOMWgv
         gMIKBzU7118dXDixAwZ+AWnpuTCfGb61tIhFHZJ/3vHEC8vMBKWz95CfTZM0GeRSC6vJ
         9Tcw==
X-Gm-Message-State: AOJu0YxUYi936W7zx0/hCqeOPVc0Wld4qvhSDGug+s2oTSJ9/ichN2m2
	TRz7hzKkzqFWeLDLCHQ49/j9Ux2y3yHxQHfmAIcJ/622yGKB2lEWJFNQXeOLYVE=
X-Google-Smtp-Source: AGHT+IEjlD5xRIOcTScuTGHjM6USJ+02b5+1PMeHVKOP7Pp8OqF4DhozZcwaJeTcrhn8QZSDG2G24Q==
X-Received: by 2002:a7b:c38f:0:b0:40e:6617:fc33 with SMTP id s15-20020a7bc38f000000b0040e6617fc33mr2680804wmj.146.1705963386703;
        Mon, 22 Jan 2024 14:43:06 -0800 (PST)
Received: from airbuntu.. ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id x16-20020adfdd90000000b00337d6539d52sm11412758wrl.18.2024.01.22.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:43:06 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] block/blk-mq: Don't complete locally if capacities are different
Date: Mon, 22 Jan 2024 22:42:20 +0000
Message-Id: <20240122224220.1206234-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
CPUs have equal capacities and only LLC cache can make a different on
perceived performance. But this assumption falls apart on HMP systems
where LLC is shared, but the CPUs have different capacities. Staying
local then can have a big performance impact if the IO request was done
from a CPU with higher capacity but the interrupt is serviced on a lower
capacity CPU.

Introduce new cpus_gte_capacity() function to enable do the additional
check.

Without the patch I see the BLOCK softirq always running on little cores
(where the hardirq is serviced). With it I can see it running on all
cores.

This was noticed after the topology change [1] where now on a big.LITTLE
we truly get that the LLC is shared between all cores where as in the
past it was being misrepresented for historical reasons. The logic
exposed a missing dependency on capacities for such systems where there
can be a big performance difference between the CPUs.

This of course introduced a noticeable change in behavior depending on
how the topology is presented. Leading to regressions in some workloads
as the performance of the BLOCK softirq on littles can be noticeably
worse.

[1] https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 block/blk-mq.c                 | 5 +++--
 include/linux/sched/topology.h | 6 ++++++
 kernel/sched/core.c            | 8 ++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac18f802c027..9b2d278a7ae7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1163,10 +1163,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	if (force_irqthreads())
 		return false;
 
-	/* same CPU or cache domain?  Complete locally */
+	/* same CPU or cache domain and capacity?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
-	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	     cpus_gte_capacity(cpu, rq->mq_ctx->cpu)))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4a21d7..31cef5780ba4 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,6 +176,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
+bool cpus_gte_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
@@ -226,6 +227,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
+static inline bool cpus_gte_capacity(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..db5ab4b3cee7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3954,6 +3954,14 @@ void wake_up_if_idle(int cpu)
 	}
 }
 
+bool cpus_gte_capacity(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);
+}
+
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	if (this_cpu == that_cpu)
-- 
2.34.1


