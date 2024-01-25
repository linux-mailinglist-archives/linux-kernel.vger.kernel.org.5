Return-Path: <linux-kernel+bounces-39110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E456A83CAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F829B446
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602F14078F;
	Thu, 25 Jan 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iI/Eruei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T1W++Nn3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7413D519;
	Thu, 25 Jan 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206901; cv=none; b=UfOcZJOtzBXg/kcz50xUn0vfcm7Q95E4Q0Sp3kpmQrcix8qhEYP+IjthGe+OK9HK4tmemGuKKXS3bndmKxloizRcKYMxkN6qgzakpqBeKucU7UnC2yLmg7yxPuN7/L/SJdpf7uzX3dQnY8rFWlT+wtJtKDVBZjqr3oVLD7VQjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206901; c=relaxed/simple;
	bh=9HNbCqXqfwUs7zSRBHZbKSyO5jyHiLF+EI2wqtSx5xM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nLUCsqBMjXMGy5SdlxC7Zjha2/NLskFVz5i5SYDsuAD4vBBg87oO4Vbn+hATk68odsRxkpjWOkAlvYVzUjClJudyuYpwJZxXJzBp4iRwqWVOPVzauBoCCgryRna3FTF/RvUR1vb62ZR5N7SQtYzcxzthtgSxGOM8llJcshWTm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iI/Eruei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T1W++Nn3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjJ09yt8uNcPF3b8qNxyWiN2kLfQdJmilN7ktn4gKpI=;
	b=iI/Eruei7Bthf3wpnXx8/S2GYa2vx/704U4EJC6cr07lfkhLeEcYOscWuI8t2mTGOFXdh2
	qEog+QqInwkM+dX8AZJCpQQu/0VmGVVY66yQhhIXgpcJH6arS5IpSs1dksYz5LQ29LNYDv
	k5srGpdHYUr21c+ihJyZuVNbuIbOU20MdSzTd+qwTKDDcLk9+8XzPcQix13knNC/ppVzFr
	1RH0ydITj8p0E0raJui78cv6ppDfnX0O/Uk3H55gmqG8rgUuYAN8t1BWU/Bb2ADVEBEGMA
	Eip4YGSLUcgUqG/xUF4aUESp17UVxRmUGsOBMhCw6TJkdbQ6ngL0Gw/xGGdkug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjJ09yt8uNcPF3b8qNxyWiN2kLfQdJmilN7ktn4gKpI=;
	b=T1W++Nn3O6qlO8RJiwAYJMqbsZ4uHdZLBmolrd2wK6sdgQ5fKSB+1spm6GJBfpnUei7qD9
	jmL78LdSebQdM0Ag==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/cpufeatures: Add the CPU feature bit for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-7-xin3.li@intel.com>
References: <20231205105030.8698-7-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689669.398.1849686617170032778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     51c158f7aaccc6f6423a61a1df4a0d4c0d9d22a9
Gitweb:        https://git.kernel.org/tip/51c158f7aaccc6f6423a61a1df4a0d4c0d9=
d22a9
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:55 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/cpufeatures: Add the CPU feature bit for FRED

Any FRED enabled CPU will always have the following features as its
baseline:

  1) LKGS, load attributes of the GS segment but the base address into
     the IA32_KERNEL_GS_BASE MSR instead of the GS segment=E2=80=99s descript=
or
     cache.

  2) WRMSRNS, non-serializing WRMSR for faster MSR writes.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-7-xin3.li@intel.com

---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c         | 2 ++
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index bd05c75..ccbf914 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -326,6 +326,7 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index e462c1d..b717420 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,6 +82,8 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
=20
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/includ=
e/asm/cpufeatures.h
index 8792841..953e6ef 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -321,6 +321,7 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */

