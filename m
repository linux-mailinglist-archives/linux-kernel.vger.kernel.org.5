Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05A7663C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjG1FrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjG1Fqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:46:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA63A96
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:46:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A22E1A8A1B;
        Fri, 28 Jul 2023 01:46:27 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=EcRi2wbRNFJnE2zKy6iOeN2R0
        2xtFKxUKxuvoQUs84Q=; b=fZGBPBux0n3E95X2KDz4pJ57aFihbFOOsqt+8ziMB
        V5eLnjyoRKr7NHf1GOsqcl8C6IfnBpxv3yyRcz1iXmvtRxm2ZUhp0IAIBJnkuRAI
        XAc1P6a2CusAXcCKLlhIuTf/BCRyR7IAKA7bPoSeobjk25/ZnXRS8TQEML0ZEW4d
        WU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C971A8A1A;
        Fri, 28 Jul 2023 01:46:27 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=9T29Lvp0prLCwwsQJisEgoAvnGRNoCbCVIXQxoBStNc=; b=F25RS3gbPD6PKKlHXCVP6KHLVrl4se9hm0ZGrfaBrefYoacKO0crm9LkFvCJurIfPP6+jwMr+dhv64hyw5OtJjr9tiMdj/EKY3DsM+ksxoRhNtVTXsrP9aooNA9V5gYlTCj98fsGn/BpxshlBYi+/hEA6c2fWDXmZdpD2RAofLM=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5D771A8A15;
        Fri, 28 Jul 2023 01:46:24 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 4/5] Staging: rtl8192e: Rename function RxTsDeleteBA
Date:   Thu, 27 Jul 2023 22:47:41 -0700
Message-ID: <20230728054742.622297-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728054742.622297-1-tdavies@darkphysics.net>
References: <20230728054742.622297-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 178F38B8-2D0A-11EE-91A5-C65BE52EC81B-45285927!pb-smtp1.pobox.com
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

Rename function RxTsDeleteBA to rx_ts_delete_ba in order to Fix checkpatc=
h
warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset=
_ba_entry
v2: Sent to mailing list via git send-email, patches are the same.       =
 =20
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

