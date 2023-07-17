Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F2756398
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGQM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGQM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC82268E;
        Mon, 17 Jul 2023 05:57:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso7040247e87.2;
        Mon, 17 Jul 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598641; x=1692190641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWK395aYGgWInPjVttJySpBAEbGy68xd8KX8YDrNaDc=;
        b=LrGyFSOiV0uVL2e/JvXQL5JGZjseiobE4xUfuujpSr536bvqNcmNoU581Y7Vd6V6dV
         Wlidoh3rlCT8wqFIzsZ0IPJLk20/btVtVtRekznfeEszXIVAL+Zzmis6UGVRfe5a05c4
         4kCzskEMTjBFl6YehmPo+5Ra5rHzEBENFS1o40m15MoGgSFimGU7xws7S9N0/CKFTojC
         DTp0tE0T0zY9wK86T//Gp/ymMvlaRhyLfi1Hv9RA9WQvfJGdLIczR0TtviDOMgSBrdHS
         /RYSTwOVlpk8zNWgqAP7dfO/1Uy99psmuGe77IAYLVhW/IadN97gWFcJPe4V37R42jN9
         M3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598641; x=1692190641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWK395aYGgWInPjVttJySpBAEbGy68xd8KX8YDrNaDc=;
        b=TcFbYkFNEhRDbsgmW2rPotRuhzndG2aeNDzeeyKM5ifYJ8n2B1yVyUaq3jzAqXpVAx
         vVnjSUGfs+G/yCZ1UVjw3IRT0Wk3uPAyvA9xGi8BqQrhQPsX+675SqyFt7Sels+W5OPs
         eV5Z90DHukBbNDgcGZMWzb4my6q3xAqTxlS9ztyW8JBfNx1YK7plxtJfbnbbiLwQrpbF
         R+G4c/1GsQqVxRnZIXieDh5602OPjqgv8wXXMyyAaNThoNtQ7a65fxr4v2qkBtu4m5t+
         YzfmLfp0lDs5wjNP0PZG0B8VGSe4sIqUfUwCfe1BC8JHMT3F6lxOrtvlm08f7CZKkVfT
         9IWg==
X-Gm-Message-State: ABy/qLbEpJOTRB3QiHo9DUpYVQX89hTdCHvwFKoqpPYAWncAvIoTeCyz
        HPt4biwFJPokiwN4aih5U6tx3o0ypkTBAA==
X-Google-Smtp-Source: APBJJlEEMgCWumSrKpaIDRclQ2ilDK+bWokkkG/49FTSp4vR5lWV96djKq3uKJCcyAFS5wShcVwcTw==
X-Received: by 2002:a05:6512:3489:b0:4f8:5755:5b22 with SMTP id v9-20020a056512348900b004f857555b22mr6648134lfr.27.1689598640524;
        Mon, 17 Jul 2023 05:57:20 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b003145559a691sm19126811wrw.41.2023.07.17.05.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:57:20 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     florian.fainelli@broadcom.com, andy@kernel.org,
        linus.walleij@linaro.org, sbranden@broadcom.com, brgl@bgdev.pl,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: bcm-kona: remove unneeded platform_set_drvdata() call
Date:   Mon, 17 Jul 2023 15:55:21 +0300
Message-Id: <20230717125521.6369-1-aboutphysycs@gmail.com>
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

The platform_set_drvdata() call was never used, ever since the driver was
originally added.
It looks like this copy+paste left-over. Possibly the author copied from a
driver that had this line, but also had a remove hook.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-bcm-kona.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 70770429ba48..2e50a07a43e6 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -597,7 +597,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	kona_gpio->pdev = pdev;
-	platform_set_drvdata(pdev, kona_gpio);
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-- 
2.34.1

