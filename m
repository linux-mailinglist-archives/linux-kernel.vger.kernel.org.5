Return-Path: <linux-kernel+bounces-117495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3147688ABFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551A91C3E857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F00149E07;
	Mon, 25 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3YQm72s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZEK9NZ1D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFB73191;
	Mon, 25 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385209; cv=none; b=HqTFbugxhrJvf3H/qKwW6sKhNZWXZ5GW5/zq+ISWxN3ho0k0VoafqjbG6aW617zYhw7jR3W83DodwH/Qi11z6FeUDcaDNaAM+goh6jjzxUx7Ust2Ori+RNIaav6GFvlk8+zbdavOcVI4fwD7zSttEoIJdgvg50e9+Zc9cIwwlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385209; c=relaxed/simple;
	bh=QAv4BR/jdL59PUXbsTS1P4f8I0AkQZMIvuLv4hNp+Zc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FQliUzFY1RCUV+b7YayZh8jwMta/aNWi9ApM9sZrAZkQ5NpCmg2mAJDKmxqIq5th5xhDUeCXR4NbBbr7jx+ngY+cbxjPnWUzjdQe+NOL7o7kUHVJXlG2sjUcUKQHggSMzJ3eRTzoYGOHMHRZRKVUdUi3gwM6dBNcOGeRjkskjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3YQm72s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZEK9NZ1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oGyPYB12iPe/M3pX5cTbA0bbTqJtN0I3MIfdCpjHi8=;
	b=w3YQm72s46l6gjReatH4igTZQ9vB1uCDIUB0dfOR3CqGUCw/zVEjbG6sjxeBpobiCjdsg3
	dWQoxmboroQsyfqKNoNn3olXFYJtevfDwIUIo/GrhxG4gEnd9NxYBOBZx8KFs2t2BXdvjr
	9fTFYIeJI4VyWb8LYmuiGPGwxN3GrrsHwJJZ2mvOPtdm3aB3nvBSCXI+WdAfj+qqnzFcby
	Oxk80gd18+eHxIS4dugOnyP1c/QOKEEPivCiQ+DhIXkiswbYVtNE8R53X8Fma+4HOf0eRh
	87jAubPn7fOGdKmDITwb8xEFu+TMcWQO9PPgxsJSuuW17+8p6K/BpLoTJ7KNGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oGyPYB12iPe/M3pX5cTbA0bbTqJtN0I3MIfdCpjHi8=;
	b=ZEK9NZ1D55DcDfnrGYLrh7WqkSkTnKvv/m4tV79RRV6oSsspczNvtktDcaeNz7cqprxt8G
	3B0OjmAW7uAKGGAw==
From: "tip-bot2 for Keguang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip: Remove redundant irq_chip::name initialization
Cc: Keguang Zhang <keguang.zhang@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240311115344.72567-1-keguang.zhang@gmail.com>
References: <20240311115344.72567-1-keguang.zhang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520530.10875.4664771902622983668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7b6f0f278d02de5a8f49202465c6427b56c97545
Gitweb:        https://git.kernel.org/tip/7b6f0f278d02de5a8f49202465c6427b56c97545
Author:        Keguang Zhang <keguang.zhang@gmail.com>
AuthorDate:    Mon, 11 Mar 2024 19:53:44 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:29 +01:00

irqchip: Remove redundant irq_chip::name initialization

Since commit 021a8ca2ba23 ("genirq/generic-chip: Fix the irq_chip name for
/proc/interrupts"), the chip name of all chip types are set to the same
name by irq_init_generic_chip() now. So the initialization to the same
irq_chip name are no longer needed. Drop them.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20240311115344.72567-1-keguang.zhang@gmail.com

---
 drivers/irqchip/irq-sunxi-nmi.c | 1 -
 drivers/irqchip/irq-tb10x.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index e760b12..bb92fd8 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -192,7 +192,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name		= gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 6805863..d59bfbe 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -150,7 +150,6 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 	gc->chip_types[0].regs.mask          = AB_IRQCTL_INT_ENABLE;
 
 	gc->chip_types[1].type               = IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name          = gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack       = irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask      = irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask    = irq_gc_mask_set_bit;

