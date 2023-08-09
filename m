Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A4F776816
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjHITMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjHITL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC010EC;
        Wed,  9 Aug 2023 12:11:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso939315e9.0;
        Wed, 09 Aug 2023 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608316; x=1692213116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uDePqqh1JbI0eVu6iP8bx2DCZtrWcLofkePNuUdzG4=;
        b=Cu1Mxwme5j0rBg2KV9UVIw/WIr5x/eEVM3MKKni8/vYUB2/KiH/pyrW4kB/d1LFFv+
         89zJjZdvrwIUByfLwOJKgTwHby9R6ZED0RxqcKI2i7TzQYYKcqhBq3GUxUTRxXqRrDaV
         DMinuHD47XdSyIxbS66ChpdLg5mzSU+q+HM0heDYpBnvtF6Z28KZ/Efs6G4AqgybUM/T
         i9tai2/JF/WY0FU/6D51fiWz70BuKM18Vw6q1zFtWinw9EsHgYgciWEoQCcll+5eLDg8
         o4ABpyyZuVFa8wOgtGj/wxSJddHGqNC3hMSk4eo/fpyrx0f0ml+840ekZ1mRGHlmGyw5
         6NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608316; x=1692213116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uDePqqh1JbI0eVu6iP8bx2DCZtrWcLofkePNuUdzG4=;
        b=U/7Eq/6pPsb6aS21Mc/FcSF67BUTDYHj/YmImkMsM7ARCIbYUhD7b1oWlsvR2EeSdq
         QNsPma8/3F+i+gK27wbx6OjxJmCQphy1O4r6PN61RVYSiWqZNzkJCEOAvg5ZLA1Z8Lv7
         VFm3HECI1RcNYJHCCEWdPzps/EydhZqICUVM9Z762D1umWzHt3cryQbZfz1bddzoQgPX
         uTf6P7vpD1vCkrL1kbiCLAMRPtF24Sigu6RHw6Bj3L8maiHGKQtVM6xV7KcINxTKwwWt
         xQUdsav9b3VKNO/RSpIcxaMbxX4amhaWT5NPMfII0PHhywcAWbYU2rc+Uyf2ukPqgCv0
         ox4Q==
X-Gm-Message-State: AOJu0Yw1tFhSAzkp4jwQw1xqa0CM0XgQAJpVwjxmL8jni/JHTqFK5ztU
        CrvoFfRw/6oHSShGIOMg16w=
X-Google-Smtp-Source: AGHT+IH6Ko59Wb2yv6hMOEJ8L68ItbVQM/vgFbtGqqxxQ5s1bhljzPlMp+on4K3439W5zlTQsO9SmA==
X-Received: by 2002:a5d:4683:0:b0:317:3f0c:b40e with SMTP id u3-20020a5d4683000000b003173f0cb40emr240404wrq.58.1691608315839;
        Wed, 09 Aug 2023 12:11:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:55 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Wed,  9 Aug 2023 21:11:35 +0200
Message-Id: <9950e3963600465e1177a20ad8a93a3927c026ef.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
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

Add the missing i2c device id.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
v6:
v5:
v4:
- no changes

v3:                                                                             
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..b5a85ce3a891 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", },
 	{ }
@@ -42,6 +48,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
-- 
2.30.2

