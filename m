Return-Path: <linux-kernel+bounces-54640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C584B1DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136161F23EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020B12E1C0;
	Tue,  6 Feb 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aor5CPkW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkLk1BkH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521E12D153;
	Tue,  6 Feb 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213726; cv=none; b=u20rJzB6pfVlujBJmXx4dTYal1tFkB55HRdNYl9JDWkzQHqeDKNop4VFU+12Wu+hI2ADqYi4V1CzW2D/8bv/VyyNLaXoS2n7Su0paY5NehNVXqCzU3iUptxQVr2WNRHp9mmfwaU7pKmqL3sJg0YFP6LCWM4msjO+Ckeyna5Ayb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213726; c=relaxed/simple;
	bh=NfP+FevxDuBK8udXH4wEzkmPr6LHcRF94FOoTA7ST+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jd1npnykcHZpSGTi7YPYgyVL6MvOC9cnaaiZM5GO4irtJmmyorSDdXzxJZKSPASgUMsMUwtct5YYSSVD3VRxV0InS+59CW3B0fr5TIrrKsks1RKkPCoN4RwIbegSlzmqGpAoaNrVmDPlv0P/TuCsoVfGPiiIuera5AJgX6PQIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aor5CPkW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkLk1BkH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Feb 2024 10:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707213717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dEABDVhmMXvMgmsdoO0NeZE5wZSIifSNPNzi2/mS34=;
	b=Aor5CPkWIsuEOunzGsZdyco2B2fG0MDOsK55Z2HabDQ8v7ukEEIXlQX+lPndFQpMpXA3qe
	162MihGQJmdYqtam/GFSOeZMQT2vtXo3aLSKMy/AEl2RVy78OnlMs8ZOOGtg6x93i/od8S
	P22263147fFOg4GQeuNAw7EqJWAxfnU4vtx+boCVIfwCv0nN+hd7l0AtoX/+jSPT1HTwDg
	ail9jzMRVoTWJnGXs6CZsSt9wddBXrd++sk+jzT/hKkfUV/fSXzK0m60McrX/e0pjY/iRU
	XPL1bKJMYv3HYOeleELXsUH5UQaNY2BiGHVQRc6CuvSTIwORsvAiTWu692hVsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707213717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dEABDVhmMXvMgmsdoO0NeZE5wZSIifSNPNzi2/mS34=;
	b=PkLk1BkHud9CJOo/HC2FSyju45aHJo5by3ZTQ2iOlxuk1RZqbdYRMpAmlH4vXivjngroAx
	W0tvoWA+0G8QkXCQ==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add error_putdec() helper
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 "Jun'ichi Nomura" <junichi.nomura@nec.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240202035052.17963-1-junichi.nomura@nec.com>
References: <20240202035052.17963-1-junichi.nomura@nec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170721371655.398.8075896700527309763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9ba8ec8ee67a00eb5631364e4b716f35559724d4
Gitweb:        https://git.kernel.org/tip/9ba8ec8ee67a00eb5631364e4b716f35559724d4
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Fri, 02 Feb 2024 03:51:43 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Feb 2024 10:50:21 +01:00

x86/boot: Add error_putdec() helper

Add a helper to print decimal numbers to early console.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local/
Link: https://lore.kernel.org/r/20240202035052.17963-1-junichi.nomura@nec.com
---
 arch/x86/boot/compressed/misc.c | 33 ++++++++++++++++++++++----------
 arch/x86/boot/compressed/misc.h |  2 ++-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e..bf2aac4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -164,21 +164,34 @@ void __putstr(const char *s)
 	outb(0xff & (pos >> 1), vidport+1);
 }
 
-void __puthex(unsigned long value)
+static noinline void __putnum(unsigned long value, unsigned int base,
+			      int mindig)
 {
-	char alpha[2] = "0";
-	int bits;
+	char buf[8*sizeof(value)+1];
+	char *p;
 
-	for (bits = sizeof(value) * 8 - 4; bits >= 0; bits -= 4) {
-		unsigned long digit = (value >> bits) & 0xf;
+	p = buf + sizeof(buf);
+	*--p = '\0';
 
-		if (digit < 0xA)
-			alpha[0] = '0' + digit;
-		else
-			alpha[0] = 'a' + (digit - 0xA);
+	while (mindig-- > 0 || value) {
+		unsigned char digit = value % base;
+		digit += (digit >= 10) ? ('a'-10) : '0';
+		*--p = digit;
 
-		__putstr(alpha);
+		value /= base;
 	}
+
+	__putstr(p);
+}
+
+void __puthex(unsigned long value)
+{
+	__putnum(value, 16, sizeof(value)*2);
+}
+
+void __putdec(unsigned long value)
+{
+	__putnum(value, 10, 1);
 }
 
 #ifdef CONFIG_X86_NEED_RELOCS
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index bc2f0f1..6502bc6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -63,8 +63,10 @@ void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);
 void __puthex(unsigned long value);
+void __putdec(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
 #define error_puthex(__x)  __puthex(__x)
+#define error_putdec(__x)  __putdec(__x)
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 

