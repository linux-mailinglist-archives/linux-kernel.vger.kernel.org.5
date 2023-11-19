Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136F97F095E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjKSWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjKSWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F7170D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e3eaf098f1so110137966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432134; x=1701036934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ael1tKdfqfresRYbM3miMc6lCiPRw9WqecWTMStesZY=;
        b=C0sx2Ylg8Lp4ubEcRvI5uto6Dy+RAvdZAlqXF4HAKmq2djYu4iy2/ndfakNxkzUIsD
         vh/9uJOG2EtN2DtGYEKncdww1Z4ftt4PwbI0RxGR3Bv6HX3JkfWoiWngkTw33Wo20NXa
         ksDsctoO+/7efj88kVDeOoUVql3sB4Y5JGvSYlfUFdqthNbVb/Bq1p8Nml8Kb4sFi7NH
         r5T4BE2Phgqsyfw2Cg64+CBLyeNfdl4/ZkqwEzjS2JudUU/D+F+GbOZk0LgVigiBX+Dh
         qrLe0O0JBBcCC+Q/CbldCiFi7u49arbvv4SgUNRI1X+XPR8l5ByGw18ROG5mg78AZ9SE
         NwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432134; x=1701036934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ael1tKdfqfresRYbM3miMc6lCiPRw9WqecWTMStesZY=;
        b=b1SYC45vNAbI1n/mpER/MIFaUr9cxCFlW6cCALnP/MJ2coUlI3ca6ojRUzT7GMVfHC
         2zuWErqhUePYQxZZ7Jp3WC02UK+6wHPwOaOIufsVoYHZArE1HFna39wCj9/C3qGkgexy
         g+SCV7l3izwyJs2+wdhDtWMgd3t782N1n+RG37nzbC1mqV6dZbmX1so+8k2Sr1jkyyo8
         ezDC4oVbfy7yaMWs7U/geJPIgL1npUIZ8tkkXXwmwBh7xq/UrcAzpngUDek/A4IfymdE
         MtHU0L3zPGHvMnjuDZ45Eb5wlnmpKbXnfVJHMyMVAZaZWaTg5ocHeYSrtBVtEz6s903O
         KxgQ==
X-Gm-Message-State: AOJu0YyIxsg1Q/WaTBwKZ86fNHCW6YJDuPh4WWSoTIUH16sDrp5l3HKI
        TIJK/r4gWNyVzP5fb6tN8ls=
X-Google-Smtp-Source: AGHT+IFIc+7Sjpjpk9g+XxpEuge1OaVTL/eKFf9jWJmtSpAv/pjR+9vMKd1hicUNJXeZaVlyJC4yrQ==
X-Received: by 2002:a17:906:7486:b0:9c4:4b20:44a5 with SMTP id e6-20020a170906748600b009c44b2044a5mr3318304ejl.4.1700432134223;
        Sun, 19 Nov 2023 14:15:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id sd22-20020a170906ce3600b009fbf15cee7fsm1434263ejb.69.2023.11.19.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:34 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] staging: rtl8192e: Remove unused variable
 country_watchdog
Message-ID: <958f2ebbedb51e71e11479f734b4df27484160e1.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

country_watchdog is initialized to 0 and then never changed. Remove
related macros and functions.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 1 -
 drivers/staging/rtl8192e/dot11d.h | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index b524ebe31869..b8ba95a65f27 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -19,7 +19,6 @@ void dot11d_init(struct rtllib_device *ieee)
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 
 	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	RESET_CIE_WATCHDOG(ieee);
 }
 EXPORT_SYMBOL(dot11d_init);
 
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 64fd39cddc22..82748b12bd82 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -25,20 +25,12 @@ struct chnl_txpow_triple {
  */
 
 struct rt_dot11d_info {
-	u8  country_watchdog;
 	u8  channel_map[MAX_CHANNEL_NUMBER + 1];
 };
 
 #define GET_DOT11D_INFO(__ieee_dev)			\
 	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
 
-#define GET_CIE_WATCHDOG(__ieee_dev)				\
-	 (GET_DOT11D_INFO(__ieee_dev)->country_watchdog)
-static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
-{
-	GET_CIE_WATCHDOG(__ieee_dev) = 0;
-}
-
 void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
 
-- 
2.42.0

