Return-Path: <linux-kernel+bounces-73364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE285C17D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098AB1F252FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4F76411;
	Tue, 20 Feb 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w9rY6w51";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwPDhjEF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB442599;
	Tue, 20 Feb 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446797; cv=none; b=ookeGdks1xsNYBe87UatrO4rqVjae76cK+/nrZ8EmdcMFa7CkkgCnU4BH9JSM2w5tfm317c8EoqfSpvgN01l4d/LO2anGh+6rZq84p3pB6JOmrDyBtrJHk2owrg3kIKjpTTaAEZuMUebErsiWuqXXOGDsfCaKSOa8fTVoZAPuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446797; c=relaxed/simple;
	bh=q3xOFmmgYocZ65Gcmtj5ydpXXT8KXajM7sCn5iFfJo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tEvAAnR/wynzHwue3Kr3SjocRDMsBkWPIJV1uRRcBTirDzdKsO+Fe5nLv5ZXPbLDec/PhG8HRkL88TTt2Iqj6mS0W0ZF5//bHjO57UWELhP0Yy0NcSm8/yaiRhzkCBLcwePhZeaPPjh9kJS0ciu+mCoPiato74JxAHxIkn7KFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w9rY6w51; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwPDhjEF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 16:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708446794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiCpFqPO/YFVtMSQiZIaMJWevt41KU4rXVeZn6KjaEI=;
	b=w9rY6w51cVeLLoYUlm4l5Ixp6KmVzdBL3gDDSjkqvbHXCGEkZbC2OSqb8Z1oGa+pOd5mrH
	Ke9GsAorIkMMv2kmlA7t55exuuxgapgZiIaz599jSaMZY2vjZP7kd63atlIaIOnxKF1sq0
	Di6pjEFTt6nB73Lt3F0bZnmgRYTNQh65jtLZvWlhd721QkV1obea9oScWUgDpTcsRvxrXv
	y/9XTRCZBR4+E8GrlNeQ6ZDd9UK0RdY5wZtqY1Ht8TpdGl/a7qXoCvVcBxve7qcWg84oi6
	4OR5rl5CY7DxvYamYHpWMCYNUEsowUvUxwA6Q7meBRZp3kw1knlzBP0M/q2g7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708446794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiCpFqPO/YFVtMSQiZIaMJWevt41KU4rXVeZn6KjaEI=;
	b=VwPDhjEFw4yeGgBCltAWzMXn9G1KlTHBh+gIoN689UgyDZN/1I2m19mQVSWLe9GTDerJRw
	L/uJqJniMeWVc0CQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240220114731.1898534-1-maz@kernel.org>
References: <20240220114731.1898534-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170844679345.398.17551290253758129895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5aa3c0cf5bba6437c9e63a56f684f61de8b503d6
Gitweb:        https://git.kernel.org/tip/5aa3c0cf5bba6437c9e63a56f684f61de8b503d6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 20 Feb 2024 11:47:31 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 17:30:57 +01:00

genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens

Users of the IRQCHIP_PLATFORM_DRIVER_{BEGIN,END} helpers rely on a fwspec
containing only the fwnode (and crucially a number of parameters set to 0)
together with a DOMAIN_BUS_ANY token to check whether a parent irqchip has
probed and registered a domain.

Since de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction
from select()"), ops->select() is called unconditionally, meaning that
irqchips implementing select() now need to handle ANY as a match.

Instead of adding more esoteric checks to the individual drivers, add that
condition to irq_find_matching_fwspec(), and let it handle the corner case,
as per the comment in the function.

This restores the functionality of the above helpers.

Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240220114731.1898534-1-maz@kernel.org
Link: https://lore.kernel.org/r/20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aeb4165..3dd1c87 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -449,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select)
+		if (h->ops->select && bus_token != DOMAIN_BUS_ANY)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);

