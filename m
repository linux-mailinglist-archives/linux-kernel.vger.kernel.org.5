Return-Path: <linux-kernel+bounces-46571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B6884417E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34B01F28657
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191782892;
	Wed, 31 Jan 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jqjBT6+u";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jqjBT6+u"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC437F48F;
	Wed, 31 Jan 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710329; cv=none; b=b1FVun2Otrrdqcvo9nHWPIHq8BSA3bTcUPsVCWxETwwezOnuyjcTYLaUy/E3lTBGc/etbvi1gM9lInw40vqOTYwZYhIAI4dyRVwSNl5LbJWrnT9YnIGQWRSjSxMlOx4L0lhvK+THPW5Pfz0o2bFc7FMezQmLrg6QAzBu/r9A4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710329; c=relaxed/simple;
	bh=yGS2QDHYP0P0IX5Sj43OrGzM9XRaVZMm32fQBhPrYi8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Iu08KdYzvx9vUordlbg2XNrzmwW92oEEmf5DdM5ZFtgRQrQuF/OyDcLFEbIk82wzWdK8NVDLXhlHNZTaLd576JiBY5Y5ax9AqlhZjn7M8DBlS6PRxkmJ9rONbBXaThGMU/XBmk+RYx8C4aTA+HQ863w5UD9hBrJkAcdlzsfgv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jqjBT6+u; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jqjBT6+u; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706710325;
	bh=yGS2QDHYP0P0IX5Sj43OrGzM9XRaVZMm32fQBhPrYi8=;
	h=Message-ID:Subject:From:To:Date:From;
	b=jqjBT6+u0CSFbNVzN2i5SQLF105KKjwtrCld7rP+PDh6RWJ264TxWmWiZ4DJevYTc
	 N91EPn6aad5zuXyL+v6Cb9hBc38j3i5HnztUX+hIRY6YACVC/QQrIkqxHydUBU3TSV
	 JnUzOuLTCnX5EHMvMR79dA35xzgIs795QwbEDaDM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DC33C12810AE;
	Wed, 31 Jan 2024 09:12:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id qpICi7ymUw4m; Wed, 31 Jan 2024 09:12:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706710325;
	bh=yGS2QDHYP0P0IX5Sj43OrGzM9XRaVZMm32fQBhPrYi8=;
	h=Message-ID:Subject:From:To:Date:From;
	b=jqjBT6+u0CSFbNVzN2i5SQLF105KKjwtrCld7rP+PDh6RWJ264TxWmWiZ4DJevYTc
	 N91EPn6aad5zuXyL+v6Cb9hBc38j3i5HnztUX+hIRY6YACVC/QQrIkqxHydUBU3TSV
	 JnUzOuLTCnX5EHMvMR79dA35xzgIs795QwbEDaDM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 22FFF1280474;
	Wed, 31 Jan 2024 09:12:05 -0500 (EST)
Message-ID: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.8-rc2
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Wed, 31 Jan 2024 09:12:03 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

6 small fixes.  5 are obvious and in drivers the fifth is a core fix to
remove the host lock acquisition and release, caused by a dynamic check
of host_busy, in the error handling loop which has been reported to
cause lockups.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Colin Ian King (1):
      scsi: initio: Remove redundant variable 'rb'

Li RongQing (1):
      scsi: virtio_scsi: Remove duplicate check if queue is broken

Michael Kelley (1):
      scsi: storvsc: Fix ring buffer size calculation

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler

Su Hui (1):
      scsi: isci: Fix an error code problem in isci_io_request_build()

Tyrel Datwyler (1):
      scsi: MAINTAINERS: Update ibmvscsi_tgt maintainer

And the diffstat:

 MAINTAINERS                 |  2 +-
 drivers/scsi/initio.c       |  3 +--
 drivers/scsi/isci/request.c |  2 +-
 drivers/scsi/scsi_error.c   |  8 ++++----
 drivers/scsi/scsi_lib.c     |  2 +-
 drivers/scsi/scsi_priv.h    |  2 +-
 drivers/scsi/storvsc_drv.c  | 12 +++++++-----
 drivers/scsi/virtio_scsi.c  |  2 --
 8 files changed, 16 insertions(+), 17 deletions(-)

With full diff below

James

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..a337cab28160 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10282,7 +10282,7 @@ F:	drivers/scsi/ibmvscsi/ibmvscsi*
 F:	include/scsi/viosrp.h
 
 IBM Power Virtual SCSI Device Target Driver
