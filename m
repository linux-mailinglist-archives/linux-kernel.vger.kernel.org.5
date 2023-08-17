Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3534977F5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350618AbjHQMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbjHQMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:03:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730382112;
        Thu, 17 Aug 2023 05:02:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so117274041fa.1;
        Thu, 17 Aug 2023 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273777; x=1692878577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMXrXLc0wj0xEWmwzIdD5Z8/MM23PAnf+hN4LdAZ/e4=;
        b=JQNPVTCMeMndORrCxRNralYWboNuL5ZNfBSyQPB1jbQtYXd5KX3jK6RSM5hlgfPCxK
         wxlvmjJWBFIn6WGNK8T5oADEBP+YtWA/91sqxDCWaXfuiaJ5LqK8Kc9SvdZLyrnrkALy
         y95wwWeRrAautvuGT7qxLDtchK9nlNHLuQMb68T41HJf3lKDEEOKo88oUnOqDawVcopP
         +0SoNKWAsFrrqMW7dshQn/IncGwrR3HVkUUpB33EiDURD83hN/b2Necj1e1youRIsAiQ
         BOeM56SVPUZoHsleRZGaiPgZaaJLyFywFxxb2OeoEZz+hSbuWYQ+ZmjeE+/eVxkMlV9B
         uIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273777; x=1692878577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMXrXLc0wj0xEWmwzIdD5Z8/MM23PAnf+hN4LdAZ/e4=;
        b=L5kAhKCMvbWFhG+Ow7TIoctIVt2Wl+a8cxdmNmUu4niGWt4+7A0Tuyi9tPjBHWB5qC
         4BnviCrN3HoSPImGnE8VTGCa2d8lnl6okIFerUdj6S4YIcuHMI64H4tQ351qRyCUaHfO
         RIuRM16kP+HtShF48Z3uIutaq3zFRb1Ew0thKSSaPVXlaQb3EviqdElAXlujsXe0XNn/
         UOgoQYzC/vngubmm5FI8CtK61yATFFhfF+gUZxa/BN8MjePSnugax/OrNy6P4G52Qags
         PVsty09xCO9i8NU48fMb70KLdEjN3iX/qpM9Nf+LWcPAowVnOscfjQ2Cv94KQWhX6bYI
         jqSA==
X-Gm-Message-State: AOJu0YxFfkudeJw3qmzWKnf8C08247mGhTO/uunQiGlg9MVl8yGw9+7q
        H+q5K5tKyWtSsbXmaPmD/Js=
X-Google-Smtp-Source: AGHT+IH0RQjh3vLiZFv8CN6AExeVHERgbftGnQ0xnAQ4Xk7c1MHPKzoDAJy4Yt0HiVkE8p5YcNptqA==
X-Received: by 2002:a2e:97c8:0:b0:2b9:2e85:2fa0 with SMTP id m8-20020a2e97c8000000b002b92e852fa0mr3854989ljj.15.1692273776384;
        Thu, 17 Aug 2023 05:02:56 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm3981213lji.123.2023.08.17.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:02:55 -0700 (PDT)
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
Subject: [PATCH v6 1/6] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Thu, 17 Aug 2023 14:05:13 +0200
Message-ID: <20230817120518.153728-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
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
    v4:
        - No changes
    v5:
        - No changes
    v6:
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

