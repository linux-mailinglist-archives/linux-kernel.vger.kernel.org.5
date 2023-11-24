Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931177F6E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjKXIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjKXIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:41:29 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC710C2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b2c9ee8ecso11256765e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700815289; x=1701420089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vhZkFxLvuCZe0A7RVw31v//xJIvUsZb7i8/r2Jbnxg=;
        b=AiSQcTYm8Hf2x6ScrnupnT9mPgbJwDvfdtEIYeUn+4as9uLj67VN8LWzQktd5xDEWE
         RgBAIBZAcRMNYv6ve8KtxzH9xi5NuXbEPhHiHcf9ifn/cUWjgigFdAPSj0QzmHoE68QO
         bqHQhqhMnSW5SE7Y348INVYYP8hQTy4iTKoIPc8pxlJQilAhMyxqjQp7DlOoj+7u6Q9u
         fHUTs0W6qJlBpPMrfMunCyeM1Z3s8wBh/Gc1N7cogvRqqU7Z8GP9JdRWf43al9m3NUeW
         dqyZ8OZFsCXWAMah3j+Rl7K5bOIU7vVkBx1mR4k1RXqInCHsq16q5UJe/CPqdYBdEMW7
         WHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815289; x=1701420089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vhZkFxLvuCZe0A7RVw31v//xJIvUsZb7i8/r2Jbnxg=;
        b=hYSiX07JoVt2mCMmSRLY7u+ZCSSly61ofvO9y5IGUlWdlw6i+GK6g4u4y4VGIecZGO
         1pUmOc1RzdRFLIJBGQiDTqQUJw6/ST5sQaJ+v+x+cKLep8X++Kwl9XvJXmi0lDid10zf
         /sQCdq6GE1P9ma5qUPySZYSYBsixxPg3vG/zf/+jrszwC1uYm/5lf8Z4tRWfUDQBZ356
         dBNhWFH/G1Bu12pTPGvay61tGjRQYmKr0xOikxh67oanZbEz1mpMd98bEAYV7lNI0fru
         VngFtoDyTLzOYhbLJwv9GxO/Xv0U3OrDdNVl5MQiK7wsZC7kJPQmCJiJPR09OHU0fprf
         C/wQ==
X-Gm-Message-State: AOJu0YymklVswe4/0fsf4ijc/rcpcmFli61G/kRnml35N0UidDmXp47V
        0q6w8QSHTh9klDVtdXAUADgDtQ==
X-Google-Smtp-Source: AGHT+IGommKInNd3FR31Z3mvyaSG7pswa9iifJaF+pYGzjLLSWEIzKdNop4bPbWiyyiCahf+KYNE1A==
X-Received: by 2002:a05:6000:253:b0:332:d84e:7fc5 with SMTP id m19-20020a056000025300b00332d84e7fc5mr1129911wrz.53.1700815289535;
        Fri, 24 Nov 2023 00:41:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm2534562wru.67.2023.11.24.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 00:41:29 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Nov 2023 09:41:15 +0100
Subject: [PATCH v9 04/12] dt-bindings: phy: amlogic,g12a-mipi-dphy-analog:
 drop unneeded reg property and example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-4-95256ed139e6@linaro.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oOPbXDBk3aIjcohZAd4QtWQn75Ng6fL6sZ33nsFIHDg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlYGGvi+SK2D6szCKmhAOwxD/2QkmEkYDKCfLNt3LA
 z+A/wj2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWBhrwAKCRB33NvayMhJ0ePwEA
 CZkwqf2CNqmVAwhMX0mZ6T3o+S0SegeVMlwXXCEGDJEr4YPs+En7dabAcfzM+Cz06Vx9Zc/iok3MkR
 3l/Etm2uXi7mRQMPmkwioAgKInUhxH3cZikmdPzcDPpmofgII8wuYs7a6cYf5yTXw6pjEApR0HtiUK
 YdDcEJUhCQVntgWFS7k4cYOHvojsRtTeBtAkFN5Juedqh+/k0QT00muBYoiaDzpv0I9zKIFwAkQBaw
 +vjAo6H7OB7DxHTFN/rzL07P6VP0hKpn0A4wBml3xMm8pyzBrLTIeZrC/XNzMPnZMuEXc4xcLqcD0+
 yYfCnlrWlC5RdOY9r3O739eRSaT1sFV+CdPSYlZfmNytYz3scHVC7lvOFy2amjLYR8cIj44XpVl/gq
 nvCrQ0L+Np3xv3IAVNB+rgNWwA0Y6X+AdDc9WeR/N+tkIgVkRdOJbKwa+Tz5TQnyIlIn7H9+9kcxjr
 x9kHQzecSDOjxwkeDxnQoFYjq2zLIAtazMFXw18qKpIHytQKCVIwesOCK0vmh8UhcLPht/tvo5jygg
 6GmyPFvso6780JXtf4XZgJtV4iJD0kRG9ADaiFmlhjAj2c8tE9QBNiE5JBHZ9HwatytJficQUuOMYC
 fJV2oR4Qa4KbVzoK8OChR68Wmrx5JW1EE0Ye5nsmZzGraDCeBQaMd1wYGBkA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amlogic,g12a-mipi-dphy-analog is a feature of the simple-mfd
amlogic,meson-axg-hhi-sysctrl system control register zone which is an
intermixed registers zone, thus it's very hard to define clear ranges for
each SoC controlled features even if possible.

The amlogic,g12a-mipi-dphy-analog was wrongly documented as an independent
register range, which is not the reality, thus fix the bindings by dropping
the reg property now it's referred from amlogic,meson-gx-hhi-sysctrl.yaml
and documented as a subnode of amlogic,meson-axg-hhi-sysctrl.

Also drop the unnecessary example, the top level bindings example should
be enough.

Fixes: 76ab79f9726c ("dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml          | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
index c8c83acfb871..81c2654b7e57 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -16,20 +16,8 @@ properties:
   "#phy-cells":
     const: 0
 
-  reg:
-    maxItems: 1
-
 required:
   - compatible
-  - reg
   - "#phy-cells"
 
 additionalProperties: false
-
-examples:
-  - |
-    phy@0 {
-          compatible = "amlogic,g12a-mipi-dphy-analog";
-          reg = <0x0 0xc>;
-          #phy-cells = <0>;
-    };

-- 
2.34.1

