Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417D77F175
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348598AbjHQHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjHQHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:47:31 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2782D59;
        Thu, 17 Aug 2023 00:47:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso6274181a34.1;
        Thu, 17 Aug 2023 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692258449; x=1692863249;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YtVkUDi6PQF71up7RtpMAiWjdgINEup56Vts/BPg3o=;
        b=shgy35M1/9NqMTnzfCUanhlOmrMfDJY48DI4GL5RClIz87mMCJFCQHMLzPcAeCRrc1
         opltzqTHqROu2dX55r3WPi5u9E93AEHxYKCPbfYxEgXFCxs8ygW5Foed+GZXzaZM171X
         JLV73ZkjtVSw0xkkD/AkivyeWJET44QtKeewjhZ0PPqfB04WxoDGYaRd6VfHTJopROd4
         s6bgoGWKi8jzSmEdnKZjwCMpeBebEBePuV6wuNrVqTZmwKYDg986s73fGdWCoOsQvtxw
         6lJf5N5mB5PMjWwg6DIhf1xP4uWTuqTfTgGmZZLHmk9z1mTRNdtM/1S138w29ThAQ7uV
         /Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692258449; x=1692863249;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YtVkUDi6PQF71up7RtpMAiWjdgINEup56Vts/BPg3o=;
        b=FJw7eey7QadHgiP+0dAT8iXiMVr6JbOkfIH2pJTfaZn9W5ZlFlffwilah4zKS/I3ai
         F5rT6OvNMo0NX8//Q2U9OsqUsYo2lf1LUs+jZ6hS1uG0aiBdzcQF8zF6OJiQYgzZZ7vh
         ifkbhRl/Ibhdj+OmOsmYZYPKjKcQRJ8I1hrhUyGxofQvoF1Cd2eZ1pGmfjuAFEXdNYim
         C/kp1l8TILV+lwLl48caSHn4poe1Qa+KKILnXWo/HzOuEChEEBU715xDCcuONw5qs8iN
         RCAuSjBd81JHqaK3uo4jJspRxIj5PSNXsPsjwDPxy8mqMrcUBZgMgMJHvfQF5e/2OeGi
         JZ5A==
X-Gm-Message-State: AOJu0YxCa07pzv0IgLEuI3/PmsGtkVokJWHfTRxu/9rFMUXkOOqVyDic
        mzBP9a9qeRcDoH+pazD20uM=
X-Google-Smtp-Source: AGHT+IG4mSYv4/yU5rPl/CC4FGmIVUdtuZYdDQTS50fM4HnEA3E5RQLh//Kb0TAPe/f5g8H2BtixbQ==
X-Received: by 2002:a05:6358:7e8f:b0:12b:c378:b090 with SMTP id o15-20020a0563587e8f00b0012bc378b090mr4627894rwn.26.1692258449382;
        Thu, 17 Aug 2023 00:47:29 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id s18-20020a63af52000000b00569368ead4bsm437026pgo.42.2023.08.17.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 00:47:28 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, dave@stgolabs.net, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
Date:   Thu, 17 Aug 2023 07:47:08 +0000
Message-Id: <20230817074708.7509-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 794d98e77f59 ("[SCSI] libfcoe: retry rejected FLOGI to another FCF if possible")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
Change in v2:
- Add fixes tag

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

