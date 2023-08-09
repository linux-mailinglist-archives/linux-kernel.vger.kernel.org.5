Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206777681B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjHITMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjHITLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC82683;
        Wed,  9 Aug 2023 12:11:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3110ab7110aso167684f8f.3;
        Wed, 09 Aug 2023 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608310; x=1692213110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHOxYEOCiaK7yG+Kbl87/DBR8ScHUJdXSuGCuLAA+rY=;
        b=QlsqP/VoV81B2dlMesBtI3mtix4KC3W2Qi+yda7E+MGj6TQgQhG0ANxw2CRtgOObYs
         eloWWS5x3MFaF+jGHl2ZQLoM30nSn3A56MjvSotZQ1ho/cSPKxSMAbBwhmOdZsKHJcXr
         0AZuFcA+SWbf/oqFtNqvpfeXJF1s26z59L+n2AyZzmRFTFOMOf9286DKT861Fl8oam+0
         lwtSq1k7TeLDHhobEW0Ne1pZEKws4uUyCEB4pln8of74IebkVuS0UbeFkJ1fsnanklzf
         /lWRhj0hht26KpJF8blUgzkqIMReV9TkdANFO7R2Zj1pidqKH6wVeNgcKTowyL1RJWz/
         4+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608310; x=1692213110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHOxYEOCiaK7yG+Kbl87/DBR8ScHUJdXSuGCuLAA+rY=;
        b=DE6uBgMO90FgcFiVIM2xQmiQLuK/kA8n4YT45ZUTzB/eXr8rj9Vfg3M/B1JO2H8poM
         nwN5OoSigvWtfxd9ClJZRNISj3A71+S7xgP+rn9NUeivs5crPXQptpOfAtT1Mb4J3/5V
         UrAwc34jI2Sx2uY/AUUlJBTZPy0FU/z5OZULetq61kqjMNGxgb7QWbx/+e+lsu8qOeap
         BGGZWgpg4gwX+6hh7OpjlDoF2nU0HhnaswNSwMGBH9VBogltajXmNNVFRvcEEbrtT7pi
         68ulb3pcl7r2UyXvrIFIcL25gXZs80ezixQtNSZapqM7xBtliH+B3e4DuRxvnqpFN5b/
         7teg==
X-Gm-Message-State: AOJu0YwmtDOX2gfo60hjrBFjm7AddhqGJxMqdizOlhdBsw1/Z5H4hfQO
        ZEn4k7O4Mwgt412PYFFen5ZajZncl5Y6cA==
X-Google-Smtp-Source: AGHT+IG91wm299iR1sqtSe1GbTGx5hhuFuevgx+e6fLmp7YDHT/RDVM6xKsgaoqP+mHl4DTIuO1XRA==
X-Received: by 2002:a5d:6091:0:b0:317:6704:72c with SMTP id w17-20020a5d6091000000b003176704072cmr211016wrt.52.1691608310304;
        Wed, 09 Aug 2023 12:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:49 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Wed,  9 Aug 2023 21:11:32 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
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

Extend the kionix,kx022a.yaml file to support the kx132-1211 device

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
v6:
v5:
v4:
v3:
- no changes 

v2:
- made the device name more specific from "kx132" to "kx132-1211"
- removed the output data-rates mentioned and replaced them with "variable 
output data-rates"

 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..034b69614416 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, variable output data-rates and a hardware-fifo buffering.
+  KX022A and KX132-1211 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132-1211
 
   reg:
     maxItems: 1
-- 
2.30.2

