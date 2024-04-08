Return-Path: <linux-kernel+bounces-135395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D489C0C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01091F22864
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CD7E582;
	Mon,  8 Apr 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da7LCIbQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4AhzBT8V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C97D07E;
	Mon,  8 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581840; cv=none; b=cgPvXqGmW68PfoGt+xgGaKWmxM1eXxDEGL9J21MBNqFqQrqLTwAsutJcYnEbyn+h8jKqaWf8V73A3o70MOEbw2b/W6TP7V5Lt+bMrtnFp43HHeMxA2R0SD6Kc0PsM1n4tkJLPkk3jU8sTwudSTmwt4kKadrv+W60iLYe1Ae6Tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581840; c=relaxed/simple;
	bh=kSnLefbdSybkZDE9MP83jDaVt0zb0bg/epwVRbzZSR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tBvU4mhIjO4jWkTQDLkJlSfHZLZkDLUORfFk5hdTtokcrRBFV6KA9OTLyKIpdsDYUctGuWIHrWOWMysz8j4djGPaAJyUFxSzQ6N2m5O4WmHSHT9+QBi3wipDom/ehqWrTCsUY5qRScfJVFEHCcTt689gZlkmGUDaPkUgyQuwzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da7LCIbQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4AhzBT8V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=204ZtOTp1RALeXoxS4RBs5bsIWWmf3jQABMdJQY0++0=;
	b=da7LCIbQFB9YoQ3ztY6CXNLpEfc6dmHNAJt11/KXyP/pLw50TX0H5HcZ8YzseHONkCpHvc
	aQ/rol/Nz+waoRaSlWpncs8Rj3FlEl7nZXDL1KPJPpjx1iO/wVdFtyTWl9dB4+jLZ+JPlU
	KVqrvH6lyt5+/O3ytq5Re1aJ9dS9GjLNhdxK7yu0YvKBzFnMEV8Bu+G6I+UccRTt7B77BL
	C1++3APa/+hnItLAflYbTrD9KiSF5AFX7TvbgLAlQJCGOlYxDNZ3in9SF+4Cv03skdCHcj
	B7mA1BY+lHhZxChdJUDGDKp3w3M4FsplIoRpTw6k2CG4RqNPMdLqygt3woADww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=204ZtOTp1RALeXoxS4RBs5bsIWWmf3jQABMdJQY0++0=;
	b=4AhzBT8VVBOnyzCU8Rw3C3ehVqT/d3++aj0wbfyc1DIOnGJSm70x78acInHy9L69/vM7St
	/iJTbaPFa/CRHrBw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Reuse timekeeping_cycles_to_ns()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-13-adrian.hunter@intel.com>
References: <20240325064023.2997-13-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183651.10875.6600827840164313874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     670be12ba8f5d20ee2fb0531be6977005cd62401
Gitweb:        https://git.kernel.org/tip/670be12ba8f5d20ee2fb0531be6977005cd62401
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

timekeeping: Reuse timekeeping_cycles_to_ns()

Simplify __timekeeping_get_ns() by reusing timekeeping_cycles_to_ns().

No functional change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-13-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c698219..f81d675 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -391,10 +391,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 
 static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 {
-	u64 delta, cycles = tk_clock_read(tkr);
-
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
 
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)

