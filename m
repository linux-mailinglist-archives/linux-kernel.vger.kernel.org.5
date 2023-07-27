Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E676469A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjG0GSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjG0GSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:18:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A49C19B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:18:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F9D72B788;
        Thu, 27 Jul 2023 02:18:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Yme2ABWyZv9hU5EZNMuaiBtZz
        P3G0tOP4AY9ah8Wu+I=; b=XqkN+mocHCfLVJfFsPdoHd3RwMf5ESmpi2BBUQH0Z
        AOEiyRxIHUt5r6p1lMzH3aZRBhg+FWdLSVytaYwnPZW+D8uxvbEj+olpu08m9si9
        3sR1+gx+hx22pe+kdAwPU7/QC6+qg+3fc2y0Tu6kokPEiDz+A1o39Scx1eqB844v
        A4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9856E2B786;
        Thu, 27 Jul 2023 02:18:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=30LCb7fytoBphnXRNlksSDylD0H458KlWfAeyHSY7sU=; b=mNnvMHRvg5ZzdJy9gSqpq9TZmUGid6gWmfV5a+EjNjdx+ZpNwPUWbsKsfV+xtsnBjFheaK3o/n0DD8jh8v/hYFEMczwyd5Pf4rPrBmPdegOVc0j9Myp9ZHn4cQTx8eLoJbcDKomNr586oYzdCWwpExyt7V1faMKW0xUkUJ1qMNI=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C56CA2B782;
        Thu, 27 Jul 2023 02:18:36 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 1/5] Staging: rtl8192e: Rename function ActivateBAEntry
Date:   Wed, 26 Jul 2023 23:19:44 -0700
Message-ID: <20230727061948.579480-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727061948.579480-1-tdavies@darkphysics.net>
References: <20230727061948.579480-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6C767EEC-2C45-11EE-847C-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
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

Rename function ActivateBAEntry to activate_ba_entry in order to Fix
checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Sent with git send-email
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

