Return-Path: <linux-kernel+bounces-88446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16B86E1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD0283AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C36EB73;
	Fri,  1 Mar 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LolqKGOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95326D52E;
	Fri,  1 Mar 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298939; cv=none; b=DdbVf5/huFSHh3d9e3nidMXR86xx9tVQ0u2ZzYdyq3YztvGmOpV/FOymJAn18si5SYYSTTi8agBaXDltWJaXR6t2ORp+ZZYk9nSlNgEHVUQabpHKFYWtHBO7T8Cr61VRIYBf4gEi56/DrRBOucW3kFGYLKMWM5A5i8pDN/tXW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298939; c=relaxed/simple;
	bh=05brAvK9Z0TPbV+QpfLJz1jGAHWOD5dX4mQufBvnrGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLj3KXNZ7Ze3oH1S+Ay9rckOif27WTTf/GBjtyDeRv+ONaAHcJLDnIFsPuUfcBVF+XMsGr9JcPY/DkCHnRRSqiFsxYrp0Aspwvb8eII7JRcdLkLTTkFPdgs7V7Z39GG+3TrpF14H0BB70ul2EOPeYY7eASMpnXPk8sOsXsRV3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LolqKGOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B55BC43390;
	Fri,  1 Mar 2024 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298939;
	bh=05brAvK9Z0TPbV+QpfLJz1jGAHWOD5dX4mQufBvnrGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LolqKGOkAq9PKXAmKb5uO4vkqtBjy9BZm0rghSGJE2nWryQjgZp+tpTMey/a5dlgC
	 FZYgZqOm3T6JH9bCRo3DcAumU0ZvAsY86Cit2OZY5vh0xjmwKtUG04vZqugLpamRX1
	 mWp4uRCu8Ms29ZLpTlqarInP5gVLsclLwr5Bo9Qw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.308
Date: Fri,  1 Mar 2024 14:15:29 +0100
Message-ID: <2024030128-landless-playoff-cfa7@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030128-recharger-bullwhip-fa3f@gregkh>
References: <2024030128-recharger-bullwhip-fa3f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4c1ea41b5621..63b99860a450 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 307
+SUBLEVEL = 308
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index faf48a3b1fea..b82afe4d26fb 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -330,6 +330,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9f6f392a4461..66c7f13b0c99 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -273,7 +273,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 /* combine single writes by using store-block insn */
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
-       zpci_memcpy_toio(to, from, count);
+	zpci_memcpy_toio(to, from, count * 8);
 }
 
 /* Create a virtual mapping cookie for a PCI BAR */
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab3ea47ecce3..abdfd440987b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -634,6 +634,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->force_port_map = 1;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8b3bf11329ba..8e4c431efc6c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -943,14 +943,15 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_freeze_queue(vblk->disk->queue);
+
 	/* Ensure we don't receive any more interrupts */
 	vdev->config->reset(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
@@ -968,7 +969,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_unquiesce_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 2c0a969adc9f..35987a35a848 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -29,7 +29,7 @@ struct sh_dmae_chan {
 	const struct sh_dmae_slave_config *config; /* Slave DMA configuration */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	void __iomem *base;
-	char dev_id[16];		/* unique name per DMAC of channel */
+	char dev_id[32];		/* unique name per DMAC of channel */
 	int pm_error;
 	dma_addr_t slave_addr;
 };
diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 11c634125c7d..0e6f96c0e395 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -442,7 +442,23 @@ static void bm_work(struct work_struct *work)
 	 */
 	card->bm_generation = generation;
 
-	if (root_device == NULL) {
+	if (card->gap_count == 0) {
+		/*
+		 * If self IDs have inconsistent gap counts, do a
+		 * bus reset ASAP. The config rom read might never
+		 * complete, so don't wait for it. However, still
+		 * send a PHY configuration packet prior to the
+		 * bus reset. The PHY configuration packet might
+		 * fail, but 1394-2008 8.4.5.2 explicitly permits
+		 * it in this case, so it should be safe to try.
+		 */
+		new_root_id = local_id;
+		/*
+		 * We must always send a bus reset if the gap count
+		 * is inconsistent, so bypass the 5-reset limit.
+		 */
+		card->bm_retries = 0;
+	} else if (root_device == NULL) {
 		/*
 		 * Either link_on is false, or we failed to read the
 		 * config rom.  In either case, pick another root.
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
index 4b571cc6bc70..6597def18627 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
@@ -154,11 +154,17 @@ shadow_fw_init(struct nvkm_bios *bios, const char *name)
 	return (void *)fw;
 }
 
+static void
+shadow_fw_release(void *fw)
+{
+	release_firmware(fw);
+}
+
 static const struct nvbios_source
 shadow_fw = {
 	.name = "firmware",
 	.init = shadow_fw_init,
-	.fini = (void(*)(void *))release_firmware,
+	.fini = shadow_fw_release,
 	.read = shadow_fw_read,
 	.rw = false,
 };
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index d06e88477588..01c6518fe565 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f8c9caa8aad6..e365fa8251c1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1475,7 +1475,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
 		/* SRQ resize is not supported */
-		break;
+		return -EINVAL;
 	case IB_SRQ_LIMIT:
 		/* Change the SRQ threshold */
 		if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
@@ -1490,13 +1490,12 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
-		break;
+		return 0;
 	default:
 		dev_err(rdev_to_dev(rdev),
 			"Unsupported srq_attr_mask 0x%x", srq_attr_mask);
 		return -EINVAL;
 	}
-	return 0;
 }
 
 int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr)
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 3fcbf56f8be2..c2a129ed1774 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -2118,7 +2118,7 @@ int init_credit_return(struct hfi1_devdata *dd)
 				   "Unable to allocate credit return DMA range for NUMA %d\n",
 				   i);
 			ret = -ENOMEM;
-			goto done;
+			goto free_cr_base;
 		}
 	}
 	set_dev_node(&dd->pcidev->dev, dd->node);
@@ -2126,6 +2126,10 @@ int init_credit_return(struct hfi1_devdata *dd)
 	ret = 0;
 done:
 	return ret;
+
+free_cr_base:
+	free_credit_return(dd);
+	goto done;
 }
 
 void free_credit_return(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 245f9505a9ac..05e35027342d 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3202,7 +3202,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 9f36ca786df8..1e88213459f2 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -277,7 +277,7 @@ void ipoib_event(struct ib_event_handler *handler,
 		return;
 
 	ipoib_dbg(priv, "Event %d on device %s port %d\n", record->event,
-		  record->device->name, record->element.port_num);
+		  dev_name(&record->device->dev), record->element.port_num);
 
 	if (record->event == IB_EVENT_SM_CHANGE ||
 	    record->event == IB_EVENT_CLIENT_REREGISTER) {
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index bee8c0b1d6a5..4ff3d98fa6a4 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -55,7 +55,7 @@ static void iser_event_handler(struct ib_event_handler *handler,
 {
 	iser_err("async event %s (%d) on device %s port %d\n",
 		 ib_event_msg(event->event), event->event,
-		 event->device->name, event->element.port_num);
+		dev_name(&event->device->dev), event->element.port_num);
 }
 
 /**
@@ -85,7 +85,7 @@ static int iser_create_device_ib_res(struct iser_device *device)
 	max_cqe = min(ISER_MAX_CQ_LEN, ib_dev->attrs.max_cqe);
 
 	iser_info("using %d CQs, device %s supports %d vectors max_cqe %d\n",
-		  device->comps_used, ib_dev->name,
+		  device->comps_used, dev_name(&ib_dev->dev),
 		  ib_dev->num_comp_vectors, max_cqe);
 
 	device->pd = ib_alloc_pd(ib_dev,
@@ -468,7 +468,8 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 			iser_conn->max_cmds =
 				ISER_GET_MAX_XMIT_CMDS(ib_dev->attrs.max_qp_wr);
 			iser_dbg("device %s supports max_send_wr %d\n",
-				 device->ib_device->name, ib_dev->attrs.max_qp_wr);
+				 dev_name(&device->ib_device->dev),
+				 ib_dev->attrs.max_qp_wr);
 		}
 	}
 
@@ -764,7 +765,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 		      IB_DEVICE_SIGNATURE_HANDOVER)) {
 			iser_warn("T10-PI requested but not supported on %s, "
 				  "continue without T10-PI\n",
-				  ib_conn->device->ib_device->name);
+				  dev_name(&ib_conn->device->ib_device->dev));
 			ib_conn->pi_support = false;
 		} else {
 			ib_conn->pi_support = true;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index d7b7b77e4d65..c4eec0aef76e 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -262,7 +262,7 @@ isert_alloc_comps(struct isert_device *device)
 
 	isert_info("Using %d CQs, %s supports %d vectors support "
 		   "pi_capable %d\n",
-		   device->comps_used, device->ib_device->name,
+		   device->comps_used, dev_name(&device->ib_device->dev),
 		   device->ib_device->num_comp_vectors,
 		   device->pi_capable);
 
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index 15711dcc6f58..d119d9afa845 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -888,7 +888,8 @@ static void opa_vnic_event(struct ib_event_handler *handler,
 		return;
 
 	c_dbg("OPA_VNIC received event %d on device %s port %d\n",
-	      record->event, record->device->name, record->element.port_num);
+	      record->event, dev_name(&record->device->dev),
+	      record->element.port_num);
 
 	if (record->event == IB_EVENT_PORT_ERR)
 		idr_for_each(&port->vport_idr, vema_disable_vport, NULL);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 6dcdc42ed081..f5402c574200 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3115,7 +3115,8 @@ static ssize_t show_local_ib_device(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%s\n", target->srp_host->srp_dev->dev->name);
+	return sprintf(buf, "%s\n",
+		       dev_name(&target->srp_host->srp_dev->dev->dev));
 }
 
 static ssize_t show_ch_count(struct device *dev, struct device_attribute *attr,
@@ -3990,7 +3991,7 @@ static ssize_t show_ibdev(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
-	return sprintf(buf, "%s\n", host->srp_dev->dev->name);
+	return sprintf(buf, "%s\n", dev_name(&host->srp_dev->dev->dev));
 }
 
 static DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
@@ -4022,7 +4023,8 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 
 	host->dev.class = &srp_class;
 	host->dev.parent = device->dev->dev.parent;
-	dev_set_name(&host->dev, "srp-%s-%d", device->dev->name, port);
+	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
+		     port);
 
 	if (device_register(&host->dev))
 		goto free_host;
@@ -4098,7 +4100,7 @@ static void srp_add_one(struct ib_device *device)
 	srp_dev->mr_max_size	= srp_dev->mr_page_size *
 				   srp_dev->max_pages_per_mr;
 	pr_debug("%s: mr_page_shift = %d, device->max_mr_size = %#llx, device->max_fast_reg_page_list_len = %u, max_pages_per_mr = %d, mr_max_size = %#x\n",
-		 device->name, mr_page_shift, attr->max_mr_size,
+		 dev_name(&device->dev), mr_page_shift, attr->max_mr_size,
 		 attr->max_fast_reg_page_list_len,
 		 srp_dev->max_pages_per_mr, srp_dev->mr_max_size);
 
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 6090f1ce0c56..5cbccf5a54d6 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -82,12 +82,16 @@ module_param(srpt_srq_size, int, 0444);
 MODULE_PARM_DESC(srpt_srq_size,
 		 "Shared receive queue (SRQ) size.");
 
+static int srpt_set_u64_x(const char *buffer, const struct kernel_param *kp)
+{
+	return kstrtou64(buffer, 16, (u64 *)kp->arg);
+}
 static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
 {
 	return sprintf(buffer, "0x%016llx", *(u64 *)kp->arg);
 }
-module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
-		  0444);
+module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
+		  &srpt_service_guid, 0444);
 MODULE_PARM_DESC(srpt_service_guid,
 		 "Using this value for ioc_guid, id_ext, and cm_listen_id"
 		 " instead of using the node_guid of the first HCA.");
@@ -148,7 +152,7 @@ static void srpt_event_handler(struct ib_event_handler *handler,
 		return;
 
 	pr_debug("ASYNC event= %d on device= %s\n", event->event,
-		 sdev->device->name);
+		 dev_name(&sdev->device->dev));
 
 	switch (event->event) {
 	case IB_EVENT_PORT_ERR:
@@ -217,12 +221,15 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
 /**
  * srpt_qp_event - QP event callback function
  * @event: Description of the event that occurred.
- * @ch: SRPT RDMA channel.
+ * @ptr: SRPT RDMA channel.
  */
-static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
+static void srpt_qp_event(struct ib_event *event, void *ptr)
 {
-	pr_debug("QP event %d on ch=%p sess_name=%s state=%d\n",
-		 event->event, ch, ch->sess_name, ch->state);
+	struct srpt_rdma_ch *ch = ptr;
+
+	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
+		 event->event, ch, ch->sess_name, ch->qp->qp_num,
+		 get_ch_state_name(ch->state));
 
 	switch (event->event) {
 	case IB_EVENT_COMM_EST:
@@ -1761,8 +1768,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	}
 
 	qp_init->qp_context = (void *)ch;
-	qp_init->event_handler
-		= (void(*)(struct ib_event *, void*))srpt_qp_event;
+	qp_init->event_handler = srpt_qp_event;
 	qp_init->send_cq = ch->cq;
 	qp_init->recv_cq = ch->cq;
 	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
@@ -1963,9 +1969,10 @@ static void __srpt_close_all_ch(struct srpt_port *sport)
 	list_for_each_entry(nexus, &sport->nexus_list, entry) {
 		list_for_each_entry(ch, &nexus->ch_list, list) {
 			if (srpt_disconnect_ch(ch) >= 0)
-				pr_info("Closing channel %s because target %s_%d has been disabled\n",
-					ch->sess_name,
-					sport->sdev->device->name, sport->port);
+				pr_info("Closing channel %s-%d because target %s_%d has been disabled\n",
+					ch->sess_name, ch->qp->qp_num,
+					dev_name(&sport->sdev->device->dev),
+					sport->port);
 			srpt_close_ch(ch);
 		}
 	}
@@ -2159,7 +2166,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	if (!sport->enabled) {
 		rej->reason = cpu_to_be32(SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
 		pr_info("rejected SRP_LOGIN_REQ because target port %s_%d has not yet been enabled\n",
-			sport->sdev->device->name, port_num);
+			dev_name(&sport->sdev->device->dev), port_num);
 		goto reject;
 	}
 
@@ -2299,7 +2306,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		rej->reason = cpu_to_be32(
 				SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
 		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
-			sdev->device->name, port_num);
+			dev_name(&sdev->device->dev), port_num);
 		mutex_unlock(&sport->mutex);
 		ret = -EINVAL;
 		goto reject;
@@ -2886,7 +2893,7 @@ static int srpt_release_sport(struct srpt_port *sport)
 	while (wait_event_timeout(sport->ch_releaseQ,
 				  srpt_ch_list_empty(sport), 5 * HZ) <= 0) {
 		pr_info("%s_%d: waiting for session unregistration ...\n",
-			sport->sdev->device->name, sport->port);
+			dev_name(&sport->sdev->device->dev), sport->port);
 		rcu_read_lock();
 		list_for_each_entry(nexus, &sport->nexus_list, entry) {
 			list_for_each_entry(ch, &nexus->ch_list, list) {
@@ -2976,7 +2983,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	}
 
 	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
-		 sdev->device->attrs.max_srq_wr, device->name);
+		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
 
 	sdev->ioctx_ring = (struct srpt_recv_ioctx **)
 		srpt_alloc_ioctx_ring(sdev, sdev->srq_size,
@@ -3009,8 +3016,8 @@ static int srpt_use_srq(struct srpt_device *sdev, bool use_srq)
 	} else if (use_srq && !sdev->srq) {
 		ret = srpt_alloc_srq(sdev);
 	}
-	pr_debug("%s(%s): use_srq = %d; ret = %d\n", __func__, device->name,
-		 sdev->use_srq, ret);
+	pr_debug("%s(%s): use_srq = %d; ret = %d\n", __func__,
+		 dev_name(&device->dev), sdev->use_srq, ret);
 	return ret;
 }
 
