Return-Path: <linux-kernel+bounces-68176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB98576D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC221F21483
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC37168DA;
	Fri, 16 Feb 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GojglAen"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89C12E78;
	Fri, 16 Feb 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068801; cv=none; b=LJW/CIS8FI2aevGKYyTp6NYo9bC8YpM181zs0PWfQJ4h26sdfBQ4TvdduwOn4v/4A2CPvY4YiEdsqS18OoF4tAbiT0Sc2EvVWWtp6G973udGUdJGhcvxb/wt2vwQoizvSk/CCAFstniQaoz9SOQLFXC+re+8JiXGXKkltTDqtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068801; c=relaxed/simple;
	bh=JrFYOs2FPwXmy1/XqxjA+hM8SVuG/+lRE4KuH28UyIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+lkVy0ySrJWHDPUnzTEz8sLHwLwX8njaJhxxiZX1bXuYIOQmkfTZK+ahE4U6K+lHJVFdKxoU1/hsj6ufHderuz2QPn9Iohb4/MxWot/+oHlYxD+Yk4pmNyeZoyk7/lrSoc4BsWj03geYlcDx97xkQhaqGAFKZjmbTmX43ehay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GojglAen; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d94b222a3aso16570005ad.2;
        Thu, 15 Feb 2024 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708068799; x=1708673599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CMrR5jQVO31f2C7rY/OyhbWryGnGfhcw/HWvAL8HISw=;
        b=GojglAenlNi0EnQJb3tIkM/u89ntEnEhLAGtRAOxrR/YorRBL2r//5aiEIKpuOaB2m
         1JA48yUCxAGeqPEeOh9BzNHROV+UDuw6b4EFvBv5f5gOPuG+2kPmvVzZco88MeyEYA/Z
         YOm4VA69fySIMuFADHHV+937tVWa3HZFDeqkNzR9tIHv1pbJNS+hL/IR5kMU6z4k19KY
         1kinCRBD2A5kUWPTDq/R6rPS5qDpK4Zcg6QETvL/UK2fLazHXj0nkXnV4br7IFOAfrXu
         0OMQ4NZ+DE2/S+1sc3ZBZLwjAHeS5Q6s6oYdhSWWH7SZ22+SKKfkKg8D4wJruKSc3v11
         nIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068799; x=1708673599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMrR5jQVO31f2C7rY/OyhbWryGnGfhcw/HWvAL8HISw=;
        b=RAYoNZA/omPU+TJZIEgyoQ+QDZ6pGy+Sl9bx8hKrTJdLSU8jgTVP8D5aeiaS/q0SOo
         p7TOB2dmtTsBA1uVMJ1TQEhQ9AvOZ/jNl3pvgWpywNT9U7/qjDQFKzEtvc7sgvaGKSnv
         2Hg7MGvIzX6mSewPqHPaKGrx/n++n6Y7hm8676/5hRwgaNeD7C3LbAfW5xNfqlnTaAOh
         Y2VgNwoCAyUkAMiWDFQitAWYnWx5MZFcDa4gycOTDhKfyCsMgfzg8Z/AOLqScVqzh/iH
         XeQ33MJSYHQLTnjd63VCyYhvd8xhXct4y/OFOY/HsZjUeQu9SmXQmlch5ITBv4hvQy9G
         eCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt7d9P/9S0aFggW9rYhvzDoW+RTEogK2K+lnAWDua8emgx5tYQZnAWib2oZLz6iIdXrMK9d6UivaAbZR3R7dQ8nz3877ORF//kN3Kc
X-Gm-Message-State: AOJu0YzYyJqLjlucmZETBsVhuTzgkG9QQTnjtcuBFUxl6KKA/OWbYc5Q
	X8wRBxQf16EZVXW7EhMvaf3EQGrvZXz1Gav7pbGVewfVhQRxE9EC
X-Google-Smtp-Source: AGHT+IFr+SagVtSO4PmH1xd1WdlIdpB5MqwREa//fHVExHaysAvSPd55ite6cpQYSsFOtL+XMQw1TQ==
X-Received: by 2002:a17:902:d4c3:b0:1d9:a647:5566 with SMTP id o3-20020a170902d4c300b001d9a6475566mr4766249plg.4.1708068799003;
        Thu, 15 Feb 2024 23:33:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709028bca00b001db7d3276fbsm2367607plo.27.2024.02.15.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:33:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] parisc/unaligned: Rewrite 64-bit inline assembly of emulate_ldd()
Date: Thu, 15 Feb 2024 23:33:15 -0800
Message-Id: <20240216073315.3801833-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use real temp variables instead of clobbering processor
registers. This aligns the 64-bit inline assembly code with the 32-bit
assembly code which was rewritten with commit 427c1073a2a1
("parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()").

While at it, fix comment in 32-bit rewrite code. Temporary variables are
now used for both 32-bit and 64-bit code, so move their declarations
to the function header.

No functional change intended.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Implemented while analyzing a bug. I am not really sure of it is worth
the effort, but I figured that I might as well submit it.

 arch/parisc/kernel/unaligned.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index c520e551a165..622c7b549fb8 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -169,7 +169,8 @@ static int emulate_ldw(struct pt_regs *regs, int toreg, int flop)
 static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 {
 	unsigned long saddr = regs->ior;
-	__u64 val = 0;
+	unsigned long shift;
+	__u64 val = 0, temp1;
 	ASM_EXCEPTIONTABLE_VAR(ret);
 
 	DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n", 
@@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 
 #ifdef CONFIG_64BIT
 	__asm__ __volatile__  (
-"	depd,z	%3,60,3,%%r19\n"		/* r19=(ofs&7)*8 */
-"	mtsp	%4, %%sr1\n"
-"	depd	%%r0,63,3,%3\n"
-"1:	ldd	0(%%sr1,%3),%0\n"
-"2:	ldd	8(%%sr1,%3),%%r20\n"
-"	subi	64,%%r19,%%r19\n"
-"	mtsar	%%r19\n"
-"	shrpd	%0,%%r20,%%sar,%0\n"
+"	depd,z	%4,60,3,%2\n"		/* shift=(ofs&7)*8 */
+"	mtsp	%5, %%sr1\n"
+"	depd	%%r0,63,3,%4\n"
+"1:	ldd	0(%%sr1,%4),%0\n"
+"2:	ldd	8(%%sr1,%4),%3\n"
+"	subi	64,%2,%2\n"
+"	mtsar	%2\n"
+"	shrpd	%0,%3,%%sar,%0\n"
 "3:	\n"
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
-	: "=r" (val), "+r" (ret)
-	: "0" (val), "r" (saddr), "r" (regs->isr)
-	: "r19", "r20" );
+	: "+r" (val), "+r" (ret), "=&r" (shift), "=&r" (temp1)
+	: "r" (saddr), "r" (regs->isr) );
 #else
-    {
-	unsigned long shift, temp1;
 	__asm__ __volatile__  (
-"	zdep	%2,29,2,%3\n"		/* r19=(ofs&3)*8 */
+"	zdep	%2,29,2,%3\n"		/* shift=(ofs&3)*8 */
 "	mtsp	%5, %%sr1\n"
 "	dep	%%r0,31,2,%2\n"
 "1:	ldw	0(%%sr1,%2),%0\n"
@@ -214,7 +212,6 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b, "%1")
 	: "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
 	: "r" (regs->isr) );
-    }
 #endif
 
 	DPRINTF("val = 0x%llx\n", val);
-- 
2.39.2


