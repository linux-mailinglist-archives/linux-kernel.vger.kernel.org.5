Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC380D9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbjLKS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbjLKRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9BC7;
        Mon, 11 Dec 2023 09:50:52 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so65520551fa.3;
        Mon, 11 Dec 2023 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317050; x=1702921850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPJtRqKNEOg0N5Ytto1LWF17klynRrR8m/oK9rsOY4A=;
        b=hg/i0+kdPHNu4Q1yaFRuUqpcqAmXiphnA43I6syZ/t3dKBwF5WDgXypTfxuTC9CB/g
         4c60x43Z7nQVGftfs+kIiYXGLStgTPpFvduztz5Al+x8ZINUQKBu2Lu9IPCRZINMjjY0
         6rw35P5UUifAZqI03SufKRWGB6BAw/JAVQwx71HAoCBympbN+qKOAXp1tvW4fyWKK+GK
         ARZn305BwYElt3tH3mk/+4hYxGseF+SrZijo7UV9Lf5a8pyQKdoTi99JQukev4B6FAbQ
         wOcG45M2qKBMxebAi7B/bRttzcQfYCiiQFZ4oG9VoVDaNYi81m9Ox/SqlUL1R2aH9aUh
         vAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317050; x=1702921850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPJtRqKNEOg0N5Ytto1LWF17klynRrR8m/oK9rsOY4A=;
        b=RcUT+AeH5QnwMiCw8o6/EY9f7aD6tkAGhcbMLuqZXWU4NwQgAWrCjBEINsKQYQb6sq
         dq3ON0zZfEuJl7f4As2odd5+FpcY14RqfPRALBxiTEgNEae+G2XvDSEr3NYpTyPz7CDr
         iQgL0hI5EtGZ+8VXYKNVM2UbtB7z7Xw5c5uNTgS3o4Y54povhTKdiTK6fZD5RFDP0Onn
         8QPZMc/hWm2APRgYbDQV//46k5LD6nbPd75xRGeS+uZfNktQG4kIZ22F+KDSp0oZnCAp
         Y3+r5gy+P2ZKzA3Yv9qYvglw6YpDznpdYs5sXmR99NDY/eHb3ealafDefof7JWIxI0af
         6Jyg==
X-Gm-Message-State: AOJu0YyFifiEAXI2rbr0K8qlUhpEHQrGfQ7fujQJm9UlgGm+tC6sYM/8
        cyMZODGXl8YcSW48PJbRf/xCcnp68i2ZivNr
X-Google-Smtp-Source: AGHT+IFmFc6F2lJ+weBv3c+S5+3heR+vSx9u4e7CpgdwzlyIVuDCv5/VZwXJkwdv0CP5fk8fw6pAGw==
X-Received: by 2002:a2e:a907:0:b0:2cc:2751:a6b7 with SMTP id j7-20020a2ea907000000b002cc2751a6b7mr815528ljq.21.1702317050576;
        Mon, 11 Dec 2023 09:50:50 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b002c9c21d01c2sm1261702lji.101.2023.12.11.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:50 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 06/19] media: i2c: ov4689: Set gain in one 16 bit write
Date:   Mon, 11 Dec 2023 20:50:09 +0300
Message-ID: <20231211175023.1680247-7-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, bits 0-7 of the AEC LONG GAIN
register (0x3508) map to bits 8-15 of the gain value and no masking is
required. Thus set analogue gain in a single 16-bit write instead of
two 8-bit writes.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 42700ecfbe0e..5392f650960c 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -32,11 +32,7 @@
 #define OV4689_EXPOSURE_STEP		1
 #define OV4689_VTS_MAX			0x7fff
 
-#define OV4689_REG_GAIN_H		CCI_REG8(0x3508)
-#define OV4689_REG_GAIN_L		CCI_REG8(0x3509)
-#define OV4689_GAIN_H_MASK		0x07
-#define OV4689_GAIN_H_SHIFT		8
-#define OV4689_GAIN_L_MASK		0xff
+#define OV4689_REG_GAIN			CCI_REG16(0x3508)
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
@@ -613,14 +609,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		ret = ov4689_map_gain(ov4689, val, &sensor_gain);
-
-		cci_write(regmap, OV4689_REG_GAIN_H,
-			  (sensor_gain >> OV4689_GAIN_H_SHIFT) &
-			  OV4689_GAIN_H_MASK, &ret);
-
-		cci_write(regmap, OV4689_REG_GAIN_L,
-			  sensor_gain & OV4689_GAIN_L_MASK,
-			  &ret);
+		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
 		cci_write(regmap, OV4689_REG_VTS,
-- 
2.43.0

