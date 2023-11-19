Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7527F0956
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjKSWOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjKSWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:14:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922812D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso894188f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432084; x=1701036884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx4XEQPLPrhx/0ZC7QuPfqxkRIrwqbWbj56fu2tqSnQ=;
        b=iFQ8W0Esi/fdhX30AmOQzspnlL1Wty1RXgurUYUUghQQkcQgC3DN3d67txHG7hs+D+
         BC9V56WaChmcqNVxoNyiQVNjVc7SotXzONStbOpaAaqRe245JRu4uhRaUyhWexm0X5aX
         eXQz1rEtyNC7Ndn4lO+0HXHKJFU30N+Dm/S5jVC+ZDDrnkaCw0R/iGdd+2+hxiO9/vFe
         E/yl4mkyM7uryVhrTrKgXwv8+k2kaN3WTJwzC4l/HBbdahssn6P70Njy7+fIkAuL1DoT
         SXOKw9f/UAfuPiHNGBhu4VktROFokL11qt5MYYnrwSMn+ym3GIzFifsYI6l259XAbUe6
         Q7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432084; x=1701036884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx4XEQPLPrhx/0ZC7QuPfqxkRIrwqbWbj56fu2tqSnQ=;
        b=i4WVmMcGM5cbPjT8M6D9Oh598l498SL+lcqGG7vgbz3EszNFftjdCnCnUgpT0mGIf+
         xrdRSjnCAmeLwiOg/u79Q0lzhc0yG5Pla3PNB0Ms0nzfSzUThi8FA1JLN8w36AEYepzs
         +mWPaYdBOuGwYJaJXwoOa83idee8ypAAsmWnm4vqV1My6myQ7QLJghFjBgM1iPUeu5gu
         asImwyPQjkgo3ypSdpq7sWmwe3yS/HknfLE5vnbMNWHwih+04GdXTZ2HZcStym+vkSvt
         l1veFhwcD7OG5Bn96phQuI7+nBMdA13XBie8YJFKicc+9VYGACerPKDMQl2CARm15igh
         vYVw==
X-Gm-Message-State: AOJu0YzTGjsKE0NPWS/bGZqIKgMENP226sAkKoyBbUOG6H0+dt4riwWP
        BYRl0w1zVpffsmRLWVwBako=
X-Google-Smtp-Source: AGHT+IEGOSTgNAA/AIqNTAbM1kSCWh+yW5uaqSLyqBFly3Kt4PFthCN/dU8eo+UYkaOIFzi8y67XXw==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr4921697wms.0.1700432083647;
        Sun, 19 Nov 2023 14:14:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b00407efbc4361sm16033038wms.9.2023.11.19.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:14:43 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:14:42 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] staging: rtl8192e: Remove unused function
 dot11d_update_country()
Message-ID: <364462eae2271f3925b362a439ec27d50dd899ef.1700431464.git.philipp.g.hortmann@gmail.com>
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

Remove unused function dot11d_update_country().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 44 -------------------------------
 drivers/staging/rtl8192e/dot11d.h |  2 --
 2 files changed, 46 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index fdc39e6e7abb..fc65a63a4de6 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -61,50 +61,6 @@ void dot11d_reset(struct rtllib_device *ieee)
 	RESET_CIE_WATCHDOG(ieee);
 }
 
-void dot11d_update_country(struct rtllib_device *dev, u8 *address,
-			   u16 country_len, u8 *country)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
-	u8 i, j, number_of_triples, max_channel_number;
-	struct chnl_txpow_triple *triple;
-
-	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(dot11d_info->max_tx_power_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
-	max_channel_number = 0;
-	number_of_triples = (country_len - 3) / 3;
-	triple = (struct chnl_txpow_triple *)(country + 3);
-	for (i = 0; i < number_of_triples; i++) {
-		if (max_channel_number >= triple->first_channel) {
-			netdev_info(dev->dev,
-				    "%s: Invalid country IE, skip it......1\n",
-				    __func__);
-			return;
-		}
-		if (MAX_CHANNEL_NUMBER < (triple->first_channel +
-		    triple->num_channels)) {
-			netdev_info(dev->dev,
-				    "%s: Invalid country IE, skip it......2\n",
-				    __func__);
-			return;
-		}
-
-		for (j = 0; j < triple->num_channels; j++) {
-			dot11d_info->channel_map[triple->first_channel + j] = 1;
-			dot11d_info->max_tx_power_list[triple->first_channel + j] =
-						 triple->max_tx_power;
-			max_channel_number = triple->first_channel + j;
-		}
-
-		triple = (struct chnl_txpow_triple *)((u8 *)triple + 3);
-	}
-
-	UPDATE_CIE_SRC(dev, address);
-
-	dot11d_info->country_len = country_len;
-	memcpy(dot11d_info->country_buffer, country, country_len);
-	dot11d_info->state = DOT11D_STATE_LEARNED;
-}
-
 void dot11d_scan_complete(struct rtllib_device *dev)
 {
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 78d1ca1e7743..39bda2f94eed 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -77,8 +77,6 @@ static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
 void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
 void dot11d_reset(struct rtllib_device *dev);
-void dot11d_update_country(struct rtllib_device *dev, u8 *address,
-			   u16 country_len, u8 *country);
 void dot11d_scan_complete(struct rtllib_device *dev);
 
 #endif
-- 
2.42.0

