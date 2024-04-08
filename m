Return-Path: <linux-kernel+bounces-135403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63089C0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498E32829BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88E8120D;
	Mon,  8 Apr 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dZY2sWX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAhgcmBO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB87FBB3;
	Mon,  8 Apr 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581846; cv=none; b=h5e/tr7op92qSNaUUMFNfxXOGZE+ey6pBAdLzpI6cpyE//x0RoCQJXFT5JHNEcc+rbSQfJb+HXrGicDSdWd34yDrL4oiY3H+ZURS7LCoTznhINrAo9H94cJR5u1XAgeKvwgpm+x90bCynvYwib3CYy2vj+J7EKOuqx/DdYcAx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581846; c=relaxed/simple;
	bh=f0UdJBOu3zymVKe/XKjuEStwE20mNSGudtg3X6ITSG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=paKr7S7Lo2pRu93adDd8Qwre5CoYt63K2ZrB2juYIfmy5Lm/mh6ROk1fC7m/+MBSAG/2mx5TIsbNtw7sXxoLBWhFuGPA9K/1Go1wWil4wbcxQW+HKdb621GNdHIC6ZeOaR1aNCssGCxEE4v3RNox37BCsm5NZMXFjdNPm1FLZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dZY2sWX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAhgcmBO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwGjD8fVTIf+EolXJYDumXYNYzSuRgEAsH/qeqNkA9U=;
	b=1dZY2sWXkYt3THPoQ+KJSCMHHIxCkr886+ER09AIspzJzkQ51QDETtDp48PFcjobh8LcqW
	ia30x2ZN3ZUu94d+7exL2P+0rrOvNb1+cmD1WDDECdCTpklZ44lcc4vF26LYF4eRH4d0lB
	Zi6Fjyr/SY+C9b3Y5iWbD5MwTdvK6Nve46xjNBsm/0Tg+3T7cgglvf47DsAqc3+HtADQ/H
	hm4NvPEtNOTs1tdN8JFCoXIlidmx6kiz5IIIkMqwro0XuafVwMX+4ieshte6yHECTiVAlb
	TKmAuxBJWwDEt1CDXQcDx4npLDyea6/S1Uc+HSMNOFEHSBSLpd7HRf6nNzqN5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwGjD8fVTIf+EolXJYDumXYNYzSuRgEAsH/qeqNkA9U=;
	b=oAhgcmBO5SHyF3gcNmVJl4SCzsG0zjfvv44Qx3TiSH54NLCwDjfqCm+U6Xag69c4uixh6H
	tMoxWBhlFqOg44Dg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] math64: Tidy up mul_u64_u32_shr()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-5-adrian.hunter@intel.com>
References: <20240325064023.2997-5-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184265.10875.9822422804315388290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5e5e51422cd189bc1b627f619f0f99324e6e4de9
Gitweb:        https://git.kernel.org/tip/5e5e51422cd189bc1b627f619f0f99324e6e4de9
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:06 +02:00

math64: Tidy up mul_u64_u32_shr()

Put together declaration and initialization of local variables.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-5-adrian.hunter@intel.com

---
 include/linux/math64.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index bf74478..fd13622 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -179,16 +179,12 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 #ifndef mul_u64_u32_shr
 static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
-	u32 ah, al;
+	u32 ah = a >> 32, al = a;
 	u64 ret;
 
-	al = a;
-	ah = a >> 32;
-
 	ret = mul_u32_u32(al, mul) >> shift;
 	if (ah)
 		ret += mul_u32_u32(ah, mul) << (32 - shift);
-
 	return ret;
 }
 #endif /* mul_u64_u32_shr */

