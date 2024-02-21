Return-Path: <linux-kernel+bounces-75208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864385E4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D61D1F22E51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8284FD0;
	Wed, 21 Feb 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nFf1xfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFUnHNkZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF784052;
	Wed, 21 Feb 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537162; cv=none; b=HFCL2LEjcPrrsapYZwv56NFifh4ykRl0w2mncI1OSIuhEjvjUiV7GGJCIuGPjdrvH1Nyca8r49op5q4I4C8nkDvgJfsRAhlHHwTNVfbtJPzQnWmLuYNZZ6FgfeWpMKzhJDdPrYl3tXF443Klo3oNjbRQKNy6YF4Q8w3kp6NlVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537162; c=relaxed/simple;
	bh=fxkW9ID7GJiMhERWY8n83OqMjHTdc9vsb1OQk6j2MUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G+mFghO/54Vq+IZHVawoLQ2NuEmSyJF5SzFubxmqx2viRwPOuqtFgoSPYKfAbb8XS9B7/VAAOt+rX8lTCr0GwzBSvmRLkmKmVH8vUBvZU1eVkppHRE+4OuX4iZIXKf7T/PcpkIGAfES9iWpTOwoWuV12kM09qaqypw00XVH0I0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nFf1xfe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFUnHNkZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 17:39:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708537159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGaJBynUBIXtMCHxSfHxeRMycMvw4ZUn9lwGf5oGM1I=;
	b=3nFf1xfePu+kXptdCjw8Eml/AZQYHAEpLVqEDWQigmEtd6hTO3d9Ka5itod38dFtHPsTmy
	4Dv4FmfxnxXmACYhMD/0GYMiVszlBlMnppm0kgzDlpDEHY2nQCtAbDeUfjMgcgLoBnNAr3
	DJc4JdH5pN9MRi/vuPZdcfckEJC7ZnAPejPWjHMsuEDtbquOVGdg0mVQ19LQtN/GHvX6bV
	bcFJSP8JQBascIggnRZ5AP/r0Y6Fq4ISygiefl/ujJmnjv4bWYV/bJCMF5MoyErR5dRf+j
	xlUQ9mt0gvp2FDrFkFyhggGuk2zEvf7jUJj62x9sUTpvaC4nNrohL0yCJtq1sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708537159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGaJBynUBIXtMCHxSfHxeRMycMvw4ZUn9lwGf5oGM1I=;
	b=KFUnHNkZU5qr7lYW5F83GHTfUINbxwFx4vJ0HxWIYTc1MbILxoL5xpBTteTsV5HzF0ghh+
	OwzQ84alsLkXufAg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/vic: Fix a kernel-doc warning
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240221064104.7863-1-rdunlap@infradead.org>
References: <20240221064104.7863-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170853715812.398.5557328318863303144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     eb0e1ebb1772302213f4882f5fada2b3f6362e66
Gitweb:        https://git.kernel.org/tip/eb0e1ebb1772302213f4882f5fada2b3f6362e66
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 20 Feb 2024 22:41:04 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Feb 2024 18:31:08 +01:00

irqchip/vic: Fix a kernel-doc warning

Drop one extraneous struct member to quieten a warning:

drivers/irqchip/irq-vic.c:73: warning: Excess struct member 'parent_irq' description in 'vic_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240221064104.7863-1-rdunlap@infradead.org
---
 drivers/irqchip/irq-vic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 9e3d556..ea93e72 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -47,9 +47,8 @@
 
 /**
  * struct vic_device - VIC PM device
- * @parent_irq: The parent IRQ number of the VIC if cascaded, or 0.
- * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
+ * @irq: The IRQ number for the base of the VIC.
  * @valid_sources: A bitmask of valid interrupts
  * @resume_sources: A bitmask of interrupts for resume.
  * @resume_irqs: The IRQs enabled for resume.

