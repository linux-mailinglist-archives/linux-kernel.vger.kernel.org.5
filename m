Return-Path: <linux-kernel+bounces-64733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9685421A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE051C22774
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A76BE7F;
	Wed, 14 Feb 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fkcWPCs6"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23EBE5D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707885286; cv=none; b=Ii5nEN2rN3Rs7YG9b4+OCiq3Z74JVpdfIM15nn80JwQhkDva2SuoP+TGEegK+0B8FpQECl2oD671iTJAeFViahi9YEV97kfUVWfY2ytX+fZWrYdTMhu3tZ+zFbXkGo+CagZSVJ7+KUBqrvIcVvBi5FlOM81+PMXcqVe9zotieWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707885286; c=relaxed/simple;
	bh=irsURspAqpMbILQXpTI03+Vo+H4uSRdDhg1+Io7IN2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmA8xUQ85XSVi7HVcpToAlUqkaj1y5ICoemqzzIogawQu4fCP4baqGnLylQRtawkL6jTH/lN9jyBUqfDr3LYOaBYdqdoL01YV2kDdB0Zqib2SJ5qDhDN4Q8vsU48+n2mTHuo2AuWq08foMqTuoHxRpFSk2i46Z+e2f5MBrjkGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fkcWPCs6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DME3U6002601;
	Tue, 13 Feb 2024 19:56:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=IsbejTa7
	fdF+Fg+jCvx0TOTcJROf2EpdedKjm+Tp4v4=; b=fkcWPCs63dQAm1bLEtnHULSZ
	WkdL9psb3kK6lqN+BtQ8FkLTlG8Vhu0V7iMn4AC1JDG0v2lYPjiS4o6P1tkQnYNz
	eVp1O+L8dszm/4XXUa4VguMfBb46Jb8ZIJ8XQgZkkgjd6HB+tstrB+46R1Hr0LsZ
	4YqEKB8f7SJWZfucAzVWmP0wtFwrPWePTUHkQ5S5r1pApyWh/Hv0Y3wSKw1yiuWg
	9kQHWG+fBnYB/pxfsQiJ+RRC9fks+X2SJsqYPQEK6gto1O/7sD0ibkRRP3efdLNY
	XgdrE5qCoIm/fxF7FdAuDKojZ9yXbLHTsedcLnNo2FP+q2eKA8N2Tr6GUdfJNg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkk3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 19:56:02 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Feb
 2024 19:56:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 13 Feb 2024 19:56:00 -0800
Received: from localhost.localdomain (unknown [10.28.36.156])
	by maili.marvell.com (Postfix) with ESMTP id 538793F707A;
	Tue, 13 Feb 2024 19:55:58 -0800 (PST)
From: Vamsi Attunuru <vattunuru@marvell.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <vattunuru@marvell.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Date: Tue, 13 Feb 2024 19:55:24 -0800
Message-ID: <20240214035524.1245615-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8vgs3BytlwnGSAafTBc4BVBzhjd_PJ5D
X-Proofpoint-GUID: 8vgs3BytlwnGSAafTBc4BVBzhjd_PJ5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02

Adds PCIe PF driver for OcteonTx3 DPI PF device which initializes DPI
DMA hardware's global configuration and enables PF-VF mbox channels
which can be used by it's VF devices. This DPI PF driver handles only
the resource configuration requests from VFs and it does not have any
data movement functionality.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 MAINTAINERS                    |   5 +
 drivers/misc/Kconfig           |  10 +
 drivers/misc/Makefile          |   1 +
 drivers/misc/mrvl-dpi/Makefile |   9 +
 drivers/misc/mrvl-dpi/dpi.c    | 559 +++++++++++++++++++++++++++++++++
 drivers/misc/mrvl-dpi/dpi.h    | 232 ++++++++++++++
 6 files changed, 816 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..73029199716d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13104,6 +13104,11 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
 F:	drivers/mmc/host/sdhci-xenon*
 
+MARVELL OCTEONTX3 DPI DRIVER
+M:	Vamsi Attunuru <vattunuru@marvell.com>
+S:	Maintained
+F:	drivers/misc/mrvl-dpi
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..3142fdb1b4c0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -574,6 +574,16 @@ config NSM
 	  To compile this driver as a module, choose M here.
 	  The module will be called nsm.
 
