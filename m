Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B277A261
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjHLUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjHLUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:15:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D31BD8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:15:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45B491BE97;
        Sat, 12 Aug 2023 16:15:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=nLHCmhK5G+o/Yh9AxXUO2mkr4
        8sS7ndKEBrgdV+qpf8=; b=myn4R/LTiJzf6wgD2MvWplk7etQXS6BMmpLJ28LJC
        1SIiREvJYnYrkTA1ZtoEBfLc7trBsKKz25LcDTAXcxmV8IcsaY3gFFCiZfiOTPcn
        RZNJcsMe68RO72/HdKbxGT7x1h8AfBKfMRy+uCMln1PHCcuz9w4CwZBMXHbMCA6T
        Vg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F5701BE96;
        Sat, 12 Aug 2023 16:15:16 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2019-09.pbsmtp; bh=MABftY3OGQ0Kh2FYSoSozWmIqnJt27w5U6oR5+PjfW8=; b=URH1tEa6ofLbQoNVA9D3UKeVgxMQPrvckPZVNVDh6zkmgJjn4zvsbFVG43PYdN3DHmaYbeJZs6bQhjx5ilGAwijBl0Td9D57IVTTwmdEFXB3R5LhAdzUh6WqEP4hNXS6wpz8iyDYjZb1TRRfjxkp13ExOeD/sJOym88Ssj1ELcw=
Received: from basil.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98F591BE92;
        Sat, 12 Aug 2023 16:15:11 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/16] Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_ba_inact_timeout()
Date:   Sat, 12 Aug 2023 13:16:51 -0700
Message-ID: <20230812201702.83421-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812201702.83421-1-tdavies@darkphysics.net>
References: <20230812201702.83421-1-tdavies@darkphysics.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: F1835E0C-394C-11EE-80C2-C2DA088D43B2-45285927!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename varialbe pRxTs in function rtllib_rx_ba_inact_timeout() to rx_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/=
rtl8192e/rtl819x_BAProc.c
index da2e53dea8e0..d3f1454ba5b0 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -532,13 +532,13 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *=
t)
=20
 void rtllib_rx_ba_inact_timeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs =3D from_timer(pRxTs, t,
+	struct rx_ts_record *rx_ts =3D from_timer(rx_ts, t,
 					      rx_admitted_ba_record.timer);
-	struct rtllib_device *ieee =3D container_of(pRxTs, struct rtllib_device=
,
-				     RxTsRecord[pRxTs->num]);
+	struct rtllib_device *ieee =3D container_of(rx_ts, struct rtllib_device=
,
+				     RxTsRecord[rx_ts->num]);
=20
-	rx_ts_delete_ba(ieee, pRxTs);
-	rtllib_send_DELBA(ieee, pRxTs->ts_common_info.Addr,
-			  &pRxTs->rx_admitted_ba_record, RX_DIR,
+	rx_ts_delete_ba(ieee, rx_ts);
+	rtllib_send_DELBA(ieee, rx_ts->ts_common_info.Addr,
+			  &rx_ts->rx_admitted_ba_record, RX_DIR,
 			  DELBA_REASON_TIMEOUT);
 }
--=20
2.41.0

