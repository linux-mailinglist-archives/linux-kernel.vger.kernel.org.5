Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43429788AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbjHYOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245742AbjHYOHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE42D69
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so359905b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972389; x=1693577189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QevXQoCS1wqQ8jrH7QdGom/cY++tygCz3u7KvlsH/DM=;
        b=IQ64K2avtOzvmOlRAtSIGm9/xoZ49AXYp7+QaP8cgiXIlxQTpqjLJBYxk9JnbeBOjQ
         CZvFU8jSwZMW19cETbcb0fqzsGOZTgliz3v8nIUkfyC4j+WJ5oapHww+2xxjOXghY9pn
         7prSf+xpZYsCg7nE2jmJnA90J0/mGVn8MR8J2wskTtue8wjrsrvILf/1dpEvP0TX+kbe
         jjzY1FaWZmgtUacnm6Xzh0OyBUbsuS7neqB2Hq7rv5w9rn9ZzkCVuNMfjc/UzvyB2c2O
         ZPiZ5/T7b/hc8nFX6INkm2h4IHrERNuytgmm86xglG/dYU8+n7itHTztwXXs8oq27xnN
         onBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972389; x=1693577189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QevXQoCS1wqQ8jrH7QdGom/cY++tygCz3u7KvlsH/DM=;
        b=LBxihPCxmDsL9gZDaLjoxpZWR4yhmKqsAZ/nq8o+oqr0gfi/IToYcPvqe6/GFf+FCk
         TtsgM09zFh22loqY9jI0WSsd5rrTpB2rDxCD6AJIge2TyxXqaLl9Ik6FYG+y6YXGYTSU
         JYkRdymBDU0P3kXaBHqG7EneMs1NCs4+A93TmA3YR8b5LLMEo0fDaLh0rWmAPLD2NBIE
         RS5HCGNhaMcrIHDAENIkPghpJwOR7jLAlYtKtg9FUTD7AS6wSDnhJNII5CS2M1zz5dwf
         c39CIzCi4cFgS6/0jEqs1FeQnb3bE+iezRTf1qMJCcK/fWEiLkdmp0/BCN4/HNcD2AMf
         o47g==
X-Gm-Message-State: AOJu0YxqvRpjFkgWqNET7P8ReKz49XTcCFbiLNaH4MIM/LaQPzOC/Zwp
        wRWGfjD7WE+TdISzk4eFZF1UfQ==
X-Google-Smtp-Source: AGHT+IGLMc2nFABpBMSJuWzj3rAN+uAoGxBJyU6d71j2CKqMY87x1mnlDQW9rFhiOFNhGz30CM3Lmg==
X-Received: by 2002:a05:6a21:33a6:b0:140:a6ec:b55f with SMTP id yy38-20020a056a2133a600b00140a6ecb55fmr23941792pzb.16.1692972389701;
        Fri, 25 Aug 2023 07:06:29 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:29 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 13/16] Staging: rtl8192e: Rename variable pTS in function rtllib_FlushRxTsPendingPkts()
Date:   Fri, 25 Aug 2023 07:08:44 -0700
Message-ID: <20230825140847.501113-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function rtllib_FlushRxTsPendingPkts() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 1d41f62fa346..4907468ddaa5 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -520,13 +520,13 @@ void rtllib_indicate_packets(struct rtllib_device *ieee,
 }
 
 void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *pTS)
+				 struct rx_ts_record *ts)
 {
 	struct rx_reorder_entry *pRxReorderEntry;
 	u8 RfdCnt = 0;
 
-	del_timer_sync(&pTS->rx_pkt_pending_timer);
-	while (!list_empty(&pTS->rx_pending_pkt_list)) {
+	del_timer_sync(&ts->rx_pkt_pending_timer);
+	while (!list_empty(&ts->rx_pending_pkt_list)) {
 		if (RfdCnt >= REORDER_WIN_SIZE) {
 			netdev_info(ieee->dev,
 				    "-------------->%s() error! RfdCnt >= REORDER_WIN_SIZE\n",
@@ -535,7 +535,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 		}
 
 		pRxReorderEntry = (struct rx_reorder_entry *)
-				  list_entry(pTS->rx_pending_pkt_list.prev,
+				  list_entry(ts->rx_pending_pkt_list.prev,
 					     struct rx_reorder_entry, List);
 		netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n", __func__,
 			   pRxReorderEntry->SeqNum);
@@ -549,7 +549,7 @@ void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
 	}
 	rtllib_indicate_packets(ieee, ieee->RfdArray, RfdCnt);
 
-	pTS->rx_indicate_seq = 0xffff;
+	ts->rx_indicate_seq = 0xffff;
 }
 
 static void RxReorderIndicatePacket(struct rtllib_device *ieee,
-- 
2.41.0

