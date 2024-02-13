Return-Path: <linux-kernel+bounces-63133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA548852B57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6091F23EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C751B599;
	Tue, 13 Feb 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FqR3nORj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQiCdoC+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848118AED;
	Tue, 13 Feb 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813599; cv=none; b=a5Kot4nBSZ236qLHd2olGt2dK9nL0u9IqijClLlCgZlgAzB87ta8cJP7we6lylyWRHJusr73P0smYht7pfQSaGBMZmhkrdUHbEMAS06rtfj02pSF2d0xqUiJSx5Hrswnz/PPC3MNtxkn+rNHtnjMaqLwUElh6kXqEYZI6pBNdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813599; c=relaxed/simple;
	bh=FUVFlKXHErfQHwVS12HqcrL/BlrR/XNwXJub9R1UUnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G7v+x5ePbIRzfpmjiH/NMnjre8W212Ezmb0GrFQeTiO0qVDgKCKIcWDxwjKHn/fV4K2F8Vc3NlnetDz3taVy/xJaBXK6XKjSciWXCxDcL+UIFMuJ4BBAhPL9dHfJTfGnBm8GSbVZ5Cy8PXXlGrCdg/BxLK4z0gMzvB5TiLpb/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FqR3nORj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQiCdoC+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 08:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707813589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ormm+PHwLi/CeFwP1A2naAwgJmnQBsAxeCyqCbJneM=;
	b=FqR3nORjlwLo57t5FFCrDcJZrZ4kYwEPfnB3zBdljb27/X2S0xX2X5N9SihSn1NQc9+p9m
	12UEu3gOC/PC2sb6lV3CuXbn8mqNt8AMMAPV3WNrfbZEI8XcwJ9zIhvPidWnUoUFqjOGuQ
	+8U7Cm4V92KF+hRjVZgBSudaUg2Duvu0F5iiDiuXePDzd/mFQB9Jyhfid2cYIrHswjx/rD
	hAfHK/1MqrD+uuYJ3rcd0ls5zadun6mlaxl0VtpKH1LYRHZQEibyq/5ZfSkL7rT7K12TVb
	+ttOU/0+i2PePC6ldcfzwpvzrfj42b+AE8+Tjxg7IyrIGuVci29LO/ONtE/VTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707813589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ormm+PHwLi/CeFwP1A2naAwgJmnQBsAxeCyqCbJneM=;
	b=AQiCdoC+rhHsjRbWwMJIAPgzekYzRRp3O89tm1Qz4JWgVsOPYnTU2xrjeKYHUV6+j9Tvbq
	10p9R4wWT1wFTHBg==
From: "tip-bot2 for Doug Berger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-brcmstb-l2: Add write memory barrier
 before exit
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240210012449.3009125-1-florian.fainelli@broadcom.com>
References: <20240210012449.3009125-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781358867.398.2362878690950793714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b0344d6854d25a8b3b901c778b1728885dd99007
Gitweb:        https://git.kernel.org/tip/b0344d6854d25a8b3b901c778b1728885dd99007
Author:        Doug Berger <opendmb@gmail.com>
AuthorDate:    Fri, 09 Feb 2024 17:24:49 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 09:33:31 +01:00

irqchip/irq-brcmstb-l2: Add write memory barrier before exit

It was observed on Broadcom devices that use GIC v3 architecture L1
interrupt controllers as the parent of brcmstb-l2 interrupt controllers
that the deactivation of the parent interrupt could happen before the
brcmstb-l2 deasserted its output. This would lead the GIC to reactivate the
interrupt only to find that no L2 interrupt was pending. The result was a
spurious interrupt invoking handle_bad_irq() with its associated
messaging. While this did not create a functional problem it is a waste of
cycles.

The hazard exists because the memory mapped bus writes to the brcmstb-l2
registers are buffered and the GIC v3 architecture uses a very efficient
system register write to deactivate the interrupt.

Add a write memory barrier prior to invoking chained_irq_exit() to
introduce a dsb(st) on those systems to ensure the system register write
cannot be executed until the memory mapped writes are visible to the
system.

[ florian: Added Fixes tag ]

Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box  Level-2 interrupt controller")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240210012449.3009125-1-florian.fainelli@broadcom.com
---
 drivers/irqchip/irq-brcmstb-l2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 5559c94..2b0b317 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -2,7 +2,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
@@ -112,6 +112,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 

