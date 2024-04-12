Return-Path: <linux-kernel+bounces-142890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF348A31B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BDB21D88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC378146D68;
	Fri, 12 Apr 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOscJ6AD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTIfSCx/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB9143899;
	Fri, 12 Apr 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933940; cv=none; b=T6Ln9/uAw76TBd1ifW5abfT09NzDhbHn53Lo+xovu9v8peytZdviYYBtoiggvj2dBAWSrRdubF1+OyD5htJAdpW2RYn7qzPjUW7/1CHv2ZrZohnTvSpIVlrodR7tAxqIhL0khRqU7QaiStnn8gWfkmBBwZljnboFyHu0Pb73k+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933940; c=relaxed/simple;
	bh=CSjVEpwxyOzY0Yk3BwD1xzaHqhoL+fSMwcHHunVAufU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O0WnqGlKGSNJtDlmiAOy8w55+g6akGsNTgyluqI1n9venO2iyE0AyiqTI5iCSLyNd6VFc2chcE1xfrhFownJ/6yVUiR1INKYDLuRFdUTr/MLMkRlpP1RXs4XgZBDCL+c7dRPW4sqJPyordzgkmhCyUiDvPBiwFiHccNOCih4OK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOscJ6AD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YTIfSCx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 14:58:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712933937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+sb4T77vVIISGAAkhvDFJJ9IEKWyr1iK5aWNGNgcOg=;
	b=OOscJ6ADedhoWa57bOqk8ifmCsbQ79JOmTjhEB1E4K4V4SRreD09I0ton/+6K17PIigScD
	wToR0Ir+1im4upZ85TNqlZvDlpq1IBaWdw6hN6t4/h8nmRLEchliluFtfh7x1uB4NtBHQu
	KLXeebV8FUj7HDAdgxFQNY5zEVXFmn4Py64ro0n4zojoKtk7B7HYSkSW3AZYDA9nCXklqe
	Wg8qLeHH4fUtNCr8ZNXefSHPErXC9dxI9acoI7n+DJgyUqsjbqKOI9f/P+D2aSAIjdGrcl
	dAEd4WvShg8dnhwvHw+AbOcjN7xLblDcqXrWyHc01AIEY8opmd66/mu+FxNV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712933937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+sb4T77vVIISGAAkhvDFJJ9IEKWyr1iK5aWNGNgcOg=;
	b=YTIfSCx/9+OKD8j8LwEFNPMFt5WcC54mzsNk1VxSNm4FODbSpCCKcl9mkZ+HDWopyxIzz6
	egxF3t5WSjPVhgCw==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] selftests: kselftest: Fix build failure with NOLIBC
Cc: Mark Brown <broonie@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412123536.GA32444@redhat.com>
References: <20240412123536.GA32444@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171293393654.10875.10737366810353639391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     16767502aa990cca2cb7d1372b31d328c4c85b40
Gitweb:        https://git.kernel.org/tip/16767502aa990cca2cb7d1372b31d328c4c85b40
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Fri, 12 Apr 2024 14:35:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 16:55:00 +02:00

selftests: kselftest: Fix build failure with NOLIBC

As Mark explains ksft_min_kernel_version() can't be compiled with nolibc,
it doesn't implement uname().

Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240412123536.GA32444@redhat.com
Closes: https://lore.kernel.org/all/f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk/
---
 tools/testing/selftests/kselftest.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0591974..7b89362 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -395,6 +395,10 @@ static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
+#ifdef NOLIBC
+	ksft_print_msg("NOLIBC: Can't check kernel version: Function not implemented\n");
+	return 0;
+#else
 	unsigned int major, minor;
 	struct utsname info;
 
@@ -402,6 +406,7 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
 		ksft_exit_fail_msg("Can't parse kernel version\n");
 
 	return major > min_major || (major == min_major && minor >= min_minor);
+#endif
 }
 
 #endif /* __KSELFTEST_H */

