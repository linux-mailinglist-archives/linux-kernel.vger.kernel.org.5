Return-Path: <linux-kernel+bounces-39104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23383CAEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869151F26CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7613DB8A;
	Thu, 25 Jan 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oTFtPwv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wRYN2yQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FC1339B4;
	Thu, 25 Jan 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206898; cv=none; b=dyhJeWQFrQ/nL7yKl9S6s1I661Zt0Fb7ozTwUw6H9Qv+0JQrZAs6bE2L0n6sFUbokPALqlK10kM04gNqGIxd+Eb6VtHPaDTeHtWfqbe2WryM5R4V/P0lA7uRY2CFT9pJ8Sye540gfHdjTRxpwHnm526kwC/p3DF28P3Ytss8otA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206898; c=relaxed/simple;
	bh=Kd5rZEVHDxAzQi89iKepGmUdUn1yDhK/tRZzlxhQzAs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=omim7f1POnqk8HjusTJMdaxXLJcd+m7Kx9phUZEX84b63WI2cnrJo7M7EcT0vvUu2QqUb6kcWHHxwIMUk/1HvTkkfknOMEz4R3CFFZIWQzeTI/KJbM0wrcoSVCj9Xh5/5XzC1XQAWPR4eL0fgiR7NWInxCi8HXc4ACvHP4+PH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oTFtPwv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wRYN2yQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJW6BhPib2WJgwSlHcd29XLukPixakyXB4kael0mI/c=;
	b=0oTFtPwvIKZXyV6BbEdBqXwvKOJENLlz+P7rCC8DZEVzx7u/BKe+9et3Cv7zSd/Glc8Tkh
	/i4/wOM4A0klI2UpQgrQvMZtGkCNOyT/5ukwF0thvcCNeKj63EKEd0Ou6qYrITgQ58Ia2P
	Ck2v1iNrkkjcdfaNblYVIg3t1bRDf8oVusgFGs6UbdcHZWYQBXBRChhmsVaAOJbJikgdJK
	X/ReqQ8MS/9nItzpUR9fLllcGlo6GiPcEMNLo36OF+qUdsdgCCWSkWkO+CRhWHMSTMHvXu
	UEm5lQGIrgAvW30eVloHeCK57RyJtkcw7uMpHzKiWwBNmaojjIvr3/XwpGKlvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJW6BhPib2WJgwSlHcd29XLukPixakyXB4kael0mI/c=;
	b=3wRYN2yQafHdEVrsExQ7Z0y37bAR3FvX4liJs+UMvIOvxuGnVPX486nqHUz4GrzaNiFuK3
	WwLk/SzFhtJqCsDg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/cpu: Add MSR numbers for FRED configuration
Cc: Megha Dey <megha.dey@intel.com>, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-13-xin3.li@intel.com>
References: <20231205105030.8698-13-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689303.398.14397485081350873453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     ddac193611e57d194328ebb0439ebd5ae4025b9d
Gitweb:        https://git.kernel.org/tip/ddac193611e57d194328ebb0439ebd5ae4025b9d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:01 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/cpu: Add MSR numbers for FRED configuration

Add MSR numbers for the FRED configuration registers per FRED spec 5.0.

Originally-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-13-xin3.li@intel.com

---
 arch/x86/include/asm/msr-index.h       | 13 ++++++++++++-
 tools/arch/x86/include/asm/msr-index.h | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b9..1f9dc9b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 1d51e18..74f2c63 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)

