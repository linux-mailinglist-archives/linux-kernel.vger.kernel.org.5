Return-Path: <linux-kernel+bounces-81323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFF867436
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569071F2E185
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4E15B1FC;
	Mon, 26 Feb 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQcV0big";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NficySbP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E01DA5F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948915; cv=none; b=RVAfFw7V7otsGPHvk2GRIyLCAMP5wZ/VwjEaHz89HpR+sdP1u8dUSoRvYcU//nWgjeJiC0zdE6Lej6lw+SeNRTr82aogw2Td7pEAv2uphIKYox+RpU0532EcLwxIq7MsjDvPCkCN4b371xizsx8j+FGbonglcmSoE9F3zN2JN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948915; c=relaxed/simple;
	bh=n6cj64Or9PbJgGcoTFOmTwi8YEiwtQFw0GN6ev3weiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cADsCl0yOBgosZOUEkoDDXVfak0ujywRcDn0+9dpYMHdMt1y/Z2gUrCcvy9sWE3F9K9pDKBax+ImD0ZyWlW/cjm8wBXIjHeVLxpKBih+sdsLd67oS50YqzOXHtvojXX8bZKWFxh/IRHzaDnAIfdwtoHC/gzT7hD3VEX+QNhTJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQcV0big; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NficySbP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708948912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssDX0tZ9H4aDFqTnUDa/YmbnpDQsXNRYjqJeEeUC+QE=;
	b=WQcV0biglPoBwnOItFsCWzHjvUl/N1wVCLQ5nLY9wqZ1XR2725+jHwPkHXinEzxQQ99pYX
	+sTn8tsf2SJRctmOnAANkkqHRakTEodjojHB0re/Uae21skTs9c6bD4W+9Z0RBiD663x9J
	tg1jLIgR8PlyjydI0vq4pMOYrJoXEgHzC+Obqrezs8KAHEbAaF1R8VTWCg1jjRZRdPaGBE
	McFYZTBWyXvaUBvTQznd9vEZz2zA95yUCPysb9dywex2vf9A5X5njTE3xQ5zkfA9B9vXDI
	Ks6xEwuvh86Ye5CM9MD249m3C4Y1qX9wElppfHozxFVm7zoYMlBpY2vZ2UVYlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708948912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssDX0tZ9H4aDFqTnUDa/YmbnpDQsXNRYjqJeEeUC+QE=;
	b=NficySbPs2/2+86UeilOXLw3LS+2zvXSEFsOG1gj3oGHWghV+YG4FqrrR+scflwoR/R644
	FCHoSf3RhRG4EUAA==
To: Mukesh Ojha <quic_mojha@quicinc.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Update @console_may_schedule in
 console_trylock_spinning()
In-Reply-To: <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
References: <20240222090538.23017-1-quic_mojha@quicinc.com>
 <87plwo5z4k.fsf@jogness.linutronix.de>
 <e5474801-53c1-6bbb-8781-e5cee42d6a90@quicinc.com>
Date: Mon, 26 Feb 2024 13:07:24 +0106
Message-ID: <875xybmo2z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

console_trylock_spinning() may takeover the console lock from a
schedulable context. Update @console_may_schedule to make sure it
reflects a trylock acquire.

Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@quicinc.com
Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1685a71f3f71..1612b50b2374 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2020,6 +2020,12 @@ static int console_trylock_spinning(void)
 	 */
 	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
 
+	/*
+	 * Update @console_may_schedule for trylock because the previous
+	 * owner may have been schedulable.
+	 */
+	console_may_schedule = 0;
+
 	return 1;
 }
 

base-commit: e7081d5a9d976b84f61f497316d7c940a4a2e67a
-- 
2.30.2

