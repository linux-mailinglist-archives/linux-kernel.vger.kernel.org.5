Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4179CFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjILL2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjILL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:27:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199621713;
        Tue, 12 Sep 2023 04:27:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-273527a8fdeso3664111a91.2;
        Tue, 12 Sep 2023 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694518036; x=1695122836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFGY1HOJLcFKtWSz4ftiIPAjki9c8ROSkcinsliHSOw=;
        b=VQYY5gfKxFAE1uw9WZKonwiOyTX2W/AjQGbZuE7PabU2kn955IHdU4iJY3+Otr4Lvr
         RRc/z+QPKSMARaUdZTSkvl/MKicorow3aAvT+bxYV3fsvpoMHX6eVzj6o+1JaiQpWttH
         HGElsgw/vFuA138sjTlgLvbY7f+PzSgsiBoU5lsmbL6S3oIy4p0ZSEFl0Prmq40PrJJs
         ntRwu1diqVbWPI+71+X6EI8W9R7qpy/d0LI3svZ/gT5RGikBPQC2JuBSgq32yQUuqXP5
         IRr1yTdrLSPbk6Z35FpOW1lxZV24r0WMXLh+w7Um0YOjuKj4JLA5LMRkqJZYOCptqZl2
         zVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518036; x=1695122836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFGY1HOJLcFKtWSz4ftiIPAjki9c8ROSkcinsliHSOw=;
        b=OjN4DozjOl8mOLNwRxKSBnr0czoIAgXU0G6lGlW59fVyDJuyX9CmBSTNBYjMNAscGJ
         vnDMRkF7kCHMQLpu8Nsi5XVbT0BQByiKtZr46enJQ9W8fDoDy4/XVTOTbh7aoq5DTkki
         gmhRYDnno977hyhxgLo7i0AYWNui1kG+BhTN0jBZ8OorJG/k7XlEf+kDUCBjAQ0rZ7/t
         VvWrL6EXUVSNeD1eA7jzG2lhOyMSS8/5PwGMmY4vwqo9jW1vh0xNS9+1vI2C7EkU+PrX
         SMAIAirmGtlmbm7K+DljdjXlFhv6oPZDCAsHxHyjYxYdRss+P0OYBW/2lE58WlY5HKzF
         socw==
X-Gm-Message-State: AOJu0YxT8Id815yZuUNkkl9SBoX0PD68rABE5clEOQ60jsjMj4nVqTiF
        PjFh7tfAgoSyM4USQtosxifYBVFQxPqLpE4u
X-Google-Smtp-Source: AGHT+IF6fUzyH8IoexQtnIolvXM8MLMPU/gtnwSH0NhMk5guIoN7iMzgxg0T/dWdGT3zMj25pIFKsQ==
X-Received: by 2002:a17:90a:c918:b0:273:ec96:b6f9 with SMTP id v24-20020a17090ac91800b00273ec96b6f9mr7351387pjt.25.1694518036038;
        Tue, 12 Sep 2023 04:27:16 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-232.hinet-ip.hinet.net. [220.133.92.232])
        by smtp.googlemail.com with ESMTPSA id fv23-20020a17090b0e9700b0026d6ad176c6sm1155618pjb.0.2023.09.12.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:27:15 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     Jes.Sorensen@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, rtl8821cerfe2@gmail.com,
        pkshih@realtek.com, Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Date:   Tue, 12 Sep 2023 19:27:09 +0800
Message-ID: <20230912112709.22456-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the RTL8192FU-based wifi adapters use the register "REG_LEDCFG1"
to control the LED, and some of them use the register "REG_LEDCFG0"
instead. Currently rtl8xxxu controls the LED via writing the values
to the register "REG_LEDCFG1" only. This caused a few RTL8192FU-based wifi
adapters's LED don't blink according to the network activity. This patch
will make rtl8xxxu write the correct values to the both register
"REG_LEDCFG0" and "REG_LEDCFG1" to fix this issue.

This was tested with these two wifi adapters:
ASUS USB-N13 C1	(vid=0x0b05, pid=0x18f1, rfe_type=0x1)
MERCURY MW310UH	(vid=0x0bda, pid=0xf192, rfe_type=0x5)

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Explain why to fix the issue in this way in the commit message.
 - Split a long statement into short ones.
 - Use some of the definitions suggested by Ping-Ke Shih.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 26 ++++++++++++-------
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 28e93835e05a..779f93afc22b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -2014,26 +2014,34 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
 	struct rtl8xxxu_priv *priv = container_of(led_cdev,
 						  struct rtl8xxxu_priv,
 						  led_cdev);
-	u16 ledcfg;
+	u32 ledcfg;
 
 	/* Values obtained by observing the USB traffic from the Windows driver. */
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
 	rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
 
-	ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
+	ledcfg = rtl8xxxu_read32(priv, REG_LEDCFG0);
+
+	/* Set LED0 GPIO enabled */
+	ledcfg |= LEDCFG0_LED0_GPIO_ENABLE;
 
 	if (brightness == LED_OFF) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7);
+		/* Setting REG_LEDCFG0[15:0] to 0x0000 turns LED0/LED1 off. */
+		ledcfg &= ~GENMASK(15, 0);
 	} else if (brightness == LED_ON) {
-		/* Value obtained like above. */
-		ledcfg = BIT(1) | BIT(7) | BIT(11);
+		/* Setting REG_LEDCFG0[15:0] to 0x0808 turns LED0/LED1 on. */
+		ledcfg &= ~GENMASK(15, 0);
+		ledcfg |= LEDCFG0_LED1SV | LEDCFG0_LED0SV;
 	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
-		/* Value obtained by brute force. */
-		ledcfg = BIT(8) | BIT(9);
+		/* Setting REG_LEDCFG0[15:0] to 0x0303 enables
+		 * hardware-controlled blinking for LED0/LED1.
+		 * The value 0x0303 is obtained by brute force.
+		 */
+		ledcfg &= ~GENMASK(15, 0);
+		ledcfg |= BIT(9) | BIT(8) | BIT(1) | BIT(0);
 	}
 
-	rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
+	rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 920ee50e2115..5ce845f1d069 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -146,6 +146,9 @@
 #define  GPIO_INTM_EDGE_TRIG_IRQ	BIT(9)
 
 #define REG_LEDCFG0			0x004c
+#define  LEDCFG0_LED0SV			BIT(3)
+#define  LEDCFG0_LED1SV			BIT(11)
+#define  LEDCFG0_LED0_GPIO_ENABLE	BIT(21)
 #define  LEDCFG0_DPDT_SELECT		BIT(23)
 #define REG_LEDCFG1			0x004d
 #define  LEDCFG1_HW_LED_CONTROL		BIT(1)
-- 
2.42.0

