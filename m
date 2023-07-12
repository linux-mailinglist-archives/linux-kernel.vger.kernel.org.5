Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E46751489
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGLXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGLXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:34:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE431BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:34:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 866D51A34E1;
        Wed, 12 Jul 2023 19:34:23 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        Aqiqad5r3+BuF106GVlTjb3d7vKYLXmApbjAv2GjMvQ=; b=xx0Z4lipTuEdFg06
        M3ekhqBJT/2B7QR9J/MMhXeO22Oy40VQvIAtKyNiN3d+PyWvUkhQoRrbBriV58En
        Bmrfon/U2m5uHYbWIufYafSse2DV+ubCJCpXMCKCA8i1dZvNIhN+cHz7CqFjxpVe
        XHvNul5icjZF2i0grsWdZWZG2Cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E9D91A34E0;
        Wed, 12 Jul 2023 19:34:23 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=Aqiqad5r3+BuF106GVlTjb3d7vKYLXmApbjAv2GjMvQ=;
 b=UiTBPwR/Y6jnedaZ8aL4EkRBsNJoVEl73B8p/1dTFOOGT5P+YDs9483xZ2W0XkHKgGEeJHqPGs7VcwyxxtxHME4cWaUb98T6BkxdGgIna0Webse+gA49KPONAJjcjwFHIDB1VmONy3iQLIZJ1+D0RlqZrWa2pdjmhs7tjs+Mrso=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC4F91A34DF;
        Wed, 12 Jul 2023 19:34:21 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:35:13 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] Staging: rtl8192e: Rename variable pBA
Message-ID: <ZK84sYjc9uHIWZcr@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: A152D0BE-210C-11EE-9AE8-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pBA to pba in order to Fix checkpatch
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 106 +++++++++++-----------
 drivers/staging/rtl8192e/rtllib.h         |   2 +-
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 6b5da38353ee..43ee1bd4a6ed 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -10,17 +10,17 @@
 #include "rtllib.h"
 #include "rtl819x_BA.h"
 
-static void activate_ba_entry(struct ba_record *pBA, u16 Time)
+static void activate_ba_entry(struct ba_record *pba, u16 Time)
 {
-	pBA->b_valid = true;
+	pba->b_valid = true;
 	if (Time != 0)
-		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
+		mod_timer(&pba->timer, jiffies + msecs_to_jiffies(Time));
 }
 
-static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pBA)
+static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pba)
 {
-	pBA->b_valid = false;
-	del_timer_sync(&pBA->timer);
+	pba->b_valid = false;
+	del_timer_sync(&pba->timer);
 }
 
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
@@ -43,28 +43,28 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 
 static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 {
-	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
+	struct ba_record *pba = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
-	if (pBa->b_valid) {
-		deactivate_ba_entry(ieee, pBa);
+	if (pba->b_valid) {
+		deactivate_ba_entry(ieee, pba);
 		bSendDELBA = true;
 	}
 
 	return bSendDELBA;
 }
 
-void ResetBaEntry(struct ba_record *pBA)
+void ResetBaEntry(struct ba_record *pba)
 {
-	pBA->b_valid			  = false;
-	pBA->ba_param_set.short_data	  = 0;
-	pBA->ba_timeout_value		  = 0;
-	pBA->dialog_token		  = 0;
-	pBA->ba_start_seq_ctrl.short_data = 0;
+	pba->b_valid			  = false;
+	pba->ba_param_set.short_data	  = 0;
+	pba->ba_timeout_value		  = 0;
+	pba->dialog_token		  = 0;
+	pba->ba_start_seq_ctrl.short_data = 0;
 }
 
 static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
-				    struct ba_record *pBA,
+				    struct ba_record *pba,
 				    u16 StatusCode, u8 type)
 {
 	struct sk_buff *skb = NULL;
@@ -75,8 +75,8 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	netdev_dbg(ieee->dev, "%s(): frame(%d) sentd to: %pM, ieee->dev:%p\n",
 		   __func__, type, Dst, ieee->dev);
 
-	if (!pBA) {
-		netdev_warn(ieee->dev, "pBA is NULL\n");
+	if (!pba) {
+		netdev_warn(ieee->dev, "pba is NULL\n");
 		return NULL;
 	}
 	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
@@ -98,21 +98,21 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	tag = skb_put(skb, 9);
 	*tag++ = ACT_CAT_BA;
 	*tag++ = type;
-	*tag++ = pBA->dialog_token;
+	*tag++ = pba->dialog_token;
 
 	if (type == ACT_ADDBARSP) {
 		put_unaligned_le16(StatusCode, tag);
 		tag += 2;
 	}
 
-	put_unaligned_le16(pBA->ba_param_set.short_data, tag);
+	put_unaligned_le16(pba->ba_param_set.short_data, tag);
 	tag += 2;
 
-	put_unaligned_le16(pBA->ba_timeout_value, tag);
+	put_unaligned_le16(pba->ba_timeout_value, tag);
 	tag += 2;
 
 	if (type == ACT_ADDBAREQ) {
-		memcpy(tag, (u8 *)&pBA->ba_start_seq_ctrl, 2);
+		memcpy(tag, (u8 *)&pba->ba_start_seq_ctrl, 2);
 		tag += 2;
 	}
 
@@ -124,7 +124,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 }
 
 static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
-				    struct ba_record *pBA,
+				    struct ba_record *pba,
 				    enum tr_select TxRxSelect, u16 ReasonCode)
 {
 	union delba_param_set DelbaParamSet;
@@ -140,7 +140,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	memset(&DelbaParamSet, 0, 2);
 
 	DelbaParamSet.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
-	DelbaParamSet.field.tid	= pBA->ba_param_set.field.tid;
+	DelbaParamSet.field.tid	= pba->ba_param_set.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct rtllib_hdr_3addr));
 	if (!skb)
