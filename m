Return-Path: <linux-kernel+bounces-63813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7CF8534C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3A41C226D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6B5F856;
	Tue, 13 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOALD4HG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te7dU6vy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEF5F846;
	Tue, 13 Feb 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838562; cv=none; b=PlP5RFP0P8x2oET9ZhMgGmTtPMFJbMStaumzKfSifztHDjpNiAEJ9Ac31d42OzxGt4EyILXCJmip4yyJO6UByd+t6ZgbN57b6qILC1BNu8+PKwxnxvYZdoFB5MGsK0bLY8nCLdp4kd+D2KwtLvO6QAuyNO6m0vxaNqcAIxJljhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838562; c=relaxed/simple;
	bh=KrXJMOr+miGtPlSb4230hrRQT3uPQwaTq8pQKITfexQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=inp4ma5q3KwWCmnRjXjm3TExRgXcDAlRvWUnqAxkWgoJFEXMQPGTSqa7SlUBuLrzYI/GPtSk4XPYX5qSH1Fsho48QPl4NPl48nKeMHRxt1ioLXhanDZepRmlKobsz5WE4Ye1v+XCOodjpRtmqDZyrdJMISIcqvCRm3/jalr0NHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOALD4HG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Te7dU6vy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 15:35:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707838559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeI03GZmt+0/zsMYnwsiUarLlYtlM+rkTcW/EfReI5k=;
	b=jOALD4HGjkmsmSSV55b03yzJWWj22vS8at1jfld4iVp0vxx+PKiQ95a/acsR2na6h6+loS
	cRR8XWQkPixWR4Kn70T8m2PXbPIT2yJdvN4iTAmi8MamK5QOmf8eNBcPklb+m/7x3Dz1k2
	iGesztm21qZ3v8toyFtXgil89YOpbPFao80Fqhtp6CUEfRkzlNtHaQYRFyBzcrG/2VD1kc
	j492Nq2Ck/+h/TZr6x1hBvRKBnQtjx2+HbY72Ea69kPydAKh6iM72Uz8JsokDRHNMRXWu6
	PtakF2VnrPz51tS3AjQ0nP0EDGUfZqrMerOTi7I3i3QXDv2uHsU9/bkjvLaJGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707838559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeI03GZmt+0/zsMYnwsiUarLlYtlM+rkTcW/EfReI5k=;
	b=Te7dU6vyUh72zJ9ZCv2ezJVmn2f1Ez7MheeAGLW54VRAe7qraENFe6AKyRlIJIfmeTvGlX
	QNmhZQSqboJK4GCA==
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
Message-ID: <170783855789.398.9923650720518736029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     cadb7de3170e22893b617276c297216039aad88d
Gitweb:        https://git.kernel.org/tip/cadb7de3170e22893b617276c297216039aad88d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 16:27:46 +01:00

x86/alternatives: Sort local vars in apply_alternatives()

In a reverse x-mas tree.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-5-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1ceaaab..9aaf703 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -440,9 +440,9 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
-	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
+	u8 *instr, *replacement;
+	struct alt_instr *a;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 

