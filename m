Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85097B5997
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbjJBRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjJBRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4983E5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52f1ece3a76so4651367a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269228; x=1696874028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIcOLQi7rOEZO2zRfMF5D3C/NLGqqczvIFQ3scs6Ros=;
        b=JKBrDt01TuJEWKw0o6jrq3sOEtBd5lgHp4sFHg9gIPIHA2qiIG6NB6BrQ0D9uMnwqu
         SITsTeJ5PD2dMWNIYmdzKDNY0YxdOzfeez1sjzPa5dv76FtH5qRbfPgO6sqSM/8hynku
         BVM6kx6EgiF8YNxZ2GtfE1KUNjOZYrJ2aAXxU2TLg2GVH86WXQu6ARhLmOAhBwUsRkL/
         JTCjUlTNU586A0u/aFIAqpsPHOH664LRJoSyHidXoHhdqtazgHqR+8YColiNPL1S1bqZ
         TGnvH8TG8IaBqGvSxR45Pg8naQIdWYtTzeB+UhrxH1CpUI1hR/vyfzHIsl0zkLFrmzgF
         c3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269228; x=1696874028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIcOLQi7rOEZO2zRfMF5D3C/NLGqqczvIFQ3scs6Ros=;
        b=QcHVWBUdvAmUONbUg1pSejeCNU/Poy5KGVYhlWeAmaNKCl8rigoUNGgaG5XLOLp4q3
         kgOszQNauYV49ZyHfL1gPH0GfOsd0erJMsU235gIN/6h22pPeCveSZCB+70be/tuBULW
         0tuYG0LL0a2XLQW9/ITjOUPED+zqRPwreHVWi/RyVabHcGHFvo/zss2oTDIvt4us980H
         5QhtReWhjQvO2UJ46N2XIDPJnJfur0PMW4tJeZ8G5Xe2P9X5yQKlNhVhQizoRxispf1h
         z9PWaGBY62db79SFZo70Nvwr+OEwh0UNjzv3IDdJW9vwj7WfgAjg7BGH0d03FsZpHOeZ
         pYdA==
X-Gm-Message-State: AOJu0YwbgjstbtCaanSBeK40xSkn1viiYjFLBcxByxuYICFjoO0JPhaD
        +styjoxJUZLdayBSWN+fSK8=
X-Google-Smtp-Source: AGHT+IFiIdAwKQO22SOdobp677I3ry+U9Ko94xzyH8SLb9QIjxzjD2SHLIyvLGR1CzUtGqCLzS1OZw==
X-Received: by 2002:a05:6402:2792:b0:51a:4d46:4026 with SMTP id b18-20020a056402279200b0051a4d464026mr9627644ede.0.1696269227733;
        Mon, 02 Oct 2023 10:53:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402104600b00536e03f62bcsm5772882edu.59.2023.10.02.10.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:47 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8192e: Remove unused/constant parameter
 mesh_flag and shutdown
Message-ID: <5a8f87165b10fd93e3e2fad83ff3380c9f4f22b2.1696266965.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parameters mesh_flag and shutdown of function
rtllib_softmac_stop_protocol(). mesh_flag is unused. shutdown is always
true.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 3 +--
 drivers/staging/rtl8192e/rtllib_softmac.c    | 5 ++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 1f3a2bee247f..4e9a0138ce55 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -655,7 +655,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	_rtl92e_cancel_deferred_work(priv);
 	cancel_delayed_work(&priv->rtllib->hw_wakeup_wq);
 
-	rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
+	rtllib_softmac_stop_protocol(priv->rtllib);
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
 	while (priv->rf_change_in_progress) {
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
@@ -1763,7 +1763,7 @@ void rtl92e_commit(struct net_device *dev)
 
 	if (priv->up == 0)
 		return;
-	rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
+	rtllib_softmac_stop_protocol(priv->rtllib);
 	rtl92e_irq_disable(dev);
 	rtl92e_stop_adapter(dev, true);
 	_rtl92e_up(dev);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bf4ec38efa35..65f29afa81be 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1705,8 +1705,7 @@ void rtllib_DisableNetMonitorMode(struct net_device *dev, bool bInitState);
 void rtllib_EnableIntelPromiscuousMode(struct net_device *dev, bool bInitState);
 void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
 					bool bInitState);
-void rtllib_softmac_stop_protocol(struct rtllib_device *ieee,
-				  u8 mesh_flag, u8 shutdown);
+void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
 void rtllib_softmac_start_protocol(struct rtllib_device *ieee, u8 mesh_flag);
 
 void rtllib_reset_queue(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 777338fd2664..1a086f0ff10d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2279,12 +2279,11 @@ struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee)
 }
 EXPORT_SYMBOL(rtllib_get_beacon);
 
-void rtllib_softmac_stop_protocol(struct rtllib_device *ieee, u8 mesh_flag,
-				  u8 shutdown)
+void rtllib_softmac_stop_protocol(struct rtllib_device *ieee)
 {
 	rtllib_stop_scan_syncro(ieee);
 	mutex_lock(&ieee->wx_mutex);
-	rtllib_stop_protocol(ieee, shutdown);
+	rtllib_stop_protocol(ieee, true);
 	mutex_unlock(&ieee->wx_mutex);
 }
 EXPORT_SYMBOL(rtllib_softmac_stop_protocol);
-- 
2.42.0

