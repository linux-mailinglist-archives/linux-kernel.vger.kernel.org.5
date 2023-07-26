Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929DE763F20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGZS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGZS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:59:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9352717;
        Wed, 26 Jul 2023 11:59:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bb0cadd3ccso86664a34.3;
        Wed, 26 Jul 2023 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690397976; x=1691002776;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziQ3nx83KMp7PLHSdD/veNs27euCmJl/gfBQ/qPL2Nk=;
        b=qE02BCWpeTlsoPyI3FxI630VuZkGfQG/sOeKMg/z6jZW5Odec8lFmx6LUqM9jfWWV1
         tRdPC9DgrqNMET/rhovyQ3PkISDUsgy2bLLXpafpHeBBTW9zwcyYfgzZYl7eWu/cCYWo
         6n6cOs7uGN6zmRuSUUMg/t+TDMzUBYKM/ipxIgRH/meDVzu2DHL+CDoWtIElGggPC74S
         qKQ3URsCItkeZ4hLhPAbZnTD11w+HprMHyZE3Tl1uUJTXPFSEVSk38XV5aWOhki2/7ol
         iygYeAST+VMjzl2+dGTqLD+avf6PSKCr0skgCedBvtaZbQC+I8wOzdDdEnD2xhm6OfDJ
         aQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397976; x=1691002776;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziQ3nx83KMp7PLHSdD/veNs27euCmJl/gfBQ/qPL2Nk=;
        b=hZF44qj8IW0qqYN6sKzBp/hAlglzezDRDXCa0Gn9v26DbWRHPSdlgVnviM0FR6g7Jy
         FV5g5XCd74omWpYURdr+CjGq5Nmv3tnwZxT/f34QtFrBOfPPh/KGWInFQtGwHeMgs+8M
         moRP/RXHYqFfBx/OPj7EbuLD8YZ6YvmrhDdGBYWO1mDu2Xsm+UDs2fZiFXyKA0RZA/th
         9NmlakNttPWFZJ9k/wiFR8QKUjY3QyEkmYlalx2drM1TyAKr6GL+eZcwCHHZWs3EN1Mo
         Z0N6Fg/+xohvNenmfhp4qGrp3Zz8gQGNEJ6dXcLJUj2xmJ5ZLCdfKGFDCrj+G8tDYHgE
         kDGA==
X-Gm-Message-State: ABy/qLZjxoGk47XrcQ0RKnxEFe8ef77JW1KHzS2OchWRpSdQ+sE2nvjh
        EEq2k+xCoViQk00lFOXLcpY=
X-Google-Smtp-Source: APBJJlHJIZiF9YuNvMi1j2Cs9Uo7oT70Xc6aVZIYz7PrTljParXdiy5YhgjmIjHYafLBqAF0Au0PoQ==
X-Received: by 2002:a05:6358:9214:b0:132:ce1f:6793 with SMTP id d20-20020a056358921400b00132ce1f6793mr2731817rwb.21.1690397975915;
        Wed, 26 Jul 2023 11:59:35 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id c1-20020a63a401000000b0055c3e8c922dsm12704151pgf.90.2023.07.26.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:59:35 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, dave@stgolabs.net, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
Date:   Wed, 26 Jul 2023 18:59:23 +0000
Message-Id: <20230726185923.53353-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a long call chain that &fip->ctlr_lock is acquired by isr
fnic_isr_msix_wq_copy() under hard irq context. Thus other process
context code acquiring the lock should disable irq, otherwise
deadlock could happen if the irq preempt the execution while the
lock is held in process context on the same CPU.

[ISR]
fnic_isr_msix_wq_copy()
 -> fnic_wq_copy_cmpl_handler()
 -> fnic_fcpio_cmpl_handler()
 -> fnic_fcpio_flogi_reg_cmpl_handler()
 -> fnic_flush_tx()
 -> fnic_send_frame()
 -> fcoe_ctlr_els_send()
 -> spin_lock_bh(&fip->ctlr_lock)

[Process Context]
1. fcoe_ctlr_timer_work()
 -> fcoe_ctlr_flogi_send()
 -> spin_lock_bh(&fip->ctlr_lock)

2. fcoe_ctlr_recv_work()
 -> fcoe_ctlr_recv_handler()
 -> fcoe_ctlr_recv_els()
 -> fcoe_ctlr_announce()
 -> spin_lock_bh(&fip->ctlr_lock)

3. fcoe_ctlr_recv_work()
 -> fcoe_ctlr_recv_handler()
 -> fcoe_ctlr_recv_els()
 -> fcoe_ctlr_flogi_retry()
 -> spin_lock_bh(&fip->ctlr_lock)

4. -> fcoe_xmit()
 -> fcoe_ctlr_els_send()
 -> spin_lock_bh(&fip->ctlr_lock)

spin_lock_bh() is not enough since fnic_isr_msix_wq_copy() is a
hardirq.

These flaws were found by an experimental static analysis tool I am
developing for irq-related deadlock.

The patch fix the potential deadlocks by spin_lock_irqsave() to
disable hard irq.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 5c8d1ba3f8f3..19eee108db02 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,16 +319,17 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -699,6 +700,7 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
+	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -732,11 +734,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_bh(&fip->ctlr_lock);
+		spin_lock_irqsave(&fip->ctlr_lock, flags);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_bh(&fip->ctlr_lock);
+		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1705,10 +1707,11 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1719,7 +1722,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1736,8 +1739,9 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1764,7 +1768,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 }
 
 /**
-- 
2.17.1

