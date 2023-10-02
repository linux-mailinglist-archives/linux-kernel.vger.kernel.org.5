Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2F7B4D22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjJBINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjJBIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:12:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC0C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:12:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50585357903so683981e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696234368; x=1696839168; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGUYisSFuCVSXERDSMArhOminCdOTb9Vp2WMHo/RH4E=;
        b=Dbt5BXt0HtfZftTC8007MeLuDQT6jbYUD87C3GiVicYIDFZLpbtFRJY7WV9TYsV7+K
         vHhwUxm8plxE+g5CCahu1sFVHCWqvUb4d46KiNe0CSSwE/+28lzlgsq00IN1KcBx9yD+
         eJvDYCEzv+GOR5PzD2FtRCxJLyEO2cXaYCwQ7M0J/qzuKjtwktr0jJ1V+G64A8jflPlg
         Ze0Oeyh3YFNlS6FtlN527VEtxE9ZZHzbkHPgMgs/5PL0fPXf0/mGpjX5N/dYLclpzZ5h
         lwxMuTOxFvjLP1ACEAt9XCRthl8bnXQXRxK5wDqzrQj8O6YMIVVRDzFLNLChyyxJKrhg
         sSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696234368; x=1696839168;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGUYisSFuCVSXERDSMArhOminCdOTb9Vp2WMHo/RH4E=;
        b=KO65/jGRo/LQXDoSl1BLXckFve32DT0SJ8LfnnpPzMc0SHDJsbAxmvpgl2qMEsFrVu
         uCwdqMp5ujsOx6xbwnP+hobwraGmDI7SHerASF9FUerV9PeblEGSsknTbtYNAzs8LoZ8
         KeUHzfXsSpGM88EQ9n8+FLhgrigpur+IxVCuOgIxOzvvQAAtUPvWCKNEBeS0wPVxhCiH
         Kmky1ZP7qtaSeK9dhHo3sw8ZpUVEYXj3KO+LkSCnLdkyLb3msEX3TECUCo5Dej8myKmp
         tsaU9YbI1ai3BOWD4VxDHrDlLPeqzHWqO9A9+dpi342RzR/N+KPICbB0XGGPiFqW+eRq
         h/aA==
X-Gm-Message-State: AOJu0Yz5TruIFhF7PfAxXRFQDwKbAv0LKZ3ceVmvpl/fGWUHjlzmZEVX
        rv82/rrKqIMyBpYzQGjy4yilxdK5dDcEGA8dT3k=
X-Google-Smtp-Source: AGHT+IFQnoc+9y60VYcF0TtnMOhJ9Clrfj/YiZsM8pd6waG3N+pD7MO20yEf9ouUtM9wNySw+AZBfw==
X-Received: by 2002:a19:c504:0:b0:503:8fa:da21 with SMTP id w4-20020a19c504000000b0050308fada21mr9021707lfe.43.1696234368515;
        Mon, 02 Oct 2023 01:12:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a19ac47000000b004fb7359ab83sm4631451lfc.80.2023.10.02.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:12:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 02 Oct 2023 10:12:47 +0200
Subject: [PATCH] gpio: Further document optional GPIOLIB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-gpiodoc-v1-1-a8ec8376bbf1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH57GmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwMj3fSCzPyU/GTd5DRLE2MDMxPDJEtDJaDqgqLUtMwKsEnRsbW1AEq
 EgStZAAAA
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optional GPIOLIB as in not depended on or selected by a driver
should NOT use any *_optional() calls, this becomes paradoxical.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/driver-api/gpio/consumer.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index de6fc79ad6f0..3e588b9d678c 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -29,6 +29,10 @@ warnings. These stubs are used for two use cases:
   will use it under other compile-time configurations. In this case the
   consumer must make sure not to call into these functions, or the user will
   be met with console warnings that may be perceived as intimidating.
+  Combining truly optional GPIOLIB usage with calls to
+  ``[devm_]gpiod_get_optional()`` is a *bad idea*, and will result in weird
+  error messages. Use the ordinary getter functions with optional GPIOLIB:
+  some open coding of error handling should be expected when you do this.
 
 All the functions that work with the descriptor-based GPIO interface are
 prefixed with ``gpiod_``. The ``gpio_`` prefix is used for the legacy

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231002-gpiodoc-cf9430641b91

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