@@ -3096,7 +3103,7 @@ static void srpt_add_one(struct ib_device *device)
 
 		if (srpt_refresh_port(sport)) {
 			pr_err("MAD registration failed for %s-%d.\n",
-			       sdev->device->name, i);
+			       dev_name(&sdev->device->dev), i);
 			goto err_event;
 		}
 	}
@@ -3107,7 +3114,7 @@ static void srpt_add_one(struct ib_device *device)
 
 out:
 	ib_set_client_data(device, &srpt_client, sdev);
-	pr_debug("added %s.\n", device->name);
+	pr_debug("added %s.\n", dev_name(&device->dev));
 	return;
 
 err_event:
@@ -3122,7 +3129,7 @@ static void srpt_add_one(struct ib_device *device)
 	kfree(sdev);
 err:
 	sdev = NULL;
-	pr_info("%s(%s) failed.\n", __func__, device->name);
+	pr_info("%s(%s) failed.\n", __func__, dev_name(&device->dev));
 	goto out;
 }
 
@@ -3137,7 +3144,8 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 	int i;
 
 	if (!sdev) {
-		pr_info("%s(%s): nothing to do.\n", __func__, device->name);
+		pr_info("%s(%s): nothing to do.\n", __func__,
+			dev_name(&device->dev));
 		return;
 	}
 
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 908bf0768827..569904f73994 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1734,6 +1734,12 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	io->ctx.bio_out = clone;
 	io->ctx.iter_out = clone->bi_iter;
 
+	if (crypt_integrity_aead(cc)) {
+		bio_copy_data(clone, io->base_bio);
+		io->ctx.bio_in = clone;
+		io->ctx.iter_in = clone->bi_iter;
+	}
+
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..5ec268817ee4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -188,8 +188,6 @@ struct stmmac_priv {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_rings_status;
-	struct dentry *dbgfs_dma_cap;
 #endif
 
 	unsigned long state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e35cdf0d2b7..f62622410355 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -115,7 +115,7 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
-static int stmmac_init_fs(struct net_device *dev);
+static void stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
 
@@ -4063,54 +4063,30 @@ static struct notifier_block stmmac_notifier = {
 	.notifier_call = stmmac_device_event,
 };
 
-static int stmmac_init_fs(struct net_device *dev)
+static void stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	rtnl_lock();
+
 	/* Create per netdev entries */
 	priv->dbgfs_dir = debugfs_create_dir(dev->name, stmmac_fs_dir);
 
-	if (!priv->dbgfs_dir || IS_ERR(priv->dbgfs_dir)) {
-		netdev_err(priv->dev, "ERROR failed to create debugfs directory\n");
-
-		return -ENOMEM;
-	}
-
 	/* Entry to report DMA RX/TX rings */
-	priv->dbgfs_rings_status =
-		debugfs_create_file("descriptors_status", 0444,
-				    priv->dbgfs_dir, dev,
-				    &stmmac_rings_status_fops);
-
-	if (!priv->dbgfs_rings_status || IS_ERR(priv->dbgfs_rings_status)) {
-		netdev_err(priv->dev, "ERROR creating stmmac ring debugfs file\n");
-		debugfs_remove_recursive(priv->dbgfs_dir);
-
-		return -ENOMEM;
-	}
+	debugfs_create_file("descriptors_status", 0444, priv->dbgfs_dir, dev,
+			    &stmmac_rings_status_fops);
 
 	/* Entry to report the DMA HW features */
-	priv->dbgfs_dma_cap = debugfs_create_file("dma_cap", 0444,
-						  priv->dbgfs_dir,
-						  dev, &stmmac_dma_cap_fops);
-
-	if (!priv->dbgfs_dma_cap || IS_ERR(priv->dbgfs_dma_cap)) {
-		netdev_err(priv->dev, "ERROR creating stmmac MMC debugfs file\n");
-		debugfs_remove_recursive(priv->dbgfs_dir);
-
-		return -ENOMEM;
-	}
-
-	register_netdevice_notifier(&stmmac_notifier);
+	debugfs_create_file("dma_cap", 0444, priv->dbgfs_dir, dev,
+			    &stmmac_dma_cap_fops);
 
-	return 0;
+	rtnl_unlock();
 }
 
 static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
@@ -4442,10 +4418,7 @@ int stmmac_dvr_probe(struct device *device,
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	ret = stmmac_init_fs(ndev);
-	if (ret < 0)
-		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
-			    __func__);
+	stmmac_init_fs(ndev);
 #endif
 
 	return ret;
@@ -4483,14 +4456,14 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
-#ifdef CONFIG_DEBUG_FS
-	stmmac_exit_fs(ndev);
-#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	clk_disable_unprepare(priv->plat->pclk);
@@ -4705,16 +4678,9 @@ static int __init stmmac_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	/* Create debugfs main directory if it doesn't exist yet */
-	if (!stmmac_fs_dir) {
+	if (!stmmac_fs_dir)
 		stmmac_fs_dir = debugfs_create_dir(STMMAC_RESOURCE_NAME, NULL);
-
-		if (!stmmac_fs_dir || IS_ERR(stmmac_fs_dir)) {
-			pr_err("ERROR %s, debugfs create directory failed\n",
-			       STMMAC_RESOURCE_NAME);
-
-			return -ENOMEM;
-		}
-	}
+	register_netdevice_notifier(&stmmac_notifier);
 #endif
 
 	return 0;
@@ -4723,6 +4689,7 @@ static int __init stmmac_init(void)
 static void __exit stmmac_exit(void)
 {
 #ifdef CONFIG_DEBUG_FS
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(stmmac_fs_dir);
 #endif
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 615edcb88037..a8664d181aa0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1385,20 +1385,20 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = genl_register_family(&gtp_genl_family);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto unreg_rtnl_link;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_genl_family;
+		goto unreg_pernet_subsys;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_genl_family:
-	genl_unregister_family(&gtp_genl_family);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
 error_out:
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c585ae3278de..532d810b89b2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1382,7 +1382,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 {
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		PCI_DEVID(dev->bus->number, dev->devfn) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 34f3b9778ffa..215581dfd333 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -164,6 +164,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 52e0ae4dc724..e9102359e313 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -285,9 +285,10 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		if (!recover) {
 			hash_del(&addr->hnode);
 			kfree(addr);
-			continue;
+		} else {
+			/* prepare for recovery */
+			addr->disp_flag = QETH_DISP_ADDR_ADD;
 		}
-		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
 	spin_unlock_bh(&card->ip_lock);
@@ -325,11 +326,13 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 			} else
 				rc = qeth_l3_register_addr_entry(card, addr);
 
-			if (!rc) {
+			if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
+				/* keep it in the records */
 				addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 				if (addr->ref_counter < 1)
 					qeth_l3_delete_ip(card, addr);
 			} else {
+				/* bad address */
 				hash_del(&addr->hnode);
 				kfree(addr);
 			}
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6047f0284f73..5c3635378c32 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1252,7 +1252,7 @@ source "drivers/scsi/arm/Kconfig"
 
 config JAZZ_ESP
 	bool "MIPS JAZZ FAS216 SCSI support"
-	depends on MACH_JAZZ && SCSI
+	depends on MACH_JAZZ && SCSI=y
 	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the onboard SCSI host adapter of MIPS Magnum
diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index a8dbe55e8ba8..3d1ea245681b 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
@@ -25,7 +25,8 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "ca53-cpu3",	0x200, 3, R8A77980_PD_CA53_CPU3, R8A77980_PD_CA53_SCU,
 	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON },
+	{ "cr7",	0x240, 0, R8A77980_PD_CR7,	R8A77980_PD_ALWAYS_ON,
+	  PD_CPU_NOCR },
 	{ "a3ir",	0x180, 0, R8A77980_PD_A3IR,	R8A77980_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77980_PD_A2IR0,	R8A77980_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77980_PD_A2IR1,	R8A77980_PD_A3IR },
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index a23dcbe79e14..3ed43a5f1fd3 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -164,7 +164,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, unpacked_lun);
@@ -195,10 +194,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 	se_tmr->tmr_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 
-	spin_lock_irqsave(&se_tmr->tmr_dev->se_tmr_lock, flags);
-	list_add_tail(&se_tmr->tmr_list, &se_tmr->tmr_dev->dev_tmr_list);
-	spin_unlock_irqrestore(&se_tmr->tmr_dev->se_tmr_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(transport_lookup_tmr_lun);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 64481a3a34d4..f8ba730fa1cf 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3463,6 +3463,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 2ef2464a5043..b8597d4a4864 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1349,7 +1349,15 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	/*
+	 * Windows NCM driver avoids USB ZLPs by adding a 1-byte
+	 * zero pad as needed.
+	 */
+	if (to_process == 1 &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		to_process--;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 1dd492e89719..379c1400bd9a 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -19,6 +19,7 @@ struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
 	enum usb_role role;
+	bool registered;
 
 	/* From descriptor */
 	struct device *usb2_port;
@@ -45,6 +46,9 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
+	if (!sw->registered)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
@@ -68,7 +72,7 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 {
 	enum usb_role role;
 
-	if (IS_ERR_OR_NULL(sw))
+	if (IS_ERR_OR_NULL(sw) || !sw->registered)
 		return USB_ROLE_NONE;
 
 	mutex_lock(&sw->lock);
@@ -276,6 +280,8 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	sw->registered = true;
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -290,8 +296,10 @@ EXPORT_SYMBOL_GPL(usb_role_switch_register);
  */
 void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw))
+	if (!IS_ERR_OR_NULL(sw)) {
+		sw->registered = false;
 		device_unregister(&sw->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c09d7426cd92..d9eafdb89cea 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -869,6 +869,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 20aff9005978..b7f9da690db2 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1488,6 +1488,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
diff --git a/fs/aio.c b/fs/aio.c
index 1bd934eccbf6..8ad748dd3e48 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -566,6 +566,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1446,7 +1453,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index df390979058f..5af5ad53e0ad 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1802,6 +1802,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1809,6 +1812,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
@@ -1835,12 +1839,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (err)
 		return err;
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
-		ext4_mb_unload_buddy(e4b);
-		return 0;
-	}
-
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ac->ac_g_ex.fe_start,
 			     ac->ac_g_ex.fe_len, &ex);
 	ex.fe_logical = 0xDEADFA11; /* debug value */
@@ -1873,6 +1875,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index e2a5320f2718..b9c759addd50 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_msg(dat->i_sb, KERN_ERR,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f89748aac8c3..e2c87c056742 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -304,6 +304,8 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index e79229a0cf01..8a36122afb75 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -434,7 +434,7 @@ static inline void rvt_set_ibdev_name(struct rvt_dev_info *rdi,
  */
 static inline const char *rvt_get_ibdev_name(const struct rvt_dev_info *rdi)
 {
-	return rdi->ibdev.name;
+	return dev_name(&rdi->ibdev.dev);
 }
 
 static inline struct rvt_pd *ibpd_to_rvtpd(struct ib_pd *ibpd)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 394c66442cff..deb9366e4f30 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -2658,9 +2658,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		(sysctl_sched_rt_runtime > sysctl_sched_rt_period))
 		return -EINVAL;
@@ -2690,7 +2687,7 @@ int sched_rt_handler(struct ctl_table *table, int write,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
@@ -2735,6 +2732,9 @@ int sched_rr_handler(struct ctl_table *table, int write,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4bb194f096ec..6ce9f10b9c7d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,7 @@ static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static int int_max = INT_MAX;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
@@ -464,6 +465,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &one,
+		.extra2		= &int_max,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -471,6 +474,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &neg_one,
+		.extra2		= &int_max,
 	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a366cf79821..d187bfb43b1f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2015,6 +2015,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
@@ -2022,6 +2025,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2057,6 +2062,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
@@ -2088,21 +2094,22 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
+		bool flush = false;
 
+		rcu_read_lock();
 		memcg = stock->cached;
-		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
-			continue;
-		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
-			css_put(&memcg->css);
-			continue;
-		}
-		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
+		if (memcg && stock->nr_pages &&
+		    mem_cgroup_is_descendant(memcg, root_memcg))
+			flush = true;
+		rcu_read_unlock();
+
+		if (flush &&
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
 			else
 				schedule_work_on(cpu, &stock->work);
 		}
-		css_put(&memcg->css);
 	}
 	put_cpu();
 	mutex_unlock(&percpu_charge_mutex);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index aae19c29bcfa..dcca7788222a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -179,6 +179,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      bool *mmap_changing,
 					      bool zeropage)
 {
 	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
@@ -310,6 +311,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				goto out;
 			}
 			down_read(&dst_mm->mmap_sem);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && READ_ONCE(*mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -391,6 +401,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
+				      bool *mmap_changing,
 				      bool zeropage);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -508,7 +519,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, zeropage);
+					       src_start, len, mmap_changing,
+					       zeropage);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 89d55770ac74..4bd601c96434 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -445,22 +445,24 @@ int __init seg6_init(void)
 {
 	int err = -ENOMEM;
 
-	err = genl_register_family(&seg6_genl_family);
+	err = register_pernet_subsys(&ip6_segments_ops);
 	if (err)
 		goto out;
 
-	err = register_pernet_subsys(&ip6_segments_ops);
+	err = genl_register_family(&seg6_genl_family);
 	if (err)
-		goto out_unregister_genl;
+		goto out_unregister_pernet;
 
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	err = seg6_iptunnel_init();
 	if (err)
-		goto out_unregister_pernet;
+		goto out_unregister_genl;
 
 	err = seg6_local_init();
-	if (err)
-		goto out_unregister_pernet;
+	if (err) {
+		seg6_iptunnel_exit();
+		goto out_unregister_genl;
+	}
 #endif
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
@@ -481,11 +483,11 @@ int __init seg6_init(void)
 #endif
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
-out_unregister_pernet:
-	unregister_pernet_subsys(&ip6_segments_ops);
-#endif
 out_unregister_genl:
 	genl_unregister_family(&seg6_genl_family);
+#endif
+out_unregister_pernet:
+	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
 }
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 7342344d99a9..7bcf4b3559ef 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -648,7 +648,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
-	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
+	ulen = len + (skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0);
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 5c209f72de70..714d0b01ea62 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -629,6 +629,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3a0aadf881fc..89500b1fe301 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2868,7 +2868,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 377832981178..e8b05769d1c9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1850,7 +1850,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 	 */
 
 	spkt->spkt_family = dev->type;
