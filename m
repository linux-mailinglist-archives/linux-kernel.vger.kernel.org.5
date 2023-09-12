Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D079D990
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjILT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjILT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0961706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso17515055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546927; x=1695151727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uIdBMaIxfi6eKcNWe6YvWQH/LhS5SQKFcSkjVp8eYk=;
        b=Ot0bbmJQrFw8DUXVvysu6JP/ZmnyQ5nX5otLtQrpXH44WzefRGKd59OsMQl4AM47Bb
         RWK0/SKKdCfHt+iG2wD9LzxSHsV34my1PoZ7du7pg+kLudlwNlnK1q6Xi0CoAvSTgwWy
         RndWoUFSEtHCcXNMd8Sk9hDZh2/tFt2htVpuD2EqbgUVxYqivnd60Fcskty26s7jX0Z2
         S61ZevuF4PF0a+r+UD7FX3Lkw9Z0djS9zMHmdrz97WpHxQCg9XBoT6VSE/fGunavm5/X
         rfz+P9tegOMTpBdSMx1RcheA5bdrHQBR6er+28+QIj9VA1PYO5hde3eoUDXZlcO0gO8b
         P2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546927; x=1695151727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uIdBMaIxfi6eKcNWe6YvWQH/LhS5SQKFcSkjVp8eYk=;
        b=qN+4qCH6g9h1r9cf1OljdKK/dG61XI3WWGgIP8MTXDOSglg1WQDCdxddOYaMSgFvyj
         WGoIXDFUOaqFnqWUSbG7ltBTmJB7ftU6eYFS3uc3VUj0twfxr2UrewAo1oJVqRUZ5GDG
         RJRbmH94kl9+dsgCBeWqOkUos+Ko7cQrPd3UAgeN2TKQv7xs09jHl4HyI7KD1AZiG9b1
         kzvOfibnAYWLWFy9zdb34QCietbP0iSi2G1XesnZawas3TlRa0TM/o0WyYHtXzzEw7OC
         mZ5ppBfQO9kHo1+I1wTcab0AKKTa1MWP3QX0N2H49EbEMihqquCigApNqBYoT7Ctvi8Z
         +SXA==
X-Gm-Message-State: AOJu0YxM5aqx7VO0CUOUBx0PaCzkTMsRsqGo7SsRaIHZET2ow0tvd2/7
        KMY3ieaJ3MjuaB7CewhiuOI=
X-Google-Smtp-Source: AGHT+IFXKi/JHNwHdhcfx1bIIfc9BSEeVB5/r5C+fHpv5d9QsAUx6XVuoEyFuwYKXeLP5JmKd0I0uQ==
X-Received: by 2002:a05:600c:34ce:b0:401:bb6e:453a with SMTP id d14-20020a05600c34ce00b00401bb6e453amr352307wmq.0.1694546927516;
        Tue, 12 Sep 2023 12:28:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c0ad900b003fee567235bsm16953674wmr.1.2023.09.12.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:47 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] staging: rtl8192e: Replace rtl92e_enable_irq with
 rtl92e_irq_enable
Message-ID: <6e8167402d279299e3ccf3468021abb0699d0e8e.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace rtl92e_enable_irq with rtl92e_irq_enable to increase readability.
priv->irq_enabled = 1 was set in both functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Unchanged
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e0500946dea5..70e1eff9c600 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1870,7 +1870,7 @@ rtl92e_init_variables(struct net_device  *dev)
 	priv->bfirst_after_down = false;
 }
 
-void rtl92e_enable_irq(struct net_device *dev)
+void rtl92e_irq_enable(struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 3c06e1da4408..14a091ae1b7d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -16,7 +16,6 @@ bool rtl92e_is_rx_stuck(struct net_device *dev);
 void rtl92e_ack_irq(struct net_device *dev, u32 *p_inta);
 void rtl92e_enable_rx(struct net_device *dev);
 void rtl92e_enable_tx(struct net_device *dev);
-void rtl92e_enable_irq(struct net_device *dev);
 void rtl92e_init_variables(struct net_device  *dev);
 void rtl92e_start_beacon(struct net_device *dev);
 void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 055cd513d76a..63bf8be3fda5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -227,15 +227,6 @@ static void _rtl92e_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	netdev_info(dev, "TXTIMEOUT");
 }
 
-void rtl92e_irq_enable(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	priv->irq_enabled = 1;
-
-	rtl92e_enable_irq(dev);
-}
-
 static void _rtl92e_set_chan(struct net_device *dev, short ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-- 
2.42.0

