Return-Path: <linux-kernel+bounces-135402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EB89C0D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9D82827A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11180620;
	Mon,  8 Apr 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTdsMSPq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjnCLVKK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2A7F7CC;
	Mon,  8 Apr 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581845; cv=none; b=PQf2QS6tnBSAQss4x2RhF0wdpcFSIBWq6mAVusaHvXh0aDfVvwlBQ25MFcVVjVOCD/55L59CrsZ2MiRkq5bZ0GnD1fLPhuX7hBR1F1i2AZqwQImKiiG2xY4fjlmCC4nXN6SJWGS6UidLVPQ3dCMWoiRoS9y4hcixPKXwQ3PK/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581845; c=relaxed/simple;
	bh=3q4123uQGG1fwT9H9eSc/cxVrgCoZKaghNv6uu19/S4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a6azRuRIkKCVqtbeKWPVicXpQkR/WlA+BnmA4eP1stsQoj8rFh2AgIXQaoLgrGY6E05deNuAHwLVBH1+zCWSGaY/xOZaign9gWzrIHLhQG1ks5l0WeOe21F7hanyrFSl1dQAisFROv8ICpQt4sZjIEMpxl41WbiWTspI3pXfte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTdsMSPq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjnCLVKK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lQFP+4wxGPaY8SWfl9yDYmAHq4BLgJQ45MqZV0OwTA=;
	b=aTdsMSPq6GUJwl90aUyzmvmDpy8lNwga6BwZPAfgSzRP6UJZIEh64Mwm+v4FY1ofBnZKje
	bL3GcVfyF7MrfqpSk8NHcqFqIURjzpLQj8bcoGjNelIIIt/7pceig3/NZUUKoXYekXjhdr
	7jxS/OiiQl16A4HMdwyxsX+lhCkOgU+Oxow5Jldi+Wzb8bUNPWkQlqJoQ4Ytg8P6shK9eB
	YOzOceE05tEl+R6hIm2uCTCxlbeLI3oP3pk2a6FTV6MTk0oKFkTY9Gsgp1zurJ5295q0T2
	4+cvRJlB8Kr+oyZeHjkepjflImVR5S7ZR/ThqxMApANsEGMM6DQiFPZ418dvJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lQFP+4wxGPaY8SWfl9yDYmAHq4BLgJQ45MqZV0OwTA=;
	b=CjnCLVKKIE/ifNsIVBBEOlIdYmtUfWpIL92wqfckVNIprxoYhRL/9rukekMjnjJyyn4tHz
	L2Jz6pGV6iZDOJBQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso, math64: Provide mul_u64_u32_add_u64_shr()
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-6-adrian.hunter@intel.com>
References: <20240325064023.2997-6-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184187.10875.16271014936581417028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1beb35ec615f676d49d68b6dc23c7418ba8ff145
Gitweb:        https://git.kernel.org/tip/1beb35ec615f676d49d68b6dc23c7418ba8ff145
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

vdso, math64: Provide mul_u64_u32_add_u64_shr()

Provide mul_u64_u32_add_u64_shr() which is a calculation that will be used
by timekeeping and VDSO.

Place #include <vdso/math64.h> after #include <asm/div64.h> to allow
architecture-specific overrides, at least for the kernel.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-6-adrian.hunter@intel.com

---
 include/linux/math64.h |  2 +-
 include/vdso/math64.h  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index fd13622..d34def7 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/math.h>
-#include <vdso/math64.h>
 #include <asm/div64.h>
+#include <vdso/math64.h>
 
 #if BITS_PER_LONG == 64
 
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
index 7da703e..22ae212 100644
--- a/include/vdso/math64.h
+++ b/include/vdso/math64.h
@@ -21,4 +21,42 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return ret;
 }
 
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+
+#ifndef mul_u64_u32_add_u64_shr
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, unsigned int shift)
+{
+	return (u64)((((unsigned __int128)a * mul) + b) >> shift);
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#else
+
+#ifndef mul_u64_u32_add_u64_shr
+#ifndef mul_u32_u32
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#define mul_u32_u32 mul_u32_u32
+#endif
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, unsigned int shift)
+{
+	u32 ah = a >> 32, al = a;
+	bool ovf;
+	u64 ret;
+
+	ovf = __builtin_add_overflow(mul_u32_u32(al, mul), b, &ret);
+	ret >>= shift;
+	if (ovf && shift)
+		ret += 1ULL << (64 - shift);
+	if (ah)
+		ret += mul_u32_u32(ah, mul) << (32 - shift);
+
+	return ret;
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#endif
+
 #endif /* __VDSO_MATH64_H */

