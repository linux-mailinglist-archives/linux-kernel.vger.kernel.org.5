Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17C77A530
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMGwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:52:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB0E54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:52:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D822311FC;
        Sun, 13 Aug 2023 02:52:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=iYEilasCDIxB4mT6D3CLWRD5N
        uzVzzKJ0CTM0oV49CM=; b=RlX/qK/bMFcuYwT/AqWN9ZKfdpi3dcIRLQhdy1Eof
        A934JL2MeHOy15R4jpLBnadLVYKKxRZYXkUxcGSv74n5SguVmT8oL2S2CwcX8kjZ
        0ZWaDq+a8itIE0dYygCu9Ab+Rlo5xRAFUm8A48bhghGY2z78O+63cqkHOIBsxa6x
        hg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2655B311FB;
        Sun, 13 Aug 2023 02:52:43 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=4Iv6gcWf4wn2IRZ3GcvwwS35UjS5hZlrJXQOP0wubr4=; b=qBuT2o6MgFXzehxyjbn0Iiwz1Jr58C4A02yMalgP24euPrQvmi0bZHcv6NZMnCLH5QimcXJP6K91doYtZy6M+l4zKxweLxTUSgY+XxycDZV7Z1ETZbfjE1T0fKJBMkqQ5u/E7z6/IeORllY0mA8ndQVhfLAxrZ5gLIrbHmRXY6s=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55DBC311F7;
        Sun, 13 Aug 2023 02:52:38 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/5] Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
Date:   Sat, 12 Aug 2023 23:54:41 -0700
Message-ID: <20230813065445.95205-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813065445.95205-1-tdavies@darkphysics.net>
References: <20230813065445.95205-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: FE5208FA-39A5-11EE-9596-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function ResetRxTsEntry() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/=
rtl8192e/rtl819x_TSProc.c
index 1c78134fc625..65521bd91b2e 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -113,12 +113,12 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS=
)
 	rtllib_reset_ba_entry(&pTS->TxPendingBARecord);
 }
=20
-static void ResetRxTsEntry(struct rx_ts_record *pTS)
+static void ResetRxTsEntry(struct rx_ts_record *rx_ts)
 {
-	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->rx_indicate_seq =3D 0xffff;
-	pTS->rx_timeout_indicate_seq =3D 0xffff;
-	rtllib_reset_ba_entry(&pTS->rx_admitted_ba_record);
+	ResetTsCommonInfo(&rx_ts->ts_common_info);
+	rx_ts->rx_indicate_seq =3D 0xffff;
+	rx_ts->rx_timeout_indicate_seq =3D 0xffff;
+	rtllib_reset_ba_entry(&rx_ts->rx_admitted_ba_record);
 }
=20
 void TSInitialize(struct rtllib_device *ieee)
--=20
2.41.0

