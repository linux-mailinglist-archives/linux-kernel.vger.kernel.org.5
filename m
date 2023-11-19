Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134197F0959
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjKSWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKSWPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF59D49
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40a279663a2so10130275e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432104; x=1701036904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW5pjvIHBsT19T4YqQCt3aUKtIVdNobRc7IkJBk4VJ0=;
        b=azFRa3mmxXA8DNc0C6ssY5wTI85M2xjoMbYmh6IPPISAo+y6flfwwksi+PTn2W7M1G
         sd3Oe11QRTC/16MK+rZGqZw9thrYPQN8bq1BRgJ2d041jjlEeXWFgM2O3dhzPOV9VdtY
         VKg79oB4Uryo7zDIL0wHl/3XBHAO1r2WwvFa+9NLr2svN+g6NgRVdasUaN0jNsLjoXXq
         nu5ZM4rTdD+Jz5rMgrUPQLHcPN8LjOuJSXziOSBAQOtXzVRHmPYMSi5iAEXuZHJoSNUg
         hRY/0GQ9PAMJmTNKmo1uC51o4RDaZj3SQklRwdT3wJDY5CvX9yDt50M862Bn/ZrpRM7n
         FYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432104; x=1701036904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW5pjvIHBsT19T4YqQCt3aUKtIVdNobRc7IkJBk4VJ0=;
        b=d6NfNn0CU+ZmtLq6KvyJo5FbL5GRGk/l/HOlfA+7VEOrvDImqJwtxu6vpYaohZIm4w
         ZkShHdVNYHSKzy860bjS3Jzs3w9AIfMkzyZfZlfjGEbiGwfufF0owlFODZaVa51L8qmc
         z/rJ6l/4COss4FwjKPODA7NS+F7MXkOMxkjTRHIpYtg9gtiU2t8hvQPHHjLxuFE/FQS9
         IHLFY6h9NuHygCqbjLcEMf0TW61QZ83AC0PmdUmosjbvGe9rY9jpxY11uVcTNbdETBsI
         XTupwmJubaZaJHRgIuS4wgecABt84YA4C4BkSwwpFYGAa/djgJA3wz5WGP/B+is26A0y
         sudw==
X-Gm-Message-State: AOJu0YxATr1MHKCOxQvwNXcA7CWF2a5oI+UvZBcqQ+K+SU2h5G6i7QjI
        22XWBf2vR/qo5bd9g1OuLcQ=
X-Google-Smtp-Source: AGHT+IHIvpO45+wS0G8kjwufV8asqnLtzug6h6GjBBG9Nd/wYBm09d8I2YJ+K4i+7aTiV2JdhMaQbw==
X-Received: by 2002:a5d:6510:0:b0:332:c6ae:ea10 with SMTP id x16-20020a5d6510000000b00332c6aeea10mr1035615wru.1.1700432103762;
        Sun, 19 Nov 2023 14:15:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0032d886039easm9100269wro.14.2023.11.19.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:03 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] staging: rtl8192e: Remove unused function
 dot11d_reset()
Message-ID: <09306a7f674e0cf1244c47ef8ddfc5ae147124f8.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function dot11d_reset().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 17 -----------------
 drivers/staging/rtl8192e/dot11d.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 95fb56cb77fc..f0241982c7a8 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -42,20 +42,3 @@ void dot11d_channel_map(struct rtllib_device *ieee)
 	ieee->bss_start_channel = 10;
 }
 EXPORT_SYMBOL(dot11d_channel_map);
-
-void dot11d_reset(struct rtllib_device *ieee)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
-	u32 i;
-
-	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(dot11d_info->max_tx_power_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
-	for (i = 1; i <= 11; i++)
-		(dot11d_info->channel_map)[i] = 1;
-	for (i = 12; i <= 14; i++)
-		(dot11d_info->channel_map)[i] = 2;
-	dot11d_info->state = DOT11D_STATE_NONE;
-	dot11d_info->country_len = 0;
-	RESET_CIE_WATCHDOG(ieee);
-}
-
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 9e8328af887c..0ca803be3965 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -72,6 +72,5 @@ static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
 
 void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
-void dot11d_reset(struct rtllib_device *dev);
 
 #endif
-- 
2.42.0

