Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E595760A65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGYGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGYGgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:36:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ADF1A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:36:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0634A1896C1;
        Tue, 25 Jul 2023 02:36:42 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        sWuZ1xA3Q1ipdadY/YTup/fAvLBuKcZgiH7KwkT64/4=; b=rrAFVkbCJUGI+KwO
        FT1aGRBBkK9hKn4x8m75LlUY+88/KMg17fI1hhhKRTF+O78QayX3TtRgLyAaTIS1
        KcJvySaHp0B6TL9IV9j71M0W6ISFS9IcKekHE7v/Vmkv76t63R3BqmrTSvmRVABu
        +Yx+VaAbTs3WPYU1OpIZGdrZpKE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F32331896C0;
        Tue, 25 Jul 2023 02:36:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=sWuZ1xA3Q1ipdadY/YTup/fAvLBuKcZgiH7KwkT64/4=;
 b=mk6djttUWXfjn2oVp3RQHSAzgTXLbCbpvS52Y/aWW6Eq5YlKYk0bL4/Lz/FIvADLoxDhvwHcYnzV2uQqZV1gNmFoQ8tTqy+9osRzsKLB2M7OF1grWFO0IureC+tKOHQ9UrwgYfNwbt6jX/CdmqYT6S0HUdeL1YY9L3z7AVtX0oM=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F6BE1896BF;
        Tue, 25 Jul 2023 02:36:40 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 24 Jul 2023 23:38:04 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Staging: rtl8192e: Rename function RxTsDeleteBA
Message-ID: <ZL9tzJWRPwRM0/n/@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 9D43FA9A-2AB5-11EE-93E3-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function RxTsDeleteBA to rx_ts_delete_ba in order to Fix checkpatch
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 6538343ea44d..9662d75257ce 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -41,7 +41,7 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 	return bSendDELBA;
 }
 
-static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
+static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
 {
 	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 			return -1;
 		}
 
-		RxTsDeleteBA(ieee, pRxTs);
+		rx_ts_delete_ba(ieee, pRxTs);
 	} else {
 		struct tx_ts_record *pTxTs;
 
@@ -501,7 +501,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 	} else if (TxRxSelect == RX_DIR) {
 		struct rx_ts_record *pRxTs =
 				 (struct rx_ts_record *)pTsCommonInfo;
-		if (RxTsDeleteBA(ieee, pRxTs))
+		if (rx_ts_delete_ba(ieee, pRxTs))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
 					  &pRxTs->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
@@ -537,7 +537,7 @@ void RxBaInactTimeout(struct timer_list *t)
 	struct rtllib_device *ieee = container_of(pRxTs, struct rtllib_device,
 				     RxTsRecord[pRxTs->num]);
 
-	RxTsDeleteBA(ieee, pRxTs);
+	rx_ts_delete_ba(ieee, pRxTs);
 	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
 			  &pRxTs->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
-- 
2.41.0

