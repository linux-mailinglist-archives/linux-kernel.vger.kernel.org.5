Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE2751465
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGLXYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjGLXYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:24:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD61BCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:24:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C1831668;
        Wed, 12 Jul 2023 19:24:15 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        VsvEWW4jTm3uKwgrvTm8WFT3f/A2AMNxLHc+Lpn7mOQ=; b=qd6tgivF5rP13bM5
        ANXMpWA0RMVaAV1VbdTP/ip+zHOYQc2nzRYC7t9VX966SuaWvyawiYjHs5kV9GlD
        WzJvxgkzlflzVI2XruqWlIffQzNsJ19p8OUGKuLGRFjyeUSPE9vi4ImOUe4Y+ERY
        Lx8OKf4UJ5Raa403VcI8s6eqpqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DD9531667;
        Wed, 12 Jul 2023 19:24:15 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=VsvEWW4jTm3uKwgrvTm8WFT3f/A2AMNxLHc+Lpn7mOQ=;
 b=XMry9kdNujmQjNhOnZlJJKo2S6kQgGyV51mvVoMG2k47NFVwWY7qAgyoM7+ZBc0MuHmjtmeEsKc9ZSfYqZnikCcj2FyGPvRVl6JUNhVMmyxKWQHx7IcvG7qIoVG05fbnMFlxlxnilDmTVqteGF4tqBpY3twme/nDOwH85GIQDgE=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0CC831666;
        Wed, 12 Jul 2023 19:24:11 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:25:01 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] Staging: rtl8192e: Rename function ActivateBAEntry
Message-ID: <ZK82TTDh4mthB/Hx@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 35685424-210B-11EE-8E03-C2DA088D43B2-45285927!pb-smtp20.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function ActivateBAEntry to activate_ba_entry
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index acc19514bca6..965ffa8b78c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -10,7 +10,7 @@
 #include "rtllib.h"
 #include "rtl819x_BA.h"
 
-static void ActivateBAEntry(struct ba_record *pBA, u16 Time)
+static void activate_ba_entry(struct ba_record *pBA, u16 Time)
 {
 	pBA->b_valid = true;
 	if (Time != 0)
@@ -282,7 +282,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	else
 		pBA->ba_param_set.field.buffer_size = 32;
 
-	ActivateBAEntry(pBA, 0);
+	activate_ba_entry(pBA, 0);
 	rtllib_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
 
 	return 0;
@@ -379,7 +379,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
-		ActivateBAEntry(pAdmittedBA, *pBaTimeoutVal);
+		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		pTS->bAddBaReqDelayed = true;
 		pTS->bDisable_AddBa = true;
@@ -479,7 +479,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	pBA->ba_timeout_value = 0;
 	pBA->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;
 
-	ActivateBAEntry(pBA, BA_SETUP_TIMEOUT);
+	activate_ba_entry(pBA, BA_SETUP_TIMEOUT);
 
 	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
 }
-- 
2.41.0

