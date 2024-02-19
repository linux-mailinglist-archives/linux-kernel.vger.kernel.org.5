Return-Path: <linux-kernel+bounces-71484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297D85A602
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599541C214D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D50374FF;
	Mon, 19 Feb 2024 14:33:33 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1F32189
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353212; cv=none; b=ISZ8L4zq2Rsk/rEoRoKC2qXD56qVD3zBMZoKwAlX3FeoD3u6wi4aVRVA4/2i/+E86H5pJQ0A183Cxhlm/iwl8uEHnGBG9rPwM5FDmC/8fb1Y6o1awxhFM/4kGA5NBH/qM8vAowl7z3sBmhpUGzhWr5TE+jLCMI4e49cEZd60I+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353212; c=relaxed/simple;
	bh=cHR/zuNBoQ74l20sbaBy5k3+Q1djSutljUyI2PwZi14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjGRhufvU4QaA6UH+JJ9bwtUGCra/i+5qUgOhIGU6nfQAvTjwPlY6P2lfuSE8JcPfDKMt2kO9XgFajG4PPIy7vSh7B7/BmP5KP1CX7U7e8afNOzGvue4FpHV4BrGvC3mTAgslQ4iC53Wcer+1JVf1ALC4JmGJJgNqR51sfaUyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a4516ec5dso31228801cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353209; x=1708958009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/YtCpE3WL4LKQWYuWvJ5CfzUa+1tQLWgCa4kzjT15c=;
        b=MzZudJpeNOPWIzbpHpOlLNxa/mffemOP+48Wp1rK9i7pDPjB3CoUApMjFRUHGMF57y
         BE3qxNR7agm1+9ngc8QgtAwM9T+bDH1KaNVXiilBaI6GNNtREh6tAQPpiSCAJQYRzmUW
         qm5BKpIh3UkIdr0WdKJzPekYJW9hL23pL90+MpzcmguYEVNX3kFk0GDJbjOxjAv6vQkJ
         B7Pa48VmgYkrX86MBmjmmp8CUhLoOX+jbzAvl5o5IszlelKsAdHtP46JP55zoRYlbJIT
         8oXjXCzjiQ6Yg16/YviGA3MX6R+bS/PZbYb9cjqbPA52UE6QMAE+dLDSTjGQ7wgFBft/
         uGKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwHgrfAA8QUtC9zJuEmXSv+vDpF3y4XooDbnu/wqBFWG8V492COE1elottDzw6IX6QNFr5J83vMvZ0ba0haAcWyxERFyyXXP7vSdwm
X-Gm-Message-State: AOJu0YzCf0K8DAktXuVujZP3ssP2D79nccLovgcEAbB7Xiq/mC0g1200
	BrZ0igzOOrwWrsqZjljFQmSMHC6wr8irEdUiA5mNcJ3f5tXm13Y/
X-Google-Smtp-Source: AGHT+IGkcxOeSLvhwc/1vo+/JWlQXcuP1cCRQ7piFV8psG7Dy/cqhFG7FHsH+M+d8pCluf81uB8vrg==
X-Received: by 2002:a05:622a:1710:b0:42d:f85c:4eb2 with SMTP id h16-20020a05622a171000b0042df85c4eb2mr8720988qtk.48.1708353209471;
        Mon, 19 Feb 2024 06:33:29 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a040:1a4:9a9f:19ad:6a8:f94b:c9c])
        by smtp.gmail.com with ESMTPSA id c21-20020ac853d5000000b0042e1950d591sm468324qtq.70.2024.02.19.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 06:33:28 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3] hrtimer: select housekeeping CPU during migration
Date: Mon, 19 Feb 2024 16:33:01 +0200
Message-ID: <20240219143301.4174966-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213164650.2935909-3-costa.shul@redhat.com>
References: <20240213164650.2935909-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
compromising CPU isolation. This commit addresses this issue by
masking valid CPUs for hrtimers using housekeeping_cpumask(HK_TYPE_TIMER).

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---

Changes in v3:
- fixed compilation errors
Changes in v2:
- [v1] https://lore.kernel.org/all/20240211135213.2518068-1-costa.shul@redhat.com/
- reworded and rebased on next

---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb0f821dcea..6057fe2e179b 100644
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
@@ -2223,8 +2224,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
 
 	tick_cancel_sched_timer(dying_cpu);
 
-- 
2.43.0


