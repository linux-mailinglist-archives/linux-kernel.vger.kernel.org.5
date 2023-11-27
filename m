Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8837F98BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjK0FgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjK0FgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67386B5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso4393405ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063380; x=1701668180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoeWuGVtTlW2JdoiNx27SMyvvU67YTUEiN2AiR6Cm+c=;
        b=mT/57NiKZ6mss7wDOlx/z3fRgY7l9MCP4aY/QpRHbsNO5bAzaEoQ1y6QO/0xacazlB
         R1zR341TN43slsu1INErUSQB6r/aeyHvtLm0V09FBD5J3xbsYd9PUL7MBTPyfuoyv2me
         F4pC8i+xyKiMYLkvWGDB1UOJZMuJOdmocJ2WqEmCfHyn6BWHG7KRPOy4Y/Jsyt6ztjBK
         zAPw+/+bes2rzhntzitsci5ZEeLte1SkqFgqEZAc/NbKcLatx/HGu3rfvTVkTy01eLiy
         qGMdbycSFZaxhzH7A4IF+tBrspNZwoztmhAD9uU0U60UwUEmCjBgmvI8j6yQJwB3OCyR
         LPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063380; x=1701668180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoeWuGVtTlW2JdoiNx27SMyvvU67YTUEiN2AiR6Cm+c=;
        b=UYbGDfqvV1LwybhU1qBMQwU61ZlreIzKo6Zb6R6JSnMryHYGIlD1JsqFcfPIL8yhhe
         BkYJeN9xyKkDKRJONZPuBMkWrHrv38+tvnO6FamXu53V4d1yQgZJhfz8qejnIiDMEroM
         l5YhpbG/mL4nCao9bwjZv0hFhbIUADijbaNw7FORbLSEK23FynqVtT8B89LRcAXmkwnF
         yPZgLJgsSbDlsMhDLZFEAIrm1k2STCV5Q9fTHmRx/NVwiObBPyKV7kZBnC3aVrsNoCCz
         x0U/in74mtodLMOyXRFjYlKlUMf6Vv91vU+NHiUA8n87puznL/+n2txPdZXgM6KOF6Ub
         XWPQ==
X-Gm-Message-State: AOJu0Yx8lhAR9e9wRm85zEL9OeqYrrDZOwDjQnWHtE9fBmqra2xPxPf3
        GKH701yZDIajkADRsNuzvX2kgjNHL4ZelnbQ0Xo=
X-Google-Smtp-Source: AGHT+IGwH33yIyeMw5+JjU7swS3KzlABo0WP0t0L2s4Q3aTp+hcLsSMuue5LeZz6wvQJ1xkJ9sR9Ng==
X-Received: by 2002:a17:903:2292:b0:1cf:ba9d:abc0 with SMTP id b18-20020a170903229200b001cfba9dabc0mr5472868plh.67.1701063379679;
        Sun, 26 Nov 2023 21:36:19 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:19 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/15] Staging: rtl8192e: Rename variable Delba
Date:   Sun, 26 Nov 2023 21:42:53 -0800
Message-ID: <20231127054305.148276-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Delba to del_ba to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index f6ba922dc82e..06aaae68aa6a 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -129,7 +129,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 {
 	union delba_param_set DelbaParamSet;
 	struct sk_buff *skb = NULL;
-	struct ieee80211_hdr_3addr *Delba = NULL;
+	struct ieee80211_hdr_3addr *del_ba = NULL;
 	u8 *tag = NULL;
 	u16 len = 6 + ieee->tx_headroom;
 
@@ -148,12 +148,12 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	Delba = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
+	del_ba = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
-	ether_addr_copy(Delba->addr1, dst);
-	ether_addr_copy(Delba->addr2, ieee->dev->dev_addr);
-	ether_addr_copy(Delba->addr3, ieee->current_network.bssid);
-	Delba->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
+	ether_addr_copy(del_ba->addr1, dst);
+	ether_addr_copy(del_ba->addr2, ieee->dev->dev_addr);
+	ether_addr_copy(del_ba->addr3, ieee->current_network.bssid);
+	del_ba->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
 
 	tag = skb_put(skb, 6);
 
-- 
2.39.2

