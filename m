Return-Path: <linux-kernel+bounces-54022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF184A95E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA071F2977B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCCE1EF1D;
	Mon,  5 Feb 2024 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KtDpLw9a"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D61DA4F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172436; cv=none; b=JbvKIUzq3YuudRnm4psMuoI9Mz4L65eV7rVs8avroZ8fJJBq00v4KVFnH3Z4gJYJu9b0hrLCNWl96Jpv0tDREFDVMxp5/vawVyLRxC81oBUEEYqZXum5gkIwUqEEBbk8V08IR20S3ciPJJwqzV/beAva01Rae+r48UK5q4/moyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172436; c=relaxed/simple;
	bh=o09bJNe2aPlOc4wEVVCFX99Itolqrn+DMkuDdxPZmL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJr1n7mIV+c+nepLp8q1cVTMgaKKZ0G//k5OgAA3YN2G5wrb7fYBGLHB83JWkSNDfer2BYG497ZN99VDjLv3Un67r1IdGOYNIXyyw9oAdUoELQwA8EIkcD9w8raVG8pZe0UWuMROczIm9YAq00yEK+EJiWG9xYV1IHEWrjGzMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KtDpLw9a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso32356605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707172433; x=1707777233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY1lzE5VEUo7Pt+XZThzXzxrEgjs9qyVbUJyIn6kri0=;
        b=KtDpLw9aiByQn57ungVFBde55fLU25ooC4xDn+6Tl8VHPYZmDaO3fvYqSXkJ/637xs
         ia3+pGhjDmru9cy0mkieH+GwvgEdS6pOoQV+RovxueNAUI/E0tiZstrvweUZk3zLImiV
         YFtQHT1m6+wKUo/iAZ/QDTBooIqDibcvS7kPR4sYQS1TBncGbph/ZoXgiPljRu+YDIQI
         QIH9JIcN6ZoBGxVjPMf+8dT4afw5TQfccN3jVLIlwsteP60g0+4Bn5Ar3T+ZQvI1WOOM
         TZ1mIVtWCy3bFDt9Qf2Bf0afP3drzHYcg4SvYnqD07JTe5TitVyk84U1/T/si2HLcX/q
         AixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172433; x=1707777233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY1lzE5VEUo7Pt+XZThzXzxrEgjs9qyVbUJyIn6kri0=;
        b=Z4fHb0y4zgCoElFr6rMtkwpG/TYGwkb2bYLPxIHYdDT561JuNMHKXp6M1OMqE9Y3Sq
         UHkkFPqFbAHdFblPVRVdWxp4ZYBd5OkKnD0aZGy/kM0/F+Nxp0/8QCn9GDr+qBljawMK
         6Lu6vF6RuVtDYEPfVmZe5qzOHmBCWXdtyme+k6X83EmBk3W1YaWjUTDCT+l9eVTaW0J/
         FDEy85O9+suc7AUzth6/LkldRukk+hH6tV7Lh2eLXzd9bVdoZl1yMe4FP+lacCASB0IE
         jDOMMiOGSwBCs33wm474+voK5JL3ZnOzEoSzhhd7Cx4Zk+nF9qBZRWT4CXorOBeQL3tZ
         Fmjw==
X-Gm-Message-State: AOJu0YzQskkYXy7cOGqfaUTyvhQDz323CbuIRI0FBe6Zcb1jTfgPmlu8
	uC9cMAVnVnKo68tT/9KU0r6Cr0z6GCz9hdynqBmn/VS+4h0ua1wUt9XrpGC41O8=
X-Google-Smtp-Source: AGHT+IEa256iVreweYj5QPTJJv8XeCIPX0vQVWQ5m6tURl9J1Q+iPY7b0LTE+RYEPkbf/HMbysLoFQ==
X-Received: by 2002:a05:600c:4f03:b0:40e:fc29:f527 with SMTP id l3-20020a05600c4f0300b0040efc29f527mr905694wmq.31.1707172433228;
        Mon, 05 Feb 2024 14:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXvkqZIJXSYM7yT+EdMqU4DaLVdUs5s1fbz68E4KmV/SO5uLdBByVDmxO56sU2tC5fc3GbQLN2Idn1EAcbP8I4UVVKizOO5aka+IOqdotIvWnkNPC7bzXGpLyV8TLL7FRbIFh9lhQ0SI7CNOAfXF/k3tiGicSSm6OcyRJU/N5tVSkkucJu8+R6KB1j2qnXLe9PHLgiCX7WiO35PojK4ix2L/FiA15u/zW4UH4cL/KSEPzwMglTvQ6kiQL/GaykFzPzwkkzPnynPKpNI9JR3il5BDzvTpOLUKsw6TllX4w==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id hi2-20020a05600c534200b0040ef702a338sm9683135wmb.25.2024.02.05.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:33:52 -0800 (PST)
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
Subject: [PATCH 2/3] sched/pelt: Add a new function to approximate runtime to reach given util
Date: Mon,  5 Feb 2024 22:33:43 +0000
Message-Id: <20240205223344.2280519-3-qyousef@layalina.io>
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

It is basically the ramp-up time from 0 to a given value. Will be used
later to help remove magic margins with something more deterministic.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 81555a8288be..00a1b9c1bf16 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c15ff5ef5a4..d078e6481bd0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3003,6 +3003,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


