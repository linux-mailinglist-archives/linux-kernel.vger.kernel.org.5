Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7A788AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbjHYOIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbjHYOHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB392D6A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso839338b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972390; x=1693577190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//JyP/NDkIwjte1iW7xlQ5CbR8Pu664kvEqMOzkiD8g=;
        b=cm5l8UFrt1fkFDpJ5k34WVbNfrNrKTSChvesOCHgwnPiUeDqPDsdte2dkoOmx1C2Z6
         7Xw/ou/rx0fVhsjOj6LXqOUHxOlS+k9DPzA0cd86/rnw522D721GrkTy3+2XFYbzXgu3
         w4AjLm/7Pn50niMdKlr8wtnjtuSFMmjX4fuaBTn/mSPQVmRdGaH1I7UBNT6lyXmAwKps
         O4H5mNI68ibA28WSS6oPU6CZsAjIMMApbRBZpDSc+LA5NlR9KSdl/p3mvpxTc7EKHSOx
         GlYx0ho5bklxmwmfhpiSdzVdgo599MqEy6vood5FCjjiuNt5SQHa3a332oe9S9k1gT7y
         GOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972390; x=1693577190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//JyP/NDkIwjte1iW7xlQ5CbR8Pu664kvEqMOzkiD8g=;
        b=dXg0Xt7hndvZyL2d9ZI0MnKqXl37gb/0mirx7RsI4VmQFfYn9Up7iTuQgWWSLNI/0o
         jRb3fLKmSfvaGlvUi+CgGkTqgGmMOf32r1/ng5MRIkOul5Ns94FsCEHu1NWb8iQ6hpwv
         PVgM5+wPab9qVlOjWESjCjUHGObebuLPsdX4/r6DFx1AZHi4nJN/ju06qOp4+6BSypDr
         YKFczNe/A5czcMY75h6zHy0TY+pHbMWO07red3aQqrw28xaenM7M8Gm/EArxl+TPQu7T
         iNo3FeoszEvkGCCoFv1iiJ8yTHWAlcV2Zo0lhLtWuto0lWKXNg0+Lb4wPAi/F6B8JwX4
         SCqg==
X-Gm-Message-State: AOJu0YyN3LsEbBA1/OTMXaI0LRwhngiX/PLN0IYHpQ6ruuQrE9NFID5M
        52gOcRXdLA52iaUXxMxeLysSDA==
X-Google-Smtp-Source: AGHT+IFvp1ogbDY5dynTMrWmlP7qjmUewSc7uV7Zdlvhkvy06D9NBZELctXRTdEtGrWUTqMdSMLjNg==
X-Received: by 2002:a05:6a20:548f:b0:137:23f1:4281 with SMTP id i15-20020a056a20548f00b0013723f14281mr19308023pzk.12.1692972390532;
        Fri, 25 Aug 2023 07:06:30 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:30 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 14/16] Staging: rtl8192e: Rename variable pTS in function RxReorderIndicatePacket()
Date:   Fri, 25 Aug 2023 07:08:45 -0700
Message-ID: <20230825140847.501113-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
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

Rename variable pTS in function RxReorderIndicatePacket() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib_rx.c | 58 ++++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4907468ddaa5..e97debe6a7d2 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -554,7 +554,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 
 static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 				    struct rtllib_rxb *prxb,
-				    struct rx_ts_record *pTS, u16 SeqNum)
+				    struct rx_ts_record *ts, u16 SeqNum)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
@@ -565,21 +565,21 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	unsigned long flags;
 
 	netdev_dbg(ieee->dev,
-		   "%s(): Seq is %d, pTS->rx_indicate_seq is %d, WinSize is %d\n",
-		   __func__, SeqNum, pTS->rx_indicate_seq, WinSize);
+		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, WinSize is %d\n",
+		   __func__, SeqNum, ts->rx_indicate_seq, WinSize);
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 
-	WinEnd = (pTS->rx_indicate_seq + WinSize - 1) % 4096;
+	WinEnd = (ts->rx_indicate_seq + WinSize - 1) % 4096;
 	/* Rx Reorder initialize condition.*/
-	if (pTS->rx_indicate_seq == 0xffff)
-		pTS->rx_indicate_seq = SeqNum;
+	if (ts->rx_indicate_seq == 0xffff)
+		ts->rx_indicate_seq = SeqNum;
 
 	/* Drop out the packet which SeqNum is smaller than WinStart */
