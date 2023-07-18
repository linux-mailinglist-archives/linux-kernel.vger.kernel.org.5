Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A09757659
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGRIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjGRIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:14:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799EDE7;
        Tue, 18 Jul 2023 01:14:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so33821765e9.1;
        Tue, 18 Jul 2023 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689668062; x=1692260062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eySJfQ7/Gc/AEP/cNfIUTGk9yVoHTH7Q2UCStgdmPk=;
        b=XzGeZP2wfi7lajh/fHbLEBJLGoAEiqq93llvJZk83NQLWkpkhmJAPN4y6D1tu3zrxn
         RFIt3dvm5FsiQrDmGigRFSxtj/klhPmQ86sy5b/xMdTu5m66zEilWY9Hjajhx+6OkUPY
         iqX2cNwwDpxwU/8UNAHY4k4e/nCqWiQ//ioPJ8/0tLJkljRyQXzDVpx2og+MBslxVCk5
         siOxXQU1aBTN3mWlYuQVKiamtHU829DnwSBRpsp7B6oFee9zU2kQbuwoPaLNEir5oKOJ
         0VCPx9V1Bd8q3ZJ8+oVMKF1zmAzJ55XtzP1Br+PzvxynBNdBcv1YWWnONYKkFtTWrlCn
         dCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668062; x=1692260062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eySJfQ7/Gc/AEP/cNfIUTGk9yVoHTH7Q2UCStgdmPk=;
        b=aScr/y2Zu/sQGFrS+m9gy4ZCR3r3jq4qSncFb9410+OpQEiqF1MH5mQlUaz+qLP2PK
         jdbYxSKau2RLjptTJmeI8GDMz5k/c/HLI6JCnBI4F8+I5zbIn1MBW9GQiRHlrtmmaOoa
         fJwN8UPq/NiOam+VJEtC66H9rCs8WBpCOa3Yp2CiZLtmYJtUG6fQrC0qrtNJP6J8rtQA
         ckOuz4wx6qYOVMkZ6ZBWXUDyAUB/m+8j5M6quXnoSh4j7weesaS97SEVbvXlAQ95lan/
         aodRFaf++yE0A65HPcZJtAU3bvSXD/Yz68+FuRoyQbvLOKktC6/cIrmOJ3Z8CHdEP1LV
         HT/Q==
X-Gm-Message-State: ABy/qLZdd1xQVkUaJf+6Fp1RSJUvJjEjWMLKSHqZPT/aFX8AqUberSpy
        hwCxF8i6GuJDgaS0cYs/hdqoy7dar68=
X-Google-Smtp-Source: APBJJlFUcyYNxBMp/Ez4i7yBxOUkaSiUF+hhVo3KRjjCatmyU6lTEJosDE+EkEfmsxzp8bFfdalcVg==
X-Received: by 2002:a05:600c:2046:b0:3fa:8422:158d with SMTP id p6-20020a05600c204600b003fa8422158dmr1225340wmg.18.1689668061660;
        Tue, 18 Jul 2023 01:14:21 -0700 (PDT)
Received: from localhost ([37.174.75.194])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b0031432c2fb95sm1626137wrs.88.2023.07.18.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:14:21 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Tue, 18 Jul 2023 10:17:59 +0200
Message-ID: <20230718081759.28902-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
ultimately causes a warning when the module probes. Fixes it.

Changes in v2:
	- dropped MODULE_ALIAS changes
	- changed commit log for more accurate description

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
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

