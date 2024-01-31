Return-Path: <linux-kernel+bounces-47135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64408449BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F61C234EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FC3EA9F;
	Wed, 31 Jan 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3i05n280";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="taGCOCHf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022D3B7AA;
	Wed, 31 Jan 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735694; cv=none; b=CsN6ahrAfbNpoBUZPp67nSWWmQ9wcLP1LXQjHXqD/McvY1Xe+NJrIGS2W1g7B9J15Ivk/n1GqDoX0fXVy5DHHZIgTNQUwjXFL6s4WdNyPpFDT/5PITfv8q5OuNe4LedIUYyhuUjauGJs4vDsF4Sq31HHs8UzRXQd2faha1Bd+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735694; c=relaxed/simple;
	bh=mp5/Po2OJqKKNU7rbTXt7PjpsYFWjHEZVutEJvMj3FQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GzVuTr+Uqx65OYgpZCFP9YIPzJAPSPx6EacFG/TjO187ZRsoO+WTO/k0jBrMW33RUbQa70xIuSaCCPsCpscXLxLR/PtCndTFo6Kk76jQsR2HeaJlLd3+dAXdNY4/Y0eqS9QV8D6iYlfjwx4bd9UbEQcyOLkHekFzCY7TF2o1rBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3i05n280; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=taGCOCHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI5t9cV2zR2IzTyqxMRzbJzEdlHiXthplThlVmPY634=;
	b=3i05n280sYbS8V0dUhrFrUYGs3abpruRDHD9vdCejEFrN4kqsm1Py/rWWlxId8gHteHwGB
	cYgsqrwjjQvTkCH0NMKbXqNIGQcZztTArtl4PZJ8mNwsu+p2geEVw5q+/YI8mL92SCluDS
	U/4mlYdlQ2qmS6IRIPcrx/4mzBeiCUkHuKP+TlD4apWdVPVTllT5A3BdefXV+yN3WSTybo
	HZpUMQay312ia7XxyjlTaj0EaG7dB51CvRwhx4PgkMcX9iNKHpn9440jGptiLLaBq17eap
	PcTbym9P20H2mY9kL5CZGB87EO88r1ux3ryr92xkn+K/56+rVW8wc5cWPBfKZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI5t9cV2zR2IzTyqxMRzbJzEdlHiXthplThlVmPY634=;
	b=taGCOCHf0H49dIDXhIzG1U1cOtq3isRtYNtL+nHyA82CeZ5ELPpfkjRrdenB3qaUPrmtS3
	GNtaJDHTbwHhjGCw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Update MSR_IA32_FRED_RSP0 during task switch
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-18-xin3.li@intel.com>
References: <20231205105030.8698-18-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568991.398.4813365016446129460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     9356c4b8886c4f7d3436c3f7fe31715bdcf1c79e
Gitweb:        https://git.kernel.org/tip/9356c4b8886c4f7d3436c3f7fe31715bdcf1c79e
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:06 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:01:36 +01:00

x86/fred: Update MSR_IA32_FRED_RSP0 during task switch

MSR_IA32_FRED_RSP0 is used during ring 3 event delivery, and needs to
be updated to point to the top of next task stack during task switch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
 

