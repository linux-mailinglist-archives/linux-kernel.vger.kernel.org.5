Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A87C7A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443101AbjJLXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443095AbjJLXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3AE1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c8a1541232so13529485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151778; x=1697756578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBvy7lbYwOwBhn+AJIxwjjdhBjxul9CUNWBOFs/FosQ=;
        b=UIj4TMYElMdp6G4kwkWFYIq0vBIjEHUBXm86+uO/we2nKAn/mA2d62eC0tFDUwDUOt
         IrMXD0nc4zQ6vhYRnMFneu5d7a6y0cmFAjm+6bNTTe4ixkMWoGTF5bRWqI4E3PudaTSX
         5rH0Rw75TbMzC3iMLDbZUgzCg4HM8CXWrsYTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151778; x=1697756578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBvy7lbYwOwBhn+AJIxwjjdhBjxul9CUNWBOFs/FosQ=;
        b=B4UHDVlxLnKB9Q/RNq8bbPi9HtAjAVLkN+GdWKvTn+Bq/aG/yPADTaPlVIDsXuOwuh
         C9nXRfvcgh0HYcEWMBHcwA+TXOFzrMWt45ZYDp861GDEznLtzQuDvxnoei5fm6pTBu6Y
         7WK+BROfV0OQRcf67BBj+f6pBgwcQAioigKmPjA6Wkcxp6NIEIEGoeB25XiROnz+DXkw
         dJB5c/0KeSipgFBuXW/O+GfGTv2R4QCuRJLyGFInm9/UnBjVWzJS+DdHdnK9FUZDCuT/
         Vwk2DFtGPbAlFHafyPUp/nBHVpkgmXWnA2mXeQ+pQi41TWCurW6QLAHd3LGDvgUFU2yr
         ak3g==
X-Gm-Message-State: AOJu0Yy5z83YAXwTF7rSWBH1COO5KzXVc8CBHK55juYrmi068bopmP7I
        ad7tWpKoq7BNcjvVvHvmwVxItA==
X-Google-Smtp-Source: AGHT+IGXznJ4hIrXPd2v4LG0qd7GDuqFPhe4DtqE9+/RvasogqCkxgRRCfWmbESl1PyoeLxvWTeJjA==
X-Received: by 2002:a17:902:f14c:b0:1c9:e0f9:a668 with SMTP id d12-20020a170902f14c00b001c9e0f9a668mr2179774plb.18.1697151778356;
        Thu, 12 Oct 2023 16:02:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:02:58 -0700 (PDT)
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
Subject: [PATCH 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
Date:   Fri, 13 Oct 2023 07:02:30 +0800
Message-ID: <20231012230237.2676469-5-wenst@chromium.org>
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

Add an entry for the MT8186 based Rusty Chromebook, also known as the
Lenovo 100e Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index fafd5e18f640..5e5834d9865f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,12 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
+        items:
+          - const: google,steelix-sku196608
+          - const: google,steelix-sku196609
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
         items:
           - enum:
-- 
2.42.0.655.g421f12c284-goog

