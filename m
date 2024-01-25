Return-Path: <linux-kernel+bounces-39095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962F83CAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015D8295A70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339E13AA4C;
	Thu, 25 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4KxA1Fm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ck4MOo0y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD371386B7;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206895; cv=none; b=U+kzlIo+10sjPjriS13diWlcwCQzE8EpL5XwMxVbC5Sp0oxv4o0QNvWjBz0A0Nckc4GRtSgxIbLFXB3WvMUPkGWvxx00deQU8d8DOjWLlI9VLHU+X0A50i7LGuLIWlDRN7jCQ0wGhrza7n1GQuphKTzB4IcOVvHx/3yAyVqub8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206895; c=relaxed/simple;
	bh=RF7N1W05VmzZr3JjO91Yskl3CQVnOza/2vJqVHtC/OI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HnvxCzkhPHv02jf4tZtdx1b3r/lCCg9yLp2Gx09Fp1r10nx5Jc1ur2tA5Fp2oTO8RL/lS3+41G7to4o4TOJIn57+NHqtkBG0kdN35au2GeWcgrNjLwIzKsvONdTSAdMknBEfB3eD8vuhoskORMEehnRz2srJ8Q3Jzix+/hO436w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4KxA1Fm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ck4MOo0y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLeY2kavi4Blft+tytqE4VRMdY3zDRsQo4hNiN/v+fM=;
	b=l4KxA1FmiUx3cVFF12gHXZRrf3i9R8vjt7jx28dOj16Dd0mT2B3sWj487wD1Y2etib6neh
	V0V1LFwSLbzFeMR8H1q7TJxuqFT6mkkWkKvPVIZMbVcuJC2noxLTeqIYAwtkQJJ1TFk0k+
	odUI9XbwOtKjYtTPxXail41teF7dbjQpwI5HLljhCBLQCu6LWWbEq9KfmM/xLjdm5MQkcB
	26U+ly9zqi8C+ZwDJsYPJccTSPICdTf2azWIhvg1wToz056pDsRH8HmaEB1nMMVUw9uwZc
	f9MMT3ReSyKthSCcIPOc5Ev37XxOVX1uyKGiQW3pzfYCQI3M1J0RA7pu4LBBMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLeY2kavi4Blft+tytqE4VRMdY3zDRsQo4hNiN/v+fM=;
	b=ck4MOo0yLiXVb/w5AEnNtzeGKqinFZVZOgE5M2cDoyEcRX/ZLRnkBDjwyrEogNLDJQukE3
	NV46AE1r5mGbhWCQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Reserve space for the FRED stack frame
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-17-xin3.li@intel.com>
References: <20231205105030.8698-17-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688966.398.5410138435076203692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     c83ce06e137034b155ce56f2830637e7dc9c56ce
Gitweb:        https://git.kernel.org/tip/c83ce06e137034b155ce56f2830637e7dc9c56ce
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:05 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: Reserve space for the FRED stack frame

When using FRED, reserve space at the top of the stack frame, just
like i386 does.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

