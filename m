Return-Path: <linux-kernel+bounces-117076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7788A6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5901F61A34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA9126F3D;
	Mon, 25 Mar 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TxWY7Fsg"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345782D9B;
	Mon, 25 Mar 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371499; cv=none; b=DKPPviGvjlM/AhIAO2VOTpn1q+0WgqEzlN3GoRh5geCWoZQFgWU6Gv/Aaa4OGXyUj1qIzZWdcoi5pXc44KrhB/JvBzmEoR1o9itJO4rRBhzJGqeQkpIwwPKju/q+bNXDQaOEUd6RkKesJl2TPoDMFYalz/jCWfGfPiiVJ7mreZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371499; c=relaxed/simple;
	bh=twU3orESnx2jZG3sXBTNrrww+jvH1PDJhT+tY59RxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XaMN+1BiCSO6qyssSfCfkvjIBuV42lg/Rft7W+9KBWmEFjegJk9FsvbP20DqKUbrj3Vy3atF7IkSq7Tz2Kdrv8RlWtc/qPHm06SImltg2Y271yp0g19r/LEkreNB5a9j0sb73I166jnlmPLdZclTxsqvnEiWFnaXnpEIMFF25cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TxWY7Fsg; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id b3ebe69af8493161; Mon, 25 Mar 2024 13:58:09 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 479EA66BC66;
	Mon, 25 Mar 2024 13:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711371488;
	bh=twU3orESnx2jZG3sXBTNrrww+jvH1PDJhT+tY59RxX8=;
	h=From:To:Cc:Subject:Date;
	b=TxWY7Fsgc2yjUIaCBqhQ/L7kUGn11xqS+QLWwg7EgreF5SQVHdFBksVhsunWo5NWN
	 vC8LQRPEUds2pBLluHhUEbLJdUniUuIxfsCgQrHK/nA3wIf3wf8ZEp/0SwX023G4Sh
	 MSKSBG7aw4NmlMXkHX5Fc0eQnqEgLvmdp6Vy2pBghEXNFRf43NFxoAlGq0wIt/CH8d
	 iubm7gQgDnQTlE8O1D1vyQerCZTKhSDG+f904hE2jPAWM58NIeOF4E4JlZBbtlcztw
	 xaDyrhLlZAJL3m/nCbOYB1lbAvneZ0elzK2XFeeJgkvKGHI/6cjIfsSv4UKnDM74v+
	 BST/4bwWD2gIQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Francisco Ayala Le Brun <francisco@videowindow.eu>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v1] irq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd
Date: Mon, 25 Mar 2024 13:58:08 +0100
Message-ID: <12417336.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 lhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrrghntghishgtohesvhhiuggvohifihhnughofidrvghu
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a problem when a driver requests a shared IRQ line to run
a threaded handler on it without IRQF_ONESHOT set if that flag has
been set already for the IRQ in question by somebody else.  Namely,
the request fails which usually leads to a probe failure even though
the driver might have worked just fine with IRQF_ONESHOT, but it does
not want to use it by default.  Currently, the only way to handle this
is to try to request the IRQ without IRQF_ONESHOT, but with
IRQF_PROBE_SHARED set and if this fails, try again with IRQF_ONESHOT
set.  However, this is a bit cumbersome and not very clean.

When commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler
for SCI") switched over the ACPI subsystem to using a threaded interrupt
handler for the SCI, it had to use IRQF_ONESHOT for it because that's
required due to the way the SCI handler works (it needs to walk all of
the enabled GPEs before IRQ line can be unmasked).  The SCI IRQ line is
not shared with other users very often due to the SCI handling overhead,
but on sone systems it is shared and when the other user of it attempts
to install a threaded handler, a flags mismatch related to IRQF_ONESHOT
may occur.  As it turned out, that happened to the pinctrl-amd driver
and so commit 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the
interrupt request") attempted to address the issue by adding
IRQF_ONESHOT to the interrupt flags in that driver, but this is now
causing an IRQF_ONESHOT-related mismatch to occur on another system
which cannot boot as a result of it.

Clearly, pinctrl-amd can work with IRQF_ONESHOT if need be, but it
should not set that flag by default, so it needs a way to indicate that
to the IRQ subsystem.

To that end, introdcuce a new interrupt flag, IRQF_COND_ONESHOT, which
will only have effect when the IRQ line is shared and IRQF_ONESHOT has
been set for it already, in which case it will be promoted to the
latter.

This is sufficient for drivers sharing the IRQ line with the SCI as it
is requested by the ACPI subsystem before any drivers are probed, so
they will always see IRQF_ONESHOT set for the IRQ in question.

Closes: https://lore.kernel.org/lkml/CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com/
Fixes: 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt request")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Reported-by: Francisco Ayala Le Brun <francisco@videowindow.eu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pinctrl/pinctrl-amd.c |    2 +-
 include/linux/interrupt.h     |    5 ++++-
 kernel/irq/manage.c           |    9 +++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-pm/include/linux/interrupt.h
===================================================================
--- linux-pm.orig/include/linux/interrupt.h
+++ linux-pm/include/linux/interrupt.h
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
 
@@ -784,7 +787,7 @@ extern void tasklet_setup(struct tasklet
  * if more than one irq occurred.
  */
 
-#if !defined(CONFIG_GENERIC_IRQ_PROBE) 
+#if !defined(CONFIG_GENERIC_IRQ_PROBE)
 static inline unsigned long probe_irq_on(void)
 {
 	return 0;
Index: linux-pm/kernel/irq/manage.c
===================================================================
--- linux-pm.orig/kernel/irq/manage.c
+++ linux-pm/kernel/irq/manage.c
@@ -1643,8 +1643,13 @@ __setup_irq(unsigned int irq, struct irq
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
Index: linux-pm/drivers/pinctrl/pinctrl-amd.c
===================================================================
--- linux-pm.orig/drivers/pinctrl/pinctrl-amd.c
+++ linux-pm/drivers/pinctrl/pinctrl-amd.c
@@ -1159,7 +1159,7 @@ static int amd_gpio_probe(struct platfor
 	}
 
 	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
-			       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME, gpio_dev);
+			       IRQF_SHARED | IRQF_COND_ONESHOT, KBUILD_MODNAME, gpio_dev);
 	if (ret)
 		goto out2;
 




