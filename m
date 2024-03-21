Return-Path: <linux-kernel+bounces-110349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065E885D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EAC1C21A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EA12B7E;
	Thu, 21 Mar 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vuPY1Tkk"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CDB66F;
	Thu, 21 Mar 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038839; cv=none; b=FXU0Kk9Ks4yIEIeV/gH4gpmTYd6bzeizaNa13PpjFdR/J8/CwbBD5RiawCETm4kuX70vIwxyn0sJAxh40TxkvdugSaw98ZfktrhA+BTeNjyVlfqAQY8pELSn+2LBJEqEMySLXdQvvG+durSgZUXiCFtmFZYAaTFvg0vIP68PsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038839; c=relaxed/simple;
	bh=y59uyS11jV7G5nY3Iw1+M8P4LfNC4nSVR4AUC0kTnms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEzAZhgaW669p1T4snj18pmSFt0fq5rh3DV1fqErEk2Jwiqx/B8Qf4Kn5G2pCXiZhlEsOS/Eechmnyswq72JJ2Sr/vNCgTFjeX1d0HEPH2kpDrW52sC4GR9e/l7mASc8QovE6OxLlaroDCsE/nytdCte8HzV/Po1sCvMGDXWl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vuPY1Tkk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 251eb72d48bcdbe6; Thu, 21 Mar 2024 17:33:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8A4F966B89C;
	Thu, 21 Mar 2024 17:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711038829;
	bh=y59uyS11jV7G5nY3Iw1+M8P4LfNC4nSVR4AUC0kTnms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vuPY1TkkSw7N1gBceDfeKlX4AIZiDjpHDt7FO/Mog69LqJ/rQkvpyJx5G7gZbRwzo
	 nqJ7QwH7oh66qBUSBfpe7ake69B5izcqCX5W5x39wd5vfGfXyVhYRqllMvV3SL6Orh
	 rXikZpMzCSqbgTu22fT14lHYI9WbdML9gtZtjn53PksTnn9PCyLFMRYYOMR7Iv4z0l
	 lJTxgHdoWRb/LtRj8rIJSBFm64AirC9bB2RhhQ4CQ8U7rdvlLFEP+VP/aqPNAhFA43
	 gWQxc71dBsidrN5e5K1siiDC/BKQiSps95CJc/32gOQap5DYrIivg5nwSWfB3lsE4v
	 boCtyB25HYrwg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Francisco Ayala Le Brun <francisco@videowindow.eu>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
Date: Thu, 21 Mar 2024 17:33:48 +0100
Message-ID: <5770245.DvuYhMxLoT@kreacher>
In-Reply-To: <5767438.DvuYhMxLoT@kreacher>
References:
 <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com>
 <5767438.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehfrhgrnhgtihhstghosehvihguvghofihinhguohifrdgvuhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
 uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

