Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E077B332
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHNICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHNIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:01:49 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3349F;
        Mon, 14 Aug 2023 01:01:48 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5236a9788a7so5473915a12.0;
        Mon, 14 Aug 2023 01:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000107; x=1692604907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSi5X4VgjsCMeAaQPLcYj9iEMPItGUk1KSzbhdjTG3Q=;
        b=MkYcbpZmXAZXdsStvHTfA6gJsstR5KEOTTt8CUuwKjNxjuOIQaA5rChfS6E/F5VyKG
         STE0fWXaMHot2lOhBRgM5oRm4RnfjTQAmjn41KaI/HsjOfMGzp52O/HioU9oKiQ77og8
         6z/WUBkrzNLR3zw9xF5VToNARDMTE6uaIOeO38RlFOHpjW7+GUTIvd+L/z8eHWZUCDB7
         FpUvr4FnZrjFhWs6H7mS244v6O5Dqoppyts4UxJsg6d1Oy/CvXitRcu21nF+DxdcshXo
         Dikct8K8gGY45sgCxSmaU5WElmhaFxv9ifkWEvi7rPCWHVtMPRz00qtg2MrmKVospSgz
         thAw==
X-Gm-Message-State: AOJu0YzdDpBmtw7Y3gs8ocaqDO8pAcgMpC9OkdSbtlj53tUYhXuw39gf
        TdOrvDmUHhWq1e9+ZRmkUCs=
X-Google-Smtp-Source: AGHT+IEaAODooEEvQc066LIoQt4jMjMo+rdKjU8jqDHOucWJHkabU02sFbYF/sNsPcVB7Z+X3fz7AQ==
X-Received: by 2002:aa7:d3d3:0:b0:522:1bdd:d41a with SMTP id o19-20020aa7d3d3000000b005221bddd41amr6651311edr.4.1692000106646;
        Mon, 14 Aug 2023 01:01:46 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0052568bf9411sm678074edx.68.2023.08.14.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:01:46 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
Date:   Mon, 14 Aug 2023 09:01:27 +0100
Message-ID: <20230814080128.143613-1-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add T7 compatible line for documentation.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v8:
 - Fix issues with git send-mail command line
Since v7:
 - Send to the correct maintainers

 .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index f1ae8c4934d9..2e189e548327 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -52,6 +52,10 @@ properties:
         items:
           - const: amlogic,meson-g12a-uart
           - const: amlogic,meson-gx-uart
+      - description: UART controller on S4 compatible SoCs
+        items:
+          - const: amlogic,t7-uart
+          - const: amlogic,meson-s4-uart
 
   reg:
     maxItems: 1
-- 
2.41.0

