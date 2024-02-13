Return-Path: <linux-kernel+bounces-63359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0D852E25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AC31C2167B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027002BB16;
	Tue, 13 Feb 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHaDuFrH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhg/24k6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD5249F3;
	Tue, 13 Feb 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820728; cv=none; b=ASvrouKHd1iBqrH677AvvIcfng78dhYhBpkkGm06u65/WOVSxBvKdvak6rg5w5YNGuUyyCCA3uBhc0khUO8UufKZTFPFo113q4kyJCZxSYj09zF/LxUW5vMS9YLkOlxUGojMw9wuBiBV8VRCVAX8R20jW2gwFuam5YqKDH1zWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820728; c=relaxed/simple;
	bh=ja0L1lGdOVqJ01QwOlVBZgwtQ+4MlbrYAQ8BDExeQqs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tSyl0cE+Atea6LYCCMI1BzuWGh9zZt/RDwGwfeNVRfFJRjx31lqJ9eFerQ5rd5kew/FLcQIFgYtsNZXdDV8WlmATtxWmkBhlpP3oc97hgyn2hKD7+2/98GDF2d0fRNcNF/KPEE9o8ozhzfY3ew2HdGGbOln0tvvs1/8H3LQaXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHaDuFrH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhg/24k6; arc=none smtp.client-ip=193.142.43.55
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
	bh=syDq48LdhL5YYdXPZAl7TgmOc/ww1Cyvz+QTvgK9s1M=;
	b=kHaDuFrHo7LMQVCyfpGq9vvcsNHKeF/EyK/0QunyVpcc7Hkn1RWzvSb4SLfNKY4CXssAje
	WBYr5BvWschy2sVbLdbYzSId0kHmtAPqKwY2UVF/IUIdDyo2UrWpaoSoN0qILhRPH+Ngoc
	FSWGw2ohLg2Ko00WX91QRKmmy16UJR3ROlfEuuJ5K705IMrLYkYdNhz8rfaF8umdAU8aQc
	yVahd/F12FUWPQHvREjp4b886IQuVOc/p8dMfo4Vu2aylbq24JHX7ST5Bmq/tVYoI3fwsk
	UphIoEPUmPdMgJPqRLzClofUoLrNGIgGrE0surpaXpQ8dPYBjwbNTv4R5xIFBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707820724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syDq48LdhL5YYdXPZAl7TgmOc/ww1Cyvz+QTvgK9s1M=;
	b=yhg/24k6TC+H6PmWr7E/NIK5KB0Byd2xLKcw8a98+8DjRfmBsDbILh8fbCgXqOnLe1JmU8
	MX8DQ1ymbEBYlkAA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Handle non-coherent GICv4
 redistributors
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213101206.2137483-2-maz@kernel.org>
References: <20240213101206.2137483-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170782072399.398.11466086711360298169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     846297e11e8ae428f8b00156a0cfe2db58100702
Gitweb:        https://git.kernel.org/tip/846297e11e8ae428f8b00156a0cfe2db58100702
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 Feb 2024 10:12:04 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 11:29:51 +01:00

irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors

Although the GICv3 code base has gained some handling of systems failing to
handle the shareability attributes, the GICv4 side of things has been
firmly ignored.

This is unfortunate, as the new recent addition of the "dma-noncoherent" is
supposed to apply to all of the GICR tables, and not just the ones that are
common to v3 and v4.

Add some checks to handle the VPROPBASE/VPENDBASE shareability and
cacheability attributes in the same way we deal with the other GICR_BASE
registers, wrapping the flag check in a helper for improved readability.

Note that this has been found by inspection only, as I don't have access to
HW that suffers from this particular issue.

Fixes: 3a0fff0fb6a3 ("irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Link: https://lore.kernel.org/r/20240213101206.2137483-2-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 37 ++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d097001..fec1b58 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -207,6 +207,11 @@ static bool require_its_list_vmovp(struct its_vm *vm, struct its_node *its)
 	return (gic_rdists->has_rvpeid || vm->vlpi_count[its->list_nr]);
 }
 
+static bool rdists_support_shareable(void)
+{
+	return !(gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE);
+}
+
 static u16 get_its_list(struct its_vm *vm)
 {
 	struct its_node *its;
@@ -2710,10 +2715,12 @@ static u64 inherit_vpe_l1_table_from_its(void)
 			break;
 		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
-		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
-				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
-		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
-				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		if (rdists_support_shareable()) {
+			val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
+					  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
+			val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
+					  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
 
 		return val;
@@ -2936,8 +2943,10 @@ static int allocate_vpe_l1_table(void)
 	WARN_ON(!IS_ALIGNED(pa, psz));
 
 	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
-	val |= GICR_VPROPBASER_RaWb;
-	val |= GICR_VPROPBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPROPBASER_RaWb;
+		val |= GICR_VPROPBASER_InnerShareable;
+	}
 	val |= GICR_VPROPBASER_4_1_Z;
 	val |= GICR_VPROPBASER_4_1_VALID;
 
@@ -3126,7 +3135,7 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
-	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+	if (!rdists_support_shareable())
 		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
 
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
@@ -3153,7 +3162,7 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 
-	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+	if (!rdists_support_shareable())
 		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
 
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
@@ -3880,14 +3889,18 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val  = virt_to_phys(page_address(vpe->its_vm->vprop_page)) &
 		GENMASK_ULL(51, 12);
 	val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
-	val |= GICR_VPROPBASER_RaWb;
-	val |= GICR_VPROPBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPROPBASER_RaWb;
+		val |= GICR_VPROPBASER_InnerShareable;
+	}
 	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
-	val |= GICR_VPENDBASER_RaWaWb;
-	val |= GICR_VPENDBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPENDBASER_RaWaWb;
+		val |= GICR_VPENDBASER_InnerShareable;
+	}
 	/*
 	 * There is no good way of finding out if the pending table is
 	 * empty as we can race against the doorbell interrupt very

