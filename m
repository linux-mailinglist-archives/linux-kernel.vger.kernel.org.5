Return-Path: <linux-kernel+bounces-90958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43E870795
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409EC1C2136A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5827702;
	Mon,  4 Mar 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgdlEbPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1cD+0eD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D05C5F4;
	Mon,  4 Mar 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571084; cv=none; b=uKI7lz0bvW8PH6JzFF9lOiELCFpDh8sgYw40/WBFVUGWd7LzKlWyenMVHV8yZcEAYl0Di/UjwZZ/xSuUGoINjSGRss1GyFqgB68w4QQ4VewatSTKVhDQCwYs+k7iOyOg6GiFES1RO/V98OtO8l9zGbegmIEAAVGeTDW4DtO6V1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571084; c=relaxed/simple;
	bh=rG3U6LWU/wcU3QEj+fG+akk0USwnOpVG1fe7DgWukKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iVBkmuFw/AYNlX3+ON1TgF2iDV0H3JuNnqzWgotJm45nKtuhmiEbPzf10+d9aZWKXrHYxie3OgIwch/WkZDJiriwC6U0N5EZIF6CU14/XPS7T5EeyRU+VvhM0s0vm7iE5WIfcwJlv4DBelO57/AP6M3Wly7Pj1sO0labHVlMRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgdlEbPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1cD+0eD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 16:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709571074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK7JKajrbVZFXAoR6poQzrLX7ERI9qkNZKOHBww1XBE=;
	b=qgdlEbPix4f7Xj/f+mYgVHgXxLJHFSd7uFFvG7/opxI9zrDro9AK/S7dH3dyPTBeLRUSz8
	2m1G1IEkMMrzAdK7Iclog7lYqavnBU4s17BQPspbP0VPsbNY+i+0CnXIOfmE3sEdM/YWVW
	Lrp5WmBZkIdKpUqjb62sBVKnMQAPyWJGaTw8JGfgRTtvmoLZ0e+WooqCPA2subzpu7lrp+
	05To0B9cWgLTLrohGyi13sX6xHoDV6apVzrPM2f+gV50Pp+KpUU+BHCpCd+CC1NO6jJJjQ
	UEnZ+2hLDWzHgUlUMEOpoBI6ghrtpdHve5PUeguz66p/MWr1YrvbPweUGPYJlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709571074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK7JKajrbVZFXAoR6poQzrLX7ERI9qkNZKOHBww1XBE=;
	b=c1cD+0eD9qhWgiAIA5nT5SlZKPLgKtf5racc+FeTNevoeEn+gnOAuvFgOaIft0KLNQaN9i
	u4zUH8tEWwCj/YBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Let prefer_mwait_c1_over_halt() return bool
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240229142248.518723854@linutronix.de>
References: <20240229142248.518723854@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170957107395.398.2216128900889603168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5f75916ec6ecdc6314b637746f3ad809f2fc7379
Gitweb:        https://git.kernel.org/tip/5f75916ec6ecdc6314b637746f3ad809f2fc7379
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Feb 2024 15:23:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 17:39:24 +01:00

x86/idle: Let prefer_mwait_c1_over_halt() return bool

The return value is truly boolean. Make it so.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240229142248.518723854@linutronix.de
---
 arch/x86/kernel/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9709959..ccaacc7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,21 +853,21 @@ void __noreturn stop_this_cpu(void *dummy)
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
-		return 0;
+		return false;
 
 	/* MWAIT is not supported on this platform. Fallback to HALT */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		return 0;
+		return false;
 
 	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
 	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
-		return 0;
+		return false;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
@@ -876,13 +876,13 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 	 * with EAX=0, ECX=0.
 	 */
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
-		return 1;
+		return true;
 
 	/*
 	 * If MWAIT extensions are available, there should be at least one
 	 * MWAIT C1 substate present.
 	 */
-	return (edx & MWAIT_C1_SUBSTATE_MASK);
+	return !!(edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*

