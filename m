Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9E8115AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442212AbjLMPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442117AbjLMPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:04:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CCE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d345b187bbso13862505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702479895; x=1703084695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5iSRDewShTPXxKrQl9ZbdBaDFVN8OqSrgR14MEC1bo=;
        b=CYhsugQDX7/PIQGMouNzFVxZ74VhphuO6ie6C+xZ5XkP0YZ1aCKbUBGLOQDXYeu5xp
         ZyThTlkUK983N7iKLYFToYwaSnrbmPc5tXM4xGcmguRhijPk8VVf0v1Heos5kfFpej0P
         HeapEyEocgZPoIAp8S6oMzXuD1nmn3jgXA+Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479895; x=1703084695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5iSRDewShTPXxKrQl9ZbdBaDFVN8OqSrgR14MEC1bo=;
        b=ob9qEomi5suK1CVLkSeOmBtk72x6cYI9xpUIBHO6MqFrdtjGnejx3IpTAVjeJiIyeq
         5W8awvxfIqkCm+RUsdt5jVfs6516oG9sUUwg5DPJUPnMhmo2b59osHbHPgSieW4O/eYD
         wOXoTX0Vjw/PGRzQ0nSmTB7uW3q0oChs5Hee+fqwVWUY/L+4QMEGMTL77lxZEKDcEXGS
         Y1L4FXQxCz1k5cXt4Kvp0MgPBzlkbHlRNUs9Toc1C2i8DKq7XG0Bh6jAERd3v8OMtx3k
         svo34DsxQz8OkOr6Z5BKlLe2z348p50cr6QtDrTxfmaszbyJ7IFPUJQwKKbaoEJDRM2R
         3zuA==
X-Gm-Message-State: AOJu0Yw9jscnc5ZQTh+hNQfSoJ2GSAPVt5X5fudp6tSQKeMgaqkE30PC
        4ofgc/shpVmdoXTL2aMmqL3Qmw==
X-Google-Smtp-Source: AGHT+IF2D6t1zTEzAvgIYyo0Wejm3JOajy+YfsbKc5W0Cj+mJTZHrPx+Rox/JQkhkLD6UyMsqVq3kg==
X-Received: by 2002:a17:902:eb88:b0:1d0:265:6a2c with SMTP id q8-20020a170902eb8800b001d002656a2cmr9652280plg.11.1702479894838;
        Wed, 13 Dec 2023 07:04:54 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1974:9e2:4915:58b0])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001cc2dc61c99sm813808pla.22.2023.12.13.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:04:54 -0800 (PST)
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
Subject: [PATCH v4 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
Date:   Wed, 13 Dec 2023 23:04:27 +0800
Message-ID: <20231213150435.4134390-4-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213150435.4134390-1-wenst@chromium.org>
References: <20231213150435.4134390-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the MT8186 based Steelix Chromebook, also known as the
Lenovo 300e Yoga Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v3:
- Collected reviewed-by from Angelo

Changes since v2:
- Picked up Conor's ack
Changes since v1:
none
---
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
2.43.0.472.g3155946c3a-goog

