Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAD799A65
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjIISUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjIISUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:20:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA6CCE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:20:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso8867125e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283619; x=1694888419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InFO5e10TT39/SdX7ezViSAF4gHuUpUJjSKidTX3SGs=;
        b=mWLt567JS1K0eX29MLXhxJWtqcw4zNf+QT8f3nuEaz8yMA0ZwoarLwbLq6tB+9rRYz
         dF7aV7hxVt2heeHqHGHjoGNOSjFFjQz6+/eRqcPfryIpyQFPsMG0/jesTY/e2gE0O7GU
         O4OJJwyPypMN0wkNqZMV9OiPiW33GnCHYiAA14i9iPfOH+OX/YA0qodBoVvthFrtgxuB
         Vdr0opKtXvXiS02I3aiw2NzvfEKgx6/TIgtvja8W874Tmi05Pu/h9RZZJfIDcuaazG7h
         hHddDwWsJd1BK3vT2xTLwBlPGDTbII29w9h454gZsFHri6tuVtEN1BcgZOUYJEzN0HRu
         +Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283619; x=1694888419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InFO5e10TT39/SdX7ezViSAF4gHuUpUJjSKidTX3SGs=;
        b=JbVLHAbjlw8x742B6+vasomllCB7rFWS00cIDH7xKKqmoTTHZlNfQEPKNYFOyU2jF2
         354IV07qMfPgxLPACJyrCGIIndnQXTYyhdzM7XFvGuPCo5tTlHxzpSN+WUtKB0Jr+om/
         3mRs2FGfZf6cvFAmidWgFOilt4eoYVoIZJZAPtG0xgTtyrTTTZtSt4zO+DR37/0o+p6t
         aoKRzw2k8+e1xeAqka46Ftn/MXWU1EYSYGF5BuPmgVyOblzIWyGSF3vfVZW7FX4ItsB5
         +Elrw1kXMl3AOM2yUC5Qpe0WeU0CfSOcmRVUh08VxGzlWob7G1/1hiKj44Vl+i4Ba5yp
         DaDA==
X-Gm-Message-State: AOJu0YxwN3AoJHa2ycUbRZ6hpQu29Jv2T5KDr+ngbJMDdxWEL89wAn3V
        A5YdysgC2WXhd0rKH1ZXo2TLdIo4yBtzOQ==
X-Google-Smtp-Source: AGHT+IFmHBu6ljIRTmRyYy1SpBZ1gCSVnv+p1A8zib68h/rTIWoSPqEsLOkbDRwo2oE1W8EpBvX7qw==
X-Received: by 2002:a05:600c:1d0a:b0:401:c6a2:3cd5 with SMTP id l10-20020a05600c1d0a00b00401c6a23cd5mr4916851wms.2.1694283619199;
        Sat, 09 Sep 2023 11:20:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b003fe17901fcdsm8447910wme.32.2023.09.09.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:20:18 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:20:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8192e: Replace rtl92e_enable_irq with
 rtl92e_irq_enable
Message-ID: <a2409c0e7dba22035c8bc43b819b837589f50886.1694282907.git.philipp.g.hortmann@gmail.com>
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

Replace rtl92e_enable_irq with rtl92e_irq_enable to increase readability.
priv->irq_enabled = 1 was set in both functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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
2.41.0

