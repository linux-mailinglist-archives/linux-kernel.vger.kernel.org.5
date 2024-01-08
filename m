Return-Path: <linux-kernel+bounces-19277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B6826ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E141C21D56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8D12E7D;
	Mon,  8 Jan 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="pLZ/eXXR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973511CAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bc09844f29so1773019b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704706351; x=1705311151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn2kTcTKQegvfRo59aF494Y7VB6jkLeF4G27EDz1T1U=;
        b=pLZ/eXXRB3+9mUJwci1Pof7Ix/tzRkQDLy0QtNzvUjT+Lo2Z5oesTNffFaatNJL84q
         3YitEdqx3rOJp+gQWG7LGLQfQgxZAXHtrPAsKktEb1PqgyNTAMkMJJn9uMlVYqjIa1nG
         TX1xD02D3FksICc8NrmLham6kPqZB8qBWBy3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706351; x=1705311151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn2kTcTKQegvfRo59aF494Y7VB6jkLeF4G27EDz1T1U=;
        b=uvhNAAHP8f6JDuFciUx2dIm/lX36wKdC8ca0P1McHkxUvW241FYUI5+5taU9LAmhxx
         p9YZFnFknKKJl3aY2Jk+kkCiXRICsdIJ33zjDK3Lp5uOYz23C2d05IABgr5eLxRUw5Ju
         y302SakAb6XiHFWeghR9p/HBf4cM9SzeGQ+24I46fNOus6AHXeNymJKrpDH5LpJGta/k
         pTq6w2EOaIQhlYLS3RzMmNnnvLtCh7KzMUkqU9Xd/vsmk9831Uumm6kGE0XeP7f0qaQv
         I1TMJcADl1UJJMLnJ5mgkWCRIM+NA03QseHFbXHnUixd6qnYFDogEn+Lgawlwiyr/7Ne
         Fhrw==
X-Gm-Message-State: AOJu0YzvP9K309eVz1chxMeKPUNq/DdCX4OVzGP8K4ICAXdgR9wa3qrd
	yphwwFEo7e5Cvf1NWGcDwNQpXnkTXcwyZypVU3BTphgED4o=
X-Google-Smtp-Source: AGHT+IF0v9pYtaCUdIMW0KC8X3CbJCAZUdalzX5CmE1kx5uZ44HD8tapWvSVvYGzZsd5cm0k4YOdCQ==
X-Received: by 2002:a05:6358:949d:b0:170:e930:bd3 with SMTP id i29-20020a056358949d00b00170e9300bd3mr3002255rwb.32.1704706350703;
        Mon, 08 Jan 2024 01:32:30 -0800 (PST)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:a221:b29b:7116:6ce9])
        by smtp.googlemail.com with ESMTPSA id i8-20020a632208000000b005cdbebd61d8sm5578974pgi.9.2024.01.08.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:32:30 -0800 (PST)
From: Daniel Palmer <daniel@0x0f.com>
To: gerg@linux-m68k.org,
	geert@linux-m68k.org,
	fthain@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 1/2] m68k: Use macro to generate 68000 interrupt entry sleds
Date: Mon,  8 Jan 2024 18:32:20 +0900
Message-ID: <20240108093221.1477020-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108093221.1477020-1-daniel@0x0f.com>
References: <20240108093221.1477020-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for decoupling the plain 68000 code from
the DragonBall support clean entry.S a little bit by
using a macro to generic the interrupt sleds (needed to
put the vector number on the stack as the 68000 doesn't
do that) and use the correct numbers.

The function to call from the sled is a parameter so that
other interrupt types (i.e. autovectored ones) can specify
their handler when they are added later.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/68000/entry.S | 100 ++++++++--------------------------------
 arch/m68k/68000/ints.c  |  28 +++++------
 2 files changed, 34 insertions(+), 94 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 72e95663b62f..e1fc740412f2 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -23,13 +23,6 @@
 .globl ret_from_exception
 .globl sys_call_table
 .globl bad_interrupt
-.globl inthandler1
-.globl inthandler2
-.globl inthandler3
-.globl inthandler4
-.globl inthandler5
-.globl inthandler6
-.globl inthandler7
 
 badsys:
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)
@@ -119,85 +112,32 @@ Lsignal_return:
 	addql	#4,%sp
 	jra	1b
 
