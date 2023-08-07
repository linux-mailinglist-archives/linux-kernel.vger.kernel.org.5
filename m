Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF73B771B54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHGHQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHGHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:16:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A910CC;
        Mon,  7 Aug 2023 00:16:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so6775896e87.0;
        Mon, 07 Aug 2023 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691392604; x=1691997404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnmGsmfbcV3FCtWSjHP/p76zvM1Crt6DYfqkcErPePc=;
        b=O03/WWJDxGDs5Opo5MCcVRfgVq2ldo/HjAtCkw95muo2CsTbZG2f7gVA2OzaIMHsVy
         6piP96SXE1O2hVtNdU3pAbW4uuA9gDL3trV79nV4CQbdSbfZxm1f+jP4AFP0oO1iRdAY
         lpCHacmFLhppKfnm87Vxf7QDH24n18s3RZhKLdTLSTfWPp63nsbVaYQiCX7H97bNMOGV
         g09Z576Wu96xTg5FpEex2JEkrYJInDZUJ80ylCkQHvspPHd1h0gyTfd2IpgS8dYutrCJ
         ela32tmnj+foxseUA+bhVweKQHhutda7tna8mcG0OwfDxk7NNxkbvNu+ELHzOURR38z/
         YivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392604; x=1691997404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnmGsmfbcV3FCtWSjHP/p76zvM1Crt6DYfqkcErPePc=;
        b=UOyLuSnIUuHKXiB2m3XvFaFGQPYGJq2vjNMVXjnmGKf1pyXZn8WcvsB2OF2uZWuVae
         /iJHZiFlh+tJoLNjtLxGIWp3BLCvq6p8JlJY3BDR/npm+NwQGyqGrV5WfrgKKttnSmM4
         nGli58Rz4fHF7Iop0TU0DJ7QtLSaawpbbMopOpSXt5eV0k+DYnZ3C+Cc4xfnLTPhDrIF
         s9re5j1UCI0JP+Xg9kvh8k9ePApU1FxB+DmPzEupvI75Jir7bg4w4TBA4pw9/pF6wD0V
         06bZjjw6wTnaR3eTgEqfi9nAmgtOeqlvyvKn/5b/E4wEFv6RV9RkiDc8kHWCRd3n2Ap8
         bRMw==
X-Gm-Message-State: AOJu0YyUj1x8sNwRQiTEsZJBwEpxgH6GeL0KqxgVQ8cEcHAk8D1JW7S2
        UBecA8LK91GyZH2I4nRQH3w=
X-Google-Smtp-Source: AGHT+IE/90oz5YLFgsBledSAMUjx7ZetVKlDDY2ToCVDOjcHXWF+aRKAVacuD2me68Em5JjAexil8Q==
X-Received: by 2002:a19:7106:0:b0:4fd:d6ba:73ba with SMTP id m6-20020a197106000000b004fdd6ba73bamr4235167lfc.37.1691392603849;
        Mon, 07 Aug 2023 00:16:43 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25924000000b004fe3d7861ccsm1398283lfi.180.2023.08.07.00.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:16:42 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Mon,  7 Aug 2023 09:18:30 +0200
Message-Id: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
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
2.40.1