@@ -174,11 +174,11 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *pBA)
+				 struct ba_record *pba)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ);
+	skb = rtllib_ADDBA(ieee, dst, pba, 0, ACT_ADDBAREQ);
 
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
@@ -187,11 +187,11 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *pBA, u16 StatusCode)
+				 struct ba_record *pba, u16 StatusCode)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP);
+	skb = rtllib_ADDBA(ieee, dst, pba, StatusCode, ACT_ADDBARSP);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
@@ -199,12 +199,12 @@ static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
-			      struct ba_record *pBA, enum tr_select TxRxSelect,
+			      struct ba_record *pba, enum tr_select TxRxSelect,
 			      u16 ReasonCode)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_DELBA(ieee, dst, pBA, TxRxSelect, ReasonCode);
+	skb = rtllib_DELBA(ieee, dst, pba, TxRxSelect, ReasonCode);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
@@ -216,7 +216,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	struct rtllib_hdr_3addr *req = NULL;
 	u16 rc = 0;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
-	struct ba_record *pBA = NULL;
+	struct ba_record *pba = NULL;
 	union ba_param_set *pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	union sequence_control *pBaStartSeqCtrl = NULL;
@@ -259,7 +259,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA = &pTS->rx_admitted_ba_record;
+	pba = &pTS->rx_admitted_ba_record;
 
 	if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 		rc = ADDBA_STATUS_INVALID_PARAM;
@@ -270,20 +270,20 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	rtllib_FlushRxTsPendingPkts(ieee, pTS);
 
-	deactivate_ba_entry(ieee, pBA);
-	pBA->dialog_token = *pDialogToken;
-	pBA->ba_param_set = *pBaParamSet;
-	pBA->ba_timeout_value = *pBaTimeoutVal;
-	pBA->ba_start_seq_ctrl = *pBaStartSeqCtrl;
+	deactivate_ba_entry(ieee, pba);
+	pba->dialog_token = *pDialogToken;
+	pba->ba_param_set = *pBaParamSet;
+	pba->ba_timeout_value = *pBaTimeoutVal;
+	pba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
 	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
-		pBA->ba_param_set.field.buffer_size = 1;
+		pba->ba_param_set.field.buffer_size = 1;
 	else
-		pBA->ba_param_set.field.buffer_size = 32;
+		pba->ba_param_set.field.buffer_size = 32;
 
-	activate_ba_entry(pBA, 0);
-	rtllib_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
+	activate_ba_entry(pba, 0);
+	rtllib_send_ADDBARsp(ieee, dst, pba, ADDBA_STATUS_SUCCESS);
 
 	return 0;
 
@@ -464,24 +464,24 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 		 u8 Policy, u8	bOverwritePending)
 {
-	struct ba_record *pBA = &pTS->TxPendingBARecord;
+	struct ba_record *pba = &pTS->TxPendingBARecord;
 
-	if (pBA->b_valid && !bOverwritePending)
+	if (pba->b_valid && !bOverwritePending)
 		return;
 
-	deactivate_ba_entry(ieee, pBA);
+	deactivate_ba_entry(ieee, pba);
 
-	pBA->dialog_token++;
-	pBA->ba_param_set.field.amsdu_support = 0;
-	pBA->ba_param_set.field.ba_policy = Policy;
-	pBA->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
-	pBA->ba_param_set.field.buffer_size = 32;
-	pBA->ba_timeout_value = 0;
-	pBA->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
+	pba->dialog_token++;
+	pba->ba_param_set.field.amsdu_support = 0;
+	pba->ba_param_set.field.ba_policy = Policy;
+	pba->ba_param_set.field.tid = pTS->TsCommonInfo.TSpec.f.TSInfo.field.ucTSID;
+	pba->ba_param_set.field.buffer_size = 32;
+	pba->ba_timeout_value = 0;
+	pba->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
 
-	activate_ba_entry(pBA, BA_SETUP_TIMEOUT);
+	activate_ba_entry(pba, BA_SETUP_TIMEOUT);
 
-	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
+	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pba);
 }
 
 void ts_init_del_ba(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0f84ee1d418e..8f0e9dbe5b7a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2016,7 +2016,7 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 void ba_setup_time_out(struct timer_list *t);
 void tx_ba_inact_timeout(struct timer_list *t);
 void rx_ba_inact_timeout(struct timer_list *t);
-void ResetBaEntry(struct ba_record *pBA);
+void ResetBaEntry(struct ba_record *pba);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *Addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
 void TSInitialize(struct rtllib_device *ieee);
-- 
2.41.0

