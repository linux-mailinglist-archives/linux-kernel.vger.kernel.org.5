Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56D777A52E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjHMGtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHMGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:48:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07191171D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:48:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63EC21A3DEB;
        Sun, 13 Aug 2023 02:48:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=PcLXtUljWKv/4ouQcNZrq39h6
        QaqnaGY6jwx/OUHT9o=; b=fM/2ESp5FMd0PMzMhT4EYpFBH7YM3mktWYfRdSuMq
        ON9vaXdXv+qUKtkyZlb9CF/DFHSH/VswJtYQLSDOCtOuxfHHc+OAKKWfG9ERCf5e
        1Pw7GRoxQ5ZsXWiewxT4wTRteXd8NWC0//4v87S1W81v5BBDK78Jx+dh7HC82sFU
        Pw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B8FB1A3DEA;
        Sun, 13 Aug 2023 02:48:54 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=xivH+ZMVje0qkRNh8Vy/E+f0jKARuDcnh8KGiyXJu2E=; b=idL3b1NsJBHsLIbbQHWpLN6FQ8LdCffzaKDN1YXh68mZOZNdQEQ5nqmLp5g0k1ZmRO5H3pi91h313id12apU/RIIg1+GF1CNDX+vljAJtnOZD5r/QBip/T4Fg28N0irxCDtFmiUnFNzE7Bjb/x1UREdq+XxqMmoXrP7O59k0FJE=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBDBD1A3DE6;
        Sun, 13 Aug 2023 02:48:51 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 6/6] Staging: rtl8192e: Rename variable pRxTs in function RxPktPendingTimeout()
Date:   Sat, 12 Aug 2023 23:50:35 -0700
Message-ID: <20230813065035.95157-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813065035.95157-1-tdavies@darkphysics.net>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 777C790A-39A5-11EE-BC63-307A8E0A682E-45285927!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function RxPktPendingTimeout() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2:Resending in smaller patch series
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 32 +++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 24a8b9fc0168..1c78134fc625 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -10,10 +10,10 @@
=20
 static void RxPktPendingTimeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs =3D from_timer(pRxTs, t,
+	struct rx_ts_record *rx_ts =3D from_timer(rx_ts, t,
 						     rx_pkt_pending_timer);
-	struct rtllib_device *ieee =3D container_of(pRxTs, struct rtllib_device=
,
-						  RxTsRecord[pRxTs->num]);
+	struct rtllib_device *ieee =3D container_of(rx_ts, struct rtllib_device=
,
+						  RxTsRecord[rx_ts->num]);
=20
 	struct rx_reorder_entry *pReorderEntry =3D NULL;
=20
@@ -22,24 +22,24 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	bool bPktInBuf =3D false;
=20
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-	if (pRxTs->rx_timeout_indicate_seq !=3D 0xffff) {
-		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
+	if (rx_ts->rx_timeout_indicate_seq !=3D 0xffff) {
+		while (!list_empty(&rx_ts->rx_pending_pkt_list)) {
 			pReorderEntry =3D (struct rx_reorder_entry *)
-					list_entry(pRxTs->rx_pending_pkt_list.prev,
+					list_entry(rx_ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			if (index =3D=3D 0)
-				pRxTs->rx_indicate_seq =3D pReorderEntry->SeqNum;
+				rx_ts->rx_indicate_seq =3D pReorderEntry->SeqNum;
=20
 			if (SN_LESS(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq) ||
+				    rx_ts->rx_indicate_seq) ||
 			    SN_EQUAL(pReorderEntry->SeqNum,
-				     pRxTs->rx_indicate_seq)) {
+				     rx_ts->rx_indicate_seq)) {
 				list_del_init(&pReorderEntry->List);
=20
 				if (SN_EQUAL(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq))
-					pRxTs->rx_indicate_seq =3D
-					      (pRxTs->rx_indicate_seq + 1) % 4096;
+				    rx_ts->rx_indicate_seq))
+					rx_ts->rx_indicate_seq =3D
+					      (rx_ts->rx_indicate_seq + 1) % 4096;
=20
 				netdev_dbg(ieee->dev,
 					   "%s(): Indicate SeqNum: %d\n",
@@ -58,7 +58,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}
=20
 	if (index > 0) {
-		pRxTs->rx_timeout_indicate_seq =3D 0xffff;
+		rx_ts->rx_timeout_indicate_seq =3D 0xffff;
=20
 		if (index > REORDER_WIN_SIZE) {
 			netdev_warn(ieee->dev,
@@ -72,9 +72,9 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		bPktInBuf =3D false;
 	}
=20
-	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq =3D=3D 0xffff)) {
-		pRxTs->rx_timeout_indicate_seq =3D pRxTs->rx_indicate_seq;
-		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
+	if (bPktInBuf && (rx_ts->rx_timeout_indicate_seq =3D=3D 0xffff)) {
+		rx_ts->rx_timeout_indicate_seq =3D rx_ts->rx_indicate_seq;
+		mod_timer(&rx_ts->rx_pkt_pending_timer,  jiffies +
 			  msecs_to_jiffies(ieee->ht_info->rx_reorder_pending_time)
 			  );
 	}
--=20
2.41.0

