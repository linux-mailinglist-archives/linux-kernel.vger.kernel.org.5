Return-Path: <linux-kernel+bounces-71577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5785A744
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD89B23EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D4383A6;
	Mon, 19 Feb 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gige87Op";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6iNM42ud"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C338389;
	Mon, 19 Feb 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356084; cv=none; b=kyrWLoL8jLYG4CNle+E0geJ5kg+D1URdx+tltlO9cyKlCO1HU6qV0Tmvxa+03aVhuYVGPo058vxWiEVL/ihQtpf5ollu/BcXXKzelZqc6y2HpQlK0hHduS43qpOKBkJKcOQ+P6ORwmO1XMSiEJVhxW64ve4dJbeWKVx3rIfQrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356084; c=relaxed/simple;
	bh=G2cvM0uYCACv57fHf4T3QzA7HExl9j/2O59IDZ0UxGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sXy4TUb6Pb0UuaAm/8ho1KYjvLmQFHo8E70CYsmn8LgtkCGNJvADz0JyVpEQtRyF3VLgEldrsGGVV0dlQ+wfjri8Qo7R7/xnt00/zqXwcyFaONBCOkNNYbgNXtZdq2UGA+Nytaa2plI58dWDPSRkRzc1K6CaBqMn6JuEPoh8GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gige87Op; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6iNM42ud; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 15:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708356081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ltsHf1PwnnRBNn4pYqVf92/T9hGBxHrz+dtWVE8uYw=;
	b=Gige87Opi7VjCflOt1nd0zzjShhvwRwbYbhCnE7EXdwbyP54+wahAW7LKw8z0Zt7OOXc0f
	MYU+6AwielGbDFWcMTyM3NRYvCKIhWcCQs1EUf3RwKkeWzqa6R80Wx/q+gcNGHT9uszCyQ
	Npx8oMDQFTJgaf/FUjmKbb4DOPfa5P+kUcUemD0+czaQ6TT3smmzDmkpZhDstLM7/FmyQq
	Pj/S49U0+na/S8CF1O08X6CuzZLO+QWxPaEihSx/RMxPtrLTLPl6tl07BLXPPNpZxNzxg2
	dAh16Y7J8FBkkRk74FcM1mC/KW7lCdKyEa54xN+QPZsJ0lF4Movsug46CboaSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708356081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ltsHf1PwnnRBNn4pYqVf92/T9hGBxHrz+dtWVE8uYw=;
	b=6iNM42udPMh3wflw8piWHMn4tr58N9QanjUMxYRhH6e6rvF11TQWDzTzrKAajfEcx3x9OD
	ZMY/tlabIARuBBCA==
From: "tip-bot2 for Vidya Sagar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] PCI/MSI: Prevent MSI hardware interrupt number truncation
Cc: Vidya Sagar <vidyas@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shanker Donthineni <sdonthineni@nvidia.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240115135649.708536-1-vidyas@nvidia.com>
References: <20240115135649.708536-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170835608023.398.3330290067084127851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     db744ddd59be798c2627efbfc71f707f5a935a40
Gitweb:        https://git.kernel.org/tip/db744ddd59be798c2627efbfc71f707f5a935a40
Author:        Vidya Sagar <vidyas@nvidia.com>
AuthorDate:    Mon, 15 Jan 2024 19:26:49 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 16:11:01 +01:00

PCI/MSI: Prevent MSI hardware interrupt number truncation

While calculating the hardware interrupt number for a MSI interrupt, the
higher bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI
domain number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting in
same hardware interrupt number for devices 0019:00:00.0 and 0039:00:00.0.

To address this cast the PCI domain number to 'irq_hw_number_t' before left
shifting it to calculate the hardware interrupt number.

Please note that this fixes the issue only on 64-bit systems and doesn't
change the behavior for 32-bit systems i.e. the 32-bit systems continue to
have the issue. Since the issue surfaces only if there are too many PCIe
controllers in the system which usually is the case in modern server
systems and they don't tend to run 32-bit kernels.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115135649.708536-1-vidyas@nvidia.com
---
 drivers/pci/msi/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c8be056..cfd84a8 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 
 	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,

