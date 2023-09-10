Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8196E799C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 02:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbjIJAVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 20:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjIJAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 20:21:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FA11BD;
        Sat,  9 Sep 2023 17:21:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso28276555ad.1;
        Sat, 09 Sep 2023 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694305260; x=1694910060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yNWeS5XoD0V76y9jaPQRQ2qI+OqmwzE1Ju3S23Gapc=;
        b=HKU7KxpAGNFsmDPNLw7bRTbupuRfM/2n6P9i8D6Lv6dAkjwFAKsks3zdfnMafr3hhx
         ZVeUunuzeJPDc+iZz10VJTx32rTVLwsxeWGfzfz8ciwMAfSpVANm1ryjm7Nof4p8WzQy
         whPsdoEjwmLQOvyrC2BVqUe7UVwUzK7Fsg3+ugb6HS0OwUc5NYPpgwZHaCIsYDNR3/V1
         COZAYgj86o2pTwIj1rW/mstwpI2rW2syFD4Ky0S/VcSh8z2Z6lcBNbclCBsqr6Rfpkez
         VOm+3Jqak/o1gbo6tqMgqEuB8wJcRAEFWLScGpItsDU3ob5lL/Z1SPJE+ISWxA4Mg93K
         oUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694305260; x=1694910060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yNWeS5XoD0V76y9jaPQRQ2qI+OqmwzE1Ju3S23Gapc=;
        b=M5rRAxxzONAx+cOpmjwXavhLb28uILVtR3IxVZanYIac/k+AsrtkzKTkOYoMIUA48w
         I8ACchzIDjO/IDFIFRvOsXr7EI01wKJcy6PqeEdBKb7ihVGUg0xhdUuhDNdZLTPPHyfI
         /gYEmJZL8p/+nZo5qzAReNZ8eUk3vf7cQhnITQmp/0CwVMu9OTTBf/KLNsc2uwsrAUcr
         OHtWbhPACLx34q8wUPNCx5xAfeQo+LrI7KOoaV+ttBy0MzgcqzYTididZoHMRly27zz+
         j/zL89JvtU13YpNSUg08N29psrPwxqgXyIJ+C32AIpGRoWcPwWYyb6i0+wlKtYrwnfVj
         r6GA==
X-Gm-Message-State: AOJu0YyyFlJkpul6G03T2JJ+f211dXpqHt/u6ISgW0BCAFN4KOSiY/o1
        8O0lu5PIs3C8sruwZov33RaPN+Dz0LaT5a0E
X-Google-Smtp-Source: AGHT+IEtlLRtmg2gODlfoWvns5ANrN7Dep1WJAIpThoN5CM2H0IXuU/yaZXA3FAIcI81nO65BiPPNg==
X-Received: by 2002:a17:902:ec88:b0:1c0:d19a:9829 with SMTP id x8-20020a170902ec8800b001c0d19a9829mr6605933plg.25.1694305259688;
        Sat, 09 Sep 2023 17:20:59 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-232.hinet-ip.hinet.net. [220.133.92.232])
        by smtp.googlemail.com with ESMTPSA id e10-20020a170902744a00b001b8943b37a5sm1964790plt.24.2023.09.09.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 17:20:59 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     Jes.Sorensen@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, rtl8821cerfe2@gmail.com,
        pkshih@realtek.com, Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Date:   Sun, 10 Sep 2023 08:20:38 +0800
Message-ID: <20230910002038.56362-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS USB-N13 C1 is a wifi adapter based on a RTL8192FU chip and its LED
doesn't blink with the rtl8xxxu driver. This patch fix this via writing
the correct value to the register "REG_LEDCFG0".

This was tested with these two wifi adapters:
ASUS USB-N13 C1	(vid=0x0b05, pid=0x18f1, rfe_type=0x1)
MERCURY MW310UH	(vid=0x0bda, pid=0xf192, rfe_type=0x5)

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 28e93835e05a..ab6d4e4e228e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -2014,26 +2014,22 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
 	struct rtl8xxxu_priv *priv = container_of(led_cdev,
 						  struct rtl8xxxu_priv,
 						  led_cdev);
-	u16 ledcfg;
+	u32 ledcfg;
 
 	/* Values obtained by observing the USB traffic from the Windows driver. */
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
 
-	ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
-
-	if (brightness == LED_OFF) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7);
-	} else if (brightness == LED_ON) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7) | BIT(11);
-	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
-		/* Value obtained by brute force. */
-		ledcfg = BIT(8) | BIT(9);
-	}
+	/* Enable LED0 GPIO and turn LED0/LED1 off. */
+	ledcfg = (rtl8xxxu_read32(priv, REG_LEDCFG0) | BIT(21)) & ~0xffff;
+
+	/* Values obtained by brute force. */
+	if (brightness == LED_ON)
+		ledcfg |= BIT(3) | BIT(11);
+	else if (brightness == RTL8XXXU_HW_LED_CONTROL)
+		ledcfg |= BIT(0) | BIT(1) | BIT(8) | BIT(9);
 
-	rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
+	rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
 
 	return 0;
 }
-- 
2.42.0

