Return-Path: <linux-kernel+bounces-67622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D3856E21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FECB21376
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832613B291;
	Thu, 15 Feb 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMNC6jOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrzsWZ3c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0613AA20;
	Thu, 15 Feb 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027023; cv=none; b=k/oUjmvXt2Nke8V7kWkekHpIBj09h0PTUXhjtOmF+SJr8qk10/AFmqsB+wBc8AmmwqJOt8RthlE3KPNP+OyP5DKNffNIr1SI0nrkd7VSiFwgwUN2OC5YJhHSrlw4Gi57wbhDHmuw37AgfZSlzqwk8fheSU30iu3h0Q9jlGrnPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027023; c=relaxed/simple;
	bh=cF2voFu03IvhnQYBjAtLPUXzN9h+atrLQRv5/RKDOnc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I4Rakaccq4rbHcS/njQcTpV3STDDWsycWiu1inW7StIbDIIUzDA2Nb7teuo6SK9wevDpXLGSTL91mN/zoxc59PakXmlPXM/GNiI1iIzu9JpKevC8JoN2AnSvnG/wqw2nu+77O92a00H1GID+8bjwdgEeu//grj1hMiI0fxn6Az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMNC6jOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrzsWZ3c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 19:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m8xGT0+fmHKWHptvMAApOjG6vd18V1pOI+Y9tbQqBw=;
	b=KMNC6jOyGQLUGa/bzG+uq/OV1JjSks41rJIgXqwPwyt5Q/Gwv3YGzhWVvwazXXkSQGvDz6
	V4BkrRf3GSvyGDJo13WQuu+dJmq+aEG150Lomom7XO1QjMulPtgvlxXPY4Ax+umhL4JMRl
	V5dT/W6I+vO8UotsXM9roKTXypiDpfQYXQK54qG257qMilb39j9TBeYaI+l9QACQwo+xJE
	E54NqtJAqBfPWAA7cVkNpLTnMt5xxlpWwEJQQ/UXIDsdqe6SdvMqUKgrgdogqZUmuzMJdN
	ac559NtNi5RbdQgtD78VPjvX9+gEjWmKDCN5YzdS8EVWuobJq73YfKMCihtOUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m8xGT0+fmHKWHptvMAApOjG6vd18V1pOI+Y9tbQqBw=;
	b=rrzsWZ3czXCORjzmc17Gxcl8JhCDBleFksGs4+K9PfcI/MfQgS6w1QAiCdijr6pnXtiJ7j
	ynZKnxHBEDhu61AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240127161753.114685-10-apatel@ventanamicro.com>
References: <20240127161753.114685-10-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170802701926.398.13636483582128299915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     2d566a498d6483ba986dadc496f64a20b032608f
Gitweb:        https://git.kernel.org/tip/2d566a498d6483ba986dadc496f64a20b032608f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 27 Jan 2024 21:47:37 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 17:55:40 +01:00

genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI

Provide a domain bus token for the upcoming support for wire to MSI device
domains so the domain can be distinguished from regular device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240127161753.114685-10-apatel@ventanamicro.com

---
 include/linux/irqdomain_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index a7dea0c..5c1fe6f 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -27,6 +27,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_PCI_DEVICE_IMS,
 	DOMAIN_BUS_DEVICE_MSI,
+	DOMAIN_BUS_WIRED_TO_MSI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

