Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF2777067
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjHJGdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjHJGdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:33:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F4C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:33:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so4682745e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691649191; x=1692253991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYTzTb8UrxRc66FImFP9rRfhwslszsfgsuSxr/7YLlU=;
        b=XVBoF8/yUIY8PYBHbJ0Z7j3ZbEFoK9XkPKGih+mU3xS6CHBVaV+E0rs9k7VHhJNUqY
         woMLWZioH8QrrAqWcuFhR9m5Vu0Iq8ia7WIu7aVeqrcjYHU2WD48Hz4jAjqaHVTBvejV
         gpaUjTWl2Fnuyq4TyzmmTDFvks/qHg6YwnFTwFmuQLKbLhwrkf5EUQ9F5chIaUg5yj4G
         LdyaY3nW5radp2afOmQ388Arp2Km9PsKOFERYVJcnhs6gccUF7rMee8rqyenPJ4yiOnU
         3MWV60QVUcPvc4ieNtbGjzC8Ga6jPurlMbqxkTSkixHbUqV75zBWK+bc7IN4+fcp4Q72
         S1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649191; x=1692253991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYTzTb8UrxRc66FImFP9rRfhwslszsfgsuSxr/7YLlU=;
        b=Az6yXXSdRN9lwxhYqHDMxzcB2b3lEUofmyNYEdcC4x1SZdF1pbmABitjhE76WHO9wB
         fR8MgstM/JPfUvSuiBUR/j0Yi6zWlE1CeaiQ60UssZ09JRcJhnummtvqWlH1SVuYUl1t
         URbpFdXGOQm9U324Kv3vBcDqn2+qajKyifJvtWVn+PGiMeuoMAHbPWB0z9GWfoj51BV2
         pLm4vSyMlkAx9KJw91/yadW6IwVIQPH956FMqbydseLb6YNOk7DLjhh2fFWMZbx9FEHU
         VD1fqAVlTNzgpmZ02WnG1jifyQ/Jh3INT4M1lkfL3+kZUfd1sgclNhzkJ3GHa5R6G+p0
         lsqg==
X-Gm-Message-State: AOJu0Yzs85rtkqYZqgNHTsqSeSax3IUw1fXWjjEOnRpBQcxnTfMdwyen
        KJDNKCTsN8qiu4eFjSnKStBMTQ==
X-Google-Smtp-Source: AGHT+IEqJ1GJ3dbmjoju3DRXle+Ph5P/SXAKqQihojhMe01unHEJ1z2+BYJ7yRiSfY0mY+2UQE9aOA==
X-Received: by 2002:a05:600c:213:b0:3fa:934c:8356 with SMTP id 19-20020a05600c021300b003fa934c8356mr1122754wmi.10.1691649191009;
        Wed, 09 Aug 2023 23:33:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4020018wmc.21.2023.08.09.23.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:33:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 04/11] ASoC: dt-bindings: samsung,midas-audio: use common sound card
Date:   Thu, 10 Aug 2023 08:32:52 +0200
Message-Id: <20230810063300.20151-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
References: <20230810063300.20151-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference the common sound card properties and deprecate the
custom "samsung,audio-routing" in favor of generic one.  This allows to
remove "model" property and make the binding closer to other sounds
cards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/samsung,midas-audio.yaml      | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
index 31095913e330..6ec80f529d84 100644
--- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
@@ -9,14 +9,13 @@ title: Samsung Midas audio complex with WM1811 codec
 maintainers:
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
+allOf:
+  - $ref: sound-card-common.yaml#
+
 properties:
   compatible:
     const: samsung,midas-audio
 
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: The user-visible name of this sound complex.
-
   cpu:
     type: object
     additionalProperties: false
@@ -38,6 +37,7 @@ properties:
       - sound-dai
 
   samsung,audio-routing:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     description: |
       List of the connections between audio components; each entry is
@@ -45,6 +45,7 @@ properties:
       being the connection's source; valid names for sources and sinks are
       the WM1811's pins (as documented in its binding), and the jacks
       on the board: HP, SPK, Main Mic, Sub Mic, Headset Mic.
+      Deprecated, use audio-routing.
 
   mic-bias-supply:
     description: Supply for the micbias on the Main microphone
@@ -62,14 +63,13 @@ properties:
 
 required:
   - compatible
-  - model
   - cpu
   - codec
-  - samsung,audio-routing
+  - audio-routing
   - mic-bias-supply
   - submic-bias-supply
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -84,7 +84,7 @@ examples:
         mic-bias-supply = <&mic_bias_reg>;
         submic-bias-supply = <&submic_bias_reg>;
 
-        samsung,audio-routing =
+        audio-routing =
                 "HP", "HPOUT1L",
                 "HP", "HPOUT1R",
 
-- 
2.34.1

