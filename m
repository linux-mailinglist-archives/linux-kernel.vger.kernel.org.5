Return-Path: <linux-kernel+bounces-109343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCE8817D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E7D1C22C91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BEF85644;
	Wed, 20 Mar 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="pMZ7IAzk"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D485639;
	Wed, 20 Mar 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963007; cv=none; b=W2LYDZ9uogStuJyDWxZhPH24IDBtnbIvSCeAcQnJxEsu8FtkOB37jruEFTlJoJbt77LyIp+JqlQpftHfUmzY5wmV65hzZLsqLVFRGer0Zf5OiGVXEHBLcQQW/TtFKx6H90J2zx4Rdhpm993ENYroukc0KLNBPMP1bFZdXRrwts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963007; c=relaxed/simple;
	bh=fGS3F1q6ekW/yCKZ4NCW6yPu736Ze9C5mVOM0rCHt1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgEj4gzXKfjYhZm4xbrM882yZdm9be1cdYZfXooyT/9bCIcynlQ4cPXmIUxp8ybmfFwtPFE+QGrVkLX0ODuDv+N1lYBLjYUDU4FRaIuLwitrlZdesgeF/Zp8Iq2VBeOML7B5nbAGzjo6EqWDoCPZwb086ctMu0Mf6Q0OFqfnN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=pMZ7IAzk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c31793086dac50fa; Wed, 20 Mar 2024 20:29:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AD11D66B753;
	Wed, 20 Mar 2024 20:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1710962996;
	bh=fGS3F1q6ekW/yCKZ4NCW6yPu736Ze9C5mVOM0rCHt1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pMZ7IAzkPS9xe7oGU/ABJjyxXCL6MCryXkq5K6JE9mpX5vSJxG0WFtNgbJXIVf3eJ
	 SZlHgzUFmcZPyMTzDJkxl6Xv1PrO9ajk2Hd22SzeBZ6tDlIzJwgU3PzwvV9ZKm+CSe
	 wfOOwdBsez5CaTDez8NsyOOBsZtwIU0JX4p9hM1I7d+VP77WnptBU8TanYQwJlmcA7
	 R/LHglJv3bu+9QQr2+ezRH8vY3/lBa2cDzxhCp7HtfYSthZI+l2F+tRzXrwTM2+P1p
	 UXoTbgggbmw9mbVNH9xnB4YT5n5L82DM91jxWd1JHWFDC7nE8pSKfFVjXaNEE4jZPW
	 CCgoikU1bbzcw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Francisco Ayala Le Brun <francisco@videowindow.eu>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
Date: Wed, 20 Mar 2024 20:29:55 +0100
Message-ID: <5767438.DvuYhMxLoT@kreacher>
In-Reply-To: <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com>
References:
 <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepfhhrrghntghishgtohesvhhiuggvohifihhnughofidrvghupdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
 ohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

On Tuesday, March 19, 2024 5:20:41 PM CET Adrian Hunter wrote:
> On 19/03/24 16:43, Francisco Ayala Le Brun wrote:
> > Hello,
> > 
> > I would like to report a bug.
> > 
> > Issue description:
> > After updating a GHF51 SBC to a newer kernel version, the system was
> 
> What was the older / working kernel version?  Are you able
> to git bisect?
> 
> > no longer able to boot. Running the "lsblk" command in the recovery
> > console showed no mmc storage detected.
> > 
> > System Information:
> > OS: Fedora 40 x86_64
> > Kernel: 6.8.0-0.rc6.49.fc40.x86_64
> > 
> > Relevant Logs:
> 
> Really no error / fail messages before the stack dump?
> 
> > [   10.920756] Call Trace:
> > [   10.920763]  <TASK>
> > [   10.920771]  dump_stack_lvl+0x4d/0x70
> > [   10.920786]  __setup_irq+0x530/0x6c0
> > [   10.920801]  request_threaded_irq+0xe5/0x180
> > [   10.920813]  ? __pfx_sdhci_thread_irq+0x10/0x10 [sdhci]
> > [   10.920843]  __sdhci_add_host+0x108/0x360 [sdhci]
> > [   10.920871]  sdhci_acpi_probe+0x3a8/0x500 [sdhci_acpi]
> > [   10.920894]  platform_probe+0x44/0xa0
> > [   10.920908]  really_probe+0x19e/0x3e0
> > [   10.930244]  __driver_probe_device+0x78/0x160
> > [   10.930264]  driver_probe_device+0x1f/0xa0
> > [   10.930273]  __driver_attach_async_helper+0x5e/0xe0
> > [   10.930284]  async_run_entry_fn+0x34/0x130
> > [   10.930296]  process_one_work+0x170/0x330
> > [   10.930309]  worker_thread+0x273/0x3c0
> > [   10.934639]  ? __pfx_worker_thread+0x10/0x10
> > [   10.934654]  kthread+0xe8/0x120
> > [   10.934663]  ? __pfx_kthread+0x10/0x10
> > [   10.934671]  ret_from_fork+0x34/0x50
> > [   10.934681]  ? __pfx_kthread+0x10/0x10
> > [   10.934688]  ret_from_fork_asm+0x1b/0x30
> > [   10.934708]  </TASK>
> > [   10.940978] mmc0: Failed to request IRQ 7: -16
> > [   10.943885] sdhci-acpi: probe of AMDI0040:00 failed with error -16
> 
> 16 is EBUSY which seems to be used by __setup_irq() for
> irq mismatch

Would you be able to test the patch below and see if it helps?

---
 drivers/pinctrl/pinctrl-amd.c |    2 +-
 include/linux/interrupt.h     |    5 ++++-
 kernel/irq/manage.c           |   13 +++++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

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
@@ -1642,8 +1642,14 @@ __setup_irq(unsigned int irq, struct irq
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
+
+		if ((old->flags ^ new->flags) & IRQF_ONESHOT)
 			goto mismatch;
 
 		/* All handlers must agree on per-cpuness */
@@ -1665,6 +1671,9 @@ __setup_irq(unsigned int irq, struct irq
 		shared = 1;
 	}
 
+	/* IRQF_COND_ONESHOT has no meaning from now on, so clear it. */
+	new->flags &= ~IRQF_COND_ONESHOT;
+
 	/*
 	 * Setup the thread mask for this irqaction for ONESHOT. For
 	 * !ONESHOT irqs the thread mask is 0 so we can avoid a
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
 





