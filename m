Return-Path: <linux-kernel+bounces-105947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA887E6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D868F1F22929
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12A374FE;
	Mon, 18 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUD9SaCS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1fuYq6I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DE2DF73;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756462; cv=none; b=CICsbcY72R9y5UTGP35svoOeAzSbRBo4pLxhJiSNthLs8DPRBesafhG+Ds10o5MX2X+EHC/UzkKrofplfrviw1ZMFlY5t7Q45q+qZFLmOo9ySkP8pBYLq/2Y/aiqyS4+9tsEPVHlGl8FwFJZNSOvbhnUng8fVgLYKGO6A3Rirc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756462; c=relaxed/simple;
	bh=DcAaQtdBQrZIRq1CHUhsIubUCl6MAP9nJ/aC7oxtUfs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eF4UQOOKE10IpMPH3PMaT7OHRaoPVwxeS2lA2T5o0LITOlvFDN+8O++UUlw4fEUWWCMEni8Lp++x5q7g+Kwu+nVecENbVkZLgx2/y7pqqwJ+Mdt8RTDAxYWPhkxVPkL9juVLR69iDM+du0agi9jxbUgbw5MhX1DF5AV1Cs8POvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUD9SaCS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1fuYq6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7evhfPnd1RPYCxwLXH6wa1aAVX12OKV7OSBKq/SrTb8=;
	b=CUD9SaCSggE+po+J79/pp0JHDLn49alDKRhjEPKoomBMzgUecQ+jMjpiH+WX+aNzGT9sw9
	z/fJIxsiDz4amaVRiqbazXvUjSxhqm4MNoJdq2uA+Qw390F2xtGImHB80pcV48fo57kppw
	XviXRmg+CYUFboUgRjslVNwJyXk/AR6eWGq/SY5Db54DpZTkoarzf4nL3pW/ZHFMuAOyhL
	OyMPhGTDYsgf8tgy3q3HCmZz/d7Af1iU7xmR8x6icyMdUoDYQvfa3KOYAe7WqWcg1FvBC3
	kXz5xmId/fvjbO6OMWlzyO9bLoE2pmn6xRhfQ2LzW9MbAmVWv7YUlpRibAiOpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7evhfPnd1RPYCxwLXH6wa1aAVX12OKV7OSBKq/SrTb8=;
	b=j1fuYq6IysXE08kqgVCicBPDN7657nB4NtamA0uRf4xFiRDx3DbgISUSDCALeFdmkFEAc/
	sfhGHNkKbKreHeDA==
From: "tip-bot2 for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/drivers/arm_global_timer: Remove stray tab
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240218174138.1942418-3-martin.blumenstingl@googlemail.com>
References: <20240218174138.1942418-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645798.12214.15954789359563730539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9256cec7b4f3293c11585326401325b1f81670e1
Gitweb:        https://git.kernel.org/tip/9256cec7b4f3293c11585326401325b1f81670e1
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 18 Feb 2024 18:41:38 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 19 Feb 2024 00:48:54 +01:00

clocksource/drivers/arm_global_timer: Remove stray tab

Remove a stray tab in global_timer_of_register() which is different from
the coding style in the rest of the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240218174138.1942418-3-martin.blumenstingl@googlemail.com
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e1c773b..8dd1e46 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -411,7 +411,7 @@ static int __init global_timer_of_register(struct device_node *np)
 	err = gt_clocksource_init();
 	if (err)
 		goto out_irq;
-	
+
 	err = cpuhp_setup_state(CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 				"clockevents/arm/global_timer:starting",
 				gt_starting_cpu, gt_dying_cpu);

