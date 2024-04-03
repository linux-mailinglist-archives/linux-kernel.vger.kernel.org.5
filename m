Return-Path: <linux-kernel+bounces-130522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF3897966
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E241F24A09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428721553A6;
	Wed,  3 Apr 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBkZOuNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IEacnahp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC315530D;
	Wed,  3 Apr 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174155; cv=none; b=c6mmheivpWpzQtlrHf/E1ToyhGSuBK7wipxRiwWSVcsRR+X7QnhG/quPs/ubwXfM+/BRa5yPGANRcAp4MfJU7KiPY1cmzND2ZE6H0e5jKP/bT3aWDUx91XsN9TQ4ONSEQGbsRzgBcFlvkS1fc7sYyPtc0vUrKBr/8QyuvL76ww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174155; c=relaxed/simple;
	bh=KS37d74OWEsLdUEIIEugWBwvMSdxG69bHALvunzttbc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fv3WPU8sIO9LTDsPq36kjhvde0gn8d9deJXttHr0Mi/iPitwPmDQSU5uB6qB7swWDytU9g7C6bZq0epKaPGNU6QT/Og2+ArNXUCYURK8oDZLpOPIY5y0Yk2UAjW7VvXhGJIlulhBr3h6fPzYgtZxLR9q31uGju1eSIib9Gypf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBkZOuNj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IEacnahp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 19:55:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712174151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idUDMwnOdD1GcHVrCLPrBZtu2WPcarrSRJydUdZHxkI=;
	b=kBkZOuNjisLiR/uhLgxW63f9eRFmd9Dt+ZDdTSQoUtvZ/zqpIk02l5Zl3AFh2qxKviu0jV
	6EomyjHxEWDxdVsag3B9Jpik8NYkp9XRjegX/UBsSzLt9Mfqhb2a2P4OLv1DHkDKBakNC7
	Sfm8+a6xEEQtsFhmWqB4Ms0vsJ+TTZQZ+h3kBE5BWH90pDjmJtihvM/7tBVUpS491Uw6cX
	9g1g3K2etnNHna1Og0oYJjuHltBlWmBV2ozxQIzPa7h5g8//aSabEO0ilepacvbqham+EO
	0UFdKVq1Q8ImNgfvwfVJlF0dUbpA0qXilEXM8A3YaYapo5GZ13wP8F8wlWgpRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712174151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idUDMwnOdD1GcHVrCLPrBZtu2WPcarrSRJydUdZHxkI=;
	b=IEacnahprwmcUw4Uodu8dxqd9CH7anKU6hM4TfMOZYSliJwE+0b5D+J/yj/+xwDEVAEs3A
	dSAI4w6eeJVjewCA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240320180228.136371-1-arnd@kernel.org>
References: <20240320180228.136371-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171217415035.10875.5390578420995891180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     cffaefd15a8f423cdee5d8eac15d267bc92de314
Gitweb:        https://git.kernel.org/tip/cffaefd15a8f423cdee5d8eac15d267bc92de314
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Mar 2024 19:02:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Apr 2024 21:50:04 +02:00

vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h

Both the vdso rework and the CONFIG_PAGE_SHIFT changes were merged during
the v6.9 merge window, so it is now possible to use CONFIG_PAGE_SHIFT
instead of including asm/page.h in the vdso.

This avoids the workaround for arm64 - commit 8b3843ae3634 ("vdso/datapage:
Quick fix - use asm/page-def.h for ARM64") and addresses a build warning
for powerpc64:

In file included from <built-in>:4:
In file included from /home/arnd/arm-soc/arm-soc/lib/vdso/gettimeofday.c:5:
In file included from ../include/vdso/datapage.h:25:
arch/powerpc/include/asm/page.h:230:9: error: result of comparison of constant 13835058055282163712 with expression of type 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
  230 |         return __pa(kaddr) >> PAGE_SHIFT;
      |                ^~~~~~~~~~~
arch/powerpc/include/asm/page.h:217:37: note: expanded from macro '__pa'
  217 |         VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
arch/powerpc/include/asm/page.h:202:73: note: expanded from macro 'VIRTUAL_WARN_ON'
  202 | #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
arch/powerpc/include/asm/bug.h:88:25: note: expanded from macro 'WARN_ON'
   88 |         int __ret_warn_on = !!(x);                              \
      |                                ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Link: https://lore.kernel.org/r/20240320180228.136371-1-arnd@kernel.org
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 3 +--
 include/vdso/datapage.h                      | 8 +-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index f0a4cf0..78302f6 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -4,7 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/page.h>
 #include <asm/vdso/timebase.h>
 #include <asm/barrier.h>
 #include <asm/unistd.h>
@@ -95,7 +94,7 @@ const struct vdso_data *__arch_get_vdso_data(void);
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
-	return (void *)vd + PAGE_SIZE;
+	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
 }
 #endif
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5d5c0b8..c71ddb6 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,12 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARM64
-#include <asm/page-def.h>
-#else
-#include <asm/page.h>
-#endif
-
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -132,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
  */
 union vdso_data_store {
 	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
+	u8			page[1U << CONFIG_PAGE_SHIFT];
 };
 
 /*

