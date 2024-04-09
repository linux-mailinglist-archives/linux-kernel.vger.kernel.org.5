Return-Path: <linux-kernel+bounces-136522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820F89D51C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EFE1C2173F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10107F7FE;
	Tue,  9 Apr 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXgZv5BX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mwdxz44z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881651EA74;
	Tue,  9 Apr 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653688; cv=none; b=MSjw4RKjP8rh+AzjGKQ1oQAYvmkLN/z04DUBJMgdoQbIYwaKzoQsCaLA3dZFTaJkNtvBcbdjV+wZS1qM4Ywjs5iHVKt4X4Vu7AHWS2FhBE0dlMBHcO9R8el9oLdiDJ4ScQe/YciN4yBk+ot2irZkEUNR6Av8Cs7hrn9nRIWhqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653688; c=relaxed/simple;
	bh=wbYUhv2RKVPiJNy/1SAN3285v56XYBSZ8F4eQCdjP3M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J4Q2RtoROj2U2YrEuI2u3qxizj7izRHGH3LWopar0b2p79OUzSyvY9s5fK65mQssocEJhNZvlx1xErBBDd3f2zO0fc605i3Tml0bBQPDiMazHX/JIWMp5SxItp8DQbK982NHZO2LDWQfg1ob0SkEm6HknN0BScVsWc5zX/Y2ntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXgZv5BX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mwdxz44z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/nwosldwjCXQdo+Q1cGN0Zy7vpqjQ7vamZYvj/AFSo=;
	b=cXgZv5BX/2rDeK5sHCRpj2r2rOpkEfDJZ7brHtZU/uokHMKyVnjkN6qzORuIqOeazcvm7N
	zHMytIHRJLiDaxws3reNRtmj8iXTJisd6NBj8FeKBqVCKWoCLtvB+WCTdzRSLXH9fXYa+/
	TtBCbcy85BuBv/MMNhJx/wnxV30G70HF4VGn48pct3urjNLglIYGQkGOz4xdG0jQ3xUkRb
	DS8Bg4kWnt2AWnvzT25aYkvkzWV7yhEyFIRePgDVdyjF61Az4uFHIrT/6uXdVJy9InE3Ck
	R31omrUszk+mEAJCIceo2GoB9YT9KqLcTrALH0Wm+Cx+TIAd1CQbA/GX+ZlNJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/nwosldwjCXQdo+Q1cGN0Zy7vpqjQ7vamZYvj/AFSo=;
	b=Mwdxz44zSsqkTTefP1mSFFilfnCetbYz9X7yq8hLYcRKTdYtoEHo/l0HdxFPZqDWffn7WD
	mLyzj5Die22AsLAQ==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-aplic: Fix spelling mistake "forwared"
 -> "forwarded"
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240327110516.283738-1-colin.i.king@gmail.com>
References: <20240327110516.283738-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265368406.10875.7603585287198246199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     14ced4756458f2c7295f27f615d22c2b5912c733
Gitweb:        https://git.kernel.org/tip/14ced4756458f2c7295f27f615d22c2b5912c733
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Wed, 27 Mar 2024 11:05:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:03:15 +02:00

irqchip/riscv-aplic: Fix spelling mistake "forwared" -> "forwarded"

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240327110516.283738-1-colin.i.king@gmail.com

---
 drivers/irqchip/irq-riscv-aplic-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 36cd04a..028444a 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -251,7 +251,7 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 
 	/* Advertise the interrupt controller */
 	pa = priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
-	dev_info(dev, "%d interrupts forwared to MSI base %pa\n", priv->nr_irqs, &pa);
+	dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv->nr_irqs, &pa);
 
 	return 0;
 }

