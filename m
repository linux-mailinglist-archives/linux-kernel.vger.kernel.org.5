Return-Path: <linux-kernel+bounces-57648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFC84DBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301451C24ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE756A8BB;
	Thu,  8 Feb 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgoENIZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E236D1AB;
	Thu,  8 Feb 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381925; cv=none; b=I/sf50vDrgytaV9UgceEUCV0V+fCZzEKYS9+/8VrKMAXX8DlK1fJdSdOB1tMaGSog9S0FTq6i5Fa2kqSZo6bsx+O1dOuTot+pBYh79/J2wehg5ZJvY+iPbztpe76lJl+LmL/t/7VU4/CxL9cNVcajiSd447CLd684vzi3eqXAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381925; c=relaxed/simple;
	bh=gBFO/9DVXohiBgwRjVJTNp1nlX5W18BmmjuIIQEzyeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM2nzGmYalmZEH4krDHQtXJ1iF1wJjtTxrnyc0AcvHWNPgBffSl/6BvI9bB8uurrESlIXhhyuVuTVzdcP0bvj3Ufska2Re2Gc8R9B92UT7X0hd9EzDRhDCUUDPBbINg6Jy2UuKdi+7MdH/rN0dNSDcTiKcjfz2y3jnZ9G8j70zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgoENIZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2CDC43394;
	Thu,  8 Feb 2024 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381925;
	bh=gBFO/9DVXohiBgwRjVJTNp1nlX5W18BmmjuIIQEzyeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgoENIZxGJWTBQr7a7M7KnxHYBZyDq62VZ7lmpu16WXA74+4Efb2hoqvNpFpcFZ3Y
	 P6EYi93XV9UL3Ltc7te1XnhET3poLKQGwMYKHdPsNGyiPX/yufOFw66ZbWmMEamkkR
	 CAFcoEPrX65+rBoWG6TMNMfEJ8yV3Vo27urGiQpjRLQ4fJuDvlM+bBVapwUbO2kb8i
	 50Zuk8MLN4o9bO9Fy2HWNlfk9n32B/Fk0PgFIRn9DThq1CQ4qDp7XgrTpyD/gapmT2
	 0dgo1HXY3KO+1zK0wn69R8jVXpVELFqMxxd0e3dlIhnG5LFgx7jHSW46ReDsjDeqcK
	 x0g+QKJ73Fftg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Richard Hirst <rhirst@linuxcare.com>
Subject: [PATCH 02/10] scsi: 53c700: Trivial: Remove trailing whitespace
Date: Thu,  8 Feb 2024 08:44:14 +0000
Message-ID: <20240208084512.3803250-3-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 5a602de99797b ("Add .editorconfig file for basic formatting") my
editor has been forced to remove trailing whitespace from any file it
saves.  Instead of fighting this recent kernel default, let's start
chipping away at fixing the issues.

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Richard Hirst <rhirst@linuxcare.com>
---
 drivers/scsi/53c700.c | 102 +++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 85439e976143b..1aa933485719a 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2001 by James.Bottomley@HansenPartnership.com
 **-----------------------------------------------------------------------------
-**  
+**
 **
 **-----------------------------------------------------------------------------
  */
@@ -18,7 +18,7 @@
  *
  * The 700 is the lowliest of the line, it can only do async SCSI.
  * The 700-66 can at least do synchronous SCSI up to 10MHz.
- * 
+ *
  * The 700 chip has no host bus interface logic of its own.  However,
  * it is usually mapped to a location with well defined register
  * offsets.  Therefore, if you can determine the base address and the
@@ -61,7 +61,7 @@
  * consistent memory allocation.
  *
  * Version 2.5
- * 
+ *
  * More Compatibility changes for 710 (now actually works).  Enhanced
  * support for odd clock speeds which constrain SDTR negotiations.
  * correct cacheline separation for scsi messages and status for
@@ -70,7 +70,7 @@
  *
  * Version 2.4
  *
