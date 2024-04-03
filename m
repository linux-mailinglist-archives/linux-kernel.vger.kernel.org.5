Return-Path: <linux-kernel+bounces-129116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AE896532
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C81728422D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FC1548E3;
	Wed,  3 Apr 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzB1vfZ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UISgoHEs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24724B23;
	Wed,  3 Apr 2024 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127595; cv=none; b=iHzZP6DKIeMzz1W/y/BaI89n4C0XwgzESzaPlui+xJg9qXFBUPmMkKwat1SUldiNPZ1By3JMo3BA+1nHd/8xL97DvovrPCtdUrjIIM1yphqQCq7Z7XGGvXnpk6tPOLaQqfFkEIoH5abuIdcamFISFafRmpC1SxvbXicci/HJqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127595; c=relaxed/simple;
	bh=VlfqdKSXYefzmBxkWSQufBOo1HBjBe6rDgGlEVPW2AM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Li8pz8KRF3DP/SJYiSiEy5/l15eK0txK+/qgp/aMcuSq8GHhLhuV1xmhFi8IZcQMdL0BgFo2cPvhMFCElcIult8Sg2FlG/QIkO6fs0A/BiEFWz70sLnXtVu3z4HYXyIbBngtGbjp2yXIGR9Go2wFHZdKAvcD9Bo4llz5UJbXPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzB1vfZ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UISgoHEs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 06:59:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712127591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WK+bCLUwJlPK0cC8dRiKU+R9qSxXMgw6f5WIvjnRYTA=;
	b=HzB1vfZ+BH1oGnsmwWuwYzVeFzX6RsAjmJaMZUUsLpS8drGcEUvgXE0EdZHHaoSB6xbKLz
	M8yy1ZFxaYjp9UHUhDezkQbVKXuzhpyG/AZyN3WxNTV+oYi/73hzR3P31V73qnHslLn1U/
	2TCDVChVt2+SqgRI0eGiJS4q9Zvh0SQ3NZzxrJSay+KJXd7DapdcY+FD1I7WvX7gkxCUbA
	BM7i7cOzJ+MF4sakbauvh9J4B7+rLygvEMkcTYKELLabjuXn+KP3saF8XM6z1D0kO+1fyJ
	un36gQ7b+QwxnnIt4nZ8y+aMqLxmX1bUiENrJXg7K81EKvk/jtg1weeX1YjS+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712127591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WK+bCLUwJlPK0cC8dRiKU+R9qSxXMgw6f5WIvjnRYTA=;
	b=UISgoHEsQaG8/GKJuYmGomFwebsIbZbNiLRUXF4NvvLMHvjztvKDMmm4Evdvt6LDLvGmHQ
	znfzPMWhT5j2wdBA==
From: "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/of: Change x86_dtb_parse_smp_config() to static
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712068830-4513-5-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-5-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212759058.10875.1562775554694124882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     f87136c05714836f1b659365443caccc1bbfce2d
Gitweb:        https://git.kernel.org/tip/f87136c05714836f1b659365443caccc1bbfce2d
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Tue, 02 Apr 2024 07:40:30 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:49:56 +02:00

x86/of: Change x86_dtb_parse_smp_config() to static

x86_dtb_parse_smp_config() is called locally only, change it to static.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1712068830-4513-5-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/include/asm/prom.h  |  2 --
 arch/x86/kernel/devicetree.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 02644e0..365798c 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,12 +23,10 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_parse_smp_config(void);
 void x86_flattree_get_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_parse_smp_config(void) { }
 static inline void x86_flattree_get_config(void) { }
 #define of_ioapic 0
 #endif
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index b93ce8a..8e3c53b 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -279,6 +279,15 @@ static void __init dtb_apic_setup(void)
 	dtb_ioapic_setup();
 }
 
+static void __init x86_dtb_parse_smp_config(void)
+{
+	if (!of_have_populated_dt())
+		return;
+
+	dtb_setup_hpet();
+	dtb_apic_setup();
+}
+
 void __init x86_flattree_get_config(void)
 {
 #ifdef CONFIG_OF_EARLY_FLATTREE
@@ -307,12 +316,3 @@ void __init x86_flattree_get_config(void)
 	if (of_have_populated_dt())
 		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 }
-
-void __init x86_dtb_parse_smp_config(void)
-{
-	if (!of_have_populated_dt())
-		return;
-
-	dtb_setup_hpet();
-	dtb_apic_setup();
-}

