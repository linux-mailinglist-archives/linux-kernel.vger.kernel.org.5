Return-Path: <linux-kernel+bounces-149759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BC8A9580
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FCC1C20CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4D15AABE;
	Thu, 18 Apr 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4U0P0ba";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6akd4Mxd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BF15AAA4;
	Thu, 18 Apr 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430750; cv=none; b=fENZXcz9jHlU4bZlwgslCjowzA5CUSaXg1FN/jR7/s3ZKH6DZCLLG3WM7jWd1ER009XAiBllkyNjEVF43q5hnhnTT4AxzB+vCY84HZ6aIpwkuiXUZmBoMvfZPh4Iyz7tHb+JdJn3WRe+RBg8+GJ3c4os3rQ8W5mlijUipN7gtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430750; c=relaxed/simple;
	bh=tkveMfw/zqlF+5IcwqNPbU5PReiD4uUyTp5l8aRY+B8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iv/yVSRE495cQYq0omaTDIrr7XoIHR84dyRt/ckNMLp9/vxEIzJBr2tw5xEPFaB3k1BlmXxnvmXw2hGxmXgCMqWuMvA1GE/zKOAnXTg8FFzvrtDKsIXIqbgeldvc8kn8z992E2ozFWPHjQ1mdH0YenMr6OUswtj5DX+y0BPnRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K4U0P0ba; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6akd4Mxd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 08:59:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713430747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa2awveOSUbd2VDTato0L3LcO727x7iaOZh9zyeapOk=;
	b=K4U0P0baneN3iPnitHAMt4pPOJF4GY6m4wxKeJ2CjsUvTqDTlM4A0hCbBkiH0v2WG59nPq
	CcFdkJxxwpR00bGIdjxtryHoGS8rNME869aX2hPlbj5JO7CIYi1Dh4QDBZxWQuamkClroO
	hjEXUosG3AX1WfAAeFYCMDrIp/f7iSz5c7KGjA9cOzY4PDKN6EfA5AlWizHNo4jXNlHw7C
	0JP8rR2xv8yjy2yWK97zq8ei89RaqNV9WERruam9aCtySYxIJOQyMrJhd9RLC7OAd0utkZ
	Q9j3zE4Dl8Qqo2ywcNzkZjJ6dfGHsQr3rjyMabA7foYJFJtC7MduRseTaFEy+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713430747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa2awveOSUbd2VDTato0L3LcO727x7iaOZh9zyeapOk=;
	b=6akd4MxdDPmeHGy01Prs6bHoa4/ik9NyjqKFskIxX0WkhceSQC6El3SJUYoMkGSkKIhYcC
	PXzl4kEDGTCrA4Bw==
From: "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred: Fix incorrect error code printout in
 fred_bad_type()
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb2a8f0a41449d25240e314a2ddfbf6549511fb04=2E17133?=
 =?utf-8?q?53612=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3Cb2a8f0a41449d25240e314a2ddfbf6549511fb04=2E171335?=
 =?utf-8?q?3612=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171343074601.10875.15730658639010324110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a4b37f5033fa812f02f3b7bd1242393d347ba791
Gitweb:        https://git.kernel.org/tip/a4b37f5033fa812f02f3b7bd1242393d347ba791
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Wed, 17 Apr 2024 19:34:25 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 18 Apr 2024 10:47:17 +02:00

x86/fred: Fix incorrect error code printout in fred_bad_type()

regs->orig_ax has been set to -1 on entry so in the printout,
fred_bad_type() should use the passed parameter error_code.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/b2a8f0a41449d25240e314a2ddfbf6549511fb04.1713353612.git.houwenlong.hwl@antgroup.com
---
 arch/x86/entry/entry_fred.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 9fa18b8..89c1476 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -28,9 +28,9 @@ static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code
 	if (regs->fred_cs.sl > 0) {
 		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
-			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 regs->fred_ss.type, regs->fred_ss.vector, error_code,
 			 fred_event_data(regs), regs->cs, regs->ip);
-		die("invalid or fatal FRED event", regs, regs->orig_ax);
+		die("invalid or fatal FRED event", regs, error_code);
 		panic("invalid or fatal FRED event");
 	} else {
 		unsigned long flags = oops_begin();
@@ -38,10 +38,10 @@ static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code
 
 		pr_alert("BUG: invalid or fatal FRED event; event type %u "
 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
-			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 regs->fred_ss.type, regs->fred_ss.vector, error_code,
 			 fred_event_data(regs), regs->cs, regs->ip);
 
-		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
+		if (__die("Invalid or fatal FRED event", regs, error_code))
 			sig = 0;
 
 		oops_end(flags, regs, sig);

