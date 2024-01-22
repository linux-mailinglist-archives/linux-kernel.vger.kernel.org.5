Return-Path: <linux-kernel+bounces-33149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC7836549
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394B2289B82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47993D3AE;
	Mon, 22 Jan 2024 14:24:39 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943B3D397
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933479; cv=none; b=XGB0wimRD3n3JSf782wEhDYU4Q2x0KuadeaomJ6zF3LfhupO6fasLGMxqTB4NPlkEnGVra49SnKEmRpfIrijdRfqBvHP/XJDtdYRIFcGqYDMCMEpvT6pUzXo7RTNzbfMV5bVULV+xrQVmhGDE320RsbvgiP2hE5GVc418LUm3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933479; c=relaxed/simple;
	bh=joO1L0dYAPVCMbnWAK+3SKlaq+ywTEuWlKC+U8+vrCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHGi1jf50BeT6egJ8TtEZp/f5vGsARtqnd1ZKoSl06hLSDqziN/MhehF6RLbSkRSMqVELKQjQT5PZu3NCiUDhAAUS3ZV7zkpA5aAKnxEiM1jXlYJsvxwS59fppH6fK+JEEVLpfM0KG1PiAAN7mKv5uWT3zgRyg/Dh8pp5VscSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by albert.telenet-ops.be with bizsmtp
	id dqQb2B0040ZxL6o06qQbQf; Mon, 22 Jan 2024 15:24:35 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvDF-00GGx3-Si;
	Mon, 22 Jan 2024 15:24:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvE2-00CFAj-Ti;
	Mon, 22 Jan 2024 15:24:34 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/4] staging: Remove board staging code
Date: Mon, 22 Jan 2024 15:24:33 +0100
Message-Id: <eec1bfb2878237888a8c3bc866d18dc53900739f.1705932585.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705932585.git.geert+renesas@glider.be>
References: <cover.1705932585.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more users of the board staging code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/staging/Kconfig        |   2 -
 drivers/staging/Makefile       |   1 -
 drivers/staging/board/Kconfig  |  12 --
 drivers/staging/board/Makefile |   2 -
 drivers/staging/board/TODO     |   2 -
 drivers/staging/board/board.c  | 204 ---------------------------------
 drivers/staging/board/board.h  |  46 --------
 7 files changed, 269 deletions(-)
 delete mode 100644 drivers/staging/board/Kconfig
 delete mode 100644 drivers/staging/board/Makefile
 delete mode 100644 drivers/staging/board/TODO
 delete mode 100644 drivers/staging/board/board.c
 delete mode 100644 drivers/staging/board/board.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index b8f777036bb22fe5..5175b1c4f1619863 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -50,8 +50,6 @@ source "drivers/staging/nvec/Kconfig"
 
 source "drivers/staging/media/Kconfig"
 
-source "drivers/staging/board/Kconfig"
-
 source "drivers/staging/gdm724x/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 5bf357782d8377c5..67399c0ad8719cb5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_VME_BUS)		+= vme_user/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
-obj-$(CONFIG_STAGING_BOARD)	+= board/
 obj-$(CONFIG_LTE_GDM724X)	+= gdm724x/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
