Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA57D772537
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjHGNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHGNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:14:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324AEB;
        Mon,  7 Aug 2023 06:14:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3176a439606so3407114f8f.3;
        Mon, 07 Aug 2023 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691414063; x=1692018863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxyrZpyRiMdxmIzfGQ3R1P1qCRsnwG50aegXf4+6Hyk=;
        b=kyApYurzfHdrOX7lA7UsyCUUuVe4UwnlELGPw4Gc7nfSt0hACahlfPhk7ZfgZYNSx+
         Asr+W967W2mu+Xk2hF2QS3uCjcY1iAxxXpt0weg7nRq4PW4zryUKg8PxLakQ2ALbB2B4
         XeKVt0rKU9n3D0cyoAPiOqG5HUwxfgnidGyXKzQbLhGKioVqz2UgCjlTapZu/5+AxyXu
         S5FNGY0aEgOGI33UEyk0ZvcDTWIHsEwqbKNZYeovSnH7ecbeYfkMW9u8okEGVWqF2SMI
         W0rb3meTWPsvaz0b8v3XVwf+nqTTB3/jkiztGnqhkn7SAsBDilUBmpH7gikPrTyIpYKF
         HEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414063; x=1692018863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxyrZpyRiMdxmIzfGQ3R1P1qCRsnwG50aegXf4+6Hyk=;
        b=YMN21GesOLSFGx/BjSyxEQ1BJ69hG078grnYqolv4Bt18kuvomRAo+5M3bidOrklBL
         q0zSb8U6I1Lzryv7gcopotw9ybO2yk18Ciuikjxohoc5+y5q2BzMHv5WiE2EQfrcKEmO
         SYdTTXQ8DK2FVSu5rHUSC23sS4a+3yhBUhjD6eSIPjrkRsH73QU/yGGLh0Q15AHRZdP1
         bqeQJCVhAn0hKAV9/BvUKSBit4o7p6dIX12ninYeWAUowskIwm+YhjM6PsHuKSLHAyM9
         FgBjAR9PamBEItS4wvcsOBce5DNpSK6z0+SDyLf4hULfjiDDRFbz0VtE5UGwmZYuKA1A
         Hu+A==
X-Gm-Message-State: AOJu0YxbjF+A9Av/fXln6ZArpcNYCGN353SHrUGoEiduMN5PA67mUBu+
        DsblVz2R9NgeICwG6kauVpWvwKg1o9J51g==
X-Google-Smtp-Source: AGHT+IGjo4QvHSjx7hVVl4E4ev962eS/4N3yo8ro1uaiW6DTUsl0PnLconcAgAz8YNYCwGzeAYNBuA==
X-Received: by 2002:a5d:55c9:0:b0:313:eb09:c029 with SMTP id i9-20020a5d55c9000000b00313eb09c029mr5118122wrw.43.1691414063127;
        Mon, 07 Aug 2023 06:14:23 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b0031274a184d5sm10467386wrn.109.2023.08.07.06.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:14:22 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] spi: jcore: removed unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 16:14:09 +0300
Message-Id: <20230807131409.18389-1-aboutphysycs@gmail.com>
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
 drivers/spi/spi-jcore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index c42a3358e8c9..f627877ae85b 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -162,7 +162,6 @@ static int jcore_spi_probe(struct platform_device *pdev)
 
 	hw = spi_master_get_devdata(master);
 	hw->master = master;
-	platform_set_drvdata(pdev, hw);
 
 	/* Find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.34.1

