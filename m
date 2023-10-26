Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F87D881F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjJZSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJZSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:18:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7E1BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:18:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9cc6c92d1e9so36040366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698344303; x=1698949103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTA02l0ubFVwBtbEfhw+KExb6bkxv2C0e8twmLrMufI=;
        b=J0NwBsvC9wBnqtFFoewVnsHvlxPqQTjLUnS6at9Dm+82kS3TWTMaeRLkBbEOzjIJUx
         uRTWkFJWImp/8B5khUz+eP0cdU2kUqaNBQujCgU6VVKzKrjlgDe5xvCGqkPpnZRMPfAE
         7eO5qLHR3wHF2KvkpvPnxP8sqWlX3Ap7g5vcENXnrev9FL4TDP8b24pOgONDJ1rLsj81
         JAbS+kggMFHHCBCG0zke+vPToWOsvRsj4RIVX6it44/g3OaWHOU+7b8KWHX5HAC7O3yP
         oHgPxgTRSmDVTm6BdNyna/erkm2nd4cYHvM132vpU9GmtCQpmK2EVCz2WZs7yKqfyubO
         kqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344303; x=1698949103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTA02l0ubFVwBtbEfhw+KExb6bkxv2C0e8twmLrMufI=;
        b=cpW/uIIoA0cWPsSfEgOatRNXceb72QyKChMZxREj46OtGgh70ryGaQ7ZYwglI9UprT
         ySaU/p7CXBDKtejBJV7aFwU9txD4gZppEEv9na6M7WgLGAx5y6KQxM8YeHhPKb1rBbec
         HFDYwp3ZQDt8a0xe/PYIXvDtWn069KzJ7SxutulgphInbTMfRtuM5npFQVwktL/xl6BP
         vP4J8MOUsa6LV+7Xb3E0F2rD1P80Eh1lAtElN5N/lHqm/pGM/TmAA66EuR/HGmXRmPFB
         1EKDNPfkkERsk09SURbffp9vWe5Bqdzfeha7kWgOc/kjqguih9C85dRiNH/QnLZeDMp5
         Zr0A==
X-Gm-Message-State: AOJu0YxC/LbEX+o77DMYADcjbSSBY0S2f7ZYycHCucUsFQca3G7KgKs+
        +KsvvBbEXF0jkpj3V4xNPvw=
X-Google-Smtp-Source: AGHT+IGb0c8y+EU7pwRJSbuKmhoEYLvnT63W8kJwHC0nVjFBNZz0yidGLURr40R2g12EmezF/bBVmw==
X-Received: by 2002:a17:907:2d27:b0:9c7:5db4:8080 with SMTP id gs39-20020a1709072d2700b009c75db48080mr348999ejc.7.1698344302945;
        Thu, 26 Oct 2023 11:18:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709060e8600b0098e78ff1a87sm11985037ejf.120.2023.10.26.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 11:18:22 -0700 (PDT)
Date:   Thu, 26 Oct 2023 20:18:21 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: rtl8192e: Fix line break issue at
 priv->rx_buf[priv->rx_idx]
Message-ID: <20231026181821.GA21819@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix line break at priv->rx_buf[priv->rx_idx] to increase readability.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d2a8a9543579..995daab906c9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1610,8 +1610,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		skb = new_skb;
 		skb->dev = dev;
 
-		priv->rx_buf[priv->rx_idx] =
-								 skb;
+		priv->rx_buf[priv->rx_idx] = skb;
 		*((dma_addr_t *)skb->cb) = dma_map_single(&priv->pdev->dev,
 							  skb_tail_pointer(skb),
 							  priv->rxbuffersize, DMA_FROM_DEVICE);
-- 
2.42.0

