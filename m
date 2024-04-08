Return-Path: <linux-kernel+bounces-135396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6889C0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE502281D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65F7E79F;
	Mon,  8 Apr 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ibDjSMA/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="421ueKpJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88907D3F8;
	Mon,  8 Apr 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581841; cv=none; b=DedyiUrZh7c2xkVlxZgMfcVeoKkxUUE7GMGDGhBKz7Ue9TQkyNVbA06EwsiBHMelH90bI7Qd7+ltFoA4LiI8S6PAvsoSlZ/DWA9EwPXXu1FCnBTlQSlalnlZCiSLGCcnNwlzynAuUaEKX/jAr0ThVRCZ+P3WIf2ViaACBmHCHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581841; c=relaxed/simple;
	bh=Pi880dGBhxu7vJl2+RrVrYbf2Fl06alPAw4yJ/1n5NY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q65CcHj2uZODBPbfscYiL5FSC9eoZc3arJzGm8dEOZC3JQqVz0pTFRo5djR9D4aqzPORQUQ6A6FrTy8XnClObXUeV/lXjsudaf6CQAqR+16rnMuiolII2sWbdgq4MzYH64Ziy83GI1upu/sWovQ5mMP5qZUQA0hRm+6Um8/4AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ibDjSMA/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=421ueKpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSQlc40Xhzc0Q5Xm3VZYWKci9+yMgajPnTVQ4nYWqdw=;
	b=ibDjSMA/XsJ4yONWuXR/6fT5EAgkGJK9jVoabDLHpNhgTMyehlgOZXix7P/aDseyseC4BZ
	VJoMUH7mzIQ3D3yb30FUnT7R5lOFxaiTjQ822Eq6BIHW56kjd3RVt7QBRZbVvICIdslUFR
	ZExVlQW8fm2/IIUKZW3R0BLQ1bdk5MBRB6uG/txuPZ0fFq15xLqNgBGnnoJJEPhTGkWJ6z
	c8fStS69mcT4Dx5zvXETj+LIV+ZmVzHqVjvU4KjjBKN4gKw5+QaezjFC3ICYhtY3DHwWRO
	eDkFqwrUffgiHDQVEmtzsLEyATO6P1nt691Ca0l/4iz7oF7yNwjHYDTEFna5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSQlc40Xhzc0Q5Xm3VZYWKci9+yMgajPnTVQ4nYWqdw=;
	b=421ueKpJhCvNo4QsdVjcUCg8Y4hdkDXpBlG3x7JG2OwBhQL67vTRHtDrPR1AdKg2homJsd
	DmKowmxMbrZbF0Bg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Tidy timekeeping_cycles_to_ns() slightly
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-12-adrian.hunter@intel.com>
References: <20240325064023.2997-12-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183726.10875.5466675565970105553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9af4548e828aa2ea66f54433c5747f64124a6240
Gitweb:        https://git.kernel.org/tip/9af4548e828aa2ea66f54433c5747f64124a6240
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

timekeeping: Tidy timekeeping_cycles_to_ns() slightly

Put together declaration and initialization of the local variable 'delta'.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-12-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6306133..c698219 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -383,10 +383,9 @@ static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 de
 
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
-	u64 delta;
+	/* Calculate the delta since the last update_wall_time() */
+	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 
-	/* calculate the delta since the last update_wall_time */
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 

