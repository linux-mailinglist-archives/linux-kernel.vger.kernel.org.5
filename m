Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08977712FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjHEXPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEXPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:15:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20D1BD4;
        Sat,  5 Aug 2023 16:15:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3178fa77b27so2765828f8f.2;
        Sat, 05 Aug 2023 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691277315; x=1691882115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beDGLo+V9tYi1NC6Mqk4Hw16Mmd1NJVmpAh76oapTaw=;
        b=qsPQMalYlf9E3fs6q/wdXiOa2o6UDNpV45aBKqztlOnC97egwtaH3bemLLtf0iNGPE
         jXJt6JUyAQAEb7UCr+XBwd/7VeBzK48sggcP+LCWDo5SgEybAxuUThj6lmDK47RgRmGe
         44n+9dDxGFVShhToBsO/0gBweK+8xXC8ErTz3P7/d5hXfcaVFkpFI0gDEZ/j9O2HQElY
         tRwr7xvIW/rf/+YuWAfG6zVDQzDRb4ypB10egdRYiY6TMIjKE1K76mIv3/CbG6ko1/6J
         JO0uvU6fIh2vuCPo0300OKt9qNlSdtmJbGmWzKL4If+0tJAD6JTSn+F2+q/UsyuL0Swj
         UXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691277315; x=1691882115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beDGLo+V9tYi1NC6Mqk4Hw16Mmd1NJVmpAh76oapTaw=;
        b=AJYKebSEtIpTBL13VmMaQkV2uFvFPJzGdW7NvMpnVS662O9fYRrp9K/OO+1F4lbfLy
         /KWMxnjTdedY3aRR7iD9pf/6gKUSm4VeVcQWH2GjmT/khq7lgecikcbjo4dVsmP+SHWi
         T8QaGqaV3brHJ4kw91ZpkX3XIhy3sPN9cLegS3NXpgzsy9icjExskKkINx9Blt+7Lbos
         VER000uMLmOvfIqsb5HoDagB4QvJwKvuX2IJC8l46ycMDuHCuVenUf9E4Hy12g1EMz8w
         AZyZQjgxMySI38GyZAL+j+2vJI6oAwNjuZ5y0szgiML+3VdFI7GE6MX9DgkS22eQcoXU
         OTpQ==
X-Gm-Message-State: AOJu0YwubaC1JlzeSKjVZ/p13wDW/6Y7WVSR4+a0F9g8l9tmCk5R8u1G
        wt96DRd8lRCRYOEGJPkfhtR0vRHuRcA=
X-Google-Smtp-Source: AGHT+IG/Pp4ha9IdnhH1Fre5T8jSoIq5dcr+6YPt0wjnuNQ6a9dvyraKopLsv/4F9/IMyE7nDA6ELA==
X-Received: by 2002:a05:6000:1205:b0:315:ad00:e628 with SMTP id e5-20020a056000120500b00315ad00e628mr4379650wrx.47.1691277315100;
        Sat, 05 Aug 2023 16:15:15 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (89.red-83-35-60.dynamicip.rima-tde.net. [83.35.60.89])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm6212531wro.3.2023.08.05.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 16:15:14 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: pressure: bmp280: Use i2c_get_match_data()
Date:   Sun,  6 Aug 2023 01:15:01 +0200
Message-ID: <cover.1691276610.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup of BMP280 i2c code and migration to the new helper function
i2c_get_match_data() instead of device_get_match_data().

Patch 1 reorders local variable declarations on probe function following
the reverse xmas tree to unify styles with other parts of the driver.

Patch 2 ports adtops the i2c_get_match_data() helper on the i2c probe.

Angel Iglesias (2):
  iio: pressure: bmp280: i2c: Rearrange vars in reverse xmas tree order
  iio: pressure: bmp280: Use i2c_get_match_data

 drivers/iio/pressure/bmp280-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


base-commit: 6d9c5ae6a70c9e1017a7a252bc730d9168e219ce
-- 
2.41.0

