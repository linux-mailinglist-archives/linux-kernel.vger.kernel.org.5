Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF67EFE99
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjKRIwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjKRIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:52:15 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555CD6D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:52:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bf60bba6f8so75559966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297530; x=1700902330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFd2CKAAw+CngGdGEaZh2Jv1ZJmAu581+YDJTtGJesA=;
        b=a1G6drh3aeMEAESDM4YcZ7g/UMkp1ow0s0vJbIineGzuwp7FCRa6iasVMABZN7h+b/
         RDXieB8ORSOUD1ryMHaUSZZOYmIZtNh8S12ACBV4VN7n4HbuJ9m9sa+dIsT7WtaPqbpN
         M4U58QZwLPpzB9Hkk37lvlA+nJNil/toKRYa6rmFSttpkyq7RisJuVXfLbvnmcd/QR1G
         wH9nsSwOXd1Ow63agvps4YpcMj40YlRJ4NSgJZFmMtRf60+6aOoMzckY9+RShFjtXhna
         YcbPO4OduV34mNulh3WcZVmv6ychfY0J1fyP9gDXB4j9dsn21wIrFdYt0luzMDwSZc9D
         XDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297530; x=1700902330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFd2CKAAw+CngGdGEaZh2Jv1ZJmAu581+YDJTtGJesA=;
        b=Q97H2/81e8Hw86aKYqQ/RqsiYU7mApxdtWIV0eXme+cWxUzAH2dVAdFbM3scBNqQMO
         pqSxoC92zz7+nFzeVUWdrvfUsLuQgf92t6tS349MD+CjIULWsx7ZXJMd6z6ict/ohtpN
         lI/RJQGNjIfp2wcvnHBjAb9CLPAioRvUK0KKuV3SOafMHU63U4tXqRCVKOIJzc5RIbL3
         afI4gzV1Uxs9aCkOOktv2T7HCKPlzWxyUMWrNSrk3t+2eQj3nQZu0vmA0mqEQJVaTAqk
         JuIViwTilv9jhB2+40OwSFYrbeiXHY4RYJAGhWpfwLhcy93L0MUTHghcxf+LP8aX7fqd
         F8NA==
X-Gm-Message-State: AOJu0YyV62Q0xwZtHZxm6Ud95hu31iB/x8JZWg51w022V8Xu0HcwmRT8
        l4l8yEu6GMeRDaTESaOXtyM=
X-Google-Smtp-Source: AGHT+IGnryVDS7JHAkUlNiTu8DrhaiLJgOXSO9KK2u45C9vEI5TrtF4vuz+BwNel21wX6+3v7eGyCQ==
X-Received: by 2002:a17:906:10cf:b0:9cb:b737:e469 with SMTP id v15-20020a17090610cf00b009cbb737e469mr1213341ejv.4.1700297529807;
        Sat, 18 Nov 2023 00:52:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b00985ed2f1584sm1668337ejs.187.2023.11.18.00.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:52:09 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:52:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Remove constant index from
 channel_array[]
Message-ID: <379293f2b48d176aaafb023d36aac9bb057f67c7.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used index of channel_array[] is always COUNTRY_CODE_WORLD_WIDE_13. Remove
index and store only used entry in channel_array. This shortens the code
and increases readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c            | 31 +++-----------------
 drivers/staging/rtl8192e/dot11d.h            |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 37106fd54f00..fdc39e6e7abb 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -12,28 +12,7 @@ struct channel_list {
 	u8      len;
 };
 
-static struct channel_list channel_array[] = {
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 36, 40, 44, 48, 52, 56, 60, 64,
-	  149, 153, 157, 161, 165}, 24},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, 11},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 36, 40, 44, 48, 52, 56,
-	  60, 64}, 21},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 36, 40, 44, 48, 52,
-	  56, 60, 64}, 22},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 36, 40, 44, 48, 52,
-	  56, 60, 64}, 22},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 36, 40, 44, 48, 52,
-	  56, 60, 64}, 22},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 36, 40, 44, 48, 52,
-	 56, 60, 64}, 22},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, 14},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},
-	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 36, 40, 44, 48, 52,
-	  56, 60, 64}, 21}
-};
+static struct channel_list channel_array = {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13};
 
 void dot11d_init(struct rtllib_device *ieee)
 {
@@ -49,7 +28,7 @@ void dot11d_init(struct rtllib_device *ieee)
 }
 EXPORT_SYMBOL(dot11d_init);
 
-void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
+void dot11d_channel_map(struct rtllib_device *ieee)
 {
 	int i;
 
@@ -57,10 +36,8 @@ void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 
 	memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 	       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
-	for (i = 0; i < channel_array[channel_plan].len; i++) {
-		GET_DOT11D_INFO(ieee)->channel_map[channel_array
-				[channel_plan].channel[i]] = 1;
-	}
+	for (i = 0; i < channel_array.len; i++)
+		GET_DOT11D_INFO(ieee)->channel_map[channel_array.channel[i]] = 1;
 
 	for (i = 12; i <= 13; i++)
 		GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 6d2b93acfa43..78d1ca1e7743 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -75,7 +75,7 @@ static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
 #define UPDATE_CIE_WATCHDOG(__ieee_dev) (++GET_CIE_WATCHDOG(__ieee_dev))
 
 void dot11d_init(struct rtllib_device *dev);
-void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee);
+void dot11d_channel_map(struct rtllib_device *ieee);
 void dot11d_reset(struct rtllib_device *dev);
 void dot11d_update_country(struct rtllib_device *dev, u8 *address,
 			   u16 country_len, u8 *country);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 68bd03500267..4b842a1789c2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -796,7 +796,7 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	dot11d_init(priv->rtllib);
-	dot11d_channel_map(COUNTRY_CODE_WORLD_WIDE_13, priv->rtllib);
+	dot11d_channel_map(priv->rtllib);
 	for (i = 1; i <= 11; i++)
 		(priv->rtllib->active_channel_map)[i] = 1;
 	(priv->rtllib->active_channel_map)[12] = 2;
-- 
2.42.0

