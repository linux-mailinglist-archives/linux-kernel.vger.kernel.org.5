Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05587F019D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKRRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjKRRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:42:47 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260B10C9;
        Sat, 18 Nov 2023 09:42:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c83d37a492so38064591fa.3;
        Sat, 18 Nov 2023 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329359; x=1700934159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gja50uK+VGu03YOVtNxYd9PQDwE60KteuWGZ1s7ZCqk=;
        b=ZW5bf1VWQ1/6KGSJyA4v8XvNmEqmb/LmWSqeJlq0dhzfvV6Tsx6nywtBvTVW4ONyMj
         iC5FOzP8rlNRZhXHhOOKcJdI3tNus2IraGqm4fDwSuo4pnM7Vm206feWd+CYli9Eb3Mt
         P6pEqlwtCMcEmMI2XIIoay4KxWdEdmiiRO071abCDk9CHEEVgaPDyIW65Jb01tuKVZye
         4qb7VnCp1ugWEcGIOdOrEV7Ba0G3yyeDh6YWafLGX1DNG+Zk573h6Lyy3n8w4eSDR9C7
         D2Xl9phfuuVsud0wDNOsaOIQ3DpovBeepFq6k8y+IZct46sbL0/nOVmYlnXjxFv42bre
         a8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329359; x=1700934159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gja50uK+VGu03YOVtNxYd9PQDwE60KteuWGZ1s7ZCqk=;
        b=I4KdM8yM6yUEAxD7MtTRzjc7SOxZNFSpz3/bbmOPYLkFqSA9jxiAppMkXeJUFBLKED
         Qe0wTCaYQWDyXaFwtvxS/a7jaQ4xOBd6nRjYhz0r+9bmHf/d7hYmXLmDNVeUuMh3zOhN
         xauMXeUsE8tX0d42R+pXIpZqZKPea/hAePrMENSACg2g1m2yCptqRV4jYNid+1FPoYBI
         c87r8JRycanqfS1DZcbOZji40BF3qMM0IeAd6MT3ZB975qYR476fNNCJ6nLOyICXmspU
         mYCEmoIJd0XGfL01k5rfkRBZjPYI2RkBEmuujs0Yp+vCUwpHEZChR8ESBnW8GOUg09Py
         Yz5g==
X-Gm-Message-State: AOJu0YzEoYv08E2IhUHtvvB8AFEBs8kGCSybDamVq5VuimM0tF4UpEnL
        gBG2nyx19+9OgKm5Kg2axT8=
X-Google-Smtp-Source: AGHT+IEwInUOdyb9JTIvDlzQjDOqKv7guvhmJ93ahOLgFcvY/4Q4hp0zaJwgva0TXnWM4RKYhWoN3Q==
X-Received: by 2002:a2e:80c7:0:b0:2c6:f0a0:8bf3 with SMTP id r7-20020a2e80c7000000b002c6f0a08bf3mr2023765ljg.11.1700329358992;
        Sat, 18 Nov 2023 09:42:38 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c340a00b004068de50c64sm6964211wmp.46.2023.11.18.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:42:38 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Maik Broemme <mbroemme@libmpq.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/20] drivers/video/fbdev/intelfb/intelfb_i2c.c: remove I2C_CLASS_DDC support
Date:   Sat, 18 Nov 2023 18:42:13 +0100
Message-ID: <20231118174221.851-14-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118174221.851-1-hkallweit1@gmail.com>
References: <20231118174221.851-1-hkallweit1@gmail.com>
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

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/video/fbdev/intelfb/intelfb_i2c.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfb_i2c.c b/drivers/video/fbdev/intelfb/intelfb_i2c.c
index 3300bd31d..f24c7cb4c 100644
--- a/drivers/video/fbdev/intelfb/intelfb_i2c.c
+++ b/drivers/video/fbdev/intelfb/intelfb_i2c.c
@@ -99,8 +99,7 @@ static int intelfb_gpio_getsda(void *data)
 
 static int intelfb_setup_i2c_bus(struct intelfb_info *dinfo,
 				 struct intelfb_i2c_chan *chan,
-				 const u32 reg, const char *name,
-				 int class)
+				 const u32 reg, const char *name)
 {
 	int rc;
 
@@ -108,7 +107,6 @@ static int intelfb_setup_i2c_bus(struct intelfb_info *dinfo,
 	chan->reg			= reg;
 	snprintf(chan->adapter.name, sizeof(chan->adapter.name),
 		 "intelfb %s", name);
-	chan->adapter.class		= class;
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= &chan->dinfo->pdev->dev;
@@ -144,8 +142,7 @@ void intelfb_create_i2c_busses(struct intelfb_info *dinfo)
 	dinfo->output[i].type = INTELFB_OUTPUT_ANALOG;
 
 	/* setup the DDC bus for analog output */
-	intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOA,
-			      "CRTDDC_A", I2C_CLASS_DDC);
+	intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOA, "CRTDDC_A");
 	i++;
 
 	/* need to add the output busses for each device
@@ -159,10 +156,8 @@ void intelfb_create_i2c_busses(struct intelfb_info *dinfo)
 	case INTEL_855GM:
 	case INTEL_865G:
 		dinfo->output[i].type = INTELFB_OUTPUT_DVO;
-		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus,
-				      GPIOD, "DVODDC_D", I2C_CLASS_DDC);
-		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus,
-				      GPIOE, "DVOI2C_E", 0);
+		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOD, "DVODDC_D");
+		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus, GPIOE, "DVOI2C_E");
 		i++;
 		break;
 	case INTEL_915G:
@@ -176,7 +171,7 @@ void intelfb_create_i2c_busses(struct intelfb_info *dinfo)
 		/* SDVO ports have a single control bus - 2 devices */
 		dinfo->output[i].type = INTELFB_OUTPUT_SDVO;
 		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus,
-				      GPIOE, "SDVOCTRL_E", 0);
+				      GPIOE, "SDVOCTRL_E");
 		/* TODO: initialize the SDVO */
 		/* I830SDVOInit(pScrn, i, DVOB); */
 		i++;

