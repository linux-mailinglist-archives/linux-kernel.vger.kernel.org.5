Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749E7F6E91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjKXIll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjKXIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:41:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6110D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5094cb3a036so2170780e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700815291; x=1701420091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=FtwETeUXOrVFirW9bCw1CRmYiTQX1v3Ojm4sXm94hT2cOGhOY+8Q8ogPBp896bwbh0
         r2lOHm0WxIHPR0GNHjSg3chitfyQbzdofBhVGrU0eNFaEzwQYqYZ3gVtjh3lC7iAOqLm
         W1qTCFqMN4+IQ+XC9eAZA2fpgPdiyOt98fj2bCBwfvl9fKEvRD7RuZW3ePcjUwF9CHtn
         sIaFFov8JAUvvID8mGjHS0vQWzBXKpYQCraDnaXgQZZBlTYNsugxrW65Nb5W/uHXcSWB
         Mbjcm87jwsH373EH8fu/Klw+A2rDgmSOsGLl60V/zGfj7tNfqK60pGxdWD+ohhRMGj7Q
         Ki4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815291; x=1701420091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szbyE8B5HmerWTS9QCGM8GNA9TtBAZ10zn0t2kxJOBs=;
        b=TvAPWK9EMZ6/jsoQKtVGI4MrlM1x0+f6MzGUrc5B/Wna8J32dUgJ6WwptFNAAl1D56
         /pjHbOAKhC34Zr1otPbOkyjbn/jwhrD/5OfzX6TcpoDDvsPfXoj7l8vj7pAVwu6zGuKW
         /UJFYVugHov+MuvkLsBO5Th2N4kWEy7r4yr09hlKQDakpPRdNpki8/4TXaklszmlKKzi
         jKrhIZ4E5XXChgbz1i75xgaq3tyC2Pk7Umzsu8JS/LNRxoWxB/ZisJTAuMOOjp8U1TS0
         qhtx6tYZXlJxg7Lco/YBupyzQ4LqYD5nVJXEbVvy63xlm2PdZuRcUAF0KHUnnTCy7wYs
         rskg==
X-Gm-Message-State: AOJu0YwAEql9OwPyAcI6SNwG8EA0uKdEMUB9hfkdtndlPXLqDcC2kSct
        ZCC1yH16trxugURBqG2cKNC3ag==
X-Google-Smtp-Source: AGHT+IF8wC4ZbNV+iRqsapT1X1L6KArgTHWCtJUniE+JBLrichukip7x/MNUSFgjU69zSXGhwIYP9Q==
X-Received: by 2002:a05:6512:2026:b0:509:4916:8b6f with SMTP id s6-20020a056512202600b0050949168b6fmr1088541lfs.37.1700815290893;
        Fri, 24 Nov 2023 00:41:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm2534562wru.67.2023.11.24.00.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 00:41:30 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Nov 2023 09:41:16 +0100
Subject: [PATCH v9 05/12] dt-bindings: arm: amlogic: Document the MNT
 Reform 2 CM4 adapter with a BPI-CM4 Module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-5-95256ed139e6@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dsHeljQP++qeke1zASpQ3YPnuH6eGTAu4r6z8mvmrbM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlYGGv3r2urKVQCnv1GMSXAcUHF2wbzkyg1d49b8yI
 ncf0ylyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWBhrwAKCRB33NvayMhJ0VlcD/
 4y1L+GLLwogkpqrR1xVtyGU3WNktnmQpmbhriYFVjc8mfDK6pfyBAzykOOFUyjcoCgKWxV1oJTuxod
 n2fNJepwZ3udvXq/phRAoM+JgB5VwPl02d66w6yh2mRT0xsuthdMpZ6GVLhbcP++Rm6wgxEcX9p/cl
 HRUp2NPx6OZGj49CiOwd4JQIe2nejmgGDUlTtfXBx0UrpPjamVyrNvMBGIIdLVH9mDQNONWT1rQM/L
 kSTuU57hLl926SrMVJ4DP3qFu/14HhsgOLiIPMgZjSVyiPWu3h2FGpFHOsXi8u4wUdJO1o/HOUy40V
 Mic7Q/lZFY39/kVxbZ4ICyg8QT9p5CzDwYXuLTYST5SCoBr7yLEBEraTke0toEJOpzx3meHPsl3ghp
 9BOlz3g/+AVzEyoz3yjDqnifU8Z4ZCG/pVJ3VAH88P7pXL8LkGyqfrzZSnWg9tiDwRC9P34pFG0CPs
 vZQ+OaIsqPpSEN6et5R/tN/luhPgfUia87H5KA3QYFyemEKu037HhZcdomNkQnxU+uBNy377thMRdD
 BxLMWftl1gzwElohUV/HuoVhcZbLRQy3xkepA0QjbquW5+cKI4Jog/261FPx6rw2ZHOLpxSyh2BoTG
 AEQOfpbdxt+xlZIRW3QRefScRXlSnVfYvXehYP9LUfxILN5HJYzvwxQy0xeA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MNT Reform 2 CM4 adapter can be populated with any Raspberry Pi CM4
compatible module such as a BPI-CM4 Module, document that.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index caab7ceeda45..2154a4614fda 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
         items:
           - enum:
               - bananapi,bpi-cm4io
+              - mntre,reform2-cm4
           - const: bananapi,bpi-cm4
           - const: amlogic,a311d
           - const: amlogic,g12b

-- 
2.34.1