+config MARVELL_OCTEONTX3_DPI
+	tristate "OcteonTX3 DPI driver"
+	depends on ARM64 && PCI
+	default m
+	help
+	  Enables OCTEONTX3 DPI driver which intializes DPI PF device's global configuration
+	  and it's VFs resource configuration to enable DMA transfers. DPI PF device
+	  does not have any data movement functionality, it only serves VF's resource
+	  configuration requests.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..86229072166c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_MARVELL_OCTEONTX3_DPI)	+= mrvl-dpi/
diff --git a/drivers/misc/mrvl-dpi/Makefile b/drivers/misc/mrvl-dpi/Makefile
new file mode 100644
index 000000000000..c938ea459483
--- /dev/null
+++ b/drivers/misc/mrvl-dpi/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Marvell's OcteonTX3 DPI driver
+#
+
+obj-$(CONFIG_MARVELL_OCTEONTX3_DPI) += octeontx3_dpi.o
+
+octeontx3_dpi-y := dpi.o
+
diff --git a/drivers/misc/mrvl-dpi/dpi.c b/drivers/misc/mrvl-dpi/dpi.c
new file mode 100644
index 000000000000..fe0b3ee469c8
--- /dev/null
+++ b/drivers/misc/mrvl-dpi/dpi.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx3 DPI driver
+ *
+ * Copyright (C) 2024 Marvell International Ltd.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include "dpi.h"
+
+#define DPI_DRV_NAME	"OcteonTx3-dpi"
+#define DPI_DRV_STRING  "Marvell OcteonTx3 DPI Driver"
+#define DPI_DRV_VERSION	"1.0"
+
+static int mps = 128;
+module_param(mps, int, 0644);
+MODULE_PARM_DESC(mps, "Maximum payload size, Supported sizes are 128, 256, 512 and 1024 bytes");
+
+static int mrrs = 128;
+module_param(mrrs, int, 0644);
+MODULE_PARM_DESC(mrrs, "Maximum read request size, Supported sizes are 128, 256, 512 and 1024 bytes");
+
+static unsigned long eng_fifo_buf = 0x101008080808;
+module_param(eng_fifo_buf, ulong, 0644);
+MODULE_PARM_DESC(eng_fifo_buf, "Per engine buffer size. Each byte corresponds to engine number");
+
+static void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
+{
+	writeq(val, dpi->reg_base + offset);
+}
+
+static u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
+{
+	return readq(dpi->reg_base + offset);
+}
+
+static int dpi_wqe_cs_offset(struct dpipf *dpi, u8 offset)
+{
+	u64 reg = 0ULL;
+
+	spin_lock(&dpi->vf_lock);
+	reg = dpi_reg_read(dpi, DPI_DMA_CONTROL);
+	reg &= ~DPI_DMA_CONTROL_WQECSDIS;
+	reg |= DPI_DMA_CONTROL_ZBWCSEN;
+	reg |= DPI_DMA_CONTROL_WQECSMODE1;
+	reg |= DPI_DMA_CONTROL_WQECSOFF(offset);
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	spin_unlock(&dpi->vf_lock);
+
+	return 0;
+}
+
+static int dpi_queue_init(struct dpipf *dpi, struct dpipf_vf *dpivf, u8 vf)
+{
+	u16 sso_pf_func = dpivf->vf_config.sso_pf_func;
+	u16 npa_pf_func = dpivf->vf_config.npa_pf_func;
+	u16 csize = dpivf->vf_config.csize;
+	u32 aura = dpivf->vf_config.aura;
+	int cnt = 0xFFFFF, queue = vf;
+	u64 reg = 0ULL;
+
+	spin_lock(&dpi->vf_lock);
+
+	dpi_reg_write(dpi, DPI_DMAX_QRST(queue), 0x1ULL);
+
+	while (cnt) {
+		reg = dpi_reg_read(dpi, DPI_DMAX_QRST(queue));
+		--cnt;
+		if (!(reg & 0x1))
+			break;
+	}
+
+	if (reg & 0x1)
+		dev_err(&dpi->pdev->dev, "Queue reset failed\n");
+
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), 0ULL);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), 0ULL);
+
+	reg = DPI_DMA_IBUFF_CSIZE_CSIZE(csize) | DPI_DMA_IBUFF_CSIZE_NPA_FREE;
+	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(queue), reg);
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS2(queue));
+	reg |= DPI_DMA_IDS2_INST_AURA(aura);
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), reg);
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS(queue));
+	reg |= DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
+	reg |= DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
+	reg |= DPI_DMA_IDS_DMA_STRM(vf + 1);
+	reg |= DPI_DMA_IDS_INST_STRM(vf + 1);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), reg);
+
+	spin_unlock(&dpi->vf_lock);
+
+	return 0;
+}
+
+static int dpi_queue_fini(struct dpipf *dpi, struct dpipf_vf *dpivf, u8 vf)
+{
+	int queue = vf;
+
+	spin_lock(&dpi->vf_lock);
+
+	dpi_reg_write(dpi, DPI_DMAX_QRST(queue), 0x1ULL);
+
+	/* Reset IDS and IDS2 registers */
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), 0ULL);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), 0ULL);
+
+	spin_unlock(&dpi->vf_lock);
+
+	return 0;
+}
+
+static void dpi_poll_pfvf_mbox(struct dpipf *dpi)
+{
+	u64 reg;
+	u32 vf;
+
+	reg = dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
+	if (reg) {
+		for (vf = 0; vf < DPI_MAX_VFS; vf++) {
+			if (!(reg & (0x1UL << vf)))
+				continue;
+
+			if (!dpi->mbox[vf]) {
+				dev_err(&dpi->pdev->dev, "bad mbox vf %d\n", vf);
+				continue;
+			}
+
+			schedule_work(&dpi->mbox[vf]->wk.work);
+		}
+
+		if (reg)
+			dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
+	}
+}
+
+static irqreturn_t dpi_mbox_intr_handler(int irq, void *data)
+{
+	struct dpipf *dpi = data;
+
+	dpi_poll_pfvf_mbox(dpi);
+
+	return IRQ_HANDLED;
+}
+
+static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf, union dpi_mbox_message_t *msg)
+{
+	switch (msg->s.cmd) {
+	case DPI_QUEUE_OPEN:
+		dpivf->vf_config.aura = msg->s.aura;
+		dpivf->vf_config.csize = msg->s.csize / 8;
+		dpivf->vf_config.sso_pf_func = msg->s.sso_pf_func;
+		dpivf->vf_config.npa_pf_func = msg->s.npa_pf_func;
+		dpi_queue_init(dpi, dpivf, msg->s.vfid);
+		if (msg->s.wqecs)
+			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
+		dpivf->setup_done = true;
+		break;
+	case DPI_QUEUE_OPEN_V2:
+		dpivf->vf_config.aura = msg->s.aura;
+		dpivf->vf_config.csize = msg->s.csize;
+		dpivf->vf_config.sso_pf_func = msg->s.sso_pf_func;
+		dpivf->vf_config.npa_pf_func = msg->s.npa_pf_func;
+		dpi_queue_init(dpi, dpivf, msg->s.vfid);
+		if (msg->s.wqecs)
+			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
+		dpivf->setup_done = true;
+		break;
+	case DPI_QUEUE_CLOSE:
+		dpivf->vf_config.aura = 0;
+		dpivf->vf_config.csize = 0;
+		dpivf->vf_config.sso_pf_func = 0;
+		dpivf->vf_config.npa_pf_func = 0;
+		dpi_queue_fini(dpi, dpivf, msg->s.vfid);
+		dpivf->setup_done = false;
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+static void dpi_pfvf_mbox_work(struct work_struct *work)
+{
+	struct dpi_pfvf_mbox_wk *wk = container_of(work, struct dpi_pfvf_mbox_wk, work);
+	union dpi_mbox_message_t msg = { 0 };
+	struct dpi_mbox *mbox = NULL;
+	struct dpipf_vf *dpivf;
+	struct dpipf *dpi;
+	int vf_id;
+
+	mbox = (struct dpi_mbox *)wk->ctxptr;
+	dpi = (struct dpipf *)mbox->pf;
+	vf_id = mbox->vf_id;
+
+	mutex_lock(&mbox->lock);
+	msg.u[0] = readq(mbox->vf_pf_data_reg);
+	if (unlikely(msg.u[0] == 0xFFFFFFFFFFFFFFFFU))
+		goto exit;
+
+	if (msg.s.vfid > dpi->total_vfs) {
+		dev_err(&dpi->pdev->dev, "Invalid vfid:%d\n", msg.s.vfid);
+		goto exit;
+	}
+
+	dpivf = &dpi->vf[msg.s.vfid];
+	msg.u[1] = readq(mbox->pf_vf_data_reg);
+	queue_config(dpi, dpivf, &msg);
+
+	writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
+exit:
+	mutex_unlock(&mbox->lock);
+}
+
+/* Setup registers for a PF mailbox */
+static void dpi_setup_mbox_regs(struct dpipf *dpi, int vf_id)
+{
+	struct dpi_mbox *mbox = dpi->mbox[vf_id];
+
+	mbox->pf_vf_data_reg = dpi->reg_base + DPI_MBOX_PF_VF_DATA0(vf_id);
+	mbox->vf_pf_data_reg = dpi->reg_base + DPI_MBOX_PF_VF_DATA1(vf_id);
+}
+
+static int dpi_pfvf_mbox_setup(struct dpipf *dpi)
+{
+	int vf;
+
+	for (vf = 0; vf < DPI_MAX_VFS; vf++) {
+		dpi->mbox[vf] = vzalloc(sizeof(*dpi->mbox[vf]));
+
+		if (!dpi->mbox[vf])
+			goto free_mbox;
+
+		memset(dpi->mbox[vf], 0, sizeof(struct dpi_mbox));
+		mutex_init(&dpi->mbox[vf]->lock);
+		INIT_WORK(&dpi->mbox[vf]->wk.work, dpi_pfvf_mbox_work);
+		dpi->mbox[vf]->wk.ctxptr = dpi->mbox[vf];
+		dpi->mbox[vf]->pf = dpi;
+		dpi->mbox[vf]->vf_id = vf;
+		dpi_setup_mbox_regs(dpi, vf);
+	}
+
+	return 0;
+
+free_mbox:
+	while (vf) {
+		vf--;
+		cancel_work_sync(&dpi->mbox[vf]->wk.work);
+		mutex_destroy(&dpi->mbox[vf]->lock);
+		vfree(dpi->mbox[vf]);
+		dpi->mbox[vf] = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static void dpi_pfvf_mbox_destroy(struct dpipf *dpi)
+{
+	int vf_id;
+
+	for (vf_id = 0; vf_id < DPI_MAX_VFS; vf_id++) {
+		if (!dpi->mbox[vf_id])
+			continue;
+
+		if (work_pending(&dpi->mbox[vf_id]->wk.work))
+			cancel_work_sync(&dpi->mbox[vf_id]->wk.work);
+
+		mutex_destroy(&dpi->mbox[vf_id]->lock);
+		vfree(dpi->mbox[vf_id]);
+		dpi->mbox[vf_id] = NULL;
+	}
+}
+
+/**
+ * Global initialization of DPI
+ *
+ * @dpi: DPI device context structure
+ * @return Zero on success, negative on failure
+ */
+static int dpi_init(struct dpipf *dpi)
+{
+	uint8_t *eng_buf = (uint8_t *)&eng_fifo_buf;
+	int engine, port = 0;
+	u8 mrrs_val, mps_val;
+	u64 reg;
+
+	for (engine = 0; engine < DPI_MAX_ENGINES; engine++) {
+		reg = DPI_ENG_BUF_BLKS(eng_buf[engine & 0x7]);
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
+	}
+
+	reg = 0ULL;
+	reg = (DPI_DMA_CONTROL_ZBWCSEN | DPI_DMA_CONTROL_PKT_EN | DPI_DMA_CONTROL_LDWB |
+		DPI_DMA_CONTROL_O_MODE | DPI_DMA_CONTROL_DMA_ENB(0x3fULL));
+
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	dpi_reg_write(dpi, DPI_CTL, DPI_CTL_EN);
+
+	/* Configure MPS and MRRS for DPI */
+	if (mrrs < DPI_EBUS_MRRS_MIN || mrrs > DPI_EBUS_MRRS_MAX || !is_power_of_2(mrrs)) {
+		dev_info(&dpi->pdev->dev, "Invalid MRRS size:%d, Using default size(128B)\n", mrrs);
+		mrrs = 128;
+	}
+	mrrs_val = fls(mrrs) - 8;
+
+	if (mps < DPI_EBUS_MPS_MIN || mps > DPI_EBUS_MPS_MAX || !is_power_of_2(mps)) {
+		dev_info(&dpi->pdev->dev, "Invalid MPS size:%d, Using default size(128B)\n", mps);
+		mps = 128;
+	}
+	mps_val = fls(mps) - 8;
+
+	for (port = 0; port < DPI_EBUS_MAX_PORTS; port++) {
+		reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
+		reg &= ~(DPI_EBUS_PORTX_CFG_MRRS(0x7) | DPI_EBUS_PORTX_CFG_MPS(0x7));
+		reg |= (DPI_EBUS_PORTX_CFG_MPS(mps_val) | DPI_EBUS_PORTX_CFG_MRRS(mrrs_val));
+		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
+	}
+
+	/* Set the write control FIFO threshold as per HW recommendation */
+	dpi_reg_write(dpi, DPI_WCTL_FIF_THR, 0x30);
+
+	return 0;
+}
+
+static int dpi_fini(struct dpipf *dpi)
+{
+	int engine = 0, port;
+	u64 reg = 0ULL;
+
+	for (engine = 0; engine < DPI_MAX_ENGINES ; engine++)
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
+
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	dpi_reg_write(dpi, DPI_CTL, reg);
+
+	for (port = 0; port < DPI_EBUS_MAX_PORTS; port++) {
+		reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
+		reg &= ~(DPI_EBUS_PORTX_CFG_MRRS(0x7) | DPI_EBUS_PORTX_CFG_MPS(0x7));
+		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
+	}
+
+	return 0;
+}
+
+static int dpi_irq_init(struct dpipf *dpi)
+{
+	int i, num_msix = 1, msix_allocated;
+	int ret = 0;
+
+	/* Clear all RAS interrupts */
+	dpi_reg_write(dpi, DPI_PF_RAS, DPI_PF_RAS_INT);
+
+	/* Clear all RAS interrupt enable bits */
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
+
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++) {
+		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i), DPI_REQQ_INT);
+	}
+
+	for (i = 0; i < DPI_MAX_CC_INT; i++) {
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), DPI_DMA_CC_INT);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i), DPI_DMA_CC_INT);
+	}
+
+	dpi->msix_entries = kcalloc(num_msix, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!dpi->msix_entries)
+		goto msix_alloc_err;
+
+	for (i = 0; i < num_msix; i++)
+		dpi->msix_entries[i].entry = DPI_MBOX_PF_VF_INT_IDX;
+
+	msix_allocated = pci_enable_msix_range(dpi->pdev, dpi->msix_entries, num_msix, num_msix);
+	if (msix_allocated != num_msix) {
+		dev_err(&dpi->pdev->dev, "DPI: Failed to enable %d msix irqs; got only %d\n",
+			num_msix, msix_allocated);
+		goto enable_msix_err;
+	}
+
+	dpi->num_irqs = msix_allocated;
+	dev_info(&dpi->pdev->dev, "DPI: MSI-X enabled successfully\n");
+
+	ret = request_irq(dpi->msix_entries[0].vector, dpi_mbox_intr_handler, 0, "dpi-mbox", dpi);
+	if (ret) {
+		dev_err(&dpi->pdev->dev, "DPI: request_irq failed for mbox; err=%d\n", ret);
+		goto enable_msix_err;
+	}
+
+	dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT_ENA_W1S, 0xFFFFFFFF);
+
+	return 0;
+
+enable_msix_err:
+	if (msix_allocated > 0)
+		pci_disable_msix(dpi->pdev);
+	kfree(dpi->msix_entries);
+	dpi->msix_entries = NULL;
+msix_alloc_err:
+	return -1;
+}
+
+static void dpi_irq_free(struct dpipf *dpi)
+{
+	int i = 0;
+
+	/* Clear All Enables */
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
+
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++) {
+		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i), DPI_REQQ_INT);
+	}
+
+	for (i = 0; i < DPI_MAX_CC_INT; i++) {
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), DPI_DMA_CC_INT);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i), DPI_DMA_CC_INT);
+	}
+
+	for (i = 0; i < dpi->num_irqs; i++)
+		free_irq(pci_irq_vector(dpi->pdev, DPI_MBOX_PF_VF_INT_IDX), dpi);
+
+	pci_free_irq_vectors(dpi->pdev);
+	kfree(dpi->msix_entries);
+	dpi->msix_entries = NULL;
+	dpi->num_irqs = 0;
+}
+
+static int dpi_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	struct dpipf *dpi = pci_get_drvdata(pdev);
+	int ret = 0;
+
+	if (numvfs == 0) {
+		pci_disable_sriov(pdev);
+		dpi->total_vfs = 0;
+	} else {
+		ret = pci_enable_sriov(pdev, numvfs);
+		if (ret == 0) {
+			dpi->total_vfs = numvfs;
+			ret = numvfs;
+		}
+	}
+
+	return ret;
+}
+
+static int dpi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct dpipf *dpi;
+	int ret;
+
+	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+
+	dpi->pdev = pdev;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to enable PCI device\n");
+		goto err_dpi_free;
+	}
+
+	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(4), DPI_DRV_NAME);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to request MMIO region\n");
+		goto err_dpi_free;
+	}
+
+	dpi->reg_base = pcim_iomap_table(pdev)[PCI_DPI_CFG_BAR];
+
+	/* Initialize global PF registers */
+	ret = dpi_init(dpi);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to initialize dpi\n");
+		goto err_dpi_free;
+	}
+
+	/* Setup PF-VF mailbox */
+	ret = dpi_pfvf_mbox_setup(dpi);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to setup pf-vf mbox\n");
+		goto err_dpi_fini;
+	}
+
+	/* Register interrupts */
+	ret = dpi_irq_init(dpi);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to initialize irq vectors\n");
+		goto err_dpi_mbox_free;
+	}
+
+	pci_set_drvdata(pdev, dpi);
+	spin_lock_init(&dpi->vf_lock);
+
+	return 0;
+
+err_dpi_mbox_free:
+	dpi_pfvf_mbox_destroy(dpi);
+err_dpi_fini:
+	dpi_fini(dpi);
+err_dpi_free:
+	devm_kfree(dev, dpi);
+	return ret;
+}
+
+static void dpi_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dpipf *dpi = pci_get_drvdata(pdev);
+
+	dpi_irq_free(dpi);
+	dpi_pfvf_mbox_destroy(dpi);
+	dpi_fini(dpi);
+	dpi_sriov_configure(pdev, 0);
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(dev, dpi);
+}
+
+static const struct pci_device_id dpi_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX3_DPI_PF,
+			 PCI_VENDOR_ID_CAVIUM, PCI_SUBDEVID_OCTEONTX3_DPI_PF) },
+	{ 0, }  /* end of table */
+};
+
+static struct pci_driver dpi_driver = {
+	.name = DPI_DRV_NAME,
+	.id_table = dpi_id_table,
+	.probe = dpi_probe,
+	.remove = dpi_remove,
+	.sriov_configure = dpi_sriov_configure,
+};
+
+static int __init dpi_init_module(void)
+{
+	pr_info("%s: %s\n", DPI_DRV_NAME, DPI_DRV_STRING);
+
+	return pci_register_driver(&dpi_driver);
+}
+
+static void __exit dpi_cleanup_module(void)
+{
+	pci_unregister_driver(&dpi_driver);
+}
+
+module_init(dpi_init_module);
+module_exit(dpi_cleanup_module);
+MODULE_DEVICE_TABLE(pci, dpi_id_table);
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION(DPI_DRV_STRING);
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DPI_DRV_VERSION);
diff --git a/drivers/misc/mrvl-dpi/dpi.h b/drivers/misc/mrvl-dpi/dpi.h
new file mode 100644
index 000000000000..99ebe6bbe577
--- /dev/null
+++ b/drivers/misc/mrvl-dpi/dpi.h
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell OcteonTx3 DPI driver
+ *
+ * Copyright (C) 2024 Marvell International Ltd.
+ */
+
+#ifndef __DPI_H__
+#define __DPI_H__
+
+ /* PCI device IDs */
+#define PCI_DEVID_OCTEONTX3_DPI_PF	0xA080
+#define PCI_SUBDEVID_OCTEONTX3_DPI_PF	0xBA00
+
+/* PCI BAR nos */
+#define PCI_DPI_CFG_BAR		0
+
+/* MSI-X interrupts */
+#define DPI_MAX_REQQ_INT 32
+#define DPI_MAX_CC_INT   64
+
+/* MBOX MSI-X interrupt vector index */
+#define DPI_MBOX_PF_VF_INT_IDX 0x75
+
+#define DPI_MAX_ENGINES 6
+#define DPI_MAX_VFS	32
+
+#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)		((x) & 0x3fff)
+#define DPI_DMA_IBUFF_CSIZE_GET_CSIZE(x)	((x) & 0x3fff)
+
+#define DPI_DMA_IBUFF_CSIZE_NPA_FREE		(1 << 16)
+
+#define DPI_DMA_IDS_INST_STRM(x)		((uint64_t)((x) & 0xff) << 40)
+#define DPI_DMA_IDS_GET_INST_STRM(x)		(((x) >> 40) & 0xff)
+
+#define DPI_DMA_IDS_DMA_STRM(x)			((uint64_t)((x) & 0xff) << 32)
+#define DPI_DMA_IDS_GET_DMA_STRM(x)		(((x) >> 32) & 0xff)
+
+#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)		((uint64_t)((x) & 0xffff) << 16)
+#define DPI_DMA_IDS_GET_DMA_NPA_PF_FUNC(x)	(((x) >> 16) & 0xffff)
+
+#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)		((uint64_t)((x) & 0xffff))
+#define DPI_DMA_IDS_GET_DMA_SSO_PF_FUNC(x)	((x) & 0xffff)
+
+#define DPI_DMA_IDS2_INST_AURA(x)		((uint64_t)((x) & 0xfffff))
+#define DPI_DMA_IDS2_GET_INST_AURA(x)		((x) & 0xfffff)
+
+#define DPI_ENG_BUF_BLKS(x)			((x) & 0x1fULL)
+#define DPI_ENG_BUF_GET_BLKS(x)			((x) & 0x1fULL)
+
+#define DPI_ENG_BUF_BASE(x)			(((x) & 0x3fULL) << 16)
+#define DPI_ENG_BUF_GET_BASE(x)			(((x) >> 16) & 0x3fULL)
+
+#define DPI_DMA_ENG_EN_QEN(x)			((x) & 0xffULL)
+#define DPI_DMA_ENG_EN_GET_QEN(x)		((x) & 0xffULL)
+
+#define DPI_DMA_ENG_EN_MOLR(x)			(((x) & 0x3ffULL) << 32)
+#define DPI_DMA_ENG_EN_GET_MOLR(x)		(((x) >> 32) & 0x3ffULL)
+
+#define DPI_DMA_CONTROL_DMA_ENB(x)		(((x) & 0x3fULL) << 48)
+#define DPI_DMA_CONTROL_GET_DMA_ENB(x)		(((x) >> 48) & 0x3fULL)
+
+#define DPI_DMA_CONTROL_O_ES(x)			(((x) & 0x3ULL) << 15)
+#define DPI_DMA_CONTROL_GET_O_ES(x)		(((x) >> 15) & 0x3ULL)
+
+#define DPI_DMA_CONTROL_O_MODE			(0x1ULL << 14)
+#define DPI_DMA_CONTROL_O_NS			(0x1ULL << 17)
+#define DPI_DMA_CONTROL_O_RO			(0x1ULL << 18)
+#define DPI_DMA_CONTROL_O_ADD1			(0x1ULL << 19)
+#define DPI_DMA_CONTROL_LDWB			(0x1ULL << 32)
+#define DPI_DMA_CONTROL_NCB_TAG_DIS		(0x1ULL << 34)
+#define DPI_DMA_CONTROL_WQECSMODE1		(0x1ULL << 37)
+#define DPI_DMA_CONTROL_ZBWCSEN			(0x1ULL << 39)
+#define DPI_DMA_CONTROL_WQECSOFF(offset)	(((uint64_t)offset) << 40)
+#define DPI_DMA_CONTROL_WQECSDIS		(0x1ULL << 47)
+#define DPI_DMA_CONTROL_UIO_DIS			(0x1ULL << 55)
+#define DPI_DMA_CONTROL_PKT_EN			(0x1ULL << 56)
+#define DPI_DMA_CONTROL_FFP_DIS			(0x1ULL << 59)
+
+#define DPI_CTL_EN				(0x1ULL)
+
+#define DPI_DMA_CC_INT				(0x1ULL)
+
+#define DPI_REQQ_INT_INSTRFLT			(0x1ULL)
+#define DPI_REQQ_INT_RDFLT			(0x1ULL << 1)
+#define DPI_REQQ_INT_WRFLT			(0x1ULL << 2)
+#define DPI_REQQ_INT_CSFLT			(0x1ULL << 3)
+#define DPI_REQQ_INT_INST_DBO			(0x1ULL << 4)
+#define DPI_REQQ_INT_INST_ADDR_NULL		(0x1ULL << 5)
+#define DPI_REQQ_INT_INST_FILL_INVAL		(0x1ULL << 6)
+#define DPI_REQQ_INT_INSTR_PSN			(0x1ULL << 7)
+
+#define DPI_REQQ_INT \
+	(DPI_REQQ_INT_INSTRFLT		| \
+	DPI_REQQ_INT_RDFLT		| \
+	DPI_REQQ_INT_WRFLT		| \
+	DPI_REQQ_INT_CSFLT		| \
+	DPI_REQQ_INT_INST_DBO		| \
+	DPI_REQQ_INT_INST_ADDR_NULL	| \
+	DPI_REQQ_INT_INST_FILL_INVAL	| \
+	DPI_REQQ_INT_INSTR_PSN)
+
+#define DPI_PF_RAS_EBI_DAT_PSN		(0x1ULL)
+#define DPI_PF_RAS_NCB_DAT_PSN		(0x1ULL << 1)
+#define DPI_PF_RAS_NCB_CMD_PSN		(0x1ULL << 2)
+#define DPI_PF_RAS_INT \
+	(DPI_PF_RAS_EBI_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_CMD_PSN)
+
+#define DPI_DMAX_IBUFF_CSIZE(x)			(0x0ULL | ((x) << 11))
+#define DPI_DMAX_REQBANK0(x)			(0x8ULL | ((x) << 11))
+#define DPI_DMAX_REQBANK1(x)			(0x10ULL | ((x) << 11))
+#define DPI_DMAX_IDS(x)				(0x18ULL | ((x) << 11))
+#define DPI_DMAX_IDS2(x)			(0x20ULL | ((x) << 11))
+#define DPI_DMAX_IFLIGHT(x)			(0x28ULL | ((x) << 11))
+#define DPI_DMAX_QRST(x)			(0x30ULL | ((x) << 11))
+#define DPI_DMAX_ERR_RSP_STATUS(x)		(0x38ULL | ((x) << 11))
+
+#define DPI_CSCLK_ACTIVE_PC 0x10000ULL
+#define DPI_CTL 0x10010ULL
+#define DPI_DMA_CONTROL (0x10018ULL)
+#define DPI_DMA_ENGX_EN(x) (0x10040ULL | ((x) << 3))
+#define DPI_ENGX_BUF(x)	(0x100C0ULL | ((x) << 3))
+#define DPI_EBUS_PORTX_CFG(x) (0x10100ULL | ((x) << 3))
+#define DPI_EBUS_PORTX_ERR_INFO(x) (0x10200ULL | ((x) << 3))
+#define DPI_EBUS_PORTX_ERR(x) (0x10280ULL | ((x) << 3))
+
+#define DPI_PF_RAS (0x10308ULL)
+#define DPI_PF_RAS_ENA_W1C (0x10318ULL)
+
+#define DPI_DMA_CCX_INT(x) (0x11000ULL | ((x) << 3))
+#define DPI_DMA_CCX_INT_ENA_W1C(x) (0x11800ULL | ((x) << 3))
+
+#define DPI_REQQX_INT(x) (0x12C00ULL | ((x) << 5))
+#define DPI_REQQX_INT_ENA_W1C(x) (0x13800ULL | ((x) << 5))
+
+#define DPI_MBOX_PF_VF_DATA0(x) (0x16000ULL | ((x) << 4))
+#define DPI_MBOX_PF_VF_DATA1(x) (0x16008ULL | ((x) << 4))
+
+#define DPI_MBOX_VF_PF_INT (0x16300ULL)
+#define DPI_MBOX_VF_PF_INT_W1S (0x16308ULL)
+#define DPI_MBOX_VF_PF_INT_ENA_W1C (0x16310ULL)
+#define DPI_MBOX_VF_PF_INT_ENA_W1S (0x16318ULL)
+
+#define DPI_WCTL_FIF_THR			(0x17008ULL)
+
+#define DPI_EBUS_MRRS_MIN			128
+#define DPI_EBUS_MRRS_MAX			1024
+#define DPI_EBUS_MPS_MIN			128
+#define DPI_EBUS_MPS_MAX			1024
+#define DPI_EBUS_MAX_PORTS			2
+#define DPI_EBUS_PORTX_CFG_MRRS(x)		(((x) & 0x7) << 0)
+#define DPI_EBUS_PORTX_CFG_MPS(x)		(((x) & 0x7) << 4)
+
+enum dpi_mbox_word_type {
+	DPI_MBOX_TYPE_CMD,
+	DPI_MBOX_TYPE_RSP_ACK,
+	DPI_MBOX_TYPE_RSP_NACK,
+};
+
+struct dpivf_config {
+	uint16_t csize;
+	uint32_t aura;
+	uint16_t sso_pf_func;
+	uint16_t npa_pf_func;
+};
+
+struct dpipf_vf {
+	uint8_t this_vfid;
+	bool setup_done;
+	struct dpivf_config vf_config;
+};
+
+/* Wrappers around work structs */
+struct dpi_pfvf_mbox_wk {
+	struct work_struct work;
+	void *ctxptr;
+};
+
+/* DPI device mailbox */
+struct dpi_mbox {
+	/* A mutex to protect access to mbox. */
+	struct mutex lock;
+	u32 vf_id;
+	u8 __iomem *pf_vf_data_reg;
+	u8 __iomem *vf_pf_data_reg;
+	struct dpi_pfvf_mbox_wk wk;
+	struct dpipf *pf;
+};
+
+struct dpipf {
+	void __iomem *reg_base;
+	struct pci_dev *pdev;
+	int num_irqs;
+	int total_vfs;
+	struct dpipf_vf vf[DPI_MAX_VFS];
+	struct msix_entry *msix_entries;
+	/* Mailbox to talk to VFs */
+	struct dpi_mbox *mbox[DPI_MAX_VFS];
+	/* lock to serialize queue access */
+	spinlock_t vf_lock;
+};
+
+#define DPI_QUEUE_OPEN  0x1
+#define DPI_QUEUE_CLOSE 0x2
+#define DPI_REG_DUMP    0x3
+#define DPI_GET_REG_CFG 0x4
+#define DPI_QUEUE_OPEN_V2 0x5
+
+union dpi_mbox_message_t {
+	uint64_t u[2];
+	struct dpi_mbox_message_s {
+		/* VF ID to configure */
+		uint64_t vfid           :8;
+		/* Command code */
+		uint64_t cmd            :4;
+		/* Command buffer size in 8-byte words */
+		uint64_t csize          :14;
+		/* aura of the command buffer */
+		uint64_t aura           :20;
+		/* SSO PF function */
+		uint64_t sso_pf_func    :16;
+		/* NPA PF function */
+		uint64_t npa_pf_func    :16;
+		/* Work queue completion status enable */
+		uint64_t wqecs		:1;
+		/* Work queue completion status byte offset */
+		uint64_t wqecsoff	:7;
+	} s __packed;
+};
+
+#endif
-- 
2.25.1


