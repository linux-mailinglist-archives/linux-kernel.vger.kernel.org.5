Return-Path: <linux-kernel+bounces-125072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19C891F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A84288F82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B20145324;
	Fri, 29 Mar 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFuK7F1n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28uhuuIP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A3137C4A;
	Fri, 29 Mar 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719685; cv=none; b=E454xHhH0F/ekQ8zzUW95nhEUyyfOY+BFjXLXwV/f/OUK38RMbFctu2Gi711FhWhhs32uUpKxGDK9bwOeteDOuYcsmv1V1X1DLbbZuxda/ydJe4Vy0KaShKrP1I4dS7kGbn8VeLlo1R/DQF/WaY5OqOBGusnG2u61YGL3MJdEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719685; c=relaxed/simple;
	bh=heN+WKKSeAHoAwskdQRgyZ0tL1FGjT4BvcNf+5bb8Ac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Efo2i3PCHeznlfC+MIV6L8AhVG1N3bgJT8Zo5JmhoK6hfyD+bdFy6MU5tBWJ8UB+fMLx2TawMcnoMGmtBXwqC+KQTSbQU7Dbfq3X3iM9Xg3k7+W7re7Ub40gXbGpxIQHAEVO24PUor1qidbXeI+9sJ1ApZISTljx3tBiW6177iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFuK7F1n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=28uhuuIP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Mar 2024 13:41:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711719682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB2HtUxxAUBEkmBV5gBiXdcQh/3BcG4ClBeUM2e237U=;
	b=jFuK7F1nt1HSgF62Se4GmYWvsIGzAAhJpwp2XhTkEs8WrH9LAZPg5sjxuq3AVObsY1mr+r
	mESs/PKe1tfQxAmy3eXxFhZ2q1B885VAcaNglgVgL9fXgRJvZ6JoPobvFZoIbMiyKQPOTL
	MTLSBTY1qp44Pu9lMx7k5M+JKr7CPC1R+IYabWllMqHdZ2mVByJmMwcy1cGXTyGhK1QqID
	smFwTZY3GVzfzOVqXYG73A/ZQgwEx9NDCKMcxUGt81DK83GSrB5AUyUIX4GK9/DSzEtb6Z
	Mndo/2/vtYj5focdC3v1sU29bs241B3LvAHn+yLz907MFqKcGgyZIhPWg22kvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711719682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB2HtUxxAUBEkmBV5gBiXdcQh/3BcG4ClBeUM2e237U=;
	b=28uhuuIPeFgx0qfWw1a00XmpO22u1mz1AwQe3saCrlbs6E3Cj9l4uiYBAZwsqnJWWZl7Kf
	zzGdN3ywVszqEaCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/vm86: Make sure the free_vm86(task) definition
 uses its parameter even in the !CONFIG_VM86 case
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZgaFfyHMOdLHEKm+@gmail.com>
References: <ZgaFfyHMOdLHEKm+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171171968134.10875.11841808669108375691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5ca28d24aecd0809d93da2ea73a4f6e4b2ccfa78
Gitweb:        https://git.kernel.org/tip/5ca28d24aecd0809d93da2ea73a4f6e4b2c=
cfa78
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 29 Mar 2024 14:20:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Mar 2024 14:24:50 +01:00

x86/vm86: Make sure the free_vm86(task) definition uses its parameter even in=
 the !CONFIG_VM86 case

I ran into a case in new code where free_vm86(task) was the only
consumer of the 'task' variable:

  arch/x86/kernel/process.c: In function =E2=80=98exit_thread=E2=80=99:
  arch/x86/kernel/process.c:118:31: error: unused variable =E2=80=98t=E2=80=
=99 [-Werror=3Dunused-variable]

Robustify the definition in the !CONFIG_VM86 case.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZgaFfyHMOdLHEKm+@gmail.com
---
 arch/x86/include/asm/vm86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vm86.h b/arch/x86/include/asm/vm86.h
index 9e8ac50..62ee199 100644
--- a/arch/x86/include/asm/vm86.h
+++ b/arch/x86/include/asm/vm86.h
@@ -84,7 +84,7 @@ static inline int handle_vm86_trap(struct kernel_vm86_regs =
*a, long b, int c)
=20
 static inline void save_v86_state(struct kernel_vm86_regs *a, int b) { }
=20
-#define free_vm86(t) do { } while(0)
+#define free_vm86(task) do { (void)(task); } while(0)
=20
 #endif /* CONFIG_VM86 */
=20

