Return-Path: <linux-kernel+bounces-26473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DA82E178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150F41F22DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAED1947A;
	Mon, 15 Jan 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNfur+Xn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72118EB0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705349991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fK1cfcz5VdHUqaPh3D2ST8gwHCilhZQB43Ha1E7iCnM=;
	b=WNfur+Xn0AquGLAu/S55rLHM79V4jAMethV0CiqHS6UmepYSu3qrShr6VqasvxLZAUlKAz
	YXOWcwC0KOC2/d8kS4xYWnOl0ssZpMv161C7Krpq1YFRFZraO4mEpHigQ1FhgEiougdrTh
	Yt7Vsmep8exIlATVw4G8xQTsQK1P6lo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-khzJsTUDOT6Lt8eRK2A-0A-1; Mon, 15 Jan 2024 15:19:49 -0500
X-MC-Unique: khzJsTUDOT6Lt8eRK2A-0A-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbacb61978so6852359b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349989; x=1705954789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK1cfcz5VdHUqaPh3D2ST8gwHCilhZQB43Ha1E7iCnM=;
        b=nOrQOXOuxjv1Pk9MQS1Y05BvxoorGl4eMZG/VLlZtZWFohHpEbAm3IRzPKclJMQEDp
         0PnfNnzWiQ04MJvXy/Hh1qFXoI/o1kUZqtE3cEv8/8JCHOEmzCrou9lM3WqbTxL7Lbq2
         ajZSpyzMvs7chkCzS0y7tM7GNRWMVarFYa4IxNUtN6e/e8vWkhV7QFH4G383YSkNkYK0
         GfGpuZoXkeEY3SGsb8B+pB1CJAo8KnmfDWIGUsRXYy7U6+TDX1fyaoPhCr9eQdBQYVcQ
         ZfOGD8gLWtANKAOXYB8qvU4Sbdo08+rqm4auY2ZILDM2K4N+HPsm+INVgJUscxvdZXLY
         CX+A==
X-Gm-Message-State: AOJu0YzcykllJXI9/GtZZGXzS27FMpbUMVW72ot06pmQrevYbspiKxhk
	RV9mv8BEoyshP9yqz/9S638UQhPppHBCfarb8nDaDpnfEDpRDaP71BRDc+VGo8PvtOe44Dd+cc7
	DCGSmHfQ69ZwFSdrQDA2JKkvO3YFAbu0Q
X-Received: by 2002:a05:6808:1908:b0:3bd:5292:f34b with SMTP id bf8-20020a056808190800b003bd5292f34bmr3919300oib.79.1705349989236;
        Mon, 15 Jan 2024 12:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEENaGGKbNIEHX5/BQ/bHPAI0ot4cjGmE5hz+QHF973R9sEcBU9XZAyYAs3BfUj7c0IjoECbQ==
X-Received: by 2002:a05:6808:1908:b0:3bd:5292:f34b with SMTP id bf8-20020a056808190800b003bd5292f34bmr3919293oib.79.1705349989012;
        Mon, 15 Jan 2024 12:19:49 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id z18-20020a05620a08d200b007834386eeaesm3106329qkz.33.2024.01.15.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:19:48 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spinlock: Fix failing build for PREEMPT_RT
Date: Mon, 15 Jan 2024 17:19:34 -0300
Message-ID: <20240115201935.2326400-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
spinlock.h") build fails for PREEMPT_RT, since there is no definition
available of either spin_needbreak() and rwlock_needbreak().

Since it was moved on the mentioned commit, it was placed inside a
!PREEMPT_RT part of the code, making it out of reach for an RT kernel.

Fix this by moving code it a few lines down so it can be reached by an
RT build, where it can also make use of the *_is_contended() definition
added by the spinlock_rt.h.

Fixes: d1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
spinlock.h")
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/spinlock.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index eaac8b0da25b8..3fcd20de6ca88 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -449,6 +449,12 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
 	return raw_spin_is_contended(&lock->rlock);
 }
 
+#define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
+
+#else  /* !CONFIG_PREEMPT_RT */
+# include <linux/spinlock_rt.h>
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Does a critical section need to be broken due to another
  * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
@@ -480,12 +486,6 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 #endif
 }
 
-#define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
-
-#else  /* !CONFIG_PREEMPT_RT */
-# include <linux/spinlock_rt.h>
-#endif /* CONFIG_PREEMPT_RT */
-
 /*
  * Pull the atomic_t declaration:
  * (asm-mips/atomic.h needs above definitions)
-- 
2.43.0


