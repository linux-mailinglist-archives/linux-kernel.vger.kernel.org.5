Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9789979BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbjIKVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjIKI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:28:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BD116
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:28:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso6859214e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420878; x=1695025678; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ant9w/M8lJ8/bqeJlIlR81Dk6HgwwGjD6bLZoS2FcM=;
        b=IyzFUixM56/D4EovSWb9hgR2oL57OL+VIyfxiRMcJs+VKzUIqJ8nwi2j4uY3rgZUmT
         jyHawhoWbJj7ANH/NTLDOIAe5n5CKNQ0UE3XrWKm7CJMRddYVAnoAGEG/4QLps/CklOg
         Y7Jw/izFYaHaf6wPw0LdCBdioeZImaCLGglt75kpe/IlEIYgJ2kntaLYJjyOGBhqHW+v
         T4DsXsxzVwC3Fl9QLkXHL0PfhoxtpgyX3ccPyzt3t51GOcQRHXMszapMduwms32FHY+f
         3DY78IXwGmGWNt7kVS2RCgx3jP89cuvcslJeD9a8K1q+aoaJWT0TUa7Acfy9u7qoTWx7
         NPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420878; x=1695025678;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ant9w/M8lJ8/bqeJlIlR81Dk6HgwwGjD6bLZoS2FcM=;
        b=etKS2oYnKJK2E5QRtT3ru3a9N/pkK9SEjyDa6XKThoORzlhw+LeT2KyHS3fhM0u96A
         /GllnmYMV+tL2/hpzUPHS27IT0PkdUBuzdQhNXJvt+eLLJB0NdHI3+6be8b0hABgDFr7
         m/mVYJQy1k+t5OfBXRJfM+ryfwa/ZOxDVodKiAP7CJ69HDnx0ctnrTKEWRfBZl+aqkGm
         5Hbbe1yO5QLi8exbmC9S2EbT5ppmecghTz8szUJzCq46sdqWSqFP2VyEDTGzA0/TXppL
         GIrfNeGwnnQJthufovtynhazf+c1Kn/s7s5EQRh1Z0hrrFFI326TvuGvsCFgY4kDOt3Q
         e4vQ==
X-Gm-Message-State: AOJu0YyiSsP1TWemx55LsUwMnwRMsSjr+5akX4RtMBFbVshC8uWKrAYL
        BwVnGXhUTxiSO6gCjBLd2JuiQbY6n8xd6KOuu9w=
X-Google-Smtp-Source: AGHT+IFLGIOqVnXFWErddjEW3L5OvOYLNCSgzbMfhN71ZCO7WhkLQqRXFrPnDwQ63q3uvX2l/z43bw==
X-Received: by 2002:a19:2d17:0:b0:500:9946:9c69 with SMTP id k23-20020a192d17000000b0050099469c69mr6021171lfj.29.1694420878624;
        Mon, 11 Sep 2023 01:27:58 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h25-20020ac25979000000b004fe83d228e4sm1268022lfp.71.2023.09.11.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:27:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:27:58 +0200
Subject: [PATCH v2] regulator: rk808: Drop useless headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-descriptors-regulator-v2-1-ce978c52c557@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI3P/mQC/42NQQqDMBBFryJZNyUmWqOr3qO4iGaiA2Jk0oYW8
 e6NQqGbQnfzhv/+X1kAQgisyVZGEDGgnxPIU8b60cwDcLSJmRRSCS0qbiH0hMvdU+AEw2My6eQ
 KbGUK6ayoJEvuQuDwefTe2sQjhhR7HTMx37+fRv2jMeZccOlcqTpxMV1prhPOhvzZ07Av/KPXq
 u5K0IW1uf7W223b3gNeCW36AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK808 is already using the proper <linux/gpio/consumer.h>
header and includes the legacy headers <linux/gpio.h> and
<linux/of_gpio.h> for no reason, drop the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This removes some low hanging dangling <linux/gpio.h>
includes.
---
Changes in v2:
- Just the dangling RK808 patch from previous work remains
- Link to v1: https://lore.kernel.org/r/20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org
---
 drivers/regulator/rk808-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 867a2cf243f6..e374fa6e5f28 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -15,10 +15,8 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/mfd/rk808.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230807-descriptors-regulator-3ed7a42fd072

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

