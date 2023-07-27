Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4F76469C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjG0GS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjG0GSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:18:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05B1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:18:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 545412B78E;
        Thu, 27 Jul 2023 02:18:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=l8UdN/EWLHyJwQapdRtTt2QKo
        +FY91epVTlA9xYH5zM=; b=tY62yvkKH4wXvibmnHcCBLGErkGLCG2Hh5MI/0W4b
        X0zE7QyhaFNY1PJDs3FRcl8T44Vkn8uwAJcxHY7cC/vaGJoD5JsZi88bRtmPJWJV
        fYxMb0Sr6e0EI90PqXKYYMlVrbRBmQPML0i9gQpuexwue0Zj5aeMknvDhp2VciyS
        w4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DB442B78D;
        Thu, 27 Jul 2023 02:18:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=06BJ1jAlItt/gLHoQGDcXD8Wbq0tI0D1VgMPMuC5IA8=; b=mP17BrWrRupcbo6s6XeyuR5SDgTngaUITzsdYrjYZ/Hg7GgEHLT9yQlJNscngztJj3qdrshXu3w3RtpB2Yte6qqPKeXbw7sBDXbEv9HCI5SSj5KB7TSxrdQMr3LjmhnnUoubeZ28mqB1YIl2s2eolQnOsYRRQ3NMD7qtcluJOcY=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0174F2B789;
        Thu, 27 Jul 2023 02:18:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 3/5] Staging: rtl8192e: Rename function TxTsDeleteBA
Date:   Wed, 26 Jul 2023 23:19:46 -0700
Message-ID: <20230727061948.579480-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727061948.579480-1-tdavies@darkphysics.net>
References: <20230727061948.579480-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 70D58B68-2C45-11EE-B58E-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TxTsDeleteBA to tx_ts_delete_ba in order to Fix checkpatc=
h
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Sent with git send-email
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 50362bbbc8dd..6538343ea44d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -23,7 +23,7 @@ static void deactivate_ba_entry(struct rtllib_device *i=
eee, struct ba_record *pB
 	del_timer_sync(&pBA->timer);
 }
=20
-static u8 TxTsDeleteBA(struct rtllib_device *ieee, struct tx_ts_record *=
pTxTs)
+static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_recor=
d *pTxTs)
 {
 	struct ba_record *pAdmittedBa =3D &pTxTs->TxAdmittedBARecord;
 	struct ba_record *pPendingBa =3D &pTxTs->TxPendingBARecord;
@@ -456,7 +456,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struc=
t sk_buff *skb)
 		pTxTs->bAddBaReqInProgress =3D false;
 		pTxTs->bAddBaReqDelayed =3D false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
-		TxTsDeleteBA(ieee, pTxTs);
+		tx_ts_delete_ba(ieee, pTxTs);
 	}
 	return 0;
 }
@@ -492,7 +492,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 		struct tx_ts_record *pTxTs =3D
 			 (struct tx_ts_record *)pTsCommonInfo;
=20
-		if (TxTsDeleteBA(ieee, pTxTs))
+		if (tx_ts_delete_ba(ieee, pTxTs))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
 					  (pTxTs->TxAdmittedBARecord.b_valid) ?
 					 (&pTxTs->TxAdmittedBARecord) :
@@ -524,7 +524,7 @@ void TxBaInactTimeout(struct timer_list *t)
 					      TxAdmittedBARecord.timer);
 	struct rtllib_device *ieee =3D container_of(pTxTs, struct rtllib_device=
,
 				     TxTsRecord[pTxTs->num]);
-	TxTsDeleteBA(ieee, pTxTs);
+	tx_ts_delete_ba(ieee, pTxTs);
 	rtllib_send_DELBA(ieee, pTxTs->TsCommonInfo.Addr,
 			  &pTxTs->TxAdmittedBARecord, TX_DIR,
 			  DELBA_REASON_TIMEOUT);
--=20
2.41.0

