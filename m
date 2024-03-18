Return-Path: <linux-kernel+bounces-105942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F189D87E6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690771F22707
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CE2E63B;
	Mon, 18 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWLjdrGT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8uP62vt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD328DD6;
	Mon, 18 Mar 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756459; cv=none; b=Qhh413/9Mcwa4NB7KidF1g9Wi6EP8Yl1zdgasxqe2jp3lynHXnYOjeczDLY9A/X57U/309qqW+ec6BwLzvoBq8E38C7KktHrq+QowjZn/ZgVDUYGnzqWXAPmbBEJIHAOwoN4FJevNDOUcPV7xOlfdDd4FyqmrY78p+7Xr2eyoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756459; c=relaxed/simple;
	bh=sPQXUXmNQr8chxf8Q2hXvrwLRi+IJkAtNw6yg45QaK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QiQdtAZQAk297doQZfTMXKaIOmejwHsA7+CNIa1yUwH9XxCxPiQmc5zLI6e5RoTu5aAv0+i9TV4xlw8h62yoUtUo7yCxJrsHxtgHHCJi8EOtxNvCMOqUSY4QBSqwUVB2dLUkaeRuAxp2NXWPp2Cpyte3TLL1MIzoGBc177N6E7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWLjdrGT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8uP62vt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkCBeogWIOiYAgTWOblhmrjKnQzhwtniOfhBW103ggw=;
	b=VWLjdrGTo+XUUlhN+RZEF4EhA7Eb69gQdH6lJP26JWIteC6FJJTPM4tL0wlL0HPhCRaCGm
	6OFamBwhB4N8yErtMeWSeDNQDaL4fs+bpiEGWiOJMhmUo1rPdUJFTc+oUSNTdiY8JqP0+v
	KY7FxPwkseS7ptUWQ4+teSMw+NS5HG3wvbrEoGRpPoxajX99xMPK5GBE9fMI/kNsmS49hZ
	PbpPuRS2tLCIgIuE1ai7s6SvzkkYbzfffTmtl/BFFmLZY7KHI4uzLIgh/SimcURd1iVdut
	VLrsXxsBqbX2Pc1jY56dvoVhlASgU19y8N0kmycXcO6eOVd8uza/eDNappFaKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkCBeogWIOiYAgTWOblhmrjKnQzhwtniOfhBW103ggw=;
	b=N8uP62vtuq1v3nZHyO9Wns44ErewrRd4mBb2aSFuIM7oH6DY6sF2/KCusM8BG7Ber3cT6O
	7b9OwwRi9dICfTCw==
From: "tip-bot2 for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Guard
 against division by zero
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225151336.2728533-3-martin.blumenstingl@googlemail.com>
References: <20240225151336.2728533-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645524.12214.9594202517178756142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e651f2fae33634175fae956d896277cf916f5d09
Gitweb:        https://git.kernel.org/tip/e651f2fae33634175fae956d896277cf916f5d09
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 25 Feb 2024 16:13:35 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 26 Feb 2024 10:07:25 +01:00

clocksource/drivers/arm_global_timer: Guard against division by zero

The result of the division of new_rate by gt_target_rate can be zero (if
new_rate is smaller than gt_target_rate). Using that result as divisor
without checking can result in a division by zero error. Guard against
this by checking for a zero value earlier.
While here, also change the psv variable to an unsigned long to make
sure we don't overflow the datatype as all other types involved are also
unsiged long.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240225151336.2728533-3-martin.blumenstingl@googlemail.com
---
 drivers/clocksource/arm_global_timer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index fd39cfa..4726a15 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -291,18 +291,17 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 	{
-		int psv;
+		unsigned long psv;
 
-		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
-					gt_target_rate);
-
-		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+		psv = DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
+		if (!psv ||
+		    abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
 			return NOTIFY_BAD;
 
 		psv--;
 
 		/* prescaler within legal range? */
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (psv > GT_CONTROL_PRESCALER_MAX)
 			return NOTIFY_BAD;
 
 		/*

