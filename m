Return-Path: <linux-kernel+bounces-139464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFE8A0398
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2703F283D24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE3481CD;
	Wed, 10 Apr 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1XIAc5i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBNNpa/c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB947A55
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789195; cv=none; b=IvYGXJliPSfGBgNb+uiohsbhF/tBH/onmUbQM6sPYx8vykrB8UMXNZrauGummfgY27htD55Fx+YqXzqKEHiU5pF/buT7AQ0WWeBNZdPcjli4YbRVoW9Pot/tu0JcT10yvwbA8OphX9hn2c4rARBrO7dUmv0P5lTmScDtfK/czPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789195; c=relaxed/simple;
	bh=ELAaPaGkJq6p3gTMdWaH/+B64HkzxUph4WcIXAbdkUg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sW+FWeWGQBGScwdZUr3CNDEsQG9ybJVFO8lwDXIPzbih1AGEGvWILwqJ+qLENOWVPH4uir5cuNXp5gBmVyW0O1Cl0QJFuYVCnftGtOiLMkOK/b7EDdOSRw/cspg5bC+MW2F008Jqe9QJjmlGTnjLA7LBdgWC6svmwA05j1rqvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1XIAc5i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBNNpa/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.635345704@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=amj9rEI4omA2o9SPkzdGtXDAK0TjsBjy30f0aomhQz0=;
	b=X1XIAc5ij2T1DenkME9geSLVZ5+2chgjOLrHVCBPgXDu1pbdO6nF4K7Yd63o7BoELiiuqa
	I1Gtiuykz8zstGf10d0kLon2yKIQFSBmM2l2mcoma0pXmgCVi7EbGrBfawvL84DvTKIk0u
	8YCPC25TYGpnSOLProlR/fEXpmC75DALdryHs+tnCTlaoVE+q6HhWLz5cnLDHkm5RcY3Z4
	H4AAl3sXCzp7j711VgjxheNh35sX08s4FXFYrYRFNgkxyD6yhXvYhXlpdL2+Yh27IgX2v7
	E5wtHysFQaWPD6YfdkCfDqISXa/gy+8R05c+WY+fZtqJwi6LLDbTb4zdPrv7CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=amj9rEI4omA2o9SPkzdGtXDAK0TjsBjy30f0aomhQz0=;
	b=RBNNpa/c5LCQEjTTy+WVRDmuoswkLSi6v/fibcAYXPq/f/PWBE9oNctbolPglNeip7xT8Y
	BLhS5ggEoKVX8PCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 11/50] posix-cpu-timers: Handle SIGEV_NONE timers correctly
 in timer_set()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:31 +0200 (CEST)

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

This will be cleaned up in a follow up patch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -706,7 +706,16 @@ static int posix_cpu_timer_set(struct k_
 				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
-				old->it_value.tv_nsec = 1;
+				/*
+				 * A single shot SIGEV_NONE timer must return 0, when it is
+				 * expired! Timers which have a real signal delivery mode
+				 * must return a remaining time greater than 0 because the
+				 * signal has not yet been delivered.
+				 */
+				if (sigev_none)
+					old->it_value.tv_nsec = 0;
+				else
+					old->it_value.tv_nsec = 1;
 				old->it_value.tv_sec = 0;
 			}
 		}


