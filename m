Return-Path: <linux-kernel+bounces-76936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A985FEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89851F28A37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9715697B;
	Thu, 22 Feb 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qTui1JCW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHYcyft0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF0155303;
	Thu, 22 Feb 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621932; cv=none; b=HumZhIFHvdLOoKLcR7QCU1irMREI9NY+U/NpCl9r8HVBpF1iBQjpVUN7GBdBSmbpVs+uHdOoZ+/pJqHQFV9P0Rmp6GNIq1jU3/h0c5xTEJkuBawtztuYLEshXLx4Koqj/0QouvysxyTSTtYpvWN95OINxMlX7uDqoPS+xctfHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621932; c=relaxed/simple;
	bh=Y/SgF6ItigDqjLcf85DykyReMmOGZlYFxEVznB+HBmI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c+ougTfVuiy8nyjvAM1+2QArgRG6AXfcd/NPg8BbAeiiZB72t4BDFbY3NiefCRfW2nPpPdGdPPIHOhxxKjMsaLFOyIVzlpv4uOLvZvFAM6DeN/wgwzMieM6dOM4QbSMkZEBtkvzeBrJY/RRUTAEEjgH7KGjsLp8jlc4UicV0g4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qTui1JCW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHYcyft0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKk3ao8eGgoRzZ3lnCXps17lYVWahMhm8Z5PwB6wqqI=;
	b=qTui1JCWB4NPagVO5wrDvRioMnr7Rb3FEoJIIu+6LOxu7kdZ5lWXlHjlxUj5WIPmAdKWQx
	qQ105uytcKDZyTE1N7MBlWvZ9nJeeB2fH+gq7KyTBdLuxqjEHh1+s5ACHq73vBHAzJ7cuO
	C+/eTLCtxVOuR6VPfjL2hbxBueskjXwtsCOczWkfd7nvZ50ZCPVix3qiviEisP3qssJ+PQ
	+Tnf7COG5KOn1/I+eRKR2lCFDxv8oV3hGi5UakfOH5Ce/s01F2h0PmVTu3CcSYPri2Aym6
	gaLjeJe4ASbp+NjemlqBSOk1O3OZtG3oTsHHxcFA+zLgr8jp49fRPQa5UqRxsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKk3ao8eGgoRzZ3lnCXps17lYVWahMhm8Z5PwB6wqqI=;
	b=BHYcyft0zdHIQ3ejlax7QvoKeAWRlpTAEEavMjsG+ETo5raAxMbLWbRLlT1Gd6I4UqIxFt
	YWP5s7VP2pseQYAg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Check if timers base is handled already
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-16-anna-maria@linutronix.de>
References: <20240221090548.36600-16-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192800.398.8318015316746640187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     89f01e10c99a5ca2ff88b545fad763d360cdbfc8
Gitweb:        https://git.kernel.org/tip/89f01e10c99a5ca2ff88b545fad763d360cdbfc8
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:32 +01:00

timers: Check if timers base is handled already

Due to the conversion of the NOHZ timer placement to a pull at expiry
time model, the per CPU timer bases with non pinned timers are no
longer handled only by the local CPU. In case a remote CPU already
expires the non pinned timers base of the local CPU, nothing more
needs to be done by the local CPU. A check at the begin of the expire
timers routine is required, because timer base lock is dropped before
executing the timer callback function.

This is a preparatory work, but has no functional impact right now.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-16-anna-maria@linutronix.de

---
 kernel/time/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 51053af..4420cdf 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2285,6 +2285,9 @@ static inline void __run_timers(struct timer_base *base)
 
 	lockdep_assert_held(&base->lock);
 
+	if (base->running_timer)
+		return;
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);

