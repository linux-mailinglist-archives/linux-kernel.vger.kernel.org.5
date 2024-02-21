Return-Path: <linux-kernel+bounces-75264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5085E56F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1481C2398E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025685646;
	Wed, 21 Feb 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EmT4lROT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwv1Qg+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052D85286;
	Wed, 21 Feb 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539683; cv=none; b=Q4jCviqqUWDiEuxhrxQHfT7UyAzElhZfDdb+ItuDbMMvYrX/xXpmZbrs0qOXT6BuQagZfWYW3lBmywlQOSnheT7gSm4p9fSXadJhoIGBISaSDmsTogmeaALQxCgWFaBJ91pJlJKXkjhWT0snPmbzqKlM+35Qm3zivpedYcSGTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539683; c=relaxed/simple;
	bh=rUuWhVTNtY+N+3k/2H3z84CAvmaTh4/RaqQ51S4F4MA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T74yhQWo9+jy2uu61v+OpE1Jm6aohMHyVCt4z+SbTN8HCgFDYHv1aviz2DH9VKwlBF3xY8JozoQFFxWhgmGpfj81+YWX/5qe9jOciQa+pA29uS+uSfftKoXCpHYmNLYR3l8bGxWtqlDnaDLxw24Ojz+4sH6kUDAw+KBsv87339c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EmT4lROT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwv1Qg+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 18:21:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708539679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuNFl3blakrH/7yQAxRYEYcMJlFbNzfht3aJk7PNNgs=;
	b=EmT4lROTStP7ZeIowyL5SK7gS8f2Vlc9J5bel33G3lRW9igJorv0apKBSB04ioxfwWz9yY
	ZxrDCW+WUD+AxPRZYIwRPHRZm2Y2KPTjWa23V8M7gLGD/CgCog86P8CtYArjomBmFgLqoD
	iwvLN6Z4y+D2g4FN3tveJG0pb6jd4poLq+bCOpGTJZok3WJycAqIuTLj/E8P5mNSV75zP2
	oX/NfWu8WVEpa+6+YQJA8AZIzXN1dghgjnbkO4IMVZ0CrWHysREJgqBymjRJd36GGfO5b7
	JpwKgenhC1fRzclveM8uspriIFsVCcorUAMHMnmSuu7rFVF/LgTUmlpP1FlmRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708539679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuNFl3blakrH/7yQAxRYEYcMJlFbNzfht3aJk7PNNgs=;
	b=zwv1Qg+J85XYDoX63d2lvHs6mlH4vbtL7iPPLGAwqQX+KeEdzK8sMEsZRgHde/CgnvnRCB
	7jYVi/r9byZEJDDQ==
From: "tip-bot2 for David Gow" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Use correct format specifier
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221092728.1281499-5-davidgow@google.com>
References: <20240221092728.1281499-5-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170853967893.398.2243431921138187436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
Gitweb:        https://git.kernel.org/tip/e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
Author:        David Gow <davidgow@google.com>
AuthorDate:    Wed, 21 Feb 2024 17:27:17 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Feb 2024 12:00:42 +01:00

time/kunit: Use correct format specifier

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240221092728.1281499-5-davidgow@google.com

---
 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index ca058c8..3e5d422 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);

