Return-Path: <linux-kernel+bounces-27079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7B82EA12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88491C22FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A1111AB;
	Tue, 16 Jan 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua5wCZME"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCC10A3D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705390373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK1cfcz5VdHUqaPh3D2ST8gwHCilhZQB43Ha1E7iCnM=;
	b=Ua5wCZME6jx6re5nxz9PGwdmcwlZHYJp/v6pUP+VR0GXnj8l0wc5bZjhrh3++6fxY2rEie
	21b4DP4TtD4p1VjWoJHWD74QooXmkM1wXhuLk2z8naP729tl5kpBIGPEWLiKVCHVgUlTSw
	X9gQFpnvYJnfP9vp7MBa4caPeIaoLhI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-ELD_HopOPeOsznxynZOAQw-1; Tue, 16 Jan 2024 02:32:52 -0500
X-MC-Unique: ELD_HopOPeOsznxynZOAQw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e744f7ca3bso148936287b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390372; x=1705995172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK1cfcz5VdHUqaPh3D2ST8gwHCilhZQB43Ha1E7iCnM=;
        b=fCFpxNpKxU8IdtsFo/Pd3lHgMUyRC7K5SodEXkOT9w3XM1AXpn4gsXWTb7Rlj7HIgK
         IQna9BTX+05j7NGJVNZJGe1qmBjt5UKf6h4BHay9I8zYTbeowMbLGarQT+DR4SN5vYul
         /b4+TrOd02scGkTZEmc+/s5CFzeO/EI4673VXBbgOFZJRB0UwI3p3jczWfZoshO3lBxG
         wM7g3shKCjsyFGXQ0Ig7QgMr1i9e3ZsHlZn14egCL4PIoFQgef0FCpU7mPuj4pqJ929I
         JbJjtkW1P7+1dttZdiCiaHaMhjRAx1wtdIv/4SkyoWhVcV+2zJu4eF4V66HFNKrifSUv
         QAJw==
X-Gm-Message-State: AOJu0Yyi44xpiZ+F5rqm9SZJX0zCjj3FZzl5v4+dv1bRWAb8NUl4Mv6u
	CskVJVyud/q2Vhpc9hRyfJD1KUHlEUQwgpONOJdE8FDKNAe9KGTOANQTZI4U3DaimhagEng6ObH
	TmadQXZ07D5SfR0zlwgz2fq8FMaYoi607
X-Received: by 2002:a0d:e2ca:0:b0:5ff:4b0b:4fde with SMTP id l193-20020a0de2ca000000b005ff4b0b4fdemr764981ywe.71.1705390372032;
        Mon, 15 Jan 2024 23:32:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH18sC1Cs9/OKkVFG7RU6M8v69e0rJ25aBTS4Qw1zCjKQ6+lsbbNadsC6htY9S5MhqTXseJTw==
X-Received: by 2002:a0d:e2ca:0:b0:5ff:4b0b:4fde with SMTP id l193-20020a0de2ca000000b005ff4b0b4fdemr764969ywe.71.1705390371787;
        Mon, 15 Jan 2024 23:32:51 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id bs6-20020ac86f06000000b00429d6bd085csm3191262qtb.6.2024.01.15.23.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:32:51 -0800 (PST)
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
Date: Tue, 16 Jan 2024 04:32:32 -0300
Message-ID: <20240116073234.2355850-3-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116073234.2355850-2-leobras@redhat.com>
References: <20240116073234.2355850-2-leobras@redhat.com>
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


