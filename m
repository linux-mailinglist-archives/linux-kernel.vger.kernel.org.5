Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1641A767A59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjG2AyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbjG2AxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2E468D;
        Fri, 28 Jul 2023 17:53:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54290603887so1631053a12.1;
        Fri, 28 Jul 2023 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591906; x=1691196706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6P0d7byHHNtJO1JXxwKJCS4iMd8OKYPtQDr5thS1SA=;
        b=CHcqyOcYveO+wTZy/3wyW9xMzNh1wutopV/+CeIcgPoo8ZU3uObWft/RVSV/X18qQ4
         4xHtxJaYys3sRL9VrL71rioqxormQbeNn9uddKGET02a72AkCa6LF6ddoQFMUDgjHx6d
         6+WlLnKJ6dUCFdBocs9Sxw8A4qNx9t2PEobJEYHiKBOZAbWExzgXrX+ytySjh8Leb/BX
         eB0p6QwI5Z9aRpnMg1hyCo9QA3B6SUM2TcueNp5FF/5c02+iuyCDiUN4zA6t09Z01M5v
         wulHvlDNX3eGoMJ5F/lu6C0efS13r9GM16oBj+zgGc9VNnT3ssFGLDDK9d/WL4tvr7J8
         fDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591906; x=1691196706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6P0d7byHHNtJO1JXxwKJCS4iMd8OKYPtQDr5thS1SA=;
        b=W+xQUQNQ6Z5AP4IiQe9rnsDcO3AhVm+j9N69ZGJHe7CZBUePe1TfDAyjMoVihk4SCU
         SZLwL6UGq0g58rPrGZyNLHf6+nfbrN+z6tRZlGf6Kxyod78IxclXa7VlMYjlsbOQpiyc
         1n0lj6DjWG/eC/ofvCkhJc4Jnu4etaL3ImO3m5SDQH+78QMXfy9jDqwyKdoJpyc0WXz4
         aY7RX8DB9LKuEclUowGeJOgCg0Yobbo8AjiiBmZBN2rV4J0+0DNydK8SgD1AQWVgS/1W
         oTukZDT9NuKZOpKhHkFTycB9H13odxVvRqDtZoaodPeTua+SA0WUrnGXUBFAzsP6108x
         4vuQ==
X-Gm-Message-State: ABy/qLbmsjlA+hECpgDIoZgs916pZY+ZEPSDH0dhGDDQpSRCMUnRfv4t
        4neS9YXrXNZhJHDzVeWJt+EOzWfj0YE=
X-Google-Smtp-Source: APBJJlGl8B4xwMAJ4UBbtNH3KWxW92k/PB1Vf16B4VwsIb8hqtSbE3Ffcw9joFIrk46A/R5Cz2Y5iA==
X-Received: by 2002:a17:902:cec6:b0:1bb:c224:908b with SMTP id d6-20020a170902cec600b001bbc224908bmr3084758plg.61.1690591905903;
        Fri, 28 Jul 2023 17:51:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 12/22] Input: hycon-hy46xx - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:21 -0700
Message-ID: <20230729005133.1095051-12-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/hycon-hy46xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/hycon-hy46xx.c b/drivers/input/touchscreen/hycon-hy46xx.c
index 2450cfa14de9..d0f257989fd6 100644
--- a/drivers/input/touchscreen/hycon-hy46xx.c
+++ b/drivers/input/touchscreen/hycon-hy46xx.c
@@ -274,10 +274,7 @@ static struct attribute *hycon_hy46xx_attrs[] = {
 	&hycon_hy46xx_attr_bootloader_version.dattr.attr,
 	NULL
 };
-
-static const struct attribute_group hycon_hy46xx_attr_group = {
-	.attrs = hycon_hy46xx_attrs,
-};
+ATTRIBUTE_GROUPS(hycon_hy46xx);
 
 static void hycon_hy46xx_get_defaults(struct device *dev, struct hycon_hy46xx_data *tsdata)
 {
@@ -535,10 +532,6 @@ static int hycon_hy46xx_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &hycon_hy46xx_attr_group);
-	if (error)
-		return error;
-
 	error = input_register_device(input);
 	if (error)
 		return error;
@@ -576,6 +569,7 @@ MODULE_DEVICE_TABLE(of, hycon_hy46xx_of_match);
 static struct i2c_driver hycon_hy46xx_driver = {
 	.driver = {
 		.name = "hycon_hy46xx",
+		.dev_groups = hycon_hy46xx_groups,
 		.of_match_table = hycon_hy46xx_of_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.41.0.487.g6d72f3e995-goog

