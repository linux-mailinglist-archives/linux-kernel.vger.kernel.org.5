Return-Path: <linux-kernel+bounces-136519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69FB89D516
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A101C21464
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AF7F46C;
	Tue,  9 Apr 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pdMgfxke";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wp3hKmfm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1587E578;
	Tue,  9 Apr 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653687; cv=none; b=OgSG9dtS0Dav6ct9zeNWrJii0ZlMrAHayY/j3ZfkHG8fD+k0bPCK715WowqGteKzUkT2hHEOtzY5uoTkMg/L1a08fMMXxqbhB5iLrMIH+Wl1VDnHzfMxFkPD67dLN5g/aUBsFywideufhl6Ep/Sa1V8wx6/wvKK0PZzVluAEd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653687; c=relaxed/simple;
	bh=rtyrlOsyG0y7h5VHwYtKJ1vBsr/b2iu9nRKb+Ocfj6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P6ffH0r96huXIv9mKv31x61L2yMYG9sWxwcUHmwLYEMiSSldaMHhTQnnQ7Id61MCd03+Jtsdg4MyvY0whiBQYe/FVHkq20hpFbB3Pa2bJg9NXV5hDpe/HghYb3s9k6vl6bBSS2WC4McD2PaavEA9IZh3jqAFm1virZ/PJlHPE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pdMgfxke; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wp3hKmfm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APMP/y4EnKfb5ze4aAiaXsWRgifOcdSTI8rDs+a5ADw=;
	b=pdMgfxke1mshdIEvhDVtiafSmLWqdAVWxbE6EFWXOlSUR0ybFGIold/ZhlhVCacaxe3Mo6
	lG2O7MzEXLxrugxJF4uaixOh6BTPBIDUXk8UG3Y5D5SNMaUmI3xj5ykkZZyPx0aP5swNRV
	DsAyHUr4EhViC/B3Mfm29slKknLz4M9cbJ6W3JONEl0E/HXCKaRPHgtEQuQgzyhN8j90dN
	yMg+VT4ZUuWfvXsCMzLAdhq2bSJbHmHS0lSWr9uIMo/oCeU5aie/++ZAi01n4Fd07MnKwS
	BhEjna3MKpMcdhz1hcU9VVBYFh/63I8VmVsq/oKPkhuX4hfHFaj+cqFxTiM3Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APMP/y4EnKfb5ze4aAiaXsWRgifOcdSTI8rDs+a5ADw=;
	b=wp3hKmfml8EcGhk3bCzAojuWzmnX0oSVazXUD1Q4Bzisz7J929ShP8iOh4XxWCWrmpZDxh
	t+5BC03lJ/3HwWCQ==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-eiointc: Set CPU affinity only on
 SMP machines for LoongArch
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240326121130.16622-4-yangtiezhu@loongson.cn>
References: <20240326121130.16622-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265368189.10875.5441043593179943891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a64003da0ef8e135cda678eb2c8a6f0baf4a9f35
Gitweb:        https://git.kernel.org/tip/a64003da0ef8e135cda678eb2c8a6f0baf4a9f35
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 26 Mar 2024 20:11:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:03:16 +02:00

irqchip/loongson-eiointc: Set CPU affinity only on SMP machines for LoongArch

According to the code comment of "struct irq_chip", the member
"irq_set_affinity" is to set the CPU affinity on SMP machines, so define
and call eiointc_set_irq_affinity() only under CONFIG_SMP.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240326121130.16622-4-yangtiezhu@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b64cbe3..4f5e6d2 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -59,6 +59,7 @@ static int cpu_to_eio_node(int cpu)
 	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
 }
 
+#ifdef CONFIG_SMP
 static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode, nodemask_t *node_map)
 {
 	int i, node, cpu_node, route_node;
@@ -126,6 +127,7 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 
 	return IRQ_SET_MASK_OK;
 }
+#endif
 
 static int eiointc_index(int node)
 {
@@ -238,7 +240,9 @@ static struct irq_chip eiointc_irq_chip = {
 	.irq_ack		= eiointc_ack_irq,
 	.irq_mask		= eiointc_mask_irq,
 	.irq_unmask		= eiointc_unmask_irq,
+#ifdef CONFIG_SMP
 	.irq_set_affinity	= eiointc_set_irq_affinity,
+#endif
 };
 
 static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,

