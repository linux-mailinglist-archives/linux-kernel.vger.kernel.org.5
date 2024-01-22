Return-Path: <linux-kernel+bounces-33236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE48366FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12D928AF82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33D4CDE2;
	Mon, 22 Jan 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdIMdjp2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nT9jg+l7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B44CB4E;
	Mon, 22 Jan 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935457; cv=none; b=jDtq3kN1KW31JcMjqKJ4a9l8ZqllrnuQAMRRdGzGlkgw67Q7jfwrAkeVXRPsugTTNM6ag0C3FElq6GUL8xf3Sb8DoeDXTtU4wN8LA+O+6DQ2AURi9AdfBS59NINKTTYvjqXnWhr8mCC0YzGKlSgfU4hIGR1SQELmuMHv9M6IEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935457; c=relaxed/simple;
	bh=OxFCdAXFTSASqxSgbwdHInjXQZEaWm2MUdInMwaX3bU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FQsEMWFJe55xscbk/mk8boKT04jhKOpVvfvuCuyFN87906oOeq65gr4r2/S52ZKWsIzUKj1M8jd7sSxQMbyAo4pghQtzHTBB/o4p8G4xtBGvgDjuNxC0fK+ZI3I6LYIf/6JGBMIQwQAXQvYOIPrPUsHPylR1qtK5Vd3Tkp8QeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CdIMdjp2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nT9jg+l7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 14:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705935453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DR3PbmSSFhDPtVAJMCA6aWJKnqAenCkYLK+/zUp6Dw=;
	b=CdIMdjp22qqMK2koK/3+wvj8suelxfMB9XuUSiiUEdjw1AhabwfmmvU6gKnfNL34seridC
	FF3mU5TP/a1pkQut8FSPu+UcyrteVL18X1szOmSudBZlLbhy3unnnwzogXMg7pnBppMRj8
	UVgHWLePFz3XE6e+gftLFPsXNiNTjeIeyrLSrjzgYdFxv2jWenfL/AyyynpZY6jv3P+c+T
	G+vCH4CZCPE2yRQmwPyUo42rdpPxYq2N7kuzwagK6zPZYXye/v5AsHLJrvysLirP2M/K5e
	iSY/0PXaVw6amgZ4TXfMZp64v5Tem7tawMDCDcwFkIRe2By9g/jJBv83mesQfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705935453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DR3PbmSSFhDPtVAJMCA6aWJKnqAenCkYLK+/zUp6Dw=;
	b=nT9jg+l7RefiknKMVzXwdveeCtKcZuBcHKpo82OrXmLRgz2wMiJiiL/LIePVYbxxUZk01v
	Wf1tjIHyBHSPzoBg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/paravirt: Make BUG_func() usable by non-GPL modules
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240109082232.22657-1-jgross@suse.com>
References: <20240109082232.22657-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170593545243.398.9370107089777687804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f7cfe7017b531e08c108ac6615b1ddedcc892428
Gitweb:        https://git.kernel.org/tip/f7cfe7017b531e08c108ac6615b1ddedcc892428
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 09 Jan 2024 09:22:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Jan 2024 15:51:07 +01:00

x86/paravirt: Make BUG_func() usable by non-GPL modules

Several inlined functions subject to paravirt patching are referencing
BUG_func() after the recent switch to the alternative patching
mechanism.

As those functions can legally be used by non-GPL modules, BUG_func()
must be usable by those modules, too. So use EXPORT_SYMBOL() when
exporting BUG_func().

Fixes: 9824b00c2b58 ("x86/paravirt: Move some functions and defines to alternative.c")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240109082232.22657-1-jgross@suse.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cc130b5..1d85cb7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,7 +403,7 @@ noinstr void BUG_func(void)
 {
 	BUG();
 }
-EXPORT_SYMBOL_GPL(BUG_func);
+EXPORT_SYMBOL(BUG_func);
 
 #define CALL_RIP_REL_OPCODE	0xff
 #define CALL_RIP_REL_MODRM	0x15

