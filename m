Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DA77A52A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHMGss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHMGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:48:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF7E54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:48:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 614421A3DDC;
        Sun, 13 Aug 2023 02:48:44 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=sVee+W8119kwgUAW/R4Ll71lA
        937X6iLrza/lgqQ3sI=; b=VQ8Y9ZhnhMTSJtRooUdxg5/UsT57W80qGPs8HJ/N+
        1OFdDyzx9rXAfpKziYodZ3a8/zEHviMVKLmNvg9ZI7+ySTQeEYtf7A365CrKfdRr
        A05nsE3bfncHsra2FpqTCb6f3lfn2M6Q5rXzRHx6tIWKRWb+clJEDS+r+xqBIk6E
        Xk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 598E31A3DDB;
        Sun, 13 Aug 2023 02:48:44 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=4Zlyxu74DmQiQA44UrA7Mb0JkNtuyzCmhp1IS86V+sE=; b=VBcF1eNDO8rBaRKCM/PIth9fMZT3JLrJAjVYAGfWtK6Noikz2HJ3+jZ3QI1mFjECBqpg4JHObEgTsH13S5CDw/T1rVAzWG7sZRr8M2+gg/tyV5l5oDSaur1YNpnAqiNa+fU91T3pJKHI1/OmdNXBDKmaIBMOk8tHrofFGukFeMc=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D7C61A3DD7;
        Sun, 13 Aug 2023 02:48:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 2/6] Staging: rtl8192e: Rename variable pTS in function rtllib_rx_ADDBAReq()
Date:   Sat, 12 Aug 2023 23:50:31 -0700
Message-ID: <20230813065035.95157-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813065035.95157-1-tdavies@darkphysics.net>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 71AD2B8C-39A5-11EE-A4E7-307A8E0A682E-45285927!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function rtllib_rx_ADDBAReq() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 1eff30533f47..2748ab59545c 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -220,7 +220,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
 	union ba_param_set *pBaParamSet =3D NULL;
 	u16 *pBaTimeoutVal =3D NULL;
 	union sequence_control *pBaStartSeqCtrl =3D NULL;
-	struct rx_ts_record *pTS =3D NULL;
+	struct rx_ts_record *rx_ts =3D NULL;
=20
 	if (skb->len < sizeof(struct rtllib_hdr_3addr) + 9) {
 		netdev_warn(ieee->dev, "Invalid skb len in BAREQ(%d / %d)\n",
@@ -253,13 +253,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, =
struct sk_buff *skb)
 			    ieee->ht_info->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
+	if (!GetTs(ieee, (struct ts_common_info **)&rx_ts, dst,
 		   (u8)(pBaParamSet->field.tid), RX_DIR, true)) {
 		rc =3D ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA =3D &pTS->rx_admitted_ba_record;
+	pBA =3D &rx_ts->rx_admitted_ba_record;
=20
 	if (pBaParamSet->field.ba_policy =3D=3D BA_POLICY_DELAYED) {
 		rc =3D ADDBA_STATUS_INVALID_PARAM;
@@ -268,7 +268,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
=20
-	rtllib_FlushRxTsPendingPkts(ieee, pTS);
+	rtllib_FlushRxTsPendingPkts(ieee, rx_ts);
=20
 	deactivate_ba_entry(ieee, pBA);
 	pBA->dialog_token =3D *pDialogToken;
--=20
2.41.0

