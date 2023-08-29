Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690878BCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjH2CnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjH2Cmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:42:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F8CC8;
        Mon, 28 Aug 2023 19:42:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-64b3ae681d1so20102356d6.0;
        Mon, 28 Aug 2023 19:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276929; x=1693881729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBgJZNfd0GMGgGpa0LFxtTLd57gxCX+RiU+/fHkUTC8=;
        b=snMCn4bQilAfPanzqmDnWMhlR7ypHcDTA2SbitRasdH8KP5jdhEVwX3QJTWXBxSNLP
         HZCaStJc3rBvgzty+cjdqMKs1sTiclFEvE6rJQylRCZODvFozakH/DyRKUFjl1TO2lG8
         Rc+9aUkb4qIXsWAdHYQ2o/J5c4ZZW2tKQ6YH4XdPOY/ygG12h2i59oO+/Thzsfk6KoxG
         RmruvDAxcrCsI3k2QOtNn+8jNXwB/Ak5GARVOEv8c5KiMF9lS2JDwlOKdKGmxgJkibPl
         Fw4B0GPezqM9b7ZlRnRn6kFjtVrxKSejj2GrSZfqrrh6Hsmt0OwKqRvGYKipjJGebzB1
         Jxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276929; x=1693881729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBgJZNfd0GMGgGpa0LFxtTLd57gxCX+RiU+/fHkUTC8=;
        b=GJoufF5xobp/UMOns/4zX3W40/66FqBCxTPE/UUUd8QaqI8S6wmHIaY8pFkJkZP1d/
         ebdSUaY/DeLztTQRSBVLTgy5AbKn1r6d7tun3x5SW3Na84AG6WRyCyIyOz8tWqIZyVjI
         fFxDfh4ugS65g0mbBhfalm8sZ1HAow3ivT9DtDQoC0Uhgewr4Exx6I3DvaTuZ01NBxuy
         5Sb+njmu4fvdw5ZcnXz16nYxfrZ1zv5RiP8tq6rKJKGrzjyd1tnqwcCX0IlL1xd/E5iP
         XJ02WnIh2jnDteJJ5eNfEMCRveJBaByOYOm7Sb1tS6r0Ujk8/s0TFdRzDAuSyYoAhfoP
         18KA==
X-Gm-Message-State: AOJu0Yxk+wz5wBxHjef5HrWGSm8857uYOLb+/gaH+H+Vj5EEeuMRfvbS
        DUOjxOBqJQ7YIGXlap8PErU=
X-Google-Smtp-Source: AGHT+IE4sMgfk06TLc3obJSRo2qazkZzsDfUz06lzWj3f2m+/USRTjHNl8N0AIgL7Egp7WBcwPh1zA==
X-Received: by 2002:a0c:bf10:0:b0:64f:40a2:59fd with SMTP id m16-20020a0cbf10000000b0064f40a259fdmr19509075qvi.60.1693276928759;
        Mon, 28 Aug 2023 19:42:08 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce509000000b0063cf4d0d558sm3010037qvm.25.2023.08.28.19.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:42:08 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Mon, 28 Aug 2023 22:41:34 -0400
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add lltc,ltc2309 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-ltc2309-v3-1-338b3a8fab8b@gmail.com>
References: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
In-Reply-To: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693276926; l=1953;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=o34kax2/rwy/5ykqlZdmINuVGDXAjzlvPtXXefQw90c=;
 b=Djbrk9t6ihbYP1d0rgdKTfofcVsDBTHeEm6Rl2Vm87Pxbi5Xx5yP6W/s1baBvFrpL2VohBrgA
 JbEUVU/Z29jAC5obv1JGr2DmViWDeNDm5zDTeliyX1iqSvxBadzBRlK
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the Linear Technology LTC2309 ADC driver.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml    | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 875f394576c2..5cc6a9684077 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,21 +4,31 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 ADC
+title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
+  - Liam Beguin <liambeguin@gmail.com>
 
 description: |
-  16bit ADC supporting up to 16 single ended or 8 differential inputs.
-  I2C interface.
+  LTC2309:
+    low noise, low power, 8-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
 
-  https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
-  https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
+
+  LTC2497:
+  LTC2499:
+    16bit ADC supporting up to 16 single ended or 8 differential inputs.
+    I2C interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
 
 properties:
   compatible:
     enum:
+      - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499
 

-- 
2.39.0

