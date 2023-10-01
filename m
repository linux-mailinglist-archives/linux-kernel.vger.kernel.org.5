Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7C7B47AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjJANpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJANpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11DAF9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso3906801a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167915; x=1696772715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBUFu7bxKPi5/cjKbiiUEWg33kyTMQhk/fPobqwOVM=;
        b=Lz7yxkOZaGCzErCAZktYSi5zUAFhNAVzh+rAabUMQXMg9jeoY9t8n4xDtg/+7NpQT+
         JknN5UVJFCftDjtCw/4GQ/dey0E1roeMgmg9dFLaQMdm4oSK+igfAsoPPBXlNShJgZM7
         mtFmeOpYL+gZy2USXt2KyVmjCZtOn0BKPldib20Hfl1gJFKzyMJsV7HUwVmRXuftyK1j
         52Zu6jYAJTGfvIMJQXD5kSK3CFpY3na6pGFKb7UawvJjUa3zzyOUVKvYV+JiodmM6inf
         NDx3hph3POyzyBx+AluwNj1LXygm9k/8h30SP2B9KtM3Fg76x0mliolIKtz+SVuR+due
         /jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167915; x=1696772715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJBUFu7bxKPi5/cjKbiiUEWg33kyTMQhk/fPobqwOVM=;
        b=awSLH0aZYgTyesEAm9Lw5XemrDO3WrT0gPwLThhLHFg5jii30ckCxZepVo/I+RauSE
         pK0wEth5ykVgRypOusPx+ypLT9GbTUND+orltpeuqCTqGnrx+aSKXwx/yjw1baPCqx9s
         CQl5bBacbGL4OADGj1GRksUKIyxCWmlPgJMg4nGp/TrK0kDuBmhxkFENBFV7axENwM7A
         DPXd1o+JeK0Z4vHwBaCKXntQejHDqXGBVuzUs+zaatcURB73WDU6ctAtnBA8bvO5Z0Ay
         7GnS3wTdCga5BD6Fb9u0oVqcWekOny++nd3J6CNQ27iegI7iHuievPXqYoybyjJOxuc/
         ykNg==
X-Gm-Message-State: AOJu0Ywn0+3aJewF+0ND6H9aTGXqsnp1IJCuI1nXcBkWHSDThdmGOU6K
        GvsMdiCufoKl9Um1n+/z6To=
X-Google-Smtp-Source: AGHT+IFO2Ur+EotY/d0w3fxqHOa31udA1k4+93ugAEuEW89WOrwJhtH9oB7TiA9qwOkFbIN4dz/tEg==
X-Received: by 2002:a05:6402:4403:b0:523:220e:a6ca with SMTP id y3-20020a056402440300b00523220ea6camr9357263eda.3.1696167915126;
        Sun, 01 Oct 2023 06:45:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402032800b00522828d438csm14009728edw.7.2023.10.01.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:45:14 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:45:13 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove unused variable
 is_silent_reset
Message-ID: <124d8f91db347e0e35184b356ba4ec39f52871cb.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ieee->is_silent_reset is set to false and never changed. All
equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c | 10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index aa198983cb3c..004818520ea8 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1211,7 +1211,6 @@ struct rtllib_device {
 	bool	bForcedBgMode;
 
 	u8 hwsec_active;
-	bool is_silent_reset;
 	bool is_roaming;
 	bool ieee_up;
 	bool cannot_notify;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 72d0225dfdf1..777338fd2664 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1298,10 +1298,8 @@ static void rtllib_associate_complete_wq(void *data)
 
 	netdev_info(ieee->dev, "Associated successfully with %pM\n",
 		    ieee->current_network.bssid);
-	if (!ieee->is_silent_reset) {
-		netdev_info(ieee->dev, "normal associate\n");
-		notify_wx_assoc_event(ieee);
-	}
+	netdev_info(ieee->dev, "normal associate\n");
+	notify_wx_assoc_event(ieee);
 
 	netif_carrier_on(ieee->dev);
 	ieee->is_roaming = false;
@@ -1334,10 +1332,6 @@ static void rtllib_associate_complete_wq(void *data)
 	psc->LpsIdleCount = 0;
 	ieee->link_change(ieee->dev);
 
-	if (ieee->is_silent_reset) {
-		netdev_info(ieee->dev, "silent reset associate\n");
-		ieee->is_silent_reset = false;
-	}
 }
 
 static void rtllib_sta_send_associnfo(struct rtllib_device *ieee)
-- 
2.42.0

