Return-Path: <linux-kernel+bounces-142633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A78A2E12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB04283EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE8B5789E;
	Fri, 12 Apr 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vv7KM8WQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGAIaIFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455C5731F;
	Fri, 12 Apr 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924133; cv=none; b=S4w3ox2Lg7LBIvhsUA7rsXMmzYfzNQyKUM2PzpfGHjUr3QSsQsEGW5+r3/2epBsuVHYNktO/r+ap+3UNzGKu5iw7g48bvWEG3bF0uf8UNLjoZq+LLPQc66ieF9kzJd3Cb4JJDcsy50s0BNJN96zTay9/5b9EI+Ux0loVv4DC3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924133; c=relaxed/simple;
	bh=nmNHb58EWI8oLDjXQIjOG1Wq8LmNik2S7FCEDWcM8tU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g/y6Dx5P7rgcGpZaPn4eSgRJtnM7cWMv+Dh64tv34QTti9ItF8P2G/dZwJ/rzpaV1kpWUo11g+mThcIP/LFWWrLdlFN1Uts2xcJC4ir9tlnP9uJKKy0eaKbtAfTG7lWDNvi7OwTeJ8zV1VZC7kZ9SMyyTb3bLJYuuoxQaQnj8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vv7KM8WQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGAIaIFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 12:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712924130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdC6iHt9iuIs2ZUHG+rVn8AHQ2/r2wQDI5UeskPFyL0=;
	b=Vv7KM8WQDfZvJF8dtJ43Vo4gDkUh8kF1L5W9ejTxFgkFzDCsk+KN3CQkYaGVZRAPpTZfLY
	ZADBcwumF5MlXL2L3gbh/dP2+Ah6XOjPoMnj4Ed7A2OonV6OJjXqHKdIiPtcd5zoOM/cUr
	MOaptZ1UEh+vMdS5wYJrPYl4ug3Mmlz2n2kvnqdEuZmztUU3qTZbvuNNUFE8uAJOBBmws2
	nTS3k2NJ7359FedklKpkuazflnVqKeGa3f+zmSba1ReewaMduiA5sNm9O78+59XNKACFvK
	QJmb+cne+2QtBOlxEmORL36ot3+3Ex86VHHOVF8KKU/lJBYcbU03LS8qyJ6Icw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712924130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdC6iHt9iuIs2ZUHG+rVn8AHQ2/r2wQDI5UeskPFyL0=;
	b=bGAIaIFgEeaXE0SP005INNs63sdee6ZcvDqKUmtNoHxt5Q6ggZR/f51ftbTJlFJcmbhd9V
	tx6shPcJC8OeneCQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests: timers: Fix posix_timers
 ksft_print_msg() warning
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Justin Stitt <justinstitt@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
References: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171292412916.10875.16404428821258401754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e4a6bceac98eba3c00e874892736b34ea5fdaca3
Gitweb:        https://git.kernel.org/tip/e4a6bceac98eba3c00e874892736b34ea5fdaca3
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Wed, 10 Apr 2024 16:26:28 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 14:11:15 +02:00

selftests: timers: Fix posix_timers ksft_print_msg() warning

After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
check_timer_distribution()") the following warning occurs when building
with an older gcc:

posix_timers.c:250:2: warning: format not a string literal and no format arguments [-Wformat-security]
  250 |  ksft_print_msg(errmsg);
      |  ^~~~~~~~~~~~~~

Fix this up by changing it to ksft_print_msg("%s", errmsg)

Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Justin Stitt <justinstitt@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240410232637.4135564-1-jstultz@google.com
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d86a0e0..348f471 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -247,7 +247,7 @@ static int check_timer_distribution(void)
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
 err:
-	ksft_print_msg(errmsg);
+	ksft_print_msg("%s", errmsg);
 	return -1;
 }
 

