Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEB7724DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHGNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHGNCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:02:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545F10FD;
        Mon,  7 Aug 2023 06:02:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso44671345e9.1;
        Mon, 07 Aug 2023 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691413349; x=1692018149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Nt4QYYjEL+p64RRfFuSmwTrTt38SuyWllng/Q97cM=;
        b=i1ViJfLDxjT2Inkm71aoUY7ogCUVoAxy7viyDUzQs1GOcMEyDx+UN2HdFGiOM6/W/k
         MzMj++aO0nEZHX8H9JJGMniqxKduqsikNqJ5N6Eggeo3DcNndg3Hqw4UdSTGKAxYRrrm
         2u45bzXlWwGGxrhajeOYLA0HsZ4Nc5sNMqOzddIBop14Yv8pckq2DwgBdq25R32KZ/CK
         NC05tw8kDTngdg34Vlw7tctbFDF2P+X+GDmZtBs/omGoRVIwnneu3oIQtsY1YVvli07u
         epD8UjywaQay80rXEt3nM/HZTstCp8nTlikmFxu/V86VkRHYTYpwVFiRq6ImhY2hfK1b
         FXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413349; x=1692018149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9Nt4QYYjEL+p64RRfFuSmwTrTt38SuyWllng/Q97cM=;
        b=lKzukbvO/4nap4a7T0zAM9dJjiYeqwN8Rw0vZ8VCK0V9wvc9exdjNc+vLdD0Nv0ufH
         rQOtLgnyirvJ9rRsHaQg5IvbHWapvFKl8LpQPaEc5z2ka1/A2IzKj+sFZMq+ofn0VCml
         rCmIeR0SuDoele4vTJZFMkfotuSnvX4UTqw7gX5Gm3EWnbEutB2ENtAbHmEFw9jggEd6
         W2N+utFyLxC7sgCg4UFsrDzG1p+ujSYWdfGBdyNPF9xw5ZtaTHpGxy5JQ2ZrnFOkCa3C
         qEm9yqP6eBiHLVJDcTvYTkVqa2Z7/RdGZb2lDBOeClERHV+S8jDZShRAv+I68OyZs9rJ
         lOeg==
X-Gm-Message-State: AOJu0YyphnmWVl1HPDEcWWinRW2wbV0+FZvjOYZJpEC86/cD5KGFyOWW
        jC5dVzi20jsk/JSrwTX3SoRZYepaT79IKg==
X-Google-Smtp-Source: AGHT+IFt803ICS7HHS+eqsWbjJ+vUNt7vM0QFSnn+y9M9UuGRQbPibDcwSyY2UVRsNg8gnj4kSNcVA==
X-Received: by 2002:adf:f7d2:0:b0:313:f676:8327 with SMTP id a18-20020adff7d2000000b00313f6768327mr6905591wrq.60.1691413349296;
        Mon, 07 Aug 2023 06:02:29 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0030ae499da59sm10439843wrq.111.2023.08.07.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:02:28 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, nick.hawkins@hpe.com, verdun@hpe.com,
        alex@shruggie.ro, Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] spi: gxp: removed unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 16:02:17 +0300
Message-Id: <20230807130217.17853-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/spi/spi-gxp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index 684d63f402f3..6261d9f036bc 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -264,7 +264,6 @@ static int gxp_spifi_probe(struct platform_device *pdev)
 
 	spifi = spi_controller_get_devdata(ctlr);
 
-	platform_set_drvdata(pdev, spifi);
 	spifi->data = data;
 	spifi->dev = dev;
 
-- 
2.34.1

