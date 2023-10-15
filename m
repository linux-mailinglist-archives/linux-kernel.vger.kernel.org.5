Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9397C99B7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjJOPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjJOPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:17:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6DAB;
        Sun, 15 Oct 2023 08:17:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4075c58ac39so37847475e9.3;
        Sun, 15 Oct 2023 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383070; x=1697987870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqQVd6iN7ettmPvcpD+SNx5dxlU6xrnXDXy31g/k6O4=;
        b=mFESidvugez4PIQf+EWQ1UdutKqMqZdMhAJaYnfxRjmwODBuzJb/Tvp9S08mlUVmPm
         OdqEa/XwhbhkmOqs4w5O61njeMVGeVYRSTxNL9We6BvdSF/WFsU5IOiPglqw9EBQfMDh
         5GnVi1y9RQvvIk9zNYLmIqUQTT7ME8Iwmf1l+xFOwe0XcnIUuTcRSyUJEgv8gQsyyEn1
         wwcKHfSoOXk0rpBrOsniX3b47FE+CB7moDslsiZZx4UjpDY49WKnf/t7CGc0a0pvhQvp
         c16b2vM52UCqYV3s4Bk4GUEAnkD+TVklFFRz9XGOt5Wzi6M4U90+Haifs7g7CTHd4WzF
         ycEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383070; x=1697987870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqQVd6iN7ettmPvcpD+SNx5dxlU6xrnXDXy31g/k6O4=;
        b=sIQS/ep9jFxsgD3HbQSRhYs0uCZZThLUy39qdgDBaXzycPEqscV3Uc17KTpY93QzIi
         zRb/b1Qe4sAfkp7mH3RMtpmDK8TkL1DoZgepEDB7lBf/mE4+yDsjcUZurwmswhpi3iJr
         ZlenD4RrxzhSSUyEnqSJ/R6dH0KxKn+af5TGc8W9CtrKaz4N3zo38sO5kNGmYqk+FgP3
         J/t5zs1kMLOcmr38BUhVcN/8U+R73Qs3Vak2CW3MtXddKaLHJrAzCS89xUfsD4gNzjfj
         KrjbyClqcIYWG/9Rh37SvQdLnt3ud/sPuJ0WomNq/xvz763zERkg8MID0OaLMb0iFZA6
         aowQ==
X-Gm-Message-State: AOJu0YxDOVOLqUyNNDg0fdkSSaJaAEzH3CJrYN4KB3aL+YAeidfGUJb4
        DVSNhwGZ81SiOt1gsv+w5qcRhhnT1M8=
X-Google-Smtp-Source: AGHT+IEkH5/TqzpKkZK9Q9e+yg4joEJk2m4PawTWrRtcQEe1RUF8HHqNHkK84aVcercLivKQy1UlrQ==
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id p20-20020a05600c205400b0040209061e87mr26952161wmg.31.1697383070442;
        Sun, 15 Oct 2023 08:17:50 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:17:50 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/5] iio: pressure: bmp280: Use i2c_get_match_data()
Date:   Sun, 15 Oct 2023 17:16:23 +0200
Message-ID: <a8c60243a2e8c53e60353b3d92edf0af6cc10b49.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace device_get_match_data() and id lookup for retrieving match data
by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index dbe630ad05b5..b3e069730f97 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 
-	chip_info = device_get_match_data(&client->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = i2c_get_match_data(client);
 
 	regmap = devm_regmap_init_i2c(client, chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.42.0

