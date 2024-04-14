Return-Path: <linux-kernel+bounces-135533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22EB89C745
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D4C1C21D28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAD13EFF3;
	Mon,  8 Apr 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJvj7XPN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5hWglGe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E113E8A5;
	Mon,  8 Apr 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587288; cv=none; b=p/R5p8NtCAf0SWEyvvC4JIUA8S2M1LtyUlVHXOXZzCx2ZSgmLSFoB0+yRATiV6AO8Ffma4R6Qurkc0El1Oj88CFbwlTAajm0cZM6CGy9v/nAecB03kEhjPazbp9i6OHmllz9pMcI1mb3Jdv8QHXt4Kbb81JTqjlrTOi1O4wR6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587288; c=relaxed/simple;
	bh=wGLCl0UtKRYyeiLABxCw182vgu+6IzM/i6MltoJlpjM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LFvdEQ60Oh2mYsBvBd7OCoBVjkCYaFfhdxZr2Irhv2gDXrZ8bhtykHFq7V2AbGYTcenAZT5FdOcSgshoDMrAbMqzXjFs26Jm3oVAOsqT6rt9CEwJRwZ6X/eApm39Ii4Sj/9p+SJqJbBJ6bJPqWQa74kctXyHuF5Pi0kO0j+cSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJvj7XPN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5hWglGe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 14:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712587285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0Jncqt8D3n+3eK13S2Wr0ZgD2itn9OYxVF/OOG1ric=;
	b=FJvj7XPN+tdj76wnRLLFSgCIg8Ulvm2O+O8xWDk1YyJh/Bthy+ta2+frwkbg0TUsdUrvPi
	yIhUkVKPusErEKgI0O7wgZyhyYO0oLHgTn+GvVHdXFRVv56Sv6cKWi4ESWp9M/31OV40DC
	fOtvzBIUKndNxJUdh8i19Gq55TO85jMhYsKhoJADnMOluVxxTpYNkHhI5M+gowKoywrWMC
	L6Gdyb/MGpTFl5QkxzwyqbvD71emdBV4uvphWG8GFBDB40hxyIu5/qAG3QJTwVUqL22/H6
	gBkk8ZcAFRI8z6/drTyx+MhNEph8cjJTkivtSAxPRGveRZJkqCHh+xJzS5k3ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712587285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0Jncqt8D3n+3eK13S2Wr0ZgD2itn9OYxVF/OOG1ric=;
	b=o5hWglGexCXouQimqVgyoNiVGf0SPgq4iQNy2+vH/r7uA7GpgKrarDyqq3hQa2+fhClToc
	J7K95O1LNICNOhDg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] irqflags: Explicitly ignore
 lockdep_hrtimer_exit() argument
Cc: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408074609.3170807-1-arnd@kernel.org>
References: <20240408074609.3170807-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258728424.10875.1653913152123120483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c1d11fc2c8320871b40730991071dd0a0b405bc8
Gitweb:        https://git.kernel.org/tip/c1d11fc2c8320871b40730991071dd0a0b405bc8
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 08 Apr 2024 09:46:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 16:34:18 +02:00

irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

When building with 'make W=1' but CONFIG_TRACE_IRQFLAGS=n, the
unused argument to lockdep_hrtimer_exit() causes a warning:

kernel/time/hrtimer.c:1655:14: error: variable 'expires_in_hardirq' set but not used [-Werror=unused-but-set-variable]

This is intentional behavior, so add a cast to void to shut up the warning.

Fixes: 73d20564e0dc ("hrtimer: Don't dereference the hrtimer pointer after the callback")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240408074609.3170807-1-arnd@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202311191229.55QXHVc6-lkp@intel.com/
---
 include/linux/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 147feeb..3f003d5 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -114,7 +114,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)

