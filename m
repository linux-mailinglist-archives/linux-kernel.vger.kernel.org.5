Return-Path: <linux-kernel+bounces-141449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D428A1E67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D61F274DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6141134428;
	Thu, 11 Apr 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQE+35O7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1A12C48C;
	Thu, 11 Apr 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858841; cv=none; b=QtAKMAmRafs4HVV5b9AiQgk5c3iFxOld0oOLutgSdE/26nTizrBnjhckB8b2N5G/J6Zavum/srIqllHXlFyh6lgmYqpxD5ZNjRDRwapuA5LNJONUryQPdkbhRVGPLJCY3SjJ2vy9nfyrp0hMyjrXKEBxzVTAgunNHa0dQ314J30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858841; c=relaxed/simple;
	bh=O8N32L3K9jno7wsSKfEzWJdKL/AjXQF2lU+bJsxXMRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMwrDNFDVt1C06yLeZN5K1+YD64sxgGqfesN5YQFGuwyHmtxwFRNllkZtzJJydTxuNPTbJMvsDbnxkEqOMvSWAOPrriWknX82O2oQFP4xIHpXlwu+sKwy/Dz/jsmjcFmAfSeZRQzQq12hZYoqM6Q3juBWvCKbAUJgxbC0BX5Qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQE+35O7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343e7c20686so20317f8f.1;
        Thu, 11 Apr 2024 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858837; x=1713463637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XppCVzrOLbUUEqTMMouW5ktdErve/q6SLfsMT7XkiNI=;
        b=UQE+35O7he7oTZRfwny/d2BJ3IPfKlpb/2CvZ+zlRIyIKaFvtiIaobQf25wpf8gMql
         iH+9pTIcB2j2a/dDcgRJr76m9HRrhrS5DB0vHjCbeJDXcXyJApHE75bpUNuYTHtN8S4e
         efGrmOqazgZKjtp+tZ8Uxy7yYxBxNd6vGk8CoPf+7tasYDDplGl6c3wtLTslm4BzDRPG
         c4MMo34nbPciqLb8ZBpt5VuybWkrY+F0NhHd1BRhePKWnX8054BroC3ujsMRbIU6q3cb
         en9aFtgK/8L/3nP0933nb8+eQxEUN+UnXjXNykLxW2MSRpb2gPMcisrYPD3V/YpjP0Qo
         0N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858837; x=1713463637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XppCVzrOLbUUEqTMMouW5ktdErve/q6SLfsMT7XkiNI=;
        b=dbrvvqvdPVIBuG1LHwYIxTC5LSZ+wzT//byGsWgSbX/bcRhjJ/tMWscsXLA7MFVrGn
         SYCcrHYHZsD8/x10KKKMdN3KTY+F34aLRQwYsJ+aY975uODA53kQ2tOBR/7UKSWYM5jx
         fsk+A8cZW27Pb38pbL/5ys+QMf2w73xQf57LXoveivoTFVysf1UmNsWxYR0svppuzm8h
         uXhdFlLNpZZlE7tRbxScmSx46cFFUBy0JR+kvenMVfkA8FFFZcfY7cNNyf3i3xYerrpl
         yhmWQa8svn75eTgnESsioWAgQYZw+RjY5pXbLzZVFdiuGR3edTMuSO++UqNuNMmy7HSQ
         YhKQ==
X-Gm-Message-State: AOJu0Yy1QsLRtZYl2scYYqUOrx1xN9zOf94yhQWoE4tLyaTg0Lws3bnS
	e6T5LTSqNKb37dmKg/T9aLpRTz/P5gKXScGago/KsgV2jNRJgjJK7K69hw==
X-Google-Smtp-Source: AGHT+IHrwjTUH/FN9k+rAjyFjRhcFivG4kqPco0kCQtIun3+F8BPmCDyBOs2iPA7ZsTTEUv0f+deUA==
X-Received: by 2002:a5d:510f:0:b0:346:cd1c:dc73 with SMTP id s15-20020a5d510f000000b00346cd1cdc73mr241909wrt.46.1712858836884;
        Thu, 11 Apr 2024 11:07:16 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b003455e5d2569sm2375949wrq.0.2024.04.11.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:16 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4/5] openrisc: Add FPU config
Date: Thu, 11 Apr 2024 19:06:31 +0100
Message-ID: <20240411180644.2023991-5-shorne@gmail.com>
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

Allow disabling FPU related code sequences to save space.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig         | 9 +++++++++
 arch/openrisc/kernel/ptrace.c | 6 ++++++
 arch/openrisc/kernel/traps.c  | 3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 3586cda55bde..69c0258700b2 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -188,6 +188,15 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config FPU
+	bool "FPU support"
+	default y
+	help
+	  Say N here if you want to disable all floating-point related procedures
+	  in the kernel and reduce binary size.
+
+	  If you don't know what to do here, say Y.
+
 source "kernel/Kconfig.hz"
 
 config OPENRISC_NO_SPR_SR_DSX
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 1eeac3b62e9d..cf410193095f 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -88,6 +88,7 @@ static int genregs_set(struct task_struct *target,
 	return ret;
 }
 
+#ifdef CONFIG_FPU
 /*
  * As OpenRISC shares GPRs and floating point registers we don't need to export
  * the floating point registers again.  So here we only export the fpcsr special
@@ -115,13 +116,16 @@ static int fpregs_set(struct task_struct *target,
 				 &regs->fpcsr, 0, 4);
 	return ret;
 }
+#endif
 
 /*
  * Define the register sets available on OpenRISC under Linux
  */
 enum or1k_regset {
 	REGSET_GENERAL,
+#ifdef CONFIG_FPU
 	REGSET_FPU,
+#endif
 };
 
 static const struct user_regset or1k_regsets[] = {
@@ -133,6 +137,7 @@ static const struct user_regset or1k_regsets[] = {
 			    .regset_get = genregs_get,
 			    .set = genregs_set,
 			    },
+#ifdef CONFIG_FPU
 	[REGSET_FPU] = {
 			    .core_note_type = NT_PRFPREG,
 			    .n = sizeof(struct __or1k_fpu_state) / sizeof(long),
@@ -141,6 +146,7 @@ static const struct user_regset or1k_regsets[] = {
 			    .regset_get = fpregs_get,
 			    .set = fpregs_set,
 			    },
+#endif
 };
 
 static const struct user_regset_view user_or1k_native_view = {
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 211ddaa0c5fa..57e0d674eb04 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -182,6 +182,7 @@ asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 {
 	if (user_mode(regs)) {
 		int code = FPE_FLTUNK;
+#ifdef CONFIG_FPU
 		unsigned long fpcsr = regs->fpcsr;
 
 		if (fpcsr & SPR_FPCSR_IVF)
@@ -197,7 +198,7 @@ asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 
 		/* Clear all flags */
 		regs->fpcsr &= ~SPR_FPCSR_ALLF;
-
+#endif
 		force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
 	} else {
 		pr_emerg("KERNEL: Illegal fpe exception 0x%.8lx\n", regs->pc);
-- 
2.44.0


