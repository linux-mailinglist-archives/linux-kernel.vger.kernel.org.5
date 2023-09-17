Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978097A3DC8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjIQVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjIQVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:12:00 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0712B;
        Sun, 17 Sep 2023 14:11:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b962c226ceso63382161fa.3;
        Sun, 17 Sep 2023 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694985112; x=1695589912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSVdBe6r93QrgKS3he21TKM8q8THmRfH47H2f/qi7rs=;
        b=PsNnpMnS3g8oPR55wnZHHExVPpz6jjMODbwO7CzxG+pgoRBIqdNVj8Bu9zl/UZIxdG
         dDUefQm+e7XU3xwfOz4amUs2oHTStqUCVEknZytwqPJ/sr10VLJeDZzpQyibGmTM2kWL
         2pDxrSbhR0lQlzVT8ztZTUWY1mymU6vIQBZys/ukk6nofPe4zg5OKdIx4JOkA+u69n+d
         eBvOeV+0vEyu83EhViJ3BnlFpltkYI9/5H8/bdsd8eLaq7wJxZwnNbPwNpK38nZojkqD
         wGOq5N2q0ZxoR1jpCvMc7e0AofHtPU2RvfIUEh1LUMbwEXYqMq0UAt1Ou2WJpQzW4tay
         OHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694985112; x=1695589912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSVdBe6r93QrgKS3he21TKM8q8THmRfH47H2f/qi7rs=;
        b=vSlmQKZHxfcmQVb/lUIF9sjeAPy/koP8y+4jhJ/XBLmMIU1QAsoxg37Mjz40qlpEyO
         z7nJlfWkybtaC1BOw4BOFQEOIFsCwB2z0xTmstmKvC0oIykH2AwOSdYg7/yUxHGIF9Wp
         94sXAnOJb7oo1Yf0skA0gzo0iwsLIiP9sb7y61b4s8ABwhqYDIzR5gdMhHD9+Cgi8ozV
         caTfS2cBoOg70kPxzS8qVhkrm/9m5cVfY1IBRGvfRIR9eNN4jkSEixvJsheahNpQYzaT
         S6/Xdi6+IfnLFYhiQHDUkaHLN+jJOcpv7QefEXv4QhXyqMBUQmyYh6AzEKhtOeYV2pxA
         U/UA==
X-Gm-Message-State: AOJu0Yw7HmURuXsiCgAuAm0CvdyAHDIt3qDXgMJwBNy6r8oyW4p9NN6C
        nCVTJ+RdFeARRNcknv5dyB4=
X-Google-Smtp-Source: AGHT+IFfXdA63AS5hj3ZeA4hzMNQEol5MtS2AWrSOj9ZFAxPe2EY2JKNOA+2CV7Gx30gOTsjRRvqCA==
X-Received: by 2002:a2e:9656:0:b0:2be:4d40:f833 with SMTP id z22-20020a2e9656000000b002be4d40f833mr6406063ljh.18.1694985112315;
        Sun, 17 Sep 2023 14:11:52 -0700 (PDT)
Received: from fr.lan ([46.31.31.48])
        by smtp.googlemail.com with ESMTPSA id p15-20020a2e740f000000b002bce3123639sm1766309ljc.98.2023.09.17.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 14:11:51 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 1/2] dt-bindings: adc: provide max34408/9 device tree binding document
Date:   Mon, 18 Sep 2023 00:11:42 +0300
Message-ID: <20230917211143.7094-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917211143.7094-1-fr0st61te@gmail.com>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c driver with Rsense option for current monitoring.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/iio/adc/maxim,max34408.yaml      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
new file mode 100644
index 000000000000..ae7c6ddb13d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Two- and four-channel current monitors with overcurrent control.
+
+maintainers:
+  - Ivan Mikhaylov <fr0st61te@gmail.com>
+
+description: |
+  The MAX34408/MAX34409 are two- and four-channel current monitors that are
+  configured and monitored with a standard I2C/SMBus serial interface. Each
+  unidirectional current sensor offers precision high-side operation with a
+  low full-scale sense voltage. The devices automatically sequence through
+  two or four channels and collect the current-sense samples and average them
+  to reduce the effect of impulse noise. The raw ADC samples are compared to
+  user-programmable digital thresholds to indicate overcurrent conditions.
+  Overcurrent conditions trigger a hardware output to provide an immediate
+  indication to shut down any necessary external circuitry.
+
+  Specifications about the devices can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max34408
+      - maxim,max34409
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  maxim,rsense-val-micro-ohms:
+    description:
+      Adjust the Rsense value to monitor higher or lower current levels.
+    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+    default: 1000
+
+required:
+  - compatible
+  - reg
+  - maxim,rsense-val-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1e {
+              compatible = "maxim,max34409";
+              reg = <0x1e>;
+              maxim,rsense-val-micro-ohms = <1000>;
+        };
+    };
-- 
2.42.0

