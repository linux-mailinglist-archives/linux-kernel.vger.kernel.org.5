Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577E57E9A67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjKMKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:38:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE110CB;
        Mon, 13 Nov 2023 02:38:16 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso3519148b3a.1;
        Mon, 13 Nov 2023 02:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871896; x=1700476696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiJlbDV02NWbkvJ5jpVJciv8KDhCisvI4tOyDfm1YJo=;
        b=Q8v7UoUYQkcqwDfXAslEfCmrzsEKWCXVahT6LfzBOGJiye9vmsPGKOdU11TbjBr13A
         nsn/wJP/gfASjvBTKNFAwOYpAejRHNUVtOnIjf3VYbs0W2VCabri2oRVNXcUwuqPcYxa
         I7bJUQNHRjEqAUe4xbP0EHPy8Ip2hz/zJz9mMy//5GuEpMzJUuZ890/0tEzjwKApmRZu
         WeilAPY9pHZr4O6aFMbmfi9IzaHBFHRON/IFCljHDcHGnZBYirSfAMEntqfkkpk3VmUn
         g3cGirpYcYKYa5E2GkveWgRP/QVaPHQGFyq+KChwDVWGtbc4z50RDbyxdZk7XqXQefD2
         iHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871896; x=1700476696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiJlbDV02NWbkvJ5jpVJciv8KDhCisvI4tOyDfm1YJo=;
        b=xDCCxFJMY3J1t9nhLUf+4c1UHQdYPT4AnWuuysH/vMuR5EvWCUwjkg/FZif0lwG/5S
         0hZLBff0gmMY5EbgftHc8FLl/lm4SVkKgtIno92/HYgXyqdUef8yZ7UlYlPwY4ZSrPxd
         wX8uwXH8GqRLE4In/HLhpmzYCzk58bSrJMi+1lZTgvNLMJHiqkFWx3Et5mqjVG1p2uhd
         cerJ1klqIC/PTh5sRXGna0iQVaHjwddtpWHWY4+GACPTkakcmZMP99sv1vTdKOpL/hwE
         clPN84iAblRpBLGxmV4jk9ZbzaAG/NRzJldKLwglkKy2UVxyc3x1Dn7euO9CtXLAePVL
         WOdw==
X-Gm-Message-State: AOJu0Ywhqu2Q9gr4TVARF7jdmTcW9eSwjD+6mcvPF7uKPz4M+ruDdqZV
        Pljp3IrRLBtuoTVlVthrgBk=
X-Google-Smtp-Source: AGHT+IEgJaKwvITNN2ZPUMkM5l5mBI49kYoY6NVeT/wLcHZJtmSH5ONKRabmekhHrtIRzZPlnDRDtw==
X-Received: by 2002:a05:6a21:193:b0:14c:c9f6:d657 with SMTP id le19-20020a056a21019300b0014cc9f6d657mr5114256pzb.22.1699871896057;
        Mon, 13 Nov 2023 02:38:16 -0800 (PST)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bb4-20020a170902bc8400b001c755810f89sm3752593plb.181.2023.11.13.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:38:15 -0800 (PST)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v7 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Mon, 13 Nov 2023 18:38:07 +0800
Message-Id: <20231113103807.1036978-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113103807.1036978-1-mimi05633@gmail.com>
References: <20231113103807.1036978-1-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes since version 7:
  Fix the part number parameter checking issue.

 drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index ed4e606be8e5..f488a189a465 100644
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
+	if (nct3018y->part_num == NCT3018Y_REG_PART_NCT3018Y && !(flags & NCT3018Y_BIT_TWO)) {
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
+		if (nct3018y->part_num == NCT3018Y_REG_PART_NCT3018Y)
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
+	} else if (nct3018y->part_num == NCT3018Y_REG_PART_NCT3018Y) {
+		flags = NCT3018Y_BIT_HF;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
+			return err;
+		}
 	}
 
 	flags = 0;
-- 
2.25.1

