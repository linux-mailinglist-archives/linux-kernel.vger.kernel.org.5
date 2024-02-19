Return-Path: <linux-kernel+bounces-71597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006585A79B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469D41F22E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E543C08E;
	Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zg1JoeF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvbUIcYq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014893A297;
	Mon, 19 Feb 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357207; cv=none; b=LW+mdZiMaQTbehfTFDQbsVrk2bHD8CP8uaTraejfqavNSOx4REh0UiOG5FZcpiZm5apEgkQY410CtiTtRgLEtxtbwrCkGAyG0Oz2dR7PRtL7tRWyyCEGuC9B0sufOzMi/2jLOyPXcD2Yd/r0EVxPxMJa41MEeVzmvw8c4NYavBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357207; c=relaxed/simple;
	bh=4h8ofa9qIf+CH6w8b3X1CVwcM9lNaj4SGvAAsc8wGck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXZ37EqF/ScnB/o0l5w+IrRKRfktIvW8IFLa98zklcJHYRr0wvWTTYj1KZnCj+ziGAZnBa+5ke4K4ZUlS+biDIenEBjsSaukmwnjl8s7/PC7Loal/PY1xanxkdsg8DoWuno3U7XnkEYXqw6F9UeHNlpp2tw4kMaf9v2QEWzJGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zg1JoeF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvbUIcYq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZRHjbrAHlMpISwMWg/IDeX5g8kU9D+wZnJXRxM/GjY=;
	b=Zg1JoeF2lTsifOPN88i8wUjYoB88l/6mCCv9aHFT+TzPxy/CV3SPYQNvhM+2ufjNHCHyUt
	iZXNwPH1UjuztQUIa//DE8fhH7vykwNXWoohGYEi88SYKMyp7mgc0at0Ic1bwIdR7MVqrz
	6jfEIzqP0kcoK9je52kJqkyPijkxyewL+xIgo9HLNfbV56vQaViP6tvgiixJruyuuyo5d2
	MWr/a8z+VPReiC1yHJHYhgPzx4DRu5WV860OCQvSBIRhAV1mT/Duv4yuBQIV+JtzijsjG/
	xven8rQTU35zdqKST9Xxdo9A3n58iLWWIvDgQD0Z8MFYchjZuwEtiSocAl9Stw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZRHjbrAHlMpISwMWg/IDeX5g8kU9D+wZnJXRxM/GjY=;
	b=TvbUIcYqXbpYl4fQVCUcaDFFoRnbUNlRp9JUsTOVB9QFnaPjSxwoQ+7CN/XxxfJnDHoaoy
	Nwsdf4h1ti0R0qCg==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 02/10] s390/vdso/data: Drop unnecessary header include
Date: Mon, 19 Feb 2024 16:39:31 +0100
Message-Id: <20240219153939.75719-3-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdso/datapage.h includes the arch specific vdso/data.h file. So there is no
need to do it also the other way round and including the generic
vdso/datapage.h file inside the arch specific data.h file.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/vdso/data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
index 73ee89142666..0e2b40ef69b0 100644
--- a/arch/s390/include/asm/vdso/data.h
+++ b/arch/s390/include/asm/vdso/data.h
@@ -3,7 +3,6 @@
 #define __S390_ASM_VDSO_DATA_H
 
 #include <linux/types.h>
-#include <vdso/datapage.h>
 
 struct arch_vdso_data {
 	__s64 tod_steering_delta;
-- 
2.39.2


