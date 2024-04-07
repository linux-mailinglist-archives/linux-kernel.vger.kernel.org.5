Return-Path: <linux-kernel+bounces-134275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F089AFDF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C94A1C20A03
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C417996;
	Sun,  7 Apr 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpGLFiR6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CE156E4;
	Sun,  7 Apr 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480614; cv=none; b=mGWONMP1qULugokf+ff1MaPJMHhZXYL0DJrpEinHkr0+vmtkJz0cTH9/BZwfrowYcDroHvCnmC7yhmeoKfrT/BjwmM9BLJX2fG4IHUA1coYJE+px+R3xRZ4JxksiGg7pWEeZ7N1Tf2NQ18SCue6CHHmO8jar3XUTWJMxi4IVUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480614; c=relaxed/simple;
	bh=3Gos612aoLPrsPFZpY6vzxas7L2U1yTGHX46XVU7dYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpQVbCR69AgR9n1tLcDp1wac568T8ARkHdU42G9nsPFg1Lem6oBCVF3LUl7AMeCyzXhOSOYIxqR1E3hEDqq4e8sn3TrLOgcTuYRF/KYhLj/6Zw9bbvJMcMHfHRuk3ACjOxt0UxumLfWQ63bfJp/Jks3x84iJAiAg5HrGcjWxx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpGLFiR6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed054f282aso1516534b3a.0;
        Sun, 07 Apr 2024 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480612; x=1713085412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Nt907o8edMLRxAYjTwIu4B/dw5DVN79x2+si+sMmU=;
        b=UpGLFiR6XiGSy72KoXCIfrXlV1ckg6ap9YDZIxWsydi86nwNYyH2/EmRcSLuUdx+ep
         3XFOTNkH17QuISCjf9RamU1+/oxA5p090FErc6l1oFExNGaRqU2cMfF0xn9Yl+Bucjbt
         jIqtlhvwcISVYqUXo7lrb0bKO8LyAvz/CXVO8zMfCxMoQpu9eMtufJ2nuv24khrAt8rU
         xzM48W1eC7dZ4B1JpOUyMDZBUEFpwVp0pJ7HIJtOqFAr+nu2BYoG7P0gcpj1CQsyFNOO
         6K1oBUZgJl6NwX5P8sARWzH7+fV7h6SkICRzLa4zDqwhdK3vc8oqEKYs07rMcf327lRE
         pJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480612; x=1713085412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1Nt907o8edMLRxAYjTwIu4B/dw5DVN79x2+si+sMmU=;
        b=CR3mWv1QX0o6/G/opSwrwCC/P97dVQrym9B/riTPQKDKYhEgez80vmTrm7aDPyDwFG
         YsowHswI0v7ssZCKlodrbmxiXj+VndrX6P9oPz/YjH/8d6Qp+pt+8m5kvnPrH5JFKjnN
         b4d5DbpFBLaLl7d6ZcSo064SpitVIkG8n0k9b5YGPZmG5Wu+SFqBgGs5hY44FO71+sUP
         47bv5q09io+6TbfbeLMyfsFwLlZHW1ND6xX0YCZVgy7KNMYxLEE9E0kWr9M8Vx1Y/jtH
         xNo8lV2Ut1j/b5iYBNzhkz2+u7yQlFTIsgp0PvlkghNRtMIw1fsxIw0Oqqlyij5xVf5z
         sgxw==
X-Gm-Message-State: AOJu0YylI3EhTgMg33+1udNEiI44A8EBoepK5FaSJnCT56WmVCzWLyt3
	RkTavsUjTPTEsKTM2cN8eVJvK0EEnuozvYS4W4uTWz81ZWy8mmq5RcsdeTnn
X-Google-Smtp-Source: AGHT+IEZWBC54z6Qvf92SZcg4NE/Us7RCUpxhKtDVKx3i9t4ub/JtDuGslUTjHfh2I5x8mKskbAYIw==
X-Received: by 2002:a17:90a:df85:b0:2a1:fb5e:6028 with SMTP id p5-20020a17090adf8500b002a1fb5e6028mr4428255pjv.20.1712480612016;
        Sun, 07 Apr 2024 02:03:32 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id i13-20020a63220d000000b005cd8044c6fesm4267344pgi.23.2024.04.07.02.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:31 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH V2 01/11] lib: Use rcu_preempt_depth() to replace current->rcu_read_lock_nesting
Date: Sun,  7 Apr 2024 17:05:48 +0800
Message-Id: <20240407090558.3395-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
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
current->rcu_read_lock_nesting might not be synced with real depth.

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


