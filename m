Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F351781BE5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHTA6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHTA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7B7D825
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a7781225b4so1549538b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492330; x=1693097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04bHVEEkcCQfELj7BMGzistsSMzG1MFXGIOcgHixp1Y=;
        b=lWyKD0/Y974RZ9Dke+vF8iXtySRYqZ2OW5RnA/vPXAWz+XzZyLFapjmZOkkX5Pqicq
         hciiXW8VoT51xt3TbIXLK5OQHi/eRsuNDGQ8pVm6wPPUguiNkoOAWbEXT4KMrYKgFzLB
         VKtsGBrPauLLsrQH5MShRRuqtQiLxzrxKY5yLlfxgB4alqlO1sgZfl+zlWiJiyN9Dp4L
         oHm6rQ7BOj3/wg/hvm6bq5j+5eZwlfvqc4ScBdg0yDX0DnmX0i+RVax5wFCyiZAMt79e
         fsLcCIdVk/Se4RdsdwpbbN9hgspQdVOz0GGQZJOsr3+gjkpZHcSkr+UXRf+O6GoSxngy
         saKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492330; x=1693097130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04bHVEEkcCQfELj7BMGzistsSMzG1MFXGIOcgHixp1Y=;
        b=F9OusF92lkaSbVZmahicS49tMyCIc6jfsgAByJjPhguZ4Iq7lWpsghRpWnxI9FY0eq
         M8xVpWS4d2ClJOUnpnPuPXqpYWVglk+Y3vEmkMNV1ahRFXN6Fc+khwjCAURvScF7MmpB
         PZC9CafqMnggwTuzhIzk/bOzx7ilCNlwetiZ2mNS5wZ0J4gXh1OD9BaSYsMrcv6dDqc7
         VtRY0De86UIPz4mKyxwJvxSEyQmOQfYmJRTLsCWdUFkd2C2wK+UVxU5n8BaV09riZGBt
         anU4z9BBWIYiKdi1KCsvcbxElFDVISB3W31URFE4JvmdR6M8E4x6/VXCrJkkaEP4L0wT
         clcQ==
X-Gm-Message-State: AOJu0YwlhL8CAU23HePVzh10hsm/fno3jjLV3447OF+2KPWn3fCp5i1i
        BXT2M81Jeulk7IEyM3s56tL5QQ==
X-Google-Smtp-Source: AGHT+IHtMPqGwgIfqW46Yc3fC8nKTtlYxQaGvqVtg7G6g10VyIsKcrL+Wj2vtkyttvmDfYXo/Wi8Kw==
X-Received: by 2002:a05:6870:fb8a:b0:1bb:6ee1:114e with SMTP id kv10-20020a056870fb8a00b001bb6ee1114emr4173284oab.28.1692492330446;
        Sat, 19 Aug 2023 17:45:30 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:30 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/16] Staging: rtl8192e: Rename variable pRxTS in function rtllib_rx_check_duplicate()
Date:   Sat, 19 Aug 2023 17:47:43 -0700
Message-ID: <20230820004744.278022-16-tdavies@darkphysics.net>
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

Rename variable pRxTS in function rtllib_rx_check_duplicate() to ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index e97debe6a7d2..491789ebcc08 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -922,15 +922,15 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 				return -1;
 		}
 	} else {
-		struct rx_ts_record *pRxTS = NULL;
+		struct rx_ts_record *ts = NULL;
 
-		if (GetTs(ieee, (struct ts_common_info **)&pRxTS, hdr->addr2,
+		if (GetTs(ieee, (struct ts_common_info **)&ts, hdr->addr2,
 			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
-			if ((fc & (1 << 11)) && (frag == pRxTS->rx_last_frag_num) &&
-			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num))
+			if ((fc & (1 << 11)) && (frag == ts->rx_last_frag_num) &&
+			    (WLAN_GET_SEQ_SEQ(sc) == ts->rx_last_seq_num))
 				return -1;
-			pRxTS->rx_last_frag_num = frag;
-			pRxTS->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
+			ts->rx_last_frag_num = frag;
+			ts->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
 		} else {
 			netdev_warn(ieee->dev, "%s(): No TS! Skip the check!\n",
 				    __func__);
-- 
2.41.0

