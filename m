Return-Path: <linux-kernel+bounces-111331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C1886ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F51C22028
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6133EA6F;
	Fri, 22 Mar 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ICxhai9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zR/M7qnM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0243D3BF;
	Fri, 22 Mar 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105102; cv=none; b=ZpZvKyF37rX81n1KwbFBL44V0O+LE1S4LiOzePhuhmXohd1ICzPxkGHeunEdZ6aI+V3F8P9vQPd5ohz/cfuJ0qnzjvR82gEGkJxqM+roI5i5TI29sBPI3amqPiAK8SCMmN9Scbo1Ow6EYyax9o9modIwxZk1Xfcf+UdgLX9yfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105102; c=relaxed/simple;
	bh=2vQGBcqfGik+DOs8/LDS6Z9Ve6JY+QDky80wYu2MJro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M2D4xPNX8RH8spSbYpCkYBGCv1pjjYNVjbeEC2qSeh/EXjN3J4PXWQyiDt6iKn1a+Rqubw1fkdgHtNni+kRa7wJOSesyg+4GEWA/CfDK4qfL93ft65ZQfzoH9DeWzqsC3p0t60zsjMaG7ldh60fNZC2Rmd6Pm1P6Dkg/4jhFYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ICxhai9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zR/M7qnM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:58:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E91sLJTV58BG8ycNZboePzCXozLdaYveDF7FK621VAg=;
	b=2ICxhai9NX5FBjmvBgg/aRbByYqgy0p7gFQ6r7N2dYrs5gx8uJqa83U1V0aRUxSFFGFZ1m
	Vvn3LOD8CwHNy6E+jCYG+s7LhP9/1tqHYf6UUCe27mRHddwpedR01KGCuWFgtg9v03QNaq
	Y8F9Y6YXa2NjTAH0CSadElXF9amOUHquw+ErExUZCUZ808oyTciJFkCmVf47Tn03TcNUcg
	6vRMh3RYon3tcFncm83MD004sE6AUAqLoMWe+jgcvJwIhfyXxoGJBYaxtrZ1PlwlzSuxbJ
	YtuGnOiEYEatvfQ006aOHCvHgPyHFW+8CW37+919g0Jkv/x27aPGEJwgwqxrtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E91sLJTV58BG8ycNZboePzCXozLdaYveDF7FK621VAg=;
	b=zR/M7qnMZ3FusZr8hfB+KhUMncQt+4BfZWRLTiTqFvkHSHCMVVNMXUT5pyKnWPYSv2Cf7b
	uq375NYU6obeXIAg==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/tsc: Make __use_tsc __ro_after_init
Cc: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240313180106.2917308-5-vschneid@redhat.com>
References: <20240313180106.2917308-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110509171.10875.16665845920451897974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     79a4567b2e8ae4d0282602a24f76f5e2382f5b98
Gitweb:        https://git.kernel.org/tip/79a4567b2e8ae4d0282602a24f76f5e2382f5b98
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 13 Mar 2024 19:01:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:18:20 +01:00

x86/tsc: Make __use_tsc __ro_after_init

__use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240313180106.2917308-5-vschneid@redhat.com
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49..0f7624e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
 static int __read_mostly tsc_unstable;
 static unsigned int __initdata tsc_early_khz;
 
-static DEFINE_STATIC_KEY_FALSE(__use_tsc);
+static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
 
 int tsc_clocksource_reliable;
 

