Return-Path: <linux-kernel+bounces-67628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C847856E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CBC2863CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FF145B01;
	Thu, 15 Feb 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fv/fNqQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAlQXPi3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8B13DB8A;
	Thu, 15 Feb 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027027; cv=none; b=sM9k3fcdb2GMzuDuOyl2n27iQACXXhHGMpQz8eRGKky2Aj5uE1XhaS2dX7LflvqwX9Ee7aduoN5NmQmK8dAgP9oZ9zBwr/vy/L9hNAWG1GM0B0i6a74ruekC9iQAtpxp/8OV6nqH7L5h08mbKff914DLNn9z+oBXgB9cMJQb1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027027; c=relaxed/simple;
	bh=qlvZFPAPDIryctsQPn1lOQw5KyKhU/2C3XBx0qs7Ikc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jiGba2GbXqpD4khqxfLuG2PDSFM1q4beiITkYCN9zN1XyHrpmED27PivVbjin3daIHHyJyJaNmRzp+y+l4be2PaQCdS5v65ylGOhSO6huLVjdGxnh3KazQWpMVi2RG7JJvHrsyNDuIZtI+FI5P/Pp9ymAd8dtT5cn6RdoocoZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fv/fNqQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAlQXPi3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNj3KENmhxtTW1IisE/N3jDlbs083Czp8L1Qxzm3TMk=;
	b=Fv/fNqQ8Bnn90AIerV4P7FsvkOtZlqWn7wbRnBPd7gZCizOhP5gKE2AJAiURPMC/l8jWnI
	RG+sTAQ5kPic0tYC3I+An1mI4AFSni5aed7JSm/Sccb9Z+f9l/7HzRxlanU6ljcqeIAuBE
	VsjT9IIJyMTaxPTYe+phWChQS+6oCMSil2YcKIlrNwA5YCI7ytZ8bbvPCMSX7jeZjzsQq+
	UHqguGTr1x7knMAj5UsqshiWOa4kGOqRhvqfOMcZvgYsbx3WOcco3YTZ48Wu2PCw+NkCf2
	+CI6VaJn12xo5OD+SF1V1Vi89LcbyQCZCXkU3SUiDXxyvr7PzNA5jzC3oivqmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027023;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNj3KENmhxtTW1IisE/N3jDlbs083Czp8L1Qxzm3TMk=;
	b=fAlQXPi3X0FqVPP4qRC6owI1XSlhy4/tq1GOrr2k//53T+ANW8sBimkd+sXjIVGZJyTDSq
	ZiDPpQ4LvHKTCtCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/irqdomain: Add DOMAIN_BUS_DEVICE_MSI
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-5-apatel@ventanamicro.com>
References: <20240127161753.114685-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802702297.398.15461628510836466714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6516d5a295356f8fd5827a1c0954d7ed5b2324dd
Gitweb:        https://git.kernel.org/tip/6516d5a295356f8fd5827a1c0954d7ed5b2324dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:32 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

genirq/irqdomain: Add DOMAIN_BUS_DEVICE_MSI

Add a new domain bus token to prepare for device MSI which aims to replace
the existing platform MSI maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-5-apatel@ventanamicro.com

---
 include/linux/irqdomain_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index c29921f..a7dea0c 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -26,6 +26,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_PCI_DEVICE_IMS,
+	DOMAIN_BUS_DEVICE_MSI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

