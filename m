Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF377198D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjHGFqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHGFqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:46:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFD1980
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:45:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F7221A0BE7;
        Mon,  7 Aug 2023 01:45:59 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Cm0x5EIziGGzMkQUeXZxCP4lP
        eKNPDxESeOb5WlzBIA=; b=w/XWDiCIzB8utwRp8vIcjQXRdzfx3dO7BVG62rCxD
        wmVID9SJ61ADaYoYaipTItWW7Zcb2+VV4cPfqWAgd8loO0Tzm/POFHFGE1StJ6ih
        9nnrKQ53n4T73xmA/kKpX1wfpZjv93Va1O+qRH0r5W5EOyi8qu0/GS22CP7AZ9QC
        fk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 379941A0BE6;
        Mon,  7 Aug 2023 01:45:59 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=zeIIoTC2mQDo2YVk57Mv6AaSbXETO612h211yRnN734=; b=qAe1vxz592rWwkIuitanlU8SrnmkFBpFdwcGkLb+4IS3jXGrfabqWQDSjH+2BnXSEDv2Ki69cCEfSszZucyQ6V0GUrBVgaMWLElOW/7GxPlDSsIrvOIYbhYKlhFp8EVtD0StUVjprqhs7w2jVMLpIdeWretA/RGmzvASxf2apj0=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DE461A0BDF;
        Mon,  7 Aug 2023 01:45:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/5] Staging: rtl8192e: Rename function TxBaInactTimeout
Date:   Sun,  6 Aug 2023 22:47:31 -0700
Message-ID: <20230807054732.1864827-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807054732.1864827-1-tdavies@darkphysics.net>
References: <20230807054732.1864827-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: AEF183AE-34E5-11EE-981C-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TxBaInactTimeout to rtllib_tx_ba_inact_timeout in order
to Fix checkpatch warning: Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index f07c9e7ed893..1eac56fa97f9 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -518,7 +518,7 @@ void rtllib_ba_setup_timeout(struct timer_list *t)
 	pTxTs->TxPendingBARecord.b_valid =3D false;
 }
=20
-void TxBaInactTimeout(struct timer_list *t)
+void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs =3D from_timer(pTxTs, t,
 					      TxAdmittedBARecord.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 1784fa676a65..c57bc0c8816b 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -139,7 +139,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		timer_setup(&pTxTS->TxPendingBARecord.timer, rtllib_ba_setup_timeout,
 			    0);
 		timer_setup(&pTxTS->TxAdmittedBARecord.timer,
-			    TxBaInactTimeout, 0);
+			    rtllib_tx_ba_inact_timeout, 0);
=20
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->TsCommonInfo.List,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e=
/rtllib.h
index 53bdf2c429a7..3383dab0d1ca 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2008,7 +2008,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ie=
ee,
 			   struct ts_common_info *pTsCommonInfo,
 			   enum tr_select TxRxSelect);
 void rtllib_ba_setup_timeout(struct timer_list *t);
-void TxBaInactTimeout(struct timer_list *t);
+void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 =
*Addr,
--=20
2.41.0

