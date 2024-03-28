Return-Path: <linux-kernel+bounces-122531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD388F91D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EE9292C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2B54663;
	Thu, 28 Mar 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8tOIJsw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE053813;
	Thu, 28 Mar 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612257; cv=none; b=cnCXNyXRY1+as3xsofdWNOCGGOITisQOui46xMY4b4MjTWrdAiZT0LAcIqNXJdMItwfcDFqIaeUOHAvpZ9iVxs6z3KfUSt78pS+ux9u3IHnfmpRIjriQG8fERDWLt/ic2XUTyK3KyH1aHw0sHWXbn5KGutSPiXEclalTeH6Fa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612257; c=relaxed/simple;
	bh=VlRDIqwoVM+p8KZfRcMcR2xazrEvf0Q/aFGW4bWeON8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ei9wfU/LpgiI7IRoVRJOSaeUXAoKY3kBHWDtrU0V0NecBXhTvjlYyAyKSEeV4KBSLrjDIYP6PtmoTa4lZW2sqiSTSYiyP6HfYNwLZIoJy8fmLvGOPhnNztKxo/ObnkM+gZlu00ZW7kcn4j8cwSPI8T1WdlsMEuOUwoMGMAuKAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8tOIJsw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0d82d441bso6187685ad.3;
        Thu, 28 Mar 2024 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612254; x=1712217054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NHnLjZYEP5UNdxD1VIIFJ0g0ZRRIIckJCqa9h6jE6A=;
        b=f8tOIJsw0WGxAcSb6g2IcfW0c3LjSA+nZtEBIqSMTryxVMTyWA4OQc1az6TBHHkfv2
         TUkRqT8TPTS3zj0Rupzu2/qZoxP7BIxSfJI37Uj6oUIKPQNM6Ppwl90GkInusUwt2Now
         NH+pGMh6JWCZSRmZ7MFJm3eX3doyf6+lzK1cV4jLx9L/7ON9+O7AtQbXTY1yhPfzodmw
         zMwmucZGe9wLiefK53Q75ZZlDlMe9xAxrpXMeiWy6bOGfkQsKXC/6Njl3TtJmkJAK+0t
         P9xer2wi0baA9JAROm9PWk7+khKfYlfGUwPIZYrJ6J7/F4Gp3qBZixhJtethcokisjvG
         nTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612254; x=1712217054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NHnLjZYEP5UNdxD1VIIFJ0g0ZRRIIckJCqa9h6jE6A=;
        b=wGcGHyshDGykbG0K5wGWay9PBkaG8ddzBW3VJkhwpXP7vdjPgr+2+uqEVyGUa3K6jB
         4nk0kWmk6ppw4Ocj81e0rbg4Ovej/lQAZGlp5N82QtKRLrWy1gHRGfLqCJOsM8499lbN
         4Non1T1nSrnH3qhexjNpnBqXGlBJjSOlTcaOLPfDhD7ZZaIi1s0oVlLr2e+cGza+RcR+
         /bqPWTm19pC/TR5xCHyLQwaB/iPX46CNRArl2os/9bOwJmOMZPDdXUPfqauBf9MJVcHB
         lrf3dHSwXdLWy6RaTln/iMY53CQH4KLH89+BigtDoXgEz6pu+8rjj/0+A3TSlq5zATrv
         a2Fg==
X-Gm-Message-State: AOJu0Yzr4N/XDV11hqN6mM4gtnA3hNWbNVkNKo5f/LQYGJaDx2rJbKG4
	yb05OHNriCDXB151rwiIw5ffUlPKov1GMf32/S/6MzymLL3fVZh9qoLYCJiY
X-Google-Smtp-Source: AGHT+IG5b9hiKqIXVMmIA/V/N+96/PpxM3h9SOhxAbcOOc4hbwQ4D182LaFIDQy1+CjspQ/K/NO4Fw==
X-Received: by 2002:a17:902:ef52:b0:1dd:7485:b4c9 with SMTP id e18-20020a170902ef5200b001dd7485b4c9mr2420939plx.22.1711612254606;
        Thu, 28 Mar 2024 00:50:54 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902694500b001e038619e34sm851133plt.221.2024.03.28.00.50.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:50:54 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 01/10] lib: Use rcu_preempt_depth() to replace current->rcu_read_lock_nesting
Date: Thu, 28 Mar 2024 15:53:09 +0800
Message-Id: <20240328075318.83039-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Use the general wrapper rcu_preempt_depth() instead of the open code.

Prepare for enabling per-cpu rcu_preempt_count, in which case
current->rcu_read_lock_nesting might not be synced with the real depth.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 lib/locking-selftest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..9bb41fb18088 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1434,7 +1434,7 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 #ifdef CONFIG_SMP
 	int saved_mgd_count = current->migration_disabled;
 #endif
-	int saved_rcu_count = current->rcu_read_lock_nesting;
+	int saved_rcu_count = rcu_preempt_depth();
 #endif
 
 	WARN_ON(irqs_disabled());
@@ -1476,9 +1476,9 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 		migrate_enable();
 #endif
 
-	while (current->rcu_read_lock_nesting > saved_rcu_count)
+	while (rcu_preempt_depth() > saved_rcu_count)
 		rcu_read_unlock();
-	WARN_ON_ONCE(current->rcu_read_lock_nesting < saved_rcu_count);
+	WARN_ON_ONCE(rcu_preempt_depth() < saved_rcu_count);
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.19.1.6.gb485710b


