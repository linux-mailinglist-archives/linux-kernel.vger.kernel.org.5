Return-Path: <linux-kernel+bounces-118245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6888B6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF5F1F61648
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB161CABB;
	Tue, 26 Mar 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saMGtJH6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjbYUpkv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD7320E;
	Tue, 26 Mar 2024 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415789; cv=none; b=NnGwguMzscpLKoT4DSyLF7CSyyYVjzMcddBoiY7T3iiJI6ltG44WVvEW5bNWB0JxCKyQdWaFwAARQOgLD0aYZv+pLnt2FYdcqS96OjM1imdKgwviG7H/zrEjHlos5jWcu3xeV504MR9lcLBjHYShTcpebIHQUa2ODkrWlMtYre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415789; c=relaxed/simple;
	bh=9qbyq1aKY8KJ8ZZU8MRNuaJcqclapTDNQE//P+JD+og=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MW/YXs02sL9qVnqi7YC6tjebfQZtIJIEC8BZu3DMS2z0VVobe9yYeymij+z3e6D2leBbhAPG57HvFAAIgRZ5hvaCZA9uRxf+EGWPBi7l5q/WrbdikmVzzzWMt/Dx5ZlTW9iQR6sDdzuqlSWQShFwJsfndn6bYLnOaqJUUpblwyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=saMGtJH6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjbYUpkv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 01:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711415786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1yhUwaNgq5rxd8y5zm2NscL86JSQztLE4MRYnn+3Is=;
	b=saMGtJH6nyqImsSq55L30EQkq2g2KNGraLnhI9LbteufzfaDqQiUKAtL44VBJNczzWrDaE
	ghaQfJ3+VC626WpH0IJaDSq1iYaWwLRK1jSxqFmm1+D3kNiNzYduP5+Vlt7FseS5P/SuxI
	/hBAaCdOIgec/A3DDYPTGLWiNmvZ8zDp/HhqXI8fiRk2c9FRm/jrlblKNEejlQ7VfG4SmK
	pO8qKkCCbCm/0wLgIebm2CgA49xsRGedS3GiRLr0OxW5ppLFaEDLML31DsKEGWEUEG2o5b
	cIcDD+N5PCMSPBGoYH+GyYg5IsFov4T03FzWKYsEOHGd9nRuwwPyGpysHAosVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711415786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1yhUwaNgq5rxd8y5zm2NscL86JSQztLE4MRYnn+3Is=;
	b=RjbYUpkvmRyEkXoGebA0pnF/v8GXfiP0opJxzUNVWE7pUFWFN0DGSLI2fj+MJi5HMt7dT0
	Kd00ZTeSGinn88BQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/armada-370-xp: Suppress unused-function warning
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240322125838.901649-1-arnd@kernel.org>
References: <20240322125838.901649-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171141578546.10875.4128601465784419919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9e81e329508576b499b5c47ab106b5fa45ce96d9
Gitweb:        https://git.kernel.org/tip/9e81e329508576b499b5c47ab106b5fa45ce96d9
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 22 Mar 2024 13:58:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 26 Mar 2024 02:12:16 +01:00

irqchip/armada-370-xp: Suppress unused-function warning

armada_370_xp_msi_reenable_percpu() is only defined when CONFIG_PCI_MSI is
enabled, and only called when SMP is enabled.

Without CONFIG_SMP, there are no callers, which results in a build time
warning instead:

drivers/irqchip/irq-armada-370-xp.c:319:13: error: 'armada_370_xp_msi_reenable_percpu' defined but not used [-Werror=unused-function]
  319 | static void armada_370_xp_msi_reenable_percpu(void) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark the function as __maybe_unused to avoid adding more complexity
to the #ifdefs.

Fixes: 8ca61cde32c1 ("irqchip/armada-370-xp: Enable MSI affinity configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240322125838.901649-1-arnd@kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index a555284..4b021a6 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -316,7 +316,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 	return 0;
 }
 #else
-static void armada_370_xp_msi_reenable_percpu(void) {}
+static __maybe_unused void armada_370_xp_msi_reenable_percpu(void) {}
 
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)

