Return-Path: <linux-kernel+bounces-137264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7C89DF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E663A2843D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131813848D;
	Tue,  9 Apr 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lh6hoEpQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nyVyQv7J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F5137930;
	Tue,  9 Apr 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677746; cv=none; b=Wf1EKxHPgthSC1grFK82K0Xq7FkvZ8nDZurRX3nmYEoePS7Y6+4/NfjiBpfAKUhLBPPZZL6X/TWZ6BrY7RLKJD+dgoXpXbitVAAa8A0tV4MCV5/Kwih3LF4icyXnhN6dN+26Tmk8+LYkGFQ5nrrJcgz2GXCWQ8AJDlvbotrdFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677746; c=relaxed/simple;
	bh=C/lscghtjNoItk4U+pnESUSZzyRAeKrBWvTPy5/qm5I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ndtXWEpsHjE7wFdwCgJDZC14XQRAGGS+cJk4MYZUaRiLZMTyN9CLkVwQ+yHbq1BbE7vOGckp9jimDpwAzknY4hP1SdJ646Yx+12uNZKlzJ2pe6x0rrm5aCzrR2Exva8wLWQNCR7NBDZDmuWz/4tld2MpaiKTRDn3Vl6Ek8liOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lh6hoEpQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nyVyQv7J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 15:49:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712677741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtR81y4zOVvC4J4BVDpKNhGlG4wYDD1cKR+e6YtcdFU=;
	b=Lh6hoEpQpJAajMtiyx41vw3dlFEjFuIE2rCc3Y3earCb4MgWHTFDGkJNx5a/5K/lBmaFFB
	SAVBQTiwj+PuKr8CkRgZahUfpnLeOLhuKhnJ6xKLDri+aftG4xzA8hej6kOfZL6csH1lxp
	fLETSkS5e1tC4xuU9khUIqKGxT+eECf5B+yqLr9VKJ78eP99T/zVEC58W2tHkcSCb9/fcW
	P53AbGXHH2PlUu7Bj8+9NOkrF3CU6R6rLxDKYr7HPO/fAjQ9L90bSwFfDzWo6og+4ZA7ex
	aTJQFFIwFygBRd/aDz/nWhqmYVemKpNNQzgzBHJDRcITRZz5wRIJjGd9z85QCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712677741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtR81y4zOVvC4J4BVDpKNhGlG4wYDD1cKR+e6YtcdFU=;
	b=nyVyQv7J7NQNW5OydikY6vTxh6UkaLR5/z3+cxeHlwNgG7wXstBH8Hd7kYC3WZzmbLy02d
	rMklYQ6mersLZBAA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Move ARCH_CAP_XAPIC_DISABLE bit
 definition to its rightful place
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C243317ff6c8db307b7701a45f71e5c21da80194b=2E17056?=
 =?utf-8?q?32532=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C243317ff6c8db307b7701a45f71e5c21da80194b=2E170563?=
 =?utf-8?q?2532=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171267774070.10875.16415429453111355258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     53bc516ade85a764edef3d6c8a51e880820e3d9d
Gitweb:        https://git.kernel.org/tip/53bc516ade85a764edef3d6c8a51e880820e3d9d
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Thu, 18 Jan 2024 18:52:24 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 17:39:54 +02:00

x86/msr: Move ARCH_CAP_XAPIC_DISABLE bit definition to its rightful place

The ARCH_CAP_XAPIC_DISABLE bit of MSR_IA32_ARCH_CAP is not in the
correct sorted order. Move it where it belongs.

No functional change.

  [ bp: Massage commit message. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/243317ff6c8db307b7701a45f71e5c21da80194b.1705632532.git.pawan.kumar.gupta@linux.intel.com
---
 arch/x86/include/asm/msr-index.h |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd..961c0eb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -163,6 +163,10 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
+						 * IA32_XAPIC_DISABLE_STATUS MSR
+						 * supported
+						 */
 #define ARCH_CAP_PBRSB_NO		BIT(24)	/*
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
@@ -185,11 +189,6 @@
 						 * File.
 						 */
 
-#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
-						 * IA32_XAPIC_DISABLE_STATUS MSR
-						 * supported
-						 */
-
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the

