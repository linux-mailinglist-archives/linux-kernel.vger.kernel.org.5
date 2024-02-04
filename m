Return-Path: <linux-kernel+bounces-51429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D92848B16
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC8B2635D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24992BE5B;
	Sun,  4 Feb 2024 04:46:41 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D760AD2C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707022000; cv=none; b=bBdm4oGIU1LEySEuDbthW4zJQbP3t7Pan0MZpEGG8ruiNDEh4MAPB2LfgqVvKc6gEZw+959BNpQ9CmYYZgvNDQBIy5fOv5diIPEAmW0Y2JYynWsrO+lU1FARkLEzF5BTrgT0qKZSrYJUIKy6R2zWirkT1jvXxRqL1NCQdv7usa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707022000; c=relaxed/simple;
	bh=GBDuC2MMlodSGYgMpqhLqVLYKeiXXyE2UugGI1ne59c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N59MPrW4hDra+nylt6Zlhp8ZRvPD1CcudzUb23DGVdWVpYj0aseZHG50iji2lEyQC/OAW+T6pmK8Knephgd86UWG5T78csWt+Jl4mYsxxLc74jJUuJErZUZ8/TtXk/kZjy90VdJcFDzRTGFyVddEXgWuIlY41VWOirKltY78sY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7853fcc314bso230585785a.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 20:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021998; x=1707626798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK9De5V8Wj4AOhyTbBnyxY3PU+lWzfPRkJg9zP8Toqw=;
        b=H0D0V+2VxUpBbYLWYonbgaxWPt4c3JseQIAgzOb4hcHviSr++WqYtMwlBv0MacpwFk
         j2n3LnRKtEydngXyvRF3pMJcc1nbI4pr/VbAnvy0Kw/SyM45XoFA353ldiHf/3U0ivmb
         25qBy8JR3AMBC+TZLykFoEKqR8LE921n8dU1XqWGcSkVQfNH5EYaSuOYPi1ElaVOCdxd
         V28H5Q3FkRLBEWoQZCTKGFMnLsxRtWJTyvPVllT6bynGL5ad/thtlAiUe8jlJjDP1Y4i
         qmyLB0k/fqaHUxuZgLJ+rIZ/PXjzQyq2nbl443M47u3Wt2TgKiBW8artxResv5gxo4sO
         j5mg==
X-Gm-Message-State: AOJu0YxE2QoD+s33zxCyIgObcJyu2EaRpfOZKgTPOv1mTt31TOynF3j8
	09ixS2LjCxBnBFVSoiqAJ5OzGny/6K1n8OjkNQdwse7Q7bKXQQ7zPWVq5EmqlEo=
X-Google-Smtp-Source: AGHT+IF2bp4VaWwcqfok5xwgDgXd0enf3F0oDenCa3fHN8G9A1HKYe5WD0vCUrHmKSBHYIRfjKePQA==
X-Received: by 2002:a05:620a:4491:b0:785:74f5:62c6 with SMTP id x17-20020a05620a449100b0078574f562c6mr2054025qkp.75.1707021997687;
        Sat, 03 Feb 2024 20:46:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGl3JbzLVNqpgamXMxGC9Ktt0InVG7HyzAo5fpqIsVtpQB3xxR3TmlZ+Gv2Q8VkttKpMEdfkL/hjEETJzapPDONom4RAysBdlOxaHwbgm/Vo39se8va+YPG4khpJFCV1A/MafdL9t4xlUwD7khEq/5ENYjW+ZPREUIcPhdCkXzZcrFbWyd8tHbvop9LG1u+webymOLAGNhlVDS80oItv4JG9Gp+ZnrQTRoqlfwbyl5scOUmf0EBfieitvfyVA7FYACTC1GcrKqmW++xingPkprbz0rBkEKa8Y23VoyB4NvnkungDrvGkH1+2n1PblJ0raHzkcJ+JU9KnrL6+aoiGOYdl2cdymcW6KIJg==
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a11af00b007840137670csm1923778qkk.24.2024.02.03.20.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:46:36 -0800 (PST)
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
Subject: [PATCH v2 3/3] sched/fair: Simplify some logic in update_sd_pick_busiest()
Date: Sat,  3 Feb 2024 22:46:18 -0600
Message-ID: <20240204044618.46100-4-void@manifault.com>
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


