Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7F799A66
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjIISUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbjIISUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:20:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFA10CA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:20:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso523471f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283613; x=1694888413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=410ZIi1RG8c1PqmFLipRBPm6x8PsGeT8nQJ7mls83l4=;
        b=A4ontzaRgcIXQipAT2NICRoYTS94lZvHWVzTlLCajrS/xICd9hGV92YZposqgUVlUa
         9zp7lGfl96qn46fmv0B0mi2bwHQotI85uE/ERosxStADBIE19WU3g1GDSMlPtxZz4bxc
         /53eZ7gfoNC+xsj/Mf76G1roC2qsYwL318SbI4+lMlV0oIFaNwWKBwzzX4LPnhtR0WJt
         cCNkI6lsMpm+8mroBpDQgPZgMX+IO3xGEh3HeSjnxvVDs9pe7PiygK7FiByTB21oEXEQ
         vxTUrM71bEu/XSa8KiAQnR2EViowh828m2NhnMuQPAN7U/+sb2xreXmvXF5qpoNLiviI
         YfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283613; x=1694888413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=410ZIi1RG8c1PqmFLipRBPm6x8PsGeT8nQJ7mls83l4=;
        b=cHoqIOnrjM6fCGw2yB9sI56C7maDaWjBRkMSv+L4vTObUen5yH/IhWZFviVuE/XzTL
         v7D4XMiIz7TzRFW7hA8kP7uTyMNKIFDPLJzRtO6flgLsBsTAr+oc/UoSSYFpShghAONK
         0BmcwUgGSdyD14Ixna18xyX6ZziG1H7QczS/Y1ujf87w5RsBOyZxqWqij2HTDP+v/sT3
         x7/9/G5cF4UED/FocFEDP8X0niVqomsiZmh3nzXn8oASFHMlMLGsomEtYgsQ4XrjUmuh
         tmkDrJjbBTBGVycOpaCqU0e3gN//x/ZY8sMaLXob2o9v16lNAdfJjC4NomERDd6iILCM
         iKHg==
X-Gm-Message-State: AOJu0YzTj7PVYApyU99ZoLrCbjBejS4Jqlin9HmnKMlwGWKHh1M+Ot86
        wuDqosKcTaaxYyGUsBJpdHE=
X-Google-Smtp-Source: AGHT+IFzDPo7N3GDVdGPJ8yY0Fz5QEfsV6SB/fGm0P3oFoCvLYNmLKWL7xHPcBMhe7Z6mMMiQpyo7w==
X-Received: by 2002:a05:600c:1c91:b0:401:d8a4:17b0 with SMTP id k17-20020a05600c1c9100b00401d8a417b0mr4950184wms.2.1694283613441;
        Sat, 09 Sep 2023 11:20:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003fbdbd0a7desm8388032wmd.27.2023.09.09.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:20:13 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:20:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Replace rtl92e_disable_irq with
 rtl92e_irq_disable
Message-ID: <257624d1aba49a922a8d061e80089b3b9d7d022e.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace rtl92e_disable_irq with rtl92e_irq_disable to increase
readability. priv->irq_enabled = 0 was set in both functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8adf53174239..e0500946dea5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1879,7 +1879,7 @@ void rtl92e_enable_irq(struct net_device *dev)
 	rtl92e_writel(dev, INTA_MASK, priv->irq_mask[0]);
 }
 
-void rtl92e_disable_irq(struct net_device *dev)
+void rtl92e_irq_disable(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 11366fda4ec3..3c06e1da4408 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -17,7 +17,6 @@ void rtl92e_ack_irq(struct net_device *dev, u32 *p_inta);
 void rtl92e_enable_rx(struct net_device *dev);
 void rtl92e_enable_tx(struct net_device *dev);
 void rtl92e_enable_irq(struct net_device *dev);
-void rtl92e_disable_irq(struct net_device *dev);
 void rtl92e_init_variables(struct net_device  *dev);
 void rtl92e_start_beacon(struct net_device *dev);
 void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 50eb8f3494ec..055cd513d76a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -236,15 +236,6 @@ void rtl92e_irq_enable(struct net_device *dev)
 	rtl92e_enable_irq(dev);
 }
 
-void rtl92e_irq_disable(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	rtl92e_disable_irq(dev);
-
-	priv->irq_enabled = 0;
-}
-
 static void _rtl92e_set_chan(struct net_device *dev, short ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-- 
2.41.0

