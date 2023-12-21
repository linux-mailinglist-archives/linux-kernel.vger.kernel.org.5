Return-Path: <linux-kernel+bounces-7814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3481AD90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D0F2855D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D25247;
	Thu, 21 Dec 2023 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMzEtLfD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDD4A19
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=k8hLjy7/0rfR5qXAt0qHIi9EgLbOXhbv/0lSI0ys1J4=; b=QMzEtLfDlc9tKFEz5RoH9gmnIy
	+eG5d7WM5y9VfoCi4L2AIHQsnnuICT9+FUK0CWAJjqVAptlEPjwPd8g0n8HDFSSTs/vexOQEmaoXu
	ab5My75boInnDu6JpOXB4L/zKK54UkP+mM9LJx3570G+4fzXgWEucqDSEu2/E2u0SnWqVYALAHcu0
	ARdnsnfwAApxyAoZC1BCEtgw+li8j4kAHA6RWpXvAMbVEyI4jSc0uK0qbDUiikn1roj9fRGTLhCHT
	n05s/X6zkSxEfvcZARvvW3VxpQ7+OVCmeaZBO2dT9dTvbLGjAoEKfv7Nsi/J6a65laEcJVKR4KYdd
	yenjODKw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9rB-001cA4-1e;
	Thu, 21 Dec 2023 03:36:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] x86/tsc: correct kernel-doc notation
Date: Wed, 20 Dec 2023 19:36:20 -0800
Message-ID: <20231221033620.32379-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add or modify function descriptions to remove kernel-doc warnings:

tsc.c:655: warning: missing initial short description on line:
 * native_calibrate_tsc
tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
tsc.c:1373: warning: Function parameter or member 'work' not described in 'tsc_refine_calibration_work'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 arch/x86/kernel/tsc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -652,7 +652,7 @@ success:
 }
 
 /**
- * native_calibrate_tsc
+ * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
@@ -1328,9 +1328,9 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  *
  * Return:
  * struct system_counterval_t - system counter value with the pointer to the
- *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
+ *	corresponding clocksource:
+ *	cycles:		System counter value
+ *	cs:		Clocksource corresponding to system counter value. Used
  *			by timekeeping code to verify comparability of two cycle
  *			values.
  */
@@ -1357,7 +1357,7 @@ static void tsc_refine_calibration_work(
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
  * tsc_refine_calibration_work - Further refine tsc freq calibration
- * @work - ignored.
+ * @work: ignored.
  *
  * This functions uses delayed work over a period of a
  * second to further refine the TSC freq value. Since this is

