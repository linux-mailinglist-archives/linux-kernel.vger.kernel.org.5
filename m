Return-Path: <linux-kernel+bounces-82392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960486839F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD361C24768
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D931339AD;
	Mon, 26 Feb 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XM7puit8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Deb2fBd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D0133417;
	Mon, 26 Feb 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986277; cv=none; b=llW1DY98+SE/6jCax0MyyyNKtzzR5mWgJgiwF0d3nL5dtX+vOQF/nEb3nvZf/6kzGx9o7iRnJ4G5Z+MfPZ1H1i0s5jkXPuG9U8QYEDv2C5NJ8PaJnGLCDLj2ALbq1tx7wKlnZjjFisvo8cByv4pFjlioeJvNG1ce4TqIqc118UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986277; c=relaxed/simple;
	bh=0DolrdCThru8iBJGFDW09pdN3p4sNRZts6fqmyfWjt0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DPNbQ1aI8wrqAd5+5NE2IRuhwIIHiiCxFpTkq0U84TFvqBPtF5xv7inrkwLWRxgyObDS1HnfQzUFv1RUcsvwjvw8cnxK3WY6cEt1ksJ7ll5l4KI33H0UxEOWih3dFQvO2wQoXQkbe9lufe6iPhPFB4UFrklImmccG4I5jfGatQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XM7puit8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Deb2fBd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osppYSeV2iCM6IzfY8UpKz76QA26duWZkibTc/Re4NE=;
	b=XM7puit8Cy/IfBtAUlsQirXA9H8MYrohLdUCUPc2TJfNJPnNVXYsuEN8TfpjWKTACwKEpY
	AefEnWCa9VI22y7tFMBNBmKrOEthLjMlF9wOou+guAy2ytgEsFRcNmYo5tgmiFKzB7jZ4f
	jqsKn5MFw5oS1fB2acpicbcjZFCefZg8Jb9YLlIJwvJJp8celDGXQm6Gim6g4oITyD8bE9
	GTT2AJ4Ex/HJGkoSzkGgqftRw3ogJZDERo2t/ZKGCLlkZGxFxSGDvbHlg0wEm0NeN6E/QI
	gEJ6GV8kfEGZXJdRF3VnzUq1a2kXwe3X4Miq6HZYr30Osp8HYsGngWMjrrwzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osppYSeV2iCM6IzfY8UpKz76QA26duWZkibTc/Re4NE=;
	b=3Deb2fBdY1PlZOH6dyNKjkS2dDTsSd00HPxuE6khB1F6XBCgoHiaapu/EepmJ2vLWEUHPr
	UKMVNsP3ZF6rQ4AA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Assume the tick can't be stopped in
 NOHZ_MODE_INACTIVE mode
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-11-frederic@kernel.org>
References: <20240225225508.11587-11-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627305.398.18387562439235037420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d9b1865c86aec7c515db5718e4820106c2c12db3
Gitweb:        https://git.kernel.org/tip/d9b1865c86aec7c515db5718e4820106c2c12db3
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode

The full-nohz update function checks if the nohz mode is active before
proceeding. It considers one exception though: if the tick is already
stopped even though the nohz mode is inactive, it still moves on in
order to update/restart the tick if needed.

However in order for the tick to be stopped, the nohz_mode has to be
either NOHZ_MODE_LOWRES or NOHZ_MODE_HIGHRES. Therefore it doesn't make
sense to test if the tick is stopped before verifying NOHZ_MODE_INACTIVE
mode.

Remove the needless related condition.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-11-frederic@kernel.org

---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b17895d..b79f540 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1086,7 +1086,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+	if (ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
 	__tick_nohz_full_update_tick(ts, ktime_get());

