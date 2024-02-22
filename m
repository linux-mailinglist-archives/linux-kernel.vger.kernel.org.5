Return-Path: <linux-kernel+bounces-77301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F948860380
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47301F260A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D76AFAD;
	Thu, 22 Feb 2024 20:09:05 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4114B823
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632545; cv=none; b=rNt9RBSj/XKRePjmFDbEMpqPGedfFKHap0uQQy346fGKYNBOCEi1jcZJCuUwDDQ/kG4P9xUG1Vp2M2Lhp0ehFHe5vl3P2KNcw958wkepapnBeL7ELIaPTxvlfnmS55nmrU8iqz1uXGBw5pQJuxlirXCrzi2yb+e/FeG/+oc1P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632545; c=relaxed/simple;
	bh=jhhohCcQBUbtJzlS98x9WZ/Tb4NtRWXAlOOqjxveNTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVaqCDq4HAhNd0tvVRcONE6FmFnRjWdakRTqBVUan2Rru2ayYMBRH6KovNPhMe/qMmy6CcCOyXCMBen+NyJ7R1fuMtudt0Z4iBUeJFKt8qz9JH6ls0GLK73VetH96HjPCKxTteSgCpIRkt93it9u3Aba/ZngkZ7l2j7IhHQ3c+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d4c0b198aso73161f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632542; x=1709237342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf+E8SiQd8DMBNrS3dxIEYFtpcnTw8yGOi5ReErHUfc=;
        b=MS6S5hgeK6sNrrIVpMv3mDZGLlAl0wV9SR5Vr1A23M9VeJwL7PC/mKl3mpnhLPEw7c
         4M7NZNKwrvNl4tVCW7S3SQsvTwwfNVq0N+6APbefQJCYlr9zB9XrP8/mE4uRuOskHcbu
         BVk6PTxCKMTeqc9IX6/ovE/hKyAfZVtkpmnDmHBzst+2wVFMGdDjYww816VFsof5DX0m
         hwXq/jFz35vSG1J6elYfaqFvqndsWi7ObmF4fWWLX4GJ90SmTMt+plwBWsyhW+vq0aHz
         YfgdrHoWbuvw+bVPuwOU5hEy7HUOAS/KwBZcRPanAl6Xkd16gvEmffdEHysmJ1qk4+vw
         nyVA==
X-Forwarded-Encrypted: i=1; AJvYcCUvx6e3oD0rS2Q8ljLBJagTwiVPw9NzBZLkTlG+g27aaJ14/3Blw6xnewDD2C5lkL+RuvIE3S0bYRtk5UomapCtcQe1LyEOTUc/9czT
X-Gm-Message-State: AOJu0YxEp2/MVZapV8l0pvczEmIR5ivsgXaDDljEiHiIS5ef+1F5KHyT
	etNKp9HNFBPeOf/zYZ2F+gbtMqVq1DU4DHHjLEDZN5pLUCIRWYYA
X-Google-Smtp-Source: AGHT+IHxpGImaR/3/NCeUAGe3JtAHTtr8Fyk0q3ND9UxuHPIWzc3o2pjUwf11a0ejQ6rIu1jOr9xpQ==
X-Received: by 2002:adf:fd11:0:b0:33d:174b:6a3c with SMTP id e17-20020adffd11000000b0033d174b6a3cmr116847wrr.59.1708632541633;
        Thu, 22 Feb 2024 12:09:01 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a040:1a4:9a9f:19ad:6a8:f94b:c9c])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b0033d4c3b0beesm102978wrz.19.2024.02.22.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:09:00 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4] hrtimer: select housekeeping CPU during migration
Date: Thu, 22 Feb 2024 22:08:56 +0200
Message-ID: <20240222200856.569036-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219143301.4174966-1-costa.shul@redhat.com>
References: <20240219143301.4174966-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
compromising CPU isolation.

Address this issue by masking valid CPUs for hrtimers using
housekeeping_cpumask(HK_TYPE_TIMER).

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---

Changes in v4:
- fixed description
Changes in v3:
- fixed compilation errors
Changes in v2:
- [v1] https://lore.kernel.org/all/20240211135213.2518068-1-costa.shul@redhat.com/
- reworded and rebased on next

---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5a98b35b0576..1fd106af747d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -38,6 +38,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -2225,8 +2226,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
 
 	tick_cancel_sched_timer(dying_cpu);
 
-- 
2.43.0


