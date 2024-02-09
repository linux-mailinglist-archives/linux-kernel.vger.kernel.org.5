Return-Path: <linux-kernel+bounces-59550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F384F8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661331C22B43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0174E39;
	Fri,  9 Feb 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUr5eR+4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iAiJv2Fm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D96BB5F;
	Fri,  9 Feb 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493550; cv=none; b=Ek5MPG3IzfbNM3Nyv32x55Y3OlSB+uRfKIgAOF1nj5Sme20DgY9J5c9J45tYwQAaqqdBUJb8z7C5L/ApQJTU+9Pmq7qBleJb87SmuwuGiDdYYRxzXOpscR2r4462o88NWnvzhmn9rMDTGJ4IoYer9uR+NmqXGHw+Wmy8eW+kDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493550; c=relaxed/simple;
	bh=XGHTamODldsKIajh+HkJlfAS60GDYUJtSZqaTXI3otw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BAiycn+JbnMpvAGe3XLsLERGtqB7EzrYfLLylpni3y0zejf3mnq6yirLiSP2nTg2QB3h3Z2C0mdH8dPMCnRjkhvbPNdoc+cGy+f4RJWspD5GO7mPrX0UwH82D0x5z8RPzdBBnAWOD0jNMfbjU5SUVCQZKAnndhJYCmga2bOnUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUr5eR+4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iAiJv2Fm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Feb 2024 15:45:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707493540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8s4ETIGvFJpPoRfIpoZJ/N42G7JkajvXf5vnPmcKnA=;
	b=RUr5eR+4jpliQ7SpZjPk8WV+Dk+C9Zd/U/0FebCiXeZzE0afJPCoM3VWNcG924iAyqLhTi
	tIDXGb3kXzOJkn1qk9srw9aeFjNFqrOojjvRT2csK3mwdJRPok19UaqmwxdtG4TWQ7us5L
	npKS0eJQRiwN4+8/7kXrai9yGIM0TLBfNdoM6lw003zKKcPXjzkdglDKEn28cqvKxASPDs
	c+e6sBqHwU6oXVRQ77Gt84yfoWqTk0SVOx2BPZ263lr62zaojfi53n1bd/0jyI5LN8Li+R
	JsIDg2stPzGjDj4o3dtoUAAm7e8Rvqmfsoesf6gMSTS1I2RibexAgOKmE4Mg+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707493540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8s4ETIGvFJpPoRfIpoZJ/N42G7JkajvXf5vnPmcKnA=;
	b=iAiJv2FmgtYnI0ILGld7utjlCgMNmKhRYjU+3SpaEtlEuTh9QAkcaWYJ56LeJNy9pk33LE
	zBhT+MVjwoSthNAA==
From: "tip-bot2 for Aleksander Mazur" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6
Cc: Aleksander Mazur <deweloper@wp.pl>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123134309.1117782-1-deweloper@wp.pl>
References: <20240123134309.1117782-1-deweloper@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170749353913.398.14031938627894513083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f6a1892585cd19e63c4ef2334e26cd536d5b678d
Gitweb:        https://git.kernel.org/tip/f6a1892585cd19e63c4ef2334e26cd536d5b678d
Author:        Aleksander Mazur <deweloper@wp.pl>
AuthorDate:    Tue, 23 Jan 2024 14:43:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Feb 2024 16:28:19 +01:00

x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

The kernel built with MCRUSOE is unbootable on Transmeta Crusoe.  It shows
the following error message:

  This kernel requires an i686 CPU, but only detected an i586 CPU.
  Unable to boot - please use a kernel appropriate for your CPU.

Remove MCRUSOE from the condition introduced in commit in Fixes, effectively
changing X86_MINIMUM_CPU_FAMILY back to 5 on that machine, which matches the
CPU family given by CPUID.

  [ bp: Massage commit message. ]

Fixes: 25d76ac88821 ("x86/Kconfig: Explicitly enumerate i686-class CPUs in Kconfig")
Signed-off-by: Aleksander Mazur <deweloper@wp.pl>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: H. Peter Anvin <hpa@zytor.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240123134309.1117782-1-deweloper@wp.pl
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index b9224cf..2a7279d 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -379,7 +379,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 

