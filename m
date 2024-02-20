Return-Path: <linux-kernel+bounces-73648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64485C572
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17934B24199
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B2B14F9E1;
	Tue, 20 Feb 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2/dHB3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKYi36CV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765314D44A;
	Tue, 20 Feb 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459475; cv=none; b=rLIlLTuTxSmw9stdVzsbXpnmZORlz5U2/lRH1x1+Xem4yPxoySYUCLtT0w3TZERgrUpRM7ZdnObYsVCn0fS9dWxh0SOhtPNq1qQQfFeWPdXSnNg/ueXCftm9AudpARXIQcmzXo+bxZtZx/shGWml9Zg5Va51IazqIHkUTbnyfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459475; c=relaxed/simple;
	bh=eEoqsfwjMP7shFa4kXo0PsUew5lxMiJtKf43SuYBnXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MnntzAAxi/RJviOVJcVKEU+dZh3/RAsagLJPYybD2h12NUYYWsIveaJylhZYUtdBdhuxIFG5RBTBSwMDQZWfJfm+3kJNfo2Yv+oqPa0nOTseQ8R0c4QbUf8zb1OHf/Ui5dOEVX/GKpgQDxoy0YU91fdOX7HpJFYOItabYYmoXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2/dHB3z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKYi36CV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIBUMm6O87L0p27q8995FI6EXw/DkNExRcvosaiWqiY=;
	b=R2/dHB3zEnqAmfhe03HDL6UiFKhuvLPaA5aG+Pb7XtiUpP7l9xAVYC5FJul9hDEzABdmWM
	viS37m4bczW5xscEBChEpsIWxTHe0veo6GTxX/kZl/uM+gjuuogY1yk+6Je1+q/s5rPPK6
	S6hXIDxh/0qbjRnPF653O5Txcr+7YMX5zMqQHRaAO/TdPuEsZ0k/ilmBlF4kGMYOrKM4V8
	lBHzskFGEN1I6dBzg6XlbRFGn5K1CP4hmIkqw+UUoTbHTP2FSsQuB9XXv9jFLeV+kbRJZe
	2tu4jKLO+XpZPGTORoX7Mjj4/Ew9qPl9VBxccSvhxelsjWWHaUtPYqQDOhKu7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIBUMm6O87L0p27q8995FI6EXw/DkNExRcvosaiWqiY=;
	b=GKYi36CVnaMDf6+iWqVxEhFjR4rQKzATNKzBTRAUb0wiJJdua7beVA6x4+louGgRy4WkBO
	9sGy/iycR0VVdCBQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] csky/vdso: Remove superfluous ifdeffery
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-4-anna-maria@linutronix.de>
References: <20240219153939.75719-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845947148.398.9186363038131049493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4eb0833d7de058735a424f1f783126c60a346b34
Gitweb:        https://git.kernel.org/tip/4eb0833d7de058735a424f1f783126c60a346b34
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

csky/vdso: Remove superfluous ifdeffery

CSKY selects GENERIC_TIME_VSYSCALL. GENERIC_TIME_VSYSCALL dependent
ifdeffery is superfluous. Clean it up.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20240219153939.75719-4-anna-maria@linutronix.de

---
 arch/csky/include/asm/vdso.h | 5 -----
 arch/csky/kernel/vdso.c      | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index bdce581..181a15e 100644
--- a/arch/csky/include/asm/vdso.h
+++ b/arch/csky/include/asm/vdso.h
@@ -5,11 +5,6 @@
 
 #include <linux/types.h>
 
-#ifndef GENERIC_TIME_VSYSCALL
-struct vdso_data {
-};
-#endif
-
 /*
  * The VDSO symbols are mapped into Linux so we can just use regular symbol
  * addressing to get their offsets in userspace.  The symbols are mapped at an
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 16c20d6..e74a250 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -8,11 +8,7 @@
 #include <linux/slab.h>
 
 #include <asm/page.h>
-#ifdef GENERIC_TIME_VSYSCALL
 #include <vdso/datapage.h>
-#else
-#include <asm/vdso.h>
-#endif
 
 extern char vdso_start[], vdso_end[];
 

