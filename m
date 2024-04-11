Return-Path: <linux-kernel+bounces-141446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CB8A1E61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BED5289AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F5127E36;
	Thu, 11 Apr 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnYVlbTL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDD502BB;
	Thu, 11 Apr 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858834; cv=none; b=FJaYYbzXmQ5t4zwgJzutR7ZOln+ePD7Tq7Tuw3NVaetbXT9U22NMMwmmdSCWh2BjixS6j+2Y5Vy17JSWjpEC32I1f7RU3OSgTV4/DXIWZaKD6CXScdQx5RUT1M+F+4SuHegEl27+nHCuEmyMUEcB4BCt58CkzMCU4p2UnQZby6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858834; c=relaxed/simple;
	bh=I5urM/vWL1w/7VyWDdzANbhN6MI/8wGHWR7ZeH+m+FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQDZLbmjYixSoe5zsS5Fu6dRuPgmVQLdjEYuMIOnj19oV6OZ1VSGpapjJlLSAQGPynqJd5jxf9nOWVRk4QkebCpVTywuPziDPat1GCuS6ZD9J64Agl5JYBRL3Zm41e0b8MlzB979hrYTKq3FtPaKf+VGhWa2yitgwZs94OUjhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnYVlbTL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso20649f8f.3;
        Thu, 11 Apr 2024 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858830; x=1713463630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+EOwJXhsx9QbZNsLj6JVJxMOSSSrrswJI/F9CXcQGQ=;
        b=KnYVlbTLmJhfsYL10pOZVnO0KMgyPrmMILJuL2NiTN9BaBw04cHqGne1pxcMhXBTdw
         ZSMmxVAAhCWuX+Y8Klv+VDafh9qCb/9GOHbwPA8PiOuSReUaSDItJHLTY1xfg5OOHIDO
         h3+cjYru9ZDwqXGfEk8cx3pyIRy4PqwsSDKEpCjplTIWkrTESFcmLg+JceBQvMby2su4
         oYg8UOVhKFbvf0dLFLElMoeUHkVSTj2uhIlFKs9MYjhbfvvYi7XDLVNSaYPkYzKawE0O
         yF8HN1GSVPSICBRniUCCRv0UrTkWF4P/FKfm96DCoK8J0Oar7ILxV7MILgMPHBlUD0TM
         yoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858830; x=1713463630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+EOwJXhsx9QbZNsLj6JVJxMOSSSrrswJI/F9CXcQGQ=;
        b=YlhLKQwRF39Omfwm3l798+/ihcIk6hijNY8vJzHHt3TPQIlT56K8qXFXzi2oebaZ6m
         Jlu3/r311JfCKeWfbglowPpCLIiZSQTOsnJdLVqxWQk9Ia5vADGyfDq9He7MacO6beP5
         3hDjG1JG4YnrF8pLTV7KRSNK6OAPmqkpTZ9gZbaJtojGFUJ/10vrA+f6krW7y2sOFf95
         dIDBJmuifleKItkeNQF3GDowmnFyZEQxTPUpjnGIqDRScqnGbTtGhl1bVJ+qTqkQ6FHv
         0TE8ON/HeCGGhuLxvEYQEsmK7tJIxgy77E4gOGzSYlCC7r1WCSJtOprAqnIRb9fNrERG
         hEnw==
X-Gm-Message-State: AOJu0Yy+Tiv2CSdNCR+XHAiyQxp5Be8qg+nVqFAeirfq/s4cFjd8hqYb
	n2qe5hxD+s2TMVi6BzrX4H0plFqLUEcXvX8kLG06Y6nPoxRgaAivz5EBDw==
X-Google-Smtp-Source: AGHT+IHN9MblxCG1iz6XVDxWtnzZxaJTFZNrwAcr66tyCOQrUWM9ptio1fTCz4B+AK362Df7J5ZrrA==
X-Received: by 2002:adf:f38d:0:b0:343:bccb:af46 with SMTP id m13-20020adff38d000000b00343bccbaf46mr241032wro.60.1712858829685;
        Thu, 11 Apr 2024 11:07:09 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b003437799a373sm2292400wrb.83.2024.04.11.11.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:08 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 1/5] openrisc: traps: Convert printks to pr_<level> macros