-	if (SN_LESS(SeqNum, pTS->rx_indicate_seq)) {
+	if (SN_LESS(SeqNum, ts->rx_indicate_seq)) {
 		netdev_dbg(ieee->dev,
 			   "Packet Drop! IndicateSeq: %d, NewSeq: %d\n",
-			   pTS->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, SeqNum);
 		ht_info->rx_reorder_drop_counter++;
 		{
 			int i;
@@ -597,18 +597,18 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	 * 1. Incoming SeqNum is equal to WinStart =>Window shift 1
 	 * 2. Incoming SeqNum is larger than the WinEnd => Window shift N
 	 */
-	if (SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
-		pTS->rx_indicate_seq = (pTS->rx_indicate_seq + 1) % 4096;
+	if (SN_EQUAL(SeqNum, ts->rx_indicate_seq)) {
+		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart = true;
 	} else if (SN_LESS(WinEnd, SeqNum)) {
 		if (SeqNum >= (WinSize - 1))
-			pTS->rx_indicate_seq = SeqNum + 1 - WinSize;
+			ts->rx_indicate_seq = SeqNum + 1 - WinSize;
 		else
-			pTS->rx_indicate_seq = 4095 -
+			ts->rx_indicate_seq = 4095 -
 					     (WinSize - (SeqNum + 1)) + 1;
 		netdev_dbg(ieee->dev,
 			   "Window Shift! IndicateSeq: %d, NewSeq: %d\n",
-			   pTS->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, SeqNum);
 	}
 
 	/* Indication process.
@@ -625,7 +625,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		/* Current packet is going to be indicated.*/
 		netdev_dbg(ieee->dev,
 			   "Packets indication! IndicateSeq: %d, NewSeq: %d\n",
-			   pTS->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, SeqNum);
 		ieee->prxbIndicateArray[0] = prxb;
 		index = 1;
 	} else {
@@ -642,12 +642,12 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 			pReorderEntry->SeqNum = SeqNum;
 			pReorderEntry->prxb = prxb;
 
-			if (!AddReorderEntry(pTS, pReorderEntry)) {
+			if (!AddReorderEntry(ts, pReorderEntry)) {
 				int i;
 
 				netdev_dbg(ieee->dev,
 					   "%s(): Duplicate packet is dropped. IndicateSeq: %d, NewSeq: %d\n",
-					   __func__, pTS->rx_indicate_seq,
+					   __func__, ts->rx_indicate_seq,
 					   SeqNum);
 				list_add_tail(&pReorderEntry->List,
 					      &ieee->RxReorder_Unused_List);
@@ -659,7 +659,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 			} else {
 				netdev_dbg(ieee->dev,
 					   "Pkt insert into struct buffer. IndicateSeq: %d, NewSeq: %d\n",
-					   pTS->rx_indicate_seq, SeqNum);
+					   ts->rx_indicate_seq, SeqNum);
 			}
 		} else {
 			/* Packets are dropped if there are not enough reorder
@@ -682,16 +682,16 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	}
 
 	/* Check if there is any packet need indicate.*/
-	while (!list_empty(&pTS->rx_pending_pkt_list)) {
+	while (!list_empty(&ts->rx_pending_pkt_list)) {
 		netdev_dbg(ieee->dev, "%s(): start RREORDER indicate\n",
 			   __func__);
 
 		pReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pTS->rx_pending_pkt_list.prev,
+					list_entry(ts->rx_pending_pkt_list.prev,
 						   struct rx_reorder_entry,
 						   List);
-		if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
-		    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq)) {
+		if (SN_LESS(pReorderEntry->SeqNum, ts->rx_indicate_seq) ||
+		    SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq)) {
 			/* This protect struct buffer from overflow. */
 			if (index >= REORDER_WIN_SIZE) {
 				netdev_err(ieee->dev,
@@ -703,8 +703,8 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 
 			list_del_init(&pReorderEntry->List);
 
-			if (SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
-				pTS->rx_indicate_seq = (pTS->rx_indicate_seq + 1) %
+			if (SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq))
+				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
 						     4096;
 
 			ieee->prxbIndicateArray[index] = pReorderEntry->prxb;
@@ -724,9 +724,9 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 	 * Rx buffering.
 	 */
 	if (index > 0) {
-		if (timer_pending(&pTS->rx_pkt_pending_timer))
-			del_timer_sync(&pTS->rx_pkt_pending_timer);
-		pTS->rx_timeout_indicate_seq = 0xffff;
+		if (timer_pending(&ts->rx_pkt_pending_timer))
+			del_timer_sync(&ts->rx_pkt_pending_timer);
+		ts->rx_timeout_indicate_seq = 0xffff;
 
 		if (index > REORDER_WIN_SIZE) {
 			netdev_err(ieee->dev,
@@ -740,10 +740,10 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		bPktInBuf = false;
 	}
 
-	if (bPktInBuf && pTS->rx_timeout_indicate_seq == 0xffff) {
+	if (bPktInBuf && ts->rx_timeout_indicate_seq == 0xffff) {
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
-		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
-		mod_timer(&pTS->rx_pkt_pending_timer, jiffies +
+		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
+		mod_timer(&ts->rx_pkt_pending_timer, jiffies +
 			  msecs_to_jiffies(ht_info->rx_reorder_pending_time));
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
-- 
2.41.0

