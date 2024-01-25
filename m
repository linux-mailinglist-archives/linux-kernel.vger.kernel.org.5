Return-Path: <linux-kernel+bounces-38902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1983C820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282CA1F265BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1068512FF7B;
	Thu, 25 Jan 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fspIrQvR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4x3P/2WM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AC12FF9E;
	Thu, 25 Jan 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200525; cv=none; b=Qj2rgTiCqMLQMxkZJIua7wXJ15tlbF2n5IOiQNUD0SrljS65d0ibmGdeksGGwKg576RQg4dBjPEq598/WIBkNxu7Zs5be0BWIGWdD7H4P6W9e1uWa/qkCsOgd2z8tKoX8Fx3pX14Bgj5ZZcgWehFFRw5mRSr6aPZv6UfPPmHIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200525; c=relaxed/simple;
	bh=07ZppXBx5HpK49KSBGhrbSx/lWjeFe4UY0N3vJ5jb4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tdUQObF0vvcB+mNijZ0XLXUfyuU3kDkPCBHVo3knGcNLq9+MeNAmXTnGlg6c8DE5WcU/t8T4B2se3NlkQsag1pfXpSktSZlftZWjQwLSkbZqT6us9wXttFi+n/f+zcMnjbUQ5cyDBN5T3zjR6e2/PCth79u6Od3FUvhWcEBnAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fspIrQvR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4x3P/2WM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 16:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706200509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8WsDl52GLUmhPEBn4X3NugHcuHUBNfYN6j4WRgtSLQ=;
	b=fspIrQvREH3hucOpmhqyQyZnW/YSZQN8D4gjlDLBuRBHKgoQ9ooFaFeS69l7aJ0B+EiXcn
	5fJHkt3tF+MqG3mRq9NOrooaJ/XXZqXbWKn4SXHtheYEcFkDWS04yhYxfnPR+KFINdJJmP
	n4XkoDsHt+1ArB8KvpppdbDKYExDxplePaj9xQ5XbQ9VqzrRDGXKh9CA3ugiRGZi1goqno
	vw0/NKr/+EYSIGz0LwFsAF/NRw2a/R5f2NixTAvgHs2tCvrwGNfQmJoqNFzO9JCq69PJ8g
	cAd5XNeChcMapt0xaHqA25NKiVWkyEu/ZUfzQniPZeQpeuYcJF2Jmxhk+wyDsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706200509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8WsDl52GLUmhPEBn4X3NugHcuHUBNfYN6j4WRgtSLQ=;
	b=4x3P/2WMSEWDTa6GIA2NzyblKr7xev3K9IJJcYzqE5UjdibKfJA14viMW17I3EbuMzz2Zy
	TivooD2zy2jZA1Aw==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/nmi: Rate limit unknown NMI messages
Cc: Namhyung Kim <namhyung@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Guilherme Amadio <amadio@gentoo.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231209015211.357983-1-namhyung@kernel.org>
References: <20231209015211.357983-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620050883.398.17609181357191094448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e2fbc857d3c677ce96d9260577491e0d8f21b6f7
Gitweb:        https://git.kernel.org/tip/e2fbc857d3c677ce96d9260577491e0d8f21b6f7
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Fri, 08 Dec 2023 17:52:11 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Jan 2024 17:29:06 +01:00

x86/nmi: Rate limit unknown NMI messages

On some AMD machines, unknown NMI messages were printed on the console
continuously when using perf command with IBS.  It was reported that it
can slow down the kernel. Ratelimit the unknown NMI messages.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Guilherme Amadio <amadio@gentoo.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231209015211.357983-1-namhyung@kernel.org
---
 arch/x86/kernel/nmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955a..d238679 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -303,13 +303,13 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	__this_cpu_add(nmi_stats.unknown, 1);
 
-	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		 reason, smp_processor_id());
+	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+			     reason, smp_processor_id());
 
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
 		nmi_panic(regs, "NMI: Not continuing");
 
-	pr_emerg("Dazed and confused, but trying to continue\n");
+	pr_emerg_ratelimited("Dazed and confused, but trying to continue\n");
 }
 NOKPROBE_SYMBOL(unknown_nmi_error);
 

