Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111447774D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjHJJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:43:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B21BCF;
        Thu, 10 Aug 2023 02:43:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso5183385ad.2;
        Thu, 10 Aug 2023 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691660612; x=1692265412;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ht3VL/Ute0f0NpKuJCr8WI+TjnXswoA7IO1WC8WBAU=;
        b=Du/F3XNKyw207VcXml+AY4g3uFJ1aRsJY3WvB/ujeTunAkzJfZ6hJuiWmp4ktzf0mq
         cU6wRhW2OijJvyigoCR8PhNMtufVeq8Nr14YOlC6tzLg1rYrAmZW7v9Xoj8T11qgNVlQ
         un7BfkUMf3iQxUscOUPPor5fG/o2zAc+Pz+qqnCLP5Ds0/HRdL5rnvdcnc6JzM06+iw3
         PA2xYtiux/7Yaj+EqNmTfekyWN74aJnJOveipih4yfMzBIrM78hd8863FeEq1+El/t8z
         TGaubqXThoc9zbX4ktmEBIYJlTKSNPlSGmu4pNJ/4H1IyHtarxqun6b0Zbek67OXGgDJ
         98qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660612; x=1692265412;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ht3VL/Ute0f0NpKuJCr8WI+TjnXswoA7IO1WC8WBAU=;
        b=d/VEwYVQTrTvF9FnCn5lcyLwaI+N6lVvogz3bde4WSN4YpyMuaFvJeNHowYLL0mQpL
         qHtcD0XHMeKNeJqS6ZhX79dwYQ4mbDBWSliID+nXGKjUbPJz4veRJbsyk/xojDu3m7W6
         TCcVS0qwhAVEmCurABadXXcwIJWTirUo2OLOUrOw7uj8nf+pmlhs074+MpjgcJBk4ZP9
         Z6w0kyG1Ts2IrBagAdi7hL5D229won29w8gQFd/N4wGf6tmMODAf7+TuTj3wNJx7w3Va
         0L/XdYJ5KS2zRtai4lM3X9Wu1rg64r4s7hApobSTaHVFH7QwW9T3l6Krkl+jcJ3hScg/
         3hpg==
X-Gm-Message-State: AOJu0YyILnu693fiqz59TFZNEDeZQOXDGq6f/6bkLxxNZsATR3HzP51v
        CqqYr64IezEVAIY29MjC8m0=
X-Google-Smtp-Source: AGHT+IEvIA7YB3PfyUgRkmbr8R8VeKGCOJisl2sw+yV7WDIIhnBPkWwkd1EYKsMuvxES1eYW3blvHg==
X-Received: by 2002:a17:902:aa0c:b0:1b8:847d:973a with SMTP id be12-20020a170902aa0c00b001b8847d973amr1486435plb.46.1691660611621;
        Thu, 10 Aug 2023 02:43:31 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001bba3650448sm1233665plb.258.2023.08.10.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:43:31 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v3 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Thu, 10 Aug 2023 17:43:23 +0800
Message-Id: <20230810094323.20077-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230810094323.20077-1-mimi05633@gmail.com>
References: <20230810094323.20077-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- In probe,
  If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
  Else, do nothing
- In set_time,
  If part number is NCT3018Y-R && TWO bit is 0,
    change TWO bit to 1, and restore TWO bit after updating time.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 drivers/rtc/rtc-nct3018y.c | 63 ++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index a4e3f924837e..bac1e3fbbbcd 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -23,6 +23,7 @@
 #define NCT3018Y_REG_CTRL	0x0A /* timer control */
 #define NCT3018Y_REG_ST		0x0B /* status */
 #define NCT3018Y_REG_CLKO	0x0C /* clock out */
+#define NCT3018Y_REG_PART	0x21 /* part info */
 
 #define NCT3018Y_BIT_AF		BIT(7)
 #define NCT3018Y_BIT_ST		BIT(7)
@@ -37,6 +38,7 @@
 #define NCT3018Y_REG_BAT_MASK		0x07
 #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
 #define NCT3018Y_REG_CLKO_CKE		0x80 /* clock out enabled */
+#define NCT3018Y_REG_PART_NCT3018Y	0x02
 
 struct nct3018y {
 	struct rtc_device *rtc;
@@ -52,7 +54,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
 
 	dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
 
-	flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
 	if (flags < 0) {
 		dev_dbg(&client->dev,
 			"Failed to read NCT3018Y_REG_CTRL\n");
@@ -109,8 +111,10 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
 		*alarm_flag = flags & NCT3018Y_BIT_AF;
 	}
 
-	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
-		__func__, *alarm_enable, *alarm_flag);
+	if (alarm_enable && alarm_flag) {
+		dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
+			__func__, *alarm_enable, *alarm_flag);
+	}
 
 	return 0;
 }
@@ -178,7 +182,30 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[4] = {0};
-	int err;
+	int err, part_num, flags, restore_flags = 0;
+
+	part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
+	if (part_num < 0) {
+		dev_dbg(&client->dev, "%s: read error\n", __func__);
+		return part_num;
+	}
+
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
+	if (flags < 0) {
+		dev_dbg(&client->dev, "%s: read error\n", __func__);
+		return flags;
+	}
+
+	/* Check and set TWO bit */
+	if ((part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BIT_TWO)) {
+		restore_flags = 1;
+		flags |= NCT3018Y_BIT_TWO;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
+			return err;
+		}
+	}
 
 	buf[0] = bin2bcd(tm->tm_sec);
 	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
@@ -212,6 +239,18 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* Restore TWO bit */
+	if (restore_flags) {
+		if (part_num & NCT3018Y_REG_PART_NCT3018Y)
+			flags &= ~NCT3018Y_BIT_TWO;
+
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
+			return err;
+		}
+	}
+
 	return err;
 }
 
@@ -479,11 +518,17 @@ static int nct3018y_probe(struct i2c_client *client)
 		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
 	}
 
-	flags = NCT3018Y_BIT_TWO;
-	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
-	if (err < 0) {
-		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
-		return err;
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
+	if (flags < 0) {
+		dev_dbg(&client->dev, "%s: read error\n", __func__);
+		return flags;
+	} else if (flags & NCT3018Y_REG_PART_NCT3018Y) {
+		flags = NCT3018Y_BIT_HF;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
+			return err;
+		}
 	}
 
 	flags = 0;
-- 
2.17.1

