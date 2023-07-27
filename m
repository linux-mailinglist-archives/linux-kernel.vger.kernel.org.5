Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADE76469D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjG0GTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjG0GS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:18:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35F26A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:18:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B98162B791;
        Thu, 27 Jul 2023 02:18:52 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=tOyyhkPnH5cG5/zI7R728hV/k
        IfXWRQqdfhJ+bAnmjM=; b=uWKlvckig6wJIvZLTGdEEMdlciZK8VpYMBRlMDjse
        8BoGBw+zSYwTxE3tkM/ARfo6i6FlD/w8r7jNYpZEUtZGVon7nV9X9eFtG23Uj2Lu
        uw7YOd34vaKh56fIvMDFUbnqVtyCySdou8A3RQpfCZyuvjqujJm0f9yyqdCPdxnK
        5s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0DD92B790;
        Thu, 27 Jul 2023 02:18:52 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=Fv4x/SzXu8s71D0ldmujCVmzDHwbAuZyPBt8Gw5BYHE=; b=tgyH7eAxyfad10N2q+CfJfhreKvEuUoD3Zf6nEYh99uWXVUE10lNf3KJw+DgKQycM2OXDEhxk8AFB/zAxOUh+wT2s2TXZSGQGa/1ZN8V7Av2nFJzltg+jT7Le+KbHVlwD4TkTrJwkTX0CZ7+e5wkpN1BqOQe88NAJwzQVEZlwMU=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 232432B78C;
        Thu, 27 Jul 2023 02:18:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 4/5] Staging: rtl8192e: Rename function RxTsDeleteBA
Date:   Wed, 26 Jul 2023 23:19:47 -0700
Message-ID: <20230727061948.579480-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727061948.579480-1-tdavies@darkphysics.net>
References: <20230727061948.579480-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 733A3F2A-2C45-11EE-A8B8-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
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

Rename function RxTsDeleteBA to rx_ts_delete_ba in order to Fix checkpatc=
h
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Sent with git send-email
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 6538343ea44d..9662d75257ce 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -41,7 +41,7 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, s=
truct tx_ts_record *pTxTs
 	return bSendDELBA;
 }
=20
-static u8 RxTsDeleteBA(struct rtllib_device *ieee, struct rx_ts_record *=
pRxTs)
+static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_recor=
d *pRxTs)
 {
 	struct ba_record *pBa =3D &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA =3D false;
@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struc=
t sk_buff *skb)
 			return -1;
 		}
=20
-		RxTsDeleteBA(ieee, pRxTs);
+		rx_ts_delete_ba(ieee, pRxTs);
 	} else {
 		struct tx_ts_record *pTxTs;
=20
@@ -501,7 +501,7 @@ void TsInitDelBA(struct rtllib_device *ieee,
 	} else if (TxRxSelect =3D=3D RX_DIR) {
 		struct rx_ts_record *pRxTs =3D
 				 (struct rx_ts_record *)pTsCommonInfo;
-		if (RxTsDeleteBA(ieee, pRxTs))
+		if (rx_ts_delete_ba(ieee, pRxTs))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
 					  &pRxTs->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
@@ -537,7 +537,7 @@ void RxBaInactTimeout(struct timer_list *t)
 	struct rtllib_device *ieee =3D container_of(pRxTs, struct rtllib_device=
,
 				     RxTsRecord[pRxTs->num]);
=20
-	RxTsDeleteBA(ieee, pRxTs);
+	rx_ts_delete_ba(ieee, pRxTs);
 	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
 			  &pRxTs->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
--=20
2.41.0

