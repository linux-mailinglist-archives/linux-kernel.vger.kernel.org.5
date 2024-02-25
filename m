Return-Path: <linux-kernel+bounces-80241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2773862C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3211F21982
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5AD19BA5;
	Sun, 25 Feb 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bWACk36R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNRu4Cxy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C75171BB;
	Sun, 25 Feb 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883914; cv=none; b=rNPkSgYsrAiLvtjRUOC7VwqXWkWzJcjOqJE+Zd/xU//x8wsVQTzfenK6qr7DU+hmCI2xe0azcdorFiydMdcXOdDPARxT0n/nS97da+WrKz1xKCCcjgOgl0vZmAJPJMio22FzcldgGkcm4lTm3ACyPoP4ep6XOcZoiz4VCsfiC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883914; c=relaxed/simple;
	bh=472xf2OqAqsnb8f5NspBuhlX9Z+q0YjWrpV1JR9Szyc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NO43FIUQyklmWcUE8mpU5Zrnzu+nySZqMke3wAe4rbAwTW3hgJxBZZZy+5f0cP5wksbK2w6v9N8lfmMUc+rWdOaOYw6FS0g51wJlaDyK+QPuW4OWbNtylwbNHqbDvUtYcxT0FDIeUPjw/yt5l91uHpX05TDosaiZJLVDdPvTnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bWACk36R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNRu4Cxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Feb 2024 17:58:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708883910;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXjJ/yLSDKkAyllwMWv7UrxuK11qrnr7cHr/R7Ucfmw=;
	b=bWACk36RKnC3ViCuFpaNrfi0/ALLx1Ua4VDayAOjibptVuN0ftNpKvm5xD0cw8AkTfNeY7
	nGb1xMvVTx7MXEX2aOqBsMF0RD7PN23sJtIGC26ISoMgnx2dR+aKvGn+h2iheD1L+iHAcY
	ygY8VAOAx4lG4WA7s1ye1D+QvSNE1ltBlBcEvdV2u1Oc/JJhDOOFdaymdasIPR0EScB54I
	7UYaY6ZabXWYqz1DPhm0fjpwY23uPd2vd8APVfc+0jhD0H+XKL2OLeLKBiO/w47lifvNqf
	q/Pam/afLyw7fLt+qW/xB/KwNXiLN14jLlhS6fY1OSYGz1LcnGlVAOjXtQX4Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708883910;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXjJ/yLSDKkAyllwMWv7UrxuK11qrnr7cHr/R7Ucfmw=;
	b=uNRu4Cxyu+6cClX4n6yY4Ca8+AAOdVCr7EoCzQXeyAGdQuiGWM17F+lFyzEJFdfxC0xkZK
	JRVDjwsDcWa5eGDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for
 HPET/IO-APIC domain search
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <878r38cy8n.ffs@tglx>
References: <878r38cy8n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170888390974.398.7311200606480641097.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     c147e1ef59d4751a60687074e4268ecc0ef31b5c
Gitweb:        https://git.kernel.org/tip/c147e1ef59d4751a60687074e4268ecc0ef31b5c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 25 Feb 2024 16:56:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Feb 2024 18:53:08 +01:00

x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC domain search

The recent restriction to invoke irqdomain_ops::select() only when the
domain bus token is not DOMAIN_BUS_ANY breaks the search for the parent MSI
domain of HPET and IO-APIC. The latter causes a full boot fail.

The restriction itself makes sense to avoid adding DOMAIN_BUS_ANY matches
into the various ARM specific select() callbacks. Reverting this change
would obviously break ARM platforms again and require DOMAIN_BUS_ANY
matches added to various places.

A simpler solution is to use the DOMAIN_BUS_GENERIC_MSI token for the HPET
and IO-APIC parent domain search. This works out of the box because the
affected parent domains check only for the firmware specification content
and not for the bus token.

Fixes: 5aa3c0cf5bba ("genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/878r38cy8n.ffs@tglx
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 arch/x86/kernel/hpet.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 40c7cf1..e66c775 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2354,7 +2354,7 @@ static int mp_irqdomain_create(int ioapic)
 	fwspec.param_count = 1;
 	fwspec.param[0] = mpc_ioapic_id(ioapic);
 
-	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		if (!cfg->dev)
 			irq_domain_free_fwnode(fn);
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a38d0c9..c96ae8f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -568,7 +568,7 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	fwspec.param_count = 1;
 	fwspec.param[0] = hpet_id;
 
-	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		irq_domain_free_fwnode(fn);
 		kfree(domain_info);

