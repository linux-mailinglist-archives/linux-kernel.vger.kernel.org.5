Return-Path: <linux-kernel+bounces-118758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F076688BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61248B26782
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF4F6FE2F;
	Tue, 26 Mar 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByO5e44O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVr1ReUI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2E5490D;
	Tue, 26 Mar 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447818; cv=none; b=SEreKRHh6iEjAdG7smZIPlcBS5UuBlv0x87h3RLONOAwgZKIlVvIuG+qVDPLf24gzyx1Jjjo2yooGEBE1oIOReAY6+1Bqh05siN2b7fNojprJ0dVx6x9H2PCTzYvn/3QkWkEFkP/VNV40B7NdVkhdweQlQeI+Vhxaul/uZWNKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447818; c=relaxed/simple;
	bh=iBFsazZw36i4AIASR6kjb8462tHYj1blnPl0qBAO7jA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ddFZrcO+ZvJxpCLxU/RYJeYFNNuDFS8TkYktBnMCIAuA0kkqy/RNkYgXVhmeTwdvF5dAbSbc1GNS2Q1gGtADe5zjeIBAKuQabs2FJ7jvn5zn+zucO4BCd2M/1ciUKnOz8wps73dEqTUGery3TPZ8D34dHxMHUjYemyS6n+pi6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByO5e44O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVr1ReUI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 10:10:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711447815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsSjZG/174JHCYPQHQP+pkw5NzhmlrR7/I9ZO1z3fI8=;
	b=ByO5e44OMZs2voa/XGH3LYKkF81Tr7n0CbwEXXJwYuOkU4hk/GA8VFvsxyb8i+27q9zNEZ
	fPWIwgQ3+Aks8vUbqNcZXPdNIKKTdVeOGWQ3IiTXN+pbYustW/S9twNDTfb9107S4dX0Wc
	eIKSRT5+0jag6abcJgx5evf+78ND3T3TgG0oGWwU8f4qjzO8cp7s9rvB0nJPPUIZ6p/FdY
	g6HoEthNgyiNKhQATqhib7eKKz9kn+XFZlsJUXKZ+N6ZsXUMHwu0t0k2cJCO901u9ScLrK
	SLOzKNNgaMuc2zLktCutQZU93w4IlV09CqwBaQ/FK2KFlgU4j0Hgbj9HgBAR9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711447815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsSjZG/174JHCYPQHQP+pkw5NzhmlrR7/I9ZO1z3fI8=;
	b=nVr1ReUIbKKFKjECyNAJpjee+66sPkv0SIKkpbbDtZxfJPeMT7FtZoFzNrF6e4liFG4t2X
	j0S7lAtrhHCI/0CQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/vdso: Fix rethunk patching for vdso-image-x32.o too
Cc: kernel test robot <oliver.sang@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <202403251454.23df6278-lkp@intel.com>
References: <202403251454.23df6278-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171144781402.10875.1003478569450333151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4969d75dd9077e19e175e60f3c5a6c7653252e63
Gitweb:        https://git.kernel.org/tip/4969d75dd9077e19e175e60f3c5a6c7653252e63
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 26 Mar 2024 10:47:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 26 Mar 2024 10:47:14 +01:00

x86/vdso: Fix rethunk patching for vdso-image-x32.o too

In a similar fashion to

  b388e57d4628 ("x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o")

annotate vdso-image-x32.o too for objtool so that it gets annotated
properly and the unused return thunk warning doesn't fire.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403251454.23df6278-lkp@intel.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202403251454.23df6278-lkp@intel.com
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index fd63051..3d64bcc 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_X86_X32_ABI)			+= vdso-image-x32.o
 obj-$(CONFIG_COMPAT_32)				+= vdso-image-32.o vdso32-setup.o
 
 OBJECT_FILES_NON_STANDARD_vdso-image-32.o	:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-x32.o	:= n
 OBJECT_FILES_NON_STANDARD_vdso-image-64.o	:= n
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o	:= n
 

