Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B97A9143
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIUDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIUDVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:43 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042CF5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ade1c7ffcfso318244b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266496; x=1695871296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezc9OmR5yedthZ9g5F70+CNner2Or9B8MzoP6J9I9Ho=;
        b=i4afTTPj2pmyrMkQKaiFzGPRvCAS/z0Cr500QiTTM7glKkNKpiyawZGvOt2CGVf1ft
         Iz/qsg9shTGmbVdBpegjvUxn7Pt+8LSQyMG5bBuswJ0mNgMk0Lv1XLD9tX6GabFW/I7Z
         dLLlA0/E5Sw1W36jFrgKHkmJ+R4Vq1Xu0ESV5wen4fK5sLDA/ScDH65z6haZFypE1ojG
         /4I69Z26pY2V5+7nZJuATHrHsff8+yiKusCFd24djfLLV7TnWMtEgJG22ckKEueY331y
         4y2ziVFsZCV1sQBCaaQ32jy7aO1vhxCGhzGALFcxl6ZaKxdmqSpM8uK3BjIMwgapWuxn
         PDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266496; x=1695871296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezc9OmR5yedthZ9g5F70+CNner2Or9B8MzoP6J9I9Ho=;
        b=NTsuGxH/ipSIrD7CtKDJwoeMLMjS0QAevc5T0lfU2XlilaOedECBHwrh58slAEixOT
         OCvdfHnS+8uXaa5qDQOHLfRM7R8Zjhq035mh3Hd+KvprJee+KgGgr9W+QkoH8nDEVmXs
         vrZCNELqJvmWryzoGkcuX//W0gGl2Y2zg1P7AtRS6Uv8TWO9Ccem6HpgHQVPjRL0EOxq
         SB+Uo2zVdg+Gv0soEc5lAGlWzMPnJPYxTqABJ5nkoCr9AUf8ockCfbVFo6MEowoQGxR7
         8oV6m9NsS2HmFv39VZMBMURaus7t1P/GX6OgO7Bc0Bgzwbz+G99M3OdOXbwDr/LibGMn
         eCvQ==
X-Gm-Message-State: AOJu0YzdScxd40mZy8yeFKBGEjWFg+Yi88v+O7kbSD2I+hDAjRPoi3QG
        DndzjHmYLZOnnKB3NaWC8okDyA==
X-Google-Smtp-Source: AGHT+IGEJBimbigrOD3g2s4seBK77ByvczbtIpyLEP7HvmmZfcSayeQlh8qqRBIoF88s87CiwZpOpQ==
X-Received: by 2002:a05:6808:1387:b0:3a8:5c24:4ef6 with SMTP id c7-20020a056808138700b003a85c244ef6mr4946471oiw.58.1695266496267;
        Wed, 20 Sep 2023 20:21:36 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:35 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/11] Staging: rtl8192e: Rename function TSInitialize
Date:   Wed, 20 Sep 2023 20:25:14 -0700
Message-ID: <20230921032515.96152-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function TSInitialize to rtllib_ts_init to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index d52deba1f20e..637e22897803 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -120,7 +120,7 @@ static void ResetRxTsEntry(struct rx_ts_record *ts)
 	rtllib_reset_ba_entry(&ts->rx_admitted_ba_record);
 }
 
-void TSInitialize(struct rtllib_device *ieee)
+void rtllib_ts_init(struct rtllib_device *ieee)
 {
 	struct tx_ts_record *pTxTS  = ieee->TxTsRecord;
 	struct rx_ts_record *rxts  = ieee->RxTsRecord;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 727bdcf7455d..c314324720c4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1844,7 +1844,7 @@ void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *pBA);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
 	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
-void TSInitialize(struct rtllib_device *ieee);
+void rtllib_ts_init(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
 void RemovePeerTS(struct rtllib_device *ieee, u8 *addr);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 2416e0c60255..abd6bfd4dfa3 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -128,7 +128,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 
 	HTUpdateDefaultSetting(ieee);
 	HTInitializeHTInfo(ieee);
-	TSInitialize(ieee);
+	rtllib_ts_init(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ieee->ibss_mac_hash[i]);
 
-- 
2.39.2