-	strlcpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
+	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
 	spkt->spkt_protocol = skb->protocol;
 
 	/*
@@ -3501,7 +3501,7 @@ static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strlcpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
+		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
 	rcu_read_unlock();
 
 	return sizeof(*uaddr);
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 7698a8974a47..567ca509b295 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -44,23 +44,6 @@ if NET_SCHED
 
 comment "Queueing/Scheduling"
 
-config NET_SCH_CBQ
-	tristate "Class Based Queueing (CBQ)"
-	---help---
-	  Say Y here if you want to use the Class-Based Queueing (CBQ) packet
-	  scheduling algorithm. This algorithm classifies the waiting packets
-	  into a tree-like hierarchy of classes; the leaves of this tree are
-	  in turn scheduled by separate algorithms.
-
-	  See the top of <file:net/sched/sch_cbq.c> for more details.
-
-	  CBQ is a commonly used scheduler, so if you're unsure, you should
-	  say Y here. Then say Y to all the queueing algorithms below that you
-	  want to use as leaf disciplines.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_cbq.
-
 config NET_SCH_HTB
 	tristate "Hierarchical Token Bucket (HTB)"
 	---help---
@@ -84,20 +67,6 @@ config NET_SCH_HFSC
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_hfsc.
 
-config NET_SCH_ATM
-	tristate "ATM Virtual Circuits (ATM)"
-	depends on ATM
-	---help---
-	  Say Y here if you want to use the ATM pseudo-scheduler.  This
-	  provides a framework for invoking classifiers, which in turn
-	  select classes of this queuing discipline.  Each class maps
-	  the flow(s) it is handling to a given virtual circuit.
-
-	  See the top of <file:net/sched/sch_atm.c> for more details.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_atm.
-
 config NET_SCH_PRIO
 	tristate "Multi Band Priority Queueing (PRIO)"
 	---help---
@@ -205,17 +174,6 @@ config NET_SCH_GRED
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_gred.
 
-config NET_SCH_DSMARK
-	tristate "Differentiated Services marker (DSMARK)"
-	---help---
-	  Say Y if you want to schedule packets according to the
-	  Differentiated Services architecture proposed in RFC 2475.
-	  Technical information on this method, with pointers to associated
-	  RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_dsmark.
-
 config NET_SCH_NETEM
 	tristate "Network emulator (NETEM)"
 	---help---
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 3139c32e1947..afc5ccb537b9 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -28,20 +28,17 @@ obj-$(CONFIG_NET_IFE_SKBPRIO)	+= act_meta_skbprio.o
 obj-$(CONFIG_NET_IFE_SKBTCINDEX)	+= act_meta_skbtcindex.o
 obj-$(CONFIG_NET_ACT_TUNNEL_KEY)+= act_tunnel_key.o
 obj-$(CONFIG_NET_SCH_FIFO)	+= sch_fifo.o
-obj-$(CONFIG_NET_SCH_CBQ)	+= sch_cbq.o
 obj-$(CONFIG_NET_SCH_HTB)	+= sch_htb.o
 obj-$(CONFIG_NET_SCH_HFSC)	+= sch_hfsc.o
 obj-$(CONFIG_NET_SCH_RED)	+= sch_red.o
 obj-$(CONFIG_NET_SCH_GRED)	+= sch_gred.o
 obj-$(CONFIG_NET_SCH_INGRESS)	+= sch_ingress.o
-obj-$(CONFIG_NET_SCH_DSMARK)	+= sch_dsmark.o
 obj-$(CONFIG_NET_SCH_SFB)	+= sch_sfb.o
 obj-$(CONFIG_NET_SCH_SFQ)	+= sch_sfq.o
 obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
 obj-$(CONFIG_NET_SCH_TEQL)	+= sch_teql.o
 obj-$(CONFIG_NET_SCH_PRIO)	+= sch_prio.o
 obj-$(CONFIG_NET_SCH_MULTIQ)	+= sch_multiq.o
-obj-$(CONFIG_NET_SCH_ATM)	+= sch_atm.o
 obj-$(CONFIG_NET_SCH_NETEM)	+= sch_netem.o
 obj-$(CONFIG_NET_SCH_DRR)	+= sch_drr.o
 obj-$(CONFIG_NET_SCH_PLUG)	+= sch_plug.o
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
deleted file mode 100644
index ff825f40ea04..000000000000
--- a/net/sched/sch_atm.c
+++ /dev/null
@@ -1,708 +0,0 @@
-/* net/sched/sch_atm.c - ATM VC selection "queueing discipline" */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/atmdev.h>
-#include <linux/atmclip.h>
-#include <linux/rtnetlink.h>
-#include <linux/file.h>		/* for fput */
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-/*
- * The ATM queuing discipline provides a framework for invoking classifiers
- * (aka "filters"), which in turn select classes of this queuing discipline.
- * Each class maps the flow(s) it is handling to a given VC. Multiple classes
- * may share the same VC.
- *
- * When creating a class, VCs are specified by passing the number of the open
- * socket descriptor by which the calling process references the VC. The kernel
- * keeps the VC open at least until all classes using it are removed.
- *
- * In this file, most functions are named atm_tc_* to avoid confusion with all
- * the atm_* in net/atm. This naming convention differs from what's used in the
- * rest of net/sched.
- *
- * Known bugs:
- *  - sometimes messes up the IP stack
- *  - any manipulations besides the few operations described in the README, are
- *    untested and likely to crash the system
- *  - should lock the flow while there is data in the queue (?)
- */
-
-#define VCC2FLOW(vcc) ((struct atm_flow_data *) ((vcc)->user_back))
-
-struct atm_flow_data {
-	struct Qdisc_class_common common;
-	struct Qdisc		*q;	/* FIFO, TBF, etc. */
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct atm_vcc		*vcc;	/* VCC; NULL if VCC is closed */
-	void			(*old_pop)(struct atm_vcc *vcc,
-					   struct sk_buff *skb); /* chaining */
-	struct atm_qdisc_data	*parent;	/* parent qdisc */
-	struct socket		*sock;		/* for closing */
-	int			ref;		/* reference count */
-	struct gnet_stats_basic_packed	bstats;
-	struct gnet_stats_queue	qstats;
-	struct list_head	list;
-	struct atm_flow_data	*excess;	/* flow for excess traffic;
-						   NULL to set CLP instead */
-	int			hdr_len;
-	unsigned char		hdr[0];		/* header data; MUST BE LAST */
-};
-
-struct atm_qdisc_data {
-	struct atm_flow_data	link;		/* unclassified skbs go here */
-	struct list_head	flows;		/* NB: "link" is also on this
-						   list */
-	struct tasklet_struct	task;		/* dequeue tasklet */
-};
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static inline struct atm_flow_data *lookup_flow(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow->common.classid == classid)
-			return flow;
-	}
-	return NULL;
-}
-
-static int atm_tc_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_graft(sch %p,[qdisc %p],flow %p,new %p,old %p)\n",
-		sch, p, flow, new, old);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (!new)
-		new = &noop_qdisc;
-	*old = flow->q;
-	flow->q = new;
-	if (*old)
-		qdisc_reset(*old);
-	return 0;
-}
-
-static struct Qdisc *atm_tc_leaf(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_leaf(sch %p,flow %p)\n", sch, flow);
-	return flow ? flow->q : NULL;
-}
-
-static unsigned long atm_tc_find(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-static unsigned long atm_tc_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	if (flow)
-		flow->ref++;
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-/*
- * atm_tc_put handles all destructions, including the ones that are explicitly
- * requested (atm_tc_destroy, etc.). The assumption here is that we never drop
- * anything that still seems to be in use.
- */
-static void atm_tc_put(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_put(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (--flow->ref)
-		return;
-	pr_debug("atm_tc_put: destroying\n");
-	list_del_init(&flow->list);
-	pr_debug("atm_tc_put: qdisc %p\n", flow->q);
-	qdisc_put(flow->q);
-	tcf_block_put(flow->block);
-	if (flow->sock) {
-		pr_debug("atm_tc_put: f_count %ld\n",
-			file_count(flow->sock->file));
-		flow->vcc->pop = flow->old_pop;
-		sockfd_put(flow->sock);
-	}
-	if (flow->excess)
-		atm_tc_put(sch, (unsigned long)flow->excess);
-	if (flow != &p->link)
-		kfree(flow);
-	/*
-	 * If flow == &p->link, the qdisc no longer works at this point and
-	 * needs to be removed. (By the caller of atm_tc_put.)
-	 */
-}
-
-static void sch_atm_pop(struct atm_vcc *vcc, struct sk_buff *skb)
-{
-	struct atm_qdisc_data *p = VCC2FLOW(vcc)->parent;
-
-	pr_debug("sch_atm_pop(vcc %p,skb %p,[qdisc %p])\n", vcc, skb, p);
-	VCC2FLOW(vcc)->old_pop(vcc, skb);
-	tasklet_schedule(&p->task);
-}
-
-static const u8 llc_oui_ip[] = {
-	0xaa,			/* DSAP: non-ISO */
-	0xaa,			/* SSAP: non-ISO */
-	0x03,			/* Ctrl: Unnumbered Information Command PDU */
-	0x00,			/* OUI: EtherType */
-	0x00, 0x00,
-	0x08, 0x00
-};				/* Ethertype IP (0800) */
-
-static const struct nla_policy atm_policy[TCA_ATM_MAX + 1] = {
-	[TCA_ATM_FD]		= { .type = NLA_U32 },
-	[TCA_ATM_EXCESS]	= { .type = NLA_U32 },
-};
-
-static int atm_tc_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)*arg;
-	struct atm_flow_data *excess = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_ATM_MAX + 1];
-	struct socket *sock;
-	int fd, error, hdr_len;
-	void *hdr;
-
-	pr_debug("atm_tc_change(sch %p,[qdisc %p],classid %x,parent %x,"
-		"flow %p,opt %p)\n", sch, p, classid, parent, flow, opt);
-	/*
-	 * The concept of parents doesn't apply for this qdisc.
-	 */
-	if (parent && parent != TC_H_ROOT && parent != sch->handle)
-		return -EINVAL;
-	/*
-	 * ATM classes cannot be changed. In order to change properties of the
-	 * ATM connection, that socket needs to be modified directly (via the
-	 * native ATM API. In order to send a flow to a different VC, the old
-	 * class needs to be removed and a new one added. (This may be changed
-	 * later.)
-	 */
-	if (flow)
-		return -EBUSY;
-	if (opt == NULL)
-		return -EINVAL;
-
-	error = nla_parse_nested(tb, TCA_ATM_MAX, opt, atm_policy, NULL);
-	if (error < 0)
-		return error;
-
-	if (!tb[TCA_ATM_FD])
-		return -EINVAL;
-	fd = nla_get_u32(tb[TCA_ATM_FD]);
-	pr_debug("atm_tc_change: fd %d\n", fd);
-	if (tb[TCA_ATM_HDR]) {
-		hdr_len = nla_len(tb[TCA_ATM_HDR]);
-		hdr = nla_data(tb[TCA_ATM_HDR]);
-	} else {
-		hdr_len = RFC1483LLC_LEN;
-		hdr = NULL;	/* default LLC/SNAP for IP */
-	}
-	if (!tb[TCA_ATM_EXCESS])
-		excess = NULL;
-	else {
-		excess = (struct atm_flow_data *)
-			atm_tc_find(sch, nla_get_u32(tb[TCA_ATM_EXCESS]));
-		if (!excess)
-			return -ENOENT;
-	}
-	pr_debug("atm_tc_change: type %d, payload %d, hdr_len %d\n",
-		 opt->nla_type, nla_len(opt), hdr_len);
-	sock = sockfd_lookup(fd, &error);
-	if (!sock)
-		return error;	/* f_count++ */
-	pr_debug("atm_tc_change: f_count %ld\n", file_count(sock->file));
-	if (sock->ops->family != PF_ATMSVC && sock->ops->family != PF_ATMPVC) {
-		error = -EPROTOTYPE;
-		goto err_out;
-	}
-	/* @@@ should check if the socket is really operational or we'll crash
-	   on vcc->send */
-	if (classid) {
-		if (TC_H_MAJ(classid ^ sch->handle)) {
-			pr_debug("atm_tc_change: classid mismatch\n");
-			error = -EINVAL;
-			goto err_out;
-		}
-	} else {
-		int i;
-		unsigned long cl;
-
-		for (i = 1; i < 0x8000; i++) {
-			classid = TC_H_MAKE(sch->handle, 0x8000 | i);
-			cl = atm_tc_find(sch, classid);
-			if (!cl)
-				break;
-		}
-	}
-	pr_debug("atm_tc_change: new id %x\n", classid);
-	flow = kzalloc(sizeof(struct atm_flow_data) + hdr_len, GFP_KERNEL);
-	pr_debug("atm_tc_change: flow %p\n", flow);
-	if (!flow) {
-		error = -ENOBUFS;
-		goto err_out;
-	}
-
-	error = tcf_block_get(&flow->block, &flow->filter_list, sch,
-			      extack);
-	if (error) {
-		kfree(flow);
-		goto err_out;
-	}
-
-	flow->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				    extack);
-	if (!flow->q)
-		flow->q = &noop_qdisc;
-	pr_debug("atm_tc_change: qdisc %p\n", flow->q);
-	flow->sock = sock;
-	flow->vcc = ATM_SD(sock);	/* speedup */
-	flow->vcc->user_back = flow;
-	pr_debug("atm_tc_change: vcc %p\n", flow->vcc);
-	flow->old_pop = flow->vcc->pop;
-	flow->parent = p;
-	flow->vcc->pop = sch_atm_pop;
-	flow->common.classid = classid;
-	flow->ref = 1;
-	flow->excess = excess;
-	list_add(&flow->list, &p->link.list);
-	flow->hdr_len = hdr_len;
-	if (hdr)
-		memcpy(flow->hdr, hdr, hdr_len);
-	else
-		memcpy(flow->hdr, llc_oui_ip, sizeof(llc_oui_ip));
-	*arg = (unsigned long)flow;
-	return 0;
-err_out:
-	sockfd_put(sock);
-	return error;
-}
-
-static int atm_tc_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_delete(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (rcu_access_pointer(flow->filter_list) || flow == &p->link)
-		return -EBUSY;
-	/*
-	 * Reference count must be 2: one for "keepalive" (set at class
-	 * creation), and one for the reference held when calling delete.
-	 */
-	if (flow->ref < 2) {
-		pr_err("atm_tc_delete: flow->ref == %d\n", flow->ref);
-		return -EINVAL;
-	}
-	if (flow->ref > 2)
-		return -EBUSY;	/* catch references via excess, etc. */
-	atm_tc_put(sch, arg);
-	return 0;
-}
-
-static void atm_tc_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_walk(sch %p,[qdisc %p],walker %p)\n", sch, p, walker);
-	if (walker->stop)
-		return;
-	list_for_each_entry(flow, &p->flows, list) {
-		if (walker->count >= walker->skip &&
-		    walker->fn(sch, (unsigned long)flow, walker) < 0) {
-			walker->stop = 1;
-			break;
-		}
-		walker->count++;
-	}
-}
-
-static struct tcf_block *atm_tc_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_find_tcf(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	return flow ? flow->block : p->link.block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int atm_tc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct tcf_result res;
-	int result;
-	int ret = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-
-	pr_debug("atm_tc_enqueue(skb %p,sch %p,[qdisc %p])\n", skb, sch, p);
-	result = TC_ACT_OK;	/* be nice to gcc */
-	flow = NULL;
-	if (TC_H_MAJ(skb->priority) != sch->handle ||
-	    !(flow = (struct atm_flow_data *)atm_tc_find(sch, skb->priority))) {
-		struct tcf_proto *fl;
-
-		list_for_each_entry(flow, &p->flows, list) {
-			fl = rcu_dereference_bh(flow->filter_list);
-			if (fl) {
-				result = tcf_classify(skb, fl, &res, true);
-				if (result < 0)
-					continue;
-				if (result == TC_ACT_SHOT)
-					goto done;
-
-				flow = (struct atm_flow_data *)res.class;
-				if (!flow)
-					flow = lookup_flow(sch, res.classid);
-				goto drop;
-			}
-		}
-		flow = NULL;
-done:
-		;
-	}
-	if (!flow) {
-		flow = &p->link;
-	} else {
-		if (flow->vcc)
-			ATM_SKB(skb)->atm_options = flow->vcc->atm_options;
-		/*@@@ looks good ... but it's not supposed to work :-) */
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-		case TC_ACT_SHOT:
-			__qdisc_drop(skb, to_free);
-			goto drop;
-		case TC_ACT_RECLASSIFY:
-			if (flow->excess)
-				flow = flow->excess;
-			else
-				ATM_SKB(skb)->atm_options |= ATM_ATMOPT_CLP;
-			break;
-		}
-#endif
-	}
-
-	ret = qdisc_enqueue(skb, flow->q, to_free);
-	if (ret != NET_XMIT_SUCCESS) {
-drop: __maybe_unused
-		if (net_xmit_drop_count(ret)) {
-			qdisc_qstats_drop(sch);
-			if (flow)
-				flow->qstats.drops++;
-		}
-		return ret;
-	}
-	/*
-	 * Okay, this may seem weird. We pretend we've dropped the packet if
-	 * it goes via ATM. The reason for this is that the outer qdisc
-	 * expects to be able to q->dequeue the packet later on if we return
-	 * success at this place. Also, sch->q.qdisc needs to reflect whether
-	 * there is a packet egligible for dequeuing or not. Note that the
-	 * statistics of the outer qdisc are necessarily wrong because of all
-	 * this. There's currently no correct solution for this.
-	 */
-	if (flow == &p->link) {
-		sch->q.qlen++;
-		return NET_XMIT_SUCCESS;
-	}
-	tasklet_schedule(&p->task);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-/*
- * Dequeue packets and send them over ATM. Note that we quite deliberately
- * avoid checking net_device's flow control here, simply because sch_atm
- * uses its own channels, which have nothing to do with any CLIP/LANE/or
- * non-ATM interfaces.
- */
-
-static void sch_atm_dequeue(unsigned long data)
-{
-	struct Qdisc *sch = (struct Qdisc *)data;
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct sk_buff *skb;
-
-	pr_debug("sch_atm_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow == &p->link)
-			continue;
-		/*
-		 * If traffic is properly shaped, this won't generate nasty
-		 * little bursts. Otherwise, it may ... (but that's okay)
-		 */
-		while ((skb = flow->q->ops->peek(flow->q))) {
-			if (!atm_may_send(flow->vcc, skb->truesize))
-				break;
-
-			skb = qdisc_dequeue_peeked(flow->q);
-			if (unlikely(!skb))
-				break;
-
-			qdisc_bstats_update(sch, skb);
-			bstats_update(&flow->bstats, skb);
-			pr_debug("atm_tc_dequeue: sending on class %p\n", flow);
-			/* remove any LL header somebody else has attached */
-			skb_pull(skb, skb_network_offset(skb));
-			if (skb_headroom(skb) < flow->hdr_len) {
-				struct sk_buff *new;
-
-				new = skb_realloc_headroom(skb, flow->hdr_len);
-				dev_kfree_skb(skb);
-				if (!new)
-					continue;
-				skb = new;
-			}
-			pr_debug("sch_atm_dequeue: ip %p, data %p\n",
-				 skb_network_header(skb), skb->data);
-			ATM_SKB(skb)->vcc = flow->vcc;
-			memcpy(skb_push(skb, flow->hdr_len), flow->hdr,
-			       flow->hdr_len);
-			refcount_add(skb->truesize,
-				   &sk_atm(flow->vcc)->sk_wmem_alloc);
-			/* atm.atm_options are already set by atm_tc_enqueue */
-			flow->vcc->send(flow->vcc, skb);
-		}
-	}
-}
-
-static struct sk_buff *atm_tc_dequeue(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-
-	pr_debug("atm_tc_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	tasklet_schedule(&p->task);
-	skb = qdisc_dequeue_peeked(p->link.q);
-	if (skb)
-		sch->q.qlen--;
-	return skb;
-}
-
-static struct sk_buff *atm_tc_peek(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("atm_tc_peek(sch %p,[qdisc %p])\n", sch, p);
-
-	return p->link.q->ops->peek(p->link.q);
-}
-
-static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("atm_tc_init(sch %p,[qdisc %p],opt %p)\n", sch, p, opt);
-	INIT_LIST_HEAD(&p->flows);
-	INIT_LIST_HEAD(&p->link.list);
-	list_add(&p->link.list, &p->flows);
-	p->link.q = qdisc_create_dflt(sch->dev_queue,
-				      &pfifo_qdisc_ops, sch->handle, extack);
-	if (!p->link.q)
-		p->link.q = &noop_qdisc;
-	pr_debug("atm_tc_init: link (%p) qdisc %p\n", &p->link, p->link.q);
-	p->link.vcc = NULL;
-	p->link.sock = NULL;
-	p->link.common.classid = sch->handle;
-	p->link.ref = 1;
-
-	err = tcf_block_get(&p->link.block, &p->link.filter_list, sch,
-			    extack);
-	if (err)
-		return err;
-
-	tasklet_init(&p->task, sch_atm_dequeue, (unsigned long)sch);
-	return 0;
-}
-
-static void atm_tc_reset(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_reset(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list)
-		qdisc_reset(flow->q);
-	sch->q.qlen = 0;
-}
-
-static void atm_tc_destroy(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow, *tmp;
-
-	pr_debug("atm_tc_destroy(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		tcf_block_put(flow->block);
-		flow->block = NULL;
-	}
-
-	list_for_each_entry_safe(flow, tmp, &p->flows, list) {
-		if (flow->ref > 1)
-			pr_err("atm_destroy: %p->ref = %d\n", flow, flow->ref);
-		atm_tc_put(sch, (unsigned long)flow);
-	}
-	tasklet_kill(&p->task);
-}
-
-static int atm_tc_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-	struct nlattr *nest;
-
-	pr_debug("atm_tc_dump_class(sch %p,[qdisc %p],flow %p,skb %p,tcm %p)\n",
-		sch, p, flow, skb, tcm);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	tcm->tcm_handle = flow->common.classid;
-	tcm->tcm_info = flow->q->handle;
-
-	nest = nla_nest_start(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_ATM_HDR, flow->hdr_len, flow->hdr))
-		goto nla_put_failure;
-	if (flow->vcc) {
-		struct sockaddr_atmpvc pvc;
-		int state;
-
-		memset(&pvc, 0, sizeof(pvc));
-		pvc.sap_family = AF_ATMPVC;
-		pvc.sap_addr.itf = flow->vcc->dev ? flow->vcc->dev->number : -1;
-		pvc.sap_addr.vpi = flow->vcc->vpi;
-		pvc.sap_addr.vci = flow->vcc->vci;
-		if (nla_put(skb, TCA_ATM_ADDR, sizeof(pvc), &pvc))
-			goto nla_put_failure;
-		state = ATM_VF2VS(flow->vcc->flags);
-		if (nla_put_u32(skb, TCA_ATM_STATE, state))
-			goto nla_put_failure;
-	}
-	if (flow->excess) {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, flow->common.classid))
-			goto nla_put_failure;
-	} else {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, 0))
-			goto nla_put_failure;
-	}
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-static int
-atm_tc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-			struct gnet_dump *d)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &flow->bstats) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int atm_tc_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static const struct Qdisc_class_ops atm_class_ops = {
-	.graft		= atm_tc_graft,
-	.leaf		= atm_tc_leaf,
-	.find		= atm_tc_find,
-	.change		= atm_tc_change,
-	.delete		= atm_tc_delete,
-	.walk		= atm_tc_walk,
-	.tcf_block	= atm_tc_tcf_block,
-	.bind_tcf	= atm_tc_bind_filter,
-	.unbind_tcf	= atm_tc_put,
-	.dump		= atm_tc_dump_class,
-	.dump_stats	= atm_tc_dump_class_stats,
-};
-
-static struct Qdisc_ops atm_qdisc_ops __read_mostly = {
-	.cl_ops		= &atm_class_ops,
-	.id		= "atm",
-	.priv_size	= sizeof(struct atm_qdisc_data),
-	.enqueue	= atm_tc_enqueue,
-	.dequeue	= atm_tc_dequeue,
-	.peek		= atm_tc_peek,
-	.init		= atm_tc_init,
-	.reset		= atm_tc_reset,
-	.destroy	= atm_tc_destroy,
-	.dump		= atm_tc_dump,
-	.owner		= THIS_MODULE,
-};
-
-static int __init atm_init(void)
-{
-	return register_qdisc(&atm_qdisc_ops);
-}
-
-static void __exit atm_exit(void)
-{
-	unregister_qdisc(&atm_qdisc_ops);
-}
-
-module_init(atm_init)
-module_exit(atm_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
deleted file mode 100644
index 7f0a5d22deaf..000000000000
--- a/net/sched/sch_cbq.c
+++ /dev/null
@@ -1,1823 +0,0 @@
-/*
- * net/sched/sch_cbq.c	Class-Based Queueing discipline.
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- *
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-
-/*	Class-Based Queueing (CBQ) algorithm.
-	=======================================
-
-	Sources: [1] Sally Floyd and Van Jacobson, "Link-sharing and Resource
-		 Management Models for Packet Networks",
-		 IEEE/ACM Transactions on Networking, Vol.3, No.4, 1995
-
-		 [2] Sally Floyd, "Notes on CBQ and Guaranteed Service", 1995
-
-		 [3] Sally Floyd, "Notes on Class-Based Queueing: Setting
-		 Parameters", 1996
-
-		 [4] Sally Floyd and Michael Speer, "Experimental Results
-		 for Class-Based Queueing", 1998, not published.
-
-	-----------------------------------------------------------------------
-
-	Algorithm skeleton was taken from NS simulator cbq.cc.
-	If someone wants to check this code against the LBL version,
-	he should take into account that ONLY the skeleton was borrowed,
-	the implementation is different. Particularly:
-
-	--- The WRR algorithm is different. Our version looks more
-	reasonable (I hope) and works when quanta are allowed to be
-	less than MTU, which is always the case when real time classes
-	have small rates. Note, that the statement of [3] is
-	incomplete, delay may actually be estimated even if class
-	per-round allotment is less than MTU. Namely, if per-round
-	allotment is W*r_i, and r_1+...+r_k = r < 1
-
-	delay_i <= ([MTU/(W*r_i)]*W*r + W*r + k*MTU)/B
-
-	In the worst case we have IntServ estimate with D = W*r+k*MTU
-	and C = MTU*r. The proof (if correct at all) is trivial.
-
-
-	--- It seems that cbq-2.0 is not very accurate. At least, I cannot
-	interpret some places, which look like wrong translations
-	from NS. Anyone is advised to find these differences
-	and explain to me, why I am wrong 8).
-
-	--- Linux has no EOI event, so that we cannot estimate true class
-	idle time. Workaround is to consider the next dequeue event
-	as sign that previous packet is finished. This is wrong because of
-	internal device queueing, but on a permanently loaded link it is true.
-	Moreover, combined with clock integrator, this scheme looks
-	very close to an ideal solution.  */
-
-struct cbq_sched_data;
-
-
-struct cbq_class {
-	struct Qdisc_class_common common;
-	struct cbq_class	*next_alive;	/* next class with backlog in this priority band */
-
-/* Parameters */
-	unsigned char		priority;	/* class priority */
-	unsigned char		priority2;	/* priority to be used after overlimit */
-	unsigned char		ewma_log;	/* time constant for idle time calculation */
-
-	u32			defmap;
-
-	/* Link-sharing scheduler parameters */
-	long			maxidle;	/* Class parameters: see below. */
-	long			offtime;
-	long			minidle;
-	u32			avpkt;
-	struct qdisc_rate_table	*R_tab;
-
-	/* General scheduler (WRR) parameters */
-	long			allot;
-	long			quantum;	/* Allotment per WRR round */
-	long			weight;		/* Relative allotment: see below */
-
-	struct Qdisc		*qdisc;		/* Ptr to CBQ discipline */
-	struct cbq_class	*split;		/* Ptr to split node */
-	struct cbq_class	*share;		/* Ptr to LS parent in the class tree */
-	struct cbq_class	*tparent;	/* Ptr to tree parent in the class tree */
-	struct cbq_class	*borrow;	/* NULL if class is bandwidth limited;
-						   parent otherwise */
-	struct cbq_class	*sibling;	/* Sibling chain */
-	struct cbq_class	*children;	/* Pointer to children chain */
-
-	struct Qdisc		*q;		/* Elementary queueing discipline */
-
-
-/* Variables */
-	unsigned char		cpriority;	/* Effective priority */
-	unsigned char		delayed;
-	unsigned char		level;		/* level of the class in hierarchy:
-						   0 for leaf classes, and maximal
-						   level of children + 1 for nodes.
-						 */
-
-	psched_time_t		last;		/* Last end of service */
-	psched_time_t		undertime;
-	long			avgidle;
-	long			deficit;	/* Saved deficit for WRR */
-	psched_time_t		penalized;
-	struct gnet_stats_basic_packed bstats;
-	struct gnet_stats_queue qstats;
-	struct net_rate_estimator __rcu *rate_est;
-	struct tc_cbq_xstats	xstats;
-
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-
-	int			filters;
-
-	struct cbq_class	*defaults[TC_PRIO_MAX + 1];
-};
-
-struct cbq_sched_data {
-	struct Qdisc_class_hash	clhash;			/* Hash table of all classes */
-	int			nclasses[TC_CBQ_MAXPRIO + 1];
-	unsigned int		quanta[TC_CBQ_MAXPRIO + 1];
-
-	struct cbq_class	link;
-
-	unsigned int		activemask;
-	struct cbq_class	*active[TC_CBQ_MAXPRIO + 1];	/* List of all classes
-								   with backlog */
-
-#ifdef CONFIG_NET_CLS_ACT
-	struct cbq_class	*rx_class;
-#endif
-	struct cbq_class	*tx_class;
-	struct cbq_class	*tx_borrowed;
-	int			tx_len;
-	psched_time_t		now;		/* Cached timestamp */
-	unsigned int		pmask;
-
-	struct hrtimer		delay_timer;
-	struct qdisc_watchdog	watchdog;	/* Watchdog timer,
-						   started when CBQ has
-						   backlog, but cannot
-						   transmit just now */
-	psched_tdiff_t		wd_expires;
-	int			toplevel;
-	u32			hgenerator;
-};
-
-
-#define L2T(cl, len)	qdisc_l2t((cl)->R_tab, len)
-
-static inline struct cbq_class *
-cbq_class_lookup(struct cbq_sched_data *q, u32 classid)
-{
-	struct Qdisc_class_common *clc;
-
-	clc = qdisc_class_find(&q->clhash, classid);
-	if (clc == NULL)
-		return NULL;
-	return container_of(clc, struct cbq_class, common);
-}
-
-#ifdef CONFIG_NET_CLS_ACT
-
-static struct cbq_class *
-cbq_reclassify(struct sk_buff *skb, struct cbq_class *this)
-{
-	struct cbq_class *cl;
-
-	for (cl = this->tparent; cl; cl = cl->tparent) {
-		struct cbq_class *new = cl->defaults[TC_PRIO_BESTEFFORT];
-
-		if (new != NULL && new != this)
-			return new;
-	}
-	return NULL;
-}
-
-#endif
-
-/* Classify packet. The procedure is pretty complicated, but
- * it allows us to combine link sharing and priority scheduling
- * transparently.
- *
- * Namely, you can put link sharing rules (f.e. route based) at root of CBQ,
- * so that it resolves to split nodes. Then packets are classified
- * by logical priority, or a more specific classifier may be attached
- * to the split node.
- */
-
-static struct cbq_class *
-cbq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *head = &q->link;
-	struct cbq_class **defmap;
-	struct cbq_class *cl = NULL;
-	u32 prio = skb->priority;
-	struct tcf_proto *fl;
-	struct tcf_result res;
-
-	/*
-	 *  Step 1. If skb->priority points to one of our classes, use it.
-	 */
-	if (TC_H_MAJ(prio ^ sch->handle) == 0 &&
-	    (cl = cbq_class_lookup(q, prio)) != NULL)
-		return cl;
-
-	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	for (;;) {
-		int result = 0;
-		defmap = head->defaults;
-
-		fl = rcu_dereference_bh(head->filter_list);
-		/*
-		 * Step 2+n. Apply classifier.
-		 */
-		result = tcf_classify(skb, fl, &res, true);
-		if (!fl || result < 0)
-			goto fallback;
-		if (result == TC_ACT_SHOT)
-			return NULL;
-
-		cl = (void *)res.class;
-		if (!cl) {
-			if (TC_H_MAJ(res.classid))
-				cl = cbq_class_lookup(q, res.classid);
-			else if ((cl = defmap[res.classid & TC_PRIO_MAX]) == NULL)
-				cl = defmap[TC_PRIO_BESTEFFORT];
-
-			if (cl == NULL)
-				goto fallback;
-		}
-		if (cl->level >= head->level)
-			goto fallback;
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-			/* fall through */
-		case TC_ACT_RECLASSIFY:
-			return cbq_reclassify(skb, cl);
-		}
-#endif
-		if (cl->level == 0)
-			return cl;
-
-		/*
-		 * Step 3+n. If classifier selected a link sharing class,
-		 *	   apply agency specific classifier.
-		 *	   Repeat this procdure until we hit a leaf node.
-		 */
-		head = cl;
-	}
-
-fallback:
-	cl = head;
-
-	/*
-	 * Step 4. No success...
-	 */
-	if (TC_H_MAJ(prio) == 0 &&
-	    !(cl = head->defaults[prio & TC_PRIO_MAX]) &&
-	    !(cl = head->defaults[TC_PRIO_BESTEFFORT]))
-		return head;
-
-	return cl;
-}
-
-/*
- * A packet has just been enqueued on the empty class.
- * cbq_activate_class adds it to the tail of active class list
- * of its priority band.
- */
-
-static inline void cbq_activate_class(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	int prio = cl->cpriority;
-	struct cbq_class *cl_tail;
-
-	cl_tail = q->active[prio];
-	q->active[prio] = cl;
-
-	if (cl_tail != NULL) {
-		cl->next_alive = cl_tail->next_alive;
-		cl_tail->next_alive = cl;
-	} else {
-		cl->next_alive = cl;
-		q->activemask |= (1<<prio);
-	}
-}
-
-/*
- * Unlink class from active chain.
- * Note that this same procedure is done directly in cbq_dequeue*
- * during round-robin procedure.
- */
-
-static void cbq_deactivate_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	int prio = this->cpriority;
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-
-	do {
-		cl = cl_prev->next_alive;
-		if (cl == this) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					q->activemask &= ~(1<<prio);
-					return;
-				}
-			}
-			return;
-		}
-	} while ((cl_prev = cl) != q->active[prio]);
-}
-
-static void
-cbq_mark_toplevel(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	int toplevel = q->toplevel;
-
-	if (toplevel > cl->level) {
-		psched_time_t now = psched_get_time();
-
-		do {
-			if (cl->undertime < now) {
-				q->toplevel = cl->level;
-				return;
-			}
-		} while ((cl = cl->borrow) != NULL && toplevel > cl->level);
-	}
-}
-
-static int
-cbq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-	    struct sk_buff **to_free)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	int ret;
-	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = cl;
-#endif
-	if (cl == NULL) {
-		if (ret & __NET_XMIT_BYPASS)
-			qdisc_qstats_drop(sch);
-		__qdisc_drop(skb, to_free);
-		return ret;
-	}
-
-	ret = qdisc_enqueue(skb, cl->q, to_free);
-	if (ret == NET_XMIT_SUCCESS) {
-		sch->q.qlen++;
-		cbq_mark_toplevel(q, cl);
-		if (!cl->next_alive)
-			cbq_activate_class(cl);
-		return ret;
-	}
-
-	if (net_xmit_drop_count(ret)) {
-		qdisc_qstats_drop(sch);
-		cbq_mark_toplevel(q, cl);
-		cl->qstats.drops++;
-	}
-	return ret;
-}
-
-/* Overlimit action: penalize leaf class by adding offtime */
-static void cbq_overlimit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	psched_tdiff_t delay = cl->undertime - q->now;
-
-	if (!cl->delayed) {
-		delay += cl->offtime;
-
-		/*
-		 * Class goes to sleep, so that it will have no
-		 * chance to work avgidle. Let's forgive it 8)
-		 *
-		 * BTW cbq-2.0 has a crap in this
-		 * place, apparently they forgot to shift it by cl->ewma_log.
-		 */
-		if (cl->avgidle < 0)
-			delay -= (-cl->avgidle) - ((-cl->avgidle) >> cl->ewma_log);
-		if (cl->avgidle < cl->minidle)
-			cl->avgidle = cl->minidle;
-		if (delay <= 0)
-			delay = 1;
-		cl->undertime = q->now + delay;
-
-		cl->xstats.overactions++;
-		cl->delayed = 1;
-	}
-	if (q->wd_expires == 0 || q->wd_expires > delay)
-		q->wd_expires = delay;
-
-	/* Dirty work! We must schedule wakeups based on
-	 * real available rate, rather than leaf rate,
-	 * which may be tiny (even zero).
-	 */
-	if (q->toplevel == TC_CBQ_MAXLEVEL) {
-		struct cbq_class *b;
-		psched_tdiff_t base_delay = q->wd_expires;
-
-		for (b = cl->borrow; b; b = b->borrow) {
-			delay = b->undertime - q->now;
-			if (delay < base_delay) {
-				if (delay <= 0)
-					delay = 1;
-				base_delay = delay;
-			}
-		}
-
-		q->wd_expires = base_delay;
-	}
-}
-
-static psched_tdiff_t cbq_undelay_prio(struct cbq_sched_data *q, int prio,
-				       psched_time_t now)
-{
-	struct cbq_class *cl;
-	struct cbq_class *cl_prev = q->active[prio];
-	psched_time_t sched = now;
-
-	if (cl_prev == NULL)
-		return 0;
-
-	do {
-		cl = cl_prev->next_alive;
-		if (now - cl->penalized > 0) {
-			cl_prev->next_alive = cl->next_alive;
-			cl->next_alive = NULL;
-			cl->cpriority = cl->priority;
-			cl->delayed = 0;
-			cbq_activate_class(cl);
-
-			if (cl == q->active[prio]) {
-				q->active[prio] = cl_prev;
-				if (cl == q->active[prio]) {
-					q->active[prio] = NULL;
-					return 0;
-				}
-			}
-
-			cl = cl_prev->next_alive;
-		} else if (sched - cl->penalized > 0)
-			sched = cl->penalized;
-	} while ((cl_prev = cl) != q->active[prio]);
-
-	return sched - now;
-}
-
-static enum hrtimer_restart cbq_undelay(struct hrtimer *timer)
-{
-	struct cbq_sched_data *q = container_of(timer, struct cbq_sched_data,
-						delay_timer);
-	struct Qdisc *sch = q->watchdog.qdisc;
-	psched_time_t now;
-	psched_tdiff_t delay = 0;
-	unsigned int pmask;
-
-	now = psched_get_time();
-
-	pmask = q->pmask;
-	q->pmask = 0;
-
-	while (pmask) {
-		int prio = ffz(~pmask);
-		psched_tdiff_t tmp;
-
-		pmask &= ~(1<<prio);
-
-		tmp = cbq_undelay_prio(q, prio, now);
-		if (tmp > 0) {
-			q->pmask |= 1<<prio;
-			if (tmp < delay || delay == 0)
-				delay = tmp;
-		}
-	}
-
-	if (delay) {
-		ktime_t time;
-
-		time = 0;
-		time = ktime_add_ns(time, PSCHED_TICKS2NS(now + delay));
-		hrtimer_start(&q->delay_timer, time, HRTIMER_MODE_ABS_PINNED);
-	}
-
-	__netif_schedule(qdisc_root(sch));
-	return HRTIMER_NORESTART;
-}
-
-/*
- * It is mission critical procedure.
- *
- * We "regenerate" toplevel cutoff, if transmitting class
- * has backlog and it is not regulated. It is not part of
- * original CBQ description, but looks more reasonable.
- * Probably, it is wrong. This question needs further investigation.
- */
-
-static inline void
-cbq_update_toplevel(struct cbq_sched_data *q, struct cbq_class *cl,
-		    struct cbq_class *borrowed)
-{
-	if (cl && q->toplevel >= borrowed->level) {
-		if (cl->q->q.qlen > 1) {
-			do {
-				if (borrowed->undertime == PSCHED_PASTPERFECT) {
-					q->toplevel = borrowed->level;
-					return;
-				}
-			} while ((borrowed = borrowed->borrow) != NULL);
-		}
-#if 0
-	/* It is not necessary now. Uncommenting it
-	   will save CPU cycles, but decrease fairness.
-	 */
-		q->toplevel = TC_CBQ_MAXLEVEL;
-#endif
-	}
-}
-
-static void
-cbq_update(struct cbq_sched_data *q)
-{
-	struct cbq_class *this = q->tx_class;
-	struct cbq_class *cl = this;
-	int len = q->tx_len;
-	psched_time_t now;
-
-	q->tx_class = NULL;
-	/* Time integrator. We calculate EOS time
-	 * by adding expected packet transmission time.
-	 */
-	now = q->now + L2T(&q->link, len);
-
-	for ( ; cl; cl = cl->share) {
-		long avgidle = cl->avgidle;
-		long idle;
-
-		cl->bstats.packets++;
-		cl->bstats.bytes += len;
-
-		/*
-		 * (now - last) is total time between packet right edges.
-		 * (last_pktlen/rate) is "virtual" busy time, so that
-		 *
-		 *	idle = (now - last) - last_pktlen/rate
-		 */
-
-		idle = now - cl->last;
-		if ((unsigned long)idle > 128*1024*1024) {
-			avgidle = cl->maxidle;
-		} else {
-			idle -= L2T(cl, len);
-
-		/* true_avgidle := (1-W)*true_avgidle + W*idle,
-		 * where W=2^{-ewma_log}. But cl->avgidle is scaled:
-		 * cl->avgidle == true_avgidle/W,
-		 * hence:
-		 */
-			avgidle += idle - (avgidle>>cl->ewma_log);
-		}
-
-		if (avgidle <= 0) {
-			/* Overlimit or at-limit */
-
-			if (avgidle < cl->minidle)
-				avgidle = cl->minidle;
-
-			cl->avgidle = avgidle;
-
-			/* Calculate expected time, when this class
-			 * will be allowed to send.
-			 * It will occur, when:
-			 * (1-W)*true_avgidle + W*delay = 0, i.e.
-			 * idle = (1/W - 1)*(-true_avgidle)
-			 * or
-			 * idle = (1 - W)*(-cl->avgidle);
-			 */
-			idle = (-avgidle) - ((-avgidle) >> cl->ewma_log);
-
-			/*
-			 * That is not all.
-			 * To maintain the rate allocated to the class,
-			 * we add to undertime virtual clock,
-			 * necessary to complete transmitted packet.
-			 * (len/phys_bandwidth has been already passed
-			 * to the moment of cbq_update)
-			 */
-
-			idle -= L2T(&q->link, len);
-			idle += L2T(cl, len);
-
-			cl->undertime = now + idle;
-		} else {
-			/* Underlimit */
-
-			cl->undertime = PSCHED_PASTPERFECT;
-			if (avgidle > cl->maxidle)
-				cl->avgidle = cl->maxidle;
-			else
-				cl->avgidle = avgidle;
-		}
-		if ((s64)(now - cl->last) > 0)
-			cl->last = now;
-	}
-
-	cbq_update_toplevel(q, this, q->tx_borrowed);
-}
-
-static inline struct cbq_class *
-cbq_under_limit(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *this_cl = cl;
-
-	if (cl->tparent == NULL)
-		return cl;
-
-	if (cl->undertime == PSCHED_PASTPERFECT || q->now >= cl->undertime) {
-		cl->delayed = 0;
-		return cl;
-	}
-
-	do {
-		/* It is very suspicious place. Now overlimit
-		 * action is generated for not bounded classes
-		 * only if link is completely congested.
-		 * Though it is in agree with ancestor-only paradigm,
-		 * it looks very stupid. Particularly,
-		 * it means that this chunk of code will either
-		 * never be called or result in strong amplification
-		 * of burstiness. Dangerous, silly, and, however,
-		 * no another solution exists.
-		 */
-		cl = cl->borrow;
-		if (!cl) {
-			this_cl->qstats.overlimits++;
-			cbq_overlimit(this_cl);
-			return NULL;
-		}
-		if (cl->level > q->toplevel)
-			return NULL;
-	} while (cl->undertime != PSCHED_PASTPERFECT && q->now < cl->undertime);
-
-	cl->delayed = 0;
-	return cl;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_prio(struct Qdisc *sch, int prio)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl_tail, *cl_prev, *cl;
-	struct sk_buff *skb;
-	int deficit;
-
-	cl_tail = cl_prev = q->active[prio];
-	cl = cl_prev->next_alive;
-
-	do {
-		deficit = 0;
-
-		/* Start round */
-		do {
-			struct cbq_class *borrow = cl;
-
-			if (cl->q->q.qlen &&
-			    (borrow = cbq_under_limit(cl)) == NULL)
-				goto skip_class;
-
-			if (cl->deficit <= 0) {
-				/* Class exhausted its allotment per
-				 * this round. Switch to the next one.
-				 */
-				deficit = 1;
-				cl->deficit += cl->quantum;
-				goto next_class;
-			}
-
-			skb = cl->q->dequeue(cl->q);
-
-			/* Class did not give us any skb :-(
-			 * It could occur even if cl->q->q.qlen != 0
-			 * f.e. if cl->q == "tbf"
-			 */
-			if (skb == NULL)
-				goto skip_class;
-
-			cl->deficit -= qdisc_pkt_len(skb);
-			q->tx_class = cl;
-			q->tx_borrowed = borrow;
-			if (borrow != cl) {
-#ifndef CBQ_XSTATS_BORROWS_BYTES
-				borrow->xstats.borrows++;
-				cl->xstats.borrows++;
-#else
-				borrow->xstats.borrows += qdisc_pkt_len(skb);
-				cl->xstats.borrows += qdisc_pkt_len(skb);
-#endif
-			}
-			q->tx_len = qdisc_pkt_len(skb);
-
-			if (cl->deficit <= 0) {
-				q->active[prio] = cl;
-				cl = cl->next_alive;
-				cl->deficit += cl->quantum;
-			}
-			return skb;
-
-skip_class:
-			if (cl->q->q.qlen == 0 || prio != cl->cpriority) {
-				/* Class is empty or penalized.
-				 * Unlink it from active chain.
-				 */
-				cl_prev->next_alive = cl->next_alive;
-				cl->next_alive = NULL;
-
-				/* Did cl_tail point to it? */
-				if (cl == cl_tail) {
-					/* Repair it! */
-					cl_tail = cl_prev;
-
-					/* Was it the last class in this band? */
-					if (cl == cl_tail) {
-						/* Kill the band! */
-						q->active[prio] = NULL;
-						q->activemask &= ~(1<<prio);
-						if (cl->q->q.qlen)
-							cbq_activate_class(cl);
-						return NULL;
-					}
-
-					q->active[prio] = cl_tail;
-				}
-				if (cl->q->q.qlen)
-					cbq_activate_class(cl);
-
-				cl = cl_prev;
-			}
-
-next_class:
-			cl_prev = cl;
-			cl = cl->next_alive;
-		} while (cl_prev != cl_tail);
-	} while (deficit);
-
-	q->active[prio] = cl_prev;
-
-	return NULL;
-}
-
-static inline struct sk_buff *
-cbq_dequeue_1(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *skb;
-	unsigned int activemask;
-
-	activemask = q->activemask & 0xFF;
-	while (activemask) {
-		int prio = ffz(~activemask);
-		activemask &= ~(1<<prio);
-		skb = cbq_dequeue_prio(sch, prio);
-		if (skb)
-			return skb;
-	}
-	return NULL;
-}
-
-static struct sk_buff *
-cbq_dequeue(struct Qdisc *sch)
-{
-	struct sk_buff *skb;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	psched_time_t now;
-
-	now = psched_get_time();
-
-	if (q->tx_class)
-		cbq_update(q);
-
-	q->now = now;
-
-	for (;;) {
-		q->wd_expires = 0;
-
-		skb = cbq_dequeue_1(sch);
-		if (skb) {
-			qdisc_bstats_update(sch, skb);
-			sch->q.qlen--;
-			return skb;
-		}
-
-		/* All the classes are overlimit.
-		 *
-		 * It is possible, if:
-		 *
-		 * 1. Scheduler is empty.
-		 * 2. Toplevel cutoff inhibited borrowing.
-		 * 3. Root class is overlimit.
-		 *
-		 * Reset 2d and 3d conditions and retry.
-		 *
-		 * Note, that NS and cbq-2.0 are buggy, peeking
-		 * an arbitrary class is appropriate for ancestor-only
-		 * sharing, but not for toplevel algorithm.
-		 *
-		 * Our version is better, but slower, because it requires
-		 * two passes, but it is unavoidable with top-level sharing.
-		 */
-
-		if (q->toplevel == TC_CBQ_MAXLEVEL &&
-		    q->link.undertime == PSCHED_PASTPERFECT)
-			break;
-
-		q->toplevel = TC_CBQ_MAXLEVEL;
-		q->link.undertime = PSCHED_PASTPERFECT;
-	}
-
-	/* No packets in scheduler or nobody wants to give them to us :-(
-	 * Sigh... start watchdog timer in the last case.
-	 */
-
-	if (sch->q.qlen) {
-		qdisc_qstats_overlimit(sch);
-		if (q->wd_expires)
-			qdisc_watchdog_schedule(&q->watchdog,
-						now + q->wd_expires);
-	}
-	return NULL;
-}
-
-/* CBQ class maintanance routines */
-
-static void cbq_adjust_levels(struct cbq_class *this)
-{
-	if (this == NULL)
-		return;
-
-	do {
-		int level = 0;
-		struct cbq_class *cl;
-
-		cl = this->children;
-		if (cl) {
-			do {
-				if (cl->level > level)
-					level = cl->level;
-			} while ((cl = cl->sibling) != this->children);
-		}
-		this->level = level + 1;
-	} while ((this = this->tparent) != NULL);
-}
-
-static void cbq_normalize_quanta(struct cbq_sched_data *q, int prio)
-{
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (q->quanta[prio] == 0)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			/* BUGGGG... Beware! This expression suffer of
-			 * arithmetic overflows!
-			 */
-			if (cl->priority == prio) {
-				cl->quantum = (cl->weight*cl->allot*q->nclasses[prio])/
-					q->quanta[prio];
-			}
-			if (cl->quantum <= 0 ||
-			    cl->quantum > 32*qdisc_dev(cl->qdisc)->mtu) {
-				pr_warn("CBQ: class %08x has bad quantum==%ld, repaired.\n",
-					cl->common.classid, cl->quantum);
-				cl->quantum = qdisc_dev(cl->qdisc)->mtu/2 + 1;
-			}
-		}
-	}
-}
-
-static void cbq_sync_defmap(struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-	struct cbq_class *split = cl->split;
-	unsigned int h;
-	int i;
-
-	if (split == NULL)
-		return;
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		if (split->defaults[i] == cl && !(cl->defmap & (1<<i)))
-			split->defaults[i] = NULL;
-	}
-
-	for (i = 0; i <= TC_PRIO_MAX; i++) {
-		int level = split->level;
-
-		if (split->defaults[i])
-			continue;
-
-		for (h = 0; h < q->clhash.hashsize; h++) {
-			struct cbq_class *c;
-
-			hlist_for_each_entry(c, &q->clhash.hash[h],
-					     common.hnode) {
-				if (c->split == split && c->level < level &&
-				    c->defmap & (1<<i)) {
-					split->defaults[i] = c;
-					level = c->level;
-				}
-			}
-		}
-	}
-}
-
-static void cbq_change_defmap(struct cbq_class *cl, u32 splitid, u32 def, u32 mask)
-{
-	struct cbq_class *split = NULL;
-
-	if (splitid == 0) {
-		split = cl->split;
-		if (!split)
-			return;
-		splitid = split->common.classid;
-	}
-
-	if (split == NULL || split->common.classid != splitid) {
-		for (split = cl->tparent; split; split = split->tparent)
-			if (split->common.classid == splitid)
-				break;
-	}
-
-	if (split == NULL)
-		return;
-
-	if (cl->split != split) {
-		cl->defmap = 0;
-		cbq_sync_defmap(cl);
-		cl->split = split;
-		cl->defmap = def & mask;
-	} else
-		cl->defmap = (cl->defmap & ~mask) | (def & mask);
-
-	cbq_sync_defmap(cl);
-}
-
-static void cbq_unlink_class(struct cbq_class *this)
-{
-	struct cbq_class *cl, **clp;
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-
-	qdisc_class_hash_remove(&q->clhash, &this->common);
-
-	if (this->tparent) {
-		clp = &this->sibling;
-		cl = *clp;
-		do {
-			if (cl == this) {
-				*clp = cl->sibling;
-				break;
-			}
-			clp = &cl->sibling;
-		} while ((cl = *clp) != this->sibling);
-
-		if (this->tparent->children == this) {
-			this->tparent->children = this->sibling;
-			if (this->sibling == this)
-				this->tparent->children = NULL;
-		}
-	} else {
-		WARN_ON(this->sibling != this);
-	}
-}
-
-static void cbq_link_class(struct cbq_class *this)
-{
-	struct cbq_sched_data *q = qdisc_priv(this->qdisc);
-	struct cbq_class *parent = this->tparent;
-
-	this->sibling = this;
-	qdisc_class_hash_insert(&q->clhash, &this->common);
-
-	if (parent == NULL)
-		return;
-
-	if (parent->children == NULL) {
-		parent->children = this;
-	} else {
-		this->sibling = parent->children->sibling;
-		parent->children->sibling = this;
-	}
-}
-
-static void
-cbq_reset(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	int prio;
-	unsigned int h;
-
-	q->activemask = 0;
-	q->pmask = 0;
-	q->tx_class = NULL;
-	q->tx_borrowed = NULL;
-	qdisc_watchdog_cancel(&q->watchdog);
-	hrtimer_cancel(&q->delay_timer);
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	for (prio = 0; prio <= TC_CBQ_MAXPRIO; prio++)
-		q->active[prio] = NULL;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			qdisc_reset(cl->q);
-
-			cl->next_alive = NULL;
-			cl->undertime = PSCHED_PASTPERFECT;
-			cl->avgidle = cl->maxidle;
-			cl->deficit = cl->quantum;
-			cl->cpriority = cl->priority;
-		}
-	}
-	sch->q.qlen = 0;
-}
-
-
-static int cbq_set_lss(struct cbq_class *cl, struct tc_cbq_lssopt *lss)
-{
-	if (lss->change & TCF_CBQ_LSS_FLAGS) {
-		cl->share = (lss->flags & TCF_CBQ_LSS_ISOLATED) ? NULL : cl->tparent;
-		cl->borrow = (lss->flags & TCF_CBQ_LSS_BOUNDED) ? NULL : cl->tparent;
-	}
-	if (lss->change & TCF_CBQ_LSS_EWMA)
-		cl->ewma_log = lss->ewma_log;
-	if (lss->change & TCF_CBQ_LSS_AVPKT)
-		cl->avpkt = lss->avpkt;
-	if (lss->change & TCF_CBQ_LSS_MINIDLE)
-		cl->minidle = -(long)lss->minidle;
-	if (lss->change & TCF_CBQ_LSS_MAXIDLE) {
-		cl->maxidle = lss->maxidle;
-		cl->avgidle = lss->maxidle;
-	}
-	if (lss->change & TCF_CBQ_LSS_OFFTIME)
-		cl->offtime = lss->offtime;
-	return 0;
-}
-
-static void cbq_rmprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]--;
-	q->quanta[cl->priority] -= cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static void cbq_addprio(struct cbq_sched_data *q, struct cbq_class *cl)
-{
-	q->nclasses[cl->priority]++;
-	q->quanta[cl->priority] += cl->weight;
-	cbq_normalize_quanta(q, cl->priority);
-}
-
-static int cbq_set_wrr(struct cbq_class *cl, struct tc_cbq_wrropt *wrr)
-{
-	struct cbq_sched_data *q = qdisc_priv(cl->qdisc);
-
-	if (wrr->allot)
-		cl->allot = wrr->allot;
-	if (wrr->weight)
-		cl->weight = wrr->weight;
-	if (wrr->priority) {
-		cl->priority = wrr->priority - 1;
-		cl->cpriority = cl->priority;
-		if (cl->priority >= cl->priority2)
-			cl->priority2 = TC_CBQ_MAXPRIO - 1;
-	}
-
-	cbq_addprio(q, cl);
-	return 0;
-}
-
-static int cbq_set_fopt(struct cbq_class *cl, struct tc_cbq_fopt *fopt)
-{
-	cbq_change_defmap(cl, fopt->split, fopt->defmap, fopt->defchange);
-	return 0;
-}
-
-static const struct nla_policy cbq_policy[TCA_CBQ_MAX + 1] = {
-	[TCA_CBQ_LSSOPT]	= { .len = sizeof(struct tc_cbq_lssopt) },
-	[TCA_CBQ_WRROPT]	= { .len = sizeof(struct tc_cbq_wrropt) },
-	[TCA_CBQ_FOPT]		= { .len = sizeof(struct tc_cbq_fopt) },
-	[TCA_CBQ_OVL_STRATEGY]	= { .len = sizeof(struct tc_cbq_ovl) },
-	[TCA_CBQ_RATE]		= { .len = sizeof(struct tc_ratespec) },
-	[TCA_CBQ_RTAB]		= { .type = NLA_BINARY, .len = TC_RTAB_SIZE },
-	[TCA_CBQ_POLICE]	= { .len = sizeof(struct tc_cbq_police) },
-};
-
-static int cbq_opt_parse(struct nlattr *tb[TCA_CBQ_MAX + 1],
-			 struct nlattr *opt,
-			 struct netlink_ext_ack *extack)
-{
-	int err;
-
-	if (!opt) {
-		NL_SET_ERR_MSG(extack, "CBQ options are required for this operation");
-		return -EINVAL;
-	}
-
-	err = nla_parse_nested(tb, TCA_CBQ_MAX, opt, cbq_policy, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_WRROPT]) {
-		const struct tc_cbq_wrropt *wrr = nla_data(tb[TCA_CBQ_WRROPT]);
-
-		if (wrr->priority > TC_CBQ_MAXPRIO) {
-			NL_SET_ERR_MSG(extack, "priority is bigger than TC_CBQ_MAXPRIO");
-			err = -EINVAL;
-		}
-	}
-	return err;
-}
-
-static int cbq_init(struct Qdisc *sch, struct nlattr *opt,
-		    struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct tc_ratespec *r;
-	int err;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-	hrtimer_init(&q->delay_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
-	q->delay_timer.function = cbq_undelay;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (!tb[TCA_CBQ_RTAB] || !tb[TCA_CBQ_RATE]) {
-		NL_SET_ERR_MSG(extack, "Rate specification missing or incomplete");
-		return -EINVAL;
-	}
-
-	r = nla_data(tb[TCA_CBQ_RATE]);
-
-	q->link.R_tab = qdisc_get_rtab(r, tb[TCA_CBQ_RTAB], extack);
-	if (!q->link.R_tab)
-		return -EINVAL;
-
-	err = tcf_block_get(&q->link.block, &q->link.filter_list, sch, extack);
-	if (err)
-		goto put_rtab;
-
-	err = qdisc_class_hash_init(&q->clhash);
-	if (err < 0)
-		goto put_block;
-
-	q->link.sibling = &q->link;
-	q->link.common.classid = sch->handle;
-	q->link.qdisc = sch;
-	q->link.q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-				      sch->handle, NULL);
-	if (!q->link.q)
-		q->link.q = &noop_qdisc;
-	else
-		qdisc_hash_add(q->link.q, true);
-
-	q->link.priority = TC_CBQ_MAXPRIO - 1;
-	q->link.priority2 = TC_CBQ_MAXPRIO - 1;
-	q->link.cpriority = TC_CBQ_MAXPRIO - 1;
-	q->link.allot = psched_mtu(qdisc_dev(sch));
-	q->link.quantum = q->link.allot;
-	q->link.weight = q->link.R_tab->rate.rate;
-
-	q->link.ewma_log = TC_CBQ_DEF_EWMA;
-	q->link.avpkt = q->link.allot/2;
-	q->link.minidle = -0x7FFFFFFF;
-
-	q->toplevel = TC_CBQ_MAXLEVEL;
-	q->now = psched_get_time();
-
-	cbq_link_class(&q->link);
-
-	if (tb[TCA_CBQ_LSSOPT])
-		cbq_set_lss(&q->link, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-	cbq_addprio(q, &q->link);
-	return 0;
-
-put_block:
-	tcf_block_put(q->link.block);
-
-put_rtab:
-	qdisc_put_rtab(q->link.R_tab);
-	return err;
-}
-
-static int cbq_dump_rate(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-
-	if (nla_put(skb, TCA_CBQ_RATE, sizeof(cl->R_tab->rate), &cl->R_tab->rate))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_lss(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_lssopt opt;
-
-	opt.flags = 0;
-	if (cl->borrow == NULL)
-		opt.flags |= TCF_CBQ_LSS_BOUNDED;
-	if (cl->share == NULL)
-		opt.flags |= TCF_CBQ_LSS_ISOLATED;
-	opt.ewma_log = cl->ewma_log;
-	opt.level = cl->level;
-	opt.avpkt = cl->avpkt;
-	opt.maxidle = cl->maxidle;
-	opt.minidle = (u32)(-cl->minidle);
-	opt.offtime = cl->offtime;
-	opt.change = ~0;
-	if (nla_put(skb, TCA_CBQ_LSSOPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_wrr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_wrropt opt;
-
-	memset(&opt, 0, sizeof(opt));
-	opt.flags = 0;
-	opt.allot = cl->allot;
-	opt.priority = cl->priority + 1;
-	opt.cpriority = cl->cpriority + 1;
-	opt.weight = cl->weight;
-	if (nla_put(skb, TCA_CBQ_WRROPT, sizeof(opt), &opt))
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_fopt(struct sk_buff *skb, struct cbq_class *cl)
-{
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tc_cbq_fopt opt;
-
-	if (cl->split || cl->defmap) {
-		opt.split = cl->split ? cl->split->common.classid : 0;
-		opt.defmap = cl->defmap;
-		opt.defchange = ~0;
-		if (nla_put(skb, TCA_CBQ_FOPT, sizeof(opt), &opt))
-			goto nla_put_failure;
-	}
-	return skb->len;
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-
-static int cbq_dump_attr(struct sk_buff *skb, struct cbq_class *cl)
-{
-	if (cbq_dump_lss(skb, cl) < 0 ||
-	    cbq_dump_rate(skb, cl) < 0 ||
-	    cbq_dump_wrr(skb, cl) < 0 ||
-	    cbq_dump_fopt(skb, cl) < 0)
-		return -1;
-	return 0;
-}
-
-static int cbq_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct nlattr *nest;
-
-	nest = nla_nest_start(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, &q->link) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	q->link.xstats.avgidle = q->link.avgidle;
-	return gnet_stats_copy_app(d, &q->link.xstats, sizeof(q->link.xstats));
-}
-
-static int
-cbq_dump_class(struct Qdisc *sch, unsigned long arg,
-	       struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	struct nlattr *nest;
-
-	if (cl->tparent)
-		tcm->tcm_parent = cl->tparent->common.classid;
-	else
-		tcm->tcm_parent = TC_H_ROOT;
-	tcm->tcm_handle = cl->common.classid;
-	tcm->tcm_info = cl->q->handle;
-
-	nest = nla_nest_start(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	if (cbq_dump_attr(skb, cl) < 0)
-		goto nla_put_failure;
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static int
-cbq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-	struct gnet_dump *d)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cl->xstats.avgidle = cl->avgidle;
-	cl->xstats.undertime = 0;
-
-	if (cl->undertime != PSCHED_PASTPERFECT)
-		cl->xstats.undertime = cl->undertime - q->now;
-
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
-	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &cl->qstats, cl->q->q.qlen) < 0)
-		return -1;
-
-	return gnet_stats_copy_app(d, &cl->xstats, sizeof(cl->xstats));
-}
-
-static int cbq_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
-		     struct Qdisc **old, struct netlink_ext_ack *extack)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					cl->common.classid, extack);
-		if (new == NULL)
-			return -ENOBUFS;
-	}
-
-	*old = qdisc_replace(sch, new, &cl->q);
-	return 0;
-}
-
-static struct Qdisc *cbq_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	return cl->q;
-}
-
-static void cbq_qlen_notify(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cbq_deactivate_class(cl);
-}
-
-static unsigned long cbq_find(struct Qdisc *sch, u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	return (unsigned long)cbq_class_lookup(q, classid);
-}
-
-static void cbq_destroy_class(struct Qdisc *sch, struct cbq_class *cl)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-
-	WARN_ON(cl->filters);
-
-	tcf_block_put(cl->block);
-	qdisc_put(cl->q);
-	qdisc_put_rtab(cl->R_tab);
-	gen_kill_estimator(&cl->rate_est);
-	if (cl != &q->link)
-		kfree(cl);
-}
-
-static void cbq_destroy(struct Qdisc *sch)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct hlist_node *next;
-	struct cbq_class *cl;
-	unsigned int h;
-
-#ifdef CONFIG_NET_CLS_ACT
-	q->rx_class = NULL;
-#endif
-	/*
-	 * Filters must be destroyed first because we don't destroy the
-	 * classes from root to leafs which means that filters can still
-	 * be bound to classes which have been destroyed already. --TGR '04
-	 */
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			tcf_block_put(cl->block);
-			cl->block = NULL;
-		}
-	}
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[h],
-					  common.hnode)
-			cbq_destroy_class(sch, cl);
-	}
-	qdisc_class_hash_destroy(&q->clhash);
-}
-
-static int
-cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **tca,
-		 unsigned long *arg, struct netlink_ext_ack *extack)
-{
-	int err;
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)*arg;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_CBQ_MAX + 1];
-	struct cbq_class *parent;
-	struct qdisc_rate_table *rtab = NULL;
-
-	err = cbq_opt_parse(tb, opt, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_CBQ_OVL_STRATEGY] || tb[TCA_CBQ_POLICE]) {
-		NL_SET_ERR_MSG(extack, "Neither overlimit strategy nor policing attributes can be used for changing class params");
-		return -EOPNOTSUPP;
-	}
-
-	if (cl) {
-		/* Check parent */
-		if (parentid) {
-			if (cl->tparent &&
-			    cl->tparent->common.classid != parentid) {
-				NL_SET_ERR_MSG(extack, "Invalid parent id");
-				return -EINVAL;
-			}
-			if (!cl->tparent && parentid != TC_H_ROOT) {
-				NL_SET_ERR_MSG(extack, "Parent must be root");
-				return -EINVAL;
-			}
-		}
-
-		if (tb[TCA_CBQ_RATE]) {
-			rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]),
-					      tb[TCA_CBQ_RTAB], extack);
-			if (rtab == NULL)
-				return -EINVAL;
-		}
-
-		if (tca[TCA_RATE]) {
-			err = gen_replace_estimator(&cl->bstats, NULL,
-						    &cl->rate_est,
-						    NULL,
-						    qdisc_root_sleeping_running(sch),
-						    tca[TCA_RATE]);
-			if (err) {
-				NL_SET_ERR_MSG(extack, "Failed to replace specified rate estimator");
-				qdisc_put_rtab(rtab);
-				return err;
-			}
-		}
-
-		/* Change class parameters */
-		sch_tree_lock(sch);
-
-		if (cl->next_alive != NULL)
-			cbq_deactivate_class(cl);
-
-		if (rtab) {
-			qdisc_put_rtab(cl->R_tab);
-			cl->R_tab = rtab;
-		}
-
-		if (tb[TCA_CBQ_LSSOPT])
-			cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-
-		if (tb[TCA_CBQ_WRROPT]) {
-			cbq_rmprio(q, cl);
-			cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-		}
-
-		if (tb[TCA_CBQ_FOPT])
-			cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-
-		if (cl->q->q.qlen)
-			cbq_activate_class(cl);
-
-		sch_tree_unlock(sch);
-
-		return 0;
-	}
-
-	if (parentid == TC_H_ROOT)
-		return -EINVAL;
-
-	if (!tb[TCA_CBQ_WRROPT] || !tb[TCA_CBQ_RATE] || !tb[TCA_CBQ_LSSOPT]) {
-		NL_SET_ERR_MSG(extack, "One of the following attributes MUST be specified: WRR, rate or link sharing");
-		return -EINVAL;
-	}
-
-	rtab = qdisc_get_rtab(nla_data(tb[TCA_CBQ_RATE]), tb[TCA_CBQ_RTAB],
-			      extack);
-	if (rtab == NULL)
-		return -EINVAL;
-
-	if (classid) {
-		err = -EINVAL;
-		if (TC_H_MAJ(classid ^ sch->handle) ||
-		    cbq_class_lookup(q, classid)) {
-			NL_SET_ERR_MSG(extack, "Specified class not found");
-			goto failure;
-		}
-	} else {
-		int i;
-		classid = TC_H_MAKE(sch->handle, 0x8000);
-
-		for (i = 0; i < 0x8000; i++) {
-			if (++q->hgenerator >= 0x8000)
-				q->hgenerator = 1;
-			if (cbq_class_lookup(q, classid|q->hgenerator) == NULL)
-				break;
-		}
-		err = -ENOSR;
-		if (i >= 0x8000) {
-			NL_SET_ERR_MSG(extack, "Unable to generate classid");
-			goto failure;
-		}
-		classid = classid|q->hgenerator;
-	}
-
-	parent = &q->link;
-	if (parentid) {
-		parent = cbq_class_lookup(q, parentid);
-		err = -EINVAL;
-		if (!parent) {
-			NL_SET_ERR_MSG(extack, "Failed to find parentid");
-			goto failure;
-		}
-	}
-
-	err = -ENOBUFS;
-	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
-	if (cl == NULL)
-		goto failure;
-
-	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
-	if (err) {
-		kfree(cl);
-		goto failure;
-	}
-
-	if (tca[TCA_RATE]) {
-		err = gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
-		if (err) {
-			NL_SET_ERR_MSG(extack, "Couldn't create new estimator");
-			tcf_block_put(cl->block);
-			kfree(cl);
-			goto failure;
-		}
-	}
-
-	cl->R_tab = rtab;
-	rtab = NULL;
-	cl->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				  NULL);
-	if (!cl->q)
-		cl->q = &noop_qdisc;
-	else
-		qdisc_hash_add(cl->q, true);
-
-	cl->common.classid = classid;
-	cl->tparent = parent;
-	cl->qdisc = sch;
-	cl->allot = parent->allot;
-	cl->quantum = cl->allot;
-	cl->weight = cl->R_tab->rate.rate;
-
-	sch_tree_lock(sch);
-	cbq_link_class(cl);
-	cl->borrow = cl->tparent;
-	if (cl->tparent != &q->link)
-		cl->share = cl->tparent;
-	cbq_adjust_levels(parent);
-	cl->minidle = -0x7FFFFFFF;
-	cbq_set_lss(cl, nla_data(tb[TCA_CBQ_LSSOPT]));
-	cbq_set_wrr(cl, nla_data(tb[TCA_CBQ_WRROPT]));
-	if (cl->ewma_log == 0)
-		cl->ewma_log = q->link.ewma_log;
-	if (cl->maxidle == 0)
-		cl->maxidle = q->link.maxidle;
-	if (cl->avpkt == 0)
-		cl->avpkt = q->link.avpkt;
-	if (tb[TCA_CBQ_FOPT])
-		cbq_set_fopt(cl, nla_data(tb[TCA_CBQ_FOPT]));
-	sch_tree_unlock(sch);
-
-	qdisc_class_hash_grow(sch, &q->clhash);
-
-	*arg = (unsigned long)cl;
-	return 0;
-
-failure:
-	qdisc_put_rtab(rtab);
-	return err;
-}
-
-static int cbq_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-	unsigned int qlen, backlog;
-
-	if (cl->filters || cl->children || cl == &q->link)
-		return -EBUSY;
-
-	sch_tree_lock(sch);
-
-	qlen = cl->q->q.qlen;
-	backlog = cl->q->qstats.backlog;
-	qdisc_reset(cl->q);
-	qdisc_tree_reduce_backlog(cl->q, qlen, backlog);
-
-	if (cl->next_alive)
-		cbq_deactivate_class(cl);
-
-	if (q->tx_borrowed == cl)
-		q->tx_borrowed = q->tx_class;
-	if (q->tx_class == cl) {
-		q->tx_class = NULL;
-		q->tx_borrowed = NULL;
-	}
-#ifdef CONFIG_NET_CLS_ACT
-	if (q->rx_class == cl)
-		q->rx_class = NULL;
-#endif
-
-	cbq_unlink_class(cl);
-	cbq_adjust_levels(cl->tparent);
-	cl->defmap = 0;
-	cbq_sync_defmap(cl);
-
-	cbq_rmprio(q, cl);
-	sch_tree_unlock(sch);
-
-	cbq_destroy_class(sch, cl);
-	return 0;
-}
-
-static struct tcf_block *cbq_tcf_block(struct Qdisc *sch, unsigned long arg,
-				       struct netlink_ext_ack *extack)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	if (cl == NULL)
-		cl = &q->link;
-
-	return cl->block;
-}
-
-static unsigned long cbq_bind_filter(struct Qdisc *sch, unsigned long parent,
-				     u32 classid)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *p = (struct cbq_class *)parent;
-	struct cbq_class *cl = cbq_class_lookup(q, classid);
-
-	if (cl) {
-		if (p && p->level <= cl->level)
-			return 0;
-		cl->filters++;
-		return (unsigned long)cl;
-	}
-	return 0;
-}
-
-static void cbq_unbind_filter(struct Qdisc *sch, unsigned long arg)
-{
-	struct cbq_class *cl = (struct cbq_class *)arg;
-
-	cl->filters--;
-}
-
-static void cbq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
-{
-	struct cbq_sched_data *q = qdisc_priv(sch);
-	struct cbq_class *cl;
-	unsigned int h;
-
-	if (arg->stop)
-		return;
-
-	for (h = 0; h < q->clhash.hashsize; h++) {
-		hlist_for_each_entry(cl, &q->clhash.hash[h], common.hnode) {
-			if (arg->count < arg->skip) {
-				arg->count++;
-				continue;
-			}
-			if (arg->fn(sch, (unsigned long)cl, arg) < 0) {
-				arg->stop = 1;
-				return;
-			}
-			arg->count++;
-		}
-	}
-}
-
-static const struct Qdisc_class_ops cbq_class_ops = {
-	.graft		=	cbq_graft,
-	.leaf		=	cbq_leaf,
-	.qlen_notify	=	cbq_qlen_notify,
-	.find		=	cbq_find,
-	.change		=	cbq_change_class,
-	.delete		=	cbq_delete,
-	.walk		=	cbq_walk,
-	.tcf_block	=	cbq_tcf_block,
-	.bind_tcf	=	cbq_bind_filter,
-	.unbind_tcf	=	cbq_unbind_filter,
-	.dump		=	cbq_dump_class,
-	.dump_stats	=	cbq_dump_class_stats,
-};
-
-static struct Qdisc_ops cbq_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&cbq_class_ops,
-	.id		=	"cbq",
-	.priv_size	=	sizeof(struct cbq_sched_data),
-	.enqueue	=	cbq_enqueue,
-	.dequeue	=	cbq_dequeue,
-	.peek		=	qdisc_peek_dequeued,
-	.init		=	cbq_init,
-	.reset		=	cbq_reset,
-	.destroy	=	cbq_destroy,
-	.change		=	NULL,
-	.dump		=	cbq_dump,
-	.dump_stats	=	cbq_dump_stats,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init cbq_module_init(void)
-{
-	return register_qdisc(&cbq_qdisc_ops);
-}
-static void __exit cbq_module_exit(void)
-{
-	unregister_qdisc(&cbq_qdisc_ops);
-}
-module_init(cbq_module_init)
-module_exit(cbq_module_exit)
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_dsmark.c b/net/sched/sch_dsmark.c
deleted file mode 100644
index 47a61689dadb..000000000000
--- a/net/sched/sch_dsmark.c
+++ /dev/null
@@ -1,519 +0,0 @@
-/* net/sched/sch_dsmark.c - Differentiated Services field marker */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/bitops.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-#include <net/dsfield.h>
-#include <net/inet_ecn.h>
-#include <asm/byteorder.h>
-
-/*
- * classid	class		marking
- * -------	-----		-------
- *   n/a	  0		n/a
- *   x:0	  1		use entry [0]
- *   ...	 ...		...
- *   x:y y>0	 y+1		use entry [y]
- *   ...	 ...		...
- * x:indices-1	indices		use entry [indices-1]
- *   ...	 ...		...
- *   x:y	 y+1		use entry [y & (indices-1)]
- *   ...	 ...		...
- * 0xffff	0x10000		use entry [indices-1]
- */
-
-
-#define NO_DEFAULT_INDEX	(1 << 16)
-
-struct mask_value {
-	u8			mask;
-	u8			value;
-};
-
-struct dsmark_qdisc_data {
-	struct Qdisc		*q;
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct mask_value	*mv;
-	u16			indices;
-	u8			set_tc_index;
-	u32			default_index;	/* index range is 0...0xffff */
-#define DSMARK_EMBEDDED_SZ	16
-	struct mask_value	embedded[DSMARK_EMBEDDED_SZ];
-};
-
-static inline int dsmark_valid_index(struct dsmark_qdisc_data *p, u16 index)
-{
-	return index <= p->indices && index > 0;
-}
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static int dsmark_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p],new %p,old %p)\n",
-		 __func__, sch, p, new, old);
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					sch->handle, NULL);
-		if (new == NULL)
-			new = &noop_qdisc;
-	}
-
-	*old = qdisc_replace(sch, new, &p->q);
-	return 0;
-}
-
-static struct Qdisc *dsmark_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	return p->q;
-}
-
-static unsigned long dsmark_find(struct Qdisc *sch, u32 classid)
-{
-	return TC_H_MIN(classid) + 1;
-}
-
-static unsigned long dsmark_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n",
-		 __func__, sch, qdisc_priv(sch), classid);
-
-	return dsmark_find(sch, classid);
-}
-
-static void dsmark_unbind_filter(struct Qdisc *sch, unsigned long cl)
-{
-}
-
-static const struct nla_policy dsmark_policy[TCA_DSMARK_MAX + 1] = {
-	[TCA_DSMARK_INDICES]		= { .type = NLA_U16 },
-	[TCA_DSMARK_DEFAULT_INDEX]	= { .type = NLA_U16 },
-	[TCA_DSMARK_SET_TC_INDEX]	= { .type = NLA_FLAG },
-	[TCA_DSMARK_MASK]		= { .type = NLA_U8 },
-	[TCA_DSMARK_VALUE]		= { .type = NLA_U8 },
-};
-
-static int dsmark_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x,parent %x), arg 0x%lx\n",
-		 __func__, sch, p, classid, parent, *arg);
-
-	if (!dsmark_valid_index(p, *arg)) {
-		err = -ENOENT;
-		goto errout;
-	}
-
-	if (!opt)
-		goto errout;
-
-	err = nla_parse_nested(tb, TCA_DSMARK_MAX, opt, dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	if (tb[TCA_DSMARK_VALUE])
-		p->mv[*arg - 1].value = nla_get_u8(tb[TCA_DSMARK_VALUE]);
-
-	if (tb[TCA_DSMARK_MASK])
-		p->mv[*arg - 1].mask = nla_get_u8(tb[TCA_DSMARK_MASK]);
-
-	err = 0;
-
-errout:
-	return err;
-}
-
-static int dsmark_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	if (!dsmark_valid_index(p, arg))
-		return -EINVAL;
-
-	p->mv[arg - 1].mask = 0xff;
-	p->mv[arg - 1].value = 0;
-
-	return 0;
-}
-
-static void dsmark_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],walker %p)\n",
-		 __func__, sch, p, walker);
-
-	if (walker->stop)
-		return;
-
-	for (i = 0; i < p->indices; i++) {
-		if (p->mv[i].mask == 0xff && !p->mv[i].value)
-			goto ignore;
-		if (walker->count >= walker->skip) {
-			if (walker->fn(sch, i + 1, walker) < 0) {
-				walker->stop = 1;
-				break;
-			}
-		}
-ignore:
-		walker->count++;
-	}
-}
-
-static struct tcf_block *dsmark_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	return p->block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int dsmark_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("%s(skb %p,sch %p,[qdisc %p])\n", __func__, skb, sch, p);
-
-	if (p->set_tc_index) {
-		int wlen = skb_network_offset(skb);
-
-		switch (skb_protocol(skb, true)) {
-		case htons(ETH_P_IP):
-			wlen += sizeof(struct iphdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv4_get_dsfield(ip_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-
-		case htons(ETH_P_IPV6):
-			wlen += sizeof(struct ipv6hdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv6_get_dsfield(ipv6_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-		default:
-			skb->tc_index = 0;
-			break;
-		}
-	}
-
-	if (TC_H_MAJ(skb->priority) == sch->handle)
-		skb->tc_index = TC_H_MIN(skb->priority);
-	else {
-		struct tcf_result res;
-		struct tcf_proto *fl = rcu_dereference_bh(p->filter_list);
-		int result = tcf_classify(skb, fl, &res, false);
-
-		pr_debug("result %d class 0x%04x\n", result, res.classid);
-
-		switch (result) {
-#ifdef CONFIG_NET_CLS_ACT
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-
-		case TC_ACT_SHOT:
-			goto drop;
-#endif
-		case TC_ACT_OK:
-			skb->tc_index = TC_H_MIN(res.classid);
-			break;
-
-		default:
-			if (p->default_index != NO_DEFAULT_INDEX)
-				skb->tc_index = p->default_index;
-			break;
-		}
-	}
-
-	err = qdisc_enqueue(skb, p->q, to_free);
-	if (err != NET_XMIT_SUCCESS) {
-		if (net_xmit_drop_count(err))
-			qdisc_qstats_drop(sch);
-		return err;
-	}
-
-	qdisc_qstats_backlog_inc(sch, skb);
-	sch->q.qlen++;
-
-	return NET_XMIT_SUCCESS;
-
-drop:
-	qdisc_drop(skb, sch, to_free);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-static struct sk_buff *dsmark_dequeue(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-	u32 index;
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	skb = qdisc_dequeue_peeked(p->q);
-	if (skb == NULL)
-		return NULL;
-
-	qdisc_bstats_update(sch, skb);
-	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
-
-	index = skb->tc_index & (p->indices - 1);
-	pr_debug("index %d->%d\n", skb->tc_index, index);
-
-	switch (skb_protocol(skb, true)) {
-	case htons(ETH_P_IP):
-		ipv4_change_dsfield(ip_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	case htons(ETH_P_IPV6):
-		ipv6_change_dsfield(ipv6_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	default:
-		/*
-		 * Only complain if a change was actually attempted.
-		 * This way, we can send non-IP traffic through dsmark
-		 * and don't need yet another qdisc as a bypass.
-		 */
-		if (p->mv[index].mask != 0xff || p->mv[index].value)
-			pr_warn("%s: unsupported protocol %d\n",
-				__func__, ntohs(skb_protocol(skb, true)));
-		break;
-	}
-
-	return skb;
-}
-
-static struct sk_buff *dsmark_peek(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	return p->q->ops->peek(p->q);
-}
-
-static int dsmark_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-	u32 default_index = NO_DEFAULT_INDEX;
-	u16 indices;
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],opt %p)\n", __func__, sch, p, opt);
-
-	if (!opt)
-		goto errout;
-
-	err = tcf_block_get(&p->block, &p->filter_list, sch, extack);
-	if (err)
-		return err;
-
-	err = nla_parse_nested(tb, TCA_DSMARK_MAX, opt, dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	err = -EINVAL;
-	if (!tb[TCA_DSMARK_INDICES])
-		goto errout;
-	indices = nla_get_u16(tb[TCA_DSMARK_INDICES]);
-
-	if (hweight32(indices) != 1)
-		goto errout;
-
-	if (tb[TCA_DSMARK_DEFAULT_INDEX])
-		default_index = nla_get_u16(tb[TCA_DSMARK_DEFAULT_INDEX]);
-
-	if (indices <= DSMARK_EMBEDDED_SZ)
-		p->mv = p->embedded;
-	else
-		p->mv = kmalloc_array(indices, sizeof(*p->mv), GFP_KERNEL);
-	if (!p->mv) {
-		err = -ENOMEM;
-		goto errout;
-	}
-	for (i = 0; i < indices; i++) {
-		p->mv[i].mask = 0xff;
-		p->mv[i].value = 0;
-	}
-	p->indices = indices;
-	p->default_index = default_index;
-	p->set_tc_index = nla_get_flag(tb[TCA_DSMARK_SET_TC_INDEX]);
-
-	p->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, sch->handle,
-				 NULL);
-	if (p->q == NULL)
-		p->q = &noop_qdisc;
-	else
-		qdisc_hash_add(p->q, true);
-
-	pr_debug("%s: qdisc %p\n", __func__, p->q);
-
-	err = 0;
-errout:
-	return err;
-}
-
-static void dsmark_reset(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-	if (p->q)
-		qdisc_reset(p->q);
-	sch->qstats.backlog = 0;
-	sch->q.qlen = 0;
-}
-
-static void dsmark_destroy(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	tcf_block_put(p->block);
-	qdisc_put(p->q);
-	if (p->mv != p->embedded)
-		kfree(p->mv);
-}
-
-static int dsmark_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	pr_debug("%s(sch %p,[qdisc %p],class %ld\n", __func__, sch, p, cl);
-
-	if (!dsmark_valid_index(p, cl))
-		return -EINVAL;
-
-	tcm->tcm_handle = TC_H_MAKE(TC_H_MAJ(sch->handle), cl - 1);
-	tcm->tcm_info = p->q->handle;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u8(skb, TCA_DSMARK_MASK, p->mv[cl - 1].mask) ||
-	    nla_put_u8(skb, TCA_DSMARK_VALUE, p->mv[cl - 1].value))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static int dsmark_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u16(skb, TCA_DSMARK_INDICES, p->indices))
-		goto nla_put_failure;
-
-	if (p->default_index != NO_DEFAULT_INDEX &&
-	    nla_put_u16(skb, TCA_DSMARK_DEFAULT_INDEX, p->default_index))
-		goto nla_put_failure;
-
-	if (p->set_tc_index &&
-	    nla_put_flag(skb, TCA_DSMARK_SET_TC_INDEX))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static const struct Qdisc_class_ops dsmark_class_ops = {
-	.graft		=	dsmark_graft,
-	.leaf		=	dsmark_leaf,
-	.find		=	dsmark_find,
-	.change		=	dsmark_change,
-	.delete		=	dsmark_delete,
-	.walk		=	dsmark_walk,
-	.tcf_block	=	dsmark_tcf_block,
-	.bind_tcf	=	dsmark_bind_filter,
-	.unbind_tcf	=	dsmark_unbind_filter,
-	.dump		=	dsmark_dump_class,
-};
-
-static struct Qdisc_ops dsmark_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&dsmark_class_ops,
-	.id		=	"dsmark",
-	.priv_size	=	sizeof(struct dsmark_qdisc_data),
-	.enqueue	=	dsmark_enqueue,
-	.dequeue	=	dsmark_dequeue,
-	.peek		=	dsmark_peek,
-	.init		=	dsmark_init,
-	.reset		=	dsmark_reset,
-	.destroy	=	dsmark_destroy,
-	.change		=	NULL,
-	.dump		=	dsmark_dump,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init dsmark_module_init(void)
-{
-	return register_qdisc(&dsmark_qdisc_ops);
-}
-
-static void __exit dsmark_module_exit(void)
-{
-	unregister_qdisc(&dsmark_qdisc_ops);
-}
-
-module_init(dsmark_module_init)
-module_exit(dsmark_module_exit)
-
-MODULE_LICENSE("GPL");
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e33c1175b158..f79700e5d801 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2994,6 +2994,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 5010a4d5bfba..c23a4764dfc6 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -286,7 +286,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\ () system call, and this
@@ -391,6 +391,154 @@ SEE ALSO
 
         print('')
 
+class PrinterHelpers(Printer):
+    """
+    A printer for dumping collected information about helpers as C header to
+    be included from BPF program.
+    @helpers: array of Helper objects to print to standard output
+    """
+
+    type_fwds = [
+            'struct bpf_fib_lookup',
+            'struct bpf_perf_event_data',
+            'struct bpf_perf_event_value',
+            'struct bpf_sock',
+            'struct bpf_sock_addr',
+            'struct bpf_sock_ops',
+            'struct bpf_sock_tuple',
+            'struct bpf_spin_lock',
+            'struct bpf_sysctl',
+            'struct bpf_tcp_sock',
+            'struct bpf_tunnel_key',
+            'struct bpf_xfrm_state',
+            'struct pt_regs',
+            'struct sk_reuseport_md',
+            'struct sockaddr',
+            'struct tcphdr',
+
+            'struct __sk_buff',
+            'struct sk_msg_md',
+            'struct xdp_md',
+    ]
+    known_types = {
+            '...',
+            'void',
+            'const void',
+            'char',
+            'const char',
+            'int',
+            'long',
+            'unsigned long',
+
+            '__be16',
+            '__be32',
+            '__wsum',
+
+            'struct bpf_fib_lookup',
+            'struct bpf_perf_event_data',
+            'struct bpf_perf_event_value',
+            'struct bpf_sock',
+            'struct bpf_sock_addr',
+            'struct bpf_sock_ops',
+            'struct bpf_sock_tuple',
+            'struct bpf_spin_lock',
+            'struct bpf_sysctl',
+            'struct bpf_tcp_sock',
+            'struct bpf_tunnel_key',
+            'struct bpf_xfrm_state',
+            'struct pt_regs',
+            'struct sk_reuseport_md',
+            'struct sockaddr',
+            'struct tcphdr',
+    }
+    mapped_types = {
+            'u8': '__u8',
+            'u16': '__u16',
+            'u32': '__u32',
+            'u64': '__u64',
+            's8': '__s8',
+            's16': '__s16',
+            's32': '__s32',
+            's64': '__s64',
+            'size_t': 'unsigned long',
+            'struct bpf_map': 'void',
+            'struct sk_buff': 'struct __sk_buff',
+            'const struct sk_buff': 'const struct __sk_buff',
+            'struct sk_msg_buff': 'struct sk_msg_md',
+            'struct xdp_buff': 'struct xdp_md',
+    }
+
+    def print_header(self):
+        header = '''\
+/* This is auto-generated file. See bpf_helpers_doc.py for details. */
+
+/* Forward declarations of BPF structs */'''
+
+        print(header)
+        for fwd in self.type_fwds:
+            print('%s;' % fwd)
+        print('')
+
+    def print_footer(self):
+        footer = ''
+        print(footer)
+
+    def map_type(self, t):
+        if t in self.known_types:
+            return t
+        if t in self.mapped_types:
+            return self.mapped_types[t]
+        print("")
+        print("Unrecognized type '%s', please add it to known types!" % t)
+        sys.exit(1)
+
+    seen_helpers = set()
+
+    def print_one(self, helper):
+        proto = helper.proto_break_down()
+
+        if proto['name'] in self.seen_helpers:
+            return
+        self.seen_helpers.add(proto['name'])
+
+        print('/*')
+        print(" * %s" % proto['name'])
+        print(" *")
+        if (helper.desc):
+            # Do not strip all newline characters: formatted code at the end of
+            # a section must be followed by a blank line.
+            for line in re.sub('\n$', '', helper.desc, count=1).split('\n'):
+                print(' *{}{}'.format(' \t' if line else '', line))
+
+        if (helper.ret):
+            print(' *')
+            print(' * Returns')
+            for line in helper.ret.rstrip().split('\n'):
+                print(' *{}{}'.format(' \t' if line else '', line))
+
+        print(' */')
+        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
+                                      proto['ret_star'], proto['name']), end='')
+        comma = ''
+        for i, a in enumerate(proto['args']):
+            t = a['type']
+            n = a['name']
+            if proto['name'] == 'bpf_get_socket_cookie' and i == 0:
+                    t = 'void'
+                    n = 'ctx'
+            one_arg = '{}{}'.format(comma, self.map_type(t))
+            if n:
+                if a['star']:
+                    one_arg += ' {}'.format(a['star'])
+                else:
+                    one_arg += ' '
+                one_arg += '{}'.format(n)
+            comma = ', '
+            print(one_arg, end='')
+
+        print(') = (void *) %d;' % len(self.seen_helpers))
+        print('')
+
 ###############################################################################
 
 # If script is launched from scripts/ from kernel tree and can access
@@ -405,6 +553,8 @@ Parse eBPF header file and generate documentation for eBPF helper functions.
 The RST-formatted output produced can be turned into a manual page with the
 rst2man utility.
 """)
+argParser.add_argument('--header', action='store_true',
+                       help='generate C header file')
 if (os.path.isfile(bpfh)):
     argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
                            default=bpfh)
@@ -417,5 +567,8 @@ headerParser = HeaderParser(args.filename)
 headerParser.run()
 
 # Print formatted output to standard output.
-printer = PrinterRST(headerParser.helpers)
+if args.header:
+    printer = PrinterHelpers(headerParser.helpers)
+else:
+    printer = PrinterRST(headerParser.helpers)
 printer.print_all()
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index cb36774a750c..2fb26bd3106e 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -469,6 +469,9 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 		}
 
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
+
 		spin_lock_irqsave(&irq->irq_lock, flags);
 		irq->pending_latch = pendmask & (1U << bit_nr);
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
@@ -1229,6 +1232,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 

