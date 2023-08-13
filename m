Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B377A531
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHMGwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHMGws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:52:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A2E1718
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:52:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 990EA311FF;
        Sun, 13 Aug 2023 02:52:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=rbquVzenJ3VYnZO77s96w9s5C
        h/W2aFhBCpHg4s/9Us=; b=lFSGm6XWpINOc6LHN1B/u6YxeHd24Oi/j3E2KFTyH
        KkjvVe3yOuGhM/f2wsRuNLPguEM95+m4qJXqmbu74uGlE0oQe2/3Ws0sLTU7XEwu
        PffCQHP0KOfE04qt97914cUyVPQZ04Rm9zVDSHIdGLgfDlNOewst1y+ZlqMIqEf+
        N0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90FA7311FE;
        Sun, 13 Aug 2023 02:52:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=ycZkzYVI/PP9EoYhwTVq6shDjoWykkUJDt2q/68j414=; b=BDJh14usN+fEB2p8l0o0L8+qKjl7PYWFUk7zxTdlwDgvtGAZ8QPdukSOCfPe1SzHWW/VLCvAXCOW1KLcCOLRjNSHLHdsQMKeM0vTlGe6Yd2kly+SzcM/l0Zx5mqQ450qZsC9FRCC0zapvexYCxwXY5PpdtcOLNemR0IxV60z8bo=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E94B7311FA;
        Sun, 13 Aug 2023 02:52:41 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/5] Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
Date:   Sat, 12 Aug 2023 23:54:42 -0700
Message-ID: <20230813065445.95205-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813065445.95205-1-tdavies@darkphysics.net>
References: <20230813065445.95205-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 00785652-39A6-11EE-BB82-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTS in function TSInitialize() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 65521bd91b2e..423126b23acd 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -124,7 +124,7 @@ static void ResetRxTsEntry(struct rx_ts_record *rx_ts=
)
 void TSInitialize(struct rtllib_device *ieee)
 {
 	struct tx_ts_record *pTxTS  =3D ieee->TxTsRecord;
-	struct rx_ts_record *pRxTS  =3D ieee->RxTsRecord;
+	struct rx_ts_record *rx_ts  =3D ieee->RxTsRecord;
 	struct rx_reorder_entry *pRxReorderEntry =3D ieee->RxReorderEntry;
 	u8				count =3D 0;
=20
@@ -151,17 +151,17 @@ void TSInitialize(struct rtllib_device *ieee)
 	INIT_LIST_HEAD(&ieee->Rx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
 	for (count =3D 0; count < TOTAL_TS_NUM; count++) {
-		pRxTS->num =3D count;
-		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
-		timer_setup(&pRxTS->rx_admitted_ba_record.timer,
+		rx_ts->num =3D count;
+		INIT_LIST_HEAD(&rx_ts->rx_pending_pkt_list);
+		timer_setup(&rx_ts->rx_admitted_ba_record.timer,
 			    rtllib_rx_ba_inact_timeout, 0);
=20
-		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
+		timer_setup(&rx_ts->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
=20
-		ResetRxTsEntry(pRxTS);
-		list_add_tail(&pRxTS->ts_common_info.List,
+		ResetRxTsEntry(rx_ts);
+		list_add_tail(&rx_ts->ts_common_info.List,
 			      &ieee->Rx_TS_Unused_List);
-		pRxTS++;
+		rx_ts++;
 	}
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 	for (count =3D 0; count < REORDER_ENTRY_NUM; count++) {
--=20
2.41.0

