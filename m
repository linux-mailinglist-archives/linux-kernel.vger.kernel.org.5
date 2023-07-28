Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48097663BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjG1Fq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjG1Fqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:46:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C735B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:46:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77F451A8A14;
        Fri, 28 Jul 2023 01:46:22 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uWcpY9tEW15/LWTbqHMjYwFOD
        e7nP5AzxTp2FXkDfu0=; b=f/bsOpebdABaOyooSi5ZRcvdWbU7Ey9QK6YYz9c2E
        akOfOVCEI+DjHVPJtsGSHzwdnmQBw6lxCn4pIU/B/h6gZh7cBNsh+sHc9Unnf6/o
        lleaITj4pD86sf15PIGw+bR3h/9PyxMM7vhGFgf2eZr9pfpPYRdccupMds7+ZXTY
        Hk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FE891A8A13;
        Fri, 28 Jul 2023 01:46:22 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=eK7mYYCfud4wfsG0kxY8/fURuzguYFmTT6xrkDLazyw=; b=hXfqNjm4kNLqPDf0u++NuDz3+BTxRmUU4Sd2eCM/r3n3HY9YW/B1WNPvkbfULVOvM4Gt2DMjoHFMYz9NKiwFy+K8Tws6vt9MlrVfiwTVbw4EH0wdI1f66cZVVBXVuCB2OU0KrPBUvMQw1yxNpU0tJ0nj4QqdLLL5OHlzRnvTxe8=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 445DB1A8A0D;
        Fri, 28 Jul 2023 01:46:20 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v3 2/5] Staging: rtl8192e: Rename function DeActivateBAEntry
Date:   Thu, 27 Jul 2023 22:47:39 -0700
Message-ID: <20230728054742.622297-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728054742.622297-1-tdavies@darkphysics.net>
References: <20230728054742.622297-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 14E37A7A-2D0A-11EE-95FF-C65BE52EC81B-45285927!pb-smtp1.pobox.com
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

Rename function DeActivateBAEntry to deactivate_ba_entry in order to Fix
checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset=
_ba_entry
v2: Sent to mailing list via git send-email, patches are the same.       =
 =20
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 965ffa8b78c2..50362bbbc8dd 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -17,7 +17,7 @@ static void activate_ba_entry(struct ba_record *pBA, u1=
6 Time)
 		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
 }
=20
-static void DeActivateBAEntry(struct rtllib_device *ieee, struct ba_reco=
rd *pBA)
+static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_re=
cord *pBA)
 {
 	pBA->b_valid =3D false;
 	del_timer_sync(&pBA->timer);
@@ -30,12 +30,12 @@ static u8 TxTsDeleteBA(struct rtllib_device *ieee, st=
ruct tx_ts_record *pTxTs)
 	u8 bSendDELBA =3D false;
=20
 	if (pPendingBa->b_valid) {
-		DeActivateBAEntry(ieee, pPendingBa);
+		deactivate_ba_entry(ieee, pPendingBa);
 		bSendDELBA =3D true;
 	}
=20
 	if (pAdmittedBa->b_valid) {
-		DeActivateBAEntry(ieee, pAdmittedBa);
+		deactivate_ba_entry(ieee, pAdmittedBa);
 		bSendDELBA =3D true;
 	}
 	return bSendDELBA;
@@ -47,7 +47,7 @@ static u8 RxTsDeleteBA(struct rtllib_device *ieee, stru=
ct rx_ts_record *pRxTs)
 	u8			bSendDELBA =3D false;
=20
 	if (pBa->b_valid) {
-		DeActivateBAEntry(ieee, pBa);
+		deactivate_ba_entry(ieee, pBa);
 		bSendDELBA =3D true;
 	}
=20
@@ -270,7 +270,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
=20
 	rtllib_FlushRxTsPendingPkts(ieee, pTS);
=20
-	DeActivateBAEntry(ieee, pBA);
+	deactivate_ba_entry(ieee, pBA);
 	pBA->dialog_token =3D *pDialogToken;
 	pBA->ba_param_set =3D *pBaParamSet;
 	pBA->ba_timeout_value =3D *pBaTimeoutVal;
@@ -363,13 +363,13 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, =
struct sk_buff *skb)
 		netdev_dbg(ieee->dev,
 			   "%s(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n",
 			   __func__, *pStatusCode);
-		DeActivateBAEntry(ieee, pPendingBA);
+		deactivate_ba_entry(ieee, pPendingBA);
 	}
=20
 	if (*pStatusCode =3D=3D ADDBA_STATUS_SUCCESS) {
 		if (pBaParamSet->field.ba_policy =3D=3D BA_POLICY_DELAYED) {
 			pTS->bAddBaReqDelayed =3D true;
-			DeActivateBAEntry(ieee, pAdmittedBA);
+			deactivate_ba_entry(ieee, pAdmittedBA);
 			ReasonCode =3D DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
 		}
@@ -378,7 +378,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
 		pAdmittedBA->ba_timeout_value =3D *pBaTimeoutVal;
 		pAdmittedBA->ba_start_seq_ctrl =3D pPendingBA->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set =3D *pBaParamSet;
-		DeActivateBAEntry(ieee, pAdmittedBA);
+		deactivate_ba_entry(ieee, pAdmittedBA);
 		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		pTS->bAddBaReqDelayed =3D true;
@@ -469,7 +469,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct t=
x_ts_record *pTS,
 	if (pBA->b_valid && !bOverwritePending)
 		return;
=20
-	DeActivateBAEntry(ieee, pBA);
+	deactivate_ba_entry(ieee, pBA);
=20
 	pBA->dialog_token++;
 	pBA->ba_param_set.field.amsdu_support =3D 0;
--=20
2.41.0

