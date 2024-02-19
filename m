Return-Path: <linux-kernel+bounces-71598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0585A79C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E1A1F22D68
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B233CF4B;
	Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0qhxuxn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/DDyv+g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0B3A8F4;
	Mon, 19 Feb 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357207; cv=none; b=OCyFbSGT2xt80hP+ARIp9e/3P6ckOgMkQmfZuudQrloQYGmgW/cEpj1+Gd0dLVTOF+9q8p5X7yXuEgciF4k/TRt5KZrBmvQ1NwfIZseLpDebJ9nZaSCHzmycxQhcB6HyqBXI0oVuu1P5MOXgR1Wfm6KTDi59w5uXKozXd9jXpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357207; c=relaxed/simple;
	bh=58CUWxVlxm2mlSFdFUvdFxekmd2xImPEn9ABAjDBWok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpVdCLzgOeWE0CCAKRTnO/cu2l5Fc4ULel9RUaFK64gq5OxqZcs0esYYWFE0jSmw8em13o+qWV34Q4Zhob1tjF5+YBd7IvEZC5pV8mZw1DzbpfGB2/MhtS8sw1B8qPW21JGTrm2GIZoNZTZx6AJpzfoYvq2XeXpRixHFWPCGyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0qhxuxn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/DDyv+g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U51NQ0C/sqG0k3Ofsflj974vXvNUKI5iq+y1fWYWuoA=;
	b=d0qhxuxnsSpYGsOeZ4U81H1DlPOa3vx6VYhqqfzkE16V+mu361hQ64QzxmFKtIbGhNhQXr
	VSDKAL/F4qd91grgCFQSWZCwW4ltGq3dXvP5xDKep7Hy7LZknzUFGBwhv+3FprUdCmvqRD
	SX/oDNX1uR2BgMca28mK0pUxqoh2xLAqi3DTKH4nYS696Q7dmDSJr4w9BuAzNmZP9f6psc
	yZsaTC3SX/M2ovROraSnk2MB1aEjVIo5KvbO5dCXYupXdxhXyJkcVqyFE6iuIaA44z9Bf9
	qSZ4rCrE6OY1cIbh3kfzXkKassnS4S47ssmWQhkIITzNqzBtNzEAbqnMTHLLfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U51NQ0C/sqG0k3Ofsflj974vXvNUKI5iq+y1fWYWuoA=;
	b=Z/DDyv+guMTwbx7NrIiiBC4hv7+btme15HBUJiJWRwGhFZ2vEP6hlOu7SsG2HnwffOt3kJ
	qPPi7YU5Qg/zmhAg==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH 03/10] csky/vdso: Remove superfluous ifdeffery
Date: Mon, 19 Feb 2024 16:39:32 +0100
Message-Id: <20240219153939.75719-4-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CSKY selects GENERIC_TIME_VSYSCALL. GENERIC_TIME_VSYSCALL dependent
ifdeffery is superfluous. Clean it up.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/include/asm/vdso.h | 5 -----
 arch/csky/kernel/vdso.c      | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index bdce581b5fcb..181a15edafe8 100644
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
index 16c20d64d165..e74a2504d331 100644
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
 
-- 
2.39.2


