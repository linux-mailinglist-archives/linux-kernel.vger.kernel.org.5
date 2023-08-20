Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4B781C0C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHTCep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHTCe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:34:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8D7D826
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a41031768so29130b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492330; x=1693097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiaXJj0k6MyiMU1PMvQA9CUDFVjljfiUN/JbuRuq1Dc=;
        b=XrrVCuhGYWjrB+tArkHmMKlhX3yFQgOaO10yJ1N4hrDYCNB4Ahik8qUUwyAjZnk3FB
         JXZClb8QVucU3/i+EyOlqGvSScjG1Y+uT996Q0KAFMHRzfVeaNLdzLyiUNFOG5I3lklJ
         wJcQaztVayFWYDforkCS7K9azvPgMd47FVHN/QU7eS5fsPHlwB/qwx5aRw9h9ujuaH6N
         F7mb00ev/4DqkAeTE3tL5tuMC8e/Mr5HAl4Say136U8fcLkK2XO+w2y79oK3SfGXucoq
         TXQje2n+0CpATVDymQA8AdqQ16poUSQe1VFCKD80eHPF8rlRrLpjhCvU1JmdHH4s9enV
         1jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492330; x=1693097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiaXJj0k6MyiMU1PMvQA9CUDFVjljfiUN/JbuRuq1Dc=;
        b=DOD6veROCxsaqsPHhJ+N1rXbkUC9+e99LL6UyA0f4b1GE2pdVrOwybex3/C0JexZCY
         qVNki58xGp6yPb6eNiiuiR9+8VO3EYFSPiXq7FeIJ6SeGGieOCfIXWO+pNvNKu+BkZqp
         X2XXWuiZUEAa2RS1VnUvbJEA4xPivUHmwFbQLw4Y5RCywOO+nklSzxx9O94x/1i/FWW4
         vl/5ol6GC2FKtq7ERp2UrxlAWrlcVw1m9Mbq/+UXsOb9pnw0j/aYpmoWEgZyMkSK4a5x
         +Z435aIPm/tzx33aMux2IcSaoPg4ffEhTq3BpcPQKgimuAZCHH47QwQA/V6tEcoGae8r
         laNg==
X-Gm-Message-State: AOJu0Yyj8ykQM05RPFQ3LEGcP66Hsr0Ya7lCkhZ0wkoz5Th28P/IX3V0
        PAnWvcxKrDqHI7stm69oA0UlJQ==
X-Google-Smtp-Source: AGHT+IGpuviT5f8bchhEBp6jh9HTym40Wa4W/rjV4hopJ4v4FzdD3oR612xeEYuTNRu+ljEkKoCjcA==
X-Received: by 2002:a17:90a:4963:b0:269:86ce:c3b5 with SMTP id c90-20020a17090a496300b0026986cec3b5mr1601170pjh.44.1692492329731;
        Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/16] Staging: rtl8192e: Rename variable pTS in function RxReorderIndicatePacket()
Date:   Sat, 19 Aug 2023 17:47:42 -0700
Message-ID: <20230820004744.278022-15-tdavies@darkphysics.net>
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

Rename variable pTS in function RxReorderIndicatePacket() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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

