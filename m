Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226D3800463
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377716AbjLAHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377691AbjLAHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:07:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA341720
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfd78f8a12so1993615ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701414465; x=1702019265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf9Ef3ZU7ACSrQpFfV8EW4u1UjhYZlyDTx04rSBoN3o=;
        b=noRsCZPmkgbf9PSPQWwFHKjmteWElDW6At/lM3lnmb2kKRav76RLqWZo29tOHBMNuf
         QmADrIu9ONDClEgyf2IvxCb4TufYyKfDvoNF2HZy39bTP1EcxdWwdmWIEs1XM8jcQEqv
         QQs9N+EGH/8FsfB+hOBWDkcEwLJWGkzveqVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414465; x=1702019265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kf9Ef3ZU7ACSrQpFfV8EW4u1UjhYZlyDTx04rSBoN3o=;
        b=H027JysxII7PHSzEutvP1j1wkjAAG7yy1d43bLHTqHp2BDtZkU9OnUJW4xz2+iVEgT
         YUc0LUNRqWQzQQFV1bs8p4dO8RYpOSb2BkTqW1EzubgCxMj9/9X2dHSVLXkRYgy/slX6
         pf/KU3UGc9J2MVxqnXEvzrDc5mkD3Y2RNCocLiF+NXLQYLAOPn7iP+Tk+IE3QYydepHc
         5lfWR8XSil69kkNjngKNB8j4YWWV7JcdkScyHHCSHyfkpZ5oTN0uwM6ClBXLEh71YYgt
         Mqqe4tmz0Ht/Mukce34KMK14GtS/TehJ79fZKloYkF7QAYCTVuqoF1NhK1M7eWRH6JX9
         RlWQ==
X-Gm-Message-State: AOJu0Yzw05Zg1cLnFOI8Wwf7lnAMtGlD1P6KakEp3VDvsn2q+LHMFLyE
        BG1f4FCduIHn+gAYe3OhI53oLA==
X-Google-Smtp-Source: AGHT+IGIbCzmIDzJDSQxwRuPwXzrNiFhKYnu2L4N6gFeW0Zicdwpq2ZPNo4PD/Ikn7kumZbw+IRFag==
X-Received: by 2002:a17:902:ea84:b0:1cc:68c1:cab5 with SMTP id x4-20020a170902ea8400b001cc68c1cab5mr25292928plb.14.1701414465113;
        Thu, 30 Nov 2023 23:07:45 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:720a:d435:c253:2402])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b001cfa0c04553sm2558684pll.116.2023.11.30.23.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:07:44 -0800 (PST)
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
Subject: [PATCH v2 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
Date:   Fri,  1 Dec 2023 15:07:08 +0800
Message-ID: <20231201070719.1229447-5-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201070719.1229447-1-wenst@chromium.org>
References: <20231201070719.1229447-1-wenst@chromium.org>
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
---
Changes since v1:
- Reorder SKU numbers in descending order.

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
2.43.0.rc2.451.g8631bc7472-goog

