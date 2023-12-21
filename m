Return-Path: <linux-kernel+bounces-8495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5181B8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8EA1F26A34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9076DA0;
	Thu, 21 Dec 2023 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5T3bJqN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99173188
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3ac87553bso5366905ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165724; x=1703770524; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpbNXhFlCORRf6AkvSh2wgzVLTEkJKKTFPLpVGEOCME=;
        b=O5T3bJqNo+PF1Bprj9oyBDS50mBdccrE0/Tkt7GwxpgJCihe8qbig2SY+955HzXMk/
         8QnTPCImJiRT+2rR0AeeDOfI234WLBm926g4/A2SVFWyYzGXaE8NLy4ff+M0u9FWAYbv
         8xE5VFmQluZJJu1XewU1iotXWAqCtWapVsUokxWYovSO2oOZhmtDE91LFFePT0e5GTfG
         JtjKhnRVR1z27wBIJ8sIXy/2yIyaYPvlslaDYxwwteKnH7laMQPzeb14X4ZDc8aemIfA
         VTxq2saN0sOOGf+dBhw6WWnu+loNsZQKAm98u8JPGR37MqGgxUWVai61GFFFSWApQLXJ
         Qxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165724; x=1703770524;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpbNXhFlCORRf6AkvSh2wgzVLTEkJKKTFPLpVGEOCME=;
        b=CihlXP+Qu6jDkP5G8WBFsEYxZTHXx97xuJI6juUHPhQthi5WYnAm/LHtx44bZIUaQ2
         pZQBDQ1Ww7dpFZUVsPXEFwgCj18y5sznhVM5aSGYOe3x1LlTarXyD0u+7sEiMdHvjR0+
         ntFyGleMoiXfMNyEmQV/7UrVw4bi4yfXfBDgcPmmBcKP+stYN8hmvlxgFGgZnqrooXRR
         R5L7VoQu5zgoXDj87+PEZg6RhhNn2mC+ix2iA9EyW2J4Sl4KY6srmbKp2sHew+ICPLDd
         xhBYnJ6SrZFYqzJtWQbed1oEciO1ZQS+07hWP1QNcT0pU89a7LpiNFrqNDNVrYH710be
         njhw==
X-Gm-Message-State: AOJu0Yzd1Qrpl5og+obnYJkRySNJPPZXW16GMrlTNtd5PvwM/H/cVCof
	YnaHWEjrxn2/ETJJo0cY3jI=
X-Google-Smtp-Source: AGHT+IHQB/1adBhOw6M05kil1uk7MvpXLyxW4ar/uBq7bbgpTrEI/T5zaZN0tDu5ypbgcf5IvrgjRA==
X-Received: by 2002:a17:903:2288:b0:1d0:1e49:3f60 with SMTP id b8-20020a170903228800b001d01e493f60mr13075772plh.27.1703165723905;
        Thu, 21 Dec 2023 05:35:23 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001cf658f20ecsm1621006plf.96.2023.12.21.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:35:23 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	qiruipeng <qiruipeng@lixiang.com>
Subject: [RFC PATCH 5/7] sched: access to runqueues by function
Date: Thu, 21 Dec 2023 21:35:16 +0800
Message-Id: <20231221133516.812-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is interested with runqueues, so try to access to it through
one new added function get_rq.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..217966111ea7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,14 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_OS_MINIDUMP
+int get_rq(int cpu, void **rq)
+{
+	*rq = (cpu_rq(cpu));
+	return sizeof(struct rq);
+}
+#endif
+
 #ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
-- 
2.17.1


