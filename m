Return-Path: <linux-kernel+bounces-39100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C241483CAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C1F1F2722E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41813BE97;
	Thu, 25 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7r9KnwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RD4yCmPj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A19137C5E;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206896; cv=none; b=CEm24/SQdLW55RzbbLJmFZQZ4HdNYMmKJKXL51GGyNraF4aIOJfzVyJOgYjaZDEiEJ6Vga4wXVEXpcAQN/tryvNVRJTVffn67l6jLYvKRe3boBfvAtpwtdFc4YThMOZBVjTVG2J0Nvf/oXD1j0Hx9ePCsoQ3uQam3zIsgYy2l5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206896; c=relaxed/simple;
	bh=wlzmYwUxJ215NNYBIX4aN9yqimcI9GZYJd5gP2TYed0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=itjSWQURU/7Hi1CdT99PSCYMlUtb4KqPXb/ENkAgKnAwad4AheL3oCVqgBMND5sybZ6hezcXoP1rZudvaObwsXCDYKXI8NWRVxs5X3ZFPqVljACvos+sdABi3UUNNHNN9N8Rl1FUxGAgbWUYGbV+9zYS9JgjM5exPdqqM+4iXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7r9KnwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RD4yCmPj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vu/47x9Ti9yhmQ+i8gJyEiZuv3PLrCTSFIaEamDaSRs=;
	b=B7r9KnwWa3LSCIp3bkum4fleThlUoKUSa9s9c9j3ClUGq2erAI4eQv3aVQbYO7eRCFqqzF
	LxA00hzoWPWspzrSOSKWliJmDf2+OY5hCSZufj2yvAVVaANNs16Im6TVQ0rZcnY+0MKDP1
	lpsQ2VDtfztEDcaaMrYp6npbPovzIu9c0cDDIYb8sYkxgpfV70i+3I/3AAMQpTkoH/8QuS
	uzpjVCsc+ejZNjNyuVMzai3A53GgJOj+sCQcoNSb4cCv483iCvvPA0M6IGtXxuInUTlZ/u
	zEFlQgz8Ueh83N0njdKVebSL9QhazPYj397fLEuyrvqsMjL+2VSZHnYSLKw0kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vu/47x9Ti9yhmQ+i8gJyEiZuv3PLrCTSFIaEamDaSRs=;
	b=RD4yCmPjFfwIO9XRSGmvXXT+ETHavD4FDyC6FJbE8K6+sBG0a88wejA32wE7D2uPxtIJME
	fq1N9Ru8mD75EMBg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: No ESPFIX needed when FRED is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-20-xin3.li@intel.com>
References: <20231205105030.8698-20-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688711.398.1337533491872943903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     bc49cef5e02ab95b5235acbbc4cb5bb6a0bdec7f
Gitweb:        https://git.kernel.org/tip/bc49cef5e02ab95b5235acbbc4cb5bb6a0bdec7f
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:08 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: No ESPFIX needed when FRED is enabled

Because FRED always restores the full value of %rsp, ESPFIX is
no longer needed when it's enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-20-xin3.li@intel.com

---
 arch/x86/kernel/espfix_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 16f9814..6726e04 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -106,6 +106,10 @@ void __init init_espfix_bsp(void)
 	pgd_t *pgd;
 	p4d_t *p4d;
 
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* Install the espfix pud into the kernel page directory */
 	pgd = &init_top_pgt[pgd_index(ESPFIX_BASE_ADDR)];
 	p4d = p4d_alloc(&init_mm, pgd, ESPFIX_BASE_ADDR);
@@ -129,6 +133,10 @@ void init_espfix_ap(int cpu)
 	void *stack_page;
 	pteval_t ptemask;
 
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* We only have to do this once... */
 	if (likely(per_cpu(espfix_stack, cpu)))
 		return;		/* Already initialized */