deleted file mode 100644
index b49216768ef699f6..0000000000000000
--- a/drivers/staging/board/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config STAGING_BOARD
-	bool "Staging Board Support"
-	depends on OF_ADDRESS && OF_IRQ && HAVE_CLK
-	help
-	  Staging board base is to support continuous upstream
-	  in-tree development and integration of platform devices.
-
-	  Helps developers integrate devices as platform devices for
-	  device drivers that only provide platform device bindings.
-	  This in turn allows for incremental development of both
-	  hardware feature support and DT binding work in parallel.
diff --git a/drivers/staging/board/Makefile b/drivers/staging/board/Makefile
deleted file mode 100644
index b6a00c93c2cc10dd..0000000000000000
--- a/drivers/staging/board/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-y	:= board.o
diff --git a/drivers/staging/board/TODO b/drivers/staging/board/TODO
deleted file mode 100644
index 8db70e10aa67448a..0000000000000000
--- a/drivers/staging/board/TODO
+++ /dev/null
@@ -1,2 +0,0 @@
-* replace platform device code with DT nodes once the driver supports DT
-* remove staging board code when no more platform devices are needed
diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
deleted file mode 100644
index f980af0373452cab..0000000000000000
--- a/drivers/staging/board/board.c
+++ /dev/null
@@ -1,204 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Magnus Damm
- * Copyright (C) 2015 Glider bvba
- */
-
-#define pr_fmt(fmt)	"board_staging: "  fmt
-
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-
-#include "board.h"
-
-static struct device_node *irqc_node __initdata;
-static unsigned int irqc_base __initdata;
-
-static bool find_by_address(u64 base_address)
-{
-	struct device_node *dn = of_find_all_nodes(NULL);
-	struct resource res;
-
-	while (dn) {
-		if (!of_address_to_resource(dn, 0, &res)) {
-			if (res.start == base_address) {
-				of_node_put(dn);
-				return true;
-			}
-		}
-		dn = of_find_all_nodes(dn);
-	}
-
-	return false;
-}
-
-bool __init board_staging_dt_node_available(const struct resource *resource,
-					    unsigned int num_resources)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_resources; i++) {
-		const struct resource *r = resource + i;
-
-		if (resource_type(r) == IORESOURCE_MEM)
-			if (find_by_address(r->start))
-				return true; /* DT node available */
-	}
-
-	return false; /* Nothing found */
-}
-
-int __init board_staging_gic_setup_xlate(const char *gic_match,
-					 unsigned int base)
-{
-	WARN_ON(irqc_node);
-
-	irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
-
-	WARN_ON(!irqc_node);
-	if (!irqc_node)
-		return -ENOENT;
-
-	irqc_base = base;
-	return 0;
-}
-
-static void __init gic_fixup_resource(struct resource *res)
-{
-	struct of_phandle_args irq_data;
-	unsigned int hwirq = res->start;
-	unsigned int virq;
-
-	if (resource_type(res) != IORESOURCE_IRQ || !irqc_node)
-		return;
-
-	irq_data.np = irqc_node;
-	irq_data.args_count = 3;
-	irq_data.args[0] = 0;
-	irq_data.args[1] = hwirq - irqc_base;
-	switch (res->flags &
-		(IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE |
-		 IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL)) {
-	case IORESOURCE_IRQ_LOWEDGE:
-		irq_data.args[2] = IRQ_TYPE_EDGE_FALLING;
-		break;
-	case IORESOURCE_IRQ_HIGHEDGE:
-		irq_data.args[2] = IRQ_TYPE_EDGE_RISING;
-		break;
-	case IORESOURCE_IRQ_LOWLEVEL:
-		irq_data.args[2] = IRQ_TYPE_LEVEL_LOW;
-		break;
-	case IORESOURCE_IRQ_HIGHLEVEL:
-	default:
-		irq_data.args[2] = IRQ_TYPE_LEVEL_HIGH;
-		break;
-	}
-
-	virq = irq_create_of_mapping(&irq_data);
-	if (WARN_ON(!virq))
-		return;
-
-	pr_debug("hwirq %u -> virq %u\n", hwirq, virq);
-	res->start = virq;
-}
-
-void __init board_staging_gic_fixup_resources(struct resource *res,
-					      unsigned int nres)
-{
-	unsigned int i;
-
-	for (i = 0; i < nres; i++)
-		gic_fixup_resource(&res[i]);
-}
-
-int __init board_staging_register_clock(const struct board_staging_clk *bsc)
-{
-	int error;
-
-	pr_debug("Aliasing clock %s for con_id %s dev_id %s\n", bsc->clk,
-		 bsc->con_id, bsc->dev_id);
-	error = clk_add_alias(bsc->con_id, bsc->dev_id, bsc->clk, NULL);
-	if (error)
-		pr_err("Failed to alias clock %s (%d)\n", bsc->clk, error);
-
-	return error;
-}
-
-#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
-static int board_staging_add_dev_domain(struct platform_device *pdev,
-					const char *domain)
-{
-	struct device *dev = &pdev->dev;
-	struct of_phandle_args pd_args;
-	struct device_node *np;
-
-	np = of_find_node_by_path(domain);
-	if (!np) {
-		pr_err("Cannot find domain node %s\n", domain);
-		return -ENOENT;
-	}
-
-	pd_args.np = np;
-	pd_args.args_count = 0;
-
-	/* Initialization similar to device_pm_init_common() */
-	spin_lock_init(&dev->power.lock);
-	dev->power.early_init = true;
-
-	return of_genpd_add_device(&pd_args, dev);
-}
-#else
-static inline int board_staging_add_dev_domain(struct platform_device *pdev,
-					       const char *domain)
-{
-	return 0;
-}
-#endif
-
-int __init board_staging_register_device(const struct board_staging_dev *dev)
-{
-	struct platform_device *pdev = dev->pdev;
-	unsigned int i;
-	int error;
-
-	pr_debug("Trying to register device %s\n", pdev->name);
-	if (board_staging_dt_node_available(pdev->resource,
-					    pdev->num_resources)) {
-		pr_warn("Skipping %s, already in DT\n", pdev->name);
-		return -EEXIST;
-	}
-
-	board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
-
-	for (i = 0; i < dev->nclocks; i++)
-		board_staging_register_clock(&dev->clocks[i]);
-
-	if (dev->domain)
-		board_staging_add_dev_domain(pdev, dev->domain);
-
-	error = platform_device_register(pdev);
-	if (error) {
-		pr_err("Failed to register device %s (%d)\n", pdev->name,
-		       error);
-		return error;
-	}
-
-	return error;
-}
-
-void __init board_staging_register_devices(const struct board_staging_dev *devs,
-					   unsigned int ndevs)
-{
-	unsigned int i;
-
-	for (i = 0; i < ndevs; i++)
-		board_staging_register_device(&devs[i]);
-}
diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
deleted file mode 100644
index 5609daf4d8695f02..0000000000000000
--- a/drivers/staging/board/board.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __BOARD_H__
-#define __BOARD_H__
-
-#include <linux/init.h>
-#include <linux/of.h>
-
-struct board_staging_clk {
-	const char *clk;
-	const char *con_id;
-	const char *dev_id;
-};
-
-struct board_staging_dev {
-	/* Platform Device */
-	struct platform_device *pdev;
-	/* Clocks (optional) */
-	const struct board_staging_clk *clocks;
-	unsigned int nclocks;
-	/* Generic PM Domain (optional) */
-	const char *domain;
-};
-
-struct resource;
-
-bool board_staging_dt_node_available(const struct resource *resource,
-				     unsigned int num_resources);
-int board_staging_gic_setup_xlate(const char *gic_match, unsigned int base);
-void board_staging_gic_fixup_resources(struct resource *res, unsigned int nres);
-int board_staging_register_clock(const struct board_staging_clk *bsc);
-int board_staging_register_device(const struct board_staging_dev *dev);
-void board_staging_register_devices(const struct board_staging_dev *devs,
-				    unsigned int ndevs);
-
-#define board_staging(str, fn)			\
-static int __init runtime_board_check(void)	\
-{						\
-	if (of_machine_is_compatible(str))	\
-		fn();				\
-						\
-	return 0;				\
-}						\
-						\
-device_initcall(runtime_board_check)
-
-#endif /* __BOARD_H__ */
-- 
2.34.1


