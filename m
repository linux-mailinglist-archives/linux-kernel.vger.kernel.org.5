Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AB79DDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjIMBhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIMBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:37:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCC115;
        Tue, 12 Sep 2023 18:37:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fe2470d81so1671436b3a.1;
        Tue, 12 Sep 2023 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694569049; x=1695173849; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Qr8W+YNZxo/PHrt3cm26F+6wvNKcFBceX5yhtm3BlE=;
        b=gplgE2NYc29wVpvu6Z9/jlSlWIVqxZ5lR/poNJ0KUCZqj6rSkcst7sH15KbtcbhM+B
         mrsuOIUPdk+MvP12N1rf17JojTUBDky+Dhnnajybd9CnmtdtwyG0or1lqn3JN+v5Y9Nd
         gr6akl/I2e9IzTdpwZgkmpwHIutNIS4n7Zodf89m78Y8ctXNCUZYUoOOdis9URYCeyMo
         8sfA4GJ4W3RMPHb3zXMme7NKOsVkMQqBlL11kcNrJ8AvVtJ8lCm6vFMcUlEAvVDhj2zr
         //USXaue2/jnBz6dD5hDzTZ+RQRB8TxKH1u8q1yZVSI5720F2bod9lhMVChAxiDVybhU
         zewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694569049; x=1695173849;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qr8W+YNZxo/PHrt3cm26F+6wvNKcFBceX5yhtm3BlE=;
        b=case/Ox42GqZ+OmX/0GdN/hunb8xMuPxuvqQyseVjS6uo9KzFyOlcAUIb9h6t4+DFB
         E77vE8LYcMFZs1nOPMb3tTScXOsqBRHc24O/GyS/DQM40U6aAH6Dn+6VyhfdvEChcuBD
         jfB/01aNtChNZss2YzzEHbTUEp1y+S7LDFO+MYzPa8fsIXtW+oUKd1LjBA8+eyaOg+AN
         nKRTse0xwr80Jy/LLlnR7wfZNGsAQWesCkTAemlqj/wMMQh7wmyn8kvvf6MjVqfaH5Fg
         CNyvs3thr2Xv7M7LsWBRxP1WkD3yNviAjJvyGxtZnLPp583+/NskOyD2EN6takb501Lh
         LDJA==
X-Gm-Message-State: AOJu0YwJfMryKc5Bj6Ap98zPRTLaIarheZhHIIYfu3AJP4SgxRymhGPV
        UMyO/gqYHqtlmMl5jqP/gyI=
X-Google-Smtp-Source: AGHT+IGrwyy2AwKKihEq6EvWvFtmbZ20XQE2n5RSWwFYjNLYqUuW7iPocw5YvspS9tY/IjuP9oy94g==
X-Received: by 2002:a05:6a00:1a11:b0:68f:b5cb:ced0 with SMTP id g17-20020a056a001a1100b0068fb5cbced0mr1439599pfv.34.1694569049094;
        Tue, 12 Sep 2023 18:37:29 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b0068a0c403636sm7874648pff.192.2023.09.12.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 18:37:28 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v6 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Wed, 13 Sep 2023 09:37:19 +0800
Message-Id: <20230913013719.8342-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913013719.8342-1-mimi05633@gmail.com>
References: <20230913013719.8342-1-mimi05633@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NCT3015Y-R and NCT3018Y-R use the same datasheet
    but have different topologies as follows.
- Topology (Only 1st i2c can set TWO bit and HF bit)
  In NCT3015Y-R,
    rtc 1st i2c is connected to a host CPU
    rtc 2nd i2c is connected to a BMC
  In NCT3018Y-R,
    rtc 1st i2c is connected to a BMC
    rtc 2nd i2c is connected to a host CPU
In order to be compatible with NCT3015Y-R and NCT3018Y-R,
- In probe,
  If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
  Else, do nothing
- In set_time,
  If part number is NCT3018Y-R && TWO bit is 0,
     change TWO bit to 1, and restore TWO bit after updating time.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index ed4e606be8e5..b006b58e15e2 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -23,6 +23,7 @@
 #define NCT3018Y_REG_CTRL	0x0A /* timer control */
 #define NCT3018Y_REG_ST		0x0B /* status */
 #define NCT3018Y_REG_CLKO	0x0C /* clock out */
+#define NCT3018Y_REG_PART	0x21 /* part info */
 
 #define NCT3018Y_BIT_AF		BIT(7)
 #define NCT3018Y_BIT_ST		BIT(7)
@@ -37,10 +38,12 @@
 #define NCT3018Y_REG_BAT_MASK		0x07
 #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
 #define NCT3018Y_REG_CLKO_CKE		0x80 /* clock out enabled */
+#define NCT3018Y_REG_PART_NCT3018Y	0x02
 
 struct nct3018y {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
+	int part_num;
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw clkout_hw;
 #endif
@@ -177,8 +180,27 @@ static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct nct3018y *nct3018y = dev_get_drvdata(dev);
 	unsigned char buf[4] = {0};
-	int err;
+	int err, flags;
+	int restore_flags = 0;
+
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
+	if (flags < 0) {
+		dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_CTRL.\n");
+		return flags;
+	}
+
+	/* Check and set TWO bit */
+	if ((nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BIT_TWO)) {
+		restore_flags = 1;
+		flags |= NCT3018Y_BIT_TWO;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
+			return err;
+		}
+	}
 
 	buf[0] = bin2bcd(tm->tm_sec);
 	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
@@ -212,6 +234,18 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* Restore TWO bit */
+	if (restore_flags) {
+		if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y)
+			flags &= ~NCT3018Y_BIT_TWO;
+
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
+			return err;
+		}
+	}
+
 	return err;
 }
 
@@ -479,11 +513,17 @@ static int nct3018y_probe(struct i2c_client *client)
 		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
 	}
 
-	flags = NCT3018Y_BIT_TWO;
-	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
-	if (err < 0) {
-		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
-		return err;
+	nct3018y->part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
+	if (nct3018y->part_num < 0) {
+		dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_PART.\n");
+		return nct3018y->part_num;
+	} else if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) {
+		flags = NCT3018Y_BIT_HF;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
+			return err;
+		}
 	}
 
 	flags = 0;
-- 
2.17.1

