Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0375146B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGLX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGLX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:28:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02955E5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:28:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 481DA1A32BB;
        Wed, 12 Jul 2023 19:27:59 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        m6menqUncA4a2eg0m4MFOVZboBdtfZm1e6YBGnLHfFA=; b=wPXHzVDa8p8qyZoL
        xKUW2WXd5OK1vO2OJsZ/xOZ/ba/rDVi+JbSAdmjYPTfWbqOwmL5F6LN2ergXbJxH
        HdHgrQUMtWvAt4DHI84JC0+BzPvLwUMi6i3xdKw7MwDX4sJhDoag2WWKrypPNRKo
        pg1c+AKjW5KveZV2Lcf2q6qEIsc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4034B1A32BA;
        Wed, 12 Jul 2023 19:27:59 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=m6menqUncA4a2eg0m4MFOVZboBdtfZm1e6YBGnLHfFA=;
 b=i7ACQJJHqnAlO4UUPIOn6uVwKthfqSUHk7SiuX82nqoBhPJvB1EOzKlKFnFVU/EXCxbVM4U+a86JBmSR7iN3XXQVGOrFAjzgjc03LTiXx9asL/57k7VIOwputk/xDjs3uMQQACpxXtAeyN5F7LTqWn5QpZpN57GDb+DWOIjS464=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0820A1A32B9;
        Wed, 12 Jul 2023 19:27:57 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:28:42 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] Staging: rtl8192e: Rename function TsInitAddBA
Message-ID: <ZK83Kswaq6jxyGcb@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: BC80BDC0-210B-11EE-B801-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TsInitAddBA to ts_init_add_ba
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 6538343ea44d..2e37f1e949ec 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -461,7 +461,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	return 0;
 }
 
-void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
+void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 		 u8 Policy, u8	bOverwritePending)
 {
 	struct ba_record *pBA = &pTS->TxPendingBARecord;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index c61fdf73c572..7841d9ce1a7f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -96,7 +96,7 @@ static void TsAddBaProcess(struct timer_list *t)
 	struct rtllib_device *ieee = container_of(pTxTs, struct rtllib_device,
 				     TxTsRecord[num]);
 
-	TsInitAddBA(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
+	ts_init_add_ba(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..de0dd48d0646 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2008,7 +2008,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
-void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
+void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
-- 
2.41.0

