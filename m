Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD17D7C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjJZFov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbjJZFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD07189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54115c72f78so116127a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299060; x=1698903860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imLoq3QOIDWhZVVFMyITjeWZi//HhodEfugMiQeWmFQ=;
        b=NMnGdXhEBz3HXa38KqE9v8Zi90Xp6CXEk35P4CU6qKf1IuaIuC1D1sSG5nMwDDulrO
         raWH11a1DBOlVE3ljrn7ou+PBw3GT4cJdhWXxyf4qeSAsmbxbDi1NZ207iUzeQJFOW9l
         eOxc79uX3GGR1wY0D4retDWKEptnK3GgaOsWMgqd4u234ekskNAB1R6aBu38JxKYvA+X
         KSfEawE9GjpaORJCk2QsxwMxTsoCPsYPuE4eHXY8HML+XaYG/FTc7C9yfxdzsvkTD6Po
         BZm98IRiew7PbYBRXYJo2ZQUFgFslJUiCvJ/XnieC0+0tSEDMl5Matqkch5cI3vfZM2Z
         NTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299060; x=1698903860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imLoq3QOIDWhZVVFMyITjeWZi//HhodEfugMiQeWmFQ=;
        b=owSo4nkKUYiiUnS+w/auELgDIwD2iCrgJVw94p0c1zpsMdvaWdSnTQWWR2bPfbAp7n
         7DoZTRl0qAL+3EB4s8oWLPCKnVJewAM60QyoxHdvP69MMK5DM1ok1/9IDz89q5EWDvDU
         IhKL0jh3jTCs72RcVvPcjWs/dVfMExit+/iklPEmZ3QuNXeBYJ5grJyUcE8Jtu/iNihi
         yF+kbTwC10jHYd+naO7Tvar++7i4MWDZpkKfff/6+oDrQfGEucITbj4BoGabMPlXpFZq
         IUzbzsjV3/JCdA4qKcw3jGu9TwAjt/Tf9FwAtwDgzAwpvApGgkSKGG11TLA43+cUQxqZ
         6VNg==
X-Gm-Message-State: AOJu0YwTjsiEKAkEaXWWWPu0GJ65Z+X0CCYmF93y+Zf8xDKYlTU1n8ch
        OjkD7ES8rsUcJ1BUJveVl7NYoytXakI=
X-Google-Smtp-Source: AGHT+IHOXgcA1TCybO2sbdaKfI+5D4MQxJngk/NOUAuorwVFoL4JhzWvNNBViBPEB/4sQHXxWbEkkQ==
X-Received: by 2002:a17:906:59a5:b0:9cb:798f:91e8 with SMTP id m37-20020a17090659a500b009cb798f91e8mr5736638ejs.6.1698299059999;
        Wed, 25 Oct 2023 22:44:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090673cd00b00991faf3810esm11261518ejl.146.2023.10.25.22.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:19 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Convert array rx_ring_dma[] to
 variable rx_ring_dma
Message-ID: <51d3be0a715452cefe5ac6dd29a86fbe65b824fa.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert array rx_ring_dma[] to variable rx_ring_dma as index is always 0.
This increases readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e343e10e011a..e93394c51264 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1841,7 +1841,7 @@ void rtl92e_enable_rx(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
-	rtl92e_writel(dev, RDQDA, priv->rx_ring_dma[RX_MPDU_QUEUE]);
+	rtl92e_writel(dev, RDQDA, priv->rx_ring_dma);
 }
 
 static const u32 TX_DESC_BASE[] = {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 573d548e44d8..8af732870ddf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1159,7 +1159,7 @@ static void _rtl92e_free_rx_ring(struct net_device *dev)
 	dma_free_coherent(&priv->pdev->dev,
 			  sizeof(*priv->rx_ring) * priv->rxringcount,
 			  priv->rx_ring,
-			  priv->rx_ring_dma[rx_queue_idx]);
+			  priv->rx_ring_dma);
 	priv->rx_ring = NULL;
 }
 
@@ -1356,7 +1356,7 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 
 	priv->rx_ring = dma_alloc_coherent(&priv->pdev->dev,
 					   sizeof(*priv->rx_ring) * priv->rxringcount,
-					   &priv->rx_ring_dma[rx_queue_idx],
+					   &priv->rx_ring_dma,
 					   GFP_ATOMIC);
 	if (!priv->rx_ring || (unsigned long)priv->rx_ring & 0xFF) {
 		netdev_warn(dev, "Cannot allocate RX ring\n");
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 2a99873fbe90..b3ebff2df62a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -234,7 +234,7 @@ struct r8192_priv {
 
 	struct rx_desc *rx_ring;
 	struct sk_buff	*rx_buf[MAX_RX_COUNT];
-	dma_addr_t	rx_ring_dma[MAX_RX_QUEUE];
+	dma_addr_t	rx_ring_dma;
 	unsigned int	rx_idx[MAX_RX_QUEUE];
 	int		rxringcount;
 	u16		rxbuffersize;
-- 
2.42.0

