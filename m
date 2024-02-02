Return-Path: <linux-kernel+bounces-49339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB488468EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162762934BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C31175A9;
	Fri,  2 Feb 2024 07:03:44 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2B17574
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857423; cv=none; b=rPJntwGiwi4Y8FSRv+ndQCTGKUUNjKyCkZB6AlgEO0ynAC+9O81Zg3NobE8xuH2tkpPejg5REF9+VsN2ae8Fug6i+2ucO2D1csc2IQ8L32r+XYbmvTi7fmF+FtAegpgfjHXdAscm7j+pcUNAsfWRnmDvqywjmzRKRUD22SYG4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857423; c=relaxed/simple;
	bh=Ev1e5CJNXRxZVofuKk4Xg3EGF/4w1f4S6jmmYhfQEC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwNmr+MqBDZjOir2qtAcRnG9E0+hpsvGADfiKIsqVtGIslcp+acg3jPW3a4YwsSgeWRihfaoTDpByYlPxrrm5wcjvqzZsc5x514FvU2aFXIq2JTQ04OoHXIwJwjJ7cMkywuzWfjiRENgBtyjgOKmxn3gJuerdf+oZU+LP3H1T/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3be48947186so933135b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706857420; x=1707462220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usWccGmETuvrOxDJdSjAbFZTPNKzKoboOKZnxaKjk6M=;
        b=rUl60PbBGmIUwVbs5RlthWd8Zv9eEFcnmR4aFX4la30Dc2zibDLKtWTVuEP2L+mZW6
         oORaFYptCiNIHSZ0eTPMpKHA+8RkbShBErxnqaXXC5VaNTjLQHtCiJdjPo3wGL0NbEN0
         wwwVol4UHcgqz1bO36cAuTD5yYYM/icmHIpuo9Xfj9uGxPcYimbtJ5LAS4pe1wUg5c38
         KfZSY15kmB5XMKrXU2LD5Q9kt22JSZb7T0jvx8pFCccw/MABmYwZxJIOMTDpA40WBRdt
         CW9UqMRLt/lw5UXAsEJ5YTH7RbjndjtV3f7gUwcf2wCRWXVQbYERiX4kbFt2iaJlmAH8
         u70Q==
X-Gm-Message-State: AOJu0YyXaJLCIM6h6o6198lc8xCmcpvhGVrK8GSNUaXvbFaxJvA8OZN0
	1pqWuSVgH/BU+Hf72hETmoxOxoBzVXJaaUpa3ZaRVoxt94ggQMVyhOFUFLIJNH9sDw==
X-Google-Smtp-Source: AGHT+IEo+QsXJBhVy91FHsIf4cr52ccuk+H4IsCVI2YDK8jsS5fL9i45oaEWL/WWpUgt/vr/SZn2mg==
X-Received: by 2002:a05:6870:5b34:b0:218:d7e9:f5e0 with SMTP id ds52-20020a0568705b3400b00218d7e9f5e0mr4012538oab.39.1706857420503;
        Thu, 01 Feb 2024 23:03:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVlKr8TQCGaYBZ0JK984Sy3q5OTSSKF68B0zlCtnIZ6G8ZVvxF3BO/gPc4LhQ3oI3zmFWAnF5DrSkdXFvNsHIBxrfRKsFDsnLB+oqNwqXityxbpaiScSRXGy07OgDe43gVjc8VEVwVic5QqMaOVUuOdr+c+mzt9RktgKjwJVfGz3vtb52JXpm2b24v13Hn+kCktSHu9R9RBCHDyLCxeZHN/HDV0wTANhj87s/dPDoaggH+m1HX6iVow4j6xyWwq6vBnzuyT9SnZTNVYLQsYOwcBel3ba+XFwqKC2gzvHhLi54sVfohm07PcR4weBMsFmbglqwkgPRDNeHftrlH6vMsHlx2APLat+L0+wg==
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id hb4-20020a05622a2b4400b0042aafe50008sm566838qtb.55.2024.02.01.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:03:39 -0800 (PST)
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
Subject: [PATCH] sched/fair: Simplify some logic in update_sd_pick_busiest()
Date: Fri,  2 Feb 2024 01:02:16 -0600
Message-ID: <20240202070216.2238392-1-void@manifault.com>
X-Mailer: git-send-email 2.43.0
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

As a bonus, remove an unnecessary goto in update_sd_lb_stats().

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..04bd655b81d3 100644
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
-		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
-			return false;
-		break;
+		return sgs->group_misfit_task_load >= busiest->group_misfit_task_load;
 
 	case group_smt_balance:
 		/*
@@ -10578,16 +10572,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
-		if (local_group)
-			goto next_group;
-
-
-		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
+		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
-next_group:
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
-- 
2.43.0


