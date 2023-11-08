Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4F7E4F97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjKHD6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHD6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:58:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265E10C9;
        Tue,  7 Nov 2023 19:58:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2802d218242so6030607a91.1;
        Tue, 07 Nov 2023 19:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699415917; x=1700020717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oW6+TAcsgkVX2L728YvNO81hwlzTKV4x5733S3mNdBs=;
        b=bglv6N8DuJitXWrUptcBK8WcyKnGYo4TA1XyIylhx1WElnLpleGVemLVqSbUWUGBz7
         tkiPILMkjTNAvcCUMNStW7YtHupXNTvckIgSNbR5ktHs6YHB9qeR9ANdwSi4f+pDbWsW
         6X97FormUxyGIJpGlZu5PTO3L+ZN1UKHo2AglFl0rRrddsNnmgUhx1Ydn+aq3ZRZGUme
         x1ugRebRbFoj5s2ubfd5A6ibMra9mtkJIZFeuBc07SwK9OajaEZUOdUeDjrqMr16WLd6
         iRm/mpIzOWe4SfkZ/4OEHzR2OcNnnLkWLnB3mIMjbJRxVLDktKFNBHPmZwefWinSI+Pf
         0LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699415917; x=1700020717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW6+TAcsgkVX2L728YvNO81hwlzTKV4x5733S3mNdBs=;
        b=Y4L9MS5kl277gtsdN20hTtFfi03Gii15tbR7InrLo8VzjnVKAU6zAO+tiOVXG4UraC
         PiphLmQdtNGndH8k795f3WOTJR+0osOHsaInOHJcd7q6TUb94nN7KiJes4Xs84y1tLPe
         tMPls1M/+Ggft0OCOqsBtyVkTt5j4fu72LwfARSYxL0xNYbobo+nLZGrx3gCN6KxH6qz
         YwShDg8FtXB+a78YYtUmKqvMdZsNJ9TEKHlguP3RxaVqMsnJbzN3ae8Ghpoee7g7BeZ9
         ap0hVuC/Qth93RD2NcOp+DcUHa3g37WFR/XsBXZRv01jnXqTeZGdKlxADp8oGGtQlf6u
         RM6Q==
X-Gm-Message-State: AOJu0YwmPVlSqf7cd3/jhAvv3kt5UJyuzO7fIc99LaxCXbsCXCnTP644
        yZ0GwKmCvDMEA115/5xl5A0=
X-Google-Smtp-Source: AGHT+IGxy8UqGEjSjO7aF6ymfbOkLNMyr0HazzEN6S/9GhcKtZvRfqbDP14jdiEY+DyyheZBAIs3sw==
X-Received: by 2002:a17:90b:2250:b0:27d:b811:2fe4 with SMTP id hk16-20020a17090b225000b0027db8112fe4mr794680pjb.26.1699415917046;
        Tue, 07 Nov 2023 19:58:37 -0800 (PST)
Received: from localhost.localdomain ([115.99.190.148])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b002635db431a0sm628102pjc.45.2023.11.07.19.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 19:58:36 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, lkp@intel.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi323: Make the local structures static
Date:   Wed,  8 Nov 2023 09:28:31 +0530
Message-Id: <20231108035831.5889-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the local structures static within their respective driver files.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311070530.qKhLTz1Y-lkp@intel.com/
Fixes: b512c767e7bc ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_i2c.c | 2 +-
 drivers/iio/imu/bmi323/bmi323_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 0008e186367d..20a8001b9956 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -66,7 +66,7 @@ static struct regmap_bus bmi323_regmap_bus = {
 	.write = bmi323_regmap_i2c_write,
 };
 
-const struct regmap_config bmi323_i2c_regmap_config = {
+static const struct regmap_config bmi323_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = BMI323_CFG_RES_REG,
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
index 6dc3352dd714..7b1e8127d0dd 100644
--- a/drivers/iio/imu/bmi323/bmi323_spi.c
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -41,7 +41,7 @@ static struct regmap_bus bmi323_regmap_bus = {
 	.write = bmi323_regmap_spi_write,
 };
 
-const struct regmap_config bmi323_spi_regmap_config = {
+static const struct regmap_config bmi323_spi_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.pad_bits = 8,
-- 
2.20.1

