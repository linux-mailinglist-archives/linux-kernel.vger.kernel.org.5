Return-Path: <linux-kernel+bounces-68837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110648580D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8031C23AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941214C58E;
	Fri, 16 Feb 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXYKlP40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="js/BmHmR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32181146001;
	Fri, 16 Feb 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096645; cv=none; b=cUmV4/ODmyFlC9qAl5xCQCMb7oMelkhUmCKnuoo9w+pdAVpX0wiFdAK2/GSp7FppsjHqP4C1ozfgrTdZNl2GkhAeFjspVjwG2fiBzMq2TtRULX56e9KOwHsqsPQ1CwggeY2WnkVHD+fzVPO6LOQhmv/aACJ3+9f3eb1SYhUiiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096645; c=relaxed/simple;
	bh=xQ3Nmv0qtbbeuF2j1KWBwFbp5ifZoPiPhtRV9J3XPUM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BVrZ9KipMYxKov+TqIbXBmf6GAfGP53jPk/lVntren1ngRc+3tw9hXgcUWQOiU0fv2n/FPdA1HDySxE3DEmcscWfqoZn6ioGAbWRK6io5CcFiC9iNea0x7DusMGscahO5wGjjgZfL636JBD29zYn9Xx9hJI5BNfjQfiqNcuYgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXYKlP40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=js/BmHmR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUVHMDjVvNB99KLv6E8yPEeFuwnUs0okqaffWIw/b2w=;
	b=zXYKlP40PU2MJpBPBnykIlRoTwPn4/fUDSt1ZqlPcxoj/hpSy/BAybBmAXCWMYWsK+vK6g
	40BsjC4d5xIjbRZ2Gfx0HUfVnLM9Xc63VHUF6f4kpYtQUtcEaMpQn2YDlkICRGS/FnoLyr
	XrAmi9npY958lvVABRE/hrby30GIOz4cLzeOIEQghXIf03ObaiEc0N4IjlnTkQ7xWVFW6j
	XwrUjd047JpCEWsdYIJb8ZAmcbzJ/xrx3SQVfmhUaA502WJ+DX4m1RnlLukOCun/Wbs+mt
	N7TzNVO5kK+84loVxTGZnfMDdaU2441gnLgve4jg1Z6YwFiFrEEv5EIPS5Pc5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUVHMDjVvNB99KLv6E8yPEeFuwnUs0okqaffWIw/b2w=;
	b=js/BmHmRQoWPadg5v2wUeUamOv15gayeseTfSX/ZA5nqbapRC/kBxu4uiD9WqNOTkc+eyE
	jn8+WvOtyGt+CcDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Make io_apic_get_unique_id() simpler
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.119261725@linutronix.de>
References: <20240212154639.119261725@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664165.398.18262468509349196306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     533535afc079b745ae8a5fd06afd2ba51b3495fe
Gitweb:        https://git.kernel.org/tip/533535afc079b745ae8a5fd06afd2ba51b3495fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/ioapic: Make io_apic_get_unique_id() simpler

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.119261725@linutronix.de



---
 arch/x86/kernel/apic/io_apic.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a4219b9..8dc91d0 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2498,17 +2498,9 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	unsigned long flags;
 	int i = 0;
 
-	/*
-	 * The P4 platform supports up to 256 APIC IDs on two separate APIC
-	 * buses (one for LAPICs, one for IOAPICs), where predecessors only
-	 * supports up to 16 on one shared APIC bus.
-	 *
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
-	 */
-
+	/* Initialize the ID map */
 	if (physids_empty(apic_id_map))
-		apic->ioapic_phys_id_map(&phys_cpu_present_map, &apic_id_map);
+		apic_id_map = phys_cpu_present_map;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2520,14 +2512,10 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 		apic_id = reg_00.bits.ID;
 	}
 
-	/*
-	 * Every APIC in a system must have a unique ID or we get lots of nice
-	 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 */
-	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
-
+	/* Every APIC in a system must have a unique ID */
+	if (physid_isset(apic_id, apic_id_map)) {
 		for (i = 0; i < broadcast_id; i++) {
-			if (!apic->check_apicid_used(&apic_id_map, i))
+			if (!physid_isset(i, apic_id_map))
 				break;
 		}
 

