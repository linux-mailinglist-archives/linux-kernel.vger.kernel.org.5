Return-Path: <linux-kernel+bounces-30507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62F831F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2485D286E65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128A2E64B;
	Thu, 18 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3jlXfr7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aW4Xy3u4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317C2E634;
	Thu, 18 Jan 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605841; cv=none; b=QgK3OMIYOJdNE12rPgjCudsnB9r1Pu1fabtIRc8YbjZnGxjlgfChcVRYQ6YvsO4fZT+5EK0tKutm+SxSbFnhHUrnSJeJCO5x5xx09kgSRkDAmjAqU1hs7gM7ZaYJY6II5HuCSyo74EI5pGBW8iqznDbzlm4+31ULKNhP47j73og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605841; c=relaxed/simple;
	bh=9hr/7fjhRvmcQmjYItGDdkQCKhlx2IvLl3sOfGQHBbM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YG25N9t82XG+74C/5z1jeJm2PQ0Hho3OCAU1ccW0dg9jlJZJmXKTVZDtUt5CMZdns/S8evDqCkUMJbudEfmnvNDcjEHxXn/Jx7uovxlykPgM78jm51c+0wyTIQ+Ag5jUDAL4PBvNlQDGztDyDqVpvhjZB10VeOB6W65Q2S5kNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3jlXfr7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aW4Xy3u4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:23:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgW/i/vlq368iaRaAnAKAD10of9tlH2c0h+ZDCJ2tp4=;
	b=L3jlXfr70CENyuvN9yUKlAOyDVMg7JqH5ALb/+KyFU1k64OYlVFwzD4YdzCvXM8s+KJYVP
	6uvP3KKgqGl0jcfI+Xk8Q9V/KBzlpkwV4koDvasH7LeM2Py6eP3WbZLRyUvQWSZVzcr2mf
	a/HJhfTws10DZx0lBU5G7EpMjxGcoEaZDXdls2bZ5ZhuzfDwwqvRdD2sPB7WFc9rsb6xbZ
	KgGfl+NNnOY4wsFEHYMk5i480QBn6LR1IZMDo+lun79oXZC+ZbEFYvrupmKUxGurgkWQZm
	hRvNUItFaupR0BK27dDMSkn/NVrBvjLFzwmBpKSO6paQEsajQbZl7mxHZ9FaXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgW/i/vlq368iaRaAnAKAD10of9tlH2c0h+ZDCJ2tp4=;
	b=aW4Xy3u42v8kQuXW8obtMG1B8biSCsN8Y5VeKCTwmFMB5lEFWep5/V1SWN+L1H4KlHkp3Z
	1G+oHPzC8MlFN+Bw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ep93xx: Fix error handling
 during probe
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231212214616.193098-1-arnd@kernel.org>
References: <20231212214616.193098-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560583693.398.17590725496857757216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c0c4579d79d0df841e825c68df450909a0032faf
Gitweb:        https://git.kernel.org/tip/c0c4579d79d0df841e825c68df450909a0032faf
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 12 Dec 2023 22:46:07 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

clocksource/drivers/ep93xx: Fix error handling during probe

When the interrupt property fails to be parsed, ep93xx_timer_of_init()
return code ends up uninitialized:

drivers/clocksource/timer-ep93xx.c:160:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (irq < 0) {
            ^~~~~~~
drivers/clocksource/timer-ep93xx.c:188:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/clocksource/timer-ep93xx.c:160:2: note: remove the 'if' if its condition is always false
        if (irq < 0) {
        ^~~~~~~~~~~~~~

Simplify this portion to use the normal construct of just checking
whether a valid interrupt was returned. Note that irq_of_parse_and_map()
never returns a negative value and no other callers check for that either.

Fixes: c28ca80ba3b5 ("clocksource: ep93xx: Add driver for Cirrus Logic EP93xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231212214616.193098-1-arnd@kernel.org
---
 drivers/clocksource/timer-ep93xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
index bc0ca6e..6981ff3 100644
--- a/drivers/clocksource/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -155,9 +155,8 @@ static int __init ep93xx_timer_of_init(struct device_node *np)
 	ep93xx_tcu = tcu;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == 0)
-		irq = -EINVAL;
-	if (irq < 0) {
+	if (!irq) {
+		ret = -EINVAL;
 		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
 		goto out_free;
 	}

