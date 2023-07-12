Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630675147C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLXbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLXbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:31:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E13170E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:31:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5318316F8;
        Wed, 12 Jul 2023 19:31:20 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        UlFpPcgJd6eBvs+tqsV0S7X52SvpA8keQhN2yc5Ia8w=; b=NKdO66g7tP2VL+/e
        aMt9uoaj7JMjutFNnc+6Cgvag4Lt5Lthe9feJewml0fqlEk2xnsMNd66bZkrib13
        yUwcfpiCtN9uT5xZjQR1j3M2fzNdslnT/ARHB2My/i2vRllew+9At2Qe0od4tsSR
        x4bKvRAynqQONIsMaAc89cDP7kg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B634316F7;
        Wed, 12 Jul 2023 19:31:20 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=UlFpPcgJd6eBvs+tqsV0S7X52SvpA8keQhN2yc5Ia8w=;
 b=I3/I1QqLWo2lRrG8ByTBPWvnCws1u8EKRGh5ryscbBODd9sPlywwL3EnI2npQZjZUWfU1Of+Xf1BYY9VenK9dXceUXgigmAJ3HgWilmyk2pTqUO2znlGhz4d74crnEjnVAbOx4o7SDaF3r9m8NOQ1QusJMNwQH75u0E6+JzgDOk=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B73F6316F6;
        Wed, 12 Jul 2023 19:31:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:32:06 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] Staging: rtl8192e: Rename function BaSetupTimeOut
Message-ID: <ZK839gkqIRUBmNwA@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 32AB55DC-210C-11EE-BF2D-C2DA088D43B2-45285927!pb-smtp20.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function BaSetupTimeOut to ba_setup_time_out
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 9a32528fe314..941b3f47710e 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -508,7 +508,7 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 	}
 }
 
-void BaSetupTimeOut(struct timer_list *t)
+void ba_setup_time_out(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs = from_timer(pTxTs, t,
 					      TxPendingBARecord.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 8005f7462aca..087082cdcee6 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -150,7 +150,7 @@ void TSInitialize(struct rtllib_device *ieee)
 
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 
-		timer_setup(&pTxTS->TxPendingBARecord.timer, BaSetupTimeOut,
+		timer_setup(&pTxTS->TxPendingBARecord.timer, ba_setup_time_out,
 			    0);
 		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
 			    TxBaInactTimeout, 0);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 42a9b1dafc27..face43ee8a2b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2013,7 +2013,7 @@ void ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 void ts_init_del_ba(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
 		 enum tr_select TxRxSelect);
-void BaSetupTimeOut(struct timer_list *t);
+void ba_setup_time_out(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
 void ResetBaEntry(struct ba_record *pBA);
-- 
2.41.0

