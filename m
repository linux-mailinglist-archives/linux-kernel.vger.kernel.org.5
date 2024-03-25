Return-Path: <linux-kernel+bounces-118145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8D88B491
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B95B302DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81380612;
	Mon, 25 Mar 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvXgsTBc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qu12Pwuo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F327640A;
	Mon, 25 Mar 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407326; cv=none; b=TWgTuphqbtDTUA2+3qn7aCmbICLzYXZvHdwxjK6C3wI8kqbBtaSsIK/hZ0uM3LptZGE9/d32u6NOFjaJxmjRw1MOX+kJB8hgKRf/IwF4yTA7rXauVI6mr3ZZm/3d//m0ZAb3vqsQmYPiyjKSC9zeH0LVRwQWmTfCd2fgSPueXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407326; c=relaxed/simple;
	bh=3r1y31v3XTJVbXsuNyo5JrJSvUfosXKWdLpQPsBInmU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ufAVHcSlUrlDKv52FibX3JPs+cLbcsdmxYVP5TTt6e0LwWbU+3ySGsYeLagNccbZn98D0i7ZO9USOm3vUrhtCPsxiXGgAgDHsWRfd4G1eNAWLFUvNHbFrL/1By653SMVpc/I+2eHbZLuFAa9ZtN8WpxiPswBvnfcNW1761M5RaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvXgsTBc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qu12Pwuo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 22:55:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711407322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VduUBxZAYZw86rW/+SYoj/g0yoJ8Q2ZF+JCtK4WaCKE=;
	b=YvXgsTBcPYeDxtIB0/qQOHBYRo3nYyk1JcCuQttXEm3AqsHP01Zjw2RAtN8pWAN4wm7Enn
	sIxWxS7PebED335ecJvwOyA7cVlDiQfJs9PKO9W9jSFovQCwKwlgDqKqAakg4e4cTA4zZ8
	HppDCsnI8oSD48XYm8i9fFq8XAmri/O58H8h3vrKlgfGW9DdTBNKq1I31bfO+dyh08iquB
	2S3f+0Jd0lxxNyD15ySSwruLSk4g4Gnr8QYaByeR0Z6LJq89pNv67HIRxsWp0n63OJIxOS
	i1DW5+KD+bQiiXDQM1Rwcgv/iYm8ZjvixAb2WzskDLZ4IUgQ15z3MceM1oDMBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711407322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VduUBxZAYZw86rW/+SYoj/g0yoJ8Q2ZF+JCtK4WaCKE=;
	b=Qu12Pwuoitv961SrVQ/9du4ndKDOCIcATQq/V/cvmAXvHlCilOqZv+2Qf6TBrWai3pw1HX
	KE1oqAecZgfI2hCg==
From: "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Introduce IRQF_COND_ONESHOT and use it in
 pinctrl-amd
Cc: Francisco Ayala Le Brun <francisco@videowindow.eu>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, "6.8+" <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <12417336.O9o76ZdvQC@kreacher>
References: <12417336.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171140732104.10875.14515495184452517144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c2ddeb29612f7ca84ed10c6d4f3ac99705135447
Gitweb:        https://git.kernel.org/tip/c2ddeb29612f7ca84ed10c6d4f3ac99705135447
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Mon, 25 Mar 2024 13:58:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 23:45:21 +01:00

genirq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd

There is a problem when a driver requests a shared interrupt line to run a
threaded handler on it without IRQF_ONESHOT set if that flag has been set
already for the IRQ in question by somebody else.  Namely, the request
fails which usually leads to a probe failure even though the driver might
have worked just fine with IRQF_ONESHOT, but it does not want to use it by
default.  Currently, the only way to handle this is to try to request the
IRQ without IRQF_ONESHOT, but with IRQF_PROBE_SHARED set and if this fails,
try again with IRQF_ONESHOT set.  However, this is a bit cumbersome and not
very clean.

When commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for
SCI") switched the ACPI subsystem over to using a threaded interrupt
handler for the SCI, it had to use IRQF_ONESHOT for it because that's
required due to the way the SCI handler works (it needs to walk all of the
enabled GPEs before the interrupt line can be unmasked). The SCI interrupt
line is not shared with other users very often due to the SCI handling
overhead, but on sone systems it is shared and when the other user of it
attempts to install a threaded handler, a flags mismatch related to
IRQF_ONESHOT may occur.

As it turned out, that happened to the pinctrl-amd driver and so commit
4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt request")
attempted to address the issue by adding IRQF_ONESHOT to the interrupt
flags in that driver, but this is now causing an IRQF_ONESHOT-related
mismatch to occur on another system which cannot boot as a result of it.

Clearly, pinctrl-amd can work with IRQF_ONESHOT if need be, but it should
not set that flag by default, so it needs a way to indicate that to the
interrupt subsystem.

To that end, introdcuce a new interrupt flag, IRQF_COND_ONESHOT, which will
only have effect when the IRQ line is shared and IRQF_ONESHOT has been set
for it already, in which case it will be promoted to the latter.

This is sufficient for drivers sharing the interrupt line with the SCI as
it is requested by the ACPI subsystem before any drivers are probed, so
they will always see IRQF_ONESHOT set for the interrupt in question.

Fixes: 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt request")
Reported-by: Francisco Ayala Le Brun <francisco@videowindow.eu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Closes: https://lore.kernel.org/lkml/CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com/
Link: https://lore.kernel.org/r/12417336.O9o76ZdvQC@kreacher

---
 drivers/pinctrl/pinctrl-amd.c |  2 +-
 include/linux/interrupt.h     |  3 +++
 kernel/irq/manage.c           |  9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 49f89b7..7f66ec7 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1159,7 +1159,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
-			       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME, gpio_dev);
+			       IRQF_SHARED | IRQF_COND_ONESHOT, KBUILD_MODNAME, gpio_dev);
 	if (ret)
 		goto out2;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 76121c2..5c9bdd3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -67,6 +67,8 @@
  *                later.
  * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
  *		   depends on IRQF_PERCPU.
+ * IRQF_COND_ONESHOT - Agree to do IRQF_ONESHOT if already set for a shared
+ *                 interrupt.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -82,6 +84,7 @@
 #define IRQF_COND_SUSPEND	0x00040000
 #define IRQF_NO_AUTOEN		0x00080000
 #define IRQF_NO_DEBUG		0x00100000
+#define IRQF_COND_ONESHOT	0x00200000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad3eaf2..bf9ae8a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1643,8 +1643,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
-		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
-		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
+		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)))
+			goto mismatch;
+
+		if ((old->flags & IRQF_ONESHOT) &&
+		    (new->flags & IRQF_COND_ONESHOT))
+			new->flags |= IRQF_ONESHOT;
+		else if ((old->flags ^ new->flags) & IRQF_ONESHOT)
 			goto mismatch;
 
 		/* All handlers must agree on per-cpuness */

