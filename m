Return-Path: <linux-kernel+bounces-137373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54F89E127
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A501C22CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC11155745;
	Tue,  9 Apr 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCOQEQe3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gV4BYXzp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B912E1D5;
	Tue,  9 Apr 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682693; cv=none; b=W9u4fogdHVg4m0b2rcNYNd1quqjL0ZzkFJVLCEKrNvN3aHL1evtlw4WLSqKpFHygUmywB+sFJOv9ZW1q4Th5rzYkmMLbR/TFBy4P5KQ3rK/g8BdDp71Dp/cxrnTlPcKx/+Nhj3AX8+Qwi6yeYgpbhY4C++7SODScXF7J9HUdorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682693; c=relaxed/simple;
	bh=xe2zX+oUmv3OI47f/cJgV4UYuKjvDV79GTN7zFkvctw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cdK3kkF3NihC+RsFWub7QDm2RFmbPrUbMjjTfRQ86PNxHf+HRMvbTiNFnF5974GKbZ9tdLKemb7pTBqvVMHYjto8Fjb0lZ4yR356aUZ/THin3w0rLgvR9rkU6ORh+cGXm40D2zQ0uWcZYckMj4WPeFU4ygSMXBdnhv+SKob/tzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCOQEQe3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gV4BYXzp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egqC4IkOkF+hknagc0QL/ggqE6BwaYEGometKi3CISQ=;
	b=LCOQEQe3jOtnhLHE6RrI0yGjFW4cund1LgCOUy+0zTbDXSEtTiIyEi3nFs/SQhjixTumcb
	JORaSNKs3U3N3W/ps+f09vSs7x4OwqDuolLJSjuu8F198k5Txwi8UJ35+tc1cs17VwNrrq
	vWJyIFFHy88PCA6Z3bsZCz1UGdTvkmu/BnkVInqVZV7TVs32y7pJ6J1ufoyVrOO5oHIcL6
	GbGe5UMX9DaXm74xynzIjJRMnd6QLTqSNlmgloWWKcwn5qFSEsSEZHBqy124reXHO3jKuJ
	k0fFQKz3UdHY+UEXweEdtNoOHSDsepfC4xlVeljAUv8JnFeBODw3NPmA3YNSeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egqC4IkOkF+hknagc0QL/ggqE6BwaYEGometKi3CISQ=;
	b=gV4BYXzplfxIsOXqxrQRGEOJQTa17ABcC6xrxioOBHcelgxSDdIqsGrSi5NjnZ43475ln/
	Kduq3axFFV4wTwCQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Sort local vars in
 apply_alternatives()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130105941.19707-5-bp@alien8.de>
References: <20240130105941.19707-5-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171268268870.10875.4199522237933126333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     05d277c9a9023e11d2f30a994bde08b854af52a0
Gitweb:        https://git.kernel.org/tip/05d277c9a9023e11d2f30a994bde08b854af52a0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 18:16:57 +02:00

x86/alternatives: Sort local vars in apply_alternatives()

In a reverse x-mas tree.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-5-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 67dd7c3..7555c15 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -445,9 +445,9 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
-	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
+	u8 *instr, *replacement;
+	struct alt_instr *a;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 

