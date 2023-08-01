Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A976BEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjHAUqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHAUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:46:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119A1722;
        Tue,  1 Aug 2023 13:46:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so8662720a12.0;
        Tue, 01 Aug 2023 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922788; x=1691527588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsCbwck1W0BVGN7R4M4UBzImqiWrqRh5iCUK8g9cDlM=;
        b=fjPOPM6Wt8T52UqI4RVSIw7Fr7W40yPbQL18fLlGO6G6uIpQX5BRvk3DeeJfmn6kPJ
         HoiOg/HuTTSrKqDJ0QTYgkRSNpgy1E7M33xjdQ4GxVnsTPp/bvf5gVhTkEkGvEzoNlu1
         ML++9MUb8BNAk3r3WynWrrUVJThnVb3/Nf/9Xi2VwsH3NAX8WVoExrDiMM43TL5clq3C
         ECIqY9tm/pUFcBGaCfpAjOuMl7T5FaUzb8b6FLGXM57mzj9tqzf4rCcfE76dHZwTasx3
         G6vB28imijZv+o5CGJEahNsUTA5ca2TN7KyoQm7tCZnBpaxSPcMd3suzrg3Zmz1vMLZS
         6O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922788; x=1691527588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsCbwck1W0BVGN7R4M4UBzImqiWrqRh5iCUK8g9cDlM=;
        b=Sf2Wb6k0McC27Im7mVUPX0mIohsCSsEjfwJS15R/cbP3FWdv9CxyaXqyXW/cJyuG2J
         T6hBEORdALmw05UUh5FAP80t9lIHN8po0IXSCOJmxqFugkfDiZfTl4ycn9StprM4LS7m
         rlM+Hzdcv+yvnPdHFOBD/fWyF2O1uiaBsouJplNljsL/6JxQy4qvyyywZAgnude6Pikj
         /iGw9m+YY0dYJ8KB3zAEmUx3iUYbQidG5T0fVCwV1IKBfzjW/zSQR4Wyc+FXw/U/ES92
         jKZabsyGj0jLKc86hekPTy1TJaeFejD4PNCgLhmpfkqX630/Ik6WSpergDuHqQCRbFI6
         kY4g==
X-Gm-Message-State: ABy/qLYCgV/xxJW29plROf23EBH1RtzgT2xXaQpeaC/CNovlnuqEyCBJ
        ohBQhX8DsM56YfghbWdfV8lL07XFId4w3g==
X-Google-Smtp-Source: APBJJlGwr6CUPEbN76s4J4w9xkApiZpZjeIBme8JHW3y0zZ3bP/dTDmfKsMyxH6MBUynyS3WJ2ExOg==
X-Received: by 2002:a17:906:7685:b0:99b:c8db:d92c with SMTP id o5-20020a170906768500b0099bc8dbd92cmr3022204ejm.30.1690922788035;
        Tue, 01 Aug 2023 13:46:28 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id rs5-20020a170907036500b00982b204678fsm8109417ejb.207.2023.08.01.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:46:27 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: zevio: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 23:46:06 +0300
Message-Id: <20230801204606.9738-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-zevio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f0f571b323f2..2de61337ad3b 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -176,8 +176,6 @@ static int zevio_gpio_probe(struct platform_device *pdev)
 	if (!controller)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, controller);
-
 	/* Copy our reference */
 	controller->chip = zevio_gpio_chip;
 	controller->chip.parent = &pdev->dev;
-- 
2.34.1

