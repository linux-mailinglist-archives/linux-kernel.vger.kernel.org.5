Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0339977FF83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355173AbjHQVHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355200AbjHQVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:06:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BE3589;
        Thu, 17 Aug 2023 14:06:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so2775595e9.2;
        Thu, 17 Aug 2023 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692306398; x=1692911198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqBIkDX0Z+QaRubiEpu+YpXhCxIFhx3aowIzGghFpdM=;
        b=a9jFM/2yeVae9w6AmWNNdM88+MO3GCJ3vIBzJnukg8W6LM+Wflzn4ERq7ieQrDuIcJ
         kIaWDU4al32zzWltJMpI8hW6uAlDnwk+IsZe/QsittA4Vxqf+Ql8NnptHWEW1PPgsAnf
         deAyBKzWc+7aJsIVMqAyUvW6AHgOAnyhyiq8xdu1Uwll0RCf2WJRrHoLoNHKat1otROg
         ZKlJPV2ivYWAtflTpncT29NnXf2I7b/eewLyeCx+y0yUhhQHoW2cCVdZagYiYeSE0KOV
         IycC/NK0/0BD4uQYNsvvpRlcxZW/jOr684h4+C94cmaP1YG38OYbz+N0bbtHCxjviCUG
         sr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306398; x=1692911198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqBIkDX0Z+QaRubiEpu+YpXhCxIFhx3aowIzGghFpdM=;
        b=Uu6bavv1Yne4Szv6jZW2OmJuQePQArZxWnC7lYer/ekwooGoN15K687HkuEeIfHKWJ
         nSQ3f1m7B6/ZKGUk5gIQx+LFfJ9PQ1588PVTM9bBiy2OXQEPLXKtrSxU8UZDej17gSk7
         kkqrATTeFlPCbo0cYasAWPWjNSBzsmMGOS/sEUB6cZQriiuQWRe7EX9FbQYd9MzjNRmf
         5uMpwY32GeyiPcFLzwjp0abRmmWVcUqyiGojm4diTEDb9TXBGSEvICBPkhcpiP6DUPOz
         JHdACVz/zVf1ose4NKi+6wBcIs7S0Y943zIMcUry7/JudSNDqXJ52SCZRS6zLS/wWvAQ
         nruQ==
X-Gm-Message-State: AOJu0YwTYQWMs/D4xw2691/1CT5esMa3qPRfeGrKQCco0YSNEoLOq74Q
        B0OhJfaIV7AbMD65GVMPZqpXMsSp9rY=
X-Google-Smtp-Source: AGHT+IG7dLLq+oI54NeNQ+YX0Xe9R4Qj4Q2cork8Cci1H0MEiGN2dbyhg9ghDnItmaO7j54yFVlC0Q==
X-Received: by 2002:a7b:cc1a:0:b0:3fe:795:712a with SMTP id f26-20020a7bcc1a000000b003fe0795712amr619771wmh.27.1692306397649;
        Thu, 17 Aug 2023 14:06:37 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c11cf00b003fe215e4492sm669727wmi.4.2023.08.17.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:06:37 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] iio: pressure: bmp280: Add support for BMP390
Date:   Thu, 17 Aug 2023 23:05:22 +0200
Message-ID: <a34c72a2027c4b98bd815e8cf01f56d69c5d1386.1692305434.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692305434.git.ang.iglesiasg@gmail.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
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

Adds BMP390 device id to the supported ids on bmp380 sensor family

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 67941a67e513..f2a63513e7eb 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1225,7 +1225,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
-static const int bmp380_chip_ids[] = { BMP380_CHIP_ID };
+static const int bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index d68745254340..bfb98e3a5596 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -293,6 +293,7 @@
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
 #define BME280_CHIP_ID			0x60
+#define BMP390_CHIP_ID			0x60
 #define BMP280_SOFT_RESET_VAL		0xB6
 
 /* BMP280 register skipped special values */
-- 
2.41.0

