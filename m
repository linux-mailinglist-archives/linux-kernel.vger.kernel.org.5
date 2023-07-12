Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E289751490
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjGLXiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGLXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F702123
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:37:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A438B36163;
        Wed, 12 Jul 2023 19:37:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        y9SL3xoxRsp2eOwbXnDO+kFjxFaDKvJEYhk5RH7SnRk=; b=jnFTyCtDyBWvoRN0
        weOazzAA/yd0G2jaeQ0Zoai/WMMfP0RWV82Y+DPwqbO2Yd3jFy/sHG1Bu+s5Q/I6
        hBN8xp0xdd9MeSDoX9/CUPBSn7BjJoK9QKe9fQaHTX66x1Mqxz2HuV/MrKnzU3YV
        AbXSUveQWJEUMfk/ZcIszzcyjPY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CC3336162;
        Wed, 12 Jul 2023 19:37:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=y9SL3xoxRsp2eOwbXnDO+kFjxFaDKvJEYhk5RH7SnRk=;
 b=IiRhfhaeE8ky5Ib2UjEPBENg0mMPKhpabqwqM1MhXPiUXLfHKW/zFHspMM+0KtYd4AmnWAhgQj8/uGFPEYnB0n3cMCELr8oiXLwLz/IAiGtoZHzc1zozAvpp7YVumKhbWKF3TxCwojML10ZyKpkjhx8Z5K/s8DYcUqybJf02OoE=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD6E73615F;
        Wed, 12 Jul 2023 19:37:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:38:28 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] Staging: rtl8192e: Rename variable TxAdmittedBARecord
Message-ID: <ZK85dJrdLb30xsKe@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 1706167C-210D-11EE-966E-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TxAdmittedBARecord to tx_admitted_ba_record
in order to fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c      |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bb9705222bc7..a58df1d94585 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -25,7 +25,7 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pb
 
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *ptx_ts)
 {
-	struct ba_record *padmitted_ba = &ptx_ts->TxAdmittedBARecord;
+	struct ba_record *padmitted_ba = &ptx_ts->tx_admitted_ba_record;
 	struct ba_record *pPendingBa = &ptx_ts->TxPendingBARecord;
 	u8 bSendDELBA = false;
 
@@ -346,7 +346,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	pTS->bAddBaReqInProgress = false;
 	pPendingBA = &pTS->TxPendingBARecord;
-	pAdmittedBA = &pTS->TxAdmittedBARecord;
+	pAdmittedBA = &pTS->tx_admitted_ba_record;
 
 	if (pAdmittedBA->b_valid) {
 		netdev_dbg(ieee->dev, "%s(): ADDBA response already admitted\n",
@@ -494,8 +494,8 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 
 		if (tx_ts_delete_ba(ieee, ptx_ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
-					  (ptx_ts->TxAdmittedBARecord.b_valid) ?
-					 (&ptx_ts->TxAdmittedBARecord) :
+					  (ptx_ts->tx_admitted_ba_record.b_valid) ?
+					 (&ptx_ts->tx_admitted_ba_record) :
 					(&ptx_ts->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
@@ -521,12 +521,12 @@ void ba_setup_time_out(struct timer_list *t)
 void tx_ba_inact_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *ptx_ts = from_timer(ptx_ts, t,
-					      TxAdmittedBARecord.timer);
+					      tx_admitted_ba_record.timer);
 	struct rtllib_device *ieee = container_of(ptx_ts, struct rtllib_device,
 				     TxTsRecord[ptx_ts->num]);
 	tx_ts_delete_ba(ieee, ptx_ts);
 	rtllib_send_DELBA(ieee, ptx_ts->TsCommonInfo.Addr,
-			  &ptx_ts->TxAdmittedBARecord, TX_DIR,
+			  &ptx_ts->tx_admitted_ba_record, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 37760d0bc35d..653ca479a00c 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -32,7 +32,7 @@ struct tx_ts_record {
 	struct ts_common_info TsCommonInfo;
 	u16				TxCurSeq;
 	struct ba_record TxPendingBARecord;
-	struct ba_record TxAdmittedBARecord;
+	struct ba_record tx_admitted_ba_record;
 	u8				bAddBaReqInProgress;
 	u8				bAddBaReqDelayed;
 	u8				bUsingBa;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 35c4083542fc..696cc0905546 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -117,7 +117,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
 	pTS->bDisable_AddBa = false;
-	ResetBaEntry(&pTS->TxAdmittedBARecord);
+	ResetBaEntry(&pTS->tx_admitted_ba_record);
 	ResetBaEntry(&pTS->TxPendingBARecord);
 }
 
@@ -152,7 +152,7 @@ void TSInitialize(struct rtllib_device *ieee)
 
 		timer_setup(&pTxTS->TxPendingBARecord.timer, ba_setup_time_out,
 			    0);
-		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
+		timer_setup(&pTxTS->tx_admitted_ba_record.timer,
 			    tx_ba_inact_timeout, 0);
 
 		ResetTxTsEntry(pTxTS);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index e43a9b26e01a..dad176b1a211 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -294,7 +294,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
-		if (!ptx_ts->TxAdmittedBARecord.b_valid) {
+		if (!ptx_ts->tx_admitted_ba_record.b_valid) {
 			if (ieee->wpa_ie_len && (ieee->pairwise_key_type ==
 			    KEY_TYPE_NA)) {
 				;
@@ -305,7 +305,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			}
 			goto FORCED_AGG_SETTING;
 		} else if (!ptx_ts->bUsingBa) {
-			if (SN_LESS(ptx_ts->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
+			if (SN_LESS(ptx_ts->tx_admitted_ba_record.ba_start_seq_ctrl.field.seq_num,
 				    (ptx_ts->TxCurSeq + 1) % 4096))
 				ptx_ts->bUsingBa = true;
 			else
-- 
2.41.0

