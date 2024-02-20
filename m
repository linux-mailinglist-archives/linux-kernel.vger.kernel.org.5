Return-Path: <linux-kernel+bounces-73365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACD85C17E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE141C22F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00672768EA;
	Tue, 20 Feb 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFx8YLQU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tV0GSSnl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854F1E48F;
	Tue, 20 Feb 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446798; cv=none; b=sTBlnrw0dY3U9zXPFBzytj5X/7taFPlcaZgKLdKgNpwYLb83NSgdeD35AkySUEzPna3T0/tb5BYJt0npTqpBatDCxg0PJ1t6cAydWF78RbJOMw051CJ8xUi7EPyPLU7NGLF3YOUXd80ZY9B9Yjp4QvnzkKWGG61rMnAuFMlNaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446798; c=relaxed/simple;
	bh=crx0V2jmDalbGCAYJq3hX4FwWQckI1QCtvZXcYEsB5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nfzPhAJRbUL0r5F0r1Hep7IGmwQRclLdkUv2u8cVX01q/DS10HjeeNFtU1zbCAY/yW2jAywzIsQO8AO/+lJHYBUhTi21Fmb9D++55B4fqCgvMe8N36ojfkkSFpyuLHFRt8ww4eWemgZX9w30+aSxcm0Bkr04beMkO+22Ep32Miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFx8YLQU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tV0GSSnl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 16:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708446795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G4Ce1NHXdD7vfzRk5AY1poHLo5i4hx/u9gfnKxfS5k=;
	b=gFx8YLQUFZM7K5S0mV8EzRqV7BYLFhmma8b+DZQVKszOpld+WwgxZh7+Tm3RMux0q3Pg9b
	1ZHNuPDkm/Op3EeB5/TdN13757DuETiXIKD7DWGzW/DmgBd45SOdP15elAn5x57GPbOLCt
	PK7T+Jm5yttg81sehZF1DNjuOfhvX4w4pVupI+cG0y04CAbpYwbp+Eu2BbBFttB7aGlBs4
	t+Mtzau/4SMZo/Et/ulw7cnZ9mKT64Uil7T0gok11yzxoMW1gImo8mMlMN714PS8Q1JsuF
	pjp6oU5SdGJT+9C5ibz6uvCO11g9hRNj+zu2gyNZwUz7AatCi61OgHrVYa+Rlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708446795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G4Ce1NHXdD7vfzRk5AY1poHLo5i4hx/u9gfnKxfS5k=;
	b=tV0GSSnl3NEwN41db3czNKhX0njHDF/cY874G4yvBlW5vZvnmchjxV9pgINkX45Bh6/xb7
	UnuJNqYpHjYBpSAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/imx-intmux: Handle pure domain searches correctly
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ttm3ikok.ffs@tglx>
References: <87ttm3ikok.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170844679441.398.5678441273073530090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     34da27aa8956d3a75c7556a59c9c7cfd0b3f18ab
Gitweb:        https://git.kernel.org/tip/34da27aa8956d3a75c7556a59c9c7cfd0b3f18ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Feb 2024 09:46:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 17:30:57 +01:00

irqchip/imx-intmux: Handle pure domain searches correctly

The removal of the paremeter count restriction in the core code to allow
pure domain token based select() decisions broke the IMX intmux select
callback as that unconditioally expects that there is a parameter.

Add the missing check for zero parameter count and the token match.

Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87ttm3ikok.ffs@tglx
---
 drivers/irqchip/irq-imx-intmux.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index aa041e4..65084c7 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -166,6 +166,10 @@ static int imx_intmux_irq_select(struct irq_domain *d, struct irq_fwspec *fwspec
 	if (fwspec->fwnode != d->fwnode)
 		return false;
 
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token == bus_token;
+
 	return irqchip_data->chanidx == fwspec->param[1];
 }
 

