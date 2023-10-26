Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA237D88CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbjJZTOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJZTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15691B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578b4981526so1067358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347634; x=1698952434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKO2g208XzCfOsORI6ZMG1mCYRoaMgItfO0wExwA+14=;
        b=FovDHLKFv9Gi3C2YjP7dXJfItRR3PH6JFC+StLbj0rZX2lSdGcAZNGY+ENj4h/CWWw
         FvkdXgqEcnMMZJuiA6fLYF1yt+xLnf5DP2JhvYbFJJQMu669YuZbT0rb1FwgNYGm5xaU
         T/vjsuw7Y0dq29pQY7yaXyNy8mFH/EOoOSsyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347634; x=1698952434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKO2g208XzCfOsORI6ZMG1mCYRoaMgItfO0wExwA+14=;
        b=ED+p0ccfldF2cIG/K0ZFkC2xsm0vsYNLohy5IRy9NSjv+ymiIGQkI8CU7uYukStNyB
         l1FgFmToKwd20hjlEFcVwa3BB016Ch959u3wpPfT99FtH365H4NoPkIcJ+SuruHXhebe
         FMFAYJ/MLhDh6tNZi5qyCZndkvimSv9vRZPEX4uoal576NXS4NHf34f1GQfJx9c0iGfv
         9GTTBEqz2MKd0d3kdzkVW5HH12xb2yx4cGE5dQ6ZNH7YI0EvE3FBJODEo6vNq6koYP4J
         ZZXpv0vNSx36CdVNN23zXvCOa80IMYUczFODY07ywwSXQIa8i7qj/+o9oIsMb3JPF8m2
         8axw==
X-Gm-Message-State: AOJu0Yz9ukpHh3XaglEv4buto+25K1Dw8q71u7DUj4fOY100vx+CSfNM
        6V0K5w2Qvv+SHY+9RAtiHhXTkg==
X-Google-Smtp-Source: AGHT+IEmsklJ5EWfVQVMeGYaB6B6U1UOfAuEgiqRe/EIB/KFs8EkGHLZUt6Yhm9lhheQgYiVB6Lw/Q==
X-Received: by 2002:a17:90b:f0a:b0:27d:37bb:12c0 with SMTP id br10-20020a17090b0f0a00b0027d37bb12c0mr449838pjb.36.1698347634291;
        Thu, 26 Oct 2023 12:13:54 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:54 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 6/7] dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-pico
Date:   Thu, 26 Oct 2023 12:09:15 -0700
Message-ID: <20231026191343.3345279-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231026191343.3345279-1-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pico (sku1) and pico6 (sku2).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index c937f49ba3b4..f133d9673803 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -258,6 +258,13 @@ properties:
               - google,makomo-sku1
           - const: google,makomo
           - const: mediatek,mt8183
+      - description: Google Pico (Acer Chromebook Spin 311)
+        items:
+          - enum:
+              - google,pico-sku1
+              - google,pico-sku2
+          - const: google,pico
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.42.0.820.g83a721a137-goog

