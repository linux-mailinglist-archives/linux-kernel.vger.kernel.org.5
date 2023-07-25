Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93233760A62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGYGgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGYGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:36:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56510C9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:36:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C34B1AB03B;
        Tue, 25 Jul 2023 02:36:06 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        qHTGpgaDHBSlDM2zIiSHVj01+YB3VY4FeGJAz+qHD8w=; b=iGQkCBcJNtfzdr6o
        tljh4JT5fBrEHBqGXhYMsONueo/n2h/4xnnSx+gqGt69Nq5nsveG7YV6D0T9jskH
        8ShkkUDVIvPEPA7dH6IUDqGZ5VeVf3D7eVm7Mnfb8rMSo/yfITBCzV/eB2rQ4ri7
        dkC5zFuOLrGmeTsTFwjHbWf+Tig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FE5C1AB039;
        Tue, 25 Jul 2023 02:36:06 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=qHTGpgaDHBSlDM2zIiSHVj01+YB3VY4FeGJAz+qHD8w=;
 b=l5dBjlVAL0o3MffXpDCz1IEnfc+eapqGO7kdfwpUkxdX1K5P8bde34mdEa4f9PheYHtAhqx78M+pnm6oleCgEHortJMZ8ImX+7Cs0VCY5p72lDJ7FCWoZJauxX8ikJb8u/idLZGalkVscQY9MsNTp31zadXB142WP0x6xwWuC5g=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BE801AB038;
        Tue, 25 Jul 2023 02:36:04 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 24 Jul 2023 23:37:27 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Staging: rtl8192e: Rename function ActivateBAEntry
Message-ID: <ZL9tp+w1nlGfXefd@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 87D77718-2AB5-11EE-BA32-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function ActivateBAEntry to activate_ba_entry in order to Fix
checkpatch warning: Avoid CamelCase

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

