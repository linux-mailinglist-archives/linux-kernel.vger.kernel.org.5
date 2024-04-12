Return-Path: <linux-kernel+bounces-142246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C688A2974
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56748B25258
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2E37145;
	Fri, 12 Apr 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrGkQ3RP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF52C6B3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911154; cv=none; b=AtBH1Sx7DDpDN6x15HM+BAENZEuddx9qoBdUCxPUxhPPPcx5J12xtPSVfAtf3JlIIs5y0Rslz5bRWO7hwSIyVK0Vdexv3Ei6tSZ6qfx84iiqKxpS0M/J08QnPWtU1gizd2F0bkyQ6NH9utV6HUUF3fStGQApXoUPY4PS0K4xbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911154; c=relaxed/simple;
	bh=6C6aLpyj0Z+TA672hlz8aMVf1BHtqYDAkYSXq5qkj70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXsq4eS7I7HFq1r6wQRzcUSRsHogFQ+GBsBpAmpjlRdklXkan68DBjWN+PTR5T7GTNisvf5jl95uHYf7EHE05iSLrzRvLs8qLLNU/Np17inxIw5K+e77upFU1FfI79zxb75o9/ap/vtYgnI6kkHgZXjJx8Oahj0l/fEJJYLXpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrGkQ3RP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso261587a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712911151; x=1713515951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0J1yegJWFmYmKya5wd2c47UHSHOnE6ubSSo/EOMOjI=;
        b=lrGkQ3RPAFSfKIkPdJSV42t1zRnZ0xjoL91nyGYJIydQsfP0vo7iWlODAUDJpq8svF
         1JNYJHD94Obg9g94cWLvB2wHI9wvrPQ+nqOMvH3oC7KdDX2qlsZItUuMV+i5QJeAwS63
         gx2makBxDwiHTaDZ9f5YAzcB5Id2l2iKSM+q1P2ZhmGVPn7ya9BN+H3rVg4MryWLeAIw
         GN7bn7vF2HQPR1zww6xgwN2qynMSIZZ6gI2knPreSJ9P33QAOFTp1nJG35jOoZ3XDVxQ
         MAvf/i9GwvNuDpCIpiryuBDd1Qh6cWyUag1s9Avv49OXBu+o4+Hu41HMrpKMi37XSHXk
         21Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911151; x=1713515951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0J1yegJWFmYmKya5wd2c47UHSHOnE6ubSSo/EOMOjI=;
        b=t1xKPTIvpoF5XTwLrQxL4Gq7z8DUCk+wJbP2cSBUMPy2A9eiU6UezbHaKG5qbuypMA
         qBJ9cATVPYglF93E1UH5IjlSmA+deym+D5xuvr9bUZGbeyBHqc6g0+vTeIStPBTeowfz
         E+aSxQ5LDxiN9EnuxxCTvTj9U3ZRORKqLvrjl46yp9UxSB5v+CTxKqlX6mdZ2dI9you5
         30CpQYz4Le8wrK3d0xYB71SHmGK6QKHnhBfxk8tH6IzjMNpRGObUHHvhjXzOFU2suUik
         WHs/JhN2JyJSNmeh6UcSdUgCHldl4Zl3OTm8oz/ID3PIWRbX9bL65zAC5H0nt9r9bwOR
         8TTw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBZsJ81k8+hQSCUxnEV78FAQIIQ9Di9IswAv4UcrTs7buHj8YQNLWOjKMK4PhhySN4L5Xf5i8KGFCvsqGeARAWmQYf+6Wh5lhD7ZV
X-Gm-Message-State: AOJu0Yx3n+aUGE8JN3G4QoZeobO6AOejW55c275ssi3iKG1H70Yb/yOx
	ALKK4ITmx0Jv0UGZYWoJCtg7sadqufAGz9kByWlP0Zr+LT2fkY4O
X-Google-Smtp-Source: AGHT+IHJOD5BFrp+ZVDKjkEBpm1iuOIXoLXZccSCmTb7oNL9FcLiSkg1eKw4Q221sIpf6ehW8LMJZA==
X-Received: by 2002:a50:8e12:0:b0:56e:2433:a0ab with SMTP id 18-20020a508e12000000b0056e2433a0abmr1806709edw.34.1712911151080;
        Fri, 12 Apr 2024 01:39:11 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id l11-20020aa7c30b000000b0056fe3d81b5bsm1454634edq.79.2024.04.12.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:39:10 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/pvqspinlock/x86: Remove redundant CMP after CMPXCHG in __raw_callee_save___pv_queued_spin_unlock()
Date: Fri, 12 Apr 2024 10:38:53 +0200
Message-ID: <20240412083908.282802-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 CMPXCHG instruction returns success in the ZF flag. Remove
redundant CMP instruction after CMPXCHG that performs the same check.

Also update the function comment to mention the modern version
of the equivalent C code.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index ef9697f20129..466af57b8ed6 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -25,9 +25,9 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
  *
  * void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
- *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
+ *	u8 lockval = _Q_LOCKED_VAL;
  *
- *	if (likely(lockval == _Q_LOCKED_VAL))
+ *	if (try_cmpxchg(&lock->locked, &lockval, 0))
  *		return;
  *	pv_queued_spin_unlock_slowpath(lock, lockval);
  * }
@@ -43,7 +43,6 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 	"mov   $0x1,%eax\n\t"						\
 	"xor   %edx,%edx\n\t"						\
 	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
-	"cmp   $0x1,%al\n\t"						\
 	"jne   .slowpath\n\t"						\
 	"pop   %rdx\n\t"						\
 	FRAME_END							\
-- 
2.44.0


