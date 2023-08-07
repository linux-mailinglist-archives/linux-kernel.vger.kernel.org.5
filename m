Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D6D77198F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHGFqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHGFqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:46:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3A199E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:46:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2EE31A0BEB;
        Mon,  7 Aug 2023 01:46:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=5eoqeurc7Us0RGOhn2V/CP1M+
        zcVavoyIN8KV85/gWA=; b=oQwGa+drz6TnJ8Af5ni3LgGzhv2HJzrSCcbdbo8qu
        Wl3QZPix8c8JaE84Bb4gIxI+3s2z7EK2PtLsij0u9ElzC8llbUR5ZltvR9+Ztf/C
        pzlu93n9z0eb4Ij9I2fMYePeDsrQmLBBXmWraT+JDb+hnHePTC4uVM2TTl5teJ/4
        /M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDB551A0BEA;
        Mon,  7 Aug 2023 01:46:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=r0indpjmfnijE9fv7U/ET5pUCSjmsRLkWxgQVJN/Iic=; b=cdnmELMA1jSG5cZGNfhsnBljPxpdxRyA7oI/mGmhcsMT6PcmEBhC5pYav803MqCyCXZNhJHUCVJSveIl6TAc+BrA7abIuY8GA6KkvyDRo63co9qtBRaW2kkoRJyZ5pjtwNTzRVZBP/Fikfrut2ZD/2MaRBWKDyiEV8wYat4pbp8=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CE041A0BE4;
        Mon,  7 Aug 2023 01:45:59 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/5] Staging: rtl8192e: Rename function RxBaInactTimeout
Date:   Sun,  6 Aug 2023 22:47:32 -0700
Message-ID: <20230807054732.1864827-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807054732.1864827-1-tdavies@darkphysics.net>
References: <20230807054732.1864827-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: B0740292-34E5-11EE-9874-C65BE52EC81B-45285927!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function RxBaInactTimeout to rtllib_rx_ba_inact_timeout in order
to Fix checkpatch warning: Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 1eac56fa97f9..0e3372868f97 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -530,7 +530,7 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t)
 			  DELBA_REASON_TIMEOUT);
 }
=20
-void RxBaInactTimeout(struct timer_list *t)
+void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 {
 	struct rx_ts_record *pRxTs =3D from_timer(pRxTs, t,
 					      rx_admitted_ba_record.timer);
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index c57bc0c8816b..24a8b9fc0168 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -154,7 +154,7 @@ void TSInitialize(struct rtllib_device *ieee)
 		pRxTS->num =3D count;
 		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
 		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
-			    RxBaInactTimeout, 0);
+			    rtllib_rx_ba_inact_timeout, 0);
=20
 		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
=20
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e=
/rtllib.h
index 3383dab0d1ca..0c812eb02ba6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2009,7 +2009,7 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ie=
ee,
 			   enum tr_select TxRxSelect);
 void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
-void RxBaInactTimeout(struct timer_list *t);
+void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
 bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 =
*Addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
--=20
2.41.0

