Return-Path: <linux-kernel+bounces-67630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67CB856E31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845F6286562
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2184145FE6;
	Thu, 15 Feb 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReHzMhP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nEKKwsK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807291420DD;
	Thu, 15 Feb 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027028; cv=none; b=a6CMy0+pCP4eVqytfTVkqpXAsO+0XTfyU3fudzGOi6MZ1v8V6yoQaBMqIFOSVBAZwxaU3fHet5Zgj53bu2K+Z699nU4AaJb0esmQ5ENw1f/FAQnUdEBGLXp8835cS9a/wQ2xaeppfEprRfnf8E5/UGmhV7GANyKj4Q5MI0AV718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027028; c=relaxed/simple;
	bh=B4B96r7h5333DHn3WdmqRjZ9Z+HqOlOwknn13elhplo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UbzPvAZIv4xSRNmRTwIPYiaqsDgMhYwYZrm2/tqIHf8sG6kFs+4j0wd2XSa+/O1eirf7pIG4PxI2zGgr6Syyy++cshZAqCzSxefR+BwwZefsAQxBnlztDS8Ekfcfylq6M0Bg1R4juR8T3mSx5fMvnhAzr4Q6VXTddkDMNtOaMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ReHzMhP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nEKKwsK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkttvpZ84OjjLQbqBM7oObYBQvlaxWVX5tMAj1EyouA=;
	b=ReHzMhP4JhZU1n1/5PUZirKwvVnZhFUCWyi6uMk8F+UR8sRVUlZSn9fD1/paK9VWUxLPmm
	1njIotlhx9uS3eje26M8ZP0J44KPRQ1n+br+/6oWIColBS58GIorN4+n8yoBH3oBMPs23/
	wrp+qb5UmeUPiGqTlT9HcqWX9JKSEUx27yoL7Rw0rcUJawlIQ0yVrgey8ey1qdYYK9LbE6
	oryG5B+58lS72+i6ksBrZGUyVMLqJqfzXX2z4FKv/hb1K04kZjUmZGNMzptCgqdhN4LJEz
	rzDOXjyxcRONRLAQTteV6cGpdYoTOshHWzm201ggZl4WnF2MTVfwxOT1MV1saw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkttvpZ84OjjLQbqBM7oObYBQvlaxWVX5tMAj1EyouA=;
	b=7nEKKwsK23DCUm9fZtGhH3x8NAfl1Ymf30yydrXLOH9sLU4XuFTHojY3W1RY2qbt/tM+LE
	SdeQdgP8ayugnbBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/irqdomain: Remove the param count restriction
 from select()
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-3-apatel@ventanamicro.com>
References: <20240127161753.114685-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     de1ff306dcf4546d6a8863b1f956335e0d3fbb9b
Gitweb:        https://git.kernel.org/tip/de1ff306dcf4546d6a8863b1f956335e0d3fbb9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:30 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:39 +01:00

genirq/irqdomain: Remove the param count restriction from select()

Now that the GIC-v3 callback can handle invocation with a fwspec parameter
count of 0 lift the restriction in the core code and invoke select()
unconditionally when the domain provides it.

Preparatory change for per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-3-apatel@ventanamicro.com

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4f..8fee379 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select && fwspec->param_count)
+		if (h->ops->select)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);

