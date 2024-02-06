Return-Path: <linux-kernel+bounces-54320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD784ADA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028DA1C23CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D197CF00;
	Tue,  6 Feb 2024 04:39:33 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E57C088
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194373; cv=none; b=mkEjixLMhAbcVFtGPQ2bsia9spPaDbSDSPrt/Qt4VSHp7m2CFHJySM1ArHtFwvsfMJ0VmtrY8UmKLNmQOK42swHM4Kus4T6sdq58aoesZ1wMsLH1N/P1efltEZZ4ctS6zA/0HtbVa/qB9ldEqgkgFOOHtKdd2hpmR3mv86eZWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194373; c=relaxed/simple;
	bh=D0GWn07QSrQNKcLM0EZX6f62nVaGa9qePJ8JuBS0Phc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2Xs6zTeFs2mCEuo6OfDCt3S2WH/yaDM5eEA6qzVrJlcdQvBCUkHglXS0nijE4jNvz6gLGrN6u7qHyE0LUB/ho12LJRxkChPqUJ2fkViG4/2Sux8FmKJO1Ub2jJ69KJG0RgMu1CRyXcVbPICfDBu2pkegCkDeV+luz//54wEcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c794970d5so1499356d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707194370; x=1707799170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OweXHWUMGZlBLk7CQUqL8P+eAADd+iVa1P4u5q9wuCA=;
        b=s+34o9Lo7gaR+7862p3T4u3BguXCwUF/04Wk6Mhou61MyoBvbRRIlx9LuE51diomvv
         xwxIUyAFKXrwnNdEGcYz2QD7dJKaEoCQYzm6l7ahPIKWL/85D2xH+b9yCiQs8AsDDJLC
         TntNnbghvPpJIvwPx9yVxJQgd2e6qFSZN9xVKZeddPxa5h4mQElnl+So35l3uBABeLgs
         d+PPSZ81n8YzVwzU0pb9GONr7u9GcpheJAjVXdcsH33v0w2T7v7a+W2HG+QWL/SsELNp
         FHmDHNJQc/lv5ZIZ7gd5MXdLIW5r6cM/9iAMRrXq6L8ScDoPLfmK2sBiaAlZBVQRPQ0e
         eiHg==
X-Gm-Message-State: AOJu0YzL/Yu9B+xSyWCZXdpw7VPov+65f/novCyigkSw7BWr12QR4PGY
	GGjCIalb5shxikLsN/q+aC+7LW/zGaVwYnO833SmkZwRge3QhzQF9YEMegqJbs9cLA==
X-Google-Smtp-Source: AGHT+IF3mi+rmRAok/VSPYBZN3kyqm7aNnS3Pl97TIRUsLUB1I/FBvbY+HSN98zr17n4c5YaPBHZuw==
X-Received: by 2002:a05:6214:1d28:b0:68c:8218:30a2 with SMTP id f8-20020a0562141d2800b0068c821830a2mr19466751qvd.0.1707194370393;
        Mon, 05 Feb 2024 20:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXB1wpEtOw8AUVfamqVIhtmaNPh6FPGwA2PmblCOucWpKiQRbP+BXxOBdLCHMdyOborem7tLZ57EHPgpRd+APgTYiK1ZS1vyrAusIYSyQIZO4ZFr7lKnovzUyv3r5MQJDSZ5YwZLPGUwKY7i2UQpN16Ki3eYT007ocCN2IXFCJlAxG51hf0RP03NoCPJrHEXBH5r3jSPe1++5ExseB+V141RZ5cYAbc4UZGhVXoMv3CguHKD1XX1FZhUT73xjaMByYlcYzGaoX+rcAkdyyzfIDkLzv1WGRqRiMUPzCi3vbIl74lkVc=
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f7-20020ad45587000000b0068c81299a2bsm671836qvx.15.2024.02.05.20.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 20:39:29 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 3/3] sched/fair: Simplify some logic in update_sd_pick_busiest()
Date: Mon,  5 Feb 2024 22:39:21 -0600
Message-ID: <20240206043921.850302-4-void@manifault.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206043921.850302-1-void@manifault.com>
References: <20240206043921.850302-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When comparing the current struct sched_group with the yet-busiest
domain in update_sd_pick_busiest(), if the two groups have the same
group type, we're currently doing a bit of unnecessary work for any
group >= group_misfit_task. We're comparing the two groups, and then
returning only if false (the group in question is not the busiest).
Othewise, we break, do an extra unnecessary conditional check that's
vacuously false for any group type > group_fully_busy, and then always
return true.

Let's just return directly in the switch statement instead. This doesn't
change the size of vmlinux with llvm 17 (not surprising given that all
of this is inlined in load_balance()), but it does shrink load_balance()
by 88 bytes on x86. Given that it also improves readability, this seems
worth doing.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 76d03106040d..fa049f866461 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10006,9 +10006,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	switch (sgs->group_type) {
 	case group_overloaded:
 		/* Select the overloaded group with highest avg_load. */
-		if (sgs->avg_load <= busiest->avg_load)
-			return false;
-		break;
+		return sgs->avg_load > busiest->avg_load;
 
 	case group_imbalanced:
 		/*
@@ -10019,18 +10017,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
-			return false;
-		break;
+		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
 
 	case group_misfit_task:
 		/*
 		 * If we have more than one misfit sg go with the biggest
 		 * misfit.
 		 */
-		if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
-			return false;
-		break;
+		return sgs->group_misfit_task_load > busiest->group_misfit_task_load;
 
 	case group_smt_balance:
 		/*
-- 
2.43.0


