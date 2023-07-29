Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1735767A43
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjG2Axc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjG2AxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7583C07;
        Fri, 28 Jul 2023 17:52:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbf8cb694aso2558885ad.3;
        Fri, 28 Jul 2023 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591910; x=1691196710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEDoSnYN8pIcJUWaBkLfUGpLv63ZtjAclUqLuL9MJWg=;
        b=q97EfmlRSwu7PhjemxZaCZq9kEYkVcmhW57MnL9wCBgBhoK2c5WSIvW4Y0dZ2eKXDZ
         yQUcEqiVVo8USMqplSLn+QSUlnOFnI4BsLhIqNWEwJaqP2Fw6HWOmCjqkH0MGN0QVhUX
         80bd2oBNQ+WtVOsI1Rtm3OkDbFkmwgqaEcDGECYH2T7j/qzzHZMj3TUR1uRZBnzCgz+U
         YrR3ThhkOl2PDgrdyhNYBhKB7HTEXwMX22HnpUAki7nEidPOOha/Wwm3tfmv1cL0ZDtM
         r3ruX0w3bdydCJiG0n14LpCdaS9OG182Xb6ARoUJV/9nNXZ1jpWgtg4Iy5VcKaz+lI4H
         NVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591910; x=1691196710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEDoSnYN8pIcJUWaBkLfUGpLv63ZtjAclUqLuL9MJWg=;
        b=hKk9G/U8IXdF9yeBjHKY+A4hPLzKwKigStqy0EdxubwREDFM733YN5fSiiP5BTzjMK
         vOpDvC0vEJcBVHL/PxxWyIYFrYI9/EYv0QUg+69bm/OJLaYufffLAqlMSvWIdCbronzm
         9WJED5WySRWl2CGo0EkERVnbEtgSTVPfEFotheulTtf4SJNFKCEeel34s6/nQe6wtQvd
         04xevSP3ABxjfBSN1IZwWgQTB1E30hegfQBzm8ryf3/KgGqGbnQomZYDKEm/puU2Ct56
         sHrMeFrwR++CCh7FDaAD6ABQZKU49/JGHoCcOQYnHq0WH80qsn38+J6Wa5WVbIKWgw0G
         Ozqw==
X-Gm-Message-State: ABy/qLZsyL6jJA3SfikyS7O+4rMPtNcT7pa/EqC6D2Iq8goLdvOv0Dza
        XJAkkRA7R58DvDu8R2iFRee5iUOAV+A=
X-Google-Smtp-Source: APBJJlFOKiXh5lBJIX98M2bnZulRSlTRUTQGSYlx77hItApYDn0syyDYQ7kCchQhfRa5xPUOfWaExA==
X-Received: by 2002:a17:902:7b85:b0:1b8:33d4:77f8 with SMTP id w5-20020a1709027b8500b001b833d477f8mr3385406pll.23.1690591909917;
        Fri, 28 Jul 2023 17:51:49 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 17/22] Input: raydium_i2c_ts - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:26 -0700
Message-ID: <20230729005133.1095051-17-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating driver-specific device attributes with
devm_device_add_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 78dd3059d585..13c500e776f6 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1004,7 +1004,7 @@ static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
 
-static struct attribute *raydium_i2c_attributes[] = {
+static struct attribute *raydium_i2c_attrs[] = {
 	&dev_attr_update_fw.attr,
 	&dev_attr_boot_mode.attr,
 	&dev_attr_fw_version.attr,
@@ -1012,10 +1012,7 @@ static struct attribute *raydium_i2c_attributes[] = {
 	&dev_attr_calibrate.attr,
 	NULL
 };
-
-static const struct attribute_group raydium_i2c_attribute_group = {
-	.attrs = raydium_i2c_attributes,
-};
+ATTRIBUTE_GROUPS(raydium_i2c);
 
 static int raydium_i2c_power_on(struct raydium_data *ts)
 {
@@ -1174,14 +1171,6 @@ static int raydium_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev,
-				   &raydium_i2c_attribute_group);
-	if (error) {
-		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
-			error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -1265,6 +1254,7 @@ static struct i2c_driver raydium_i2c_driver = {
 	.id_table = raydium_i2c_id,
 	.driver = {
 		.name = "raydium_ts",
+		.dev_groups = raydium_i2c_groups,
 		.pm = pm_sleep_ptr(&raydium_i2c_pm_ops),
 		.acpi_match_table = ACPI_PTR(raydium_acpi_id),
 		.of_match_table = of_match_ptr(raydium_of_match),
-- 
2.41.0.487.g6d72f3e995-goog

