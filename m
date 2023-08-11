Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AE778973
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHKJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:08:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3532D61
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so2659974e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691744909; x=1692349709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lY+LwKhdiwT5yUuk0pfp4VDPScPM/Qp05zIRykeUedo=;
        b=Ymm1VEr5VHHuUz1h0+0XGLFthsQ1Rf6B3gZS+Lpm3PWXOMXbVuAXMspHQ2NfZ+IvXK
         7YO2Cp1V+hFu44BiVs8JmnR9WyGqm8b47pRH3/zmUnj6meoZi2gPBy/t23j0A9Htdk17
         41x6Ipud2ZsqAgi1YleOSLog0zNo+LgL4bsMQhbKcV0tjKUjrpD7TdFBFKRWPeMD5JUh
         OOpeR51vEF3o/sniMiYFHlpseN/0h87a597AaogHaTTB5Ufbpmi+t/KlmdqXzQdbbQjr
         xK7/nGXBAARgUld1YIPelNHRgJcMZ1y2EDDh9WFLd+UZBd/ACjTzPcCK2zKRWBEQIGSL
         XpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744909; x=1692349709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY+LwKhdiwT5yUuk0pfp4VDPScPM/Qp05zIRykeUedo=;
        b=F2mLLw0gANmXIPVoCrZGibawOzsIoVXyv8PhqD3z0AsHoF0MYVXeZqYJ29FGjPI03p
         cHN0z3GHT2JxmywtVn4Nfo0mvAyNnQaaC5WAJdgZtRyzJvUzt9C9GKTc0tTxRkRdbSoQ
         8vmRfDpLUtMGJCqApxFrunu3uzOlxse0q21YRy7CDJl/33DNf15oNS87NZSaLNzEIOM+
         5kQ7DNaunEHgeR4+Xoj9Wj1O2CPGoZY87dsqaqdaDgWDEy52LvVcHdjUhKNUS0JG7CJK
         iymoGgF7jlDpQUcyw24rkkLHoCTevZq5Z6k9/cGO+vR7ZJ9wti/K7N9OsmChdYYjYxTW
         x6CA==
X-Gm-Message-State: AOJu0Yw5qsGelFZWhA5Pq6kG47vDwuoAeLT2CXzdQ3NONCpRumL8lbaa
        QL9qkCjO1Wger8j3O5FuaSNP6Q==
X-Google-Smtp-Source: AGHT+IHGPuOs6tx4yRfVp0Qm9TI8cnImteMDWSv8MiPZfesohXJLwu0z7qx277pTjY90I59383tM1w==
X-Received: by 2002:a05:6512:33ca:b0:4fe:8e0:87f3 with SMTP id d10-20020a05651233ca00b004fe08e087f3mr927803lfg.41.1691744908749;
        Fri, 11 Aug 2023 02:08:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm642340lfl.299.2023.08.11.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:08:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] iio: imu: lsm6dsx: Support temperature and ism330dhc
Date:   Fri, 11 Aug 2023 11:08:24 +0200
Message-Id: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIj61WQC/x3MSQqAMAxA0atI1gY6qKhXERfaRg04lAZEKN7d4
 vIt/k8gFJkE+iJBpJuFrzNDlwW4bTpXQvbZYJSxqtUamS+UMDl6cJej8aLQWtfZpqaumhfIYYi
 08PNPh/F9P0RtFZtkAAAA
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISM330DHC is used in the SpaceX Starlink terminals which
are running a realtime patched close-to-mainline Linux kernel so
let's support it because why not.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      iio: lsm6dsx: Support temperature channel
      iio: imu: lsm6dsx: Add support for ism330dhc

 drivers/iio/imu/st_lsm6dsx/Kconfig             |  8 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 26 ++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  4 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 73 ++++++++++++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  4 ++
 6 files changed, 109 insertions(+), 11 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230811-iio-spacex-lsm6ds0-33c9365e94bf

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

