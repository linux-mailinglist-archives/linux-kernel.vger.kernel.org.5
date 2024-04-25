Return-Path: <linux-kernel+bounces-158540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2138B21DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1757928264C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8E1494D2;
	Thu, 25 Apr 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UO3Prxdo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rO0YkVen"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56012BF26;
	Thu, 25 Apr 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049212; cv=none; b=e/mvhkUXBrGjwINaGe78AUj09b9lRKvY/UlPewrw+Vgf0aXIhrfvC1V6GzL3gbBk6Zokh7Pke3DQJJlFqk5g1V9BPUaDpOgIwLq17qxfoJFzQgcVmzO6i8Et5E6hPu6ugX1ceVaJ30I7IXcW3LpkSXNMvUFZyd8sxmaA4mal2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049212; c=relaxed/simple;
	bh=7I3uNiAKkTZbyzrbvRO6/IoX/oE6N2txpsfgRt+sSIE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KbDxW9E3wyJc/S3/pBPJKd24VmkAVVWqS4SrWXoLBWD2TSlx11smbnwu5xbbkQG+T+lm76R0z1SQEwKBYOuNY1nEN6lvS6A+pcgY+0jdP2rl3t9wi46kZdNvg/5WVsd1sXNfSYATInJv68P0srBOlJ9vX18fmuObYWP5Aw9/Nt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UO3Prxdo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rO0YkVen; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 12:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714049209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6FSSItB5bP1S5Sxr7VrKCW2jb0AYSfQBCr4NLQySyc=;
	b=UO3PrxdoW9gPDHwd8h0M4tDTvG2pu2Z0LaKV2WG5RyOuCa11/egJZLNBeAXB2QKEsrb3lH
	KeJAudS6pynNdRfl2TePsM82N632spz8B3QFBH6eVO+b5qduG/VOuwvpZXcZU+LgHNa7TY
	IzhFDH+fhVaGJ4QpDrDGNyf69bqqUe17lwaRgE/0iSjhxdHQBlZtS3veBN32SIj91gbVcc
	5hs6MgEAnCFiBmGcKJfJ4EsRpYQDj6Eqz9hfaGaUYmMgdU5FyfvNhC4G6AePHfWf41Bw3L
	0YUoS+5ocQKOWGaosbzDhvasapt6lJxG6XlC3+MpXUfdZipmLMNb6tnApR8ANQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714049209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6FSSItB5bP1S5Sxr7VrKCW2jb0AYSfQBCr4NLQySyc=;
	b=rO0YkVenapbvMNTCcHmykkenOAP3Ibsjo6/TJezBncdoJ0vNPPXATarGH5WIw9bads0QWN
	8bw0/8BPZuRbtCCA==
From: "tip-bot2 for Guanrui Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc
Cc: Guanrui Huang <guanrui.huang@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240418061053.96803-3-guanrui.huang@linux.alibaba.com>
References: <20240418061053.96803-3-guanrui.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171404920851.10875.11267717296229772633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     382d2ffe86efb1e2fa803d2cf17e5bfc34e574f3
Gitweb:        https://git.kernel.org/tip/382d2ffe86efb1e2fa803d2cf17e5bfc34e574f3
Author:        Guanrui Huang <guanrui.huang@linux.alibaba.com>
AuthorDate:    Thu, 18 Apr 2024 14:10:53 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Apr 2024 14:38:24 +02:00

irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

This BUG_ON() is useless, because the same effect will be obtained 
by letting the code run its course and vm being dereferenced,
triggering an exception.

So just remove this check.

Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240418061053.96803-3-guanrui.huang@linux.alibaba.com

---
 drivers/irqchip/irq-gic-v3-its.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 20f9542..98e5593 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4526,8 +4526,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err = 0;
 
-	BUG_ON(!vm);
-
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;

