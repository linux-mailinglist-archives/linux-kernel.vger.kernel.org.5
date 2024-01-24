Return-Path: <linux-kernel+bounces-37520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8383B13D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D861F24CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E5131E3E;
	Wed, 24 Jan 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbeBPvVR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIjIBO9/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AC12BE98;
	Wed, 24 Jan 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121324; cv=none; b=DisE7tTrtm4YLIF0JHxMON7lEKUxd9cMPnDrYmrC8iU1V2s065tl50KkucKn+l+6ohTG5LfY6Iw3Wh7vJuhF9kjgfGCarOFQnDdP4NAIygVxQOjHA4b5cJulvHj0lAJD+udkkPGiClN2xF23N+knPwI/D8Vt8EeeAHGLFQEqAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121324; c=relaxed/simple;
	bh=zqIwBcZy8s3HKxyWjDeJgVM8vExPAiJFvGzFhcIFPXc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N7EJnhDitgfYuTc7hAxTc1WegO/LIeGmKk73Q5nrHgbqzVVLC2/k9SXqU4Nc4kLthg1d/Y2uU5HP2ddNMdBwby7BEXcbpAZGgvO8Er8JU0BQUKulxCzVyv+fDzg0GKbG96Sd4WxOqpD3kgXJQtfbesMiIjT7ytbTxtKIlc37Rzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbeBPvVR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIjIBO9/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:35:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CeYFYbHtQXiyI0iy/9AsI9qEof0nJzgAJmMtj9PBic=;
	b=MbeBPvVRQ8aeArXDSU3o9/eUFNJzxkgXc1NUOfRbN9w1lnktHhGFmTXVcIe7EDZcyMqKD1
	YctWco59Sc+O/AY9AdKveN4EnrnJKmAymprMikAF+uy/JwBUUaaRY6lyMHuUI1XbvAHEVx
	JAfDKMflpqbl59y0jlbPpfg+fusuYu56zGNM4bs7UqLhFBDbfsu3QskdEsrZ2zH+fi7hnV
	Y1v/0FV6rqJqVAM/GUQ7jw5tMy85iyCK4UMRhhcBLzFM2I9BYGusYoFUDV3mN7YrTAlIdg
	S8FOfLa6omaPl2PsN3xA1BCrJzrQcIaUyTZXSYWK9Bwh59ss5RhvSEFSjR9xtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CeYFYbHtQXiyI0iy/9AsI9qEof0nJzgAJmMtj9PBic=;
	b=lIjIBO9/pSHQ/WumUJt6gbZfSGKr1MCVg5itaactTUK4IPioTLpD6B4O49Ku7Y2LL8U0E4
	OiER1dMkXuS1cgCA==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()
Cc: Marc Zyngier <maz@kernel.org>, Dawei Li <dawei.li@shingroup.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122085716.2999875-3-dawei.li@shingroup.cn>
References: <20240122085716.2999875-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612131964.398.1843674173078747091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d22083a5f09b2066728a91f3abb71284451247b1
Gitweb:        https://git.kernel.org/tip/d22083a5f09b2066728a91f3abb71284451247b1
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Mon, 22 Jan 2024 16:57:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 16:02:48 +01:00

irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()

GIC & GIC-v3 share same gic_irq() implementations, both of which serve
exact same purpose as irqd_to_hwirq(). irqd_to_hwirq() is a generic and
top level API of the interrupt subsystem, it's independent of any chip
implementation.

Replace gic_irq() with irqd_to_hwirq() and convert struct irq_data::hwirq
to irq_hw_number_t explicitly.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122085716.2999875-3-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-gic-v3.c | 19 +++++++------------
 drivers/irqchip/irq-gic.c    | 27 ++++++++++++---------------
 include/linux/irq.h          |  2 +-
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 65cbf37..20a75f0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -181,11 +181,6 @@ static enum gic_intid_range get_intid_range(struct irq_data *d)
 	return __get_intid_range(d->hwirq);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -542,7 +537,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >= 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >= 8192))
 		return -EINVAL;
 
 	/* desc lock should already be held */
@@ -582,7 +577,7 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >= 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >= 8192))
 		return;
 
 	/* desc lock should already be held */
@@ -620,7 +615,7 @@ static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
+	write_gicreg(irqd_to_hwirq(d), ICC_EOIR1_EL1);
 	isb();
 
 	if (gic_arm64_erratum_2941627_needed(d)) {
@@ -640,19 +635,19 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 * No need to deactivate an LPI, or an interrupt that
 	 * is is getting forwarded to a vcpu.
 	 */
-	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
+	if (irqd_to_hwirq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
 
 	if (!gic_arm64_erratum_2941627_needed(d))
-		gic_write_dir(gic_irq(d));
+		gic_write_dir(irqd_to_hwirq(d));
 	else
 		gic_poke_irq(d, GICD_ICACTIVER);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t irq = irqd_to_hwirq(d);
 	enum gic_intid_range range;
-	unsigned int irq = gic_irq(d);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -678,7 +673,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	ret = gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
+		pr_warn("GIC: PPI INTID%ld is secure or misconfigured\n", irq);
 		ret = 0;
 	}
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 412196a..98aa383 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -162,11 +162,6 @@ static inline void __iomem *gic_cpu_base(struct irq_data *d)
 	return gic_data_cpu_base(gic_data);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool cascading_gic_irq(struct irq_data *d)
 {
 	void *data = irq_data_get_irq_handler_data(d);
@@ -183,14 +178,16 @@ static inline bool cascading_gic_irq(struct irq_data *d)
  */
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
-	writel_relaxed(mask, gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4);
+	u32 mask = 1 << (irqd_to_hwirq(d) % 32);
+
+	writel_relaxed(mask, gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32) * 4);
 }
 
 static int gic_peek_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
-	return !!(readl_relaxed(gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4) & mask);
+	u32 mask = 1 << (irqd_to_hwirq(d) % 32);
+
+	return !!(readl_relaxed(gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32) * 4) & mask);
 }
 
 static void gic_mask_irq(struct irq_data *d)
@@ -220,7 +217,7 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq = gic_irq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (hwirq < 16)
 		hwirq = this_cpu_read(sgi_intid);
@@ -230,7 +227,7 @@ static void gic_eoi_irq(struct irq_data *d)
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq = gic_irq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	/* Do not deactivate an IRQ forwarded to a vcpu. */
 	if (irqd_is_forwarded_to_vcpu(d))
@@ -293,8 +290,8 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t gicirq = irqd_to_hwirq(d);
 	void __iomem *base = gic_dist_base(d);
-	unsigned int gicirq = gic_irq(d);
 	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
@@ -309,7 +306,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
+		pr_warn("GIC: PPI%ld is secure or misconfigured\n", gicirq - 16);
 		ret = 0;
 	}
 
@@ -319,7 +316,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
 	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
-	if (cascading_gic_irq(d) || gic_irq(d) < 16)
+	if (cascading_gic_irq(d) || irqd_to_hwirq(d) < 16)
 		return -EINVAL;
 
 	if (vcpu)
@@ -796,7 +793,7 @@ static void rmw_writeb(u8 bval, void __iomem *addr)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + irqd_to_hwirq(d);
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081af..97baa93 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -179,7 +179,7 @@ struct irq_common_data {
 struct irq_data {
 	u32			mask;
 	unsigned int		irq;
-	unsigned long		hwirq;
+	irq_hw_number_t		hwirq;
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;

