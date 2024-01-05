Return-Path: <linux-kernel+bounces-17461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CC824D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DB7286AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291D46A1;
	Fri,  5 Jan 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI/gHWf5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B319442C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc02ab3cc9so740946a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 20:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704427326; x=1705032126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut37mQnu+DRmmKQT59rSr16i4obzZ+960wl3XdV13xI=;
        b=LI/gHWf5B9NGMIbmP8+XZqIrpHsJlqXd0C/aqldKOHTwF0q3Nm6rWUWfch54MBVr1Z
         lM5wXPYhqTLSQxXfRHmFwAjE8aLSVE+ndE1B6hK3GSCkwZcZ4/h2GiUescGOQUOq2sl4
         BpyvtWJxAhzi2K283nTDIr/pj26E0YjEMmk0U4A+hJHJmzyW1S4eiqoTgZ6unuNyz5zC
         NBJK65r2AkcTnMsngkzuCIs5sqJv1YnemKXpSI4nalgejciPA4kt5n8VesAQUoSx3WZU
         Dm7k6ILCMG+ywnU5Rkdhj6Wnnv6Qr+pIKqPyC6pPZzz4f1yMYNbFVKpdgxDmZzhtiYs6
         RBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704427326; x=1705032126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ut37mQnu+DRmmKQT59rSr16i4obzZ+960wl3XdV13xI=;
        b=FcasF1OpiPyI5LBP7Al/iixHV+aVHMEa6AYKVgw2VVJ83kvj4qSixkcmUE+ooIAVnj
         Lcz2u9aPHKyOGEqQFq9jx9pkzSLFY/penD8TqB7dxCDpdzLbtTzsSBQYFF/Ep6K06KKj
         ArnkmhMzbqaKRxcNZK6+337eZ2OD8itGAT2q9KPzO2jSzsYCm6lxHYBKC/AYLiL6Uj5a
         aMvIHiZ/CHBr7vRqiVkDZz+kwTAS01znffb+BC3P5r/CAx5Ipqk0VAT15SUx4NRmKetT
         ONglCUEKVr8L5wU9eXl9h4mFP8YOH85wVaM6abAk5bjlQCV+PNGdcGxQU4gOrGQDT8Ya
         u31A==
X-Gm-Message-State: AOJu0YxtK7FWT1DqGsIsAYV0Rku5EfD+ydM04a9UcEBWKjUxf2OeyAQF
	jBs+RzWHa/Na3HTsNl4mX3s=
X-Google-Smtp-Source: AGHT+IFsSlRjzmls+aF14SN+Iiys3AtVedz9iz3GmeB6XtIY6pcjYCMdBQTVSC96DL3Ggd2Q9e3MYA==
X-Received: by 2002:a05:6358:718b:b0:16d:edaa:921c with SMTP id t11-20020a056358718b00b0016dedaa921cmr1662479rwt.12.1704427325840;
        Thu, 04 Jan 2024 20:02:05 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.14])
        by smtp.googlemail.com with ESMTPSA id c5-20020a170902b68500b001bf52834696sm372030pls.207.2024.01.04.20.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 20:02:05 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH] sched: save to call pick_eevdf when TIF_NEED_RESCHED is set
Date: Thu,  4 Jan 2024 23:01:59 -0500
Message-ID: <20240105040159.5026-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now can have TIF_NEED_RESCHED set from update_curr()
in check_preempt_wakeup_fair(), so check to save to call
pick_eevdf once it's set and defer the possible picking
to where schedule() is called.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..28b2860e1f09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8273,6 +8273,12 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
+	/*
+	 * We can come here with TIF_NEED_RESCHED already set from update_curr,
+	 * check to save one call to pick_eevdf if it's set.
+	 */
+	if (test_tsk_need_resched(curr))
+		return;
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
-- 
2.41.0


