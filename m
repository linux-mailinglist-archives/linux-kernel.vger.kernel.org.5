Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708F7F01DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjKRSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjKRSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4200130;
        Sat, 18 Nov 2023 10:05:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e28724ac88so418370066b.2;
        Sat, 18 Nov 2023 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330715; x=1700935515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StehfMdN64OqQSfteMU1WHeQbOvnHJtoyvxwinO8ko0=;
        b=MW0MBr+gVctwGbvP0/np911QdoIkjwoaRJHqWs+519WubkRGrns3XuX6iWyoxrN9zW
         aRw4r7heaSuZ0CqLW1fyOaxMNO3mKemlmL/DLGLi8MfxDbAdkZEy8Vam72UJf7/+CS3s
         SN4StERQdRlJBdJWJDjq6YUoLmNEJ7Mm+Ydupod/NggtvNDapEguvbI1JkidUaj3VEUr
         yLuF4V4fLUqoDO5lui9uBF32R8kbKR6rFND4F4aNoPGYrNjy7hYBYHsrOSBAUduKMGAj
         Es6zcSZ4AlNIl57PoOdvqt9gaGCK5z+4A2wrIt4ANHNFPlNEKZfNH7D+vZQ4uCc3zDYp
         uDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330715; x=1700935515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StehfMdN64OqQSfteMU1WHeQbOvnHJtoyvxwinO8ko0=;
        b=SP2Z6jRJPUb/pbLRwH5JRd2vckZ7DKJKcsArYTM3fGqZGGeMzkLZpzB+XdXsZ2vmg5
         6X4eQHrYaBuzUQOnP0TKO2PST5FsGzwI3AhAmSKqztGzybLYCMIeNWoy304b70Ff5rZr
         8GTuKXJga61ffjESbU2kFkA9ydMmBidJ/8mzOEvhfAbvx8vqecvvYxGtIzGdvGvJov8z
         dJqBo5HIPehjpeAWLByN5+99I+g7uTp+Ix9In8muaoN7P5PVvU7/T/xLA2laK7sZcfIi
         ZOd3esgtjrhMYBsE1D3wBllOTNeDCJ+DyOVO3Uu75Z8KOzcBKo/3UPcrYjpx7bOjWTU8
         N7CA==
X-Gm-Message-State: AOJu0YwmApl/YGLlCjiJCNm76RlXvsw5+MJ9K7MtUb8CDfvST4stH6uc
        qI+JNnMjgT8OqUc/SDNtZIBwKGJOgzRT1Q==
X-Google-Smtp-Source: AGHT+IG4cOA1GuvjI/7QuVvjlkBUgRgdx2J0Y9YKZ/6BZo6MS1IgJBQw5UKODgCuwBBp7khWNiT7nQ==
X-Received: by 2002:a17:906:2748:b0:9d4:84b6:8715 with SMTP id a8-20020a170906274800b009d484b68715mr2218532ejd.52.1700330715006;
        Sat, 18 Nov 2023 10:05:15 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:14 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] drivers/i2c/busses/i2c-gpio.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:05:00 +0100
Message-ID: <20231118180504.1785-7-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118180504.1785-1-hkallweit1@gmail.com>
References: <20231118180504.1785-1-hkallweit1@gmail.com>
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

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/i2c/busses/i2c-gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index fb35a75fe..df2b183ca 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -444,7 +444,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 
 	adap->algo_data = bit_data;
-	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->class = I2C_CLASS_HWMON;
 	adap->dev.parent = dev;
 	device_set_node(&adap->dev, fwnode);
 

