Return-Path: <linux-kernel+bounces-136523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB889D51E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764DA1C21558
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89227FBAB;
	Tue,  9 Apr 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZXMiRDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4UXsh+MR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D37E798;
	Tue,  9 Apr 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653688; cv=none; b=cSsDNfvHfGfPBaKpbnSR/eG9vLR389Nn9OqzqA5xQCrQZUGHLAdHSGNeO3thkmy0nwrj5LudYY4BrGrkW3xS2+qgn63w+w0MHrBOvsnd3LLC1NE/nQtZPOu1hAjh1IqqgjgVHdFSNAmFlPiy0XsPhmfwkvw8QWtPxTmIU00P/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653688; c=relaxed/simple;
	bh=DP0RHiFGs1Pa2cyRONbjfGpcBS8Fgpr2vJcgP4Ldjck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LyBG39Jm0mzxDoSbS+yKo9VR+RXJ05WeTbksMkACigvpBZoCZZ4X0qIKlkCv4LiyzY5kBW22pTIAgI2mcQloznvJyfgL8boKxo+Xg6ofyXrsGcZg58jIOkrCVK4yyx8mK1w8o7SiU1M39kk0I6G6uFqxP0L0qMkrAbtzNKk+6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZXMiRDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4UXsh+MR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbKXof8/1KDjh1IPeB4qJqO3SNsOO4LfNmgeOcCrpg=;
	b=1ZXMiRDAXAVa6bRyLTx6qSu7mLruxAQ+tm8MARVi0vN+Xe793zQuPinAcbYC3GPdxyzl6+
	51CE0xwFFVM+ToBYUbeHSCLWSW5CM29kuB2ozFPH1Ze257/gZvGdiU1VWhBQk0xhHusjGx
	b4B6qhjorS8aci2sTH/yjuAN71CHDl2bqC4s3NCqnl/khp1HYoCBEKdUfIMg+FqLlwFXb4
	i8k3tCRz06ssZ+/Cdg2f1BlibYvpZske61Nfz9VdVpc/bJXRYgsYV3R5HiopEcErt8jt7J
	sfKu6Xn6mPx6Ptp2RJ8E61zDVK9Fbm2EA4t/7pPwjYnWxDiyq0aH+IY4645KQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbKXof8/1KDjh1IPeB4qJqO3SNsOO4LfNmgeOcCrpg=;
	b=4UXsh+MRcks1PPF74aodBPYPKk0lue4GkG0RCKvPeO5KahIdSdovk7/d5kDKYOdXb47P/I
	zpil9rAObvzQpxAQ==
From: "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-pch-msi: Fix off-by-one on
 allocation error path
Cc: Zenghui Yu <yuzenghui@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240327142334.1098-1-yuzenghui@huawei.com>
References: <20240327142334.1098-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265368263.10875.8711308213701220968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b327708798809328f21da8dc14cc8883d1e8a4b3
Gitweb:        https://git.kernel.org/tip/b327708798809328f21da8dc14cc8883d1e8a4b3
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 27 Mar 2024 22:23:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:03:16 +02:00

irqchip/loongson-pch-msi: Fix off-by-one on allocation error path

When pch_msi_parent_domain_alloc() returns an error, there is an off-by-one
in the number of interrupts to be freed.

Fix it by passing the number of successfully allocated interrupts, instead of the
relative index of the last allocated one.

Fixes: 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Link: https://lore.kernel.org/r/20240327142334.1098-1-yuzenghui@huawei.com

---
 drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 6e1e1f0..dd4d699 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -136,7 +136,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
 
 err_hwirq:
 	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 
 	return err;
 }

