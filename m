Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C797E1615
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKETcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKETca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:32:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483D112;
        Sun,  5 Nov 2023 11:32:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso577879766b.1;
        Sun, 05 Nov 2023 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699212745; x=1699817545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agF7FmNdxJL43+j1iH0SmmU3n7HdFDcises4JFJGz6w=;
        b=jGwR9eYNOJDMOLKfx2jyA6SIiq9a77nOH8sGVHSeHK92DAgylbuf+wjmuFeHlk1PhV
         dF3SlS61l8klyZC+deN3gPAr/5JJ5lqB+g+fxPjCL5YtNUQeg4HpCAYprPemM4bFbOKk
         KfPGSEmODLU7ipKcjkxjbxBTZBzFC7dxBgMNcpaR4+kBn0B8ow74GOhcKmcpQTBNKQdL
         Gup5iiHTgQk54ji3zgWlNJ6YA1PAHn1L88iID4DO7zo4CtS+vKICArLJ8+IQfNP8MRFx
         e/mE4fTNw1adJuT4QMqudSscAwCStxtAvYsXttKSzFlHX6qOylAHnQsozfNnBEm7I9r/
         YXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699212745; x=1699817545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agF7FmNdxJL43+j1iH0SmmU3n7HdFDcises4JFJGz6w=;
        b=tE5uvX95D2x+MSUqUjeJ+dYXtcVlrERCHamoH3wBoe0jYDuxlK8UwM0EBGIvgJp0xX
         Oe7TcuWL5cbnW+3zJVbdoSEnR4kMMd7YfmUOG9r2U3olG1teU1xjFU+tyIN7/skKlBw/
         Fr8HNd/0nj6bw+T3PAmXSgTtszU/ZNd795a9yMmZUY7viMlZUje9eEk6NKQHqA5hoRXV
         rmXHo2404OZtH/EA/uV6Jc8C/1Qkwuzsnb+cbk0cgqVLjH3sdXhauEoVyQNKc6s4Nqzq
         OfwpW2Lc7YbDUgVPc5tSDQJkdsXGw1VFbBX81PtTOoqGqyi+fjHVAgwyoB4wNBFkcQUq
         vPUg==
X-Gm-Message-State: AOJu0YyJfoTwh7g/glmy3zjMckHQ2AH9XCAXxFxCQAwqReff7SYOsWJ2
        FTN7mYaKYc+sQ4cL5cHm+hQ=
X-Google-Smtp-Source: AGHT+IFW03Hb4jgMVpoKFT6k2n2/IOwEUF3f/AOeKrhy1HUPc0tVCAI0xKLU/1YelHIXwW52te7wPw==
X-Received: by 2002:a17:907:1b22:b0:9c2:a072:78c4 with SMTP id mp34-20020a1709071b2200b009c2a07278c4mr11405087ejc.25.1699212744922;
        Sun, 05 Nov 2023 11:32:24 -0800 (PST)
Received: from spiri.. ([5.14.137.80])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009b947aacb4bsm3300259ejw.191.2023.11.05.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 11:32:24 -0800 (PST)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date:   Sun,  5 Nov 2023 21:31:30 +0200
Message-Id: <20231105193132.47009-3-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105193132.47009-1-alisadariana@gmail.com>
References: <20231105193132.47009-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..b9a9f7b20670 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -21,8 +21,15 @@ properties:
       - adi,ad7190
       - adi,ad7192
       - adi,ad7193
+      - adi,ad7194
       - adi,ad7195
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -96,6 +103,31 @@ required:
   - spi-cpol
   - spi-cpha
 
+patternProperties:
+  "^channel@([0-9a-f])$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 0
+        maximum: 7
+
+      diff-channels:
+        description: |
+          The differential channel pair for Ad7194 configurable channels. The
+          first channel is the positive input, the second channel is the
+          negative input.
+        items:
+          minimum: 1
+          maximum: 16
+
+    required:
+      - reg
+      - diff-channels
+
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -127,3 +159,40 @@ examples:
             adi,burnout-currents-enable;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "adi,ad7194";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7192_mclk>;
+            clock-names = "mclk";
+            interrupts = <25 0x2>;
+            interrupt-parent = <&gpio>;
+            dvdd-supply = <&dvdd>;
+            avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
+
+            adi,refin2-pins-enable;
+            adi,rejection-60-Hz-enable;
+            adi,buffer-enable;
+            adi,burnout-currents-enable;
+
+            channel@0 {
+                reg = <0>;
+                diff-channels = <1 6>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <2 3>;
+            };
+        };
+    };
-- 
2.34.1

