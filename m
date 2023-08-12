Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB81377A260
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjHLUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjHLUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:15:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7251997
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:15:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB0821BE94;
        Sat, 12 Aug 2023 16:15:12 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=tuxre37dON19QnujLYE2V5rvX
        KdrAkoFaz0FCvGD45A=; b=wsMcOdkW7pZLCvJx/bRNY6+oQhGeCfzqHTnDeDLtn
        WASWf53yqecoClRPV6tkmnycR/wYv5jfK21hVJJJ2oV5zf0rPP2b66u03NRJR+P+
        ea7G503wlWX3cWmxfgEmz061Rs1O29HSqkFvWOII9FiWunsHTvLNZ0hwLc4cm44c
        1Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D46831BE93;
        Sat, 12 Aug 2023 16:15:12 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=hcfIV3fD/3ucaklLQ9pgz2OmKOqrQXlAL/c+Eb2Rtfw=; b=fRNSPa96HdEnUGYq1M6Nbh8Jodlx/q5J/43sOE5IxcHtYjM4h4zrA94SDuQDHlUOC2xEMMvpPve12U3RAL5rQDRYbUQdI9cI63nIK08NpHhjXPGRGRM6AXG1GUgVsgIxh308wxUiCPQunzmqtSvKZ66bZ/xSPAS9oRmoNggC+TU=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9D751BE8E;
        Sat, 12 Aug 2023 16:15:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_ts_init_del_ba()
Date:   Sat, 12 Aug 2023 13:16:50 -0700
Message-ID: <20230812201702.83421-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812201702.83421-1-tdavies@darkphysics.net>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: EF68AD48-394C-11EE-8642-C2DA088D43B2-45285927!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pRxTs in function rtllib_ts_init_del_ba() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index 39a5da44b8eb..da2e53dea8e0 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -499,11 +499,11 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ie=
ee,
 					(&pTxTs->TxPendingBARecord),
 					 TxRxSelect, DELBA_REASON_END_BA);
 	} else if (TxRxSelect =3D=3D RX_DIR) {
-		struct rx_ts_record *pRxTs =3D
+		struct rx_ts_record *rx_ts =3D
 				 (struct rx_ts_record *)pTsCommonInfo;
-		if (rx_ts_delete_ba(ieee, pRxTs))
+		if (rx_ts_delete_ba(ieee, rx_ts))
 			rtllib_send_DELBA(ieee, pTsCommonInfo->Addr,
-					  &pRxTs->rx_admitted_ba_record,
+					  &rx_ts->rx_admitted_ba_record,
 					  TxRxSelect, DELBA_REASON_END_BA);
 	}
 }
--=20
2.41.0

