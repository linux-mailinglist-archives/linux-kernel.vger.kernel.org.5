Return-Path: <linux-kernel+bounces-28408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DE82FE33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4D1F26532
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86000749A;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PE/UNjSU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D915BF;
	Wed, 17 Jan 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453808; cv=none; b=j9JGj7dCyH6ggmkfczQ6QkoWggSD79rytSBIkO+f7MZYHANLeSb8KpGm7draIVsGSe33N4GQzmSNPpnXlKzDWFDs1UfBleRZgrAlITxiiNhH37HE5VWIQjnIf877lJHvYRNaGO0bAdyUVkqBMrWKWM7lKZCa8oCBiiu/QAJ8/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453808; c=relaxed/simple;
	bh=bj1RQ/zuwjkWVOON+ntuZ6l/PDRcucLrnlepmOpz0fo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=USwirSS7F8wVTpUL+DU6FnjRWcjRkkf2ANJfCEqoBRgtsJ4VFf53m4j1KqXJvAwe+5DIfGMZAS1I945MsrOX1oBaCFiauBhJr6PUZ+N5inoDsoMT5lr5WF7xbwRKuAtAXTFIotY4bRw+f2gGU1ikoBQ9MvnJ2a9UeiRdg6sFk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PE/UNjSU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XBmORscXXZHiW56NHRNnc5Yepc4GRt+FSu1EBqfjiI0=; b=PE/UNjSUdImk5gKFwXtQ1Kgtar
	UJmcWG18mtE+xw+YxDpTozUguLwFIQea+UpLTrVPbjRCr03P+wHx1nYZx69jWLDMAoKlMVbmHfsYh
	ZqdXECVaUChG0wMaR9AiLZHk+jko7XBn5tVjUJ+AD+0XM5YyZ4QJZi19oBi3FV/7Z7u0jH9tpG1BK
	cMzN3z0h/YYSBBupAAKTG7AivxJsInI7LnyX4xN32S79dwdCNTUZsN4uMGA1kYBxig8BOhAXynwQN
	o9GJbEcCjFVA0DIE3Qj0yMqdTwfdlUGyaObzhbXMdYcmb8mGbtDIoZlCuiUQvt24biEHiaqzlqHbV
	cdM5/Ifg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRS-00E6zu-2R;
	Wed, 17 Jan 2024 01:10:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 04/13] ARM: OMAP2+: cm33xx: use matching function name in kernel-doc
Date: Tue, 16 Jan 2024 17:09:52 -0800
Message-ID: <20240117011004.22669-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a kernel-doc warning by using the correct function name in
the kernel-doc comment:

cm33xx.c:366: warning: expecting prototype for am33xx_restore_save_context(). Prototype was for am33xx_clkdm_restore_context() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/cm33xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -357,7 +357,7 @@ static int am33xx_clkdm_save_context(str
 }
 
 /**
- * am33xx_restore_save_context - Restore the clockdomain transition context
+ * am33xx_clkdm_restore_context - Restore the clockdomain transition context
  * @clkdm: The clockdomain pointer whose context needs to be restored
  *
  * Restore the clockdomain transition context.

