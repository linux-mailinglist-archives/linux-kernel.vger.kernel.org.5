Return-Path: <linux-kernel+bounces-152535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFE8AC035
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC42815B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D31CF87;
	Sun, 21 Apr 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhN6IrpL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJAyNBBl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F11CA8F;
	Sun, 21 Apr 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713719470; cv=none; b=jhEWJ9vXUx2EMQ3q+hvHO/9w2s9ZR018FPB2hTqg79Ne8uqMJVZS+d06cEZhVMeRmoDhtdsv5dJknrVXC55mYxHNbVqk9kCBBgxkTQSO41Bhm+labb8b1zJn7wFhN+XLLzKAcFpF3euCRC0f763BJ0JBVcUkv1nJrlC9ipH+a9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713719470; c=relaxed/simple;
	bh=KpSb7c9BhEPtqr3znriteaXa8LHeFRii/6sczFQoyoc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZhIwQx39MKIYivAchzeKMb+JH9NlOWBH3xhWd9cWtZ+GyrymIqj6VY/legoh4316yRCuXWKfcWzjfXk168ERTA8/M2CZA+pbFxfNm9O/G4ZNKvNZ+VM9GRzytRVygIv21sezNyWdwM0S1oKlTUaqvu5DZW1VRTPj1Bov2qrZ/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhN6IrpL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJAyNBBl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 21 Apr 2024 17:11:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713719466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DEJGTzogNBnLsV4v82Z6uqUbvYBn/dfRVD05b156Vo=;
	b=NhN6IrpLtUSBZHWlOjbE22LTQ0DI8xrSRfCorUUAAc1WeigZLa0fudBQ/3YjY4a+IVpEoN
	fCdMJcyPfguW67FG3TsxPi68JE3/4rCONrG2ir+Bm5GdEW3ks/jsBNFZqYAXdq4l25PSaL
	ETig/+JLoz7WI3EAJuNUf9z9HWezItxhjNabT0TYGNBZsoRJiILJSDxxu/m490n4Zry5xc
	lC9d2e09l7/+aSqeFAyuYDRBZffFx4wQjqTkjkfUAWXUvUp/cBXhqbcQmCw2ktFaa6VRQw
	KOP9kVK+7SyFCCCtzESa6i3AMv6kRAm2Gul594F/+VthU6awL1Jd8Zbxvizzfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713719466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DEJGTzogNBnLsV4v82Z6uqUbvYBn/dfRVD05b156Vo=;
	b=PJAyNBBlT+ex6aROq1/OjylfzV7MPvjQ45gzVcP3NlNS8uN7rvPfgQoTjtuaNBH+Oqe2D4
	u1zABpfUEbvGhSAg==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Merge the two
 CONFIG_X86_EXTENDED_PLATFORM entries
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204100719.42574-1-masahiroy@kernel.org>
References: <20240204100719.42574-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171371946443.10875.15940850527405121296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     71d99ea47fbd3179e01f8037aad1d1367a821de2
Gitweb:        https://git.kernel.org/tip/71d99ea47fbd3179e01f8037aad1d1367a821de2
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 04 Feb 2024 19:07:19 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 21 Apr 2024 18:41:40 +02:00

x86/Kconfig: Merge the two CONFIG_X86_EXTENDED_PLATFORM entries

There are two menu entries for X86_EXTENDED_PLATFORM, one for X86_32 and
the other for X86_64.

These entries are nearly identical, with the only difference being the
platform list in the help message.

While this structure was intended by commit

  8425091ff8af ("x86: improve the help text of X86_EXTENDED_PLATFORM"),

there is no need to duplicate the entire config entry. Instead, provide
a little more clarification in the help message.

  [ bp: Massage. ]

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240204100719.42574-1-masahiroy@kernel.org
---
 arch/x86/Kconfig | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e88f6f7..0046ffb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -506,10 +506,9 @@ config X86_FRED
 	  ring transitions and exception/interrupt handling if the
 	  system supports.
 
-if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
-	depends on SMP
+	depends on SMP && X86_32
 	help
 	  This option is needed for the systems that have more than 8 CPUs.
 
@@ -522,7 +521,10 @@ config X86_EXTENDED_PLATFORM
 	  systems out there.)
 
 	  If you enable this option then you'll be able to select support
-	  for the following (non-PC) 32 bit x86 platforms:
+	  for the following non-PC x86 platforms, depending on the value of
+	  CONFIG_64BIT.
+
+	  32-bit platforms (CONFIG_64BIT=n):
 		Goldfish (Android emulator)
 		AMD Elan
 		RDC R-321x SoC
@@ -530,28 +532,14 @@ config X86_EXTENDED_PLATFORM
 		STA2X11-based (e.g. Northville)
 		Moorestown MID devices
 
-	  If you have one of these systems, or if you want to build a
-	  generic distribution kernel, say Y here - otherwise say N.
-endif # X86_32
-
-if X86_64
-config X86_EXTENDED_PLATFORM
-	bool "Support for extended (non-PC) x86 platforms"
-	default y
-	help
-	  If you disable this option then the kernel will only support
-	  standard PC platforms. (which covers the vast majority of
-	  systems out there.)
-
-	  If you enable this option then you'll be able to select support
-	  for the following (non-PC) 64 bit x86 platforms:
+	  64-bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif # X86_64
+
 # This is an alphabetically sorted list of 64 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
 config X86_NUMACHIP

