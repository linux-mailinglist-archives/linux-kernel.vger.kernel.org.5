Return-Path: <linux-kernel+bounces-45909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCC8437BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3555728A64D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0D7AE5A;
	Wed, 31 Jan 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zxg9FYBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8v7Xtlo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3D74E2B;
	Wed, 31 Jan 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685686; cv=none; b=nXFS3PsKQTT0Ml7SdY66CtVtPGMjowEUNSwepbTcsZgUJ4NGw/q/bdxvu30P3Nv/GrX/dtE3XsSYJ/XmQincMiFGoqSVc0E48WTSULE4s9KSRHoZpWPehp21iizwyVmLW4AnO9MxPeW9IIvuOA2EjFVAFY87VgJnyMkOh+cVn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685686; c=relaxed/simple;
	bh=SQSvVsiG1DgRggxdwtLKi4x6V4RPZIaBhYDO/Abj2Q4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XLdvdkxp466ZGhs+tw6wyQo8EK1Ku3qUeTZAGb9Rya6c0LJ5q9k875G948N/Sie2iCJQZQ9/pyVkPkz/zi7tfuTjCNi0dPkxeZiiaKOHnuzUSy6BPUnOzPoRBSlEzhlhVWjsOUNCWQLLq54M04FVKukDj8lSNil8Jlq8GMrPb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zxg9FYBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8v7Xtlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyfbE1G1aG1noX/XnDR3g+FrbN3MKuudiv5ASwe74rQ=;
	b=Zxg9FYBfRsEfGC49iG9NvMygMctnZmRacJKVRYgFkD0JaDK5PsdD2U85Uqbg5vzYJOe4/J
	OdquAZEkJmNVbrm6hcy+/3ZFiSQlZcz/VvhUjKYIvsEoHxNCKRyQ00zrJFkDJfMiWjRMVB
	CSoWxyaQAbqYMX9fRhHQ7P++WdHk6/orVeZoPyyqJsnuf6WyE4Wg138YeNjtpZftljWL4B
	JZV3+B5vthFBshHnPMgwqWjKPZZaBaoUpTZ9HZF0vGWxwLykACrNt7lJtRbJo/efC94y+e
	yiVpoF4H7QuEvgNMEn3OkLYAosuSmQ6hCuYcrFdaf+PcqMRfJSjwCJKt0ZQwdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyfbE1G1aG1noX/XnDR3g+FrbN3MKuudiv5ASwe74rQ=;
	b=r8v7Xtlowp5Bo6sdOFiKfN7odNMaYhwuwXAcNfO0WbZtq5IG0WOGwFf3maOODNxu49Hn2p
	Y4bIvoTftB+9sQBw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Update MSR_IA32_FRED_RSP0 during task switch
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-18-xin3.li@intel.com>
References: <20231205105030.8698-18-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668568173.398.2179661093584754061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     f393835cbab6184f3ee6ed90499a88e9930a8512
Gitweb:        https://git.kernel.org/tip/f393835cbab6184f3ee6ed90499a88e9930a8512
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:06 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: Update MSR_IA32_FRED_RSP0 during task switch

MSR_IA32_FRED_RSP0 is used during ring 3 event delivery, and needs to
be updated to point to the top of next task stack during task switch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-18-xin3.li@intel.com

---
 arch/x86/include/asm/switch_to.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index f42dbf1..c3bd0c0 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,9 +70,13 @@ static inline void update_task_stack(struct task_struct *task)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/* Xen PV enters the kernel on the thread stack. */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		/* WRMSRNS is a baseline feature for FRED. */
+		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
+	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
+	}
 #endif
 }
 

