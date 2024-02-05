Return-Path: <linux-kernel+bounces-54021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B384A95D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDFA1F29E33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E0C17552;
	Mon,  5 Feb 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="j2FTQNzy"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFFE1AB814
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172436; cv=none; b=Jofm6qKBwp6DNKrQprSQ9fxO26LeFVwQjRimLLrInIJmIi9b7rN7UR3ZBZM+IrvwyBiNwRViGy9xd6zn1BPpGba3FaXQkjAqd55VrJpnz/U6Cvfi2EnV2UllbSV+/66q5sbOJgOgvX2H80FTQu4Qz9SRieHHdkrzarNnb3cMGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172436; c=relaxed/simple;
	bh=DbQcm0a3M/AsKYK9hyqutmK2DhHtvv2jn4TKd7OI4QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAEzG4YI7TVCQCQAbDMoEi+2IrTy8FKTCduyf6dg04QjQ4U6xhlHxlcz22qBilZiGql0rXIFsnCvqS6QJJV8KrTHM8AjSoAHYh6sfUkmEvYwuAYr+5W8x9g4Rgeakk9+WDRcUaijFIezd9Z0bZTtJGwqt+pslQFhMFeEnYmFWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=j2FTQNzy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b45befbbbso100127f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707172432; x=1707777232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hiMd0UBDCAFg7Es0dAzOSGkIUEebklJELnGHhQIERE=;
        b=j2FTQNzypyBkOcy2Ql+x3K75lpX5sUy4PYpeHM5aLD25poG8H+QrRXXEyHN+QJjiy9
         1CtnaANAEF0zNJF4vg9rgsfMQKGm5qYW0kSR8TZI0cYzZZ/rnU7Xa6fO79zapIhgN4U4
         v4za6/G+/xxktyY1sngCyR1IPP3q9/Y+cO6cDyJIVI6PVEFdsoN7n7lV7UFmE1m0CBLZ
         P44SW9PU3AQO2nbvpbPCidPaZph0aQEQkE5Mz0aLytrk+c0M0JqtszXicIivYqoYjmin
         AYeSAbNH1rDfxRJC+z6GL3sa+NIaKT38A7t+qWIE6jNmqe8b/UOa2tmXA5kSuzrM49aQ
         rqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172432; x=1707777232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hiMd0UBDCAFg7Es0dAzOSGkIUEebklJELnGHhQIERE=;
        b=szAjfeYlwT6y7MZb1a1FHVot1DDktJNiwNInNH+clR58VXuJV5NSWGYN3LpPDOEWwW
         +vWS/F73A1qUX/HMXhIsvHCjclTpkKBCVfMJUwb2F1TBRDshqzyLAhMwXbFas9CJG6Hp
         ie6wNVLc6dnQ42cvnr/6Pi2yRnFRG7Hw0hz1pqG062E/m967XpGWIhU/z1MQaHYM4Bnl
         mJKdBv33MESc2Tr0mrkVDShWsiow0NjYkCtdzy9HudrOLy8aRTrWaHnn9BZGdIr4gkx0
         wXElnFHkF/1JXV/XbejOkCjg7QC88z9/nnQDEHnT97AUkCAJRDTSk/61KGlvZMVXB+Dv
         bdBQ==
X-Gm-Message-State: AOJu0Yy5lQb4OD1PStASC3nHjvsL8juTDPMqPsFJAVGyqIVt6E3lct0+
	DoCfO+BbJNPCjl0Dsy2Vttakx8RFybbLjBjezorz6P1uhNUSgDkR3/mZTQGS780=
X-Google-Smtp-Source: AGHT+IFXDu/mc/UYviUNnoq+S96GfsehHvQY5Im2mDj5D7woew3KodEItnjoB8gcGqwb+THzAAB9QA==
X-Received: by 2002:a05:6000:146:b0:33b:2177:2228 with SMTP id r6-20020a056000014600b0033b21772228mr174772wrx.59.1707172432328;
        Mon, 05 Feb 2024 14:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqIOICRsJFMHlBs1K9HfcbG9hi75g7DdeW8naV+QzppV1a/AZ2wFHZzX41WbhqTnulvSEam3lx6fEAar9XXMe004O/PctdIyJkvzdW/xDxDuu0NlzY+fTjPyEkeVCFWwYGjUYUEFrZsWwSLmmieuBVt82SGJ3fn4pLKFGc1piM76U4qE4c2+W+O33sl9LUEJuAl2FM2aVwqcBYLTkzT9E2/5SjZg/8fyq1MdkNlcP383vxEwnYSqbupXRoApIrc5nXtw8MZ6RlJqDer9dPr68f30zOFfR51EV6v2iC3A==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id hi2-20020a05600c534200b0040ef702a338sm9683135wmb.25.2024.02.05.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:33:51 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 1/3] sched/pelt: Add a new function to approximate the future util_avg value
Date: Mon,  5 Feb 2024 22:33:42 +0000
Message-Id: <20240205223344.2280519-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205223344.2280519-1-qyousef@layalina.io>
References: <20240205223344.2280519-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given a util_avg value, the new function will return the future one
given a runtime delta.

This will be useful in later patches to help replace some magic margins
with more deterministic behavior.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 22 +++++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 63b6cf898220..81555a8288be 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -466,4 +466,24 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 
 	return ret;
 }
-#endif
+#endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
+
+/*
+ * Approximate the new util_avg value assuming an entity has continued to run
+ * for @delta us.
+ */
+unsigned long approximate_util_avg(unsigned long util, u64 delta)
+{
+	struct sched_avg sa = {
+		.util_sum = util * PELT_MIN_DIVIDER,
+		.util_avg = util,
+	};
+
+	if (unlikely(!delta))
+		return util;
+
+	accumulate_sum(delta, &sa, 1, 0, 1);
+	___update_load_avg(&sa, 0);
+
+	return sa.util_avg;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..1c15ff5ef5a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3002,6 +3002,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
+unsigned long approximate_util_avg(unsigned long util, u64 delta);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


