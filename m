Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566337D7C69
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjJZFoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjJZFoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D519F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c6f0530929so14428666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299054; x=1698903854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNXP1byPvesZdfc6sqLsUl9gM3gqBThouw1QohVxG38=;
        b=cTPLSCj5pBBbnJ7GDsUcW0qoVBdwW6GNKKH9bDn2PoGdIIXkLXtvapFqOZy8nvn0gT
         VSi/0Rrf66bhGIyj32XAIxvZXEZXbmYWUtACQkZHKwlxNbAF0rUrIh8OtHceSVhrdENX
         6Vtv9QZTspzUFXfGllNQew8NxNwplhzQTyJXqlZUwaFH0INhMQ0mjUQSsY7GgSbQb/S8
         06BFgEJxht7GzIXLiRecGN6aHPLDJOhh3j0EJO1WNFT4f2EzBTF0mxzpE4p4H8tAz6p0
         GzONI2vkquHI7SHF00kdw8C/2fF5lIdSdZYF92FXAAn6rKAwyh+knYDqoQaXSWPYHSjN
         po6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299054; x=1698903854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNXP1byPvesZdfc6sqLsUl9gM3gqBThouw1QohVxG38=;
        b=Uq9hNAmDBzDS+o+x7DWO9Av2jBUCJFDH63LXZyksECvomfBnR1mSgCVSK/krFduvJJ
         ceU4v9zkmF1CBgrfBtoFvTu+hnlxo7YKEVrcjrFZc96Gswgibs+RtEx1v+5+zcqbE0NQ
         VaCX5js+BchzwBiUyyMNm3/hD1PLjUdC20JMrMqG3RvmcxIL8OJtUtgyqR7qSpe0I16M
         jPX5ot88EGOvGOZqaLerPRfRbBckinwv04udGlELCL2C+VSwMiRciX/1mLWvN0QXjfSM
         Z+hUwWdh0amMxuW6oqqf8jt/+b6Hu+KxRlnGyqxdUWRBM6CZdduPwzIU9rphMKYa5wjy
         HIvA==
X-Gm-Message-State: AOJu0Yzl6Yx6Gxq704GhNSvTW104aSugpqvdLdDgaMRfqkyXpha2VADX
        TLZqUqLpgCIUKjIrwr8x+OI=
X-Google-Smtp-Source: AGHT+IEUQb7ZEfMb1j7XIWettGwOTwr8B03mIxUOw0AP3WBsKgtvIOnTbNoEuxTSWSEz4NBAAB21Bg==
X-Received: by 2002:a17:906:74d1:b0:9be:3483:94da with SMTP id z17-20020a17090674d100b009be348394damr11842255ejl.1.1698299053674;
        Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ov6-20020a170906fc0600b009ce03057c4dsm1684281ejb.2.2023.10.25.22.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Convert array rx_buf[][] to array
 rx_buf[]
Message-ID: <967337963336cf09383003050b12c43c779e1562.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert array rx_buf[][] to array rx_buf[] as index is always 0. This
increases readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d0d5b1dfff48..573d548e44d8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1145,7 +1145,7 @@ static void _rtl92e_free_rx_ring(struct net_device *dev)
 	int rx_queue_idx = 0;
 
 	for (i = 0; i < priv->rxringcount; i++) {
-		struct sk_buff *skb = priv->rx_buf[rx_queue_idx][i];
+		struct sk_buff *skb = priv->rx_buf[i];
 
 		if (!skb)
 			continue;
@@ -1373,7 +1373,7 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 		if (!skb)
 			return 0;
 		skb->dev = dev;
-		priv->rx_buf[rx_queue_idx][i] = skb;
+		priv->rx_buf[i] = skb;
 		mapping = (dma_addr_t *)skb->cb;
 		*mapping = dma_map_single(&priv->pdev->dev,
 					  skb_tail_pointer(skb),
@@ -1575,7 +1575,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 	while (count--) {
 		struct rx_desc *pdesc = &priv->rx_ring
 					[priv->rx_idx[rx_queue_idx]];
-		struct sk_buff *skb = priv->rx_buf[rx_queue_idx]
+		struct sk_buff *skb = priv->rx_buf
 				      [priv->rx_idx[rx_queue_idx]];
 		struct sk_buff *new_skb;
 
@@ -1614,7 +1614,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		skb = new_skb;
 		skb->dev = dev;
 
-		priv->rx_buf[rx_queue_idx][priv->rx_idx[rx_queue_idx]] =
+		priv->rx_buf[priv->rx_idx[rx_queue_idx]] =
 								 skb;
 		*((dma_addr_t *)skb->cb) = dma_map_single(&priv->pdev->dev,
 							  skb_tail_pointer(skb),
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index caa8a00cc922..2a99873fbe90 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -233,7 +233,7 @@ struct r8192_priv {
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 
 	struct rx_desc *rx_ring;
-	struct sk_buff	*rx_buf[MAX_RX_QUEUE][MAX_RX_COUNT];
+	struct sk_buff	*rx_buf[MAX_RX_COUNT];
 	dma_addr_t	rx_ring_dma[MAX_RX_QUEUE];
 	unsigned int	rx_idx[MAX_RX_QUEUE];
 	int		rxringcount;
-- 
2.42.0

