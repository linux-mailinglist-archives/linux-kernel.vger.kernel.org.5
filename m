Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455E800464
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbjLAHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377709AbjLAHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:07:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF0173C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cff3a03dfaso1985925ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701414467; x=1702019267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vppgLjSmhUrkns2eunD5T4MJYG5kmc4rlOiXGna8MDA=;
        b=HMg+dYYO3FdC438NODfaIzQtCwdsIkt+s8AqRYxRp/7+k5CvJcs/o69RDJxsxaikRR
         SDuus+OKM+LddH23whijhZDD/wXGqW4Tw15/Ff2/f36EhCqVt2iCYhz3gJYBGs/iuXAi
         2asAvrptyuAtNu3l1aiNpeOpww1Xm5MBBr0lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414467; x=1702019267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vppgLjSmhUrkns2eunD5T4MJYG5kmc4rlOiXGna8MDA=;
        b=CoqkVVPsMDwFW/QzKOcyh21SbUbMgE2o0U0amTELnoFHqWw2l4lY6ukAPiJLT42GiT
         VjQVi/0NY4lgIlMXxjHfc3hKnaLAKLQsAhU4tqAmM2GEVVlqnddxpEKEcZu4YkJXtQjI
         eJYlRKsPodtCZ6A2bwMLJwkQMle7iFUnrVfW7mVhyQ2VQZascQyjZyqbgj3Iq/yNO5mV
         z/H/Hogn88lfp3VAzsHVWh3H85qu9A7DqlYeNMpao8RTAKbBPT+T7RCXf18WtNgPT3LI
         eYTgS69Tq5P1Dnd6iI+8xKtudgY0rqTdflqbzCsbpc9gPNa1OTFkuRNhenO9uMr6PSY7
         JnGg==
X-Gm-Message-State: AOJu0YyWxe7Oml+Yd1uCOzcmc7GHYuKhkAWrEzVPFfx32c548iBYYcfS
        fvqSexbfCErDOiMeu/msLdkQmQ==
X-Google-Smtp-Source: AGHT+IGTphmUhRjkz/SwX75LovD8m+jVDaQwDhTa9OZZPnZS0R4hi69+nJ/+7tnZ5aMIt5gAr0YasA==
X-Received: by 2002:a17:902:f805:b0:1cf:ad71:6f64 with SMTP id ix5-20020a170902f80500b001cfad716f64mr17581637plb.59.1701414467395;
        Thu, 30 Nov 2023 23:07:47 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:720a:d435:c253:2402])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b001cfa0c04553sm2558684pll.116.2023.11.30.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:07:47 -0800 (PST)
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
Subject: [PATCH v2 5/9] dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
Date:   Fri,  1 Dec 2023 15:07:09 +0800
Message-ID: <20231201070719.1229447-6-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201070719.1229447-1-wenst@chromium.org>
References: <20231201070719.1229447-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
Changes since v1:
- Reorder SKU numbers in descending order.

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
2.43.0.rc2.451.g8631bc7472-goog

