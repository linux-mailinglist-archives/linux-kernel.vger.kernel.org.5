Return-Path: <linux-kernel+bounces-104043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30B87C83E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D37283433
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE1DDA3;
	Fri, 15 Mar 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZtGZwSs"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B228C05
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710476079; cv=none; b=bKiq5XTiARK0FLX8valxLjlHlAGtO/ZaMTHq6s8iD7mAM4NEmGpQyJIvuqFpOM+cMFwT56RjU/J9yOfKf4cMNCfZ7v+VOCrLdF8W528seUX70Tj6RB8PNVwsb/OWe2GZhtY2fwQEBVe0Ln0JL/zblmAgwMvHPFphXlcQc4PcaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710476079; c=relaxed/simple;
	bh=fNFNjQvXNvgikvOXPiMJs11G4GpRMkjI6aMCQwpzMvw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uaKbCxzFJFh8tIAt55wY2ZyOZlXdBS//u5Zb/c14gO6zEfdCu2tRLZJPE4W1WSDzZStBl/OEbqNzy0kX/vjGlhCmAhfDU/+G3QL0Zc35iT2Kjj6QmaUFOt91RyVS+1Twt3eWAnajU6yBCiJ0k5kou7DD7XBRMT/Gv++O6ztIZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZtGZwSs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1929547a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710476076; x=1711080876; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esWBAWNpxZxSv2f4JZ39IMVHRPSBl9yDSu/rgu5wDoA=;
        b=cZtGZwSsuoaxHBzDsDmiX6SMxR3qbY4mj89UkklRjJHdYQooeXc3DWhgFel+q1zBXC
         uIFYYb0eTjnEHx19Qm5io+52NBOG/5ISXInaODmW06is4WNaW0H+wd7g/vKfeTjyHuV5
         Y/IXBuOIGjmQOiHrNRKVwHZhVETy10AcxAPme/C9YXPzCgoL0UuH3Ot3ROvMYd6goGSZ
         YH4IicJiGqs21V2JFr9UQsrQy+Mjs/XWLzhYFNmTtq6aLM54LDt7vmof9pjFBJUC4YeO
         BFCeLnRgpoTf66cioM5Z4ZrCgbOefqCKtSg2aKEXBLbOx1614S3OjVxI+9DCvEzmBzoR
         5qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710476076; x=1711080876;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esWBAWNpxZxSv2f4JZ39IMVHRPSBl9yDSu/rgu5wDoA=;
        b=Rbim4P1CYg8Bu0JZBlqIWxBax8zmWPhtdmx2cLi9wurPaF28rDoeD1VBElvBD7Ivb6
         KjFZDkm34GZuZULJtP/RkAByIrEnQWHm9O1AilKtEz0PC0RPFj8UT8XdhxsIvzLct/pm
         YIVmduYYvYSKk2fguPNeriGXJ65KcVG7vlnw48duuRQdzSLghPcZO8NvgYln4WIIzH4I
         D/akEDVWBIP4qO5k7U9GNfRLw5gbVnEDWwC/XP4DCBHR0VWY+MToqcO7chuIWnfBL46/
         qTPTBqvTvh+z1ZC8ZM8bZsxQrIg6Dzf7Mp1SEqNq7zXS3HGTl0gBN52knCcwW7EPHevr
         Onww==
X-Forwarded-Encrypted: i=1; AJvYcCXy2ShIjtyhJWT2KX6IiFaGJtxHCDWby8e+geDefKS5KEva8KzttFBTXcOKZSaBUVWV9YRptIkAUQfrdqFD0rD/mVPDbI1hFf4li16d
X-Gm-Message-State: AOJu0YwC8r+hEwho8f+AMipYDzAOaBYCaEBwJf1UWdrNclHGwbJ6aa8i
	ypDjFrBCkBpVAGY1r1PtutAzckfRNiFlt4TVWOxiz273xq8Q8t3z
X-Google-Smtp-Source: AGHT+IHIhge/PybGVc54z98Xe0W/RrPEWumidHHnkfGgW3fIHLT1OqFgrT6J87hZ7vFBnJOGnC9BFw==
X-Received: by 2002:a05:6402:4341:b0:564:5150:76a2 with SMTP id n1-20020a056402434100b00564515076a2mr2158445edc.4.1710476076088;
        Thu, 14 Mar 2024 21:14:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ig15-20020a056402458f00b005681599a033sm1294562edb.13.2024.03.14.21.14.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2024 21:14:35 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>,
	Brian Gerst <brgerst@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] x86/head_64: move parameter close to call function
Date: Fri, 15 Mar 2024 04:14:20 +0000
Message-Id: <20240315041420.12802-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

startup_64_setup_env is first introduced by 'commit 866b556efa12
("x86/head/64: Install startup GDT")'. Then 'commit 469693d8f622
("x86/head/64: Re-enable stack protection")' insert some code which
leverage %rdi, which is removed by 'commit 8f6be6d870e8 ("x86/smpboot:
Remove initial_gs")'.

This left the parameter of startup_64_setup_env a little far away from
where it is used. Let's move them together for better understanding.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Joerg Roedel <jroedel@suse.de>
CC: Michael Roth <michael.roth@amd.com>
CC: Brian Gerst <brgerst@gmail.com>
CC: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3dbd05f93859..5fb8bb7cdabe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -69,8 +69,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
@@ -78,6 +76,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
+	leaq	_text(%rip), %rdi
 	call	startup_64_setup_env
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
-- 
2.34.1


