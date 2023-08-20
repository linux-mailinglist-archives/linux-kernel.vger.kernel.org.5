Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71128781BE8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjHTA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0087D802
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26d4dc7a8daso1186024a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492324; x=1693097124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN0Dz8EYWUsVecmkM6K8qhUJf9gNy1vPVpYgzSxYCV4=;
        b=eQcWro493IWsRQDzek8dDweYGrQSFdozCTzgbkPkZ59Mfi7DWTeN6G7v/0AvA1VMzc
         Kc6oIO7xGdmCnWgrLKh8XZy4xUbB6bA2Tu10L6xOYpw/OItvmpY8kmw0yPWNisLnbWUh
         3oee5COPeFmy0hmRrr8ASrQll9Cj5aUvqHI0+ErRhxL6zgiVRlvW+swwqExU+q7dbt2D
         UcRRs1HpONUVIBOn7IF1+dFXVEoTLPe/tnLB6OnIWuEPsQU8FbhjVyM1+Tjx+QoeuEiw
         wqZFDYw1HKYiOYJg93cT9tY67NxDoE7FwwjA9x6IbTUk8vEW8oHJ1Ys+WWFY2zQH9RUS
         oPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492324; x=1693097124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN0Dz8EYWUsVecmkM6K8qhUJf9gNy1vPVpYgzSxYCV4=;
        b=kjwMA0SRRpzsaKqEthra2lQ3PthUS5HO+nZliqLD6gJNW6H0VNC/gwPW64/AbZlOOX
         wkm5PZe5P4sbWA+etJX26h6KeVKB1rphPbNURPig75R7ncbP2oLv5MbmLUuWnWkYgjLn
         LTHQOZyB6V+JdDXLL8tTxcI+Qfvk6R9u211nM0QkGYbkHuinWUFcsadFNJXUdb4kUyZS
         BbWrVuejblZc+T0O5jg9RCTwd53C24e/9MRKbtme3dOYO77wzNzYBkpIvQ2l74y4cCWM
         AuHNVpjPraPn5fLDeuUrnlQrWy9a79gXt3MTQI0pGudx02JuX8e6YrIRmKIOdMWfEdHT
         81rw==
X-Gm-Message-State: AOJu0Yy+5fSyJo5PCzPnJpCtxGu18ih4SqjtTgeecqMcYV7OzWS4Mkr1
        79zvs5jULaES9UEBxvY1RkZz1w==
X-Google-Smtp-Source: AGHT+IGFUhM8GrAZfMajXM2+u+qXwDz1uQDKGihUZ8BVfVwrTwu7lwJUSJ3eFmkvQ1lxFsOWMsR1bQ==
X-Received: by 2002:a17:90b:293:b0:26b:2c52:5fc with SMTP id az19-20020a17090b029300b0026b2c5205fcmr2429849pjb.18.1692492323706;
        Sat, 19 Aug 2023 17:45:23 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:23 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 06/16] Staging: rtl8192e: Rename variable pRxTs in function RxPktPendingTimeout()
Date:   Sat, 19 Aug 2023 17:47:34 -0700
Message-ID: <20230820004744.278022-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function RxPktPendingTimeout() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3:Resend as 16 patch series - no longer throttled by email provider
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 33 +++++++++++------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 24a8b9fc0168..75bf59d267c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -10,10 +10,9 @@
 
 static void RxPktPendingTimeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
-						     rx_pkt_pending_timer);
-	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
-						  RxTsRecord[pRxTs->num]);
+	struct rx_ts_record *ts = from_timer(ts, t, rx_pkt_pending_timer);
+	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
+						  RxTsRecord[ts->num]);
 
 	struct rx_reorder_entry *pReorderEntry = NULL;
 
@@ -22,24 +21,24 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	bool bPktInBuf = false;
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-	if (pRxTs->rx_timeout_indicate_seq != 0xffff) {
-		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
+	if (ts->rx_timeout_indicate_seq != 0xffff) {
+		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTs->rx_pending_pkt_list.prev,
+					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			if (index == 0)
-				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
+				ts->rx_indicate_seq = pReorderEntry->SeqNum;
 
 			if (SN_LESS(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq) ||
+				    ts->rx_indicate_seq) ||
 			    SN_EQUAL(pReorderEntry->SeqNum,
-				     pRxTs->rx_indicate_seq)) {
+				     ts->rx_indicate_seq)) {
 				list_del_init(&pReorderEntry->List);
 
 				if (SN_EQUAL(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq))
-					pRxTs->rx_indicate_seq =
-					      (pRxTs->rx_indicate_seq + 1) % 4096;
+				    ts->rx_indicate_seq))
+					ts->rx_indicate_seq =
+					      (ts->rx_indicate_seq + 1) % 4096;
 
 				netdev_dbg(ieee->dev,
 					   "%s(): Indicate SeqNum: %d\n",
@@ -58,7 +57,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}
 
 	if (index > 0) {
-		pRxTs->rx_timeout_indicate_seq = 0xffff;
+		ts->rx_timeout_indicate_seq = 0xffff;
 
 		if (index > REORDER_WIN_SIZE) {
 			netdev_warn(ieee->dev,
@@ -72,9 +71,9 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		bPktInBuf = false;
 	}
 
-	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
-		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
-		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
+	if (bPktInBuf && (ts->rx_timeout_indicate_seq == 0xffff)) {
+		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
+		mod_timer(&ts->rx_pkt_pending_timer,  jiffies +
 			  msecs_to_jiffies(ieee->ht_info->rx_reorder_pending_time)
 			  );
 	}
-- 
2.41.0

