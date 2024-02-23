Return-Path: <linux-kernel+bounces-78657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7886169D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94614288D25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675484A49;
	Fri, 23 Feb 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YXeyTTYw"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C84A29
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703899; cv=none; b=QSDTCf8wZ51I0jSL3SNlFraJZtq5s6egVvXSbx4GmkNVxn9k7MnCS6inNMZOTh/kih5bCrjm7gYG/+slVwDZsCj2DHQg/9au64BntFekCKrEx+Jv2mnu0yd6uk1ycrLWRJK/cThszNcMUCPXeTrz1tFecjks2fHPb/uMV5Zp9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703899; c=relaxed/simple;
	bh=verFB4RWW2WKHBdwnW5wGBh0OHUpCbgBY9nBGkAThvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+/TSi/c8T0BLnowkF+03lsaDEVBRKmIDtYho0vstoibOSkFxuj/YSAV8Ad08jrO0YeW6k/+r89XpR0E1JT5Gdr6z/G6w5FuRtGQJ2g6WwRWx8spaIFLQ+O9cW2rHito+B/UgDkkNRXeCKLtebiYsyaFuJCcyo1gO/p7oFEoxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=YXeyTTYw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so82802966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708703896; x=1709308696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4BYLr0MWlji1r8Yd3MAsjyyUgmFtEg5Rxw6JJBPkks=;
        b=YXeyTTYwcoIAVJ/AeTKf+QibCFXJOubNU7kaqapP71SJhPdcorEKY1IFP0Ddu60xGo
         hLARODPjotg1kUiHZStUtlRRis+HWyJf5tURVyL1hiij6KoYzDLqLtuYN51k2aD7Fsju
         DPyVMFmIGcPv3Yns6nLp876sOIFaIPiOeUZ3pjMUhbiPXu9CXcfqDpuFBIYvmdp7G/7N
         hKsTUNO1Pd+/q+95NV3F9JNo4T4P7B2voPy4woGEzqJfWK37vFMmOMEMdxnMxduMzO4M
         8uC68yqumtsB3nmEJq530KwSg80oecc9VmK0ByuegrZM8EHzQPGxwmFF1RoUjvqStonJ
         1HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703896; x=1709308696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4BYLr0MWlji1r8Yd3MAsjyyUgmFtEg5Rxw6JJBPkks=;
        b=qafiseHB60G5Qz2c0C8Qp7Q4ECfABScNa5AENNunxfYPWjbZFuvoN4lLR8DRnCE5iT
         j4f87IWIbe5jGa3jHQXzeUaLoL8cDbThyphmJxkbdXWYPra8UtVJqtdtR8zFY/X3iWLZ
         gP5IlD0wjKT+AO7qHITTN/zK6xf0oSiYNAFLrWDSxa2MEktpgUlPDedMKsd3gADgi+Gd
         JC26wM2G2juRpuNk7yEnw1Y/6DLtm4YeX43pkUz6cOFArw953Ap+yB54UJTtHOn0EYvW
         VBODDxThJwAdZUqr9JVPW4gXa69mpPyJHQ74t9284lxnddnEWLpMH1Ym5+duZt2ZOPlJ
         uxEg==
X-Gm-Message-State: AOJu0YzSMSMxeBX6KX25ZYxVr1XlKtMfNYp+iJexFPCPGIr85Gx8lUA6
	bDLcVxoDvzCe04+N5KAfvjKevB0m4MlpQEG9zybQgtuGHBow353YOkOdPLkb7xk=
X-Google-Smtp-Source: AGHT+IGciSpnmtF5umI7fTlobqNT5Txu6kdgb58OFFOx1loOQKb7N2Mc81T6S4yNfG+f8pQ1k1RWFg==
X-Received: by 2002:a17:906:cec5:b0:a3f:6ff9:6280 with SMTP id si5-20020a170906cec500b00a3f6ff96280mr137907ejb.50.1708703896578;
        Fri, 23 Feb 2024 07:58:16 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3e28471fa4sm6461293ejc.59.2024.02.23.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:58:16 -0800 (PST)
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
	Christoph Hellwig <hch@infradead.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 1/2] sched: Add a new function to compare if two cpus have the same capacity
Date: Fri, 23 Feb 2024 15:57:48 +0000
Message-Id: <20240223155749.2958009-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155749.2958009-1-qyousef@layalina.io>
References: <20240223155749.2958009-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new helper function is needed to help blk-mq check if it needs to
dispatch the softirq on another CPU to match the performance level the
IO requester is running at. This is important on HMP systems where not
all CPUs have the same compute capacity.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/topology.h |  6 ++++++
 kernel/sched/core.c            | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4a21d7..11e0e00e0bb9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,6 +176,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
+bool cpus_equal_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
@@ -226,6 +227,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
+static inline bool cpus_equal_capacity(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a76c7095f736..adbaabb23fa1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3953,6 +3953,17 @@ void wake_up_if_idle(int cpu)
 	}
 }
 
+bool cpus_equal_capacity(int this_cpu, int that_cpu)
+{
+	if (!sched_asym_cpucap_active())
+		return true;
+
+	if (this_cpu == that_cpu)
+		return true;
+
+	return arch_scale_cpu_capacity(this_cpu) == arch_scale_cpu_capacity(that_cpu);
+}
+
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	if (this_cpu == that_cpu)
-- 
2.34.1


