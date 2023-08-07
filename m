Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903977198C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjHGFqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHGFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:45:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DA1703
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:45:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8A0B1A0BE1;
        Mon,  7 Aug 2023 01:45:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=80mXZW4JwvdQMg75yj/O2W/yN
        gK0tjvH1+uc4letNw8=; b=R+ej3G5E/dElSm8zXu4RJLmsOA6fVDsBOK5uYJJn2
        xX38pKyb4Qm5adrGoJEraHQQUQ0+3jkOi+UqrW4+ZRsFThFXyfvSzts1eaaa/rNI
        SJDmBTtX7+S5aKKMYRTk2Lv+ffGq1DCQMuWbOWA+AzrltXvyKZ9N3lbyXPjAI87z
        OE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A200C1A0BE0;
        Mon,  7 Aug 2023 01:45:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=NsrMBOy4Y/gerUo4wn6EsK1Ss22LXhsXc3sGFyEJqrI=; b=POjNNOUHnYKzjji+cTXSKaz42XwVYLFvSfoO0G71KE3hfO58BqmJvuFS0sBqCEvyIC2/n2OVGRAD2UvadM25GiTXpInWhlpTHhzj1F24wr9aJr+rZgeg198K3PvHwCZvx+s3QQcO2gqHD+bhuOYK/QAJ4ZHWl+kV7VaHdcbmYuI=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15EBB1A0BD9;
        Mon,  7 Aug 2023 01:45:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/5] Staging: rtl8192e: Rename function BaSetupTimeOut
Date:   Sun,  6 Aug 2023 22:47:30 -0700
Message-ID: <20230807054732.1864827-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807054732.1864827-1-tdavies@darkphysics.net>
References: <20230807054732.1864827-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: AD686930-34E5-11EE-A8A3-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function BaSetupTimeOut to rtllib_ba_setup_timeout in order to Fix
checkpatch warning: Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 19c845ec863c..f07c9e7ed893 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -508,7 +508,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee=
,
 	}
 }
=20
-void BaSetupTimeOut(struct timer_list *t)
+void rtllib_ba_setup_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs =3D from_timer(pTxTs, t,
 					      TxPendingBARecord.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 759778787afa..1784fa676a65 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -136,7 +136,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		pTxTS->num =3D count;
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
=20
-		timer_setup(&pTxTS->TxPendingBARecord.timer, BaSetupTimeOut,
+		timer_setup(&pTxTS->TxPendingBARecord.timer, rtllib_ba_setup_timeout,
 			    0);
 		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
 			    TxBaInactTimeout, 0);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e=
/rtllib.h
index a4238db2fd56..53bdf2c429a7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2007,7 +2007,7 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ie=
ee, struct tx_ts_record *pTS,
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *pTsCommonInfo,
 			   enum tr_select TxRxSelect);
-void BaSetupTimeOut(struct timer_list *t);
+void rtllib_ba_setup_timeout(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
--=20
2.41.0

