Return-Path: <linux-kernel+bounces-63358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00D852E23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910131F253D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9628E3C;
	Tue, 13 Feb 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1zcUeppW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMbHKsru"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE4249EA;
	Tue, 13 Feb 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820727; cv=none; b=W9fMi4JtJ3lOIwJ+b6zp1rFFRU3J/Aucoq+U1PzG7LraJ1Ckuwh6+Dj1XxJrpb/Y1poDTuVKhdbmrGFUN9qAZ0iDcE9jztN1xuj7IAB5w+yxeQGkO4nJG1AjEyqAIVodaZAiQWUAww/B3OJtuH3ePnEETyx5UtxwZPAcK1XXdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820727; c=relaxed/simple;
	bh=Uy1WRLvsRPh+dMpNYNJnzvWJK9kiQUrzvYENMWgy88Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bVZ8l4MwxLSUVZY8R3nf44J2uGbgIKMXcEyC+k8m0AitfbxgOCo/BVmpGvG7ZarlIRmanIFAEZVQ4RdXR+8TvmaybnXUa4Ifhs7UHSLZ06f9WIusrBFhCfy7vMWGhawCCNSZDISnCJUvTRhPY8ncaqoW3VzvKtskDsuD3MC0pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1zcUeppW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMbHKsru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 10:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707820724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3QWOyLixGt1iJ/I+f3IkJUKSIdZzuFVyhqA5gxCtk0=;
	b=1zcUeppW3kbdnbhIfa2NMM3y4GQpjMFZfnrQSlCPWdLJRaHVY50eEzmsZwu8/AOen6D5wP
	+J4IerZZVhjCtaO8x+KeU0HJx5Ky9wXhYSg4WgRHotDBbfzjyBpMXaqvAPXg9mu3RYyIEi
	8jIC3+dZvOeySlbEYY9TbBts2Zv3qzGnfHa69nTY8UG9MiyBonSJhOxDrCe8NUWJ1CdfuE
	aoBUWK64STXewwKWjv67czapwiyxqpIYToPmbKeiPbfmM33flGw/oVIKVtk0GDTxilLJ2L
	anYdagit/SIJgPU5J2NeXphyPAreaaA0yVcFyZdWui5AXKJezRezeKFEZ3T+iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707820724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3QWOyLixGt1iJ/I+f3IkJUKSIdZzuFVyhqA5gxCtk0=;
	b=QMbHKsrupmFLaukr6i6TYcqvun3kvbPA8LX6HMjpeE6Mzt12yAmedwESqXoOTlfsQrcGFJ
	9cMyNI1plbTCLIAw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Restore quirk probing for
 ACPI-based systems
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213101206.2137483-3-maz@kernel.org>
References: <20240213101206.2137483-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170782072338.398.14487986832885043977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8b02da04ad978827e5ccd675acf170198f747a7a
Gitweb:        https://git.kernel.org/tip/8b02da04ad978827e5ccd675acf170198f747a7a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 Feb 2024 10:12:05 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 11:29:52 +01:00

irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

While refactoring the way the ITSs are probed, the handling of quirks
applicable to ACPI-based platforms was lost. As a result, systems such as
HIP07 lose their GICv4 functionnality, and some other may even fail to
boot, unless they are configured to boot with DT.

Move the enabling of quirks into its_probe_one(), making it common to all
firmware implementations.

Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240213101206.2137483-3-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fec1b58..250b456 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5091,6 +5091,8 @@ static int __init its_probe_one(struct its_node *its)
 	u32 ctlr;
 	int err;
 
+	its_enable_quirks(its);
+
 	if (is_v4(its)) {
 		if (!(its->typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(its);
@@ -5442,7 +5444,6 @@ static int __init its_of_probe(struct device_node *node)
 		if (!its)
 			return -ENOMEM;
 
-		its_enable_quirks(its);
 		err = its_probe_one(its);
 		if (err)  {
 			its_node_destroy(its);

