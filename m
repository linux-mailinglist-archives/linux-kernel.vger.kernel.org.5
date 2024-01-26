Return-Path: <linux-kernel+bounces-40105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CA83DA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4261F26C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C31B956;
	Fri, 26 Jan 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YRvivAIC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKmwjGIa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3661B7E8;
	Fri, 26 Jan 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273622; cv=none; b=Ir2hlDBjo2Cy0EEr/UpY0OKXyyTpSk86Ku9hVEOGnclAH0+0Sp27Qy8MY82O6kzTcr1j2yXyNh/dvjHcJl+W8ed4ZotMiYu6h38V2mj9a8x5s1sV5aFCf4CllnXIiY3cr4LnMeWlh7XFXrUGRSJJtDTRov+47Mm0Z4fWDs2YNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273622; c=relaxed/simple;
	bh=crEkeVj7Bs+xMpRjnPknM/Yqxm8h3ndBVuH6Jl7K/Mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YK7rv/ySP3YVirAbqvbSpSSKTg9e6KZRdisstnU4/iT4ZFQNW8cIajAnsF2yOg/e7BXae2a0nR0whD16hj60uOYb5iRyz27D24DyLCXFCvPRS2mkCbHCsxj171u+N95JuHSRx205vY9Rssf1YqVYJS3hgWKgey9ZG/QVtK53EcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YRvivAIC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKmwjGIa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 12:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706273619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ft2WJzQF+PY1zHfzprvk0m7UItI04v5JPkKm6TXQoS0=;
	b=YRvivAIC9E+lnCavi2pAnhQC5O1opjJYoWW9rjsrffB6j6n8CaXK7x8OH+m/RoNkwM08ko
	X2gLmZZAFz/q+sLKtn+0SYNNhSiG1diBoZzLR9X+zINDSLCDB+hkXKmne7CnAS2HEVJ0lI
	tdSRsBimswNdGQPJN3fG8+FT2piyX9TP8VJbF56gDPsfrLjBIouGTFz4lff6GlkYDZkTSU
	/8MzajJD8oxl/HeuIWJMidu3CRGvissYfW6fbEPK0KAuxeEtGqcQqwmdMUDw2aJLb86bYU
	5G7251Ky1mr+yRcabiYzAsrkXHJvyoCxTR1HUVSUYXPFpr7yeZsXn59Q2HDm3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706273619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ft2WJzQF+PY1zHfzprvk0m7UItI04v5JPkKm6TXQoS0=;
	b=WKmwjGIawcCS3ps325F5cdDRwZjH/Su37OChK1NyyBWfR+xNg6dvEb004qQBOt57bMsULs
	EZSUqR9t447VCPDA==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] bitmap: Define a cleanup function for bitmaps
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122124243.44002-2-brgl@bgdev.pl>
References: <20240122124243.44002-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170627361832.398.12750100629168138899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d12a82848eac28d248e67940378fe4a72b0a8cd3
Gitweb:        https://git.kernel.org/tip/d12a82848eac28d248e67940378fe4a72b0a8cd3
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Mon, 22 Jan 2024 13:42:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00

bitmap: Define a cleanup function for bitmaps

Add support for autopointers for bitmaps allocated with bitmap_alloc()
et al.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20240122124243.44002-2-brgl@bgdev.pl

---
 include/linux/bitmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 9945143..df24c8f 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/find.h>
 #include <linux/limits.h>
@@ -127,6 +128,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
+DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);

