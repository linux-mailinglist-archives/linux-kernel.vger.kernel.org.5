Return-Path: <linux-kernel+bounces-63283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBA852D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AFB1F2991B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BC364C5;
	Tue, 13 Feb 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0W9Nxn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zIBTEQVF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28E2C697;
	Tue, 13 Feb 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818223; cv=none; b=uEjzY07yvOpRxLEM3onMlAudz491E3kCyvRMTD/DxTijjP3qOBguRgQtxRx82lZIQLT/F3cJpbBtMDqi+djJp0NfHBRIHQH5eI8m6AaRBnCMyauLpCuok+/kCZ+zByPGXxyJIJWwfRQpAkdOLRQGPg+A0wO+gShLy4XTaK+Pp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818223; c=relaxed/simple;
	bh=iGjPOz9dqoNts+T+448I5hUuxjj0LAiQI+tQQaJfbqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uYYfG9PxdMOZsXiJEKba8eLa9UeCJ92eFeDMK6bcGbi5PGtbixtcANb3tmQavwmp+xbypygQj2k0USvb3YPIvZyIIqoLEcftBgXysmTxntndPe+mp1+egQkC/gGkEjK6KyDfPbIDopJu4n95qP2d3IRY5Mvm+qK89vzyZt2Yt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0W9Nxn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zIBTEQVF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ga8gjUuHA/M7trC17sJZBov1w6L2E4sKkS4+7bQ0WlI=;
	b=s0W9Nxn3w4Byhsclt6UgDO6x91WCX516I/C6MB212tw6OPVujyyHHEAFji0Lkpy15NVP+y
	LgeuKFA5tYt9CLJ8oOLkRSuYakNUH4ux1p6aG7VNnUKwpFehp1gtTmC6YDhkY322dEeDJ3
	rNlEGQ46Uf7vWgu2x/KxrzibQAJp/xLlbFANADaA0PAFOPUa3qKAL8hJ/dwg7e6mEJ7p/a
	OX4UpT+3r9wnoSPaj0/fMoR9wJTfzKXADo5LTHd1/MtcpK5rUUhZzOFUmU5+oJz+Fma1la
	okH7kgXJC5vB//RzTt5w0vs9VyulH/JcjDZ53gDxo64yHTaXCYKTfZfEO2YVGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ga8gjUuHA/M7trC17sJZBov1w6L2E4sKkS4+7bQ0WlI=;
	b=zIBTEQVFhNdyvuRldyHD98Ed7SqET24yEqT8Y7AuyTFMgzQ5EBEz2WcadP4dmcLxkFAkGp
	mzIp85HDLfZ+pvAw==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-eiointc: Remove explicit interrupt
 affinity restore on resume
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240130082722.2912576-4-maobibo@loongson.cn>
References: <20240130082722.2912576-4-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781821970.398.12234224860251731939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     83c0708719f77018cd3b98b0011c9526a3e0e2ca
Gitweb:        https://git.kernel.org/tip/83c0708719f77018cd3b98b0011c9526a3e0e2ca
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Tue, 30 Jan 2024 16:27:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:53:14 +01:00

irqchip/loongson-eiointc: Remove explicit interrupt affinity restore on resume

During suspend all CPUs except CPU0 are hot-unpluged and all active
interrupts are migrated to CPU0.

On resume eiointc_router_init() affines all interrupts to CPU0, so the
subsequent explicit interrupt affinity restore is redundant.

Remove it.

[ tglx: Rewrote changelog ]

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240130082722.2912576-4-maobibo@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index fad22e2..405f622 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -310,23 +310,7 @@ static int eiointc_suspend(void)
 
 static void eiointc_resume(void)
 {
-	int i, j;
-	struct irq_desc *desc;
-	struct irq_data *irq_data;
-
 	eiointc_router_init(0);
-
-	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
-			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
-			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
-				raw_spin_lock(&desc->lock);
-				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
-				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
-				raw_spin_unlock(&desc->lock);
-			}
-		}
-	}
 }
 
 static struct syscore_ops eiointc_syscore_ops = {

