Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4F7A913D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIUDVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIUDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259C6ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso228292b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266489; x=1695871289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KASEbjcOhE/m7ePWr35T+nD0DZh8w9pj8YmAibT9zBE=;
        b=hNAajZRpN/j7OTBmmEOsslZL/RwA4LKVgdN729fgXLPrjw/d1yFgyTmk7qqa6bW/OV
         K6xUmNqOPls2BGUEmv3XG6DjQmD3wBmJpsYIQ42JGojhW0zy+93WZScQIoudAi+V0/FB
         lR8aRtqxwgOOEM9ra4fwRyh+bvoADdQGoAWmXMu9Uz+bg/82b3qzFNZC0DbvLDYeXNpx
         quur/DiN79JYJD1dE1trVy5XMGJ8ivRxBnsjt9iTM2taTzbJVRmy4R3dzYtJh1APfxGo
         /8720ywWUG6vLGinNxEfiVMCprxG6SCl5Vnq/qtMOsn0YAqHr+F+Ar4QlvFLuxLyX8wf
         6TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266489; x=1695871289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KASEbjcOhE/m7ePWr35T+nD0DZh8w9pj8YmAibT9zBE=;
        b=gAefh1nfYpTeN4MCGJ/s7ibw1XZnODr/56z7ZVmwHWGKrTUAcfZy8gNkJy/kf4mFpf
         ZgFmmzvqsOfYsc5p+DeY2oAxBurc7MNBVcFEh3CBJsJ7LUiNrmqUUhzj/JweWSZwQ0MV
         hRFg5CbAkfhh1dvUnL/x9Hd3ldBtnTspt6W0VqTl1Zv5ZwCZmKpDRm9etxpJiQLZEcHS
         83eXSIPPBRWbypC/ywcyp14xBu/0nPQ6saSqGMddCEhe/hObe8wkdqxJg/u+mcTEFQnA
         CEWLkeOiu6sYvb/6ODUiyGwhsH2vuockQQ8CN402oL6MBuj8+HundL/oBl6zlf2dgX57
         8yiA==
X-Gm-Message-State: AOJu0YypHGSG9QpSy6C+ld9cjgRL0E+qeEOZjSBaYwkcA0Dre9iqrUJn
        3ItZklUBUB8LfotYkFOgCx601A==
X-Google-Smtp-Source: AGHT+IHTOpTLQVGFk+v9hBQxxH5KVJxj63qlsHnHihr5lTRkcxoDV4HQKHpRmL60fXq0cCvvi7j8GA==
X-Received: by 2002:a05:6a00:248f:b0:68a:53e6:1fed with SMTP id c15-20020a056a00248f00b0068a53e61fedmr4872695pfv.23.1695266489689;
        Wed, 20 Sep 2023 20:21:29 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:29 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/11] Staging: rtl8192e: Rename variable Dst
Date:   Wed, 20 Sep 2023 20:25:08 -0700
Message-ID: <20230921032515.96152-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Dst to dst to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 5642e7788e42..621dbca7716a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -63,7 +63,7 @@ void rtllib_reset_ba_entry(struct ba_record *pBA)
 	pBA->ba_start_seq_ctrl.short_data = 0;
 }
 
-static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
+static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *pBA,
 				    u16 StatusCode, u8 type)
 {
@@ -73,7 +73,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	u16 len = ieee->tx_headroom + 9;
 
 	netdev_dbg(ieee->dev, "%s(): frame(%d) sentd to: %pM, ieee->dev:%p\n",
-		   __func__, type, Dst, ieee->dev);
+		   __func__, type, dst, ieee->dev);
 
 	if (!pBA) {
 		netdev_warn(ieee->dev, "pBA is NULL\n");
@@ -89,7 +89,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 
 	BAReq = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
-	ether_addr_copy(BAReq->addr1, Dst);
+	ether_addr_copy(BAReq->addr1, dst);
 	ether_addr_copy(BAReq->addr2, ieee->dev->dev_addr);
 
 	ether_addr_copy(BAReq->addr3, ieee->current_network.bssid);
-- 
2.39.2

