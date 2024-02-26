Return-Path: <linux-kernel+bounces-82386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D10868394
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F72E1C230E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D4132C13;
	Mon, 26 Feb 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfeIC5ac";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RZAQLlx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DB132495;
	Mon, 26 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986272; cv=none; b=NnsRM1HDj3UQlEQoowVOa6Nq1KbQn/Mwt7c55IwAhin2HrN2cRprHgHLfPwftMiV7xiSd5A5AT0VuPMIP4vVIP1lEZX3JnR91zMZbyZcAjooT84fqGUYP324IFlTooZRfuf0N9n97LZglYpeBLzsFnJn9T1dK0rYin0uEapg+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986272; c=relaxed/simple;
	bh=x3++88y6Yyga2IoThm9EeYXn7jl6jLoll5JW4EPO4FM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qL3nXX9ySrwaxrNbxQS+uQ9RT1M1eiYsAbvlIBobLT/wFj8s1VQAENVeSHmyKbiNUA1Jevy4M8q1K49/njrWVQXhng/N6TGio2Y0xFYNjVO5Hps6uxice380pfnDrADq7O7XXiUqAwnowqBy/gcJGMHDzdUtEH+DgrGJ/9uhGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfeIC5ac; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RZAQLlx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLnCpmLMridB4rzUX2oS2TojIlSaDlBpIP7r9u3LGZs=;
	b=cfeIC5acZt1S4R9jg2SAdznuNdWIApP5iSVNMHrNJ9B21tncrkg0P/VHM5oxE0p10EsVMN
	uO99tILOneiiS2Rz8tzxaR13xATmez52/PeRwv3A3NQopX3rdY6kJp5TEkHRrlldY3qMtg
	Gwx4Vh811VR60tZOtYt6/PvjDwzQre6HV1LwpMjW1tszDJG35ZDEkooAJH1+egVacSljdZ
	dOjnXYYdi0JYuIg49ngsr938DYguSPbby+6B3doCFPBkTqsX7jd84Fv89K7nD2q/Cjajyt
	P6RqOwIxZ/ExJwT3braGsTOO5rnx+8tW9bIbrjxzEfGxvAYgwdcIcCtCM20CiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLnCpmLMridB4rzUX2oS2TojIlSaDlBpIP7r9u3LGZs=;
	b=4RZAQLlxV1iZ7Ps05uMkSxHIBz9flIQ1wUk1asMCQDyWmUQ74NgLqetbRZhyveWAgXfudt
	gF8TG47VgzPkrIBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] vdso/datapage: Quick fix - use asm/page-def.h for ARM64
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240226175023.56679-1-anna-maria@linutronix.de>
References: <20240226175023.56679-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898626656.398.2907648829613976791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8b3843ae3634b472530fb69c3861de0b70a5e6bf
Gitweb:        https://git.kernel.org/tip/8b3843ae3634b472530fb69c3861de0b70a5e6bf
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 26 Feb 2024 18:50:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 23:13:41 +01:00

vdso/datapage: Quick fix - use asm/page-def.h for ARM64

The vdso rework for the generic union vdso_data_store broke compat VDSO on
arm64:

In file included from arch/arm64/include/asm/lse.h:5,
		 from arch/arm64/include/asm/cmpxchg.h:14,
		 from arch/arm64/include/asm/atomic.h:16,
		 from include/linux/atomic.h:7,
		 from include/asm-generic/bitops/atomic.h:5,
		 from arch/arm64/include/asm/bitops.h:25,
		 from include/linux/bitops.h:68,
		 from arch/arm64/include/asm/memory.h:209,
		 from arch/arm64/include/asm/page.h:46,
		 from include/vdso/datapage.h:22,
		 from lib/vdso/gettimeofday.c:5,
		 from <command-line>:
arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
  298 |         u128 full;
      |         ^~~~
arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
  305 | static __always_inline u128
	 \
      |

The reason is the include of asm/page.h which in turn includes headers
which are outside the scope of compat VDSO. The only reason for the
asm/page.h include is the required definition of PAGE_SIZE. But as arm64
defines PAGE_SIZE in asm/page-def.h without extra header includes, this
could be used instead.

Caution: this is a quick fix only! The final fix is an upcoming cleanup of
Arnd which consolidates PAGE_SIZE definition. After the cleanup, the
include of asm/page.h to access PAGE_SIZE is no longer required.

Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240226175023.56679-1-anna-maria@linutronix.de
Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
---
 include/vdso/datapage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7ba4437..5d5c0b8 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,7 +19,11 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARM64
+#include <asm/page-def.h>
+#else
 #include <asm/page.h>
+#endif
 
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>

