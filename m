Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92575763D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjGRILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:11:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8C58E;
        Tue, 18 Jul 2023 01:11:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so8815584e87.3;
        Tue, 18 Jul 2023 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689667878; x=1692259878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpSa3JuGu2F5rDkHmeBs8MJOc0K66x3Zvji8Ik/U/dU=;
        b=luKqgmR6miKDMTlzg9Q2mfg05kLQVXqLLBIjOFAOZiqm/QFsGNS7EihK1lq6wdpGWK
         rN8dc7CyYvzwroWLp6nOzy68lFyoRSWA+IALFI/K0LTISsud6I4u5w4O4l6rPiIMxX4g
         ytol2K7xSb2FpFwt0fiariP4YYLdGarplXSD4pYyoirOO8FpxNzn6WfHJm9iTdQvHZXC
         ri0Qbm4chtUws3WnZzaacn0akPcMS6RW8JHvzq8ccsntzStBwGiH4/bsgvPhxiPQAc3f
         GJh4ipwqlcsVErqM1phGfJd1o7dOQdQJOz+iSYmmfCh6VYaUPZcOEF95E8+h/OMlU369
         wCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667878; x=1692259878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpSa3JuGu2F5rDkHmeBs8MJOc0K66x3Zvji8Ik/U/dU=;
        b=aBtw89fMRW4gzSbx0qTy2JyEa2Kox72PgOJu0prR8o/+BXNP5n1l48xUQG6T13+m5x
         HKpx5P1j/Zk5yKXesyQ7zJ8pBUxiVnb4BhfCFpHmGEM4PUBBquoeBZ1z+jUiI8KLTs48
         iEOJTUdsvD+/5388KxyyMGvJjIL0hVjrET4d7H8kBC/jB29l6kcp+2bCE9vfi/Filq8X
         6/mjkpNxoUoj31osEyWkIXXlZv0/LNUNRskXRzZfUvQuhopMTmGE2uQSR4Wtf/+bpCoZ
         fb62lQtg6FKTAXPjY3kgKzSXAIdKHbUZbQdnfLV90v7GBWA4N4fSXRaVPMJyHJTJLkq/
         mwwQ==
X-Gm-Message-State: ABy/qLYI9zIc9u65mivDsIXrFez1Zm1cD16wb22+LptanuGkVkBS22gR
        8h3b/QRAhhLr1TEcFp0rFkI=
X-Google-Smtp-Source: APBJJlHwD5T0hI02QFCRKs9CDtc0FTWE17lYnAwkmOzKvsDjYMJ9puMNcByCKr+Z7+Gf22wp4xWuzA==
X-Received: by 2002:a05:6512:3694:b0:4fb:8dcc:59e5 with SMTP id d20-20020a056512369400b004fb8dcc59e5mr1001179lfs.39.1689667877381;
        Tue, 18 Jul 2023 01:11:17 -0700 (PDT)
Received: from localhost ([37.174.75.194])
        by smtp.gmail.com with ESMTPSA id g15-20020adff40f000000b00316f9abf073sm1627560wro.82.2023.07.18.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:11:17 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Tue, 18 Jul 2023 10:14:18 +0200
Message-ID: <20230718081418.28225-1-rgallaispou@gmail.com>
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

