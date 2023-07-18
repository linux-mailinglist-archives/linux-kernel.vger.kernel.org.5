Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD675834F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGRRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjGRRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:17:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D46199;
        Tue, 18 Jul 2023 10:17:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so55686335e9.1;
        Tue, 18 Jul 2023 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689700621; x=1692292621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRDtp/WtEw9mLKqbxe9I85x6ziwi94Y2+xfVDhxRx98=;
        b=l35yAg6rLbX9bryJRqrdHh0SNSnkU2HjdV1QnN9k+iR1MDEyIHRodrxwx6D5yMd0Ty
         2riv5zpKPGWr7im5tYE4xWkAUZZiXWQHS7is8BiV43wZSm0Imt2H7poEsA2tsmnHpiJc
         LCL26sp6cjENNQjqthxsMGkg0DHwmqvkrM93ExyinF4DJZvg+nZTZgJpFTLkVRKjS2Yq
         jArb202ZSfEuSvOELPqI70eb+5cZVFsVR1RsKihhpHFg8hNmaJbV1haGcWOINg1AmpUy
         3Mf0mT6/pJ0pcsI7HTn9SB3vivnqCMWFF/Z9jrUnNoKKWuunSfMtEsKn/8OirxPAVkcx
         8VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700621; x=1692292621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRDtp/WtEw9mLKqbxe9I85x6ziwi94Y2+xfVDhxRx98=;
        b=Vt+l6BCOk0qqfi4xurEv4IjXgzpifIhIH+7vYjmqPDiNHlqQcjWmEiNh3g6A1EmlAo
         uj33+OPhtA6+qu89NlHmxbEyzoctXU1XdKknOaWOiinUTc3ny2RpujUxaMo0YxTyFrQk
         pYyl7dYADQvGjMUX+Lega42nHkN5Da9WoPcXXaMH8VNPULhCz8a+p/juo1bxz3R7PEAP
         fxrtnCzuoUf8YrcBrb+9ZVs3OWjS7+9TQtTzgKou5UoKK/xXqt8P0JIVayU0RAFKRNge
         OmOA1ZjH0fw6rFloHqHZOyjNqmpDoe/3vbvEJ+i0/YXHLQpjVreF8PCVeRa8fVGZ6Vn+
         WOFw==
X-Gm-Message-State: ABy/qLZf7XeVGsyntJiID0Vxq0+W4patJocqZz6n/YN7QEqmGcpD/GVe
        CePiCnEH10k4VaNlwFJo1Vs=
X-Google-Smtp-Source: APBJJlG6LoYeezjNXpGpd5uIC0J1poUg9o9vS0RrXRrX0PkrfaGrt01RZcKAMG5YfuJpc/XYYaB0ww==
X-Received: by 2002:a7b:c387:0:b0:3fb:c217:722e with SMTP id s7-20020a7bc387000000b003fbc217722emr21174wmj.33.1689700621245;
        Tue, 18 Jul 2023 10:17:01 -0700 (PDT)
Received: from localhost ([37.171.244.194])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003fb739d27aesm10877952wma.35.2023.07.18.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:17:00 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Tue, 18 Jul 2023 19:20:24 +0200
Message-ID: <20230718172024.67488-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
ultimately causes a warning when the module probes. Fixes it.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---

Changes in v3:
	- added changelog

Changes in v2:
	- dropped MODULE_ALIAS changes
	- changed commit log for more accurate description

 drivers/staging/fbtft/fb_ili9341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index 9ccd0823c3ab..47e72b87d76d 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -145,7 +145,7 @@ static struct fbtft_display display = {
 	},
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9341", &display);
+FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "ilitek", "ili9341", &display);
 
 MODULE_ALIAS("spi:" DRVNAME);
 MODULE_ALIAS("platform:" DRVNAME);
-- 
2.41.0

