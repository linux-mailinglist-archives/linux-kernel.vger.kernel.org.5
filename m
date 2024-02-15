Return-Path: <linux-kernel+bounces-67631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59639856E33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84F7B22797
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD414600B;
	Thu, 15 Feb 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKQW7O9D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G47cNF+L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33184145344;
	Thu, 15 Feb 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027028; cv=none; b=Ca3+Rr1K5ZHlcCzMgF+mZUFZr/CX3g1g8Aa9fVeUwXMbxfdVJggoqv3MmdjcPKmchXAfiwaQEC7AxKR2ZDSdYE9Lx3aPbYDH12BrGhMsu7yBgjHr+cwFE+m1avb9lIROKwsXL2r0PcZ0J/u6wkj3LJUXAKbehlO4Lw5T3JStlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027028; c=relaxed/simple;
	bh=sRprGE4OtoJgLdSrRq9T+Y5449jUfBBENtG+uLb5r5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KKr9WLINS1dmBNmxHGRc2+sUlRUdGZ4exEbWVTJvbEdsmBH/FRlW17ObvS4Emmxnbabt1vl0+W0HZ2gRYORSFkZ6Y0RJYs69NBpv/FKP+UgO+yKg3S6EKVDAGy3t70C9j3/fUXOAt73cRF/Go/gDo5gJjU/DMcHxTFbV7SUVlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKQW7O9D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G47cNF+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWzmlYHTyuBRWs7MhCU34vGoL/mBld4kUDv/xrBnfk=;
	b=kKQW7O9D9CcBq75DdPiJIzT+9I2ke0NEySKmdBDj0H6dItAjO/4cUdYISMBAQ1ZMWwf+Qt
	L59OdbAujdhe53t62QjDappl0mRkWvZMdCBPD6JzVpc5xX0lK1aHwAG/VNqF6B3CGZMDF9
	IpFE5Zhbsp9qaxUO3ulmeKl267zDNH9XxMQ/jl9lEPlAIR4wSC89ix2mRgR7ngxswiOgcU
	fhFYSyUqSxtwQcLZW63NpoowHshItWVYq93t3UYysx7Wm8kYyjRJlwxztcJracvIjKxfDo
	OHVwc4ph6vaIXFzimTJeXQ0bIU32LO4nOIwVmJ+7h3HdsjGxpb/Exvdraxdzzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWzmlYHTyuBRWs7MhCU34vGoL/mBld4kUDv/xrBnfk=;
	b=G47cNF+L5JKViYuZPQ8dsO7hGDJefczxT//Lnek/SpVut7loFNCxYhvZtbLnkdCtraJr6T
	zGWFBAt17aOcW1Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3: Make gic_irq_domain_select() robust
 for zero parameter count
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-2-apatel@ventanamicro.com>
References: <20240127161753.114685-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702482.398.14573562660062119117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     15137825100422c4c393c87af5aa5a8fa297b1f3
Gitweb:        https://git.kernel.org/tip/15137825100422c4c393c87af5aa5a8fa297b1f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:29 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:39 +01:00

irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter count

Currently the irqdomain select callback is only invoked when the parameter
count of the fwspec arguments is not zero. That makes sense because then
the match is on the firmware node and eventually on the bus_token, which is
already handled in the core code.

The upcoming support for per device MSI domains requires to do real bus
token specific checks in the MSI parent domains with a zero parameter
count.

Make the gic-v3 select() callback handle that case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240127161753.114685-2-apatel@ventanamicro.com

---
 drivers/irqchip/irq-gic-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329..35b9362 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1702,9 +1702,13 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	irq_hw_number_t hwirq;
 
 	/* Not for us */
-        if (fwspec->fwnode != d->fwnode)
+	if (fwspec->fwnode != d->fwnode)
 		return 0;
 
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token == bus_token;
+
 	/* If this is not DT, then we have a single domain */
 	if (!is_of_node(fwspec->fwnode))
 		return 1;

