Return-Path: <linux-kernel+bounces-128459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8395895B19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E26D28448D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653915AABC;
	Tue,  2 Apr 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z92ulbYc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5D175A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080277; cv=none; b=LQkeAhChi/VS0Rdb9YjqYb+nRo4Syr62lQgHA+8Os29TnHBGstYWM1s8WTXxUjrpf6WYoZ+u51ERwcEwkKJ+6xoEu8bvDsASWqUfwD3D3HyGc+j9u4GgVkK42G+LMDBPBGp5fQC4nBzDUlNyJ5HuAofGsinQaOsXFQR+s2s3I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080277; c=relaxed/simple;
	bh=X8/zUI4zO6DOE/dIka0w3ek/ccPMEivBZsLxz/KtmCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwDVVsgVVLlUWvIENHPZYlICbgCfeSrFj8jPpB+SMZkVoGtPTZ5XjdqbO9Gj0lFKL7VUYF/vQs8okZV4ibsbTNK+SjpJFEprKfEZqQYl9tgV1qjWl8tnOGDe9vLYsjAehWRR3ROGki2s6bWdPeRTdB9z60px6H9z9ZaW6yYiWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z92ulbYc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so56863781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080274; x=1712685074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Md9PUewy1DWNEAZDG/GzDr/wmUHw+Qb95S0gsjbWhAA=;
        b=Z92ulbYcUCBSN7l9uMe/3llkfvzOt2EwRjbonr8OfNatav48rPxiZITjb9LLL0Vize
         PpNmlPnvZfN+8J3nnwYDopDSRgM06h4K2/3xV/SwH/9WENQMzUpHO++tSABji3kDnsv0
         VRIVdr2fLiuA/U0LCXa0PP/VyJMH5uDL/Bs6S0LLp2GCdV0EQpj9d3y8rXoMyHzrkLSn
         h2z0MhVPMtAPe+yrs3fDJ5w4r3dNjzQCvWyZuJEO7dpTEuMOsFmR5tDV9Lf7l70aQ5Cu
         AX93Cp6mY7/YwZ3yfbtX8ZL8yMdsl14w9iS7LbRGAFDLaaIicBIL8OOB3Tz+S8BKNr2D
         iuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080274; x=1712685074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md9PUewy1DWNEAZDG/GzDr/wmUHw+Qb95S0gsjbWhAA=;
        b=O9jzgd8KCexsRMwAFaKlJmWoDedkIBf9NlWgQDRyP2/XaJ1kt9lmLOthhQMQwPjL/W
         zteEYrNlnGK/PT6oNQdrwecRI5PlIcexDUko1yLDzrdArYzThW62HyPLS33soq049yVl
         6/qnYVTz4PF6yA9ONNGWhYr1nNhmFHncGMuld+9z5ScazJXtjbYeF1UcJvFUX9Kkp4Br
         nn4f4wyER4nGRUwAH59cW23eck+uKPnGCX+UX0HBAU8JBNp5s10n839MDqlx1k2kbkJI
         ETZr3LSYbx2PYE6E8bULfV8ow3V4FRwvCw6z0P1UOE8cmxL3j/L+ywchN7c5sL0Bs7Dc
         lqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Wh+RfYzVhUrl0tvVNLsuw+Uj27PV7/+qFTiH5tQ6BF3xSuq6G0fSsUcM88FGAhs+5+hYwATVegw/H0epj5nmOSsOgOXD0rCRZsqO
X-Gm-Message-State: AOJu0Yw5W7sd8TKJcOSmwGwdkIdRocG2RX2SHLewGpXl38LgSkC91WHY
	+h1rw+JF1peP+f7OifEvgvaYen6k08lhS3VSjmpuzt94GMffaT4+
X-Google-Smtp-Source: AGHT+IF/TsAmq2jgvQYY9S3J+Xd656UHm4Rw5Kivd3psq+PqjjtHB0it0SoH1rS9vM6XdZsQnxmFsg==
X-Received: by 2002:a2e:9884:0:b0:2d5:9bd4:4496 with SMTP id b4-20020a2e9884000000b002d59bd44496mr8237506ljj.50.1712080273581;
        Tue, 02 Apr 2024 10:51:13 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ev6-20020a056402540600b005682a0e915fsm6993521edb.76.2024.04.02.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:51:12 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Charlemagne Lasse <charlemagnelasse@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Use __force to cast from __percpu address space
Date: Tue,  2 Apr 2024 19:50:38 +0200
Message-ID: <20240402175058.52649-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix sparse warning when casting from __percpu address space by using
__force in the cast. x86 named address spaces are not considered to
be subspaces of the generic (flat) address space, so explicit casts
are required to convert pointers between these address spaces and the
generic address space (the application should cast to uintptr_t and
apply the segment base offset). The cast to uintptr_t removes
__percpu address space tag and sparse reports:

  warning: cast removes address space '__percpu' of expression

Use __force to inform sparse that the cast is intentional.

Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com/
Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/percpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1f6404e0c428..20696df5d567 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -77,7 +77,7 @@
 #define arch_raw_cpu_ptr(_ptr)					\
 ({								\
 	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
-	tcp_ptr__ += (unsigned long)(_ptr);			\
+	tcp_ptr__ += (__force unsigned long)(_ptr);		\
 	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else
@@ -96,8 +96,8 @@
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr)*)(__force uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-- 
2.42.0


