Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3160769064
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGaIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGaIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:38:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C01AC;
        Mon, 31 Jul 2023 01:36:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so3466769a12.1;
        Mon, 31 Jul 2023 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690792585; x=1691397385;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ci0VzxlGA6+Ov1RdRZDEQyvW5emdHSh9T102agzXi3Y=;
        b=iByFOX84+wMG22TRQzFz+umOa4gTfbieZZiqcLVKkfDbE5qIi4wlMk+IwumrHoKGPc
         HSLnzdjmt+awUMEFkKsYnkS7US0XQ1DxbYfQXrMkQyNatxeCs86WGF3KANGwpYQZCSow
         TYOLIQzrJ6y8Rhp+19F0ZbMTRWwaJbAeIuBuozU5iDbQmpT6NJ65p/TTMk2CyOvLAWgL
         wP52n5sNa77G+XapX2ac5+vFhS/lpLqjJVkL6mrRoAOfDWEFwdfaQTQ7tSlreTM3v/NA
         oHQn0Oz8DtRZB0nalthZsQC4/b9wKDYteoQ+2qxs+Lc3TwzvaZXDAW8ABTzTICmPfbXR
         oBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792585; x=1691397385;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci0VzxlGA6+Ov1RdRZDEQyvW5emdHSh9T102agzXi3Y=;
        b=New7nIf4JXW4WZSbqdG1qmhyyemAl+0oMSwzF2HasJmtMgdvAJSusp/ROSHwCuDPtO
         VZvaqNdixFby2/L1oiQK/7P7hBgx4dQiz+Gwoq14UxzHryN4ff66u6LTZ8vGF7BYxWRA
         B0VjHy1mMs/IbWMo6vVuW9hxVQLazjHdwV/2CdaEebxaJcjWFKXRlYQN5r1Hz5bF9rT4
         wn0U/EvgpPGp68rsuFBcgc5CqX28KiBYOVwn6MM21JjFAkbElj9mXmjDd2gokjAGBJHw
         aekX/zk5Rt/3pbzxNfDFsQWb0f6aP77tgRVZ9d92drnPNMcWwZxlT5fhypEKgY2pDq9V
         1eEw==
X-Gm-Message-State: ABy/qLYX5or6AOcErV5BMGddbPqvV92RmkXXTlxQKrJ2xihZ71Hmtlej
        /wAJ+wARh0fd0ZdsYsBgrvo=
X-Google-Smtp-Source: APBJJlEprrbwfvFx6bVXxaXeYgodersvFVGB+JZ3X3ysI4357uil7ha15hH2RZ5x3lpHZJC9vOL3KA==
X-Received: by 2002:a17:90a:318c:b0:267:f1d7:ed68 with SMTP id j12-20020a17090a318c00b00267f1d7ed68mr10517923pjb.14.1690792585213;
        Mon, 31 Jul 2023 01:36:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a4300b00267b7c5d232sm7960162pjl.48.2023.07.31.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:36:24 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        YHYANG2@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v1 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Mon, 31 Jul 2023 16:36:14 +0800
Message-Id: <20230731083614.6074-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230731083614.6074-1-mimi05633@gmail.com>
References: <20230731083614.6074-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
- Add rtc dts property "part-number" to check the chip is matching or not.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 drivers/rtc/rtc-nct3018y.c | 69 +++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index a4e3f924837e..e6d2a5db8733 100644
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
 
@@ -456,6 +495,7 @@ static int nct3018y_probe(struct i2c_client *client)
 {
 	struct nct3018y *nct3018y;
 	int err, flags;
+	const char *part_num = "NCT3015Y-R";
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_BYTE |
@@ -479,11 +519,24 @@ static int nct3018y_probe(struct i2c_client *client)
 		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
 	}
 
-	flags = NCT3018Y_BIT_TWO;
-	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
-	if (err < 0) {
-		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
-		return err;
+	of_property_read_string(client->dev.of_node, "part-number", &part_num);
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
+	if (flags < 0) {
+		dev_dbg(&client->dev, "%s: read error\n", __func__);
+		return flags;
+	} else if (flags & NCT3018Y_REG_PART_NCT3018Y) {
+		if (strcasecmp(part_num, "NCT3018Y-R") != 0)
+			dev_dbg(&client->dev, "%s: part_num=%s but NCT3018Y_REG_PART=0x%2x\n",
+				__func__, part_num, flags);
+		flags = NCT3018Y_BIT_HF;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
+			return err;
+		}
+	} else {
+		dev_dbg(&client->dev, "%s: part_num=%s, NCT3018Y_REG_PART=0x%2x\n",
+			__func__, part_num, flags);
 	}
 
 	flags = 0;
-- 
2.17.1

