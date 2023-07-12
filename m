Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5B75147E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGLXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:33:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF4199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:33:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4EDF36141;
        Wed, 12 Jul 2023 19:33:37 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        XSX9XuFD4IHn1MFKn1hvAMyDaF1YWpN+lkLClOmoas8=; b=e45fQ23vAxvlvScP
        RbaKjt9HOpp9JGtR2mOgMJrtabJsyfEzjlz9aVOajjtN0XRisIEA1ZmprTVQbxl/
        /uyLkqH0l+dLhVrQ3JXAMIpdxexNena7kapd27JOciO2L+xcAEh59sGm27fCUGai
        VAVem59Xw9GDZRIFgg7+NYpBSXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD65336140;
        Wed, 12 Jul 2023 19:33:37 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=XSX9XuFD4IHn1MFKn1hvAMyDaF1YWpN+lkLClOmoas8=;
 b=u/b+kiBT3Frs54p/7YAeBqPVQtsBdkdAJ09Iu7shOwoGV47tTpSm60iNW+7Q9f7NpYTLoNm4ULZDlihFUY2HQPmcPy+RBbhnq857AmEoMgx05i1MDv2+nk6Z4ti/KHwcSqml+GmVnG91yWuzy6vtu8UaQESw0EpcB2SwzLpmQzY=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 724FC3613F;
        Wed, 12 Jul 2023 19:33:33 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:34:23 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] Staging: rtl8192e: Rename function RxBaInactTimeout
Message-ID: <ZK84f9H2QOW935Jx@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 8426E5DE-210C-11EE-88EE-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function RxBaInactTimeout to rx_ba_inact_timeout
in order to Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 675f3ba15a7a..6b5da38353ee 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -530,7 +530,7 @@ void tx_ba_inact_timeout(struct timer_list *t)
 			  DELBA_REASON_TIMEOUT);
 }
 
-void RxBaInactTimeout(struct timer_list *t)
+void rx_ba_inact_timeout(struct timer_list *t)
 {
 	struct rx_ts_record *pRxTs = from_timer(pRxTs, t,
 					      rx_admitted_ba_record.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7f0340dd764d..2f7d5324edb9 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -175,7 +175,7 @@ void TSInitialize(struct rtllib_device *ieee)
 			    0);
 
 		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
-			    RxBaInactTimeout, 0);
+			    rx_ba_inact_timeout, 0);
 
 		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4f55dcf42bc7..0f84ee1d418e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2015,7 +2015,7 @@ void ts_init_del_ba(struct rtllib_device *ieee,
 		 enum tr_select TxRxSelect);
 void ba_setup_time_out(struct timer_list *t);
 void tx_ba_inact_timeout(struct timer_list *t);
-void RxBaInactTimeout(struct timer_list *t);
+void rx_ba_inact_timeout(struct timer_list *t);
 void ResetBaEntry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *Addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
-- 
2.41.0

