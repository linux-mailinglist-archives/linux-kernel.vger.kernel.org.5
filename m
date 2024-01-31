Return-Path: <linux-kernel+bounces-47140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC18449C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9536B26A27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38424501C;
	Wed, 31 Jan 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2m+uUDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+RiLubm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0E3FB06;
	Wed, 31 Jan 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735697; cv=none; b=nhy7gLWkkN+abbY2kCNpOyqbAKh54cGdS5houYZ4j/lb2J0/WAcVR3QhdnA3gqAONuwAhEkdq0NL8G9gHZRGRfHthSR4vDzP0ScL5w9hxScPEyYZCTeY4A5ucsZhBSYZLP4GGEEcwr4siGSG+Yi/78zjhKI9CeSZJPybgg60SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735697; c=relaxed/simple;
	bh=pV2zr4++IAVGn1UyLL0YQuC3DbVc1LjBvwuFyR3Lg2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jDImA0enh6+6z+6toXKHAkt1NFTALRhh/biGHd1q0504JSBYPgd23ExVK72tVVCKMLKPgHLjMWka8dttTIbp+mPxC0K0xI7XRE3Rz2HSBgvWe4gTZxHiSlyl4pv+jeVg2mQ5k9aCvPe2GkkxDOj2cfQ1796PrsIX17ulA++GanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2m+uUDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+RiLubm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHzAREIZjBCQhX7gFd+k7R9tMdKXx+CAWHyaGIDAJJM=;
	b=p2m+uUDYX1i8MJuByAmEpn2OYCucVW3Tj87NOn+Ri3TSleBiwjbiJ08xL36YgnJ2CbgDWN
	jBseLLFlx/v1SWeiAmXeYa01ygDrNhb1s19bzpGh6BFs9NZRCCpLW7O2tw72IR9gBa6L+4
	qk4k97poNp+/W6dL9BWf9FbnlWmQmPoyjzlFH4fy8QDOBsE5380lsV7Iikv7nIoukQ3jDI
	tbD5VleXnUqKRiPhhFYlru3WC4xi52NuBkZzMArrQp387Bgimt2/TR5/kOekabnSDqjYTH
	HQ83vdZpVZEPOwJui6yfizP+aNehdrZyeaD6eBLT5/riSTvh9A3D5i3m/Yl9YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHzAREIZjBCQhX7gFd+k7R9tMdKXx+CAWHyaGIDAJJM=;
	b=T+RiLubmjeObsoa7tojTgDEEvyKb4eyQBIKHXN3vLaypkrI+uIlvbsKuhHKJBL4VPmzkeS
	ado/tnwNGw+BqcDg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/cpu: Add X86_CR4_FRED macro
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-12-xin3.li@intel.com>
References: <20231205105030.8698-12-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673569353.398.15524385501761288714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     ff45746fbf005f96e42bea466698e3fdbf926013
Gitweb:        https://git.kernel.org/tip/ff45746fbf005f96e42bea466698e3fdbf926013
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:00 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:00:38 +01:00

x86/cpu: Add X86_CR4_FRED macro

Add X86_CR4_FRED macro for the FRED bit in %cr4. This bit must not be
changed after initialization, so add it to the pinned CR4 bits.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-12-xin3.li@intel.com
---
 arch/x86/include/uapi/asm/processor-flags.h | 7 +++++++
 arch/x86/kernel/cpu/common.c                | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index d898432..f1a4adc 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -139,6 +139,13 @@
 #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
 #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
+#ifdef __x86_64__
+#define X86_CR4_FRED_BIT	32 /* enable FRED kernel entry */
+#define X86_CR4_FRED		_BITUL(X86_CR4_FRED_BIT)
+#else
+#define X86_CR4_FRED		(0)
+#endif
+
 /*
  * x86-64 Task Priority Register, CR8
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcd..c3a1757 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -382,9 +382,8 @@ out:
 }
 
 /* These bits should not change their value after CPU init is finished. */
-static const unsigned long cr4_pinned_mask =
-	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-	X86_CR4_FSGSBASE | X86_CR4_CET;
+static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
+					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 

