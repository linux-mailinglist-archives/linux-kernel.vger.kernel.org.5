Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80275927A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGSKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGSKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:14:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C91FE9;
        Wed, 19 Jul 2023 03:14:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31716932093so858353f8f.3;
        Wed, 19 Jul 2023 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689761684; x=1692353684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdeu/FNXu1IFJS3/hcgjv0hV6ECeTHIsIHo54xBo1WM=;
        b=k8EqETGbVTckou8SA3q7lqdzVZLWQZjoTAF/I3mwwciSYf643o8LeAA9zYvSjtUUtg
         Q1+MP5p64XR1cU+giFfEoFv4EwB3w70i1wEwbeuSMZajNG4kCIIfFmZGFMKllcJTKMt3
         y2JC92+QbjKqUIaRm3He28PFJp/5VStp9vdBS/TgcDmrwiQoyPJVR/oJ17PBi8jqxvYM
         NREUlSAX+QQ27thCscClLTzgLL+zObMGsd78b2jnCcPTw7KG+Frcg0zz1ZBEuaGyhhW5
         eq3JG/yZDixUKpwulob2tmr8CQtyH/ZUEHjmlw1sg1TFH8r+pv7VojBNkJyYixyI9QK1
         G9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761684; x=1692353684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdeu/FNXu1IFJS3/hcgjv0hV6ECeTHIsIHo54xBo1WM=;
        b=No2MKz/aV6+En8MfoK3BGy7JI7TnjFSVaOPBeW12WKaY64RfsX+BIKzWJz0BKickC8
         VofJturnNpn4BNLXvJQLqjarLPCm3I6TNU+SbNXlAlIoGMMraLRPxbF3QJyOHUny+cHC
         vDrTInvu81DvgumXbXB+/baVJ5tZ2B6lq4hH8KgWEIJy8DRt5mcCIctWRFT6gKvLDhjv
         bvz3wj+9fTp1en8478T723hx+6VNOIUp+L8hjn7CfxzONbHfDo4flBfvtnGJ+aN+BTJL
         PwpUNQu8BoVYYXo4IeX14o1AEhEfjLFGUznj00W0zuT4NobAo8eIbW6OjRuX+aMZNdW/
         Muvw==
X-Gm-Message-State: ABy/qLa+9HHWcjboN8+LsH0jx0WSpy5dgMphsG+F2gml86psmVy8Gu8b
        afEkBgjSO2+aikTtZbJkSA9Bx3ojPBAP2w==
X-Google-Smtp-Source: APBJJlHh7h3DgHDGm3HnP9/Y3UgOqiBHciQ8oTaJAiiw1R2Jd6++zvulTs0u/i23pDx3eo5vbrxP/w==
X-Received: by 2002:adf:e388:0:b0:314:3b09:ca8 with SMTP id e8-20020adfe388000000b003143b090ca8mr1886038wrm.58.1689761684472;
        Wed, 19 Jul 2023 03:14:44 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b003144bfbd0b3sm4889456wrs.37.2023.07.19.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:14:44 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        keguang.zhang@gmail.com, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: loongson1 :remove unneeded platform_set_drvdata()call
Date:   Wed, 19 Jul 2023 13:13:39 +0300
Message-Id: <20230719101339.18256-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In the drivers/gpio/gpio-loongson1 the call to platform_set_drvdata was
removed.
This function call was found to be unnecesarry as the associated
structure is defined inside the local .c file.
It doesn't use any type of function either so it can be removed without
any complications.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-loongson1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 6ca3b969db4d..2a57ffa0548b 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -78,8 +78,6 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, ls1x_gc);
-
 	dev_info(dev, "GPIO controller registered with %d pins\n",
 		 ls1x_gc->gc.ngpio);
 
-- 
2.34.1

