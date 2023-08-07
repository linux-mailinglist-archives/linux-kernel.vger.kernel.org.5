Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596F77198A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjHGFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHGFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:45:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C011708
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:45:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CC031A0BD8;
        Mon,  7 Aug 2023 01:45:51 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VMt5lkXuonoG2y3uP9PFjCZO6
        91m2Hji0vyUDwwToVI=; b=dj+3apV8MDn6MpF01sRHPAmh29ZEEB0bR7o6N1T9Z
        YDvENZyQXWYAmityGI39ukMezJjfnrTnzpOjdNwXJaMk2BNfXNI8rDCOev7xWPed
        /eY7YwmmKz3Y8gO72n5H7of7YKgRn07LcpAGEq0qssfFZnY7H6dC0Zi0X1YkMgBu
        3g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 858BE1A0BD6;
        Mon,  7 Aug 2023 01:45:51 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=mB7sH0SJCbApPkpurdRl6F0uzB4zzON+qh7H0G7S1j8=; b=hiWFFn9CfvpSv0uCSKx+0SzKUWh278Qwu9AnmeaKVoRKXN/wmEbefayxhEGrHXXOibUWr54kAHXVtao9HPIOhPhz5ofQHuLbDoFftL7GSZp3mLqR1WZK0fW69e6c2MK6gaM/3zG+KF3Rcjy6XE2B2+Si9a7hxn13Xdzp7WqxaKE=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE3A21A0BD1;
        Mon,  7 Aug 2023 01:45:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/5] Staging: rtl8192e: Rename function TsInitAddBA
Date:   Sun,  6 Aug 2023 22:47:28 -0700
Message-ID: <20230807054732.1864827-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807054732.1864827-1-tdavies@darkphysics.net>
References: <20230807054732.1864827-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: AA491ABA-34E5-11EE-A3C3-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TsInitAddBA to rtllib_ts_init_add_ba in order to Fix
checkpatch warning: Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 600802c795b9..9605d21bbf40 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -461,8 +461,8 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struc=
t sk_buff *skb)
 	return 0;
 }
=20
-void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
-		 u8 Policy, u8	bOverwritePending)
+void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_reco=
rd *pTS,
+			   u8 Policy, u8	bOverwritePending)
 {
 	struct ba_record *pBA =3D &pTS->TxPendingBARecord;
=20
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 14e0c000a31a..a36f175ba230 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -88,7 +88,7 @@ static void TsAddBaProcess(struct timer_list *t)
 	struct rtllib_device *ieee =3D container_of(pTxTs, struct rtllib_device=
,
 				     TxTsRecord[num]);
=20
-	TsInitAddBA(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
+	rtllib_ts_init_add_ba(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
 	netdev_dbg(ieee->dev, "%s(): ADDBA Req is started\n", __func__);
 }
=20
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e=
/rtllib.h
index c5a692dfcd17..c38dc5ae0b72 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2002,8 +2002,8 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, =
u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
-void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
-		 u8 Policy, u8 bOverwritePending);
+void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_reco=
rd *pTS,
+			   u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct rtllib_device *ieee,
 		 struct ts_common_info *pTsCommonInfo,
 		 enum tr_select TxRxSelect);
--=20
2.41.0

