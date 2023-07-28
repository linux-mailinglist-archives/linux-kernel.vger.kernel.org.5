Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B76640E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjG1GTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjG1GTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:19:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1913D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:19:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA72E1A8D1E;
        Fri, 28 Jul 2023 02:18:19 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=COpGeTLjpZ9YKLcwM5ezF6QSu
        9d8w3sdre09Itj6Y2Y=; b=r68f4Cic6LstmPCRccPAo+Hj8Eqfrj3JFMmePirWx
        Ds3mz5ux41g4Q2zIdavE4BbLK2lEJw0VMsSYRPeSjP7Lz1zwGiF8d5SdZtNbKD+K
        Bmx443sXDPbolAxl9k6Bx0ilqQSFzAOOZwSOMmGJDRmVRtRRAiRbck/NPSAKXmLs
        Ns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3AB61A8D1D;
        Fri, 28 Jul 2023 02:18:19 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=iVc9Etj2FqWwWTcqnp+zFzfbRi2T9cIl827B0Z5dMGg=; b=dgksz02m9y7Y9rqDObq2r3oLlMwMrjTN6orr28N2444/+CB0jgMcSEjcqZ7V0XSvCGTEZVyhncP3xqlIaSx1OO+PZiitwJDpanlGSwA9UxW3w755FRvhXUXn412eQw0Pv8JUSdJDBUDIq853eAk6ejThrQEqaPVvx1XwP4v1mnk=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 825EB1A8D18;
        Fri, 28 Jul 2023 02:18:17 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 5/5] Staging: rtl8192e: Rename function ResetBaEntry
Date:   Thu, 27 Jul 2023 23:19:30 -0700
Message-ID: <20230728061930.624540-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728061930.624540-1-tdavies@darkphysics.net>
References: <20230728061930.624540-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 8BAB0570-2D0E-11EE-BDB8-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function ResetBaEntry to rtllib_reset_ba_entry in order to Fix=20
checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v4: Resending. git send-email failed to send patch #5.
v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset=
_ba_entry
v2: Sent to mailing list via git send-email, patches are the same.       =
 =20
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 9662d75257ce..600802c795b9 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -54,7 +54,7 @@ static u8 rx_ts_delete_ba(struct rtllib_device *ieee, s=
truct rx_ts_record *pRxTs
 	return bSendDELBA;
 }
=20
-void ResetBaEntry(struct ba_record *pBA)
+void rtllib_reset_ba_entry(struct ba_record *pBA)
 {
 	pBA->b_valid			  =3D false;
 	pBA->ba_param_set.short_data	  =3D 0;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index c61fdf73c572..2779a31457a5 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -117,8 +117,8 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->bAddBaReqDelayed =3D false;
 	pTS->bUsingBa =3D false;
 	pTS->bDisable_AddBa =3D false;
-	ResetBaEntry(&pTS->TxAdmittedBARecord);
-	ResetBaEntry(&pTS->TxPendingBARecord);
+	rtllib_reset_ba_entry(&pTS->TxAdmittedBARecord);
+	rtllib_reset_ba_entry(&pTS->TxPendingBARecord);
 }
=20
 static void ResetRxTsEntry(struct rx_ts_record *pTS)
@@ -126,7 +126,7 @@ static void ResetRxTsEntry(struct rx_ts_record *pTS)
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->rx_indicate_seq =3D 0xffff;
 	pTS->rx_timeout_indicate_seq =3D 0xffff;
-	ResetBaEntry(&pTS->rx_admitted_ba_record);
+	rtllib_reset_ba_entry(&pTS->rx_admitted_ba_record);
 }
=20
 void TSInitialize(struct rtllib_device *ieee)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e=
/rtllib.h
index e3ce4431d460..c770ec37aeff 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2016,7 +2016,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
-void ResetBaEntry(struct ba_record *pBA);
+void rtllib_reset_ba_entry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 =
*Addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
 void TSInitialize(struct rtllib_device *ieee);
--=20
2.41.0

