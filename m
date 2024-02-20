Return-Path: <linux-kernel+bounces-73649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14285C574
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27581C20E66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C215099D;
	Tue, 20 Feb 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSgMS4ux";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejtIJ9GJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BA14E2EF;
	Tue, 20 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459476; cv=none; b=r0FenAwC7Fe1fQf5dme9M0B7GEblASFJ6aDPEcXabssOxittbsaN0KxXpeyYMyUy9rbXWvC0jQXhkatEd56aA52gjT6bzq4oCxVWUUiXs3mH6i9KgLGktP+FXaQn2bs4n+NhWpn1FsR0fjIHRS9fGsP3GavjDBaF99ct4yvK5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459476; c=relaxed/simple;
	bh=4TCy4jsz6vOyemxjzKtuVRKXZVG8ITAp56rGYziQQ04=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kVuvQwTCU4Zeg2WGqpGzKWLaC9ksCQhXkSr8JwbmmZXSf1smmteRCXI3GSCaaDHwdqfILdPHBT5/bmAROKvFsUF8/8yKXbIt2IRtEjOgX2RmeTHBy/Cwdv0xKLnIb7VN6pwXw2gmYKDBJZaf6W1vnp2/WU7usIhwuAPiUKUkshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSgMS4ux; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejtIJ9GJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l102G3q20PmtbbBl9BsYNIxEZPbV4Svfrn8Hrss284s=;
	b=sSgMS4uxdfkzzerFLjyS68yPZaXLA9La2C0kYWKvmd3rV1HHIPpDriFu1oabPP/zv9U9LS
	+78dEFwmIE5A2labNv/j6Y+wp8xS/iolC1KvrytB1TpOooQrqCXn/fg1bxpoOJm3MxdqVM
	LDWnVi8h7V+0ZTRQvIs2XhWRY39/Z+pwTBZ2GVo5apapUV382K6lAxniuhCyJ+UJbmXDae
	xsfUCRrIj+TM57nPNEdrksdmtM/ygWHhRSDB+Fgyske3L2YdkxGbPf6Poa7qOTjsxCiX2y
	t5ypciKBBr2PxDBknFX5ZT9UXqGQ8rwSbpMmSgNw+vCQIISvMjL0uP1Lp4vbug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l102G3q20PmtbbBl9BsYNIxEZPbV4Svfrn8Hrss284s=;
	b=ejtIJ9GJXUjP9T8PnIEM4gXE8y9XaKQr2Rq+itm4oQOa4HneHkzSrgFOMy3VjlJLylQ1If
	Ds4j+R4uu062ROCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] s390/vdso/data: Drop unnecessary header include
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-3-anna-maria@linutronix.de>
References: <20240219153939.75719-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845947236.398.8603848028893031556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3ebacc96f8862eb26f8a6568d91bda8ecff19879
Gitweb:        https://git.kernel.org/tip/3ebacc96f8862eb26f8a6568d91bda8ecff19879
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

s390/vdso/data: Drop unnecessary header include

vdso/datapage.h includes the architecture specific vdso/data.h header
file. So there is no need to do it also the other way round and including
the generic vdso/datapage.h header file inside the architecture specific
data.h header file.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20240219153939.75719-3-anna-maria@linutronix.de

---
 arch/s390/include/asm/vdso/data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
index 73ee891..0e2b40e 100644
--- a/arch/s390/include/asm/vdso/data.h
+++ b/arch/s390/include/asm/vdso/data.h
@@ -3,7 +3,6 @@
 #define __S390_ASM_VDSO_DATA_H
 
 #include <linux/types.h>
-#include <vdso/datapage.h>
 
 struct arch_vdso_data {
 	__s64 tod_steering_delta;

