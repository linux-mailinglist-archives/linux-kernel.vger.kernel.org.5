Return-Path: <linux-kernel+bounces-156850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CD8B0917
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D31C23881
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D621DFCE;
	Wed, 24 Apr 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21i4Ev+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R09LMCfX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180F15664E;
	Wed, 24 Apr 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961089; cv=none; b=tMeDvbxaokW72Mk5CVfBxtZ/VWP2I+LXBnkJIib4Wejbay2+hThKP/xqt7Kn4MKyB0DCF+mY6/tx4LYGCgs9jOuMsu8W3GwbNwzdVsnLrrLT74Z2V87sz8lUsvg0w/L63No+dS3GJeKwOMYhe9HTEV2vMWPJMWhMQP1Aa8MRYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961089; c=relaxed/simple;
	bh=GbHKzyfhUb1jOnVvYSSSri/kXM9vJDiRPMH7awIcAWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M/jsXV4+jDCcij5orpJ8xBl/Mv9zssfRx/iWvr+zVyWIhNHwSSMb+fC30n1mYvw+HRXZ4CDW76peRtNyeCIk+yw07eb3XwrYYLiXhiTqgPNTVhRNjYjNxof1wDW1SnpMrefB/IS9hKzIcErfWsu2DMwtaTNzVBdYn8pLj+qBmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21i4Ev+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R09LMCfX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 12:18:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713961086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkjPL2IHsyS1WOvJSXBAtUZ2oR4SwSOeXnheY4fVsKU=;
	b=21i4Ev+yqG8+3LcpQMy2uhfLvazl65QV+NN1cIum2s1xLZeXjOSrOAqIUDdDRsCLZ3jUb8
	o17/IhX1qwdOejm+tMYWFdg7fweOO//SlvE0HLAnYcE5oZTuu3oYKDWRxWYEMNzw+rP4Xx
	b6Ow328EhnjAVwqstrgrOAb4CJ3QkMjfsZEnSKI/h/VBvpXJF7E3PietSuwlLDMnwFd3zZ
	W5u0Nar5BlYiNgYVjTW7vuIjUvv+xAB1/BQHwJZZOvm8shtDbJvSo4/8QLaE9HUDrbsdTg
	D0UYXMHXtnHF3EPBlLAE1ewe+v8uGIN+YUh4zX8PNsjedFJxir3YCz7On9eegQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713961086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkjPL2IHsyS1WOvJSXBAtUZ2oR4SwSOeXnheY4fVsKU=;
	b=R09LMCfXf03waoKLV4A/1dYe5JBEtdZ730N+UvUOMaNm43V1QNkcKOpXB8dV7GPyi0G6F1
	kPbZpsGbG1DS/hDA==
From: "tip-bot2 for Wenkuan Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range
Cc: Wenkuan Wang <Wenkuan.Wang@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423144111.1362-1-bp@kernel.org>
References: <20240423144111.1362-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171396108538.10875.18372163140114322675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2718a7fdf292b2dcb49c856fa8a6a955ebbbc45f
Gitweb:        https://git.kernel.org/tip/2718a7fdf292b2dcb49c856fa8a6a955ebbbc45f
Author:        Wenkuan Wang <Wenkuan.Wang@amd.com>
AuthorDate:    Wed, 10 Apr 2024 11:53:08 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Apr 2024 14:05:25 +02:00

x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range

Add some more Zen5 models.

Fixes: 3e4147f33f8b ("x86/CPU/AMD: Add X86_FEATURE_ZEN5")
Signed-off-by: Wenkuan Wang <Wenkuan.Wang@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240423144111.1362-1-bp@kernel.org
---
 arch/x86/kernel/cpu/amd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index cb9eece..307302a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -459,8 +459,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
 	case 0x1a:
 		switch (c->x86_model) {
-		case 0x00 ... 0x0f:
-		case 0x20 ... 0x2f:
+		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
 		case 0x70 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);

