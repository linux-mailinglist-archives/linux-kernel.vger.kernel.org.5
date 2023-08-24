Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD1787626
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjHXQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjHXQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:08 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278A1989;
        Thu, 24 Aug 2023 09:56:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6490c2c4702so295436d6.2;
        Thu, 24 Aug 2023 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692896165; x=1693500965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et8TOSEmIO3QzLFT4lx8CWQnB3/Guzy4Ha+7G/MeCFo=;
        b=h2x+xj4RHYBRc7oohdX8bSH4BTS0wO5Rpejo8sneGdNcbouK4wmQAUei+ukrFMxn7u
         pabYGn9N312ec4H2VYUGOYt5higLPDW4aDmMzkvrqJwcl4gCFwU0ldoOmSPCzS3CU281
         wT/f61Fz8QX9KfFEWvJc77lWKrdTr0iGz46yubN6NkI1WFSFy3d7PqINw3Z79xPiC1Xj
         bZ/I5bbly7bZoDqNhTVLWevR+gvC0Ufp03SIDF3cFaTreFktP74eS902hJFdt5knYXqH
         kXlE2zr5g2lf82HKN7bqzy8sljNvvSMUHHLD7Aghs8i7cKKY17umDpHoHzrClhvUvzVJ
         erlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896165; x=1693500965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et8TOSEmIO3QzLFT4lx8CWQnB3/Guzy4Ha+7G/MeCFo=;
        b=CkTbZtXMgQlcRvw39odGYIX5lXTEhjUp1Nb0sjCs4Mjc4KEFej1XZCxYe2ZLmE8ezC
         u60cZiwJ+zieej/Zcbajz0HS4eOQnkx7meswhl3UQEOrXMyKATlXV5i0mAX3tTqjLncJ
         o+WBudXJRXw9aoT9t6lHQwRPnVcIzAe0S9eZxA/Jop4fpnByGpyP2FQLn+EDAcrj3+Dc
         zfTatIrth7q/fcWuRhD5FsW4yU7QVC/uww1PvoM4icdQDCgEDfQL1FlSTzEYTSB9Dr2O
         Yu7UQ1FLlFivkwqU1MF7kRcWMA3JNZkSvV/N+fHCb27m2FTXjyVTJVxvENEG6FvI2zU8
         J2JA==
X-Gm-Message-State: AOJu0YzOYxkLk3iuy1KffrTXZPnlpHdN62pTW4KswD58QB4mNASOtDh3
        o+DlG0rJUgAZm91gjMWFre0=
X-Google-Smtp-Source: AGHT+IHbz94cY/C4D0UI2JcUm+0qULBNvaLm8nB1MOZSvOAgnPWGsxM0DFPvnj5lHx656EplcqSeNg==
X-Received: by 2002:a0c:f8d1:0:b0:647:1993:92da with SMTP id h17-20020a0cf8d1000000b00647199392damr15247641qvo.48.1692896165369;
        Thu, 24 Aug 2023 09:56:05 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b0064f4f14aecesm2225654qvl.24.2023.08.24.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:56:05 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Thu, 24 Aug 2023 12:55:32 -0400
Subject: [PATCH 3/3] dt-bindings: iio: adc: add lltc,ltc2309 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
In-Reply-To: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692896161; l=1525;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=jOMSRnVhtOdMMA5BeZTnQMHkjBFOPEt0vDS9JW0uYNY=;
 b=OSWOmFl+2hTC9I9vmyLFmB/GFXXHjlxw5KavavRh1kY/wNY6e4W0P0liHSC9VDL32+PbWIAkB
 hqnqoBdv+zMAoNYCiPIO5qC+C8w4KtSekQZVcSf9uPB7hy13UmLK3uw
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

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 .../devicetree/bindings/iio/adc/lltc,ltc2309.yaml  | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
new file mode 100644
index 000000000000..7874290dad75
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2309.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology / Analog Devices LTC2309 ADC
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2309
+
+  refcomp-supply:
+    description: Power supply for the reference voltage
+
+  reg:
+    enum:
+      - 0x08
+      - 0x09
+      - 0x0a
+      - 0x0b
+      - 0x18
+      - 0x19
+      - 0x1a
+      - 0x1b
+      - 0x28
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@28 {
+            #io-channel-cells = <1>;
+            compatible = "lltc,ltc2309";
+            reg = <0x28>;
+        };
+    };

-- 
2.39.0

