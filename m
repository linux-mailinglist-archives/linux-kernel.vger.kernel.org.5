Return-Path: <linux-kernel+bounces-105944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07F87E6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35EF1C21682
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A02E644;
	Mon, 18 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwULD6Xe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKJTMyOp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0A2C87A;
	Mon, 18 Mar 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756459; cv=none; b=fbTDnnn2FmVAzpud1KklVURNK0nUKkIOsM+e+vi6f0hREAjmCZNdjsmCTLIEvwVxPhrVvg+0WmiWHUpOdPh1IjnY7aI/r2wrw7vYC1DlcKEqVZH2KvuUjNd/JqKWzYBtGNL1tF916O+2NW/hnXWHtK/b8gT5+/6IbY3XUGQjy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756459; c=relaxed/simple;
	bh=pj+rcMyOroe98gdifNXYG8iw5FTYjh/F7Hkr4AymIWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p6tGty8G/qDzLrlf5ySPePPgskQDMdYNc9db1feTVebnoHjU8uCmoyI7QNycgBawmLRO5qIwhQ72BWpk4m8PwvV2CD+mYNGbdxSmeoZ6ZZFWbVN1lKg3llQzxJccOnxfgouYCmS6JoPRigQda2Vd3d10mK6BSkePXgM1srDcs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwULD6Xe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKJTMyOp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjhdYcghU+6oGp0f0ppi3Vin6mzC87vD2TKJqS1tz6c=;
	b=qwULD6Xe7+Y5FA7Zr6epn/BKRUohz4UiiNQtaaZSlSjvbK/S0imd0zGW1TTA3Uiq24X0/l
	jiWiPTZRRbXdzgzvnPNG63CtK9z2GV0GvH/Lm5ljFsllg2aFIagig09n/kD4et+1fpDPQp
	H4sRKq3rKJ65IrMnhaGclB7mevWJaLolHJHtAaqJ6JQY0qloG9qvMEOnncCPUTOL1oXhgn
	5X7G0tcnfrB9qOVnMSEQYhfLoXKtQf6vOSS0QJPT9un89bY/EUBg1lW7IVW8YDqRTcBV0T
	Hxy7bFo/J5RIMMfk29rxMdhNqTfYN8neSS8TXoeMoD2ePuEKfrf0qu0pmO7NRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjhdYcghU+6oGp0f0ppi3Vin6mzC87vD2TKJqS1tz6c=;
	b=vKJTMyOpuiXqGadf8P82U0oPZVvi4XdbnCF6hXvTMnRp6XAkO/wLkcsSfWrEtawMq+qNui
	JxLH7CQcw2Pn3FBA==
From: "tip-bot2 for Ley Foon Tan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-riscv: Clear timer
 interrupt on timer initialization
Cc:  <stable@vger.kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@rivosinc.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
References: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645287.12214.16209590885523114527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8248ca30ef89f9cc74ace62ae1b9a22b5f16736c
Gitweb:        https://git.kernel.org/tip/8248ca30ef89f9cc74ace62ae1b9a22b5f16736c
Author:        Ley Foon Tan <leyfoon.tan@starfivetech.com>
AuthorDate:    Thu, 07 Mar 2024 01:23:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Mar 2024 12:08:59 +01:00

clocksource/drivers/timer-riscv: Clear timer interrupt on timer initialization

In the RISC-V specification, the stimecmp register doesn't have a default
value. To prevent the timer interrupt from being triggered during timer
initialization, clear the timer interrupt by writing stimecmp with a
maximum value.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240306172330.255844-1-leyfoon.tan@starfivetech.com
---
 drivers/clocksource/timer-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd..79bb9a9 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -108,6 +108,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)

