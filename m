Return-Path: <linux-kernel+bounces-70505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCFC8598C0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F6D281243
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0D73196;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0WIo/21";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxjV0DyE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6726F09D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282674; cv=none; b=qnyZrIxiFk1Ee5SAEc7/U1gR30f41FRWHrB/Kxi6H6ogBk6GeBW/o++N1ofFENYuKZuXJigqzd5a8gFrbZqpBvE8Hz+aBcAfi0DJkopO0QUsyYg6fOfDOFXN/yLLfGaMrbrVqgrn8WOYNp0Tqa78K5k/+beZmkxr5qGjk/ST9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282674; c=relaxed/simple;
	bh=dox9/szQb+26iWG6sdrMGBj/6N8EK08NBiaQoryJAZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osFYRAlJotSEBhvSR6sqKyFBv9FFvxL+CwHA1hAuV9zXpcGOjvyYn8oZ/479QXias97SZW+48reOMEo9PVaD573Emr7jFtwzEQZIpTmevAdsOTU5PBCFJkLLwEWbqHLDXiSM2m4WjaM7t163Nqe6w5+x92hMjHCEDe2mOgq1udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0WIo/21; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rxjV0DyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Do8ewsprPzBc28AvFoSgrf1uIwAex3sQdWFNrubJEIE=;
	b=n0WIo/21+og62Xcdgg4mHDaJ9aa+CTHp0s7sApg1zCrn4OCuWxR6QQMEbiCHvbb+dFMm1L
	V9FnWhjtHIeb1jcwhgPgzjnfISI4Du2Fid4OhSb5q5yRNHbxovscbdrlDAnyqtr5Ot/Dvz
	NoOrEmSD94iNw1Ij7asEVkJqyzuQoUkXKFubKBHBbASydUM5avhQSJ/lEmOZB48MPTkOww
	2fXOOOFQZuvDbsRED3yBvNqNo/77k7k+urNy+DhwMGutAIrdyj5z5wGiJ6uO7NrSrGnbmr
	hneukamflRKxXUyGNhrOISFNO4NJCHCVL46pWq55uSLBGxplRjEP6lnVlLUs1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Do8ewsprPzBc28AvFoSgrf1uIwAex3sQdWFNrubJEIE=;
	b=rxjV0DyEVlmUerI569cgyyqOJTLFr3BJW/IldEcccb31Wr3M+HzMoQYeQ7O44tY+agL9J3
	gl8yKmTbAJdauQDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 10/26] printk: nbcon: Fix kerneldoc for enums
Date: Sun, 18 Feb 2024 20:03:10 +0106
Message-Id: <20240218185726.1994771-11-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kerneldoc requires enums to be specified as such. Otherwise it is
interpreted as function documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 5c55faa013e8..d8922282efa1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -130,7 +130,7 @@ static inline int con_debug_leave(void)
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -211,7 +211,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
-- 
2.39.2


