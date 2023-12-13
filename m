Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5F8115AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442122AbjLMPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442164AbjLMPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:04:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947910A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d351848c9fso1843715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702479898; x=1703084698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHQKk4d8ddwdrjZBqESFWwMSVagHkFt89kWPhTD7Nn4=;
        b=lfHAQJaBkFEDbtJbPqboW/6IahVxZUEYIk6XZxBrIt+B2S5Q8yoA2ZVFI6u3/DFWdU
         ivlRWeNnwgOamFc/YePaXLga9BO3zsM49EDMsbgwUG3jjnYQMXdhWGHoQGuJw3Pjhc35
         yoiHIk86NOQQ8Ddz4vs41t249bMreUtu0aE34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479898; x=1703084698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHQKk4d8ddwdrjZBqESFWwMSVagHkFt89kWPhTD7Nn4=;
        b=cBJjzBR0CZy+onl4wcCi64NFU2CxOLCD0zd0JCrFuZh9RyfQ7NRfV7lNW9DFjxKeem
         a7sy5oGcp9THyu7zmNgh1ilKJo7az3rafCsu00RgB18f+AvwE3ZWkNhHAB82/FSZe/4B
         uh+0FAoxMHyWX5DXJ6rUFnwWhvesG5/MiTzQI3aSGyptxt8VgLcY6tjVmkftJJSUwyMT
         /nQrd+wZnU/dteZtMpJJz33JHJSOwLGm4HhbStKuRlZsn+apLQNgsfh7Y8PHcKpwAhmP
         c0DzES/ig50mpJMf1cy2ixpRVuguiZCuezm5+us/pXQQUy/ceee8N0taQiDGoaW8h2ei
         vi5g==
X-Gm-Message-State: AOJu0Yz3lfbLzsq+iV1RyLSj0M3sl8OQXGIJ22kzAg/k6m1Jem9NpO8w
        gQw7JK0+5zc/LHfMKJ2JHevmHj4Vqc/6rnNoMdLiLQ==
X-Google-Smtp-Source: AGHT+IGkHAOSAbKahJZ+Rvzu3EviFtnKBG06cWxjCCSZxriqnyEZUPbnctUK9bg7P+z3snWvZmTsTA==
X-Received: by 2002:a17:902:bf06:b0:1d0:a663:20f5 with SMTP id bi6-20020a170902bf0600b001d0a66320f5mr2807931plb.67.1702479897768;
        Wed, 13 Dec 2023 07:04:57 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1974:9e2:4915:58b0])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001cc2dc61c99sm813808pla.22.2023.12.13.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:04:56 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
Date:   Wed, 13 Dec 2023 23:04:28 +0800
Message-ID: <20231213150435.4134390-5-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213150435.4134390-1-wenst@chromium.org>
References: <20231213150435.4134390-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the MT8186 based Rusty Chromebook, also known as the
Lenovo 100e Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v3:
- Collected reviewed-by from Angelo

Changes since v2:
- Picked up Conor's ack

Changes since v1:
- Reorder SKU numbers in descending order.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 95d2b430ab17..85d394e390f0 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,12 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
+        items:
+          - const: google,steelix-sku196609
+          - const: google,steelix-sku196608
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
         items:
           - enum:
-- 
2.43.0.472.g3155946c3a-goog

