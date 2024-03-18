Return-Path: <linux-kernel+bounces-105957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6887E6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEE41C218B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045B3F9D4;
	Mon, 18 Mar 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOSBWNmN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="59tst1XK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9239840;
	Mon, 18 Mar 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756467; cv=none; b=GYmkn3zBIizPoral2Ro4jYVOtUE/GGu1ttBsXuKpaRq3ESjcgmlpQAepilmDbvKtk1u+rdWesjmCv3fYaXCNPF907O/A+nVZMb7ZrEIGguCcPfhO/SSwJkIWJUZrVxGQXy5nNmSCl5SRmFThg9CwchbaUHGaw1B5AF9q1qXzlhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756467; c=relaxed/simple;
	bh=ygJD81H/s+iOVJSVIE/YLc7P+dYz2mHlCbIBJNuqc7U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pumGWpnOK0dGTuqyLyEOmGBxXy28N8TIAkxP0jYCVCGdbiDibsc/MDbeYjpoNq9fpQfQbesO+P/2sJDkpiCIwI7WwYXZRGzuOVT8aHHD0FZ97z6spbOXXmO+G14/WOvkmtAHjDuFfC+wdnM/8tWRCvhBIUY6M9xxXdiaXo8i4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOSBWNmN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=59tst1XK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6Md1VP8kiIpnNH9Nd9C6ilbLntoy7J6ypnrNQQAukM=;
	b=sOSBWNmNU0UYW5tIuBgx/OYUK+1InjbMd1Ycx4ahi/W2D6VIb6l1eQIHyX+UoYgsGmZIvh
	cnRYycR+MHIaM2mgaVzTIPu6OtjgKOIU2XXvZPYItAanU6DxigKLHUfNYwgnJ7jh9U2tux
	IllNSw+LgeM5lUHnxlcC6ErnBdq3aPnWPdaIoiRSu0kNIcJziDTIKL0UP1mgjcZlAYR6iL
	18VvJA1dXkTcfAebOToLOebFkaJMeSdI+8ucE2rZcQAJVLz84phZv7u6jqH+TlPomCde+s
	20oR2Ox2gZF2B+V2JPmEdQjgmC3FhGRab9K6spFlhTu7hE75EtKcir3rDoMPkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6Md1VP8kiIpnNH9Nd9C6ilbLntoy7J6ypnrNQQAukM=;
	b=59tst1XKHmDS1GiygM0q2wj2bHfuxzSKZ1idg7qhOIUH8QG/RUXuhqPIzrrsI6Ygn7j92H
	HXspyszkvGSmvtDg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/drivers/stm32: Fix all kernel-doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240120173615.14618-1-rdunlap@infradead.org>
References: <20240120173615.14618-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646340.12214.5162192204726393181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     906fed29f4527e60db30d4eaa4b5b06a92447c69
Gitweb:        https://git.kernel.org/tip/906fed29f4527e60db30d4eaa4b5b06a92447c69
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 20 Jan 2024 09:36:15 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 22 Jan 2024 13:15:38 +01:00

clocksource/drivers/stm32: Fix all kernel-doc warnings

Add a "Returns:" section in one function description.
Use the correct function name in another function description.

These changes prevent 2 warnings:

timer-stm32.c:79: warning: No description found for return value of 'stm32_timer_of_bits_get'
timer-stm32.c:189: warning: expecting prototype for stm32_timer_width(). Prototype was for stm32_timer_set_width() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240120173615.14618-1-rdunlap@infradead.org
---
 drivers/clocksource/timer-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index c9a753f..0a4ea32 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -73,7 +73,7 @@ static void stm32_timer_of_bits_set(struct timer_of *to, int bits)
  * Accessor helper to get the number of bits in the timer-of private
  * structure.
  *
- * Returns an integer corresponding to the number of bits.
+ * Returns: an integer corresponding to the number of bits.
  */
 static int stm32_timer_of_bits_get(struct timer_of *to)
 {
@@ -177,7 +177,7 @@ static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 }
 
 /**
- * stm32_timer_width - Sort out the timer width (32/16)
+ * stm32_timer_set_width - Sort out the timer width (32/16)
  * @to: a pointer to a timer-of structure
  *
  * Write the 32-bit max value and read/return the result. If the timer

