Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E17D24E4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjJVRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjJVRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CD119;
        Sun, 22 Oct 2023 10:23:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso1616764f8f.1;
        Sun, 22 Oct 2023 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995393; x=1698600193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Uvqm6njBSoTbqoFZ5igrrI4fi2hQcKwzs6OhXvSIfM=;
        b=O8zMeb2PJtBLCE2GvaMYdo6zoz4tGDBKVTYdKdE3bx8qCZ4RgmIB36iceC+FG9vuDh
         hZMuceKDg2D5Vx0HDSLKHHtvBmR8rLoQ8tilcWrHymwP5XCDCYQZe98IyxFLELF3kiOU
         dED4WBJylOVV9EbX16P4VkKQ4rKOS5gnzZoNFi7/V2M8FfOMuCAEt3o6jpGd8EGo4MKv
         LG3/ywz7y9bf3RynOorNu5f5mvA14ieNbjZJjj4Ddqzi9uB1voZBistgrQYIdzYLvusx
         yIEfReA878jbYfPrGpI0+mjbMciO6U4hnlYe8rZw+5043Ca3mHJl/HRAmt2QC1Q7Qe5s
         gnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995393; x=1698600193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Uvqm6njBSoTbqoFZ5igrrI4fi2hQcKwzs6OhXvSIfM=;
        b=uwbALmaW9g4SbgdaUmi6xWIBXIH0SY16sDxZXc5ws69+2oTPZxgLOA6VQMQOYREfLV
         zSkiEF8cqGukfAMiQO5WcL3smIehrFRiekMbSkktbou7xvDTlIcU5YbgE7IbMcZIOBOC
         gZNJlgu6W36tHDrxDhFvAUyQtO5TGNEkF3wId5EVZtn5E4/Gj84IJH+8wYzEIA3IR9Jg
         2JQkx0CALBj/vZPMYjrj4JO1si5GBm+0uUkNtbEIrIw7zK9UT5tNMDhI/uwGlJr4IWUj
         CTRjC8YmL4d7Hp6zkdNrwyxWFT81N43bMb1WMNOf/a7jKpoBae5iDtXYGUXQeis0onJG
         wXqQ==
X-Gm-Message-State: AOJu0YypB9vMzNZ8DKAdv8qtXtHAZg+XuUuGTYUvRMzy1LjB/HsEPTkm
        IWefBzrd2wAudbhKeOtFT1nCW87IW2Y=
X-Google-Smtp-Source: AGHT+IHg3z/YYy0wIIyL6x3ZWFz5huQ6vNT0zjKTPX5vX/U83OKah6ASKwsIKnmglA/T8eDzEndJGQ==
X-Received: by 2002:adf:eed0:0:b0:32d:9572:646e with SMTP id a16-20020adfeed0000000b0032d9572646emr5621672wrp.54.1697995393643;
        Sun, 22 Oct 2023 10:23:13 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:13 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/5] iio: pressure: bmp280: Use spi_get_device_match_data()
Date:   Sun, 22 Oct 2023 19:22:18 +0200
Message-ID: <9ea8ac90b2b8a8cf45803d0435243c0bee009b37.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
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

Use the spi_get_device_match_data() helper instead of
device_get_match_data() and the fallback match_id logic.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 1dff9bb7c4e9..2eed483a8cc4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -58,9 +58,7 @@ static int bmp280_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	chip_info = device_get_match_data(&spi->dev);
-	if (!chip_info)
-		chip_info = (const struct bmp280_chip_info *) id->driver_data;
+	chip_info = spi_get_device_match_data(spi);
 
 	regmap = devm_regmap_init(&spi->dev,
 				  &bmp280_regmap_bus,
-- 
2.42.0

