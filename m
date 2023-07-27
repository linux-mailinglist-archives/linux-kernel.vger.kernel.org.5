Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073577650A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjG0KLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjG0KLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:11:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502F136;
        Thu, 27 Jul 2023 03:11:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so1324600e87.2;
        Thu, 27 Jul 2023 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690452694; x=1691057494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKG9MVFIRvqoRSnmeWz7npe5982c49Ck/crDS1uk2Vw=;
        b=LbWCII2zEZy68YDOXP9YLqhGDr5/kGqKvMpMYvSs31jIyfjEQNzwU6R2cCGli3gG0d
         o564K2jbiNngGgDVcm9E2y8RXvD11EYAIPILWZnJFELKHzbntUFi1JsMPJxGvGvHZyNR
         F2zWZfestrZeNV9O2NfU7NQp8MEt793m1Hsv3g1V9z7PbTaWQNFdvD+IwE2q0GT6pMQc
         VAk9c6i3y3i0j18NkXpKJR0m1XC93tPDyK+8tNFmTKNQ7K5597sgxGlbftW4N4zvGYiZ
         CU5Fzh8C6YeQufGP/V8noKOUOmaGOX0TjdfRJVE7Z4gnEq9RABBk5/SI9oKN3E5jCDfA
         B3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690452694; x=1691057494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKG9MVFIRvqoRSnmeWz7npe5982c49Ck/crDS1uk2Vw=;
        b=bh9eia6MxAfJmQCmxJIhX23+7TBSom5YmtjP0v+KjO7NgMQqL6DZMZi1GMNkf6pZ3m
         gl09PuDybYo8rPmdOxc3tmE5y0kMu7l3yJkNd13JL++IQWWDoGmdVgonPTxBPArr2Dj4
         mZHbt91OpS6ITEGjyNzEDM6nP3WXQt64gZVB1xnUbtB1sLoc+fv6dtGCUnLFU0t/tdlL
         sZ68EQgUWu5q8/u3KudFsDHrVRbxzLYyb8Q3eDBKh0JU7SQNYZPSrjE8M2uPFMl9+LmY
         Q5QF2Rolrzd/bkhtmpkEGHHXY3DbDw0FySZTigclewqGouykGfmC7ydwV0c0I2kjkmgi
         WFiQ==
X-Gm-Message-State: ABy/qLb1qbca3p+VwmnleYc9FDOAMxgmgE5eGLND5UVgQb2Hsai2yuoL
        YS1poSSyp3kXCeJskC7tlus=
X-Google-Smtp-Source: APBJJlGqEvRJigqsWboW+74h7Pzr0x6BnYIJp5NyelgefKNRgrgJPBlxwj+35f1Im6hIEyfaZ5jwpA==
X-Received: by 2002:a05:6512:2311:b0:4fb:85ad:b6e2 with SMTP id o17-20020a056512231100b004fb85adb6e2mr1493821lfu.50.1690452693851;
        Thu, 27 Jul 2023 03:11:33 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 3-20020ac24843000000b004fb504b0f32sm243664lfy.69.2023.07.27.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 03:11:32 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Thu, 27 Jul 2023 12:13:17 +0200
Message-Id: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
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

