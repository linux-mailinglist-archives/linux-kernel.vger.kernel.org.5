Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD57686B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjG3R1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjG3R1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:27:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EFE126;
        Sun, 30 Jul 2023 10:27:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso1819377e87.1;
        Sun, 30 Jul 2023 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690738033; x=1691342833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8kWVxhD71IIdy/AgMqM2tISpTPB47LaxO4vVrxguZc=;
        b=MC8TCH9CgDZVR576uMzXETmgTfuqE1VYop4dVcLL3LjAJn0Soyg/bs+FdaRgmxj9BV
         H5vL0/N391Q+Iu6rsGvdgxSi/XSv62QmNoiUxJ8FO4N3t7KUqR/59AX+JqO877BUXMp7
         qauTQVxNpkd8qiLvE5vGLo9tV2nuLrw/H8Mrb5FIrOQbpK1vGge0139O0b91vQv5BcEh
         CXM3gaBUgnuY3aPQlTtgEVy+aPQVQHV1Ry4JECCwvlrag14ldQtdAioVDs3TUJCx1mBX
         bW1hjM5ZcTdRAKc103GwOpYgKR5ZePwf/e3IQ6mnK/NlyzDy9rfsMYvGTKdC8AyWrTse
         5n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690738033; x=1691342833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8kWVxhD71IIdy/AgMqM2tISpTPB47LaxO4vVrxguZc=;
        b=VzDYA6qeZBu+bMU4o+tMDNnpoYe2WlpEjX32IM4RoIVar2DIEF9/JkUVknIcSowu+V
         mhXoC10ybdvPtow1dgnrxqMkqLbcywUf1ZgJZOKxI749kRO543gkWoYm8l3hLRXhUsps
         t0VINaZaTCWrU1/oqd2DsOWt6YMPuRWMXPsZpc24pUz0Xn+DUndk/aSQ9pC/vjn0Op5S
         4RImjh/t3QIAmgP4iCBRShHhmkO+DlKzIV7j2cen0+xMWNbfsoFdHWYkc38Vh186Uyea
         v0XlpD6mCB28ul1YyDvdXQYNdStsKPVMWwjmOh1OKogpwm8L3Ql8iY8CIG2vdyIitMtW
         czMw==
X-Gm-Message-State: ABy/qLaiErryyepXffNpnV7XjEfK4xjvX5jeoxjo3SDf4/swsbBWANQp
        d93DC7L/Ov1Z96oA1fDk+qo=
X-Google-Smtp-Source: APBJJlHfVCNTvAYLLe5UlEX+F6sVrab38+WDRrmWtWQ+2uBoT0OGZ17OjsydWQUIzZ8yznruH2Af9w==
X-Received: by 2002:a19:8c09:0:b0:4fe:1e74:3f3a with SMTP id o9-20020a198c09000000b004fe1e743f3amr4108295lfd.58.1690738032723;
        Sun, 30 Jul 2023 10:27:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b004f8555f7aa1sm1737117lfc.52.2023.07.30.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:27:12 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: maxim,max17040: update properties
Date:   Sun, 30 Jul 2023 20:26:46 +0300
Message-Id: <20230730172648.71578-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730172648.71578-1-clamor95@gmail.com>
References: <20230730172648.71578-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add status and temperature properties.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index 2627cd3eed83..4bccf25a111c 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -55,6 +55,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  io-channels:
+    items:
+      - description: battery temperature
+
+  io-channel-names:
+    items:
+      - const: temp
+
   wakeup-source:
     type: boolean
     description: |
@@ -95,3 +103,26 @@ examples:
         wakeup-source;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max17043";
+        reg = <0x36>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&charger>;
+
+        io-channels = <&adc 8>;
+        io-channel-names = "temp";
+
+        maxim,alert-low-soc-level = <10>;
+        wakeup-source;
+      };
+    };
-- 
2.39.2