- * Added support for the 53c710 chip (in 53c700 emulation mode only---no 
+ * Added support for the 53c710 chip (in 53c700 emulation mode only---no
  * special 53c710 instructions or registers are used).
  *
  * Version 2.3
@@ -190,7 +190,7 @@ static char *NCR_700_condition[] = {
 	"DISCONNECT_MSG RECEIVED",
 	"MSG_OUT",
 	"DATA_IN",
-	
+
 };
 
 static char *NCR_700_fatal_messages[] = {
@@ -260,7 +260,7 @@ NCR_700_offset_period_to_sxfer(struct NCR_700_Host_Parameters *hostdata,
 static inline __u8
 NCR_700_get_SXFER(struct scsi_device *SDp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
 
 	return NCR_700_offset_period_to_sxfer(hostdata,
@@ -416,7 +416,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 int
 NCR_700_release(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 
 	if (hostdata->noncoherent)
@@ -449,7 +449,7 @@ NCR_700_identify(int can_disconnect, __u8 lun)
  * Inputs : host - SCSI host */
 static inline int
 NCR_700_data_residual (struct Scsi_Host *host) {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	int count, synchronous = 0;
 	unsigned int ddir;
@@ -461,16 +461,16 @@ NCR_700_data_residual (struct Scsi_Host *host) {
 		count = ((NCR_700_readb(host, DFIFO_REG) & 0x3f) -
 			 (NCR_700_readl(host, DBC_REG) & 0x3f)) & 0x3f;
 	}
-	
+
 	if(hostdata->fast)
 		synchronous = NCR_700_readb(host, SXFER_REG) & 0x0f;
-	
+
 	/* get the data direction */
 	ddir = NCR_700_readb(host, CTEST0_REG) & 0x01;
 
 	if (ddir) {
 		/* Receive */
-		if (synchronous) 
+		if (synchronous)
 			count += (NCR_700_readb(host, SSTAT2_REG) & 0xf0) >> 4;
 		else
 			if (NCR_700_readb(host, SSTAT1_REG) & SIDL_REG_FULL)
@@ -500,7 +500,7 @@ sbcl_to_string(__u8 sbcl)
 
 	ret[0]='\0';
 	for(i=0; i<8; i++) {
-		if((1<<i) & sbcl) 
+		if((1<<i) & sbcl)
 			strcat(ret, NCR_700_SBCL_bits[i]);
 	}
 	strcat(ret, NCR_700_SBCL_to_phase[sbcl & 0x07]);
@@ -533,7 +533,7 @@ find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
 	if(slot->state != NCR_700_SLOT_FREE)
 		/* should panic! */
 		printk(KERN_ERR "BUSY SLOT ON FREE LIST!!!\n");
-		
+
 
 	hostdata->free_list = slot->ITL_forw;
 	slot->ITL_forw = NULL;
@@ -546,11 +546,11 @@ find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
 	slot->state = NCR_700_SLOT_BUSY;
 	slot->flags = 0;
 	hostdata->command_slot_count++;
-	
+
 	return slot;
 }
 
-STATIC void 
+STATIC void
 free_slot(struct NCR_700_command_slot *slot,
 	  struct NCR_700_Host_Parameters *hostdata)
 {
@@ -560,7 +560,7 @@ free_slot(struct NCR_700_command_slot *slot,
 	if(slot->state == NCR_700_SLOT_FREE) {
 		printk(KERN_ERR "53c700: SLOT %p is FREE!!!\n", slot);
 	}
-	
+
 	slot->resume_offset = 0;
 	slot->cmnd = NULL;
 	slot->state = NCR_700_SLOT_FREE;
@@ -654,7 +654,7 @@ NCR_700_internal_bus_reset(struct Scsi_Host *host)
 STATIC void
 NCR_700_chip_setup(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	__u8 min_period;
 	__u8 min_xferp = (hostdata->chip710 ? NCR_710_MIN_XFERP : NCR_700_MIN_XFERP);
@@ -694,11 +694,11 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 	} else {
 		NCR_700_writeb(BURST_LENGTH_8 | hostdata->dmode_extra,
 			       host, DMODE_700_REG);
-		NCR_700_writeb(hostdata->differential ? 
+		NCR_700_writeb(hostdata->differential ?
 			       DIFF : 0, host, CTEST7_REG);
 		if(hostdata->fast) {
 			/* this is for 700-66, does nothing on 700 */
-			NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION 
+			NCR_700_writeb(LAST_DIS_ENBL | ENABLE_ACTIVE_NEGATION
 				       | GENERATE_RECEIVE_PARITY, host,
 				       CTEST8_REG);
 		} else {
@@ -731,7 +731,7 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 		NCR_700_writeb(ASYNC_DIV_3_0 | hostdata->dcntl_extra, host, DCNTL_REG);
 		hostdata->sync_clock = hostdata->clock*2;
 		hostdata->sync_clock /= 3;
-		
+
 	} else if(hostdata->clock > 37 && hostdata->clock <= 50) {
 		/* sync divider 1, async divider 2 */
 		DEBUG(("53c700: sync 1 async 2\n"));
@@ -764,7 +764,7 @@ NCR_700_chip_setup(struct Scsi_Host *host)
 STATIC void
 NCR_700_chip_reset(struct Scsi_Host *host)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)host->hostdata[0];
 	if(hostdata->chip710) {
 		NCR_700_writeb(SOFTWARE_RESET_710, host, ISTAT_REG);
@@ -774,7 +774,7 @@ NCR_700_chip_reset(struct Scsi_Host *host)
 	} else {
 		NCR_700_writeb(SOFTWARE_RESET, host, DCNTL_REG);
 		udelay(100);
-		
+
 		NCR_700_writeb(0, host, DCNTL_REG);
 	}
 
@@ -790,7 +790,7 @@ NCR_700_chip_reset(struct Scsi_Host *host)
  * ACK) so that the routine returns correctly to resume its activity
  * */
 STATIC __u32
-process_extended_message(struct Scsi_Host *host, 
+process_extended_message(struct Scsi_Host *host,
 			 struct NCR_700_Host_Parameters *hostdata,
 			 struct scsi_cmnd *SCp, __u32 dsp, __u32 dsps)
 {
@@ -816,15 +816,15 @@ process_extended_message(struct Scsi_Host *host,
 
 			spi_offset(starget) = offset;
 			spi_period(starget) = period;
-			
+
 			if(NCR_700_is_flag_set(SCp->device, NCR_700_DEV_PRINT_SYNC_NEGOTIATION)) {
 				spi_display_xfer_agreement(starget);
 				NCR_700_clear_flag(SCp->device, NCR_700_DEV_PRINT_SYNC_NEGOTIATION);
 			}
-			
+
 			NCR_700_set_flag(SCp->device, NCR_700_DEV_NEGOTIATED_SYNC);
 			NCR_700_clear_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
-			
+
 			NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
 				       host, SXFER_REG);
 
@@ -841,7 +841,7 @@ process_extended_message(struct Scsi_Host *host,
 			resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 		}
 		break;
-	
+
 	case A_WDTR_MSG:
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
@@ -1121,7 +1121,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 
 			SCp = scsi_host_find_tag(SDp->host, hostdata->msgin[2]);
 			if(unlikely(SCp == NULL)) {
-				printk(KERN_ERR "scsi%d: (%d:%d) no saved request for tag %d\n", 
+				printk(KERN_ERR "scsi%d: (%d:%d) no saved request for tag %d\n",
 				       host->host_no, reselection_id, lun, hostdata->msgin[2]);
 				BUG();
 			}
@@ -1180,7 +1180,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 				       slot->cmnd->cmd_len);
 
 
-			
+
 		}
 	} else if(dsps == A_RESELECTED_DURING_SELECTION) {
 
@@ -1193,10 +1193,10 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 
 		__u8 reselection_id = NCR_700_readb(host, SFBR_REG);
 		struct NCR_700_command_slot *slot;
-		
+
 		/* Take out our own ID */
 		reselection_id &= ~(1<<host->this_id);
-		
+
 		/* I've never seen this happen, so keep this as a printk rather
 		 * than a debug */
 		printk(KERN_INFO "scsi%d: (%d:%d) RESELECTION DURING SELECTION, dsp=%08x[%04x] state=%d, count=%d\n",
@@ -1222,7 +1222,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 			slot->state = NCR_700_SLOT_QUEUED;
 		}
 		hostdata->cmd = NULL;
-		
+
 		if(reselection_id == 0) {
 			if(hostdata->reselection_id == 0xff) {
 				printk(KERN_ERR "scsi%d: Invalid reselection during selection!!\n", host->host_no);
@@ -1233,7 +1233,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 				reselection_id = hostdata->reselection_id;
 			}
 		} else {
-			
+
 			/* convert to real ID */
 			reselection_id = bitmap_to_number(reselection_id);
 		}
@@ -1251,7 +1251,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 		 * a return here will re-run the queued command slot
 		 * that may have been interrupted by the initial selection */
 		DEBUG((" SELECTION COMPLETED\n"));
-	} else if((dsps & 0xfffff0f0) == A_MSG_IN) { 
+	} else if((dsps & 0xfffff0f0) == A_MSG_IN) {
 		resume_offset = process_message(host, hostdata, SCp,
 						dsp, dsps);
 	} else if((dsps &  0xfffff000) == 0) {
@@ -1304,7 +1304,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 
 		/* Take out our own ID */
 		id &= ~(1<<host->this_id);
-		if(id != 0) 
+		if(id != 0)
 			break;
 		udelay(5);
 	}
@@ -1322,7 +1322,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 		struct NCR_700_command_slot *slot =
 			(struct NCR_700_command_slot *)SCp->host_scribble;
 		DEBUG(("  ID %d WARNING: RESELECTION OF BUSY HOST, saving cmd %p, slot %p, addr %x [%04x], resume %x!\n", id, hostdata->cmd, slot, dsp, dsp - hostdata->pScript, resume_offset));
-		
+
 		switch(dsp - hostdata->pScript) {
 		case Ent_Disconnect1:
 		case Ent_Disconnect2:
@@ -1344,7 +1344,7 @@ process_selection(struct Scsi_Host *host, __u32 dsp)
 		case Ent_Finish2:
 			process_script_interrupt(A_GOOD_STATUS_AFTER_STATUS, dsp, SCp, host, hostdata);
 			break;
-			
+
 		default:
 			slot->state = NCR_700_SLOT_QUEUED;
 			break;
@@ -1547,7 +1547,7 @@ NCR_700_intr(int irq, void *dev_id)
 			/* clear all the negotiated parameters */
 			__shost_for_each_device(SDp, host)
 				NCR_700_clear_flag(SDp, ~0);
-			
+
 			/* clear all the slots and their pending commands */
 			for(i = 0; i < NCR_700_COMMAND_SLOTS_PER_HOST; i++) {
 				struct scsi_cmnd *SCp;
@@ -1556,7 +1556,7 @@ NCR_700_intr(int irq, void *dev_id)
 
 				if(slot->state == NCR_700_SLOT_FREE)
 					continue;
-				
+
 				SCp = slot->cmnd;
 				printk(KERN_ERR " failing command because of reset, slot %p, cmnd %p\n",
 				       slot, SCp);
@@ -1620,7 +1620,7 @@ NCR_700_intr(int irq, void *dev_id)
 				data_transfer += residual;
 
 				if(data_transfer != 0) {
-					int count; 
+					int count;
 					__u32 pAddr;
 
 					SGcount--;
@@ -1680,7 +1680,7 @@ NCR_700_intr(int irq, void *dev_id)
 			NCR_700_scsi_done(hostdata, SCp, DID_ERROR<<16);
 		}
 
-		
+
 		/* NOTE: selection interrupt processing MUST occur
 		 * after script interrupt processing to correctly cope
 		 * with the case where we process a disconnect and
@@ -1718,7 +1718,7 @@ NCR_700_intr(int irq, void *dev_id)
 		DEBUG(("Attempting to resume at %x\n", resume_offset));
 		NCR_700_clear_fifo(host);
 		NCR_700_writel(resume_offset, host, DSP_REG);
-	} 
+	}
 	/* There is probably a technical no-no about this: If we're a
 	 * shared interrupt and we got this interrupt because the
 	 * other device needs servicing not us, we're still going to
@@ -1732,7 +1732,7 @@ NCR_700_intr(int irq, void *dev_id)
 			 * position we left off */
 			int j = (i + hostdata->saved_slot_position)
 				% NCR_700_COMMAND_SLOTS_PER_HOST;
-			
+
 			if(hostdata->slots[j].state != NCR_700_SLOT_QUEUED)
 				continue;
 			if(NCR_700_start_command(hostdata->slots[j].cmnd)) {
@@ -1752,7 +1752,7 @@ NCR_700_intr(int irq, void *dev_id)
 
 static int NCR_700_queuecommand_lck(struct scsi_cmnd *SCp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
 	__u32 move_ins;
 	struct NCR_700_command_slot *slot;
@@ -1852,7 +1852,7 @@ static int NCR_700_queuecommand_lck(struct scsi_cmnd *SCp)
 		default:
 			printk(KERN_ERR "53c700: Unknown command for data direction ");
 			scsi_print_command(SCp);
-			
+
 			move_ins = 0;
 			break;
 		case DMA_NONE:
@@ -1937,7 +1937,7 @@ STATIC int
 NCR_700_host_reset(struct scsi_cmnd * SCp)
 {
 	DECLARE_COMPLETION_ONSTACK(complete);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
 
 	scmd_printk(KERN_INFO, SCp,
@@ -1975,9 +1975,9 @@ STATIC void
 NCR_700_set_period(struct scsi_target *STp, int period)
 {
 	struct Scsi_Host *SHp = dev_to_shost(STp->dev.parent);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SHp->hostdata[0];
-	
+
 	if(!hostdata->fast)
 		return;
 
@@ -1994,11 +1994,11 @@ STATIC void
 NCR_700_set_offset(struct scsi_target *STp, int offset)
 {
 	struct Scsi_Host *SHp = dev_to_shost(STp->dev.parent);
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SHp->hostdata[0];
 	int max_offset = hostdata->chip710
 		? NCR_710_MAX_OFFSET : NCR_700_MAX_OFFSET;
-	
+
 	if(!hostdata->fast)
 		return;
 
@@ -2031,7 +2031,7 @@ NCR_700_slave_alloc(struct scsi_device *SDp)
 STATIC int
 NCR_700_slave_configure(struct scsi_device *SDp)
 {
-	struct NCR_700_Host_Parameters *hostdata = 
+	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
 
 	/* to do here: allocate memory; build a queue_full list */
-- 
2.43.0.594.gd9cf4e227d-goog


