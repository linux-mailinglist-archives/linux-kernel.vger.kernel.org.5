Return-Path: <linux-kernel+bounces-71686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872885A905
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9891C2178F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC793CF4E;
	Mon, 19 Feb 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAhslH5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7fWOQ432"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BA3FB21;
	Mon, 19 Feb 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360519; cv=none; b=QRp6k1AfntkwYpM/u7F3PC0di5pY7ilGY9wvULQI/7TGLsJBC19S6Klsyyvkd+mDNuSxJ6CrquMmjCOzCItsVNDlXgj/g1WdQhfWPRvs8J2rdh+mmz4Y2xnnyIPnJwGNXbD9cz2moxrxotDgcJIXHEWag/nBKHBGSyPgLnN79qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360519; c=relaxed/simple;
	bh=Idw1vDDtc6dcTHvMpbTfp8KxEfRv/UVvvHnfEt4KQ0Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OI+qS8l1hhl/I4tt2qYYe3tD5hdW+kQ2yMk6zh4xiRNyIIEDQYACfMJXOge+R31yOiQlcbDHdffmg+w8fCzZQXrbees5hPr+5sqk3Vdbm2o7ie2kJFJPR+xlc8V9xiouW8la7L9lI7SCnwJbbuSrjxS6C9U2Ra3h23IL1F1u5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAhslH5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7fWOQ432; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 16:35:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708360516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hR2ba7cr0Kap8YHhF1/mw/Ks29O4RybZ9BPUoZmrFYk=;
	b=nAhslH5E1ql+w5f3S5nII6zTIQgHnyDDv7rM2k+m1kMUDL9C4RP1HTyybeKl4NhcYK69Gs
	30m8iwUl0T8uh26IfHRugC9TAi2uIU8IvBG6QUfmS4gmvqK2LH2Tch+tQYtSZ6kppiASoQ
	o8igw8Is2VKyyqH8S9daDHoCiVZl4IfZOdXccPXQTrw6usarNm1NN0vYSUKGHD03CCDCq9
	UfcEZIGrB5cyjyZrjnv/GNUH70IoJ5kt+/19GaHM9yGy/pnJU9EpPnRrS0G06oWyDNKA8V
	884D5Vms08IMnsL3pxZNfZjC2ATEUCHgvX2zTz4eU3HzHzTdKzvwIuNGOrgDNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708360516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hR2ba7cr0Kap8YHhF1/mw/Ks29O4RybZ9BPUoZmrFYk=;
	b=7fWOQ432qxMIkgAdXXgE7sxmHtZR4wKWksi5gew5kAEpYHmQOVemtAdVimNILyO/p8s1dl
	puZVpQHl7ycickBQ==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Fix cross-timestamp interpolation for non-x86
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218073849.35294-4-peter.hilber@opensynergy.com>
References: <20231218073849.35294-4-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836051538.398.6736189078796081366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     14274d0bd31b4debf28284604589f596ad2e99f2
Gitweb:        https://git.kernel.org/tip/14274d0bd31b4debf28284604589f596ad2e99f2
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Mon, 18 Dec 2023 08:38:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 12:18:51 +01:00

timekeeping: Fix cross-timestamp interpolation for non-x86

So far, get_device_system_crosststamp() unconditionally passes
system_counterval.cycles to timekeeping_cycles_to_ns(). But when
interpolating system time (do_interp == true), system_counterval.cycles is
before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
expectations.

On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
and xtstamp->sys_realtime are then set to the last update time, as
implicitly expected by adjust_historical_crosststamp(). On other
architectures, the resulting nonsense xtstamp->sys_monoraw and
xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
adjust_historical_crosststamp().

Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
the last update time when interpolating, by using the local variable
"cycles". The local variable already has the right value when
interpolating, unlike system_counterval.cycles.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20231218073849.35294-4-peter.hilber@opensynergy.com

---
 kernel/time/timekeeping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e9f2f8..8aab7ed 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1261,10 +1261,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);

