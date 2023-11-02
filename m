Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D467DFB0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbjKBTiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbjKBTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:38:04 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341B197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:38:01 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7afd45199so16474467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698953881; x=1699558681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YxDo5I+EX0yrxCfQAZ7+uuLIS/24nsDH11HDbkhlEo=;
        b=o4wC70omJK4OgIHih9ZrYz6Hb9xj+3W/8ETAl29XOTiA+YdWC4rl+RMgDyXJXHunxw
         54+JKCFP+xaPoEE0UB6eaHBs/X4vJ8ytUSKUphx0GEI9D+eo+txzYr8gvPZUTWKsNbtr
         UrIYDselLKNn5SVcEJE0Ixl//fx327PKvKmvcFYHsdJEnv/yOQiAjVegdAw4j6bt3Sia
         k8To7mGqh51Kb8YjAgD6gfAzCgtN8CCtEiEc2QcSAPt70JnEgFySdMx+9pgIiboE3Mp8
         t1EYJz/QPUdXEgIqhu4aW/A8XIYNnVV09fE8+y1KAJBDLav8H/4TFOXOi5UIfrtITwUY
         ibiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953881; x=1699558681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YxDo5I+EX0yrxCfQAZ7+uuLIS/24nsDH11HDbkhlEo=;
        b=tAbXM0+j8005onV5WIHjpfHHKQE35Wxjfx0SxrdsIS2V2qKG7OqOQo0mHCqzKOAMR1
         k3ipYn78x0Mq81Goah3XpJFQTCiFVV0Ogu7gl6+Igx5NnxGT9s9D0ciiSE95Y86GSQ5m
         bi64d7B5sib6bevXJ2powOFZHkT0+RI3cAF14tO7943mlXf7bpQnd9vqKJ9aPhG7UN2w
         xxQeKYeVMM2+C1Ca2A9rDe78LNVJratsryCcfwJro6FnZafZ8qB1hceAUGxqlpYSQRxk
         aRL0yksSYJ/eG/hc7noQGUhxIf7yn0ChsVP4SxLRwLkv62tsyRdQbpSfahkDj+AWoycu
         3eSw==
X-Gm-Message-State: AOJu0YzNneG69MT1mtbwwE+WdUwKPMUkHwMmQXPudps7eraEmyYoRS8o
        3etn8wpKt7tdQk914JODJyTDdw==
X-Google-Smtp-Source: AGHT+IEZoJ1CRKlf8Tf6WDEq6K7gFBAfOJEJb5tFuGsIrr/px8RBoV3gByLjxFR9jKsU8noJVGElOw==
X-Received: by 2002:a05:690c:ed0:b0:5a7:b53f:c304 with SMTP id cs16-20020a05690c0ed000b005a7b53fc304mr883688ywb.37.1698953881190;
        Thu, 02 Nov 2023 12:38:01 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce90a000000b0065b260eafd9sm30654qvo.87.2023.11.02.12.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:38:00 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH v2 3/5] dt-bindings: spi: add stm32f7-spi compatible
Date:   Thu,  2 Nov 2023 15:37:20 -0400
Message-ID: <20231102193722.3042245-4-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32F7 SPI peripheral is nearly identical to the STM32F4, with the
only significant differences being support for a wider range of word
sizes and the addition of 32-bit transmit and receive FIFOs.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index ae0f082bd377..5754d603f34f 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - st,stm32f4-spi
+      - st,stm32f7-spi
       - st,stm32h7-spi
 
   reg:
-- 
2.42.0

