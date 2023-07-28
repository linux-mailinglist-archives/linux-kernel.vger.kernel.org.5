Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE676640A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjG1GTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjG1GTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:19:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543B3ABD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:18:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7D0B1A8D0D;
        Fri, 28 Jul 2023 02:18:10 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=6DozYcWGpai+70tN92/WhExeB
        h8ebB3Bn6oBjVQK1T4=; b=nqJ7r5iGgh1f+ScCotRcI2AYfEH1lDOqAtOR5bvr8
        RcFtuVIOd8HhG7hC8GvvOXO2sNK382xruF9HzxuIcwQkx+nLj7LMg3Uv8+bn2P/4
        L/8MFdm23+eHd3UZewOCHYz5exSWwoytsWivmSXyjsr8QEyok5+TSylm+tqheJbw
        4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0FD21A8D0C;
        Fri, 28 Jul 2023 02:18:10 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=gLP+8ekI4uyWYNGCTV5ZuJN04h5oF4Jz1y/73M9N2t4=; b=kzBcCHGK4YMq9dSe3LQ5S2KLPvfpB4WIqKnv5MC+iUlXwoVky5Rb5pwQzF63OCDFrA4zlDCQdCh4FAlpji5qhWpsig3h6ZQwMvHQ0Z9bgChr4r87eqTTd6mMU+TI7sfQSmJI8T3Og+hge18l8C0qegqWY0q9o16sNTC/41TGi3Y=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 273111A8D08;
        Fri, 28 Jul 2023 02:18:08 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 1/5] Staging: rtl8192e: Rename function ActivateBAEntry
Date:   Thu, 27 Jul 2023 23:19:26 -0700
Message-ID: <20230728061930.624540-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728061930.624540-1-tdavies@darkphysics.net>
References: <20230728061930.624540-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 8624FAD4-2D0E-11EE-90E5-C65BE52EC81B-45285927!pb-smtp1.pobox.com
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

Rename function ActivateBAEntry to activate_ba_entry in order to Fix
checkpatch warning: Avoid CamelCase

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
index acc19514bca6..965ffa8b78c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -10,7 +10,7 @@
 #include "rtllib.h"
 #include "rtl819x_BA.h"
=20
-static void ActivateBAEntry(struct ba_record *pBA, u16 Time)
+static void activate_ba_entry(struct ba_record *pBA, u16 Time)
 {
 	pBA->b_valid =3D true;
 	if (Time !=3D 0)
@@ -282,7 +282,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
 	else
 		pBA->ba_param_set.field.buffer_size =3D 32;
=20
-	ActivateBAEntry(pBA, 0);
+	activate_ba_entry(pBA, 0);
 	rtllib_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);
=20
 	return 0;
@@ -379,7 +379,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, st=
ruct sk_buff *skb)
 		pAdmittedBA->ba_start_seq_ctrl =3D pPendingBA->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set =3D *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
-		ActivateBAEntry(pAdmittedBA, *pBaTimeoutVal);
+		activate_ba_entry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		pTS->bAddBaReqDelayed =3D true;
 		pTS->bDisable_AddBa =3D true;
@@ -479,7 +479,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct t=
x_ts_record *pTS,
 	pBA->ba_timeout_value =3D 0;
 	pBA->ba_start_seq_ctrl.field.seq_num =3D (pTS->TxCurSeq + 3) % 4096;
=20
-	ActivateBAEntry(pBA, BA_SETUP_TIMEOUT);
+	activate_ba_entry(pBA, BA_SETUP_TIMEOUT);
=20
 	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
 }
--=20
2.41.0

