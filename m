Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77867AB8AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjIVR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjIVR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:56:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D78730EA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c364fb8a4cso23247915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405237; x=1696010037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLImW1IzePGbN+/EKPq+ioMvgiAmC6mEu6v1g8YfVEg=;
        b=CHQAliV2GLtAhRmw3Y9M6mVpiwxNovQ431EasJv73jASKw0ywvHAvVrJ/ZsZ8sAACA
         xtM1xORYY6eaEf1OHoCWY2TNUlEQcxlRXNx9cHcpaiNKh5BFj8n/tuUiZBrneFrhXWLC
         IDnHSPOLChGXvPlXRq4AlJJ5YgRWLoNpLSxck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405237; x=1696010037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLImW1IzePGbN+/EKPq+ioMvgiAmC6mEu6v1g8YfVEg=;
        b=mgDz0lXgVVrWbNP0IM6p5qGMY0GTTVwWrdanfFoX51CrRTcbmMQOPGC3I6wuxFqBGL
         4cD6suarhpwSPT2wPMSstUheXs+bJ8JZD6dpZ0feW8vZ8Nfp6kcyb6Jut4fiUSYV83fy
         3uL5gPRWdEhBXB9fE+yF8dVD+tN4oCzAyPyWECTpe0HIE+joNjCDCaEzk+hz8ZaQzlCg
         nLvxbulgbL83pvj7W5jpjxfHzEdHNsXgLlmurijKYPU05T2smZH6InBjB1I+a7GGtZg5
         kiiHi038iRMn9FVA4o3JqkXvenNMx7lvCgMu4gkzwXr8nuyP3v/yTtGXM9OQzz6MtvdL
         1gvQ==
X-Gm-Message-State: AOJu0YwK/LnmZ3mSB5ovLr8ptF6nQKUwG+Cddjt+W6dAkLBHvCFPIW87
        C8ny0lk55EvauTPexwFXsvbSBQ==
X-Google-Smtp-Source: AGHT+IGF3fNGmUjC4okiXR6Ev3mOPUrKRgaxVlLdi8Plb8MDgj/4DVzkWP898nuYl3TJbEm6TJyfFw==
X-Received: by 2002:a17:902:f687:b0:1c5:f4c7:b4de with SMTP id l7-20020a170902f68700b001c5f4c7b4demr167642plg.2.1695405236901;
        Fri, 22 Sep 2023 10:53:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001ba066c589dsm3759352plc.137.2023.09.22.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] power: supply: axp20x_ac_power: Annotate struct axp20x_ac_power with __counted_by
Date:   Fri, 22 Sep 2023 10:53:55 -0700
Message-Id: <20230922175355.work.006-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=keescook@chromium.org;
 h=from:subject:message-id; bh=xHCdB+Bm90QD3l3umM0GSzvzHSQIr+R2KIoMY7RnKys=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSze1eY/sp2o8MEriIqwEc63bQLWGuZ7Mxjn
 XsSXzjxXROJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UswAKCRCJcvTf3G3A
 JkmYD/0S5o/H/m1efZ3VLfgKqfWqJMlk1UnalQCznqLB523UsBWOyBFnCxJpx5xAQd2EAH91j5a
 gBDwJWO155sAMdKYBg421/d0lTM+zYXSDZpyICyA1G2Opkka9dhfzlrpNYhCFam98UFxOO9O49t
 djX5PdSHYcJ1C95HbfPuiC1JdN8pDwl7McJKCDJgDQCAqxcVdrRWht/CoTG5zNPGwko91JVvOxE
 K49WJK+FSKVOEG9SKA4ODQDXPrnsr/KXWm19/7Kwtt3/Jt8NOE1k9nY20k90czIRxVH6yn40dw9
 XwA32R13GtGujQRdKcKtYiXvrS3LX9CBP/QL7jK8WW4SSWLrf9AOKgrdpCMOiQybtrE5TFZKxUD
 c01ygdxfBJM+Z9T2vzaWMkVQhSmDloymBckp6Aw4+QxTX2XIpx7Mx6gByTBv/z29kKQTkhctofD
 RjuvWxEJXSBIVdGYVxHEVnejxUNCCPKXMAwYqN41lz81sUypVwcjk0xUl0lL8YdKf7IEP1XHsAq
 cDbRHp3BuasSrnfhdQc4jdnagoA0jZG7RV/C4cA3Lzkcgl4ewRvm5SZvBR5ZrphbGBWdROQqsBu
 cddUfhNcPlDhPH5xrMR4f0qDMI6HV3aebr04+HBX8WrelhuleyrQfVXsc8068m2IVu6OqB5CbUp
 xb8XFZi TX0C2BjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct axp20x_ac_power.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/power/supply/axp20x_ac_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 19a118633115..e5733cb9e19e 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -45,7 +45,7 @@ struct axp20x_ac_power {
 	struct iio_channel *acin_i;
 	bool has_acin_path_sel;
 	unsigned int num_irqs;
-	unsigned int irqs[];
+	unsigned int irqs[] __counted_by(num_irqs);
 };
 
 static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
-- 
2.34.1

