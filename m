Return-Path: <linux-kernel+bounces-30509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B27831FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C742A286E10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0022E829;
	Thu, 18 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUh82t1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IMudtwJp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED312E638;
	Thu, 18 Jan 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605842; cv=none; b=CdL9EIiyfeNjBSkhl1EqHhD/kEINtu2b7bmUf9zjI8uOea1w+rTohcKg04US4d8RVkz6shFrRV0oRWcHjfGj2U2zrbOSEY3ST9A2xYAvTXI4LUdNlMfnuBKm8CrGrovRJeaMuUNJgL0VLV93h4DEqJ0GKEsnWVRgq9l/udvwvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605842; c=relaxed/simple;
	bh=5K79weihR9ehHxWPt903GxnUH2tmS6OjPkayhk/1JaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iua2YT3TOGfxq1ZSlKjKVh9KBOVXh4GYIfts8a5Ph+PKs7y7hcRcAroG389iQY2pDSjbLlGeRHn0TUJYheuOeN7s8SDlw4BjtMWLwrrMg8zFb0rrNwztqu0HlSN8EPMCYGMRlMCcBS41lXlifmaAxgnAUEm/pPmxZGh2XbsO5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUh82t1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IMudtwJp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUuNorrMAP9H0ed+OcM49ilz0VjE06cs17ELtrt/WhM=;
	b=oUh82t1g9SPmV+ROGXwQKIDqfCZawhNlbR3wE1jAAtf/nskmdTpSm7J7cu8j89JI2fpQ40
	ezVDb/OTDPPyg+sLm9N3EkDyg14mW8DfY7705a71KSR6cez+gZNqftPRMMX0RU6hTEjDco
	UIZxvMDFEtauLxmh5lKU/NRHAgbH+ZDeyc2lJHbUcFwAIwHRAgdBsKcErMzS4L1Fhofk7V
	lx+H96RiFexstlvgQ2M/diZLnBRz2YB9OHMtLUVs4RRMBQtaNZcTehYeqHBGvi+KOb26hZ
	LGBUPFdaDGxhBmkqJLYOxFaQyNdgvQTLZUAq18p6hEiHcVtBKIo2iCoLInUyHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUuNorrMAP9H0ed+OcM49ilz0VjE06cs17ELtrt/WhM=;
	b=IMudtwJpeB0Y0iRKynwPGDyCmIrR8u3AeOcuBvlQImIiKC3DmV9BgcRzHshpe24g+DQAwO
	0UjSVfb+zX9H1aCA==
From: "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix make W=n
 kerneldoc warnings
Cc: kernel test robot <lkp@intel.com>, Tony Lindgren <tony@atomide.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231114072930.40615-1-tony@atomide.com>
References: <20231114072930.40615-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560583838.398.11665037671743804758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b99a212a7697c542b460adaa15d4a98abf8223f0
Gitweb:        https://git.kernel.org/tip/b99a212a7697c542b460adaa15d4a98abf8223f0
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Tue, 14 Nov 2023 09:29:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

clocksource/drivers/timer-ti-dm: Fix make W=n kerneldoc warnings

Kernel test robot reports of kerneldoc related warnings that happen with
make W=n for "parameter or member not described".

These were caused by changes to function parameter names with
earlier commits where the kerneldoc parts were not updated.

Fixes: 49cd16bb573e ("clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()")
Fixes: a6e543f61531 ("clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040403.DzIiBuwU-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202311040606.XL5OcR9O-lkp@intel.com/
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231114072930.40615-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5f60f6b..56acf26 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -183,7 +183,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
  * dmtimer_write - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
  * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
+ * @val:        data to write into the register
  *
  * The posted mode bit is encoded in reg. Note that in posted mode, the write
  * pending bit must be checked. Otherwise a write on a register which has a
@@ -949,7 +949,7 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
 
 /**
  * omap_dm_timer_set_int_disable - disable timer interrupts
- * @timer:	pointer to timer handle
+ * @cookie:	pointer to timer cookie
  * @mask:	bit mask of interrupts to be disabled
  *
  * Disables the specified timer interrupts for a timer.

