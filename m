Return-Path: <linux-kernel+bounces-45907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5668437BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ADB2888A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F02768FD;
	Wed, 31 Jan 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcaPgPow";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySMLLQFQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AF6DD19;
	Wed, 31 Jan 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685684; cv=none; b=iHKPtTUcXpDADRtIUtoRdYqMYDfV0820nCubCZJ37w0dZWMDkkdOXoynyysgaf3bKgJVYJQdyVe892nuEUgDvWioTPbdhz3z+85HZl5z8ooafScVzlHyudlnciN0Ofxrsr/ooKyFKlDjmcfWyX91kNg2E4UGyQYuq4sYqtDHyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685684; c=relaxed/simple;
	bh=lRX/Cwn5841ZQVMSLI88ekqtL5uilM05LQsWrvM1mms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dZ5a+WVQm0Tqj82msNJn/RR+bB9kU3tvD7zjthfrABaCa/jg7J+Jw54iHiEmF2KXUQ2eA2aP3cw9hkMX7OVghNzv+GbvJKrpFN4Ei5iTHgzFXEVG6Ik8+COYvXzyEtuxbphaDTrTyN/NFBuYreTVw27MEuvrgy+Jg9xDHGe8fXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcaPgPow; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySMLLQFQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdDbI+3UdclGrdmKctpKWHGBsVC6dyLT2iD8l1QugE0=;
	b=CcaPgPowpVr4Comr6fK3GnGsPaz6IJRx3THZ1KJJrNi6pj/tvoR5hW3+fbyaevaxuSPWgP
	szPeseSBvNIWmtwFz/C5WCoy4E9KTqHRdHyaZlu5FErUJ0N6RpvvyYBP+qdXx5DyCww0k3
	Ht74JrGDanZlMw12hFPXbFLKjEGXKJTLbDwGDZc1oHGoA/qU6MP8NKBK74n4nZDSvhke65
	yLwMsHUlWwoAfi/tMiZmb9U3Zc9dhWA/8AzXZKhUlASWFUKBi3n7Fh+qEc3mr8Mf/087uk
	Pi5h/VDv7O8IR5q0ddImCrD8h3vPgF17Q3+M1/ezTltCdNh6GcjLNhNK6sVjog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdDbI+3UdclGrdmKctpKWHGBsVC6dyLT2iD8l1QugE0=;
	b=ySMLLQFQ9lsOXe5oHWkGJ0Kdc0IDYzmRzJd1SfXtABhxxTlGUu+GiqESe1RvfXWP+Up6N0
	oziiTkYcVaieVTAA==
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
Message-ID: <170668568002.398.1889543253223143145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     d0fb796dc3475cf71d788ec960d8ed5de4d7a429
Gitweb:        https://git.kernel.org/tip/d0fb796dc3475cf71d788ec960d8ed5de4d7a429
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:08 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

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

