Return-Path: <linux-kernel+bounces-100208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DE87938B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695A51F216E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C07AE7C;
	Tue, 12 Mar 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43Kf20VD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="twbct22t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC67A709;
	Tue, 12 Mar 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244826; cv=none; b=KJXZAPlVjs654kmKVecz1mW1iHkSyOpVZm6LN8C0yf5bjX20Licfh1Q7FWQhXkl+2JyQy8boNOcnKONzbW0lhma+qjNqiIolKCMfi8gN7bLU8h56yldxl/Ia0JDM5pYUa+/3bEEDzFhe86kj3EFjCiT/7RaXtpwlYJSWCZCZB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244826; c=relaxed/simple;
	bh=ZlfcN/ofZauMrFg+DtftuTt2hEK7saBtIUr9emtu9Xg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B7PEUcz/Kb6C0OhHKTLXCH59EUGi31RB91ENynSgKWYlpKCTeQ1TZiwsrFDbfU7YjjoXJy/4gJxajUQtJ307b6Db+zdEJJIUYeOXG4XDIOy7U1ZB4dSDOs8NIqpEy14JDXJUY2pRIVsP+m6eaNizrnZ+0YC1yGtLumzw9a1MpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43Kf20VD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=twbct22t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wngTxSdXH8J+W8QlLSDTZ0AYdzIkKxUr46ZVsVxPlYU=;
	b=43Kf20VDb9XQOY47ZiZ/rgeYCtyX15loRcbBRj7XwHDEicS3N9HpVOypGU/JJOGvCfVdKh
	e6O8p3pg6fZnj15hrsoHAOc03b8xkgevc07STYAUXXvlTk7ZBdPd21CaP1osCaPGHToOeU
	7xMaxBaiGo1eoPmW2CHsP8vAiPSkFGz0jmPFM9KVInP5VQp1uUKs5Qbh6vaVBYcB9a08LU
	xNqyi9BFDQFQunuGOEov5prm1os9N2oeFk+YbrY77CGnGNn7JHtsekGmcVAwrBJRZ/vk1h
	0FQCPaoW/Zr0YYAX2xmRAYg830om2K7ELWlMrI/VZdJj3ayEY/UE+7Gbc4QEnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wngTxSdXH8J+W8QlLSDTZ0AYdzIkKxUr46ZVsVxPlYU=;
	b=twbct22tbVkjedRMgU8+VMVPqvBuB49Ge4i9t6KhfHxGWFO3iim/MbepTsGbhM2PwY1gPI
	aTV9302Q9oWuZVDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename find_busiest_queue() =>
 sched_balance_find_src_rq()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-7-mingo@kernel.org>
References: <20240308111819.1101550-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482255.398.17932333906741351556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f1cd2e2e79d283e315356bd403c7f928e994f057
Gitweb:        https://git.kernel.org/tip/f1cd2e2e79d283e315356bd403c7f928e994f057
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 23 Oct 2023 13:04:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename find_busiest_queue() => sched_balance_find_src_rq()

The find_busiest_queue() naming has two small quirks:

 - Scheduler functions that deal with runqueues usually have a rq_ prefix
   or _rq postfix, but this function has neither.

 - Plus the 'busiest' qualifier to this function was historically
   correct, but has become somewhat of a misnomer: in quite a few
   cases we will not pick the busiest runqueue - but the best
   (possible) runqueue we can balance tasks from. So name it a
   bit more neutrally, similar to the 'src/dst' nomenclature
   we are already using when moving tasks between runqueues.

To fix both quirks, and to standardize scheduler load-balancing
function names on the sched_balance_() prefix, rename the
function to sched_balance_find_src_rq().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-7-mingo@kernel.org
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d2753c..1cd9a18 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10959,9 +10959,9 @@ out_balanced:
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue among the CPUs in the group.
+ * sched_balance_find_src_rq - find the busiest runqueue among the CPUs in the group.
  */
-static struct rq *find_busiest_queue(struct lb_env *env,
+static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 				     struct sched_group *group)
 {
 	struct rq *busiest = NULL, *rq;
@@ -11280,7 +11280,7 @@ redo:
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(&env, group);
+	busiest = sched_balance_find_src_rq(&env, group);
 	if (!busiest) {
 		schedstat_inc(sd->lb_nobusyq[idle]);
 		goto out_balanced;

