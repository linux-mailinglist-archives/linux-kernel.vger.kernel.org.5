Return-Path: <linux-kernel+bounces-135216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6389BCDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511E8B22DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72335338F;
	Mon,  8 Apr 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9Nv+sTO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWbytI7n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4A52F83;
	Mon,  8 Apr 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571484; cv=none; b=XWxUGJUE8x2ekoY46Bb6ElgKIsOrxH9kudJU0LFVCYMICSRsi5+fFMaObc1riWOgE7r9p9x25IW80kfYhFQafwFMFR7jAj4feGanu9/mCRoGrgDAn//+2+2ijnR3rva196wsftFdTvu2e68WqAuqPw5D4knPpc5/DEKUiFymFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571484; c=relaxed/simple;
	bh=ndnxWBaDMIoX9SuwF9xmE9J0d9iLYQgbIKQaVs/ewVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M1L7mTYKDLnBG744Rnsv095+p2jGhV3NEd5RPswODE1ghflWG2xzmnMAciZDQplKeL9hffwW58rV1u3AiVHkIi2UVkx3TjR0MXWkMLH9WzFGrprjOLaGYBfHHJWA5i4A+4qqznsaj/kwE32puaL8N3yz6V3KmXBdgJ6KkUKjKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9Nv+sTO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWbytI7n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 10:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712571481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY5Yn0pEVsFL1jcTs8xAw+j/ArLb8o13dUUPeJ/7V+A=;
	b=K9Nv+sTOiDNRcDQgtkOjepl0ofJGfpH8gdU4HXxgEJ1EHPVpmu4gQV+KS4KrMrwpBetpSZ
	oEQHM8IfEgyCS2iesBenKpCuYlgiYiRK45CKYdkZ/+KZ5EHCB54lC4PRX/jil5A0QLp19P
	lemcMu3L/tPfXbA0so7KCpUfBKz7morV/GZqCjYG7oWmJEdk7pobEH6IAGg0PGt3j0SitU
	uD434tdjRAh06iu9ugVSNfDWSw/vRsMwewJ+uHlrQF1t3Pd290F9VdDcWYjy6cH6hHI5I9
	yqVLJzeD8ZBFqqTVp9BKG47btTjfToe9FbzEWmJRrGjvoS6X74rveNdb5TQjjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712571481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY5Yn0pEVsFL1jcTs8xAw+j/ArLb8o13dUUPeJ/7V+A=;
	b=IWbytI7nCCwmK4afyeY+qbH10yuUD635NOqJ4hDQemh7SgQnX/B+CrGj6T0ADc1i8yVuCD
	LXnnThtyxy1stSCQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Check virq for 0 before use in
 irq_dispose_mapping()
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240405190105.3932034-1-andriy.shevchenko@linux.intel.com>
References: <20240405190105.3932034-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171257148005.10875.12889492362507316257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a2ea3cd78317ae8995b65b52299158bbae52a77f
Gitweb:        https://git.kernel.org/tip/a2ea3cd78317ae8995b65b52299158bbae52a77f
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 05 Apr 2024 22:01:05 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 12:08:58 +02:00

irqdomain: Check virq for 0 before use in irq_dispose_mapping()

It's a bit hard to read the logic since the virq is used before checking it
for 0. Rearrange the code to make it better to understand.

This, in particular, should clearly answer the question whether the caller
needs to perform this check or not, and there are plenty of places for both
variants, confirming a confusion.

Fun fact that the new code is shorter:

  Function                                     old     new   delta
  irq_dispose_mapping                          278     271      -7
  Total: Before=11625, After=11618, chg -0.06%

when compiled by GCC on Debian for x86_64.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240405190105.3932034-1-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdomain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c87..aadc889 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -909,10 +909,11 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data = irq_get_irq_data(virq);
+	struct irq_data *irq_data;
 	struct irq_domain *domain;
 
-	if (!virq || !irq_data)
+	irq_data = virq ? irq_get_irq_data(virq) : NULL;
+	if (!irq_data)
 		return;
 
 	domain = irq_data->domain;

