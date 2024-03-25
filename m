Return-Path: <linux-kernel+bounces-116838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9188A46A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BB81C3923D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE61137740;
	Mon, 25 Mar 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPV9YT9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUv6mWS+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6F1369BA;
	Mon, 25 Mar 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362566; cv=none; b=AWSIWpvIdRwtK556y87Mj5ZmCQH/E2NxXIvqbmo54MwrbKM4X752/6fSiH9a2M6HUzagOArLCIh0eoepUiCB5sVZAx6e1MbCYgWKSf55+b66mEg2Gz/QMMs0u3e3Ydors5flgQ6DxFeqEwqRy1aWujH26vvO7sxXTFHwRtmh0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362566; c=relaxed/simple;
	bh=exsZ/RlFrlpl7+FM8gvJIdkjzrnMeECp/lur/esR3Yg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hWGae+NM0uUfo7+CqiNX04foStwRHWLs+/vOli5drhgma0H5i1KEtbA8X0JZkSAhWsUz94PTw9/Woby/kSEfxlsmI/9RPVxvVgtHFQT5W/gc87ZX9NnOObBbMTGIz54WTma2wF2smf5EPc+Zm2JzFfNSP6Wvd/G0+Mboi6fCTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPV9YT9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUv6mWS+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 10:29:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711362562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvU+bUjj4JAzflrn+dxjxcxBeNkheAqboGKDVwCtN9M=;
	b=tPV9YT9u9uxDUlsOS2cFncAUqbtKxgrvfUh0zGfK2LwUMI8cbBITFYDXof0ttP0pLYPKks
	Zjsh0joCyH5+JuFZfwbAElo6dPjeV0ZFZEcIOvnSxaIXk95YcXXOuaednUzqI4izTP80Rw
	Jedujfgbc+psgE80iR3TSh0cse18YhlRX5Vj6Csk5SEIvhJWBJCAhH4/HOh0CJhfZrW6VX
	qEiN++wUymJcF8SraUHUbPff2wr/1Ugqm29UfqajkjXGejl6Gcdp/gZrtjdFSkFMy/NBoe
	IC/uG4PcZ0cp/JpOUgISQmSg6EdzsguLUPG63qyHthD4/JCTlo0uuVbfam+Z5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711362562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvU+bUjj4JAzflrn+dxjxcxBeNkheAqboGKDVwCtN9M=;
	b=GUv6mWS+B6+KKmayIKK+DUsUaXZwwQAgYnne91TEBP758a5tkX9dZyFMuSsbcYEtkcL40/
	jYVbyAjl/0al2pAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] x86/cpufeatures: Add new word for scattered features
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8380d2a0da469a1f0ad75b8954a79fb689599ff6=2E17110?=
 =?utf-8?q?91584=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8380d2a0da469a1f0ad75b8954a79fb689599ff6=2E171109?=
 =?utf-8?q?1584=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136256210.10875.7016666652992736521.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7f274e609f3d5f45c22b1dd59053f6764458b492
Gitweb:        https://git.kernel.org/tip/7f274e609f3d5f45c22b1dd59053f6764458b492
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:01:44 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:16:54 +01:00

x86/cpufeatures: Add new word for scattered features

Add a new word for scattered features because all free bits among the
existing Linux-defined auxiliary flags have been exhausted.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/8380d2a0da469a1f0ad75b8954a79fb689599ff6.1711091584.git.sandipan.das@amd.com
---
 arch/x86/include/asm/cpufeature.h        | 6 ++++--
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/include/asm/disabled-features.h | 3 ++-
 arch/x86/include/asm/required-features.h | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a127369..42157dd 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -91,8 +91,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -116,8 +117,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f0337f7..4d850a7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index da4054f..c492bdc 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -155,6 +155,7 @@
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726..e9187dd 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */

