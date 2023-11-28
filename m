Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765187FCA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjK1W4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1W43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:56:29 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146A8F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:56:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bc4fe8158so72177e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701212194; x=1701816994; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xuLFYcf0TNvhnaNMn05DlMPThucmO+PUnWnxmCggZI=;
        b=tZGFT/HbWTpHlL75cnWG0tt0A1z3WRQZ/iZFFMk35F/smV9VEHedJ5mruvYrsLjVE7
         9OaWddlsWpuYLtn/TA4/VYcmU0hEf6stJ6GSeJjFwvtH9VQdpRc/OFemWcGHl6OlHIdW
         VCktzHCfrB+kDYPwLJmmMwUdKZaU99YWvAYr/0KqIYJgZsrSpjJfX7CZjRgwsRD3v4n7
         p5Yu2tMvdQfh3eoq+zzG4qYrtRzek2KykG/2eJ6pyB/rV7kG71/VVqfiwr1dmkax3SHN
         R1AjFzmyETgqXlmrJxNG3tiNDdYz1iSEfQ0vMGVEIS6FS7vOUWVvfDJi17jOu5oSIXYt
         8OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212194; x=1701816994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xuLFYcf0TNvhnaNMn05DlMPThucmO+PUnWnxmCggZI=;
        b=mQdEcJaoekm8rBPL9Y69DTWJG4MCU1Svl8PofFQb6zKF/5zU73P8aHnJGxlhb8ESNF
         WiiV5XMw953+nYvPWHFVFClqaCj4dvv5O5oNBiQPRb7ac9Bl1csN6LvMOBtPZ7mdMUpB
         RuUKJ055VRmwDhaT41mzUGe+W1I502y6GQhw88S9uUW0EO1EaXUrypoCGTZyeFlua/9D
         4bSoKoo7Mz76hJeFL85qqZ4LQm24VEChO3lRPYw/vUrM0gGkJmeULRe0Q31fvUFHrfEN
         FjUYr2/S3koO6PF/cb2EOa7yhaR+RxMY+DoLnK5NwwqPiUpxJGWZnhm2XV7l+qSjK3tS
         4S1g==
X-Gm-Message-State: AOJu0YyohNSweTwcL6e4i8wZb30/f20do/sFL7IFUmFCUakXg+dbku/k
        oS9ow+4AQnQ1rgKjWUr1z6Hfyw==
X-Google-Smtp-Source: AGHT+IHsR0VwQA4IHasXgAGq/EHOQVJtBo8gaHlxH/zBpSKVYWB8W7dA5ok7G4m3yTpFtwdPU9zyvA==
X-Received: by 2002:ac2:4acc:0:b0:50b:c062:92e1 with SMTP id m12-20020ac24acc000000b0050bc06292e1mr1513725lfp.6.1701212194002;
        Tue, 28 Nov 2023 14:56:34 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512309400b0050aa9cfc238sm1963698lfd.89.2023.11.28.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:56:33 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 23:56:32 +0100
Subject: [PATCH] iio: proximity: irsd200: Drop unused include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB9wZmUC/x3MQQqAIBBA0avErBNSw6KrRAvTqWaTMhMRSHdPW
 r7F/wUEmVBgagow3iSUzgrdNhAOf+6oKFaD6YzV2owqogSmfCUWRZSUGzpnPK69swPUKjNu9Pz
 HeXnfD9ntx/FhAAAA
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver includes the legacy GPIO header <linux/gpio.h> but doesn't
use any symbols from it. Drop it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/proximity/irsd200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index bdff91f6b1a3..323ac6dac90e 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -7,7 +7,6 @@
 
 #include <asm/unaligned.h>
 #include <linux/bitfield.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>

---
base-commit: 05b5bdf18a6ba2dd9db82b6296d4edd6465b6210
change-id: 20231128-descriptors-iio-67062aeb4637

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

