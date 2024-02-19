Return-Path: <linux-kernel+bounces-71604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437385A7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B90284D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A241218;
	Mon, 19 Feb 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJ3a/vYz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2nFv2f5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427623D3A6;
	Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=n9Oig5dSyZLndSHXTjNIe5viFWMCN07Oo4C3JrBKbJT8wk/cVxa4NYZOszg0rw0UdAo6gGncrgp+47MKG6Y/4NXcKJr5q1duq4nAfDv/JaIo8aGcUiYMp+km/0yUK/0gzXAsKx+Jvq7g/ahjfk/wAeLjVMNtE+LE61F9xKc3ZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=Egt3w6vKpDeIpAiXo8C6D0ps5U8rKblI/NKKhpwZTB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4s6GfogSiuYgEuEhIuRzZgtZm2QMvieFqMGxOrikUDrokoMez2vTRTV1li6hWP2vpcEkV79jag9K5ZVOicxBi4+Q6PYiG4iyo+4Gxf+PYaepAZSiyIijz14WvJuemfcy7FnNi/JzTTH7ZWWBzSsCOR+FbT8UTKYKkUtDQUCw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJ3a/vYz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2nFv2f5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9YNrD7tVQTrXaMc0HLx7Bog9I9Y+lcWW3PT+KiRz7g=;
	b=RJ3a/vYzw3wkv0lfjHWOSa3CQH7dtEAd1TsC2GWp6zruN6abfp84kgYTK1tOfgdD1DwORD
	Rodida/DODREXt5n6/TNYKea1SQifVc/5cLMdEQRveMD2Nw8H/M7SAVIdhvupthNgbkFxP
	9kSMPEiLmverJWsp7bMt/cfJDAO6kMt+I5wIm4WZkr8lNHDcIGgRUEFDsFNDpzqjjvfpuG
	HjZDrKqAJJaqlZJ8DfzuObIdrdPV3WxO04sG50UFPvM2VHIMRYjFw39DyKUpxQQKOxy2SA
	77fMzo1a1QxMcAXAFvNWlZa6fGwQRjQUf9STwBcs1im13Q9FRgc/J04tfWqCNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9YNrD7tVQTrXaMc0HLx7Bog9I9Y+lcWW3PT+KiRz7g=;
	b=H2nFv2f5VzCxp5vwhmWZv4sSB+CxOkUflxB3/09HSK9yyjsJkr2/6UMNUpeu5OPNOcFu/p
	G48PpkvxupQND0BQ==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Subject: [PATCH 09/10] mips/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:38 +0100
Message-Id: <20240219153939.75719-10-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a generic union definition for vdso_data_store in vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/vdso.h | 5 -----
 arch/mips/kernel/vdso.c      | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index cc7b516129a8..afb03d45bcd0 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -50,9 +50,4 @@ extern struct mips_vdso_image vdso_image_o32;
 extern struct mips_vdso_image vdso_image_n32;
 #endif
 
-union mips_vdso_data {
-	struct vdso_data data[CS_BASES];
-	u8 page[PAGE_SIZE];
-};
-
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index f6d40e43f108..dda36fa26307 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -24,7 +24,7 @@
 #include <vdso/vsyscall.h>
 
 /* Kernel-provided data used by the VDSO. */
-static union mips_vdso_data mips_vdso_data __page_aligned_data;
+static union vdso_data_store mips_vdso_data __page_aligned_data;
 struct vdso_data *vdso_data = mips_vdso_data.data;
 
 /*
-- 
2.39.2


