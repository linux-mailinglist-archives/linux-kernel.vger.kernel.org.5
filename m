Return-Path: <linux-kernel+bounces-137989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688C89EADF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDE0281D53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3E383B5;
	Wed, 10 Apr 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSQopYmK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB21427B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730618; cv=none; b=EV13UoM1eSZn5XK3M2dzERjOKARv6zAdO+CcuqQ5jHCFeXV3cAR415xarjS0w/xUXABAq/zgfsGBAxiQxapBGgUDiWVDS2KZPnYHZ9jFCgeXFuNPJanGVEi2/T1PoyzfNr7vHgVQw7gsc4PzGUqUA/TdpVhxxMZQOiHHzDQ3dC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730618; c=relaxed/simple;
	bh=hfmGUGJRC5qYnCDGJi6Q0sqLQpVi0qi+Mm03ZXTOB3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiCr77Uvdb8ZiCr8IsnnZncZXXUqNvsbo0ylEcNDTg7KLxXfFCXfVO8/yG74EWHwscmmQFytz6YBxxZDRMYkusIpqIX1O7Dvr5V4IWausXM6OeTu/vt2BRpyiDxt6cLS3mvWfZuVxGsgJQ/Le/2VAHDVV4ouGCDGkcaTzX6UQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSQopYmK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8485198a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712730615; x=1713335415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfDl8VXjqT1xe25Pkv7WIcjg9jGtsFTMnccravoA0jk=;
        b=bSQopYmK0HqYrURleWXrp45XGWYK8MpHQh1Tv7iWjIwKtwcfjrWH0ltsIOm03Cc6D1
         V7lbkeRNNMp/EWKWpaah+2D6wTA/ZzakGQhzrlezp3/Ogif1jNz848ZDJZmiyxfjSFfs
         IxfO8+nALlHptifo9QurBUm4iNIILqmr3KY4TIXN0pqshO3u1xyE3NH/xdhAPpNrDcqY
         wdy7Za1flsABm6JW2xngFV4fyrg5bHWlDxc9AAigm/8IZBQEc/qenGlO731HBrKN/MOT
         tW8sM3MR7SFfsqcgzJzV4dF9DRU1RAL8Zkf2HoY0s69RzHSXb6V+Vl3DxNa3y/JsUml7
         GFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730615; x=1713335415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfDl8VXjqT1xe25Pkv7WIcjg9jGtsFTMnccravoA0jk=;
        b=NT2TgwhT/aUavOVCzkR4D9HP9A0prB2Nqe3M4fZGpLQelZU4amY+chS7kxMVGxdlJd
         o89sj60aO5gBBzQnN/GUqknqBpTfeefmXIcxQ3JnNwumyJI+wKxlyDY+eN/DQPkzfO+N
         wP9P9ow6Q/qOECn5tMtinGF7fPo6Vpwjd8pzOZu0UtjZhBbBgPX4TaRRpQ6hQKKutzMj
         nIolHPSQHqaKoPHSnA5UBwTeWIOwofx7UeoleZvCE5WWlfLXwh+dTZyGmpUo3/vUXbj2
         ImSlCULNrpZV2uGaemnG1h8+EcFZzI5JHf5OnAyoj80jgZL9Zqe4PAp0oHB32Ak5AXMc
         uR+w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Y6SgXsSbOHjKZMvnau87gEPgIwbEdK1j9TMjkOgPqXpmgH4+n2Wf4yeDmmvbeEK+Ggr4IaFUjMZK6nUZtEFLwhrTAygFSJdrIuMa
X-Gm-Message-State: AOJu0Yw+A/9Zu81FvMVDB5BfXJAl+Ss+l2/DZDFQ6zKW1izsZa45O5VY
	q4csIOlK1bU0bhdaebNWE/FKyzrRVOy0nHcCgKxkts7s3PgL2pgw
X-Google-Smtp-Source: AGHT+IHtv1KOyiS1RizQPwf+6BjyqSfIyiSY0CZFL299CsdjFE/LBN1DlIloZ5YIXx116MeHAGRtvw==
X-Received: by 2002:a50:9fcb:0:b0:564:5150:76a2 with SMTP id c69-20020a509fcb000000b00564515076a2mr1020712edf.4.1712730615188;
        Tue, 09 Apr 2024 23:30:15 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id c9-20020a0564021f8900b00568c613570dsm6129606edc.79.2024.04.09.23.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:30:13 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 4/4] locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions
Date: Wed, 10 Apr 2024 08:29:36 +0200
Message-ID: <20240410062957.322614-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410062957.322614-1-ubizjak@gmail.com>
References: <20240410062957.322614-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to implement arch_atomic_sub() family of inline
functions, corresponding macros can be directly implemented using
arch_atomic_add() inlines with negated argument.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      | 12 ++----------
 arch/x86/include/asm/atomic64_64.h | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec04350..55b4d24356ea 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -86,11 +86,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(-i, v);
-}
-#define arch_atomic_sub_return arch_atomic_sub_return
+#define arch_atomic_sub_return(i, v) arch_atomic_add_return(-(i), v)
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -98,11 +94,7 @@ static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_add arch_atomic_fetch_add
 
-static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub(i, v) arch_atomic_fetch_add(-(i), v)
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 3165c0feedf7..ae12acae5b06 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -80,11 +80,7 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(-i, v);
-}
-#define arch_atomic64_sub_return arch_atomic64_sub_return
+#define arch_atomic64_sub_return(i, v) arch_atomic64_add_return(-(i), v)
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -92,11 +88,7 @@ static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub(i, v) arch_atomic64_fetch_add(-(i), v)
 
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-- 
2.44.0


