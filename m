Return-Path: <linux-kernel+bounces-110597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E7886117
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F701F21AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3B13540E;
	Thu, 21 Mar 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JO5qvYAF"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68213442E;
	Thu, 21 Mar 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049667; cv=none; b=pSSu3ht4ktbxmHb3FSnU8lQ+72oO7r5OYh4HT5uAopfaZiQkEwZ0WKwqR8GWyysyyN4LJTkQuwx+oBQJUlx/c8dBgAfgbQEq5kT/uG+VrBNEf/mg6pxx2DMd1CASRgrBtNBseIu1McV6dbPgoT6uAmQh0e/Gf90HOoH+oQrx0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049667; c=relaxed/simple;
	bh=8A2wrudJMqa4rJ04LxRBfhEzIL9L2ZJmURvmhuJpY4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzMn1izRJ+IwHEcgsXtdCcsNSRpiuew8OheJrn9H56VNkoZZ/Hu6wP00e0TZF2nCeCkbSWSu+O4tuYxBqkv/Z9O1GK+mCd6HNOwdAMVke/eQebtRY8n/BMQ4MXSbTDGHUCgKV/x0bWuuJisDZoY8xhtR19+yPrHo9nWXAEC2eDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JO5qvYAF; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 1c1d074a8c5ff484; Thu, 21 Mar 2024 20:34:16 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4A7AB66B8D7;
	Thu, 21 Mar 2024 20:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049656;
	bh=8A2wrudJMqa4rJ04LxRBfhEzIL9L2ZJmURvmhuJpY4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JO5qvYAF0hvkGX48AKJ7qYq27wl8Cp21HWYmmNTRS6Q7hGEnxbCkmLX9ER1TjJ1Ju
	 Y4wKHWHcklINPKby3oy7csjwp9vQDYQaR2Kz6zbK3q1+Vglfg+VrTqlSq9r5VP4Tpz
	 NRkyFS7pwR1Fopps+wIGvqHdGOgfmGStb+Bx9BxEQfVrrR0jMDWPLZsgoodWelMTbO
	 3wifXplYSUHvQXFx4r7NYFYp1FVAXWtig4jnvjuKM2y7/ruQUxN6FXjJkPrQgZbydw
	 h4Ix4nJOVaJUiZk1+UQ/+0WuyTOFVejv7xlq//crhfp2PC+nmTI998RHXpbZ04N6kq
	 eF/h6WSMeEnYw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/5] cpufreq: intel_pstate: Simplify spinlock locking
Date: Thu, 21 Mar 2024 20:30:42 +0100
Message-ID: <4561413.LvFx2qVVIh@kreacher>
In-Reply-To: <12409658.O9o76ZdvQC@kreacher>
References: <12409658.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because intel_pstate_enable/disable_hwp_interrupt() are only called from
thread context, they need not save the IRQ flags when using a spinlock
as interrupts are guaranteed to be enabled when they run, so make them
use spin_lock/unlock_irq().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1682,30 +1682,26 @@ ack_intr:
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 {
-	unsigned long flags;
-
 	if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	spin_lock_irq(&hwp_notify_lock);
 	if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
 		cancel_delayed_work(&cpudata->hwp_notify_work);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	spin_unlock_irq(&hwp_notify_lock);
 }
 
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 {
 	/* Enable HWP notification interrupt for guaranteed performance change */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&hwp_notify_lock, flags);
+		spin_lock_irq(&hwp_notify_lock);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-		spin_unlock_irqrestore(&hwp_notify_lock, flags);
+		spin_unlock_irq(&hwp_notify_lock);
 
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);