Date: Thu, 11 Apr 2024 19:06:28 +0100
Message-ID: <20240411180644.2023991-2-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180644.2023991-1-shorne@gmail.com>
References: <20240411180644.2023991-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pr_* macros are the convention and my upcoming patches add even more
printk's.  Use this opportunity to convert the printks in this file to
the pr_* macros to avoid patch check warnings.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 88 ++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9370888c9a7e..6d0fee912747 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -51,16 +51,16 @@ static void print_trace(void *data, unsigned long addr, int reliable)
 {
 	const char *loglvl = data;
 
-	printk("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
-	       (void *) addr);
+	pr_info("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
+		(void *) addr);
 }
 
 static void print_data(unsigned long base_addr, unsigned long word, int i)
 {
 	if (i == 0)
-		printk("(%08lx:)\t%08lx", base_addr + (i * 4), word);
+		pr_info("(%08lx:)\t%08lx", base_addr + (i * 4), word);
 	else
-		printk(" %08lx:\t%08lx", base_addr + (i * 4), word);
+		pr_info(" %08lx:\t%08lx", base_addr + (i * 4), word);
 }
 
 /* displays a short stack trace */
@@ -69,7 +69,7 @@ void show_stack(struct task_struct *task, unsigned long *esp, const char *loglvl
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	printk("%sCall trace:\n", loglvl);
+	pr_info("%sCall trace:\n", loglvl);
 	unwind_stack((void *)loglvl, esp, print_trace);
 }
 
@@ -83,57 +83,57 @@ void show_registers(struct pt_regs *regs)
 	if (user_mode(regs))
 		in_kernel = 0;
 
-	printk("CPU #: %d\n"
-	       "   PC: %08lx    SR: %08lx    SP: %08lx FPCSR: %08lx\n",
-	       smp_processor_id(), regs->pc, regs->sr, regs->sp,
-	       regs->fpcsr);
-	printk("GPR00: %08lx GPR01: %08lx GPR02: %08lx GPR03: %08lx\n",
-	       0L, regs->gpr[1], regs->gpr[2], regs->gpr[3]);
-	printk("GPR04: %08lx GPR05: %08lx GPR06: %08lx GPR07: %08lx\n",
-	       regs->gpr[4], regs->gpr[5], regs->gpr[6], regs->gpr[7]);
-	printk("GPR08: %08lx GPR09: %08lx GPR10: %08lx GPR11: %08lx\n",
-	       regs->gpr[8], regs->gpr[9], regs->gpr[10], regs->gpr[11]);
-	printk("GPR12: %08lx GPR13: %08lx GPR14: %08lx GPR15: %08lx\n",
-	       regs->gpr[12], regs->gpr[13], regs->gpr[14], regs->gpr[15]);
-	printk("GPR16: %08lx GPR17: %08lx GPR18: %08lx GPR19: %08lx\n",
-	       regs->gpr[16], regs->gpr[17], regs->gpr[18], regs->gpr[19]);
-	printk("GPR20: %08lx GPR21: %08lx GPR22: %08lx GPR23: %08lx\n",
-	       regs->gpr[20], regs->gpr[21], regs->gpr[22], regs->gpr[23]);
-	printk("GPR24: %08lx GPR25: %08lx GPR26: %08lx GPR27: %08lx\n",
-	       regs->gpr[24], regs->gpr[25], regs->gpr[26], regs->gpr[27]);
-	printk("GPR28: %08lx GPR29: %08lx GPR30: %08lx GPR31: %08lx\n",
-	       regs->gpr[28], regs->gpr[29], regs->gpr[30], regs->gpr[31]);
-	printk("  RES: %08lx oGPR11: %08lx\n",
-	       regs->gpr[11], regs->orig_gpr11);
-
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-	       current->comm, current->pid, (unsigned long)current);
+	pr_info("CPU #: %d\n"
+		"   PC: %08lx    SR: %08lx    SP: %08lx FPCSR: %08lx\n",
+		smp_processor_id(), regs->pc, regs->sr, regs->sp,
+		regs->fpcsr);
+	pr_info("GPR00: %08lx GPR01: %08lx GPR02: %08lx GPR03: %08lx\n",
+		0L, regs->gpr[1], regs->gpr[2], regs->gpr[3]);
+	pr_info("GPR04: %08lx GPR05: %08lx GPR06: %08lx GPR07: %08lx\n",
+		regs->gpr[4], regs->gpr[5], regs->gpr[6], regs->gpr[7]);
+	pr_info("GPR08: %08lx GPR09: %08lx GPR10: %08lx GPR11: %08lx\n",
+		regs->gpr[8], regs->gpr[9], regs->gpr[10], regs->gpr[11]);
+	pr_info("GPR12: %08lx GPR13: %08lx GPR14: %08lx GPR15: %08lx\n",
+		regs->gpr[12], regs->gpr[13], regs->gpr[14], regs->gpr[15]);
+	pr_info("GPR16: %08lx GPR17: %08lx GPR18: %08lx GPR19: %08lx\n",
+		regs->gpr[16], regs->gpr[17], regs->gpr[18], regs->gpr[19]);
+	pr_info("GPR20: %08lx GPR21: %08lx GPR22: %08lx GPR23: %08lx\n",
+		regs->gpr[20], regs->gpr[21], regs->gpr[22], regs->gpr[23]);
+	pr_info("GPR24: %08lx GPR25: %08lx GPR26: %08lx GPR27: %08lx\n",
+		regs->gpr[24], regs->gpr[25], regs->gpr[26], regs->gpr[27]);
+	pr_info("GPR28: %08lx GPR29: %08lx GPR30: %08lx GPR31: %08lx\n",
+		regs->gpr[28], regs->gpr[29], regs->gpr[30], regs->gpr[31]);
+	pr_info("  RES: %08lx oGPR11: %08lx\n",
+		regs->gpr[11], regs->orig_gpr11);
+
+	pr_info("Process %s (pid: %d, stackpage=%08lx)\n",
+		current->comm, current->pid, (unsigned long)current);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
 	 */
 	if (in_kernel) {
 
-		printk("\nStack: ");
+		pr_info("\nStack: ");
 		show_stack(NULL, (unsigned long *)esp, KERN_EMERG);
 
 		if (esp < PAGE_OFFSET)
 			goto bad_stack;
 
-		printk("\n");
+		pr_info("\n");
 		for (i = -8; i < 24; i += 1) {
 			unsigned long word;
 
 			if (__get_user(word, &((unsigned long *)esp)[i])) {
 bad_stack:
-				printk(" Bad Stack value.");
+				pr_info(" Bad Stack value.");
 				break;
 			}
 
 			print_data(esp, word, i);
 		}
 
-		printk("\nCode: ");
+		pr_info("\nCode: ");
 		if (regs->pc < PAGE_OFFSET)
 			goto bad;
 
@@ -142,14 +142,14 @@ void show_registers(struct pt_regs *regs)
 
 			if (__get_user(word, &((unsigned long *)regs->pc)[i])) {
 bad:
-				printk(" Bad PC value.");
+				pr_info(" Bad PC value.");
 				break;
 			}
 
 			print_data(regs->pc, word, i);
 		}
 	}
