Return-Path: <linux-kernel+bounces-133655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF7589A6B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D897F28382B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D091779B6;
	Fri,  5 Apr 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IX5/wFFh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7XjVV/+N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4641779A7;
	Fri,  5 Apr 2024 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353896; cv=none; b=StoporyW9SYpnKWwBs/+HRSps11m41Al0sqTZ2XApKxuPZ9FbDJ8xOU43AY02hb+Pk6c4Lb/DrKFaVHliihnCEz6Z1nyIhZvzNymymTJsNH3gsEyPPWBYgCx6gbzBDqAAHl7yuYCe8oF2SB9WGXmv11sRcfanO8AFRb4nr4QXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353896; c=relaxed/simple;
	bh=qnPCxhijiKo1965NzfGBjF8Wk82s8pu8INodAXhOxjM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ICDe2Aj6d7bORWwkKfzVfjOMcUPB9HtNyFIjjpeSP4ekDFnWaNGmxRIhSFlMTpSk902o6dvuk/aPi0s06tvYs1Ty0hZm2IJEGFNezu6K+Rl0hOhOljGnILlg4OriWHceM5RdL069XGiXfsGmFzvp8N0YyouRciC3nw/mJXKrjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IX5/wFFh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7XjVV/+N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Apr 2024 21:51:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712353892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h4OV17tldwjv+ugFjSZlstFzEs3BbAG5cbN8SdrUJZM=;
	b=IX5/wFFhO88kpkABsGxmUEqqCVxui4hT6W8L+qg99G2aLT2+n83OXOsBwkh/xtyGVh0ylT
	5QfQNF7eu/j48lQspmW6yiImriH38IxRYUyOlmv39chYxBn60pY5/9GDXPDB8cE9tolXtG
	Yl3T2HbCWlomk+KhoiFF2DUjnv4NEW7pDF6kaTdbHrF6dGRKGxIDGK/NUl3yrSDsR75k/d
	r4kjTq0byDh1/sPnjjbqEoolmuXqW4TWje8azdg/0MxNBCGa45jekk3ByiBNS+tXgNm4q/
	upO3LE3bEpwVKUxWVfEiCvzREbVLzmSwmNcmG9AfZR4AOwhPc/5Yw0tkqhZJUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712353892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h4OV17tldwjv+ugFjSZlstFzEs3BbAG5cbN8SdrUJZM=;
	b=7XjVV/+N2eCWbRftGEfFqV97nEalleyjIVYq7GKsUcIZydhV4Hm8luAaySmnKw1k8JF+MG
	DoFBBQyl7W2BogCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode/AMD: Remove unused PATCH_MAX_SIZE macro
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171235389097.10875.3141438373262739023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     3287c22957b401903e4933a81eea9191788da33b
Gitweb:        https://git.kernel.org/tip/3287c22957b401903e4933a81eea9191788da33b
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 05 Apr 2024 23:33:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Apr 2024 23:33:08 +02:00

x86/microcode/AMD: Remove unused PATCH_MAX_SIZE macro

Orphaned after

  05e91e721138 ("x86/microcode/AMD: Rip out static buffers")

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 620f0af..c0d56c0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -84,8 +84,6 @@ struct microcode_amd {
 	unsigned int			mpb[];
 };
 
-#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
-
 static struct equiv_cpu_table {
 	unsigned int num_entries;
 	struct equiv_cpu_entry *entry;

