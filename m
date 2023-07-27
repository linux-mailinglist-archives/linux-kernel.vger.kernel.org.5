Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF07654B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjG0NPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjG0NPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:15:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D41715
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1344b707so1697551e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1690463710; x=1691068510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlHS3c+VxHsFWIOTMvMRWn0mbzBcdnmU1XQTAfeqf/c=;
        b=iqCD0UbM5xzIU2MIzEc2I29BMfDR1GoL24i8lLESIpYhWhDg82rSEdmFR3rcwbWl4o
         tTWB4PjWGOoZeO04nNAd/L7iP452u1rpqgkW56lzchczujuVuOMQqQbt1t6vqR531mvL
         filn1+X/Y2WQh3qT6dIZ61NBg0wnCVI4Abtx9Au4aH5wxtLIYYzYokQIOhh0J/CRaEcy
         dHQXV/0fVbRvT+vrWLpaFOnFd4sGSgkCR3dpXBPV4zx/Jdcyg3D8zHdjszeKSG92peDE
         CKUpnMkppdORuLyqZjtVuEmD5tC9NPtF24/jOKfO1FkLHbxqfb46BgNSLQ+hW5tYoA4I
         gAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463710; x=1691068510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlHS3c+VxHsFWIOTMvMRWn0mbzBcdnmU1XQTAfeqf/c=;
        b=gPz8ZNGJ+UORdnaLQzMqCpEpttBFKLHsrpYphy/Oxi1ufzHFEPn/cIyzErGWEJk1w6
         Y0qMJNyKHCa4zeWco0xrzAL4irypgCtQ7FotPLtZ03eOST1du2lh+ngf/4PeAf/fY9q2
         Y1pALTF548HJVj/IWLmnyNzPu01TLVavwrD9cRpocmYnMZ2W8bY1ZYsBjfgjAvZnY1hO
         H4soqGh3krY0cAy4QCJMwtQDAS7KwuJZLJFAQawxRLg4WrWdxoOOLt9xabj10XnQwfrp
         MRV/rCQarT7wqWwPcQ38NPdj4QsNTgSQnQG6bSfEmWX2lJV1z7CAk2JKwnqIULVb6nD5
         mHBg==
X-Gm-Message-State: ABy/qLYUKbxG1GtMrDxKnTqabr2Rqtl+ipOvl8hvZ5F8JVH8iSvtVGCq
        7rgEN5NNyYAAd6fbDcD4v0HmQ/GpGnG+amvofO9v
X-Google-Smtp-Source: APBJJlHYSB6x26e+LEBz3SZb2KAilbyTwxQp9hD1HBKgwG/DRtYtsUGaL/Y+M+7TgW25aQ6P7y0L6A==
X-Received: by 2002:a19:4f58:0:b0:4f9:556b:93c4 with SMTP id a24-20020a194f58000000b004f9556b93c4mr1498198lfk.31.1690463709961;
        Thu, 27 Jul 2023 06:15:09 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id g11-20020ac2538b000000b004f21f196701sm306640lfh.203.2023.07.27.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:15:09 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v1 2/2] thunderbolt: add tracefs support to dev_* logging helpers
Date:   Thu, 27 Jul 2023 15:13:26 +0200
Message-Id: <20230727131326.2282301-2-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20230727131326.2282301-1-lb@semihalf.com>
References: <20230727131326.2282301-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrappers for dev_* logging functions used in thunderbolt
module in order to be able to dynamically enable/disable
logging of messages to the thunderbolt tracefs instance.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/thunderbolt/acpi.c      |  10 +--
 drivers/thunderbolt/ctl.c       |   9 +--
 drivers/thunderbolt/icm.c       |  14 ++---
 drivers/thunderbolt/nhi.c       |  72 +++++++++++-----------
 drivers/thunderbolt/nvm.c       |   2 +-
 drivers/thunderbolt/retimer.c   |  12 ++--
 drivers/thunderbolt/switch.c    |  24 ++++----
 drivers/thunderbolt/tb.c        |   8 +--
 drivers/thunderbolt/tb.h        |  25 +++++---
 drivers/thunderbolt/usb4_port.c |   2 +-
 drivers/thunderbolt/xdomain.c   | 106 ++++++++++++++++----------------
 11 files changed, 147 insertions(+), 137 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 38fefd0e5268..10d923b37f85 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -82,11 +82,11 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 				       DL_FLAG_RPM_ACTIVE |
 				       DL_FLAG_PM_RUNTIME);
 		if (link) {
-			dev_dbg(&nhi->pdev->dev, "created link from %s\n",
-				dev_name(&pdev->dev));
+			tb_dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+				   dev_name(&pdev->dev));
 		} else {
-			dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
-				 dev_name(&pdev->dev));
+			tb_dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
+				    dev_name(&pdev->dev));
 		}
 
 		pm_runtime_put(&pdev->dev);
@@ -119,7 +119,7 @@ void tb_acpi_add_links(struct tb_nhi *nhi)
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, 32,
 				     tb_acpi_add_link, NULL, nhi, NULL);
 	if (ACPI_FAILURE(status))
