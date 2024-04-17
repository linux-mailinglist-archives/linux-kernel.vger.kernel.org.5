Return-Path: <linux-kernel+bounces-148449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B38A82C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D6BB21977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9F13D282;
	Wed, 17 Apr 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nk6j0Q5B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmBP6X8b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392913CF87;
	Wed, 17 Apr 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355645; cv=none; b=Dnf6FFT5tEUweKelYhYysRVcOrWNoh8/pC3IOJw3iUR7DXi4S2gSnrITUkvCczU5beRs7tu0Nb4ZIFcJ6l8qqBjZ4MIHKfUHPPRlRf4DUU0jGBGgd9VopEcjM46HBgeQUKFozH9iPqsKYY+CgD5+M7H02xRQpTuXWyJu+iAkPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355645; c=relaxed/simple;
	bh=Mld444p9FhL8wMvlmYVWtS5/xKW9ha596WOP9W2tO7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZVnEUHRjjuQtmc2l4CgNB2Q0+T+FquoWLswgZARmQ7YfTTw66mxROEKQ7kiUg5MNspWMXoeV1ie5ONOozOdOA7y3XLT7BAzHT5m8z4vNzi9iff6+4SU/rVy7RmtefQS6gVuEEr9XcsRcrJUxLzP2xg01GC+Jc0PwwXPVmg8zOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nk6j0Q5B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmBP6X8b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 12:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wsRe5sh182mnCSY3/Up7nwKIXbPH8RlWxpeXyYrMLc=;
	b=Nk6j0Q5B9DPR3WIJsJx2mihYF1Ux+v0Dq3E8XRlXQp7cpj56LIcwzq+n6EQYmw6rgwl+i5
	n9fynegF9nZpYiaR5uV86aUpMxbBrUlXYRN9A66tc8o/28omxsjVVanLnV2iR3pmqJmu7X
	lEQSLUzS8NhxFu3XPZur4FBL/x/VZB/m6QMiVPHvaenYrmnqdqEyG6kIZw1OvBhLJOCRKR
	49pvAUfN32/sdk+HuZXylFguaZWruvQl7za80TZpB7CsUg1rSNKvQhHGEbEqz1FwD+amtx
	OB80XMtCYi31yYblT3zSN4325i2C7UQt4X4oEryh4uxCPKXbMwqwa2kIcwgMsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wsRe5sh182mnCSY3/Up7nwKIXbPH8RlWxpeXyYrMLc=;
	b=BmBP6X8b5yBK9himN7tQWEBkFKpuJ3TotSpujCgvKQX/Tm+bTEQKcLPDhxi5G+1p/B5Bol
	Q5FCQqsvCTmKyKAQ==
From: "tip-bot2 for Alexander Gordeev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] s390/irq,nmi: Include <asm/vtime.h> header directly
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3fb696637c0eb7e9d6ffd6cbf9e647d7c5986b3d=2E17127?=
 =?utf-8?q?60275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
References: =?utf-8?q?=3C3fb696637c0eb7e9d6ffd6cbf9e647d7c5986b3d=2E171276?=
 =?utf-8?q?0275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171335564052.10875.11708694357063387016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     036cbbafbd1eb2a7437912c2fe5fdefc9d52c309
Gitweb:        https://git.kernel.org/tip/036cbbafbd1eb2a7437912c2fe5fdefc9d52c309
Author:        Alexander Gordeev <agordeev@linux.ibm.com>
AuthorDate:    Wed, 10 Apr 2024 17:09:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Apr 2024 13:37:22 +02:00

s390/irq,nmi: Include <asm/vtime.h> header directly

update_timer_sys() and update_timer_mcck() are inlines used for
CPU time accounting from the interrupt and machine-check handlers.
These routines are specific to s390 architecture, but included
via <linux/vtime.h> header implicitly. Avoid the extra loop and
include <asm/vtime.h> header directly.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/3fb696637c0eb7e9d6ffd6cbf9e647d7c5986b3d.1712760275.git.agordeev@linux.ibm.com
---
 arch/s390/kernel/irq.c | 1 +
 arch/s390/kernel/nmi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 6f71b0c..259496f 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -29,6 +29,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stacktrace.h>
 #include <asm/softirq_stack.h>
+#include <asm/vtime.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index c77382a..230d010 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -31,6 +31,7 @@
 #include <asm/crw.h>
 #include <asm/asm-offsets.h>
 #include <asm/pai.h>
+#include <asm/vtime.h>
 
 struct mcck_struct {
 	unsigned int kill_task : 1;

