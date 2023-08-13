Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467D77A529
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHMGsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHMGsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:48:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF94E54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:48:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16EF21A3DD9;
        Sun, 13 Aug 2023 02:48:42 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uCEB4UTOuYP665ySAfd9c1BvS
        Hb0rWEFjz1u7Ivb5Gk=; b=dfH5ho/xN1hBTXY+y0Ubl2cUFHn0+KNO9gVf6rmdc
        PFaDuw5zFr+BqGP7Dzi5+2OrRulLNMs1+ToNx7DrXTktQQbwicuuzJK7IbBhPPiU
        vMt1gtWtCwBbsX9U1CCBfaHeViOuqo2Y/xvVnDHFU3WTUjjMLh+jWmZvOQPYPBcL
        Ps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F76E1A3DD8;
        Sun, 13 Aug 2023 02:48:42 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=GhnUVZWmEQeXBkgxU0RKp9mDgMhU6CHVk+Jc5KMqd94=; b=ZtqKwDiEeaqK76U6Av/8ptcP3+EHDo/hhxSKeQwT7hfHyQZq/ckdmEno6TO8pD8Hj2XENN+ZWVLR10mW0B4PNlBu13z2U42AMZYpfH0NDn3xTwWHvQo4R/kDhhLfWhPxp2Nu2R8E0yiaJTWTXlU1uihOvyKHc9iBoWTakW5M0IQ=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3B291A3DD2;
        Sun, 13 Aug 2023 02:48:39 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 1/6] Staging: rtl8192e: Rename variable pBa in function rx_ts_delete_ba()
Date:   Sat, 12 Aug 2023 23:50:30 -0700
Message-ID: <20230813065035.95157-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813065035.95157-1-tdavies@darkphysics.net>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 704B7E1A-39A5-11EE-8A15-307A8E0A682E-45285927!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pBa in function rx_ts_delete_ba() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2:Resending in smaller patch series
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