-		dev_warn(&nhi->pdev->dev, "failed to enumerate tunneled ports\n");
+		tb_dev_warn(&nhi->pdev->dev, "failed to enumerate tunneled ports\n");
 }
 
 /**
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index d997a4c545f7..a66dd965296b 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 
 #include "ctl.h"
+#include "tb.h"
 
 
 #define TB_CTL_RX_PKG_COUNT	10
@@ -54,16 +55,16 @@ struct tb_ctl {
 	dev_WARN(&(ctl)->nhi->pdev->dev, format, ## arg)
 
 #define tb_ctl_err(ctl, format, arg...) \
-	dev_err(&(ctl)->nhi->pdev->dev, format, ## arg)
+	tb_dev_err(&(ctl)->nhi->pdev->dev, format, ## arg)
 
 #define tb_ctl_warn(ctl, format, arg...) \
-	dev_warn(&(ctl)->nhi->pdev->dev, format, ## arg)
+	tb_dev_warn(&(ctl)->nhi->pdev->dev, format, ## arg)
 
 #define tb_ctl_info(ctl, format, arg...) \
-	dev_info(&(ctl)->nhi->pdev->dev, format, ## arg)
+	tb_dev_info(&(ctl)->nhi->pdev->dev, format, ## arg)
 
 #define tb_ctl_dbg(ctl, format, arg...) \
-	dev_dbg(&(ctl)->nhi->pdev->dev, format, ## arg)
+	tb_dev_dbg(&(ctl)->nhi->pdev->dev, format, ## arg)
 
 static DECLARE_WAIT_QUEUE_HEAD(tb_cfg_request_cancel_queue);
 /* Serializes access to request kref_get/put */
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index dbdcad8d73bf..0303d554b5a5 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1477,7 +1477,7 @@ static int icm_ar_get_mode(struct tb *tb)
 	} while (--retries);
 
 	if (!retries) {
-		dev_err(&nhi->pdev->dev, "ICM firmware not authenticated\n");
+		tb_dev_err(&nhi->pdev->dev, "ICM firmware not authenticated\n");
 		return -ENODEV;
 	}
 
@@ -1819,7 +1819,7 @@ static int icm_firmware_start(struct tb *tb, struct tb_nhi *nhi)
 	if (icm_firmware_running(nhi))
 		return 0;
 
-	dev_dbg(&nhi->pdev->dev, "starting ICM firmware\n");
+	tb_dev_dbg(&nhi->pdev->dev, "starting ICM firmware\n");
 
 	ret = icm_firmware_reset(tb, nhi);
 	if (ret)
@@ -1914,7 +1914,7 @@ static int icm_firmware_init(struct tb *tb)
 
 	ret = icm_firmware_start(tb, nhi);
 	if (ret) {
-		dev_err(&nhi->pdev->dev, "could not start ICM firmware\n");
+		tb_dev_err(&nhi->pdev->dev, "could not start ICM firmware\n");
 		return ret;
 	}
 
@@ -1946,10 +1946,10 @@ static int icm_firmware_init(struct tb *tb)
 	 */
 	ret = icm_reset_phy_port(tb, 0);
 	if (ret)
-		dev_warn(&nhi->pdev->dev, "failed to reset links on port0\n");
+		tb_dev_warn(&nhi->pdev->dev, "failed to reset links on port0\n");
 	ret = icm_reset_phy_port(tb, 1);
 	if (ret)
-		dev_warn(&nhi->pdev->dev, "failed to reset links on port1\n");
+		tb_dev_warn(&nhi->pdev->dev, "failed to reset links on port1\n");
 
 	return 0;
 }
@@ -2128,7 +2128,7 @@ static int icm_runtime_resume_switch(struct tb_switch *sw)
 	if (tb_route(sw)) {
 		if (!wait_for_completion_timeout(&sw->rpm_complete,
 						 msecs_to_jiffies(500))) {
-			dev_dbg(&sw->dev, "runtime resuming timed out\n");
+			tb_dev_dbg(&sw->dev, "runtime resuming timed out\n");
 		}
 	}
 	return 0;
@@ -2544,7 +2544,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	}
 
 	if (!icm->is_supported || !icm->is_supported(tb)) {
-		dev_dbg(&nhi->pdev->dev, "ICM not supported on this controller\n");
+		tb_dev_dbg(&nhi->pdev->dev, "ICM not supported on this controller\n");
 		tb_domain_put(tb);
 		return NULL;
 	}
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 3ff89817e421..39428f4ba071 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -152,9 +152,9 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 	else
 		new = old & ~mask;
 
