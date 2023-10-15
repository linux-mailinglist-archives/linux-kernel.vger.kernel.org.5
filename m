Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8E7C99B5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJOPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:17:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B28AB;
        Sun, 15 Oct 2023 08:17:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4054f790190so40398715e9.2;
        Sun, 15 Oct 2023 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383065; x=1697987865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hN8/T5csc2eyAKIgjmzBuDVcsX2FfoJF5gsqGYHVrY=;
        b=Zu1Ch5oRW/nXMpVrHjew6ctZC9ImgIEDPWXNjW5kW28G0iNxzny87sODhi4RZS73JI
         Ekp5T0XJsotSXu3qq8+8GNp3y1hkZj99WMCShJM/0pUukZNr6wnKJM320c+AxnT86aCh
         v1mBZgiJzMPgUNAyC2hR2Uke8N0UNOg+YrLPQlCGNsZuiii+WavwyIgUM/IouMvTmpQa
         PQ5CYLND5l3029hhA2jByC+X7ymwQSyNlPPfJnxZYVoiJY3LrE9lgvR1L4onDDM16/kZ
         ajIAyScGTJDgGxpkCBKrdjmVaGiN/NYMC4or7GHyjLXLUAXeruoMGcgtCmiXKMEQ4JAB
         vL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383065; x=1697987865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hN8/T5csc2eyAKIgjmzBuDVcsX2FfoJF5gsqGYHVrY=;
        b=HrQKALdAoVwv8rnPYesDw3JOpfEZHPcU7KYNiSGYywiAXRKzivZniV03aaN87OqLLN
         63ulmMTNPXZqpfHbqTyV1K9YcprIyF5y8pgwWs3vXX7kIH0fFfrm9+ruAcVDxScq+1N1
         H6yXBxupXx+eWtdImYMGXPImoYo7xWUIrXCFRNTt1DUhqWtX8PQkUesFQaztOhBPPcta
         q0rYXsBlENA+Id2jRM3HOCBF0VArdm1DcyLYy2EoSo5cwLU+n0Ec6Z5SHYGkG8i7P9wX
         drA7mMAP7IiZW4DAEdZaRzWasMfa63ZR+iiae9mAsBT0A8uXyxdhHv9ZFs9pLRa1Vcz0
         pNIg==
X-Gm-Message-State: AOJu0YypsIE761VpN5r74OGSRrKuwUDmgRatIHxdlWQlgq5Dx+68ET89
        jBb78MIYXfzYz+AgStZUKcByS6vw19Q=
X-Google-Smtp-Source: AGHT+IHiwHRwM6pM/AMiS0WgG5zukAzudX4L5NOIztframcb6NXffk1oyFJIN5qZkGzTNxsK1eUJ0A==
X-Received: by 2002:a05:600c:3b82:b0:407:8317:ad81 with SMTP id n2-20020a05600c3b8200b004078317ad81mr1110252wms.1.1697383064429;
        Sun, 15 Oct 2023 08:17:44 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:17:43 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/5] Add support for BMP390 and various driver cleanups
Date:   Sun, 15 Oct 2023 17:16:22 +0200
Message-ID: <cover.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Add support for the Bosch BMP390 pressure sensors and includes minor
driver code cleanups.
Patches 1 and 2 update I2C and SPI driver matching logic using newer
helper functions available.
Patch 3 fixes minor coding style incoherences.
Patches 4 and 5 introduce support for the new BMP390 sensor allowing
sensor families to have a list of known device IDs to improve detection

This patch series is aggregates patches from various series:
https://lore.kernel.org/all/20230812175808.236405-1-biju.das.jz@bp.renesas.com/
https://lore.kernel.org/all/cover.1691952005.git.ang.iglesiasg@gmail.com/
https://lore.kernel.org/all/cover.1692805377.git.ang.iglesiasg@gmail.com/

Angel Iglesias (4):
  iio: pressure: bmp280: Use spi_get_device_match_data()
  iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
  iio: pressure: bmp280: Allow multiple chips id per family of devices
  iio: pressure: bmp280: Add support for BMP390

Biju Das (1):
  iio: pressure: bmp280: Use i2c_get_match_data()

 drivers/iio/pressure/bmp280-core.c | 56 ++++++++++++++++++++++++------
 drivers/iio/pressure/bmp280-i2c.c  |  8 ++---
 drivers/iio/pressure/bmp280-spi.c  | 10 ++----
 drivers/iio/pressure/bmp280.h      |  4 ++-
 4 files changed, 54 insertions(+), 24 deletions(-)


base-commit: 73006239ef2313f1986f86af86f8b06150a807e9
-- 
2.42.0

