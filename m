Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997776640C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjG1GTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjG1GTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:19:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E14227
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:18:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E06B1A8D15;
        Fri, 28 Jul 2023 02:18:15 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=OiV0njMtvH9qWAdC500rUNA/t
        fiOlHiTZyJUFPDpZT4=; b=r5wA3wk/UPymoUvFComw7ycJ9OwtKVjBso8lp+MM6
        kvsh5Bj87ujlyFawJQyV378/iGdVXF6jRJQK63KCtSuOIOD+CMOa8j4kch17LJJ+
        6+LFuMLRWFqbBYdccOHz51o/fbFPA1COPMaCXbyTxVILhoEKb2DBz+ngus5psSru
        kg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66BFD1A8D14;
        Fri, 28 Jul 2023 02:18:15 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=f9flxcSu4TBNa6nh5mI3LwHd7NstE09ghZl7BbcmNSE=; b=I0qIJ0//fmeysgWMvoIij2y/Fevl8l+LnwQ/620UiO+SqRBp4ewdJBsub+hIrWgTt1+Do5lQr7YYVlE1GRpn3L2vZPSC1sQ3JnCLhFv1f47fiQccMvaD30tOlFnqSubfLMCshqyp8HAfU+7tch2M/IDRRX9uDwSI2svgkyZhqoo=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E128A1A8D0E;
        Fri, 28 Jul 2023 02:18:12 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 3/5] Staging: rtl8192e: Rename function TxTsDeleteBA
Date:   Thu, 27 Jul 2023 23:19:28 -0700
Message-ID: <20230728061930.624540-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728061930.624540-1-tdavies@darkphysics.net>
References: <20230728061930.624540-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 88E9AEEA-2D0E-11EE-8F68-C65BE52EC81B-45285927!pb-smtp1.pobox.com
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

Rename function TxTsDeleteBA to tx_ts_delete_ba in order to Fix checkpatc=
h
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v4: Resending. git send-email failed to send patch #5.
v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset=
_ba_entry
v2: Sent to mailing list via git send-email, patches are the same.       =
 =20
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

