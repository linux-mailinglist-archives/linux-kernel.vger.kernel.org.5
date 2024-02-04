Return-Path: <linux-kernel+bounces-51428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA19848B15
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB931F22FAB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7BDAD55;
	Sun,  4 Feb 2024 04:46:39 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6579E0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021999; cv=none; b=mHfvmkjHC/PIiMUoc6Dd+qd9DUW28aY94Ys3mDw2H/Al9kf4BQ7EbAQxSnK/SoIatKAPULcAHfu68QdUjW0kDkME0oLBTqTA/lrTshY59ssmzjewJdBbJrbHhhStH0XcBI5ZeT4Tr6ioe5tv2hDaSmnTl40/bVlW5149lQXkAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021999; c=relaxed/simple;
	bh=vui/RYMxtvLSlzIZx1ihMqsZNVVUacQvQp4BnYDnMfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/rZ0pWLRwWm+rGqxB13o6qGEP4UV9gmqVMfAccGiiQXWHGs3i6GZmHvHFOxOuw2kOZb+3UyEJqtO4IIQQt6DD7VAz7Wuh4h5GRMO/gNA17yPlxwD04b3opgYleltUqdSJzKt2Zb3zIWqILU4P/BjCv0ygKJ/sYMjNh6bxM0ZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783d4b3ad96so221592785a.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 20:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021996; x=1707626796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQTMIMuLSrSdNFkBQ8JACN0LFlSoVQIArYjoabFjhtU=;
        b=H1aRUYjTjIvs6E1cO0QMg9tm7ilcpa1Evq0TKdSIvxGlmYdDCQtyvn4/wHndkt05gJ
         HyBN8oQ79SnVj1XlWLpbPfaIqxTMvvedW21c55HQw0MoxlPXXhqIxOt+TAX4GaeCg/yJ
         BMpiALOFH2Gl3VD97mbLsGiF99MuTQ5Z6UA4UvoZCGhOMi8t428LZjyZ0PYZ6k7au85Y
         hVsz42FWHhQxxkj/68MLu2tY0UHu2fzSsGZcHAkjq+cKs+fnrGLcFK2+MB95EaNNf+rb
         i0/YYPzMw9MdFDKpxeFut27jYSYaI8HHTNd0gwOdLQj5ZhsPmJRlBabyBBUTVOEhjbWW
         5hmQ==
X-Gm-Message-State: AOJu0YxbTYvPkgkYFGN5Px+p1hOVSAZ5lV7R+DPIBRgDMXCQt+alLivG
	y77cBqxlF7DGiuO3s8AePuGx2U2jHjxvYftOkGBvAoXFXBXeJxJRLMmIjPZpaO8=
X-Google-Smtp-Source: AGHT+IE60+G8bx/mkj6dzFfYM3I0ibACAoFVvsennF8TbsItIYmUKLv/0XUpk7O5uXYdxN5Y9c1lBw==
X-Received: by 2002:a05:620a:1211:b0:785:3abd:ce51 with SMTP id u17-20020a05620a121100b007853abdce51mr6774160qkj.58.1707021995706;
        Sat, 03 Feb 2024 20:46:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWes6Z47uXeC7KAMZiu/aOWDJN7lH4ycbqLnWSbxMmv7lO1Uvkm+VjGE+ykgfVR9R7TDBROhV3KwNYNshSMZBtmek9J+FklPq4njOuarTeYHCPrE4P30x4PsA20HrRBvRMVWX/2bRct4H4YvQuISR5V3ugcnzcsQ8L1wq3rCsi+l38fxkLHL2DKeUEfn6AukBfsexhqA8KmWb4j/Q4jDCQwVbDBKTdPnfWsesQog8Y/u3j8nH80elmDb+ZxP83pv6YAvSwP3DdiVilq7eR4xWtStLEnvMQfF/WORBlPVJYapy9xMCzITpH5iZd2LJVSohrnI2hEJmX2hojnEM94CSojXwnA5pVx3YbyLQ==
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a21c700b007853eb72c49sm1925688qka.46.2024.02.03.20.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:46:35 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v2 2/3] sched/fair: Do strict inequality check for busiest misfit task group
Date: Sat,  3 Feb 2024 22:46:17 -0600
Message-ID: <20240204044618.46100-3-void@manifault.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204044618.46100-1-void@manifault.com>
References: <20240204044618.46100-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_sd_pick_busiest(), when comparing two sched groups that are
both of type group_misfit_task, we currently consider the new group as
busier than the current busiest group even if the new group has the
same misfit task load as the current busiest group. We can avoid some
unnecessary writes if we instead only consider the newest group to be
the busiest if it has a higher load than the current busiest. This
matches the behavior of other group types where we compare load, such as
two groups that are both overloaded.

Let's update the group_misfit_task type comparison to also only update
the busiest group in the event of strict inequality.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7519ea434b1..76d03106040d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10028,7 +10028,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * If we have more than one misfit sg go with the biggest
 		 * misfit.
 		 */
-		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+		if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
 			return false;
 		break;
 
-- 
2.43.0


