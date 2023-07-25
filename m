Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB9760A66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGYGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGYGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:36:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796691BDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:36:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF7241896C4;
        Tue, 25 Jul 2023 02:36:55 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        4ifpopfsPEbuguZHPOneJiNiH/D5ZRPZeKyy8QviyPA=; b=EF0osaC0Cl0qhYKD
        7FaWNNMuWjTU3iSIrEFnv4CPghfiMid2dHTIG3Uv4yRQpprEKbVW2Fswu/fiIMTB
        dDopSi5ER9HfPiQxDaVKja7Ol4dy0Tai6FRew6DqWtU/LcqvT+Q5TQUUtSb/5jzg
        yO8gj11GKpx/hnSb/moCbJnf9FU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C75A71896C3;
        Tue, 25 Jul 2023 02:36:55 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=4ifpopfsPEbuguZHPOneJiNiH/D5ZRPZeKyy8QviyPA=;
 b=fx7UH30dcEa+7G9DdAqslpwervs0CBRYjGOqQAaqYTLp4QWdxB5m89CdOFeBJ7hB732UvUUaK1927iddlbt5RfizoNudExs5IW2+AUMA4hDoGH82GXuFnjpkGwmldZ44lqhyS/+Tqsl1npBRhPeR/Is70SDn2A7axow97Ae44VY=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11BDC1896C2;
        Tue, 25 Jul 2023 02:36:53 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 24 Jul 2023 23:38:18 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Staging: rtl8192e: Rename function ResetBaEntry
Message-ID: <ZL9t2idD6wqni7Pf@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: A557BF32-2AB5-11EE-A909-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function ResetBaEntry to reset_ba_entry in order to Fix checkpatch
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 9662d75257ce..cb6450206763 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -54,7 +54,7 @@ static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *pRxTs
 	return bSendDELBA;
 }
 
-void ResetBaEntry(struct ba_record *pBA)
+void reset_ba_entry(struct ba_record *pBA)
 {
 	pBA->b_valid			  = false;
 	pBA->ba_param_set.short_data	  = 0;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index c61fdf73c572..21ffbb6b231f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -117,8 +117,8 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
 	pTS->bDisable_AddBa = false;
-	ResetBaEntry(&pTS->TxAdmittedBARecord);
-	ResetBaEntry(&pTS->TxPendingBARecord);
+	reset_ba_entry(&pTS->TxAdmittedBARecord);
+	reset_ba_entry(&pTS->TxPendingBARecord);
 }
 
 static void ResetRxTsEntry(struct rx_ts_record *pTS)
@@ -126,7 +126,7 @@ static void ResetRxTsEntry(struct rx_ts_record *pTS)
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->rx_indicate_seq = 0xffff;
 	pTS->rx_timeout_indicate_seq = 0xffff;
-	ResetBaEntry(&pTS->rx_admitted_ba_record);
+	reset_ba_entry(&pTS->rx_admitted_ba_record);
 }
 
 void TSInitialize(struct rtllib_device *ieee)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..ccc9e7bbbcbb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2016,7 +2016,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
-void ResetBaEntry(struct ba_record *pBA);
+void reset_ba_entry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *Addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
 void TSInitialize(struct rtllib_device *ieee);
-- 
2.41.0

