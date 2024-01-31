Return-Path: <linux-kernel+bounces-47136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C98449BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA50DB27CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375953FB34;
	Wed, 31 Jan 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="McSpwabh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMmeuJEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B913BB3D;
	Wed, 31 Jan 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735694; cv=none; b=CO1uL31+vbFqC/C1UpiSLS2I912vJYrxE6XVrmhceywkMOjEQFMEhpq2t1uUJ3Ws3T3UA1vqRlZptY6SsbzPHGGxsgN9kVecvBeM878BoKyDlDWze9w8Bl7cZ2E0smTW+gsWdjT1NCN3cA/HhB5E062/AsaYthAbxezYV9o2LFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735694; c=relaxed/simple;
	bh=amc0Ld0f8tthTrPZKjqAZGX4Aqk1Gf4HoJmRO8jWkNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a+xo3+zK/Gmd/R7RwultLufgo9Vfy6p3TQBkotG6ZWaiJfsm9YuexuIulBq7if9f6teL2+5jEJKrwMQiVcDs8K6M3qagONvzocatDNySX8TzkwOf9GivJqOfACncBV9RqJztMs3UBeVL3J7WCCu/jKo2+W1yhAs4ypKlxKEDoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=McSpwabh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMmeuJEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3rySNEmjT/c4K21p0U7c4EN7VOfizhRI1l/sNnNJVE=;
	b=McSpwabh/7gWBwYRp3QTiJ0b8tKSoliHIEtcxWWsihXkN3DirS5Se6pCgH84TxTlSe9AA9
	N0mHTcYmiMQ7AaDPkU+RybHcnvF2JBaunUTkViiLa4rFJ/A5LV2vsOAInRqtCJZoo8jccA
	GgLR5rXuITb4/yDZUF8AMBG1opIZUrZMGAhh+eZ10Ns0OAGMpGxVD3wZ+poPt7hKQtL29u
	XxpPHzFwTGuDvLLeKm0ArrojUPLfa3fRq55JoVLqeN8gPrDgK+3pi+iaQdijWbuWIKFEah
	a09ZJ14lktOj96bcExy03EOPeewV7JSZwN14fXSROYFCYpAL4/L90UaQg0dgBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3rySNEmjT/c4K21p0U7c4EN7VOfizhRI1l/sNnNJVE=;
	b=nMmeuJEfDolhPWPUnaHkfqxrsdNo+59CNSZWvnBR2FCKxcOypjU6yWo5RZEUC03rhtplsS
	4Yz7msMeAKtwy3AQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Reserve space for the FRED stack frame
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-17-xin3.li@intel.com>
References: <20231205105030.8698-17-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673569050.398.6147585182118522399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     65c9cc9e2c14602d98f1ca61c51ac954e9529303
Gitweb:        https://git.kernel.org/tip/65c9cc9e2c14602d98f1ca61c51ac954e9529303
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:05 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:01:31 +01:00

x86/fred: Reserve space for the FRED stack frame

When using FRED, reserve space at the top of the stack frame, just
like i386 does.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-17-xin3.li@intel.com
---
 arch/x86/include/asm/thread_info.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b029..12da7df 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -31,7 +31,9 @@
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
  *
- * x86_64 has a fixed-length stack frame.
+ * x86-64 has a fixed-length stack frame, but it depends on whether
+ * or not FRED is enabled. Future versions of FRED might make this
+ * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -39,8 +41,12 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else
-# define TOP_OF_KERNEL_STACK_PADDING 0
+#else /* x86-64 */
+# ifdef CONFIG_X86_FRED
+#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
+# else
+#  define TOP_OF_KERNEL_STACK_PADDING 0
+# endif
 #endif
 
 /*

