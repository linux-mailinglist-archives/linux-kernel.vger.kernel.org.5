Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922C77A25F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjHLUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHLUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:15:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B303171F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:15:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 252CF1BE91;
        Sat, 12 Aug 2023 16:15:09 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=rYGXxbSdhU9Z32QR5d66cST1v
        ThPGrVy7OD2em5iI7k=; b=pRi9blvYfwL+wRYpLxgCnBVOX7FUXUB6xk4y+2wU7
        v4K2j5YDoVsE3eobcKkTKYBQs0dsGdWDvfVSS61Dgi7jK7oJ6jzLvaAazl2r9UDC
        ij1c94cJlR2aNCcS2MQ66H+aN2CRLjX2fYldbVLX64U7qoz2hhspTsVjNGUrfHmf
        ZI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E6EF1BE90;
        Sat, 12 Aug 2023 16:15:09 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=1noZkKSZpdG7aaAuA4TCJ+X9SuOBc0gHKo1nCLQWRtk=; b=SgutaGcpb2cSmPJ0r0Z/xbpzxZ2Ztc2sMz1MTT+MF0NlHPoOGYGXnXEWF/LI6MGDA3SGM/Mj0Fk0sBQgJVANkjl6x9CjMBLGLZhzoCdoqIScEh83F/THZ70+tdAtwPmxI4kXeuaQdehKBbWCSaLr9fxbTVdukwloSqBiNpZd/W4=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD1F61BE8A;
        Sat, 12 Aug 2023 16:15:03 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
Date:   Sat, 12 Aug 2023 13:16:49 -0700
Message-ID: <20230812201702.83421-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812201702.83421-1-tdavies@darkphysics.net>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: ECE13AC2-394C-11EE-A560-C2DA088D43B2-45285927!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function rtllib_rx_DELBA() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 2748ab59545c..39a5da44b8eb 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -430,9 +430,9 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struc=
t sk_buff *skb)
 	pDelBaParamSet =3D (union delba_param_set *)&delba->payload[2];
=20
 	if (pDelBaParamSet->field.initiator =3D=3D 1) {
-		struct rx_ts_record *pRxTs;
+		struct rx_ts_record *rx_ts;
=20
-		if (!GetTs(ieee, (struct ts_common_info **)&pRxTs, dst,
+		if (!GetTs(ieee, (struct ts_common_info **)&rx_ts, dst,
 			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struc=
t sk_buff *skb)
 			return -1;
 		}
=20
-		rx_ts_delete_ba(ieee, pRxTs);
+		rx_ts_delete_ba(ieee, rx_ts);
 	} else {
 		struct tx_ts_record *pTxTs;
=20
--=20
2.41.0

