Return-Path: <linux-kernel+bounces-40373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0083DF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B7A28A3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362DE1E88C;
	Fri, 26 Jan 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2Gm97MS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEq5gEWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264A1E874;
	Fri, 26 Jan 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287886; cv=none; b=mbSw3xniirBGljelhxJG48Y66xHndZmvsVbEqIRkXcmpfJETXGfZEyw1SJMlPomjWbaVjplsJW1KoE815SyLO44UKL2S5E2SYEP8SYj9/LYgyovKFa+yaXmpgwEVWHgF0zX42HxTWKz3quke+o83p64zB2AKNQtkqXliMpwHW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287886; c=relaxed/simple;
	bh=/PLgagZn9nOuTVK0PNZmw9Mm96mPvdJXqXG++W+3M44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s5L2PHJcR8JphSFPwaqwFDDf+Tkedc5aQ6TAUxwV1q+Lz9FLJO3PJeGA9AoSgYIYJytwDu+QUN40dF4uXMf15X3fPyiPBKAXNWyU6d3pG6xoARDm7R7u8gqZlOUn0zXYoO24rstqKmSFjhlhVdsilyOeLEJxBswNlCBpr+pBt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2Gm97MS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEq5gEWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 16:51:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706287882;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyEoPBNnkA+0kfiIvKmnK5SI/FCEFBFxu+ykIPEqzpU=;
	b=c2Gm97MSpYevqIFaweggMCjlZxaD52mJZVfSRjMGqqugWh9OFhFL0AIDsid4/nBaWhcaxq
	4YNAO95akq0NvVg0myxzbI/5LSGXqx3ad+m13j3gFKSBr7ZgoRbJCINa9vhJaMQVY1r64O
	6J5Dfw2OuVrwOHkklnZCXLRl6mZ9kTZag/sMVlYlMgn0wUtmXbnNElRnBgOPd5GkTVVTBJ
	8g1Yd1pox7unc9jPntEUctPCrOGFwPH3YupzQzZp257TyQBQREfKJ4S5d8bj1tHWirmMWK
	447lxg3sQkWh5OtkuU8i+vBMXhnrwynGA5TcLJCD3NptMbytFDbx3pJfq5k8Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706287882;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyEoPBNnkA+0kfiIvKmnK5SI/FCEFBFxu+ykIPEqzpU=;
	b=UEq5gEWckTp28+7XJT3a+SlpPGxox9cRmL12uTh5m+/f5o8OxfWQWc4RDk6dZSr31HFsc6
	d6iUHqC4sSDZGtDQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: smp/core] cpu/hotplug: Delete an extraneous kernel-doc description
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240114030615.30441-1-rdunlap@infradead.org>
References: <20240114030615.30441-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170628788139.398.3295669207179067546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     ef7e585bf48013baabc00de1a15753dd7b626a2d
Gitweb:        https://git.kernel.org/tip/ef7e585bf48013baabc00de1a15753dd7b626a2d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 13 Jan 2024 19:06:15 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 17:44:42 +01:00

cpu/hotplug: Delete an extraneous kernel-doc description

struct cpuhp_cpu_state has an extraneous kernel-doc comment for @cpu.
There is no struct member by that name, so remove the comment to
prevent the kernel-doc warning:

  kernel/cpu.c:85: warning: Excess struct member 'cpu' description in 'cpuhp_cpu_state'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240114030615.30441-1-rdunlap@infradead.org

---
 kernel/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba..f059375 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,7 +54,6 @@
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
- * @cpu:	CPU number
  * @node:	Remote CPU node; for multi-instance, do a
  *		single entry callback for install/remove
  * @last:	For multi-instance rollback, remember how far we got

