Return-Path: <linux-kernel+bounces-82441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53C86849E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D74B1C219F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F09135A71;
	Mon, 26 Feb 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UBjxsy7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkbR+21V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16A60864;
	Mon, 26 Feb 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708990306; cv=none; b=XfTGiHp2Z/PD0m4dy+8NpdvEo5hvDn1LR9UZSx+quOYTWVYIKeqC8mLRVPz5ugHeZ8ZHtpmFBoTpmsQPFtbeG6NttcJ/n5BBItnFLG1SofxK5OoQn5izIQGJZVEpzcGn0pImwyz/QgApEfYbwyqiIa6OEfIlkfBHesG/nzO9Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708990306; c=relaxed/simple;
	bh=Uj02hhUC3ciONiJFobENSypCac+14b1YFOPPRCYYOlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tBETB6ST96BdOqZWFn620aO8jfUPuHy8E8GitT42H36DBsPNw0yL/Wks9CjggpAbZW94LKkSRfe9RYFXlhHi9+pCfqfBwtTK3Rwr2MW8WXMsHPHFp9nsxQ2iD5CbGig6m1psGjy6o7GCXuyMhJ/7NJ9EAJkT1dbxN1YIVsk1ZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UBjxsy7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkbR+21V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 23:31:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708990302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/+vWLgFOyGXzZvHbRQQYhnMyMxUqGESN9iHCw7s5MU=;
	b=0UBjxsy7MYD4DhCHeghuFlKmXEnFVl7qg09685aTjRLdVCqMxdPc/9ZDDZtNbUwWVmdBO3
	xeelNLeUDSEYBYTrg/rboHdkPPVXeyBigZqkeb48e0DAl8T+CMplRLig8mjd4vuTJFa8+B
	TGEtwu03cWan7Yw84QEN7gXngCh3EjFxYMoqGgy/bWV1rWGP1+tF7Ds7mSPkizKfqLRpTF
	4GDbwdlu5Eeo9J835AuwTTfnyjav30fBvK/pgeP95CHeB1oWHRN8GQkFWOIMlIfAz8er2e
	toZ8eTBBZPs54RjLMO5Q8HNV75L4GZLXCdiV/N0KaeDuR8LlIqHSD6d9qA8pZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708990302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/+vWLgFOyGXzZvHbRQQYhnMyMxUqGESN9iHCw7s5MU=;
	b=wkbR+21Vwi8weJWoI5V+D8shkmOPlfhQjox5NUlMUc21r/szfO3Rmj9J1VVWK46suTnaWL
	fb+hpkyp59IPtgAw==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86: Increase brk randomness entropy for 64-bit systems
Cc: y0un9n132@gmail.com, Kees Cook <keescook@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Kosina <jkosina@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240217062545.1631668-1-keescook@chromium.org>
References: <20240217062545.1631668-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170899030090.398.7397849626399402025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Gitweb:        https://git.kernel.org/tip/44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 16 Feb 2024 22:25:43 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 00:23:55 +01:00

x86: Increase brk randomness entropy for 64-bit systems

In commit c1d171a00294 ("x86: randomize brk"), arch_randomize_brk() was
defined to use a 32MB range (13 bits of entropy), but was never increased
when moving to 64-bit. The default arch_randomize_brk() uses 32MB for
32-bit tasks, and 1GB (18 bits of entropy) for 64-bit tasks.

Update x86_64 to match the entropy used by arm64 and other 64-bit
architectures.

Reported-by: y0un9n132@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jiri Kosina <jkosina@suse.com>
Closes: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com/
Link: https://lore.kernel.org/r/20240217062545.1631668-1-keescook@chromium.org
---
 arch/x86/kernel/process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade..45a9d49 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1030,7 +1030,10 @@ unsigned long arch_align_stack(unsigned long sp)
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	return randomize_page(mm->brk, 0x02000000);
+	if (mmap_is_ia32())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
 }
 
 /*