-	printk("\n");
+	pr_info("\n");
 }
 
 /* This is normally the 'Oops' routine */
@@ -157,10 +157,10 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
 
 	console_verbose();
-	printk("\n%s#: %04lx\n", str, err & 0xffff);
+	pr_emerg("\n%s#: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
 #ifdef CONFIG_JUMP_UPON_UNHANDLED_EXCEPTION
-	printk("\n\nUNHANDLED_EXCEPTION: entering infinite loop\n");
+	pr_emerg("\n\nUNHANDLED_EXCEPTION: entering infinite loop\n");
 
 	/* shut down interrupts */
 	local_irq_disable();
@@ -173,8 +173,8 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 
 asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
-	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
-	       ea, vector);
+	pr_emerg("Unable to handle exception at EA =0x%x, vector 0x%x",
+		 ea, vector);
 	die("Oops", regs, 9);
 }
 
@@ -211,7 +211,7 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 		/* Send a SIGBUS */
 		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address);
 	} else {
-		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
+		pr_emerg("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
 		die("Die:", regs, address);
 	}
@@ -224,7 +224,7 @@ asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 		/* Send a SIGBUS */
 		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 	} else {		/* Kernel mode */
-		printk("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
+		pr_emerg("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
 		show_registers(regs);
 		die("Die:", regs, address);
 	}
@@ -419,8 +419,8 @@ asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 		/* Send a SIGILL */
 		force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)address);
 	} else {		/* Kernel mode */
-		printk("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
-		       address);
+		pr_emerg("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
+			 address);
 		show_registers(regs);
 		die("Die:", regs, address);
 	}
-- 
2.44.0


