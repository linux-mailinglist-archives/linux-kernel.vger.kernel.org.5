Return-Path: <linux-kernel+bounces-105950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE287E6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAB2830B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4C374FF;
	Mon, 18 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjh6ibU8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufqOZYNE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865533CF5;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756462; cv=none; b=qgUXaH1A5yAEQh6rK8K65fMHPU7N509gKzwx9jspzNKwXnbjXj0FQk9iAnBMFQmIQGOm5ciapqz/9I0u1aOkzRZgNvsjuBK6hf4T23jY5jsaXrP2W4v2i/r1jUGGCM4L8N6XrOt9eZjaS6K05JGXfHAxgx8e3sf4l6rvCyWAhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756462; c=relaxed/simple;
	bh=ZuJAc6yNfnTF1I0PEjxLvcPmqJSLmCLUjRddv0LK1DE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kPvQqh3jqjYg3Yr4cr52cJfHmmgl8EZG2eZ8hxuHqCQ16bP/rgNc7SK/uHpKpy7LuRrNKKwL3bTj4RUWIFf/tGA1F9IA+Q1SEZJ8Kpn0LJNxodAEc4LLtyWXMbvn3+mqQAXEotbM/flIRaL8DWXHzDwK4gRPA1/JfIsH4/6BBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjh6ibU8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufqOZYNE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b//zDllkXn+N6wHnmQVoU019nyMDE8fxzSYmDMfEnV8=;
	b=gjh6ibU8NyL6WMECKzn/tmb6dpJEQt8oEUDGKRpEohEpny2gkVmQkFnxNk51/Cm2SRgUZW
	V1KQW7K/8ePt+yLRR5nAbnkm1MXY74Veyjl4bS83ph169r8jvXNCj6neGolrFCWaqg7g8z
	bjR4MDYsyxaZj0nsaGqbG2wgnx+qBYKznf42F++X0jZcuLQlwYVSGvAfWyT1loLA4JKtNh
	R05n3EUEhkRy6QCsoMI6NVr2sw82G5m/uRRiJTn8ZPpZyDh6a02FR4DHKVXLTrFj64nepm
	imtNh9JgAbtHM+b813KMKJLpJ1ZrqphBhafJEVkOf202AwhV52ZlRa5dmInTSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b//zDllkXn+N6wHnmQVoU019nyMDE8fxzSYmDMfEnV8=;
	b=ufqOZYNEfzcEgb3xs9lvuO/q7+qQtPrICkNSRKGx8RqvVlbIS87lamMGZZIFosu60vBjkp
	qDdVa8dRfBhRKDBQ==
From: "tip-bot2 for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Fix maximum
 prescaler value
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
References: <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645864.12214.2790928900981194474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b34b9547cee41575a4fddf390f615570759dc999
Gitweb:        https://git.kernel.org/tip/b34b9547cee41575a4fddf390f615570759dc999
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 18 Feb 2024 18:41:37 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Feb 2024 00:48:54 +01:00

clocksource/drivers/arm_global_timer: Fix maximum prescaler value

The prescaler in the "Global Timer Control Register bit assignments" is
documented to use bits [15:8], which means that the maximum prescaler
register value is 0xff.

Fixes: 171b45a4a70e ("clocksource/drivers/arm_global_timer: Implement rate compensation whenever source clock changes")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240218174138.1942418-2-martin.blumenstingl@googlemail.com
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 44a61dc..e1c773b 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -32,7 +32,7 @@
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
 #define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MAX        0xFF
 #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
 					 GT_CONTROL_PRESCALER_SHIFT)
 

