Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E769F760A63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGYGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjGYGgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:36:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4551E42
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:36:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BBBD194B7;
        Tue, 25 Jul 2023 02:36:21 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        D2uTiRvsYq9z5a7T8+noJIXCfFk6b6rip0io+qs3BW8=; b=jPUn4uL4ytRB4SEC
        QBssYo8EgHgcVWpQNuH2LeOAV8T1xk3KF7koXZJhzqYkEv7+O4TrA1kS4pJ+q46Z
        a5X+Ayzr12hl6YPs1dXGrmNcHVZo6s42AJBQMaqHyDrL6UpRo1MkHufHbrJ2uzC2
        whxXFtWnGkzG/LJvXIBON+NFSkI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34A69194B6;
        Tue, 25 Jul 2023 02:36:21 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=D2uTiRvsYq9z5a7T8+noJIXCfFk6b6rip0io+qs3BW8=;
 b=Lgot7Fmg2iGEWoOBrFLwDDQY+cjNcWZTCbigk76quhP9lqjF0u5MHRAWoutxksIEwzmIrML+GqAU+9TfBW1eU1xIuJ2fDh21Km+kjdWTnNWirbqqhfVRJymGhh5JVY5sj+J4blHbWSb+vWdBAnnQDZ8gPg2GOYONGXrAUNpD5KA=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 132DA194B5;
        Tue, 25 Jul 2023 02:36:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 24 Jul 2023 23:37:39 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Staging: rtl8192e: Rename function DeActivateBAEntry
Message-ID: <ZL9tsxIkogwp825i@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 8E6BF63A-2AB5-11EE-9B43-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function DeActivateBAEntry to deactivate_ba_entry in order to Fix
checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 965ffa8b78c2..50362bbbc8dd 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -17,7 +17,7 @@ static void activate_ba_entry(struct ba_record *pBA, u16 Time)
 		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
 }
 
-static void DeActivateBAEntry(struct rtllib_device *ieee, struct ba_record *pBA)
+static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pBA)
 {
 	pBA->b_valid = false;
 	del_timer_sync(&pBA->timer);
@@ -30,12 +30,12 @@ static u8 TxTsDeleteBA(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
 	u8 bSendDELBA = false;
 
 	if (pPendingBa->b_valid) {
-		DeActivateBAEntry(ieee, pPendingBa);
+		deactivate_ba_entry(ieee, pPendingBa);
 		bSendDELBA = true;
 	}
 
 	if (pAdmittedBa->b_valid) {
-		DeActivateBAEntry(ieee, pAdmittedBa);
+		deactivate_ba_entry(ieee, pAdmittedBa);
 		bSendDELBA = true;
 	}
 	return bSendDELBA;
@@ -47,7 +47,7 @@ static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 	u8			bSendDELBA = false;
 
 	if (pBa->b_valid) {
-		DeActivateBAEntry(ieee, pBa);
+		deactivate_ba_entry(ieee, pBa);
 		bSendDELBA = true;
 	}
 
@@ -270,7 +270,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	rtllib_FlushRxTsPendingPkts(ieee, pTS);
 
-	DeActivateBAEntry(ieee, pBA);
+	deactivate_ba_entry(ieee, pBA);
 	pBA->dialog_token = *pDialogToken;
 	pBA->ba_param_set = *pBaParamSet;
 	pBA->ba_timeout_value = *pBaTimeoutVal;
@@ -363,13 +363,13 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
 			   __func__, *pStatusCode);
-		DeActivateBAEntry(ieee, pPendingBA);
+		deactivate_ba_entry(ieee, pPendingBA);
 	}
 
 	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy == BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed = true;
-			DeActivateBAEntry(ieee, pAdmittedBA);
+			deactivate_ba_entry(ieee, pAdmittedBA);
 			ReasonCode = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
 		}
@@ -378,7 +378,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->ba_timeout_value = *pBaTimeoutVal;
 		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *pBaParamSet;
-		DeActivateBAEntry(ieee, pAdmittedBA);
+		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		pTS->bAddBaReqDelayed = true;
@@ -469,7 +469,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	if (pBA->b_valid && !bOverwritePending)
 		return;
 
-	DeActivateBAEntry(ieee, pBA);
+	deactivate_ba_entry(ieee, pBA);
 
 	pBA->dialog_token++;
 	pBA->ba_param_set.field.amsdu_support = 0;
-- 
2.41.0

