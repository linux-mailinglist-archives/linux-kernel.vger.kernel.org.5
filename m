Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587377576F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGRIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:45:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E91103;
        Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3583333b3a.3;
        Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689669948; x=1692261948;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CR1YngAZBQYUPSsbWejwgz5QcYsHxChch/OgGgwh/aE=;
        b=XpKAALYMr2citfX+e/SmXXIynMoEuO1elLYhLylxzdDh/aDs0bn16jOM/k+WD6aygo
         YeFhe4uGE5R0ObMd7Zj5MxuMr6TCUna+1MV2omkjFYr7t5gINWMQ7N7gOOxClYqkVEpq
         98GegC2OykOQT6S5b5G5i0py8/jsxa6TwWQA9AwFBQKvql5Lb1UD6HgVi6tP2FvrsK+V
         KFZikVmEZaiCMnb4igIc6pQDK0FbEj6zzTuWgiwwBa+RhV2QZPDIPQ3tRUrAuJFyY8aw
         DuLndeUqphULYnLRH5Sb9JyetLe5CFsl3JMGrSljV92JfBT/j0ToQNaKhC/EwRVk2d/f
         i0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669948; x=1692261948;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CR1YngAZBQYUPSsbWejwgz5QcYsHxChch/OgGgwh/aE=;
        b=luyjSYIbWxZHXBChvkDlF5hajstRUQ1eydOYLrXZ5h+r/tDUzhlJ/V2M110muT3/2S
         fmYi4ppJgvxC7ioaopNKyjKSxR5iff9vCmA0DIi1EOYpa19Sw1Vk9pO8vG+iHbLakfLb
         IH3zyOq+bNwrB/vEfFksmnJ10zdorXNAuEaHgvGRmmXXT/f00FDUXDHlfVzURlszUa52
         tXs6N1gLHKIFPq207xdD3elPisvegnO0FeUkoPi4oGfX8/kkbby8YmSwYf0f2j7yOP34
         qe/FPv1VRi70Bq3eKmDTkS+LpEihRQR8l5NVxv/3zUWPPAJKmBzGNx8n1eEsGe70B89X
         wLJg==
X-Gm-Message-State: ABy/qLa+6DyT5vCEu7PIRnlS1iPhJC+7VTSdpMw/5UGdALBBQkHa6Mi+
        kty+o/3fd5OWhWbfMKFclfY=
X-Google-Smtp-Source: APBJJlEWSej+ZWhjTej9FxL8Z6XsJo4GJFMvstgh7d6+tutmfzdaZG5J+lF6+xRlGdLmjZb3k4Jqhg==
X-Received: by 2002:a05:6a20:7d83:b0:131:44f2:8691 with SMTP id v3-20020a056a207d8300b0013144f28691mr17769623pzj.37.1689669948289;
        Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001b9fef7f454sm1291516plb.73.2023.07.18.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        YHYANG2@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH 1/1] RTC: nuvoton: Modify the setting timing of write ownership
Date:   Tue, 18 Jul 2023 16:45:35 +0800
Message-Id: <20230718084535.11081-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718084535.11081-1-mimi05633@gmail.com>
References: <20230718084535.11081-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the write ownership to default.
- Set the TWO bit to gain write ownership for BMC before it updates time.
- Restore the TWO bit after BMC updates the time.
- Set 24-Hour Format.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 drivers/rtc/rtc-nct3018y.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index a4e3f924837e..e6b06724cdef 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -178,7 +178,19 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[4] = {0};
-	int err;
+	int err, flags, restore_flags = 0;
+
+	/* Check and set TWO bit */
+	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
+	if (!(flags & NCT3018Y_BIT_TWO)) {
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
@@ -212,6 +224,16 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* Restore TWO bit */
+	if (restore_flags) {
+		flags &= ~NCT3018Y_BIT_TWO;
+		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+		if (err < 0) {
+			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
+			return err;
+		}
+	}
+
 	return err;
 }
 
@@ -479,7 +501,7 @@ static int nct3018y_probe(struct i2c_client *client)
 		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
 	}
 
-	flags = NCT3018Y_BIT_TWO;
+	flags = NCT3018Y_BIT_HF;
 	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
 	if (err < 0) {
 		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
-- 
2.17.1

