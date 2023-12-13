Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CA8115AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442234AbjLMPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442209AbjLMPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:04:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AF93
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d04dba2781so41727425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702479900; x=1703084700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvrIa3O45gpt2G985gqVa8hOF+a0Vp/PW1UMbJtMjpQ=;
        b=QQdbl9veXqAXF9n9Tk6P8HQ2iAltBzK+tVCmutHvqzV33X2/wnwQMnij4YZplwd3On
         ztVOJaHlqHyt3awhF87g26JvBtrkp6qoIdm6zeYxQAsm4/ZS6hanxyjWl1DvT3hQsLSc
         avNdSTy/IpThRDjt8twTJ85Vx+d7kLuf6wG0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479900; x=1703084700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvrIa3O45gpt2G985gqVa8hOF+a0Vp/PW1UMbJtMjpQ=;
        b=HyIRgz5CckVfPSmB3uEdNVY4KE4Nq7zOA0ClRXAAtrbyvStNbD/dZMMmdb7BBFUdwy
         K97HT/+Y9Fz3N1c8In+KPPISudxRBFIFQF7nif4L3QS6wgu5nwaVtg5TYlfaM42cW7rf
         V8NTVxzjLX83PqxRWHniv/Yh4j+zTmmmkfP6zL3dYde3l7Tin4qIatK4R8Nd/RI3tI4/
         VSiAdKKKnzG0XkYpvXhBHzFKhJsaDEF65sUuoSgt02jPOLElnZz1C3QsFyaGUW777VvP
         skuCee7hDaJMl3AzaDWn69D0zPN53OieEvDHAsR4fkRN4OuJi1g1Jig77Io8ro8z7B8O
         HjKQ==
X-Gm-Message-State: AOJu0Yzc9kbYGhYVtmz5QBMZHSrFpzZ6pgDfsNsVpKOqZ+fm2BI/qjk6
        vmKW0VL/pYAhCXsZQ9iJeqOK9A==
X-Google-Smtp-Source: AGHT+IF2oSj+ur61bjoC52Jha6uiwR39mZ8qZHcGzePU+fWCARUA9rccPDp45Z8i0yEhjvLM/0TPyw==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:1e6a with SMTP id cp9-20020a170902e78900b001d06ffe1e6amr4428827plb.77.1702479900300;
        Wed, 13 Dec 2023 07:05:00 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1974:9e2:4915:58b0])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001cc2dc61c99sm813808pla.22.2023.12.13.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:04:59 -0800 (PST)
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
Subject: [PATCH v4 5/9] dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
Date:   Wed, 13 Dec 2023 23:04:29 +0800
Message-ID: <20231213150435.4134390-6-wenst@chromium.org>
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

Add entries for the MT8186 based Chromebooks, also collectively known
as the Lenovo IdeaPad Slim 3 Chromebook (14M868). It is also based on
the "Steelix" design. Being a laptop instead of a convertible device,
there is no touchscreen or stylus, which is similar to Rusty. However
Magneton does not have ports on the right side of the device.

Three variants are listed separately. These use different touchscreen
controllers, or lack a touchscreen altogether.

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
 .../devicetree/bindings/arm/mediatek.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 85d394e390f0..155ba22e2ad3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,24 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393219
+          - const: google,steelix-sku393216
+          - const: google,steelix
+          - const: mediatek,mt8186
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393220
+          - const: google,steelix-sku393217
+          - const: google,steelix
+          - const: mediatek,mt8186
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393221
+          - const: google,steelix-sku393218
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196609
-- 
2.43.0.472.g3155946c3a-goog