On Wednesday, March 20, 2024 8:29:55 PM CET Rafael J. Wysocki wrote:
> On Tuesday, March 19, 2024 5:20:41 PM CET Adrian Hunter wrote:
> > On 19/03/24 16:43, Francisco Ayala Le Brun wrote:
> > > Hello,
> > > 
> > > I would like to report a bug.
> > > 
> > > Issue description:
> > > After updating a GHF51 SBC to a newer kernel version, the system was
> > 
> > What was the older / working kernel version?  Are you able
> > to git bisect?
> > 
> > > no longer able to boot. Running the "lsblk" command in the recovery
> > > console showed no mmc storage detected.
> > > 
> > > System Information:
> > > OS: Fedora 40 x86_64
> > > Kernel: 6.8.0-0.rc6.49.fc40.x86_64
> > > 
> > > Relevant Logs:
> > 
> > Really no error / fail messages before the stack dump?
> > 
> > > [   10.920756] Call Trace:
> > > [   10.920763]  <TASK>
> > > [   10.920771]  dump_stack_lvl+0x4d/0x70
> > > [   10.920786]  __setup_irq+0x530/0x6c0
> > > [   10.920801]  request_threaded_irq+0xe5/0x180
> > > [   10.920813]  ? __pfx_sdhci_thread_irq+0x10/0x10 [sdhci]
> > > [   10.920843]  __sdhci_add_host+0x108/0x360 [sdhci]
> > > [   10.920871]  sdhci_acpi_probe+0x3a8/0x500 [sdhci_acpi]
> > > [   10.920894]  platform_probe+0x44/0xa0
> > > [   10.920908]  really_probe+0x19e/0x3e0
> > > [   10.930244]  __driver_probe_device+0x78/0x160
> > > [   10.930264]  driver_probe_device+0x1f/0xa0
> > > [   10.930273]  __driver_attach_async_helper+0x5e/0xe0
> > > [   10.930284]  async_run_entry_fn+0x34/0x130
> > > [   10.930296]  process_one_work+0x170/0x330
> > > [   10.930309]  worker_thread+0x273/0x3c0
> > > [   10.934639]  ? __pfx_worker_thread+0x10/0x10
> > > [   10.934654]  kthread+0xe8/0x120
> > > [   10.934663]  ? __pfx_kthread+0x10/0x10
> > > [   10.934671]  ret_from_fork+0x34/0x50
> > > [   10.934681]  ? __pfx_kthread+0x10/0x10
> > > [   10.934688]  ret_from_fork_asm+0x1b/0x30
> > > [   10.934708]  </TASK>
> > > [   10.940978] mmc0: Failed to request IRQ 7: -16
> > > [   10.943885] sdhci-acpi: probe of AMDI0040:00 failed with error -16
> > 
> > 16 is EBUSY which seems to be used by __setup_irq() for
> > irq mismatch
> 
> Would you be able to test the patch below and see if it helps?
> 
> ---
>  drivers/pinctrl/pinctrl-amd.c |    2 +-
>  include/linux/interrupt.h     |    5 ++++-
>  kernel/irq/manage.c           |   13 +++++++++++--
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/include/linux/interrupt.h
> ===================================================================
> --- linux-pm.orig/include/linux/interrupt.h
> +++ linux-pm/include/linux/interrupt.h
> @@ -67,6 +67,8 @@
>   *                later.
>   * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
>   *		   depends on IRQF_PERCPU.
> + * IRQF_COND_ONESHOT - Agree to do IRQF_ONESHOT if already set for a shared
> + *                 interrupt.
>   */
>  #define IRQF_SHARED		0x00000080
>  #define IRQF_PROBE_SHARED	0x00000100
> @@ -82,6 +84,7 @@
>  #define IRQF_COND_SUSPEND	0x00040000
>  #define IRQF_NO_AUTOEN		0x00080000
>  #define IRQF_NO_DEBUG		0x00100000
> +#define IRQF_COND_ONESHOT	0x00200000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  

We actually can get away without defining a new IRQ flag, as in
the patch below.

It is not super-clean, but should do the work.

Linus, what do you think?

---
 drivers/pinctrl/pinctrl-amd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pinctrl/pinctrl-amd.c
===================================================================
--- linux-pm.orig/drivers/pinctrl/pinctrl-amd.c
+++ linux-pm/drivers/pinctrl/pinctrl-amd.c
@@ -1159,7 +1159,18 @@ static int amd_gpio_probe(struct platfor
 	}
 
 	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
-			       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME, gpio_dev);
+			       IRQF_SHARED | IRQF_PROBE_SHARED, KBUILD_MODNAME,
+			       gpio_dev);
+	/*
+	 * There can be a flags mismatch if IRQF_ONESHOT has been set for the
+	 * IRQ already, so if the error code indicates that, try again with
+	 * IRQF_ONESHOT set.
+	 */
+	if (ret == -EBUSY)
+		ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
+				       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME,
+				       gpio_dev);
+
 	if (ret)
 		goto out2;
 