-	dev_dbg(&ring->nhi->pdev->dev,
-		"%s interrupt at register %#x bit %d (%#x -> %#x)\n",
-		active ? "enabling" : "disabling", reg, interrupt_bit, old, new);
+	tb_dev_dbg(&ring->nhi->pdev->dev,
+		   "%s interrupt at register %#x bit %d (%#x -> %#x)\n",
+		   active ? "enabling" : "disabling", reg, interrupt_bit, old, new);
 
 	if (new == old)
 		dev_WARN(&ring->nhi->pdev->dev,
@@ -523,8 +523,8 @@ static int nhi_alloc_hop(struct tb_nhi *nhi, struct tb_ring *ring)
 	if (nhi->quirks & QUIRK_E2E) {
 		start_hop = RING_FIRST_USABLE_HOPID + 1;
 		if (ring->flags & RING_FLAG_E2E && !ring->is_tx) {
-			dev_dbg(&nhi->pdev->dev, "quirking E2E TX HopID %u -> %u\n",
-				ring->e2e_tx_hop, RING_E2E_RESERVED_HOPID);
+			tb_dev_dbg(&nhi->pdev->dev, "quirking E2E TX HopID %u -> %u\n",
+				   ring->e2e_tx_hop, RING_E2E_RESERVED_HOPID);
 			ring->e2e_tx_hop = RING_E2E_RESERVED_HOPID;
 		}
 	}
@@ -554,23 +554,23 @@ static int nhi_alloc_hop(struct tb_nhi *nhi, struct tb_ring *ring)
 	}
 
 	if (ring->hop > 0 && ring->hop < start_hop) {
-		dev_warn(&nhi->pdev->dev, "invalid hop: %d\n", ring->hop);
+		tb_dev_warn(&nhi->pdev->dev, "invalid hop: %d\n", ring->hop);
 		ret = -EINVAL;
 		goto err_unlock;
 	}
 	if (ring->hop < 0 || ring->hop >= nhi->hop_count) {
-		dev_warn(&nhi->pdev->dev, "invalid hop: %d\n", ring->hop);
+		tb_dev_warn(&nhi->pdev->dev, "invalid hop: %d\n", ring->hop);
 		ret = -EINVAL;
 		goto err_unlock;
 	}
 	if (ring->is_tx && nhi->tx_rings[ring->hop]) {
-		dev_warn(&nhi->pdev->dev, "TX hop %d already allocated\n",
+		tb_dev_warn(&nhi->pdev->dev, "TX hop %d already allocated\n",
 			 ring->hop);
 		ret = -EBUSY;
 		goto err_unlock;
 	}
 	if (!ring->is_tx && nhi->rx_rings[ring->hop]) {
-		dev_warn(&nhi->pdev->dev, "RX hop %d already allocated\n",
+		tb_dev_warn(&nhi->pdev->dev, "RX hop %d already allocated\n",
 			 ring->hop);
 		ret = -EBUSY;
 		goto err_unlock;
@@ -595,8 +595,8 @@ static struct tb_ring *tb_ring_alloc(struct tb_nhi *nhi, u32 hop, int size,
 {
 	struct tb_ring *ring = NULL;
 
-	dev_dbg(&nhi->pdev->dev, "allocating %s ring %d of size %d\n",
-		transmit ? "TX" : "RX", hop, size);
+	tb_dev_dbg(&nhi->pdev->dev, "allocating %s ring %d of size %d\n",
+		   transmit ? "TX" : "RX", hop, size);
 
 	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
 	if (!ring)
@@ -704,8 +704,8 @@ void tb_ring_start(struct tb_ring *ring)
 		dev_WARN(&ring->nhi->pdev->dev, "ring already started\n");
 		goto err;
 	}
-	dev_dbg(&ring->nhi->pdev->dev, "starting %s %d\n",
-		RING_TYPE(ring), ring->hop);
+	tb_dev_dbg(&ring->nhi->pdev->dev, "starting %s %d\n",
+		   RING_TYPE(ring), ring->hop);
 
 	if (ring->flags & RING_FLAG_FRAME) {
 		/* Means 4096 */
@@ -741,12 +741,12 @@ void tb_ring_start(struct tb_ring *ring)
 			hop &= REG_RX_OPTIONS_E2E_HOP_MASK;
 			flags |= hop;
 
-			dev_dbg(&ring->nhi->pdev->dev,
-				"enabling E2E for %s %d with TX HopID %d\n",
-				RING_TYPE(ring), ring->hop, ring->e2e_tx_hop);
+			tb_dev_dbg(&ring->nhi->pdev->dev,
+				   "enabling E2E for %s %d with TX HopID %d\n",
+				   RING_TYPE(ring), ring->hop, ring->e2e_tx_hop);
 		} else {
-			dev_dbg(&ring->nhi->pdev->dev, "enabling E2E for %s %d\n",
-				RING_TYPE(ring), ring->hop);
+			tb_dev_dbg(&ring->nhi->pdev->dev, "enabling E2E for %s %d\n",
+				   RING_TYPE(ring), ring->hop);
 		}
 
 		flags |= RING_FLAG_E2E_FLOW_CONTROL;
@@ -779,8 +779,8 @@ void tb_ring_stop(struct tb_ring *ring)
 {
 	spin_lock_irq(&ring->nhi->lock);
 	spin_lock(&ring->lock);
-	dev_dbg(&ring->nhi->pdev->dev, "stopping %s %d\n",
-		RING_TYPE(ring), ring->hop);
+	tb_dev_dbg(&ring->nhi->pdev->dev, "stopping %s %d\n",
+		   RING_TYPE(ring), ring->hop);
 	if (ring->nhi->going_away)
 		goto err;
 	if (!ring->running) {
@@ -848,8 +848,8 @@ void tb_ring_free(struct tb_ring *ring)
 	ring->descriptors_dma = 0;
 
 
-	dev_dbg(&ring->nhi->pdev->dev, "freeing %s %d\n", RING_TYPE(ring),
-		ring->hop);
+	tb_dev_dbg(&ring->nhi->pdev->dev, "freeing %s %d\n", RING_TYPE(ring),
+		   ring->hop);
 
 	/*
 	 * ring->work can no longer be scheduled (it is scheduled only
@@ -944,9 +944,9 @@ static void nhi_interrupt_work(struct work_struct *work)
 		if ((value & (1 << (bit % 32))) == 0)
 			continue;
 		if (type == 2) {
-			dev_warn(&nhi->pdev->dev,
-				 "RX overflow for ring %d\n",
-				 hop);
+			tb_dev_warn(&nhi->pdev->dev,
+				    "RX overflow for ring %d\n",
+				    hop);
 			continue;
 		}
 		if (type == 0)
@@ -954,10 +954,10 @@ static void nhi_interrupt_work(struct work_struct *work)
 		else
 			ring = nhi->rx_rings[hop];
 		if (ring == NULL) {
-			dev_warn(&nhi->pdev->dev,
-				 "got interrupt for inactive %s ring %d\n",
-				 type ? "RX" : "TX",
-				 hop);
+			tb_dev_warn(&nhi->pdev->dev,
+				    "got interrupt for inactive %s ring %d\n",
+				    type ? "RX" : "TX",
+				    hop);
 			continue;
 		}
 
@@ -1145,7 +1145,7 @@ static void nhi_shutdown(struct tb_nhi *nhi)
 {
 	int i;
 
-	dev_dbg(&nhi->pdev->dev, "shutdown\n");
+	tb_dev_dbg(&nhi->pdev->dev, "shutdown\n");
 
 	for (i = 0; i < nhi->hop_count; i++) {
 		if (nhi->tx_rings[i])
@@ -1231,7 +1231,7 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
 	pci_walk_bus(bus, nhi_check_iommu_pdev, &port_ok);
 
 	nhi->iommu_dma_protection = port_ok;
-	dev_dbg(&nhi->pdev->dev, "IOMMU DMA protection is %s\n",
+	tb_dev_dbg(&nhi->pdev->dev, "IOMMU DMA protection is %s\n",
 		str_enabled_disabled(port_ok));
 }
 
@@ -1246,7 +1246,7 @@ static void nhi_reset(struct tb_nhi *nhi)
 		return;
 
 	if (!host_reset) {
-		dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
+		tb_dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
 		return;
 	}
 
@@ -1257,13 +1257,13 @@ static void nhi_reset(struct tb_nhi *nhi)
 	do {
 		val = ioread32(nhi->iobase + REG_RESET);
 		if (!(val & REG_RESET_HRR)) {
-			dev_warn(&nhi->pdev->dev, "host router reset successful\n");
+			tb_dev_warn(&nhi->pdev->dev, "host router reset successful\n");
 			return;
 		}
 		usleep_range(10, 20);
 	} while (ktime_before(ktime_get(), timeout));
 
-	dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
+	tb_dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
 }
 
 static int nhi_init_msi(struct tb_nhi *nhi)
@@ -1367,7 +1367,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* cannot fail - table is allocated in pcim_iomap_regions */
 	nhi->iobase = pcim_iomap_table(pdev)[0];
 	nhi->hop_count = ioread32(nhi->iobase + REG_CAPS) & 0x3ff;
-	dev_dbg(dev, "total paths: %d\n", nhi->hop_count);
+	tb_dev_dbg(dev, "total paths: %d\n", nhi->hop_count);
 
 	nhi->tx_rings = devm_kcalloc(&pdev->dev, nhi->hop_count,
 				     sizeof(*nhi->tx_rings), GFP_KERNEL);
@@ -1404,7 +1404,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return dev_err_probe(dev, -ENODEV,
 			"failed to determine connection manager, aborting\n");
 
-	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
+	tb_dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
 
 	res = tb_domain_add(tb);
 	if (res) {
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 69fb3b0fa34f..9c58de48ea03 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -318,7 +318,7 @@ struct tb_nvm *tb_nvm_alloc(struct device *dev)
 		}
 
 		if (!vops) {
-			dev_dbg(dev, "retimer NVM format of vendor %#x unknown\n",
+			tb_dev_dbg(dev, "retimer NVM format of vendor %#x unknown\n",
 				rt->vendor);
 			return ERR_PTR(-EOPNOTSUPP);
 		}
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 47becb363ada..dbd54855fb77 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -97,7 +97,7 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	return 0;
 
 err_nvm:
-	dev_dbg(&rt->dev, "NVM upgrade disabled\n");
+	tb_dev_dbg(&rt->dev, "NVM upgrade disabled\n");
 	if (!IS_ERR(nvm))
 		tb_nvm_free(nvm);
 
@@ -410,20 +410,20 @@ static int tb_retimer_add(struct tb_port *port, u8 index, u32 auth_status)
 
 	ret = device_register(&rt->dev);
 	if (ret) {
-		dev_err(&rt->dev, "failed to register retimer: %d\n", ret);
+		tb_dev_err(&rt->dev, "failed to register retimer: %d\n", ret);
 		put_device(&rt->dev);
 		return ret;
 	}
 
 	ret = tb_retimer_nvm_add(rt);
 	if (ret) {
-		dev_err(&rt->dev, "failed to add NVM devices: %d\n", ret);
+		tb_dev_err(&rt->dev, "failed to add NVM devices: %d\n", ret);
 		device_unregister(&rt->dev);
 		return ret;
 	}
 
-	dev_info(&rt->dev, "new retimer found, vendor=%#x device=%#x\n",
-		 rt->vendor, rt->device);
+	tb_dev_info(&rt->dev, "new retimer found, vendor=%#x device=%#x\n",
+		    rt->vendor, rt->device);
 
 	pm_runtime_no_callbacks(&rt->dev);
 	pm_runtime_set_active(&rt->dev);
@@ -437,7 +437,7 @@ static int tb_retimer_add(struct tb_port *port, u8 index, u32 auth_status)
 
 static void tb_retimer_remove(struct tb_retimer *rt)
 {
-	dev_info(&rt->dev, "retimer disconnected\n");
+	tb_dev_info(&rt->dev, "retimer disconnected\n");
 	tb_nvm_free(rt->nvm);
 	device_unregister(&rt->dev);
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7ea63bb31714..37e519110faf 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2912,7 +2912,7 @@ int tb_switch_add(struct tb_switch *sw)
 	 */
 	ret = tb_switch_add_dma_port(sw);
 	if (ret) {
-		dev_err(&sw->dev, "failed to add DMA port\n");
+		tb_dev_err(&sw->dev, "failed to add DMA port\n");
 		return ret;
 	}
 
@@ -2922,12 +2922,12 @@ int tb_switch_add(struct tb_switch *sw)
 		/* read drom */
 		ret = tb_drom_read(sw);
 		if (ret)
-			dev_warn(&sw->dev, "reading DROM failed: %d\n", ret);
+			tb_dev_warn(&sw->dev, "reading DROM failed: %d\n", ret);
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
 		ret = tb_switch_set_uuid(sw);
 		if (ret) {
-			dev_err(&sw->dev, "failed to set UUID\n");
+			tb_dev_err(&sw->dev, "failed to set UUID\n");
 			return ret;
 		}
 
@@ -2938,7 +2938,7 @@ int tb_switch_add(struct tb_switch *sw)
 			}
 			ret = tb_init_port(&sw->ports[i]);
 			if (ret) {
-				dev_err(&sw->dev, "failed to initialize port %d\n", i);
+				tb_dev_err(&sw->dev, "failed to initialize port %d\n", i);
 				return ret;
 			}
 		}
@@ -2966,27 +2966,27 @@ int tb_switch_add(struct tb_switch *sw)
 
 	ret = device_add(&sw->dev);
 	if (ret) {
-		dev_err(&sw->dev, "failed to add device: %d\n", ret);
+		tb_dev_err(&sw->dev, "failed to add device: %d\n", ret);
 		return ret;
 	}
 
 	if (tb_route(sw)) {
-		dev_info(&sw->dev, "new device found, vendor=%#x device=%#x\n",
-			 sw->vendor, sw->device);
+		tb_dev_info(&sw->dev, "new device found, vendor=%#x device=%#x\n",
+			    sw->vendor, sw->device);
 		if (sw->vendor_name && sw->device_name)
-			dev_info(&sw->dev, "%s %s\n", sw->vendor_name,
-				 sw->device_name);
+			tb_dev_info(&sw->dev, "%s %s\n", sw->vendor_name,
+				    sw->device_name);
 	}
 
 	ret = usb4_switch_add_ports(sw);
 	if (ret) {
-		dev_err(&sw->dev, "failed to add USB4 ports\n");
+		tb_dev_err(&sw->dev, "failed to add USB4 ports\n");
 		goto err_del;
 	}
 
 	ret = tb_switch_nvm_add(sw);
 	if (ret) {
-		dev_err(&sw->dev, "failed to add NVM devices\n");
+		tb_dev_err(&sw->dev, "failed to add NVM devices\n");
 		goto err_ports;
 	}
 
@@ -3057,7 +3057,7 @@ void tb_switch_remove(struct tb_switch *sw)
 	usb4_switch_remove_ports(sw);
 
 	if (tb_route(sw))
-		dev_info(&sw->dev, "device disconnected\n");
+		tb_dev_info(&sw->dev, "device disconnected\n");
 	device_unregister(&sw->dev);
 }
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 62b26b7998fd..bfdd08eaeb64 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2413,11 +2413,11 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
 				       DL_FLAG_AUTOREMOVE_SUPPLIER |
 				       DL_FLAG_PM_RUNTIME);
 		if (link) {
-			dev_dbg(&nhi->pdev->dev, "created link from %s\n",
-				dev_name(&pdev->dev));
+			tb_dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+				   dev_name(&pdev->dev));
 		} else {
-			dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
-				 dev_name(&pdev->dev));
+			tb_dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
+				    dev_name(&pdev->dev));
 		}
 	}
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 3d874182b996..5353ca589886 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -720,26 +720,35 @@ static inline bool tb_dbg_trace_enabled(void)
 }
 #endif
 
