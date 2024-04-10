Return-Path: <linux-kernel+bounces-139291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B808A0104
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD528457D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB9181B93;
	Wed, 10 Apr 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2X3TWX4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGxmOBEp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF318132B;
	Wed, 10 Apr 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779552; cv=none; b=spwLA397kLC3mLwPuOaup5GsXsaQ9AxFFaM30OkmCJHdASWJcnRusbnFQ6s24SfflRUJO/GU7PmP/hQHyTeDKrElXC5sM1KQU1gUq6eN8jbIJSBHP2/7pvra4jdV6oeL8dqCuBj9xmkarOgR+ivwr9yZvt1l8V1SJaNU0RxmO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779552; c=relaxed/simple;
	bh=4VcY5QHkMjO9Oeuya0wisFEUgdxmPJH9LDSVVzdI+UY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XmWiEqhXto7k2YOV0OZ/IL8U/HzbEMBm60afeCSMRF94iDYuW1MfI+0T8ZJ53MFgphtfAfJfht6DIQztyEugv0ChkU+y1z0YtANY9GM9UL8zYPkFRP92dM8rGjcuPn4X49OK/IhDy+p+5QmyxONBpBaP+w7IKGr4WNTTl0yPhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2X3TWX4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGxmOBEp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 20:05:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712779549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzyvKV7DoFU8n8jJViAK7dZ1O569OCvpccWqVmbmCvw=;
	b=Q2X3TWX4iyEjhTAAaf+LCnr0eaDXBoQy+nHiwTogSYLWBe6Wti4QwWSGWzA8XIcZCjtErD
	uED+XZtfqnoW0Tgd/jYMlVwgwAXnE+Tm9qY/T6M44hGvkjhCOA/bQoGMRZ7o76SCmZo/3N
	ZU/MD8bD3FfvLAZpCKZsA9c/HdUCoJgRETa6qy1aV/mBrZhGpAwL4FYM23kV3HLOgv5uYc
	Eoyr7BoOP4fIpLgH4veTa8SRMXqpnerjuCqK3SAghuh9pcy4i/MxFqF30nUrgEuNSIu2hc
	yVG1W5rsoijv3S7nZjQRYRsEf2hAU1iisuJt1EVzDns8ha/9mFlgHyS2srisqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712779549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzyvKV7DoFU8n8jJViAK7dZ1O569OCvpccWqVmbmCvw=;
	b=tGxmOBEpF5TRhzorvZlHDQQ4EkX3a/XVX7boDirEwz6TQdX4t710kYMPwLtSxQxtklDq6/
	my3GKDAZSx9nvTAg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] bug: Fix no-return-statement warning with !CONFIG_BUG
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Functional Testing <lkft@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410153212.127477-1-adrian.hunter@intel.com>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171277954823.10875.13569747246376964639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5284984a4fbacb0883bfebe905902cdda2891a07
Gitweb:        https://git.kernel.org/tip/5284984a4fbacb0883bfebe905902cdda28=
91a07
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 10 Apr 2024 18:32:12 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Apr 2024 22:01:35 +02:00

bug: Fix no-return-statement warning with !CONFIG_BUG

BUG() does not return, and arch implementations of BUG() use unreachable()
or other non-returning code. However with !CONFIG_BUG, the default
implementation is often used instead, and that does not do that. x86 always
uses its own implementation, but powerpc with !CONFIG_BUG gives a build
error:

  kernel/time/timekeeping.c: In function =E2=80=98timekeeping_debug_get_ns=E2=
=80=99:
  kernel/time/timekeeping.c:286:1: error: no return statement in function
  returning non-void [-Werror=3Dreturn-type]

Add unreachable() to default !CONFIG_BUG BUG() implementation.

Fixes: e8e9d21a5df6 ("timekeeping: Refactor timekeeping helpers")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/r/20240410153212.127477-1-adrian.hunter@intel.c=
om
Closes: https://lore.kernel.org/all/CA+G9fYvjdZCW=3D7ZGxS6A_3bysjQ56YF7S-+PNL=
Q_8a4DKh1Bhg@mail.gmail.com/
---
 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6e79442..b7de3a4 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -156,7 +156,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt=
, ...);
=20
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {		\
+	do {} while (1);	\
+	unreachable();		\
+} while (0)
 #endif
=20
 #ifndef HAVE_ARCH_BUG_ON

