Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6B7EB749
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKNUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjKNUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FF18A;
        Tue, 14 Nov 2023 12:06:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso256216a12.1;
        Tue, 14 Nov 2023 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992391; x=1700597191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHqmZQtpCfDNx8aSq2U41jb/Kk8YGjCcXQnDvNvG/4s=;
        b=OVfJVElCIQ5vT7ELyh6MJYqdumoRb/n66EPzsLu/nf3UvnaooVlOJTMcNol2j80q1V
         UwwSWaElRq33uSneLbyO/ZhocD2ITY+iCTBJD/yvRYJtF55MW/d6LqGjewzOBiucXNDp
         pEEaag8OtxzLQ3gWdzc8CSY4S2+TM6YJoLHRfoF0dV4FjAMXfSxNIuK65UNNtXNLICqV
         C9XlqrtWIa5IOeXuCzLBP1g0WVZPmyEcln/Lb5uPy9tSx4oLyrdtcjNeRsdnMKy/uhST
         fWwOlb38q/s0IJDv4+jCczWGCkQVdHCsRsVx2uDr3Mzxw9YJu8FsPHOKTF8UEUbETIa7
         ApuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992391; x=1700597191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHqmZQtpCfDNx8aSq2U41jb/Kk8YGjCcXQnDvNvG/4s=;
        b=Bs7S1uwqD2KLQh1Fi9ewnXXJJONLZmTY7haGKKsB2KsR5o9vSnkyZsQL9xcwE0x5Pf
         wYNJ9TXbTRQMs2ce2WYON6YTsVs5F28wuYwUxqr6RznpzNnAChO6syUr/c6Si+vZ/tRc
         KxoojHxRh2KofMnK03Jh+U54/EO3htsec1NBuZs0UgAmcV4pAK64lDzGd+FV/m/zGExg
         5NZ2vyQR685DMzDgSx9h8m/R/QuFySJMKC2Wq6DjeUEwN4FmO1w9V2w0DN/0BKEVa9/L
         yADg9kuffLqh6Vkrzl1D3ycQ2rpBZ/hyRkSkL9pqhdpkTh9DPITeMy774VLj/i0OAHP9
         5luQ==
X-Gm-Message-State: AOJu0Yy4Lgev3FVCoiMetHM39UDK6QLWC/zRjWvcjJXzPmorYLSJ01i9
        qxkbmcnPqbiufDzAPzZlXiQ=
X-Google-Smtp-Source: AGHT+IGYcF3sw91u9Mb8PeF1/f2eeg0FghwvAfphmlFXB39+fUZYeYYr62DYmnd4AMVp06QWUmxzkg==
X-Received: by 2002:a17:906:da1d:b0:9f2:8220:3f57 with SMTP id fi29-20020a170906da1d00b009f282203f57mr157979ejb.8.1699992391605;
        Tue, 14 Nov 2023 12:06:31 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:06:31 -0800 (PST)
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date:   Tue, 14 Nov 2023 22:05:32 +0200
Message-Id: <20231114200533.137995-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114200533.137995-1-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 9b59d6eea368..800b396f5993 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -21,6 +21,7 @@ properties:
       - adi,ad7190
       - adi,ad7192
       - adi,ad7193
+      - adi,ad7194
       - adi,ad7195
 
   reg:
@@ -108,6 +109,42 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          const: adi,ad7194
+    then:
+      properties:
+        '#address-cells':
+          const: 1
+
+        '#size-cells':
+          const: 0
+
+      patternProperties:
+        "^channel@([0-7a-f])$":
+          type: object
+          $ref: adc.yaml
+          unevaluatedProperties: false
+
+          properties:
+            reg:
+              description: The channel index.
+              minimum: 0
+              maximum: 7
+
+            diff-channels:
+              description: |
+                The differential channel pair for Ad7194 configurable channels. The
+                first channel is the positive input, the second channel is the
+                negative input.
+              items:
+                minimum: 1
+                maximum: 16
+
+          required:
+            - reg
+            - diff-channels
 
 unevaluatedProperties: false
 
@@ -137,3 +174,40 @@ examples:
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

