Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA07C7A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443088AbjJLXDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443068AbjJLXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:02:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0373CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d922c039so12692225ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151776; x=1697756576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE2xuZH+agCjBR7PCdArWMNvITRMyBp9lywkci3iPfo=;
        b=bC/ArQfa8wQnogpeFi4YL961TNs9eEf9N/XXz+SlKdWnE8zqTOhI1QozMXK3SmMVZ6
         yqha7VXnmBye552w8DuZi5q9K/2NxY5nqQ3YHgL93F71uVjtTzdJ8FIUJTIr9rALYseR
         zb+Dj8SkNu/G2dBpJGcDH3pu1c1iVKfESaUVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151776; x=1697756576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE2xuZH+agCjBR7PCdArWMNvITRMyBp9lywkci3iPfo=;
        b=ITqPr3ezsqVFUpkDSZPzx87kekQfiWEjVqRVwYPv/He5UnOavqNz7HA9rytJaq2AOQ
         D2TTZX00YjP+otZ/uNze6O0HJT4hx+1gEzX3wAtvBU3ovYTEr9tSsrWWth/Temjr2HQH
         0QsJ6gRY6dWzPtQ/PbIMSUQ3ecGeAF0FwVL9hl5otJKzZne9CTMCXj+L+kXcW3OwtjII
         +g9YG/g2pHfrI49jqwHqg6OzwZxMIEmpp89f60gO+OzLcxKDFcZs/ZAZqOjfAwTcfH80
         0zzUXM53uc93MOZMof3Cmw4ZPAkOO+/Mlb+mxVXS1hAU7DkuGaph1VTiMqG7JX2ccRGU
         Vqag==
X-Gm-Message-State: AOJu0YypEjStK8oH4U5ByZNGqeckUAJ/rnKimEyf1Vd3v0Mj18wVaffi
        EpOxmWekqnsMKKAJQ03CMu1SvA==
X-Google-Smtp-Source: AGHT+IH82x0sce06pOgWdTOBXT/0/9Qeyys0giYi3PeU9VJRdoN88a47OlyJF9OWRAjbgB1qKDskbA==
X-Received: by 2002:a17:902:dac9:b0:1bf:4582:90d with SMTP id q9-20020a170902dac900b001bf4582090dmr31465372plx.46.1697151776154;
        Thu, 12 Oct 2023 16:02:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:02:55 -0700 (PDT)
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
Subject: [PATCH 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
Date:   Fri, 13 Oct 2023 07:02:29 +0800
Message-ID: <20231012230237.2676469-4-wenst@chromium.org>
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

Add an entry for the MT8186 based Steelix Chromebook, also known as the
Lenovo 300e Yoga Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index aa7e6734b336..fafd5e18f640 100644
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
           - const: google,tentacruel-sku262144
-- 
2.42.0.655.g421f12c284-goog

