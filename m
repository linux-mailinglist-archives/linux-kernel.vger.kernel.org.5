Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB5788AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjHYOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjHYOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B402D5D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c3b9f83f4so22784b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972386; x=1693577186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKylAdpbd6bAT6DkmqHJUl+vujDdihaxPwNW91ic0fo=;
        b=Y7Q+sqUaSW3vzJEHdF9uiGaoNUCsojkzB05711djc5hfk2bCCBVBZu/DQpzHk3Zgd0
         44W5Zbpox0fM/UpQcjni+3dTgxeIqAoQeOnu0I02B+OAcU5ZYAlYpNi0uCkXY2U3CS0H
         vUriHbnVlqO5p8I3E9aggkNGOnSworSQHHK/hy28cF0zFB1XqayEFf4qUKCcmP2qctk/
         cmtdC3tjhbiGvjd22nVvkjzi1RQ21LGgGE+9gM5Ac2Mn9QUiiPsoieL/qY3kR0/dyqUD
         C+hvRysiDgF+j8dwaaUknFhtVRqHGzHsx6klVyutHkOlR8HGP1cz1KOdGLUzZzTBUzo/
         Eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972386; x=1693577186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKylAdpbd6bAT6DkmqHJUl+vujDdihaxPwNW91ic0fo=;
        b=ZlBNqHpQo9jbDFaCal5nsdPFzkUNp0nKyfJ5Z0IfT/OQn/Ygvd1pwyGoN2s1FBWwbX
         Jfrk50dmLfW/zqRZrXyQlEwBLGMp233UNKlMrcG2uenPZjCrJRECqmCNHcVhsLHjrV/8
         zCEqhQe+HFlKKj0C9IT9DSMMVa0W6amGsCJZ2SL8RFepEVZVrzyHb7dxxQJwpLMv22en
         lppj/ZfmAspHNIc3ICH/f2viuUPbI8W9deLr1Pod2cQuxOnBQzIDlDXRB59w1KNGcJzF
         ZgOI3/HiaQZThz7eux5p3AZkbbBnzzia1AS4yEb+XEo5G92O/DxsYIUrUzLW6kvDZKuo
         xkGA==
X-Gm-Message-State: AOJu0YwOawQ0P3kocmsyIubhPrHHDaY+BSBLBuoNVwEJ2XyrycxaVb1f
        Kh3G/TYxKrm5yB05CMlsBcwaLQ==
X-Google-Smtp-Source: AGHT+IGgbKwCOlfYMyCws4X06VH/xiXwzjL6b3sf172YAxQgv3qBX3xijGOgSjL5p6or9VVgfWxq9Q==
X-Received: by 2002:a05:6a20:2455:b0:122:10f9:f635 with SMTP id t21-20020a056a20245500b0012210f9f635mr21148928pzc.19.1692972386656;
        Fri, 25 Aug 2023 07:06:26 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:26 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 10/16] Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
Date:   Fri, 25 Aug 2023 07:08:41 -0700
Message-ID: <20230825140847.501113-11-tdavies@darkphysics.net>
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

Rename variable pRxTS in function RemoveTsEntry() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 131a5d7b4599..944970272801 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -364,14 +364,14 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 
 	if (TxRxSelect == RX_DIR) {
 		struct rx_reorder_entry *pRxReorderEntry;
-		struct rx_ts_record *pRxTS = (struct rx_ts_record *)pTs;
+		struct rx_ts_record *ts = (struct rx_ts_record *)pTs;
 
-		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
-			del_timer_sync(&pRxTS->rx_pkt_pending_timer);
+		if (timer_pending(&ts->rx_pkt_pending_timer))
+			del_timer_sync(&ts->rx_pkt_pending_timer);
 
-		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
+		while (!list_empty(&ts->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
-					list_entry(pRxTS->rx_pending_pkt_list.prev,
+					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, List);
 			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
 				   __func__, pRxReorderEntry->SeqNum);
-- 
2.41.0

