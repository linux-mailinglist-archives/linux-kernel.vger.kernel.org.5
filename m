Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7333F7C7A17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443083AbjJLXDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443069AbjJLXC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:02:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D424BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9e072472bso9347495ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151774; x=1697756574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yqkAgo/MWU32uTOpYWxBlk99kCXZj/R+2kdYHDmcPQ=;
        b=YLkb/zEIgErr7W5Ns7a5qrTYcRqXuZsUUm2dcznj61eRVviTk/IU+7RE2oDmhPxVLW
         kWnmUTed+tUy8a5+4pQnxc48/m2vMg/Irs/oC3SPcqeVZ1EhCxJjbezEouz2e9CzkuIt
         k1o0XMAr7ICA1hQSxYjx9qlyfgLSnfQ4h/Ngw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151774; x=1697756574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yqkAgo/MWU32uTOpYWxBlk99kCXZj/R+2kdYHDmcPQ=;
        b=Tj6GGH8ZBW8KDkolGbe9V8q6eOGMFd67oLDrurA23GdnpciuFptX8x2/VhiLKa+PJ3
         8r+ICVJk4y8aoe0QpZMtRVfHFZLh74o8b8Mydnf5EqJhgWbjHtITcmDj1Smndn4h6Msn
         lgqfP16VluqkKG/qJiwsMBbROYMyl8WCgWWlO7rfkTFOU+sjLUcBV8VKiAtgIDuri44n
         /fePP1yk9UHPgkgGGFBpxcV3sZaQkE+pV4jMRBP4ufUFdfTpnxvVYCrR3gNxc0hOLQpX
         npL0haVb6h5N3c2ZxNm2KW1gSEEAZBL+nE4LirOXn4/NX2tlnaX3HunwhiYF/2JtZr23
         0QaA==
X-Gm-Message-State: AOJu0YwKewjAWDn1HDxugFxWr1Gc7a6coliB5N/xAsTqxM75AD580XP3
        WJxvDouJ8KcsnjFOEI2OSCTaWA==
X-Google-Smtp-Source: AGHT+IG4Jz3St0JSY+Xv22Ld5Lp75IMTOmETltc03cF5+vYAt26xlXAJR4aUtfFXw/keyYea6CEZbQ==
X-Received: by 2002:a17:902:e803:b0:1c6:2acc:62ea with SMTP id u3-20020a170902e80300b001c62acc62eamr28185711plg.57.1697151773931;
        Thu, 12 Oct 2023 16:02:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:02:53 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool Chromebooks
Date:   Fri, 13 Oct 2023 07:02:28 +0800
Message-ID: <20231012230237.2676469-3-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012230237.2676469-1-wenst@chromium.org>
References: <20231012230237.2676469-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The two
are based on the same board design: the former is a convertible device
with a touchscreen, stylus, and some extra buttons; the latter is a
clamshell device and lacks these additional features.

The two devices both have two variants. The difference is a second
source touchpad controller that shares the same address as the original,
but is incompatible.

The extra SKU IDs for the Tentacruel devices map to different sensor
components attached to the Embedded Controller. These are not visible
to the main processor.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 60337b439744..aa7e6734b336 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,32 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
+        items:
+          - const: google,tentacruel-sku262144
+          - const: google,tentacruel-sku262145
+          - const: google,tentacruel-sku262146
+          - const: google,tentacruel-sku262147
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
+        items:
+          - const: google,tentacruel-sku262148
+          - const: google,tentacruel-sku262149
+          - const: google,tentacruel-sku262150
+          - const: google,tentacruel-sku262151
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
+        items:
+          - const: google,tentacruel-sku327681
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
+        items:
+          - const: google,tentacruel-sku327683
+          - const: google,tentacruel
+          - const: mediatek,mt8186
       - items:
           - enum:
               - mediatek,mt8186-evb
-- 
2.42.0.655.g421f12c284-goog

