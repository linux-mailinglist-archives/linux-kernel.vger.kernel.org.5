Return-Path: <linux-kernel+bounces-29618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466AC8310D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B541F27AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6B187E;
	Thu, 18 Jan 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB8c5Jyp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C25665;
	Thu, 18 Jan 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541047; cv=none; b=DMXONSvd9zrkPmLhvVcz4y9uOp3CKTjiJI2aAKmqQruAPbv/CAcEyy2jCoQHo/FkijaXkB5EhPfSOxPQBhurz9zBgj6mY4r+jlibUclYr2QyQcZUxnMtlQzVi2IpovO4y8m0OQ68iu4ElUz7GLNBeUM6W7DVEgagLWSUOrd9+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541047; c=relaxed/simple;
	bh=z0tOA5t7mBXbPtmO+ZwsPJdYR8Va8TzVzjWtGVNmXzw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key; b=MBu3OrWFhzuENuUv3dd3Os4sCFIYsy2IcmjMIVdFKjnvwIH4xpjLA9IKIoCEatYpWNnowaOxA6CvUzZM2tTV6IWPvFrCxNeCEHpe7fXZTybKxveqWw2Y+At4GqMThGWpf5PM0aSJSelfBn8UGdH7Nz+0+YfwmZSEjvmqYqaOUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB8c5Jyp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705541045; x=1737077045;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=z0tOA5t7mBXbPtmO+ZwsPJdYR8Va8TzVzjWtGVNmXzw=;
  b=WB8c5Jypj2lPUyWazkchjxk708GJb1mbnsIz4sKam/xg4p/+UshY/fZz
   mxumHljBHYZMz5Z1lIZhgoSRdkv/GBOXwbVEioDiX06T2kIEXqY9kHUk1
   bfKMTlofwh9E0IB7g4heK6Mne0CEvBHVuVNj7dgZ78EBrnLoAKwyIzkIP
   jC2MInC/pgiZa1RnlyRoSQ60hvHRNQ1uAA8kAYrDSM1fbTC1I65bGQibl
   dckNR4BJnwtaQWeFUEFuEs3l4fs6nqGIZFtqe8E56wE3cvHZS8ogivzMA
   GFxtp/puPXoPYlXQySVMoBWTVE0zA1pzDSopwDAHSmhcDWRCNGCpeNA7d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="208635"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="208635"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777599315"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="777599315"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.114.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:24:03 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 Jan 2024 17:24:01 -0800
Subject: [PATCH v2] cxl/pci: Skip irq features if MSI/MSI-X are not
 supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-dont-fail-irq-v2-1-f33f26b0e365@intel.com>
X-B4-Tracking: v=1; b=H4sIALB9qGUC/3WMQQ6CMBAAv0J6tqZdCBRP/sNwKO1WNsFWW0I0h
 L9b8OJBjzPJzMISRsLETsXCIs6UKPgMcCiYGbS/IiebmYGASkihuA1+4k7TyCk+uG7rUoqyVk4
 4lpt7REfP/XfpMg+UphBf+36Wm/13miWXvKpEA6As9hbO5CccjybctvGnkvJXpQQYAN20aPqvq
 lvX9Q3rfHah4AAAAA==
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Larsen <davelarsen58@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705541042; l=5229;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=z0tOA5t7mBXbPtmO+ZwsPJdYR8Va8TzVzjWtGVNmXzw=;
 b=ynQqwwlnMs59Odbj1VlY2EMQilsdc0+eg5aAnPjs84ydXHPBhioa5XBglAIQz9T/D72noRxBK
 GgEgO8cQch7DMb+LuQAwksHU/81NkRvt75n7ZLu6hNSeBUQCtexwoFE
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

CXL 3.1 Section 3.1.1 states:

	"A Function on a CXL device must not generate INTx messages if
	that Function participates in CXL.cache protocol or CXL.mem
	protocols."

The generic CXL memory driver only supports devices which use the
CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
vectors in anticipation of their need for mailbox interrupts or event
processing.  However, the above requirement does not require a device to
support interrupts, only that they use MSI/MSI-X.  For example, a device
may disable mailbox interrupts and either be configured for firmware
first or skip event processing and function.

Dave Larsen reported that the following Intel / Agilex card does not
support interrupts on function 0.

	CXL: Intel Corporation Device 0ddb (rev 01) (prog-if 10 [CXL Memory Device (CXL 2.x)])

Rather than fail device probe if interrupts are not supported; flag that
irqs are not enabled and avoid features which require interrupts.
Emit messages appropriate for the situation to aid in debugging should
device behavior be unexpected due to a failure to allocate vectors.

Note that it is possible for a device to have host based event
processing through polling.  However, the driver does not support
polling and it is not anticipated to be generally required.  Leave that
functionality to a future patch if such a device comes along.

Reported-by: Dave Larsen <davelarsen58@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- [djbw: add reported by and info about the card.]
- [djbw: skip error reporting in the mailbox case.]
- [djbw: clean up event message]
- [iweiny: pick up tags]
- Link to v1: https://lore.kernel.org/r/20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com
---
 drivers/cxl/pci.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..93df03f0622e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -381,7 +381,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
+static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
@@ -440,7 +440,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
 
 	/* background command interrupts are optional */
-	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
+	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) || !irq_avail)
 		return 0;
 
 	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
@@ -587,7 +587,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
 	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
 }
 
-static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
+static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 {
 	int nvecs;
 
@@ -604,9 +604,9 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nvecs < 1) {
 		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
-		return -ENXIO;
+		return false;
 	}
-	return 0;
+	return true;
 }
 
 static irqreturn_t cxl_event_thread(int irq, void *id)
@@ -742,7 +742,7 @@ static bool cxl_event_int_is_fw(u8 setting)
 }
 
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
-			    struct cxl_memdev_state *mds)
+			    struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_event_interrupt_policy policy;
 	int rc;
@@ -754,6 +754,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (!host_bridge->native_cxl_error)
 		return 0;
 
+	if (!irq_avail) {
+		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
+		return 0;
+	}
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
@@ -788,6 +793,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
+	bool irq_avail;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -845,11 +851,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
+	irq_avail = cxl_alloc_irq_vectors(pdev);
 
-	rc = cxl_pci_setup_mailbox(mds);
+	rc = cxl_pci_setup_mailbox(mds, irq_avail);
 	if (rc)
 		return rc;
 
@@ -908,7 +912,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
-	rc = cxl_event_config(host_bridge, mds);
+	rc = cxl_event_config(host_bridge, mds, irq_avail);
 	if (rc)
 		return rc;
 

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240108-dont-fail-irq-a96310368f0f

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