-M:	Michael Cyr <mikecyr@linux.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
 S:	Supported
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 2a50fda3a628..625fd547ee60 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -371,7 +371,6 @@ static u16 initio_se2_rd(unsigned long base, u8 addr)
  */
 static void initio_se2_wr(unsigned long base, u8 addr, u16 val)
 {
-	u8 rb;
 	u8 instr;
 	int i;
 
@@ -400,7 +399,7 @@ static void initio_se2_wr(unsigned long base, u8 addr, u16 val)
 		udelay(30);
 		outb(SE2CS, base + TUL_NVRAM);			/* -CLK */
 		udelay(30);
-		if ((rb = inb(base + TUL_NVRAM)) & SE2DI)
+		if (inb(base + TUL_NVRAM) & SE2DI)
 			break;	/* write complete */
 	}
 	outb(0, base + TUL_NVRAM);				/* -CS */
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 71f711cb0628..355a0bc0828e 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -3387,7 +3387,7 @@ static enum sci_status isci_io_request_build(struct isci_host *ihost,
 		return SCI_FAILURE;
 	}
 
-	return SCI_SUCCESS;
+	return status;
 }
 
 static struct isci_request *isci_request_from_tag(struct isci_host *ihost, u16 tag)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 79da4b1c1df0..4f455884fdc4 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -61,11 +61,11 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
 static enum scsi_disposition scsi_try_to_abort_cmd(const struct scsi_host_template *,
 						   struct scsi_cmnd *);
 
-void scsi_eh_wakeup(struct Scsi_Host *shost)
+void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy)
 {
 	lockdep_assert_held(shost->host_lock);
 
-	if (scsi_host_busy(shost) == shost->host_failed) {
+	if (busy == shost->host_failed) {
 		trace_scsi_eh_wakeup(shost);
 		wake_up_process(shost->ehandler);
 		SCSI_LOG_ERROR_RECOVERY(5, shost_printk(KERN_INFO, shost,
@@ -88,7 +88,7 @@ void scsi_schedule_eh(struct Scsi_Host *shost)
 	if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
 	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0) {
 		shost->host_eh_scheduled++;
-		scsi_eh_wakeup(shost);
+		scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	}
 
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -286,7 +286,7 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost);
+	scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cf3864f72093..1fb80eae9a63 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -280,7 +280,7 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost);
+			scsi_eh_wakeup(shost, scsi_host_busy(shost));
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 3f0dfb97db6b..1fbfe1b52c9f 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -92,7 +92,7 @@ extern void scmd_eh_abort_handler(struct work_struct *work);
 extern enum blk_eh_timer_return scsi_timeout(struct request *req);
 extern int scsi_error_handler(void *host);
 extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
-extern void scsi_eh_wakeup(struct Scsi_Host *shost);
+extern void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy);
 extern void scsi_eh_scmd_add(struct scsi_cmnd *);
 void scsi_eh_ready_devs(struct Scsi_Host *shost,
 			struct list_head *work_q,
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a95936b18f69..7ceb982040a5 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -330,6 +330,7 @@ enum storvsc_request_type {
  */
 
 static int storvsc_ringbuffer_size = (128 * 1024);
+static int aligned_ringbuffer_size;
 static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
@@ -687,8 +688,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	new_sc->next_request_id_callback = storvsc_next_request_id;
 
 	ret = vmbus_open(new_sc,
-			 storvsc_ringbuffer_size,
-			 storvsc_ringbuffer_size,
+			 aligned_ringbuffer_size,
+			 aligned_ringbuffer_size,
 			 (void *)&props,
 			 sizeof(struct vmstorage_channel_properties),
 			 storvsc_on_channel_callback, new_sc);
@@ -1973,7 +1974,7 @@ static int storvsc_probe(struct hv_device *device,
 	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
 
 	stor_device->port_number = host->host_no;
-	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
+	ret = storvsc_connect_to_vsp(device, aligned_ringbuffer_size, is_fc);
 	if (ret)
 		goto err_out1;
 
@@ -2164,7 +2165,7 @@ static int storvsc_resume(struct hv_device *hv_dev)
 {
 	int ret;
 
-	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
+	ret = storvsc_connect_to_vsp(hv_dev, aligned_ringbuffer_size,
 				     hv_dev_is_fc(hv_dev));
 	return ret;
 }
@@ -2198,8 +2199,9 @@ static int __init storvsc_drv_init(void)
 	 * the ring buffer indices) by the max request size (which is
 	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
 	 */
+	aligned_ringbuffer_size = VMBUS_RING_SIZE(storvsc_ringbuffer_size);
 	max_outstanding_req_per_channel =
-		((storvsc_ringbuffer_size - PAGE_SIZE) /
+		((aligned_ringbuffer_size - PAGE_SIZE) /
 		ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
 		sizeof(struct vstor_packet) + sizeof(u64),
 		sizeof(u64)));
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 4cf20be668a6..617eb892f4ad 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -188,8 +188,6 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
 		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
 			fn(vscsi, buf);
 
-		if (unlikely(virtqueue_is_broken(vq)))
-			break;
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
 }


