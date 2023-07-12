Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2095275147D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGLXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLXcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:32:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E2E5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:32:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 956501B7F9B;
        Wed, 12 Jul 2023 19:32:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        k4Rg3JScZZGbHu0KzWz4UIDzTNedP5Uso0IXHkeikgY=; b=rzQLk+IE6dlRwBIB
        4SxDwD4+/KTQv0l1NyfKKZgH4WB4dA4gGMQiuHO61P21N2WwcG/BZdLVN7/fnR+I
        xruLA2JSwdRIjhTy2MQjFCAp1N//Q7aud/zQFnoepA2T73+CPG3nd5DQoESeH3v5
        Hxs3TmwJiCwiLXddpK3yYz5PEXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CE551B7F9A;
        Wed, 12 Jul 2023 19:32:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=k4Rg3JScZZGbHu0KzWz4UIDzTNedP5Uso0IXHkeikgY=;
 b=F1Pvuo7eX1uoGsTIifdmrhDJsNmlrvRkT0+/etQ5QKInCq5t0h/mGKA/ylbZRd2bXjIkI5vNRuvn6pnpfg+B7Bm5K4rNz6s8vaD/9tAwyz0n3ttUXwB/6FAt4bgKBEpV8iVZb4GJq+FCLZa9LcMKFVta1zKm79Nnkt8SjwmT/cE=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A2F31B7F99;
        Wed, 12 Jul 2023 19:32:15 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:33:06 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] Staging: rtl8192e: Rename function TxBaInactTimeout
Message-ID: <ZK84Mvdkjcfw71vw@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 55DF614C-210C-11EE-8F96-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TxBaInactTimeout to tx_ba_inact_timeout
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 941b3f47710e..675f3ba15a7a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -518,7 +518,7 @@ void ba_setup_time_out(struct timer_list *t)
 	pTxTs->TxPendingBARecord.b_valid = false;
 }
 
-void TxBaInactTimeout(struct timer_list *t)
+void tx_ba_inact_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
 					      TxAdmittedBARecord.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 087082cdcee6..7f0340dd764d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -153,7 +153,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		timer_setup(&pTxTS->TxPendingBARecord.timer, ba_setup_time_out,
 			    0);
 		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
-			    TxBaInactTimeout, 0);
+			    tx_ba_inact_timeout, 0);
 
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->TsCommonInfo.List,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index face43ee8a2b..4f55dcf42bc7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2014,7 +2014,7 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
 		 enum tr_select TxRxSelect);
 void ba_setup_time_out(struct timer_list *t);
-void TxBaInactTimeout(struct timer_list *t);
+void tx_ba_inact_timeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
 void ResetBaEntry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *Addr,
-- 
2.41.0

