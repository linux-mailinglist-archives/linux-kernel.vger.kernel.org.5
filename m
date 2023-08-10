Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4A7776B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHJLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHJLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:19:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789E10D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so997856a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666357; x=1692271157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=08PCzZQV+ZzJaaurE/RdZbmv1tOgJOzqlJ5y/EyoZXc=;
        b=vHdFjJRb8trHQShMGZCVQJ85MPqOTAUqBNacs8Vxmk8XZqTKMqxYkKpmJot4GVENtS
         Yl4JGTkorhlrIHZ0IimFMiCUmT5tAD1p5C3c+DoC9Gf3uZIZG4/HOm5pMFaHN/w8HHnY
         IWNckQ+MVy2UQDebo0XzncFIWeRFwApg6kSi7l/4Gvf2yGlctE6kc51yyKEbmBuUxW2y
         0pxAjp/q1+w6e/GVTiv7a2IvbZB536U/bQbhib72k32rzRGn26kovpxjP2qn6npEsCRl
         Rgtdpy7L0+DbRnTRO3TSxDiPMhce4VQdToN64eo6HHAD2YeqgbAGMfHHlEXRp9maCymZ
         MQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666357; x=1692271157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08PCzZQV+ZzJaaurE/RdZbmv1tOgJOzqlJ5y/EyoZXc=;
        b=BJs7iAQvZZy9BjMtX1Th9yGGM0sROufSIhKwcaEzgNGMGj01MGF9pG9buutUZG350K
         gZgDhgxCGyT8ZmY+QY+ZcPtjTEGhscXd9kiHP0yf5j0nyJF2biDhsG7Wg5Is6ZOpNW8M
         FGL/IG5JdynwhfRCYm64RfWXbgBtNyeNpTK7aaAf+F6C3xf46AinywdIM0v8sa1eqryI
         xNr8boEarqa9yhzWw7ii4wFrTYUQBnvDRNns/GwKDG9zSNEZHNXfssqjcAuBk7Goysdo
         RfAMSSUCP7g/NXX0wh+wLhyWuy1fQ5yDOJEiUxRpfWVDyONOftKtJpAnnwRESLMp9I/I
         MMkA==
X-Gm-Message-State: AOJu0YzmS/rzLOHfNkJ5CfKXCb9OyF1um/4G9Wi+NXU28GyD0dQYk/Wv
        3l385mJjDRC6k0kJPfN/OupWClPwrdeJDs0QWvLBnw==
X-Google-Smtp-Source: AGHT+IHMFHPCpM1MEXV7eT8sZM7EGAhzio8kzAePnm6+zrrLoNRbFZK7petfu7scq+ppPRHtQdl+Vg==
X-Received: by 2002:a17:906:32d4:b0:99c:ac84:663b with SMTP id k20-20020a17090632d400b0099cac84663bmr1884473ejk.65.1691666357104;
        Thu, 10 Aug 2023 04:19:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm797018ejb.84.2023.08.10.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] regulator: ltc3589: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:12 +0200
Message-Id: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'variant' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  ltc3589.c:394:22: error: cast to smaller integer type 'enum ltc3589_variant' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/ltc3589.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index cf931b8c36dc..d892c2a5df7b 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -391,8 +391,7 @@ static int ltc3589_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ltc3589);
 	if (client->dev.of_node)
-		ltc3589->variant = (enum ltc3589_variant)
-			of_device_get_match_data(&client->dev);
+		ltc3589->variant = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		ltc3589->variant = id->driver_data;
 	ltc3589->dev = dev;
-- 
2.34.1

