Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F2788E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHYSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHYSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:21:13 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854A1FC7;
        Fri, 25 Aug 2023 11:21:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4108a8f0de7so6530081cf.0;
        Fri, 25 Aug 2023 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692987668; x=1693592468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWzPeQsJy0n/ivfFwupuyfKQNHfuR+Cb9iKlBKca8PA=;
        b=jWLPvP25+Z/xB+oCX/TmuJTpUiVhT5zNoK8WvAuOk/uwo8HfXJigrgvc2eB7pzABmJ
         jaJiktOp9KmbIijWqNrTJ6zHDxf9s8rmeMC2/ta4OqAhdCuUzvLzjrvvRDI/53CdW0T7
         O6DZ87So8P0rk7WYXbUQ4V0LaH3wlBpMmIkz5d4We9SVlT9d7Vm2Rj2ifB+XEZOicJgu
         7FIoxZqDitAS87L9Zl0s+NF1kxjYDl0P5gHjPcGlSXLOn/qAPHbjI5Y4DbXaXSfm3pHn
         9EiVgA9SZVs84z6Q0mIyOacCB4p/TVGfBeXvfBPwcMfBNd5eAbKFW3Wm2G+An6Uc4o3I
         RZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987668; x=1693592468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWzPeQsJy0n/ivfFwupuyfKQNHfuR+Cb9iKlBKca8PA=;
        b=Xa3RMXMw30zgNy39MmmYbrWgPnTS2D0L2N5F2zlAWikAW5XQFHgU3WOYJ2Ethx9XQn
         UvB/K+lEyenH2K49/Eh9jKbmOHR2Rc+ALWaDhM9r6gZRuuaXyD8jSsFEp34U9EXTbwOt
         RqjQ25zHq5kNf8rW4bKq3fSZKTXYYZuzEghMq3MIFujgHXwbut4IFciW1eFjhcCKrvMe
         FGEKBmYTf2sElGlmMQluUojvCp5d6BRrpFmbMY70iWTkji6SXGNiahsPOHfqYfy0gCLj
         0/d4k1HmJpxC4QL/qMllQc/6DG/5Iq/zc6Hu1o0m8f6Nhxm5FgTHjODmQcuoDu4IS5py
         VRbg==
X-Gm-Message-State: AOJu0YwV06unyOtLFf4bMrPKFWDODiu5DKPTPDo1fKvBj0FhF32eY+X5
        I57i6vv6cBejG7tIqFGSnTc=
X-Google-Smtp-Source: AGHT+IHFA/2NO5X041jdrIP6DENtDmwMNAzs3fDTwLv252e9ARpSGk1a0biwGlOlpPiOEeI8c8NeGw==
X-Received: by 2002:ac8:58cf:0:b0:401:e2b1:d28d with SMTP id u15-20020ac858cf000000b00401e2b1d28dmr23692523qta.20.1692987668453;
        Fri, 25 Aug 2023 11:21:08 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id ew9-20020a05622a514900b004109928c607sm679747qtb.43.2023.08.25.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:21:08 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Fri, 25 Aug 2023 14:20:58 -0400
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add lltc,ltc2309 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-ltc2309-v2-1-6d75f2b3fb50@gmail.com>
References: <20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com>
In-Reply-To: <20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692987666; l=1886;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=Wta7B4HVyCzdYrovvnf1JwrpyCACNS7nZIhtpsndyhY=;
 b=/usnhzy1ITfT7LYjJ54QJTMskIORaGtsMWn4PNYq+ZdoHLzoR3s6UE3jkC/qanidP/bJYwMmv
 LWwVL5lv/VGD+MZ825BBjvrIlwQ0q/9KakYepggaNrex4HB3yGM7k4Q
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