-/*
- * This is the main interrupt handler, responsible for calling process_int()
- */
-inthandler1:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#65,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler2:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#66,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler3:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#67,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler4:
+/* Create an interrupt vector sled */
+ .macro inthandler num func
+	.globl inthandler\num
+	inthandler\num:
 	SAVE_ALL_INT
 	movew	%sp@(PT_OFF_FORMATVEC), %d0
 	and	#0x3ff, %d0
 
 	movel	%sp,%sp@-
-	movel	#68,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler5:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#69,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler6:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#70,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
-	bra	ret_from_exception
-
-inthandler7:
-	SAVE_ALL_INT
-	movew	%sp@(PT_OFF_FORMATVEC), %d0
-	and	#0x3ff, %d0
-
-	movel	%sp,%sp@-
-	movel	#71,%sp@- 		/*  put vector # on stack*/
-	jbsr	process_int		/*  process the IRQ*/
-3:     	addql	#8,%sp			/*  pop parameters off stack*/
+	/* put vector # on stack*/
+	movel	#\num,%sp@-
+	/* process the IRQ*/
+	jbsr	\func
+	/* pop parameters off stack*/
+	addql	#8,%sp
 	bra	ret_from_exception
+ .endm
+
+/* Dragonball interrupts */
+inthandler 65 process_int
+inthandler 66 process_int
+inthandler 67 process_int
+inthandler 68 process_int
+inthandler 69 process_int
+inthandler 70 process_int
+inthandler 71 process_int
 
 inthandler:
 	SAVE_ALL_INT
diff --git a/arch/m68k/68000/ints.c b/arch/m68k/68000/ints.c
index 2ba9926e91ae..e721932e495d 100644
--- a/arch/m68k/68000/ints.c
+++ b/arch/m68k/68000/ints.c
@@ -63,13 +63,13 @@ asmlinkage void trap46(void);
 asmlinkage void trap47(void);
 asmlinkage irqreturn_t bad_interrupt(int, void *);
 asmlinkage irqreturn_t inthandler(void);
-asmlinkage irqreturn_t inthandler1(void);
-asmlinkage irqreturn_t inthandler2(void);
-asmlinkage irqreturn_t inthandler3(void);
-asmlinkage irqreturn_t inthandler4(void);
-asmlinkage irqreturn_t inthandler5(void);
-asmlinkage irqreturn_t inthandler6(void);
-asmlinkage irqreturn_t inthandler7(void);
+asmlinkage irqreturn_t inthandler65(void);
+asmlinkage irqreturn_t inthandler66(void);
+asmlinkage irqreturn_t inthandler67(void);
+asmlinkage irqreturn_t inthandler68(void);
+asmlinkage irqreturn_t inthandler69(void);
+asmlinkage irqreturn_t inthandler70(void);
+asmlinkage irqreturn_t inthandler71(void);
 
 /* The 68k family did not have a good way to determine the source
  * of interrupts until later in the family.  The EC000 core does
@@ -163,13 +163,13 @@ void __init trap_init(void)
 
 	_ramvec[32] = system_call;
 
-	_ramvec[65] = (e_vector) inthandler1;
-	_ramvec[66] = (e_vector) inthandler2;
-	_ramvec[67] = (e_vector) inthandler3;
-	_ramvec[68] = (e_vector) inthandler4;
-	_ramvec[69] = (e_vector) inthandler5;
-	_ramvec[70] = (e_vector) inthandler6;
-	_ramvec[71] = (e_vector) inthandler7;
+	_ramvec[65] = (e_vector) inthandler65;
+	_ramvec[66] = (e_vector) inthandler66;
+	_ramvec[67] = (e_vector) inthandler67;
+	_ramvec[68] = (e_vector) inthandler68;
+	_ramvec[69] = (e_vector) inthandler69;
+	_ramvec[70] = (e_vector) inthandler70;
+	_ramvec[71] = (e_vector) inthandler71;
 }
 
 void __init init_IRQ(void)
-- 
2.43.0


