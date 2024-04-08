Return-Path: <linux-kernel+bounces-135407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70989C0EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610B6B26782
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9F84A5E;
	Mon,  8 Apr 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StCXmCmT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1t+JQXIm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744048172A;
	Mon,  8 Apr 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581849; cv=none; b=Pn2dhGKf7jrrNAWb6kYUkHMa6fgYqBbSmOgDFkdWfmje2gP09VU0zq615Ysh/TPq0Tk54VTKsMJwClOQY3uVeYlQRRxtSpOuDqEY8KMLLAnQnRQadZnK1BKSkFvELvTg7Mv/hSe/t3nZeKo7xPB53i/PpOZ8wAypjKHnYya9Bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581849; c=relaxed/simple;
	bh=/Q+PU8T6gLhFpzjoA53ggNZvTA9M9ff/4vXMR1inHXs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jw8sLd08u5LBK+ZurB6e2JYVfY5gkC7Lp8m1NhKuvoJJGY2TqWIxgd1BluzXGYfL2KUXrTebL/JL9/CNYFWTRtZq5IQXLe3/4YZyb3glCGCYXE3+nG6vPnF6uAX9f3pXaX1xuS4PgrvUo+mYHYsSTCtnE2Lbb6qyXfKbVapiVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StCXmCmT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1t+JQXIm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/XJ6c98Yjpd6rPWBRT2/YDryWxCrtpUWekr8Vk8C18=;
	b=StCXmCmTA1ozSMPs2ZpNrpicdhCldlInSa7huxECXev4j1GbCh18pF4a2HMR67ee2hDDve
	zqqDv/kSiveEI/pWUTrzgaWfVFuG4ZtfyDoY9qLCEop9Ec30Qg3+xOcEfsanKoTLJowLuV
	SwxCC9NNRQfhDYznMVjFm6eKCTMOMG4gQVlh55NhVWfdhHaadnSMf+coEzHSstXWOFroVt
	oZ3G4odvavRYuN+4XHGFxxP9iMaEKIJx5n1D9CrmtNJrmsNSRWcJoBSQfPd19IS9r4Opiq
	LxDnAsOVTevMQUBqW4uiHvSyMcWEa9leldidrTf9zUh6Ier+Y9GKTV3+lMYJpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/XJ6c98Yjpd6rPWBRT2/YDryWxCrtpUWekr8Vk8C18=;
	b=1t+JQXImnc1fHlH4o2BN8dLRux34NdZf4L7OPJrG25ElKyEPAXPek4gBxE7i7oLePyYPK/
	ujT2Zg+8WXcBW/Cw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Consolidate vdso_calc_delta()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-2-adrian.hunter@intel.com>
References: <20240325064023.2997-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184484.10875.13971529593913504039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c8e3a8b6f2e62661d838ae222774121ae23777a4
Gitweb:        https://git.kernel.org/tip/c8e3a8b6f2e62661d838ae222774121ae23777a4
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:06 +02:00

vdso: Consolidate vdso_calc_delta()

Consolidate vdso_calc_delta(), in preparation for further simplification.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-2-adrian.hunter@intel.com

---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 26 ++++++++-----------
 arch/s390/include/asm/vdso/gettimeofday.h    |  7 +----
 lib/vdso/gettimeofday.c                      |  9 ++++++-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 78302f6..c639089 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -13,6 +13,17 @@
 
 #define VDSO_HAS_TIME			1
 
+/*
+ * powerpc specific delta calculation.
+ *
+ * This variant removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+#define VDSO_DELTA_NOMASK		1
+
 static __always_inline int do_syscall_2(const unsigned long _r0, const unsigned long _r3,
 					const unsigned long _r4)
 {
@@ -104,21 +115,6 @@ static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
 }
 #define vdso_clocksource_ok vdso_clocksource_ok
 
-/*
- * powerpc specific delta calculation.
- *
- * This variant removes the masking of the subtraction because the
- * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
- * which would result in a pointless operation. The compiler cannot
- * optimize it away as the mask comes from the vdso data and is not compile
- * time constant.
- */
-static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
-{
-	return (cycles - last) * mult;
-}
-#define vdso_calc_delta vdso_calc_delta
-
 #ifndef __powerpc64__
 static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
 {
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
index db84942..7937765 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -6,16 +6,13 @@
 
 #define VDSO_HAS_CLOCK_GETRES 1
 
+#define VDSO_DELTA_NOMASK 1
+
 #include <asm/syscall.h>
 #include <asm/timex.h>
 #include <asm/unistd.h>
 #include <linux/compiler.h>
 
-#define vdso_calc_delta __arch_vdso_calc_delta
-static __always_inline u64 __arch_vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
-{
-	return (cycles - last) * mult;
-}
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ce2f695..faccf12 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -6,6 +6,13 @@
 #include <vdso/helpers.h>
 
 #ifndef vdso_calc_delta
+
+#ifdef VDSO_DELTA_NOMASK
+# define VDSO_DELTA_MASK(mask)	U64_MAX
+#else
+# define VDSO_DELTA_MASK(mask)	(mask)
+#endif
+
 /*
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
@@ -13,7 +20,7 @@
 static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
-	return ((cycles - last) & mask) * mult;
+	return ((cycles - last) & VDSO_DELTA_MASK(mask)) * mult;
 }
 #endif
 