-#define __LOG_TRACE_PRINT(log_func, tb, fmt, arg...)			\
+#define __LOG_TRACE_PRINT(log_func, dev, fmt, arg...)			\
 	do {								\
-		const struct device *dev = &(tb)->nhi->pdev->dev;	\
-									\
 		log_func(dev, fmt,  ## arg);				\
 									\
 		if (tb_dbg_trace_enabled())				\
 			tb_trace_printf(dev, fmt, ## arg);		\
 	} while (0)
 
+#define tb_to_dev(tb) (&(tb)->nhi->pdev->dev)
+
+#define tb_dev_err(dev, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_err, dev, fmt, ## arg)
+#define tb_dev_warn(dev, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_warn, dev, fmt, ## arg)
+#define tb_dev_info(dev, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_info, dev, fmt, ## arg)
+#define tb_dev_dbg(dev, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_dbg, dev, fmt, ## arg)
+
 #define tb_err(tb, fmt, arg...) \
-	__LOG_TRACE_PRINT(dev_err, tb, fmt, ## arg)
+	__LOG_TRACE_PRINT(dev_err, tb_to_dev(tb), fmt, ## arg)
 #define tb_WARN(tb, fmt, arg...) \
-	dev_WARN(&(tb)->nhi->pdev->dev, fmt, ## arg)
+	dev_WARN(tb_to_dev(tb), fmt, ## arg)
 #define tb_warn(tb, fmt, arg...) \
-	__LOG_TRACE_PRINT(dev_warn, tb, fmt, ## arg)
+	__LOG_TRACE_PRINT(dev_warn, tb_to_dev(tb), fmt, ## arg)
 #define tb_info(tb, fmt, arg...) \
-	__LOG_TRACE_PRINT(dev_info, tb, fmt, ## arg)
+	__LOG_TRACE_PRINT(dev_info, tb_to_dev(tb), fmt, ## arg)
 #define tb_dbg(tb, fmt, arg...) \
-	__LOG_TRACE_PRINT(dev_dbg, tb, fmt, ## arg)
+	__LOG_TRACE_PRINT(dev_dbg, tb_to_dev(tb), fmt, ## arg)
 
 #define __TB_SW_PRINT(level, sw, fmt, arg...)           \
 	do {                                            \
diff --git a/drivers/thunderbolt/usb4_port.c b/drivers/thunderbolt/usb4_port.c
index e355bfd6343f..a1b0b1c62acb 100644
--- a/drivers/thunderbolt/usb4_port.c
+++ b/drivers/thunderbolt/usb4_port.c
@@ -279,7 +279,7 @@ struct usb4_port *usb4_port_device_add(struct tb_port *port)
 	if (dev_fwnode(&usb4->dev)) {
 		ret = component_add(&usb4->dev, &connector_ops);
 		if (ret) {
-			dev_err(&usb4->dev, "failed to add component\n");
+			tb_dev_err(&usb4->dev, "failed to add component\n");
 			device_unregister(&usb4->dev);
 		}
 	}
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 5b5566862318..7d5241f588a7 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -659,7 +659,7 @@ static void update_property_block(struct tb_xdomain *xd)
 
 		dir = tb_property_copy_dir(xdomain_property_dir);
 		if (!dir) {
-			dev_warn(&xd->dev, "failed to copy properties\n");
+			tb_dev_warn(&xd->dev, "failed to copy properties\n");
 			goto out_unlock;
 		}
 
@@ -669,7 +669,7 @@ static void update_property_block(struct tb_xdomain *xd)
 
 		ret = tb_property_format_dir(dir, NULL, 0);
 		if (ret < 0) {
-			dev_warn(&xd->dev, "local property block creation failed\n");
+			tb_dev_warn(&xd->dev, "local property block creation failed\n");
 			tb_property_free_dir(dir);
 			goto out_unlock;
 		}
@@ -683,7 +683,7 @@ static void update_property_block(struct tb_xdomain *xd)
 
 		ret = tb_property_format_dir(dir, block, block_len);
 		if (ret) {
-			dev_warn(&xd->dev, "property block generation failed\n");
+			tb_dev_warn(&xd->dev, "property block generation failed\n");
 			tb_property_free_dir(dir);
 			kfree(block);
 			goto out_unlock;
@@ -1169,26 +1169,26 @@ static int tb_xdomain_get_uuid(struct tb_xdomain *xd)
 	u64 route;
 	int ret;
 
-	dev_dbg(&xd->dev, "requesting remote UUID\n");
+	tb_dev_dbg(&xd->dev, "requesting remote UUID\n");
 
 	ret = tb_xdp_uuid_request(tb->ctl, xd->route, xd->state_retries, &uuid,
 				  &route);
 	if (ret < 0) {
 		if (xd->state_retries-- > 0) {
-			dev_dbg(&xd->dev, "failed to request UUID, retrying\n");
+			tb_dev_dbg(&xd->dev, "failed to request UUID, retrying\n");
 			return -EAGAIN;
 		}
-		dev_dbg(&xd->dev, "failed to read remote UUID\n");
+		tb_dev_dbg(&xd->dev, "failed to read remote UUID\n");
 		return ret;
 	}
 
-	dev_dbg(&xd->dev, "got remote UUID %pUb\n", &uuid);
+	tb_dev_dbg(&xd->dev, "got remote UUID %pUb\n", &uuid);
 
 	if (uuid_equal(&uuid, xd->local_uuid)) {
 		if (route == xd->route)
-			dev_dbg(&xd->dev, "loop back detected\n");
+			tb_dev_dbg(&xd->dev, "loop back detected\n");
 		else
-			dev_dbg(&xd->dev, "intra-domain loop detected\n");
+			tb_dev_dbg(&xd->dev, "intra-domain loop detected\n");
 
 		/* Don't bond lanes automatically for loops */
 		xd->bonding_possible = false;
@@ -1200,7 +1200,7 @@ static int tb_xdomain_get_uuid(struct tb_xdomain *xd)
 	 * manager to replace it.
 	 */
 	if (xd->remote_uuid && !uuid_equal(&uuid, xd->remote_uuid)) {
-		dev_dbg(&xd->dev, "remote UUID is different, unplugging\n");
+		tb_dev_dbg(&xd->dev, "remote UUID is different, unplugging\n");
 		xd->is_unplugged = true;
 		return -ENODEV;
 	}
@@ -1221,26 +1221,26 @@ static int tb_xdomain_get_link_status(struct tb_xdomain *xd)
 	u8 slw, tlw, sls, tls;
 	int ret;
 
-	dev_dbg(&xd->dev, "sending link state status request to %pUb\n",
-		xd->remote_uuid);
+	tb_dev_dbg(&xd->dev, "sending link state status request to %pUb\n",
+		   xd->remote_uuid);
 
 	ret = tb_xdp_link_state_status_request(tb->ctl, xd->route,
 					       xd->state_retries, &slw, &tlw, &sls,
 					       &tls);
 	if (ret) {
 		if (ret != -EOPNOTSUPP && xd->state_retries-- > 0) {
-			dev_dbg(&xd->dev,
-				"failed to request remote link status, retrying\n");
+			tb_dev_dbg(&xd->dev,
+				   "failed to request remote link status, retrying\n");
 			return -EAGAIN;
 		}
-		dev_dbg(&xd->dev, "failed to receive remote link status\n");
+		tb_dev_dbg(&xd->dev, "failed to receive remote link status\n");
 		return ret;
 	}
 
-	dev_dbg(&xd->dev, "remote link supports width %#x speed %#x\n", slw, sls);
+	tb_dev_dbg(&xd->dev, "remote link supports width %#x speed %#x\n", slw, sls);
 
 	if (slw < LANE_ADP_CS_0_SUPPORTED_WIDTH_DUAL) {
-		dev_dbg(&xd->dev, "remote adapter is single lane only\n");
+		tb_dev_dbg(&xd->dev, "remote adapter is single lane only\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1269,22 +1269,22 @@ static int tb_xdomain_link_state_change(struct tb_xdomain *xd,
 		return ret;
 	tls = val & LANE_ADP_CS_1_TARGET_SPEED_MASK;
 
-	dev_dbg(&xd->dev, "sending link state change request with width %#x speed %#x\n",
-		tlw, tls);
+	tb_dev_dbg(&xd->dev, "sending link state change request with width %#x speed %#x\n",
+		   tlw, tls);
 
 	ret = tb_xdp_link_state_change_request(tb->ctl, xd->route,
 					       xd->state_retries, tlw, tls);
 	if (ret) {
 		if (ret != -EOPNOTSUPP && xd->state_retries-- > 0) {
-			dev_dbg(&xd->dev,
-				"failed to change remote link state, retrying\n");
+			tb_dev_dbg(&xd->dev,
+				   "failed to change remote link state, retrying\n");
 			return -EAGAIN;
 		}
-		dev_err(&xd->dev, "failed request link state change, aborting\n");
+		tb_dev_err(&xd->dev, "failed request link state change, aborting\n");
 		return ret;
 	}
 
-	dev_dbg(&xd->dev, "received link state change response\n");
+	tb_dev_dbg(&xd->dev, "received link state change response\n");
 	return 0;
 }
 
@@ -1302,11 +1302,11 @@ static int tb_xdomain_bond_lanes_uuid_high(struct tb_xdomain *xd)
 		width_mask = width | TB_LINK_WIDTH_ASYM_TX | TB_LINK_WIDTH_ASYM_RX;
 	} else {
 		if (xd->state_retries-- > 0) {
-			dev_dbg(&xd->dev,
-				"link state change request not received yet, retrying\n");
+			tb_dev_dbg(&xd->dev,
+				   "link state change request not received yet, retrying\n");
 			return -EAGAIN;
 		}
-		dev_dbg(&xd->dev, "timeout waiting for link change request\n");
+		tb_dev_dbg(&xd->dev, "timeout waiting for link change request\n");
 		return -ETIMEDOUT;
 	}
 
@@ -1334,8 +1334,8 @@ static int tb_xdomain_bond_lanes_uuid_high(struct tb_xdomain *xd)
 	ret = tb_port_wait_for_link_width(port, width_mask,
 					  XDOMAIN_BONDING_TIMEOUT);
 	if (ret) {
-		dev_warn(&xd->dev, "error waiting for link width to become %d\n",
-			 width_mask);
+		tb_dev_warn(&xd->dev, "error waiting for link width to become %d\n",
+			    width_mask);
 		return ret;
 	}
 
@@ -1345,7 +1345,7 @@ static int tb_xdomain_bond_lanes_uuid_high(struct tb_xdomain *xd)
 	tb_port_update_credits(port);
 	tb_xdomain_update_link_attributes(xd);
 
-	dev_dbg(&xd->dev, "lane bonding %s\n", str_enabled_disabled(width == 2));
+	tb_dev_dbg(&xd->dev, "lane bonding %s\n", str_enabled_disabled(width == 2));
 	return 0;
 }
 
@@ -1358,19 +1358,19 @@ static int tb_xdomain_get_properties(struct tb_xdomain *xd)
 	u32 gen = 0;
 	int ret;
 
-	dev_dbg(&xd->dev, "requesting remote properties\n");
+	tb_dev_dbg(&xd->dev, "requesting remote properties\n");
 
 	ret = tb_xdp_properties_request(tb->ctl, xd->route, xd->local_uuid,
 					xd->remote_uuid, xd->state_retries,
 					&block, &gen);
 	if (ret < 0) {
 		if (xd->state_retries-- > 0) {
-			dev_dbg(&xd->dev,
-				"failed to request remote properties, retrying\n");
+			tb_dev_dbg(&xd->dev,
+				   "failed to request remote properties, retrying\n");
 			return -EAGAIN;
 		}
 		/* Give up now */
-		dev_err(&xd->dev, "failed read XDomain properties from %pUb\n",
+		tb_dev_err(&xd->dev, "failed read XDomain properties from %pUb\n",
 			xd->remote_uuid);
 
 		return ret;
@@ -1386,14 +1386,14 @@ static int tb_xdomain_get_properties(struct tb_xdomain *xd)
 
 	dir = tb_property_parse_dir(block, ret);
 	if (!dir) {
-		dev_err(&xd->dev, "failed to parse XDomain properties\n");
+		tb_dev_err(&xd->dev, "failed to parse XDomain properties\n");
 		ret = -ENOMEM;
 		goto err_free_block;
 	}
 
 	ret = populate_properties(xd, dir);
 	if (ret) {
-		dev_err(&xd->dev, "missing XDomain properties in response\n");
+		tb_dev_err(&xd->dev, "missing XDomain properties in response\n");
 		goto err_free_dir;
 	}
 
@@ -1433,14 +1433,14 @@ static int tb_xdomain_get_properties(struct tb_xdomain *xd)
 		}
 
 		if (device_add(&xd->dev)) {
-			dev_err(&xd->dev, "failed to add XDomain device\n");
+			tb_dev_err(&xd->dev, "failed to add XDomain device\n");
 			return -ENODEV;
 		}
-		dev_info(&xd->dev, "new host found, vendor=%#x device=%#x\n",
-			 xd->vendor, xd->device);
+		tb_dev_info(&xd->dev, "new host found, vendor=%#x device=%#x\n",
+			    xd->vendor, xd->device);
 		if (xd->vendor_name && xd->device_name)
-			dev_info(&xd->dev, "%s %s\n", xd->vendor_name,
-				 xd->device_name);
+			tb_dev_info(&xd->dev, "%s %s\n", xd->vendor_name,
+				    xd->device_name);
 
 		tb_xdomain_debugfs_init(xd);
 	} else {
@@ -1486,10 +1486,10 @@ static void tb_xdomain_queue_link_status2(struct tb_xdomain *xd)
 static void tb_xdomain_queue_bonding(struct tb_xdomain *xd)
 {
 	if (memcmp(xd->local_uuid, xd->remote_uuid, UUID_SIZE) > 0) {
-		dev_dbg(&xd->dev, "we have higher UUID, other side bonds the lanes\n");
+		tb_dev_dbg(&xd->dev, "we have higher UUID, other side bonds the lanes\n");
 		xd->state = XDOMAIN_STATE_BONDING_UUID_HIGH;
 	} else {
-		dev_dbg(&xd->dev, "we have lower UUID, bonding lanes\n");
+		tb_dev_dbg(&xd->dev, "we have lower UUID, bonding lanes\n");
 		xd->state = XDOMAIN_STATE_LINK_STATE_CHANGE;
 	}
 
@@ -1530,7 +1530,7 @@ static void tb_xdomain_state_work(struct work_struct *work)
 			 state > XDOMAIN_STATE_ERROR))
 		return;
 
-	dev_dbg(&xd->dev, "running state %s\n", state_names[state]);
+	tb_dev_dbg(&xd->dev, "running state %s\n", state_names[state]);
 
 	switch (state) {
 	case XDOMAIN_STATE_INIT:
@@ -1626,7 +1626,7 @@ static void tb_xdomain_state_work(struct work_struct *work)
 		break;
 
 	default:
-		dev_warn(&xd->dev, "unexpected state %d\n", state);
+		tb_dev_warn(&xd->dev, "unexpected state %d\n", state);
 		break;
 	}
 
@@ -1643,19 +1643,19 @@ static void tb_xdomain_properties_changed(struct work_struct *work)
 					     properties_changed_work.work);
 	int ret;
 
-	dev_dbg(&xd->dev, "sending properties changed notification\n");
+	tb_dev_dbg(&xd->dev, "sending properties changed notification\n");
 
 	ret = tb_xdp_properties_changed_request(xd->tb->ctl, xd->route,
 				xd->properties_changed_retries, xd->local_uuid);
 	if (ret) {
 		if (xd->properties_changed_retries-- > 0) {
-			dev_dbg(&xd->dev,
-				"failed to send properties changed notification, retrying\n");
+			tb_dev_dbg(&xd->dev,
+				   "failed to send properties changed notification, retrying\n");
 			queue_delayed_work(xd->tb->wq,
 					   &xd->properties_changed_work,
 					   msecs_to_jiffies(XDOMAIN_DEFAULT_TIMEOUT));
 		}
-		dev_err(&xd->dev, "failed to send properties changed notification\n");
+		tb_dev_err(&xd->dev, "failed to send properties changed notification\n");
 		return;
 	}
 
@@ -1931,9 +1931,9 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 	xd->dev.groups = xdomain_attr_groups;
 	dev_set_name(&xd->dev, "%u-%llx", tb->index, route);
 
-	dev_dbg(&xd->dev, "local UUID %pUb\n", local_uuid);
+	tb_dev_dbg(&xd->dev, "local UUID %pUb\n", local_uuid);
 	if (remote_uuid)
-		dev_dbg(&xd->dev, "remote UUID %pUb\n", remote_uuid);
+		tb_dev_dbg(&xd->dev, "remote UUID %pUb\n", remote_uuid);
 
 	/*
 	 * This keeps the DMA powered on as long as we have active
@@ -2002,7 +2002,7 @@ void tb_xdomain_remove(struct tb_xdomain *xd)
 	if (!device_is_registered(&xd->dev)) {
 		put_device(&xd->dev);
 	} else {
-		dev_info(&xd->dev, "host disconnected\n");
+		tb_dev_info(&xd->dev, "host disconnected\n");
 		device_unregister(&xd->dev);
 	}
 }
@@ -2057,7 +2057,7 @@ int tb_xdomain_lane_bonding_enable(struct tb_xdomain *xd)
 	tb_port_update_credits(port);
 	tb_xdomain_update_link_attributes(xd);
 
-	dev_dbg(&xd->dev, "lane bonding enabled\n");
+	tb_dev_dbg(&xd->dev, "lane bonding enabled\n");
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tb_xdomain_lane_bonding_enable);
@@ -2085,7 +2085,7 @@ void tb_xdomain_lane_bonding_disable(struct tb_xdomain *xd)
 		tb_port_update_credits(port);
 		tb_xdomain_update_link_attributes(xd);
 
-		dev_dbg(&xd->dev, "lane bonding disabled\n");
+		tb_dev_dbg(&xd->dev, "lane bonding disabled\n");
 	}
 }
 EXPORT_SYMBOL_GPL(tb_xdomain_lane_bonding_disable);
-- 
2.41.0.487.g6d72f3e995-goog

