Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF7781BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjHTA6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10137D823
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bd8639e7e5so1325227a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492329; x=1693097129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVP43ZdT+Ah8txpqgYO67dhB2NuYflevUyyp4oWr+Mg=;
        b=I2bQLi96Sufi0VclsAjtNQwD7BuaUlTG5TtgiU+xgRCxO5H7M8T13xegVnQ6gVKfK6
         3sY7VYepiQT4c1zcA0K26kd0rh3FUKlfnD5zGFHD4M4/W1DWee8OAWMqlzXyXau6Z6tw
         /oLhOO9OSJhzhPiA1gTDwjh6QeBqIB4c3+kL1AoUTQSIei9Vp7nu3fu6ZgTPDgdzkSnR
         pEPMhxLZXrP4tgAXI5qMEef3Q2JptqQD0BNIYyOSO26FYBeeYPIadf9XJ2AlsEq5kCaQ
         DTvOMDUXuDu66oyw1jyPd3cZEwEKYfeWrWnFMlZVkGWwZCzt+RM9r7aw6FlTTTFlniUX
         nv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492329; x=1693097129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVP43ZdT+Ah8txpqgYO67dhB2NuYflevUyyp4oWr+Mg=;
        b=VKLkPEzw3LFewDGWh9jmGQn33WJW9oQdo2rgeIc4VfP1Xv70QYxGrnqYEs/qo6xhPS
         eT5dAH/XQPZXQ0vdR4dO6e6qfYPL1qZi93Vw526BiKbnyRXgcSR1J0TyKQ5dNBQPRZab
         Lk8WlyaPxrNt3TUhzmg+2CiPHqexqhR5bXJYRfidASPeJ4VNFH0N9h2NLmMuGsGi9HIN
         OqJo0Fu1nLqeocpmB40bMHqwDxC6CnKT4DEAd2Atkmoie0hlYYdLPBVxb8XDvOq7w4ow
         7DMsr0Kmp28X3clp9B5qkMGnm9fTtwTGjLoCYqECApXnaiCDxurdIoIv5XIJ0F3Zt+R4
         p1Mw==
X-Gm-Message-State: AOJu0YyVNUc58gaU+mAD0FOukpJx/BVHvdUXsFC6jn2hVU8W7x11PFio
        zYd3KuedpypELdaKSfsqgRJjmg==
X-Google-Smtp-Source: AGHT+IGDP5sANo4IhkqOVaphQ3jmgOfa7gbQtfzg9AMb2dBEpYWI98MCngull48D9XaaZK23RS0e5g==
X-Received: by 2002:a05:6870:3307:b0:1b0:b13:c16 with SMTP id x7-20020a056870330700b001b00b130c16mr4720685oae.2.1692492329130;
        Sat, 19 Aug 2023 17:45:29 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:28 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/16] Staging: rtl8192e: Rename variable pTS in function rtllib_FlushRxTsPendingPkts()
Date:   Sat, 19 Aug 2023 17:47:41 -0700
Message-ID: <20230820004744.278022-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
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
---
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

