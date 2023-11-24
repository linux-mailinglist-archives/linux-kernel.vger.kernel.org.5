Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815D7F712D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjKXKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345564AbjKXKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:31 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33959172E;
        Fri, 24 Nov 2023 02:16:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a011e9bf336so241906066b.3;
        Fri, 24 Nov 2023 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820990; x=1701425790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StehfMdN64OqQSfteMU1WHeQbOvnHJtoyvxwinO8ko0=;
        b=D5oWfcvk3P8eyMO9IRsW2DAAnK9/tQJZn9FNResLz1EgakHQG6tmH5UeZoTidpxKWK
         uWTeXROcjYaZiHk8OiakLYXntaWJody1N9hP1DeTEOp3pODmWiz6tb+zsCY/8sgsSouW
         uz9fmd1upcFd1j34qYeTWVl4oKOivGizitaPihOLqkUjVqhNq35473e1FxL/oCDmrBbX
         /k47iuVxNT3Htu7r93ZwB9Joc0lEKHEgO8EsbX6210G0S80b3Fewi907E8fsUANAeLBY
         lxNWGqhAgo5ulBKhZ2QoPRsf6DsrjD5RLINr/VmDLtI15aTH1RELf+TYRGUlSdKC21WD
         Rzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820990; x=1701425790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StehfMdN64OqQSfteMU1WHeQbOvnHJtoyvxwinO8ko0=;
        b=ImF4xCqP66VoTTcCt9Pb4ec1R1QZqKPivAV4KFGvx0Mglz690YYY/jT9YzhFTVtSr4
         ygug8TRXkAXSmWXT6H+BB9lDaKTmwJU9ZFeGmDZxCX3Uy1cgzXeuvcA7/BZyBt2Jn9mW
         jD1M6oOoRfSM0nYcuAUe8lXbvlLJv2TAnxq7OoSD1M/mxdlcKeMs5RiNIPLB7OM48uv6
         EVNjkoi6vuruf4RitMXSVheGgYq0tFEIqm7+hAaz+o+IVM2/1xjUurS3D4x1CGtHsShR
         hNVBj6NrA4QozZeH1r0lLJaCioSWXrd3npBu2e8uEZKgm2rFDO8XoodzcAUAKJAYXhFs
         gefA==
X-Gm-Message-State: AOJu0YzFWs/7q/PWKpJxMW7Az/yk+wwNk+yKReL24kh64gMqQcpxPIZI
        MLbATP8Vop1/d/IG45VmsN8=
X-Google-Smtp-Source: AGHT+IFo4kpjhjqKsHKXQhHzYemOVp77eLIV5HBj9tx8zE3iH8QI6Kl9uEBbiFo7bp4YMFPcti2JdQ==
X-Received: by 2002:a17:906:f357:b0:a0a:2704:e4f6 with SMTP id hg23-20020a170906f35700b00a0a2704e4f6mr159366ejb.21.1700820989928;
        Fri, 24 Nov 2023 02:16:29 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-72cf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:72cf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b009fbf15cee7fsm1887801ejb.69.2023.11.24.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:16:29 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] i2c: gpio: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Fri, 24 Nov 2023 11:16:15 +0100
Message-ID: <20231124101619.6470-7-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124101619.6470-1-hkallweit1@gmail.com>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
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
 

