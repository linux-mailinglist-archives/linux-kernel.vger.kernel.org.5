Return-Path: <linux-kernel+bounces-128050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF65C895564
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A51C21B24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380C85286;
	Tue,  2 Apr 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUkzgNg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8qM02Mf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFB84039;
	Tue,  2 Apr 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064516; cv=none; b=SdvB8YBB2WRjWnp6VTYHLb4QS6vGgJ9FIsRyLb6TFVIImc0AEGgJkQUDSqSI09atyfoeFnYV3tWAtqLWSD/3yyf6i4fC/aY2ukJxNUvAiEnQrKJjOH9bKYGr+a44oVZojCbXcgMVZpBzdQWx/LNBKWY7m/lqqoGnPBRXq2np2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064516; c=relaxed/simple;
	bh=RXbAtwMy42ElQNB3HQ3sNrOz2iVr2dp/A3YxBpbmuag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZQVDbxgAQpIdwzdpfYC08QLvIp/ovNHwnzIHxqrm0sx8Zk/PzYEZbqb22jGHdvE4NX38hklaDfSRdBr1MSI97KiIdUVH+vNYErtUVtMbcGMzCn/S7CsDSWs/sURYLZWjydX50IdVGaj83ST6KSvn2EixQHqDv7LFfCEUHVCG8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qUkzgNg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8qM02Mf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Apr 2024 13:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712064510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqthSyu1ONMJcVYmPNQezj+3N69fQK1nHLGRpF+ZG+M=;
	b=qUkzgNg/utr0FzZd074xnns7LMkjKMmLXJ8+1UGEnNqtc37I0WFJC4otAVkk39NB0g5YfB
	hrkPTzRID+UVpF8aua3Z7mArdXARnFgp9c1aVoJZ8v4p5/B6HcF9aw81iLyUC/DD/OzNhD
	77cOddhNlopnXoz3EoGwJo5LranHp1aL5F/0FrhFmWRXjjUUTVSoJChzLBETJq2P9d3Hyt
	GYMo++yp4Eb4TQfWlr39TGvxCGnIuOeCUz56KbhQFHr+f5C/6glalelpQrCvtU7FYH5HFS
	m6uIhO1nT2fSeKAH5hlbO8F+0uBmLi06KIrR8cyRmXcgcEd98f2jGzLXb02UFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712064510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqthSyu1ONMJcVYmPNQezj+3N69fQK1nHLGRpF+ZG+M=;
	b=n8qM02Mf3WURARyMw8J/vEjdDkx0iC95LKTjbz+EswPyX4S+JVzNI9+FAfHKb5A92s7cNT
	ZwLhFlbwKfhuSQDQ==
From: "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/32: Remove unused IA32_STACK_TOP and two externs
Cc: YueHaibing <yuehaibing@huawei.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230625125411.25840-1-yuehaibing@huawei.com>
References: <20230625125411.25840-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171206450950.10875.3799270619287955319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     52b2c101b9ce3b954ebbed4c24396ec28f66fcd9
Gitweb:        https://git.kernel.org/tip/52b2c101b9ce3b954ebbed4c24396ec28f66fcd9
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Sun, 25 Jun 2023 20:54:11 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Apr 2024 15:01:40 +02:00

x86/32: Remove unused IA32_STACK_TOP and two externs

Since

  32974ad4907c ("[IA64] Remove COMPAT_IA32 support")

IA32_STACK_TOP and ia32_setup_arg_pages() are not used anymore.

And

  675a0813609f ("x86: unify mmap_{32|64}.c")

left behind ia32_pick_mmap_layout() extern declaration.

Remove them all.

  [ bp: Massage commit message. ]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230625125411.25840-1-yuehaibing@huawei.com
---
 arch/x86/include/asm/ia32.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 4212c00..9d69f3f 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -56,17 +56,6 @@ struct stat64 {
 	unsigned long long	st_ino;
 } __attribute__((packed));
 
-#define IA32_STACK_TOP IA32_PAGE_OFFSET
-
-#ifdef __KERNEL__
-struct linux_binprm;
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
-				unsigned long stack_top, int exec_stack);
-struct mm_struct;
-extern void ia32_pick_mmap_layout(struct mm_struct *mm);
-
-#endif
-
 extern bool __ia32_enabled;
 
 static __always_inline bool ia32_enabled(void)

