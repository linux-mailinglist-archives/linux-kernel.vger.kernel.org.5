Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260D751476
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGLX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLX3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:29:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E3170E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:29:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 083C2316E1;
        Wed, 12 Jul 2023 19:29:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        HY1Rm7fpxTqb2jYNDCWoqzPm4QE4JHw4AH7Vp0SsMFQ=; b=gCaDoqy6clatyG5E
        YHd44Pj2BfijQ1+lgocSFvqOYl8Q7Et7SaGIQmvqMKNgVMhv8jtrMuz3EQjaVONw
        ievLFghoNx1UjT+/S13NwTvG+R+3Wqhs+odVbCcLbT5CTKtR1zkr9X65alyJg66+
        l5fq3TGxktkS1ZCu7sYnCq/SejA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00AFA316E0;
        Wed, 12 Jul 2023 19:29:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=HY1Rm7fpxTqb2jYNDCWoqzPm4QE4JHw4AH7Vp0SsMFQ=;
 b=f+8rkmd+/D3p2P7h4JqFuDoAu1acbp0Ohy0/SWOkiWU8ZmnFdrNEQGVNDdJoag49PBtefnwmKmkFxIKc/R0K675VrwGVK+m/ODqYb2Lhp93ss05J1/FIguGQLMKf+yCvVhSlLde2gSSy8pn7E5ZMKT+y8xtVsrM9EWS1uqpn9M0=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5ADD0316DF;
        Wed, 12 Jul 2023 19:29:35 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:30:26 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] Staging: rtl8192e: Rename function TsInitDelBA
Message-ID: <ZK83kk5tQWqdTvXz@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: F63CD6A2-210B-11EE-ADE0-C2DA088D43B2-45285927!pb-smtp20.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TsInitDelBA to ts_init_del_ba
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2e37f1e949ec..9a32528fe314 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -484,7 +484,7 @@ void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
 }
 
-void TsInitDelBA(struct rtllib_device *ieee,
+void ts_init_del_ba(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
 		 enum tr_select TxRxSelect)
 {
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7841d9ce1a7f..8005f7462aca 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -396,7 +396,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 {
 	del_timer_sync(&pTs->SetupTimer);
 	del_timer_sync(&pTs->InactTimer);
-	TsInitDelBA(ieee, pTs, TxRxSelect);
+	ts_init_del_ba(ieee, pTs, TxRxSelect);
 
 	if (TxRxSelect == RX_DIR) {
 		struct rx_reorder_entry *pRxReorderEntry;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index de0dd48d0646..42a9b1dafc27 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2010,7 +2010,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 		 u8 Policy, u8 bOverwritePending);
-void TsInitDelBA(struct rtllib_device *ieee,
+void ts_init_del_ba(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
 		 enum tr_select TxRxSelect);
 void BaSetupTimeOut(struct timer_list *t);
-- 
2.41.0

