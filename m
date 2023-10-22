Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D57D24DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjJVRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjJVRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CC7C5;
        Sun, 22 Oct 2023 10:23:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so2054810f8f.1;
        Sun, 22 Oct 2023 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995382; x=1698600182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JIMYJiPAhT+0FE33ih8JeSS7Sn9JxWUSKEOWy99FSI=;
        b=IluLLykUOTDD+psrEuJJ8qtzVvZF/MzqDimXxmIfyODi5bzZbbXAF0ctnQ/vYUHfyw
         4bqQFhKbu+uJ5DCiai/VoN60QQs67IW+Am9okn3lwlryXf/EdPT7nLoeP+0Ad/K5iKfs
         PqlZHnji00mLReu5fBu/Db4y6B6VElbDGNeyZEJgfAHAJXTC8lnn+pVyMdvXi9hi8KvS
         Ass7JE1UPReShaRs0YTqI36CbZ0MRDV2J6k9TdnlyaHJbCr+e5MCy30Vp7uHcoQx02ve
         8uBy2o7H9YGx4YkjLUaUHztB9hRhH8Ucq2Gn5OXRtjEkHiC6bmc3udDv65yD/XUK1JK8
         sQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995382; x=1698600182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JIMYJiPAhT+0FE33ih8JeSS7Sn9JxWUSKEOWy99FSI=;
        b=ObDT6kDyHKOMAVy0z+qhWsxFFPl8pJKBS8wU3sH733k7mR2jVvk5FpoR5M8jWStvx3
         6pLFwi0JTuuY4FE+lASv8rt9ClZvV+sSmIjx8Ns9sUiqUt4/7gblKRDFJVqO/JB5riYk
         Qe3VThlEc4mKPSBFC1+xcFTTIQojf0zZK8obsCZqCOr5UBDvIYU6SP2Xt20jMfB4RSu7
         pUbV/OZTBerMfgnXy9Bh4mDM4lE4OYVidCEE4bO7H2DxWI1PoQzp3VBglRT5bv1H5nbc
         LpbiC2j7RorHON5b9W05vltpUrOxKRTGescNeFotV3079I7TNaFq686RbX5S9Vw9dtM6
         linA==
X-Gm-Message-State: AOJu0YzK8d8U7wIBs5XUrkqNpJiSqwcmNNZvZYiUPELi4wPKS96S+Cs2
        aqt2v+cFaN09Wj68Nq1jxXsZQJUZ+sA=
X-Google-Smtp-Source: AGHT+IG43p1SgH5athyqDAxChxQi411tj/4Eum7fffB/82pppqYa07qN5bbfR/pE5TeNaCQGzxAhOA==
X-Received: by 2002:adf:ed0e:0:b0:31f:afeb:4e7d with SMTP id a14-20020adfed0e000000b0031fafeb4e7dmr6504824wro.18.1697995381896;
        Sun, 22 Oct 2023 10:23:01 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:01 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/5] Add support for BMP390 and various driver cleanups
Date:   Sun, 22 Oct 2023 19:22:16 +0200
Message-ID: <cover.1697994521.git.ang.iglesiasg@gmail.com>
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

Changes in v2:
	- Dropped unnecessary register reorder in patch 3.
	- Simplified error reporting on patch 4 avoiding string memallocs.
	- Added fallback logic on patch 4 to follow firmware configuration
	  whether device ID matches with any of the known devices IDs.


Angel Iglesias (4):
  iio: pressure: bmp280: Use spi_get_device_match_data()
  iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
  iio: pressure: bmp280: Allow multiple chips id per family of devices
  iio: pressure: bmp280: Add support for BMP390

Biju Das (1):
  iio: pressure: bmp280: Use i2c_get_match_data()

 drivers/iio/pressure/bmp280-core.c | 38 +++++++++++++++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c  |  8 +++----
 drivers/iio/pressure/bmp280-spi.c  | 10 +++-----
 drivers/iio/pressure/bmp280.h      |  4 +++-
 4 files changed, 38 insertions(+), 22 deletions(-)


base-commit: 89e2233386a5670d15908628b63e611cb03b0d03
-- 
2.42.0

