Return-Path: <linux-kernel+bounces-63938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95903853696
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5222528CC39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34A5FDC4;
	Tue, 13 Feb 2024 16:49:23 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA858124
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842962; cv=none; b=YgZF3vTQY/QdTbcUGvGKhb5aVZ81xm4pFlgeEgKC0NiM0yuGaLuiT0sOBdCnwCLQm/yLhlpaA4ti/c7GvL555yHPSCEiMxzdbehEOTsIq8T8aemoPzBo9eVnc+oyfKYIQNAxBW2L8cnZf1XucYyyGr7j0B9IaA1Yu2WMVaHYH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842962; c=relaxed/simple;
	bh=t5eu94w58s/hnTAf+99KfT5+85It8b/b96Jcf315P7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f429QTocbFOAT6VgCII7NqYrLNoGGD5rveYia+rESbbsp+ZfXWhdYAwWpk/0A4FgJHXutUtefFqrl8Gql75CvtFhb4njKWeqTXZz5MA4sc4eWMsnN4jPfDMmfo83m+i2dVnUEO+cA4p90lWNSVcZEsGa+n6f38DJwtRPac8+HIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso78700276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842960; x=1708447760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8rCZ76h4ZxdDgV1qzO63Dy9I9DhB49wsplKO93pUzM=;
        b=Y4UbH0DqAGSb8mcKsaChetOdjX7GcGTRKgOvOlbg9d5MCGX75vEQmy0Ul7txm6Ve6O
         FnyM8ixvXJN+QktESn6i727ZgGQMJweLfMPcR/NC0EG5hhcuRQm2QXKuRmgYwoMIi0KE
         ra++u4/dTMx0cM52tK78GXbZvrrbp7aKUMxhN3DMGoWr06Em9LwkSiRzMCFq9XjSX9aM
         +C9ScEIQmVuhcvoHRYtr23PvVo5zScfXQvRscax8tJfTHvu1x6TuM0gok8jc81SkcYqH
         ht4ZiSnrvdf7FHUEeX+P++5sI1nq9xmKLfGZSvL9xStzeAlysYwKHVepEW3XecFq5F25
         v8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNUjz34cfFO3MUWCO+rgutx7xAot3EUdUOXsnSjHCGZDbLGqS1M/f489XUNW00vW3E5z72wt/yJN3ZAGrRm52c9EahkMlIt7cj2EF8
X-Gm-Message-State: AOJu0YxjkHs13EBg9etT+8hB6JsCCH6e8gasfoQpsZEs3mxWNVeGgS75
	+mtBRoMn5xQOrJY7mYmnMJkuw6V245TZxEKxDUju0z1oxT1/Cu4m
X-Google-Smtp-Source: AGHT+IFf1aC0QEyjn/PG5BcioJQowW1/Q9whlHhdIxGBDT7XOM9L4Qx9chmBaRrUXU1Qn9hxweK3Aw==
X-Received: by 2002:a0d:dc02:0:b0:5e7:c9de:1ae3 with SMTP id f2-20020a0ddc02000000b005e7c9de1ae3mr9138446ywe.47.1707842960252;
        Tue, 13 Feb 2024 08:49:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOff7WoZ/roOHHvN9ZmrHw/Rq2x32q1uEL1gcusjU1Pn0rrDwwiiswFOqXrMxByux22sn3gZRR7kKstU+a47bo91B1e1Z8j/2h5MUsvNtvf+r32RnHn8k3uZteAnWh3ElJplWHSJ9GAMu51bGsv43YzQsdyGA=
Received: from costa-tp.redhat.com ([2a00:a040:1a4:9a9f:19ad:6a8:f94b:c9c])
        by smtp.gmail.com with ESMTPSA id u186-20020a0dd2c3000000b00604a3e9c407sm1814332ywd.41.2024.02.13.08.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:49:19 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2] hrtimer: select housekeeping CPU during migration
Date: Tue, 13 Feb 2024 18:46:51 +0200
Message-ID: <20240213164650.2935909-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211135213.2518068-1-costa.shul@redhat.com>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
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

Changes in v2:
- [v1] https://lore.kernel.org/all/20240211135213.2518068-1-costa.shul@redhat.com/
- reworded and rebased on linux-next
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb0f821dcea..947bd6cf7105 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2224,7 +2224,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
 
 	tick_cancel_sched_timer(dying_cpu);
 
-- 
2.43.0


