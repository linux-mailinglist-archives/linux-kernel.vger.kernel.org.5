Return-Path: <linux-kernel+bounces-30510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9487D831FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83FB1C23793
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12D2E840;
	Thu, 18 Jan 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1RVh8N+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5HNtTYm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCB2E641;
	Thu, 18 Jan 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605842; cv=none; b=GxMF9VuJ9laSe/SNcHHDeAyfSH7YZZCWGz3RY9y20qhrfOg6frVW0dvOgbXPV+lS56f+2M19x0SDz49Vg9khLkyp32wAPquR3sgc2VJw80fWesWjNAKkztLivEbN4RiQRd05McOAdfTkxkHPZiOY0Yt63V0A6XcBkBKhcGLwF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605842; c=relaxed/simple;
	bh=IQQtFURNvODIyaNvAuKT7JPni73b4s8l2TDrTyHUN08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dVR7Wk/ltRwXy4xgbaP9QOm5wITx7nhkHEVjWafY3lEH0mi61u8JysmrtU3eVJ/gsqq+aKb4FoO6LWRbmEv9Q7QT18DAt73Npk+6BJXOkGTe5CwUtj2alhv7lpzJ1gNNwTO7i0pHti2USYEp7I2Lk+Gobo9gKZaXc6AzEKMuF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1RVh8N+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5HNtTYm; arc=none smtp.client-ip=193.142.43.55
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
	bh=xnIpWqev2LgwO8Ow1GD+t6pP0ociRd6H33tAplbXrUk=;
	b=v1RVh8N+ZiGCtAGsO4yxoeGJyWHEJrIywhLLcvlCxA2lOLNifcCrTdGi9nb786xgvQeR7E
	RDJ71FNz36JevSDJjmAh/U0oQTE1HbVwa09E3qZ3uxb37Q39v01v34gMjMYCNh1u64iSHe
	TIkBV4nEvCdg6QgKaOVvm9Zvg5rXjY3g2cmuQnWr265E/qhUF9A5e5YVV0fajuHhtocYvM
	VjyITKQ1BtN4X4Zwmxk+DpaR9qM/b5mC15fg6+4OFCygZieVWVIPfWY+fpNBKChLSeBUKu
	6Y5x/YZjuDiEpIR+CIg7II2m9nKUghQYQmwqgU0O8NTLzS6Z5Fre3+4ySDP+BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnIpWqev2LgwO8Ow1GD+t6pP0ociRd6H33tAplbXrUk=;
	b=l5HNtTYmSueFVepDrpX9uvpC77E617HsQX/jfGvHznnv6H85SkJ/84hFAvS6UGV1Ms6GiW
	jHwX1+dBF7iFQ9Aw==
From: "tip-bot2 for Joshua Yeong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/timer-riscv: Add riscv_clock_shutdown callback
Cc: Joshua Yeong <joshua.yeong@starfivetech.com>,
 Anup Patel <anup@brainfault.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
References: <20231116105312.4800-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560583897.398.3924693885126380500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6a902b118e7f30dbf0e6248f7b0f97e12c0939c3
Gitweb:        https://git.kernel.org/tip/6a902b118e7f30dbf0e6248f7b0f97e12c0939c3
Author:        Joshua Yeong <joshua.yeong@starfivetech.com>
AuthorDate:    Thu, 16 Nov 2023 18:53:12 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

clocksource/timer-riscv: Add riscv_clock_shutdown callback

Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
switching out riscv timer as clock source

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231116105312.4800-1-joshua.yeong@starfivetech.com
---
 drivers/clocksource/timer-riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 57857c0..e66dcbd 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -61,12 +61,19 @@ static int riscv_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static int riscv_clock_shutdown(struct clock_event_device *evt)
+{
+	riscv_clock_event_stop();
+	return 0;
+}
+
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
+	.set_state_shutdown	= riscv_clock_shutdown,
 };
 
 /*

