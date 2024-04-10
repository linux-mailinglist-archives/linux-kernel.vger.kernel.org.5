Return-Path: <linux-kernel+bounces-139468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E558A039C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A526F1F25B06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E984E1D5;
	Wed, 10 Apr 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2STrY0D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5ggaPAH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81A4D58E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789202; cv=none; b=oNiBew9yxB97TiucGAlH8qoVspee9Ql+T9mb3ugGITUX5nwjtDSusrRYTeFlZ+hxxLl024hRe1Pf7wTPDCnoqQmqfYofr5si2Ku08nvgSZYZr39iFlqiUs9i8/Bi0LciF9HZUKqbEqSrin7Feqyxf/QlYt4xFmqSep2jsfcB3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789202; c=relaxed/simple;
	bh=dqa4y3Sy5EE+IYLFY+hDqiZngky6H6vw41xP99gkF3Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eDSUhJJVUnOdnMmHamtCazFSzLmgHosGiRBRo6bn4/zLgL75qIILKXGwk295lOQ9Guxr79QnjVWAkguAVxIA5GZCJ87w6eV8PSKtos90kFsaD/uafhHsX6FD8+Twwb6gpWo/gzur6e72OC8F2Ug15FM1vHP5QVYXC70xLhZGyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2STrY0D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5ggaPAH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.881137309@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4hHoBY9MrEXBowGP0DzQQAtC7OGDF1Jxkr/5VDlxgmk=;
	b=N2STrY0Dwm2Mv5xsMFM/qy1ueCHSxZo6g49pE4uzGHGWWRNPY/FOupisQimKKzAFxsLfXv
	yCSH8TTkyTcmV9KVpv8+3RY03uZPiHFk/HY3k00cGQkyaZkOlFrtJYUfExlkfWpA52+9Dl
	9mpUjr6i2VuCWwaurhfUsRgD04jPFO+/dw4KCmff5kcVPKzfycqja5te8hLJKXLx2iQcQn
	JfiG/9J1cn6rTEWatb/KsImn+ZyJSb6vLbpyHaSuCRauFb1u7hqlPJ3yQOBSmRdC8BYXK1
	bxesIYyvgUJ9CF83uw77EMbCo1QLvrxKN1k75F8/Hg/6jSN5VQgnz9z/e4vs2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4hHoBY9MrEXBowGP0DzQQAtC7OGDF1Jxkr/5VDlxgmk=;
	b=X5ggaPAHzS4RVSwb2VElGPi4Oa+EfCt/7GP8daM3Yeb7m67qmJrsPjntYCqWbo/LO3BPnw
	qBb2q/R2hTROa9Cw==
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
Subject: [patch V2 15/50] posix-cpu-timers: Remove incorrect comment in
 posix_cpu_timer_set()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:38 +0200 (CEST)

A leftover from historical code which describes fiction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -689,13 +689,8 @@ static int posix_cpu_timer_set(struct k_
 			__posix_cpu_timer_get(timer, old, now);
 	}
 
+	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
-		/*
-		 * We are colliding with the timer actually firing.
-		 * Punt after filling in the timer's old value, and
-		 * disable this firing since we are already reporting
-		 * it as an overrun (thanks to bump_cpu_timer above).
-		 */
 		unlock_task_sighand(p, &flags);
 		goto out;
 	}


