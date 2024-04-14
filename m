Return-Path: <linux-kernel+bounces-144035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B286D8A411A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57481C21084
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93629219ED;
	Sun, 14 Apr 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW7pONAp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A4208AD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081679; cv=none; b=dw/KNlqCtCdwrlb0Uj6h/gWCY7dAiP7Ah0vhIPmaxD/VF1smYlA/nZcua17p5kzZ17msrm3Ss22q1/mF7ekX6EvqARBp8MxY40TPVFQwKvlrh1mN0UUYoj/r6YfWtd4ymIP4ij4KAfdOidkoislXENnGHfnq9qxly6Ib4vpJBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081679; c=relaxed/simple;
	bh=ECMysrP8zjPcxjfhOtZ0DK0O51XqwOuVaxe/4M8ZB+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ioxI0wfkwvglLxitfSEYEJjQqehAi7BPcT21fsCb4FKd2Gml7T58MEczT6lCSWHecXRIS7c7IyJRurG130R/kO5ewJoEbWzBKRNXri82dIZbG6Zdh0CIkBu1lnfnASvqRU7xLtng9kmdePLQYJ8USGev8m/a0jdjTm+V649/k80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW7pONAp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5425558a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713081676; x=1713686476; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iqP4FRZX74jWgTQcUVDjMloIsKSGUqdMZFPLZDB+JmA=;
        b=QW7pONApnMzd1rFbwf5FZ4kwCbdm9mKbwi6xdtQrcrtlN74sBnD6LC/Vbf6+iBwqAJ
         1UAnaOoOjOi831nwVbBm4d1Ogk86zVUcypry+dCn2ZaN2zD5p6OyssKqqgiWX3cSUh9Q
         yYrznm3sl0+Ko6p6bvI/8UKCDkJ7F3A4MseitNBioxNuvG3iBCb4GvB4aSk7gkLm7nMb
         z2JeTJy6P/nb3VVzDsvEGVyO6L8ey+wLwGVcJftKc33olEACW9w5Ms/WajjC4CLKpZDN
         3qVLvgrvl4QWfonM0tciLEicP4pxnPY/b4uCyAngk9ew2Q1aoxNEXQLzEt9i4Re84PRT
         c2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713081676; x=1713686476;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqP4FRZX74jWgTQcUVDjMloIsKSGUqdMZFPLZDB+JmA=;
        b=ZuKpXIMFCm+CyDCnWvB73KldQzXUjX7H7zaft5KKKYcm+xQl/1xzUVgWdhFu5rrgSK
         TtpVBYf0gL6G1e8DIMlNhX7nH67YqnQStK8Qv5OQXizZM40/W4uKWB88s9Blc+qL1C28
         pvnuQ3kTgnrgR8VMqhGMNff4vOdwyLbMijfusShdT56kei3Kwt2jt1B4Kj7bHLZsrQ06
         ciXM1AHSg3TGE6FFwqWhJujrQp76Rr0LbPtUsyNFZqs9qIUNDLE62iRQglop0iQPk4e5
         ykXV9i56uhLOyg2uTqLhFSw8Sx0dCjwXZgQmQLKf0v41+JMx5Bck0+1uyZDJs0mlB+Ej
         tD1g==
X-Gm-Message-State: AOJu0Yy6XKWGpRMRaDqY0+RPSlWKrz6Gbza7vpnvcqPHfqMsBEdoA73E
	Vra0Dr2xP84pVwKlql54XhOZL0fDHMvfcssYw9hWubvy/lmBnupG
X-Google-Smtp-Source: AGHT+IHuE/Pn7Tdt6KdNWzZ8PKXNgvmuVfMED7Lbn5h7QLSUVtv42CUZ3llsLg5MrUdtc/eDn17uwQ==
X-Received: by 2002:a17:906:6a08:b0:a46:4bd4:df86 with SMTP id qw8-20020a1709066a0800b00a464bd4df86mr9760100ejc.3.1713081676223;
        Sun, 14 Apr 2024 01:01:16 -0700 (PDT)
Received: from gmail.com (2A00111001332BCD9129005EE765889E.mobile.pool.telekom.hu. [2a00:1110:133:2bcd:9129:5e:e765:889e])
        by smtp.gmail.com with ESMTPSA id og42-20020a1709071dea00b00a47152e6d10sm3923034ejc.134.2024.04.14.01.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:01:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 14 Apr 2024 10:01:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] locking fix
Message-ID: <ZhuNSJxHZzWhVAik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-04-14

   # HEAD: fa1f51162338b3e2f520d4bfedc42b3b2e00da6d locking: Make rwsem_assert_held_write_nolockdep() build with PREEMPT_RT=y

Fix a PREEMPT_RT build bug.

Thanks,

	Ingo

------------------>
Sebastian Andrzej Siewior (1):
      locking: Make rwsem_assert_held_write_nolockdep() build with PREEMPT_RT=y


 include/linux/rwbase_rt.h | 4 ++--
 include/linux/rwsem.h     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 29c4e4f243e4..f2394a409c9d 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -31,9 +31,9 @@ static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
 	return atomic_read(&rwb->readers) != READER_BIAS;
 }
 
-static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
+static __always_inline bool rw_base_is_write_locked(const struct rwbase_rt *rwb)
 {
-	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
+	return atomic_read(&rwb->readers) == WRITER_BIAS;
 }
 
 static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4f1c18992f76..c8b543d428b0 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -167,14 +167,14 @@ static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
 
-static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+static __always_inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
 
-static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
 {
-	rw_base_assert_held_write(sem);
+	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
 }
 
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)

