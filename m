Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAE800461
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377700AbjLAHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjLAHHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:07:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A31720
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2864a74f297so970518a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701414463; x=1702019263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu4WrQC62p9kUCUz6OnbUntEhdQYwvAf3l0CssAK7JA=;
        b=kT02B5psadlpL7w14obra4wEQA+xRKHN3FjKBFLZAjNK6vXzPCq3RYHLHWr4sNevBM
         rb8u5wWJEPGs2HRce2b27ihfapua92EwZoGyH3ZKSTDHMZibIq/t9uKd9Xc+SOd8wzTW
         rk9yQ/yrH+bQSCk0zoaPaZ/IhOKi4LQpn0PNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414463; x=1702019263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu4WrQC62p9kUCUz6OnbUntEhdQYwvAf3l0CssAK7JA=;
        b=NycRfVd/wORwlEPXRaM3plCcAImSnuCvyKVTSjAPZA40ML81/wO4mABhUQYobUKBnD
         uii8aKcWWDzsvRA7YQLqLubDeSN00ZNVBCuBCSprjDvXnrltocedrv8ode3PMm7DBpjo
         1PUAtL1oBepnNFq9aU8H7mwbrOmJb3LFkyz+1FqsJdbb2q9qfxftRbcI6ESTDs53hrEq
         sNs7fCBDZWBXHZF0e+yMxN9r/dPpo6LxtbeKrExOXI5lWbalqHR9aAOU3LTmRFxwBVpW
         eJyw31dTyn/qeye7rt28h5pjKwbbWyDfNtOnm/5sHLp//NnB3335Hr+Z6kfL9wZ/K4vv
         fUVA==
X-Gm-Message-State: AOJu0Yyzwe36M5IH2Brccg6TlmHWfqg0WfbAIXs28fC+K1BU00FuHj2Z
        N67qIFDHPnZCaAjJYDZqiPqPYA==
X-Google-Smtp-Source: AGHT+IHuC2XOMcvUa6guDnbfMxkbtrmd0uvpo69WLURwN+EEHQyuU3bS/3XZkBo3D08ftm4E7KpHWw==
X-Received: by 2002:a17:90b:1644:b0:285:8a70:b557 with SMTP id il4-20020a17090b164400b002858a70b557mr24011996pjb.31.1701414462795;
        Thu, 30 Nov 2023 23:07:42 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:720a:d435:c253:2402])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b001cfa0c04553sm2558684pll.116.2023.11.30.23.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:07:42 -0800 (PST)
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
Subject: [PATCH v2 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
Date:   Fri,  1 Dec 2023 15:07:07 +0800
Message-ID: <20231201070719.1229447-4-wenst@chromium.org>
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

Add an entry for the MT8186 based Steelix Chromebook, also known as the
Lenovo 300e Yoga Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- none

 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 709a1292bca7..95d2b430ab17 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,13 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
+        items:
+          - enum:
+              - google,steelix-sku131072
+              - google,steelix-sku131073
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
         items:
           - const: google,tentacruel-sku262147
-- 
2.43.0.rc2.451.g8631bc7472-goog

