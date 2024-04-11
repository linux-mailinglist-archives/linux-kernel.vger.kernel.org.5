Return-Path: <linux-kernel+bounces-140260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019A8A1079
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8F28AB61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C58314D449;
	Thu, 11 Apr 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2geq2B1u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTAv3j0i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A6146A74;
	Thu, 11 Apr 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831620; cv=none; b=RfxQsHR1y5JKXbRk+mtcv/owEWt9lvJW+4PPKmbGzEEfTviYQUc6aACi6hPdORXaN1qV8bCBH9TAp/KBC2UWHiNHf+SKooiX5J+skbqQRxRlJHbebT74Sg0PmUKJSNZs1G5qyHTQlCEK3s34xK5XWwx2z81wz5J7kF1J0sMT/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831620; c=relaxed/simple;
	bh=yT4/VxLXMB/+uJJSBfHcYF/pCdSW8LMQJNrERz9bZuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DlzokZWag8bcIp1WDQFNRNB0dfvvZ57on07RnUzsPjNMMAMOSw2gpNm7j+uXYPybTkoQlvNv/UoCclFMYR+maP2aLZrVyJbT+KbiBpQkf/6sUXBYJNurobYmFXsG3IGIAbq9ghp14Pz4TcYo2eqN1xKct7j45DRC51XMQSKkRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2geq2B1u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTAv3j0i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 10:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712831616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e387RiNr07lgjmO0ZNePR+Ip91jIkCIo+LZIehyfm0=;
	b=2geq2B1u1JLxzdHIpnD3eD3Ri+G/HnYC9VdtLRqXzcxQgU5quHo7Dj+nTyMP34uP7IplPC
	A8Q+dJxoCsTGEpdP6ZjlepxzoScRATV43Q66OXBuROXmaHiD41AFni0crF+Ic8zMlyA4km
	WuXxJJpJUv7keEAltD89xTt/5nXtRbgxnq7KLKh/ANdA79voIRMk3gt5lihsE/6b+6TZNe
	PBu/N9XotXbS19Zhhn57aPugLN4YQ79V94wf4JSzpTrcYafEwhj3clRX0HofO99GBjkeKc
	tMpWjZvqn7gl27qmLKr7r0k6ePaKuPInBgQwJ4nPxo0Q0PszwF3qvIu6sUiKgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712831616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e387RiNr07lgjmO0ZNePR+Ip91jIkCIo+LZIehyfm0=;
	b=zTAv3j0icFrLxooArsN+YJ7sLmNdmUhfr6I6IH+ukEBnRNqSx8vSDcQ+M2dKC3RM8SJC9S
	DKcM/Nymv16DqFCw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Update MAINTAINERS to include interrupt
 related header files
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240405185726.3931703-2-andriy.shevchenko@linux.intel.com>
References: <20240405185726.3931703-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171283161501.10875.11908832823188260337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     81e4cb0fd45c84d416e3edffbf6ae62c89ce6b5a
Gitweb:        https://git.kernel.org/tip/81e4cb0fd45c84d416e3edffbf6ae62c89ce6b5a
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 05 Apr 2024 21:56:45 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Apr 2024 12:29:40 +02:00

genirq: Update MAINTAINERS to include interrupt related header files

Interrupt related header files seems orphaned, add them to the respective
subsystem records.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240405185726.3931703-2-andriy.shevchenko@linux.intel.com

---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a909b1..adab4f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11435,6 +11435,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
 F:	include/linux/irqdomain.h
+F:	include/linux/irqdomain_defs.h
 F:	kernel/irq/irqdomain.c
 F:	kernel/irq/msi.c
 
@@ -11444,6 +11445,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	include/linux/group_cpus.h
+F:	include/linux/irq.h
+F:	include/linux/irqhandler.h
+F:	include/linux/irqnr.h
+F:	include/linux/irqreturn.h
 F:	kernel/irq/
 F:	lib/group_cpus.c
 
@@ -11454,6 +11459,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
+F:	include/linux/irqchip.h
 
 ISA
 M:	William Breathitt Gray <william.gray@linaro.org>

