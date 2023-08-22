Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A56784A44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHVTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHVTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790CCF2;
        Tue, 22 Aug 2023 12:20:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50078eba7afso4639245e87.0;
        Tue, 22 Aug 2023 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732044; x=1693336844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QPTswzEs0NNaPACSXZZFvzNW7C4lCRixzMkQxkaQC0=;
        b=Q0v5mcTuQSZJQ7OlvA90SwF2A7EREA9Z49DboMu/yPsK0ypNiom6ET8b1drqP7PdrU
         V5V1zqZP3lqLHgffY/gJKaDGSS4xX9lMY5EA3+CaJsEHXT2I+8StsQLLouxw+OfTiGK/
         LNQQG1jH/e85U6QiWTmw8vT6Z7v42CtvVtiDRkKQannk/YVQaaskamcoCBcmDkoh1AEe
         X0+0lDWbRsGRSUVqhJXR2yd5gT1VqlqbYKoHFYP2jZFjKC7TDBBG5F16Rfgwh6Q9yb7y
         579UjdaN/1L7gW06TPhoeHqzEK/K9Zr5BWW8uJxZtd1nX5jjVxg61RTalrxkOcWIAv2Q
         DjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732044; x=1693336844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QPTswzEs0NNaPACSXZZFvzNW7C4lCRixzMkQxkaQC0=;
        b=YQ/x0QhxxsZd8T2IlQ+L/EF54kWNBoi+VVUPygFhQaF4QNL9huewx1bWlhffYlsSdl
         0AJW0Jfw1vOCq0CrdtbsngzCMKeAmj7MNCZz4t8P4BOY2qpOQKGChs6k5QW4D9qEZjEC
         YamfLGMuyPlnlsvlbrcriiqPCYsM6Sse+LLp1O1w3mSvrWQxP60O25Z678Hoocfc9rk/
         C3NWzeMsNAtZrzSfecon9kP11DqT0k2K/EqdNOr14/ELx8FCHnMQfhW6SJE24z+HcgFB
         wOI54cv34Z+t7uWR6H6Lx1huaBbPthsXTT5qCXF5pfuYqhssuQ4+D9FsV6AhNWJlYnuA
         4KzA==
X-Gm-Message-State: AOJu0Yyq5kC0leqzfXRVjytqDaVzGbM6W6Q/BOmq6gsV4k5ekMz3rPwi
        dxX9TjSPT47E78uAwcif740=
X-Google-Smtp-Source: AGHT+IEdtvULRKNfebeNEnXdyEkgVLnvGQZU/vhy9/JaEsjv7A8lCVzQNFlAvOoj/3MQkqwf5guWZQ==
X-Received: by 2002:a05:6512:3988:b0:500:7e70:ddee with SMTP id j8-20020a056512398800b005007e70ddeemr6757032lfu.8.1692732044102;
        Tue, 22 Aug 2023 12:20:44 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe89735f1asm450586lfi.34.2023.08.22.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:20:42 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/6] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Tue, 22 Aug 2023 21:22:54 +0200
Message-ID: <20230822192259.1125792-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
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

Microchip does have many similar chips, add those to the compatible
string as the driver support is extended.

The new supported chips are:
  - microchip,mcp3910
  - microchip,mcp3912
  - microchip,mcp3913
  - microchip,mcp3914
  - microchip,mcp3918
  - microchip,mcp3919

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v2:
        - No changes
    v3:
        - No changes
    v4:
        - No changes
    v5:
        - No changes
    v6:
        - No changes
    v7:
        - No changes
    v8:
        - No changes

 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index f7b3fde4115a..06951ec5f5da 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -18,7 +18,13 @@ description: |
 properties:
   compatible:
     enum:
+      - microchip,mcp3910
       - microchip,mcp3911
+      - microchip,mcp3912
+      - microchip,mcp3913
+      - microchip,mcp3914
+      - microchip,mcp3918
+      - microchip,mcp3919
 
   reg:
     maxItems: 1
-- 
2.41.0

