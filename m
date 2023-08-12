Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B677A25D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjHLUPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHLUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:14:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC0CE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:15:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7023C1BE86;
        Sat, 12 Aug 2023 16:15:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=jDI9LdcLjxhciyvlQxAI0TxXP
        3cRH+KlrKyc6EFAOKk=; b=Jbs8wWgdFjtbebWImwv5in3bu7ANKxfJrnYUTjxN4
        gWTN/KavYkEsQcg/qIXhmrOK1t1ObLLL4x5vqm8nmdUb687UOLJ9cA293S4/i6Sy
        YWlYTrEs+27TYUEZO98bhSjijbRPO14sKnVTwJ4gBNHB9mjmWYWSbQiLmX67BEMN
        Qc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 688FC1BE85;
        Sat, 12 Aug 2023 16:15:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=yl+/X8GENc3EniLq1csMY/Zmd8cTbl/awZpte9T/0Po=; b=HGsYHAjK4EU2BuxEAA0Io82dizW2eot5Kk4RbRauIhbAt65y64blH8aofgqEWx6I36e5h7iuqE8MeyggcwRk3n9+dYldzivmSiVLpPlm31Tc1n1ElBVpQYchXokiHZycQBdHHP8aajj3AZDuhiq9KFb0bO+ur/ZZkmoEl96IQ54=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A662D1BE7F;
        Sat, 12 Aug 2023 16:14:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/16] Staging: rtl8192e: Rename variable pBa in function rx_ts_delete_ba()
Date:   Sat, 12 Aug 2023 13:16:47 -0700
Message-ID: <20230812201702.83421-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812201702.83421-1-tdavies@darkphysics.net>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: E89C0CE4-394C-11EE-9A1A-C2DA088D43B2-45285927!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pBa in function rx_ts_delete_ba() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 0e3372868f97..1eff30533f47 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -41,9 +41,9 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, s=
truct tx_ts_record *pTxTs
 	return bSendDELBA;
 }
=20
-static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_recor=
d *pRxTs)
+static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_recor=
d *rx_ts)
 {
-	struct ba_record *pBa =3D &pRxTs->rx_admitted_ba_record;
+	struct ba_record *pBa =3D &rx_ts->rx_admitted_ba_record;
 	u8			bSendDELBA =3D false;
=20
 	if (pBa->b_valid) {
--=20
2.41.0

