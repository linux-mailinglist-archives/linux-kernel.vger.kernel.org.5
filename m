Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A019767A41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjG2Ax3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjG2AxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528293C22;
        Fri, 28 Jul 2023 17:52:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9c368f4b5so24837095ad.0;
        Fri, 28 Jul 2023 17:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591908; x=1691196708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcbA7VXwVFtFuTMrK9gecBZGBHC/yp4CxVuqNzuvBTk=;
        b=ImtOLwbAdOovXTFQhxq45BStb4JK2HiBIdGmZLMbdrZtuC9LewUnM4EN5cgwSSJ2Ez
         JY8HTNl74dtmMNy2rxiivOllpo15VNs2L6crbKtgOaEhP0vEIlzStI3v0ojDIGzm3s/4
         0Vf88rxRi8rAyIZhpJiMOhJm/74g5pOWiUJmRbmf3ChPxhiEyZf/IQ8+bZMw682gYhM3
         2mjKzjex4buLi1G/qjqAh9fLNJIFmqfdN10gVJlMiXBKVIIgxDKRlTX30iifvpK2RyZz
         QyWTwpp1FIIKzgldA53LCJFURvAROwaZq4JUCOl2aD1pP9M2yKWbjSJvUvo5gtT2aUtn
         X7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591908; x=1691196708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcbA7VXwVFtFuTMrK9gecBZGBHC/yp4CxVuqNzuvBTk=;
        b=KCRXHBfWJEEqNN9p6hNFbG8TpR+QPphnVKs/UnhXJOd7jAwci/QoZYBwmNaJy71zjX
         n6qUEHL2lTaRKDUd7hqmu5c0SOBgc6hAkNnAXRZ4Atk/Ul6nbt3Q8lroENGaWeyCJmG1
         aVgvEq15x4QYa79s7B9CkHDIVfRmTVsVaFtO2ShoMFr0PICD+5UbD6i+ixoMB2CeM59E
         2waAjDKpD1qacVsM0ha8c+cHMHhGn5PI8Mxb2BaTPKPSmyjBgKDblbpIwoYRHC1Ocs1x
         QKY9JN1eYYCO2ihHt7AIh9xRW4HgML2ipUwn6njmw4d/zifpJKC+ON05nJbRK8qzU6Vm
         aCrw==
X-Gm-Message-State: ABy/qLYjRgWEsSvJFoyHc3fdyfhIIhcBZ2r/SakiFtWNqKQ9Kbtnj13h
        uWZ08HGsj9V10TNgpJL4dzs9GOG7sZA=
X-Google-Smtp-Source: APBJJlEQ16G1vApZYvVnFvAIe0m+RfsVYTzGlpcREKUYW17v/fapKsasKWQToJReDZCmYLLN4yHvsA==
X-Received: by 2002:a17:903:11c9:b0:1b9:d38d:f08d with SMTP id q9-20020a17090311c900b001b9d38df08dmr4130752plh.18.1690591908217;
        Fri, 28 Jul 2023 17:51:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 15/22] Input: iqs5xx - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:24 -0700
Message-ID: <20230729005133.1095051-15-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/iqs5xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index b4768b66eb10..a3f4fb85bee5 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -974,10 +974,11 @@ static umode_t iqs5xx_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static const struct attribute_group iqs5xx_attr_group = {
+static const struct attribute_group iqs5xx_group = {
 	.is_visible = iqs5xx_attr_is_visible,
 	.attrs = iqs5xx_attrs,
 };
+__ATTRIBUTE_GROUPS(iqs5xx);
 
 static int iqs5xx_suspend(struct device *dev)
 {
@@ -1053,12 +1054,6 @@ static int iqs5xx_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &iqs5xx_attr_group);
-	if (error) {
-		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
-		return error;
-	}
-
 	if (iqs5xx->input) {
 		error = input_register_device(iqs5xx->input);
 		if (error)
@@ -1089,6 +1084,7 @@ MODULE_DEVICE_TABLE(of, iqs5xx_of_match);
 static struct i2c_driver iqs5xx_i2c_driver = {
 	.driver = {
 		.name		= "iqs5xx",
+		.dev_groups	= iqs5xx_groups,
 		.of_match_table	= iqs5xx_of_match,
 		.pm		= pm_sleep_ptr(&iqs5xx_pm),
 	},
-- 
2.41.0.487.g6d72f3e995-goog

