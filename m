Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684337D88CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjJZTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjJZTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C21B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5cd27b1acso11347305ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347632; x=1698952432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLZEufX4IELLQNXAIl4tmqVd4CvacXFJyoj0xSht3aE=;
        b=jwu+izEA+iNQnS2lnGpzAIush5pUyQCHqH2hr/ymOsr97Ku3anF1/SsYLLzPYiE0Xl
         ugG4/tWySuTFF9WPmjHkhFqoN0MD/kpbXYtHjAdZ+42RFBcFu0VUCBBMNeKDOl8oT7Sr
         3QhuoaTpVCIQxsXCPHJ/qD3dEgVSQmdvzd2xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347632; x=1698952432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLZEufX4IELLQNXAIl4tmqVd4CvacXFJyoj0xSht3aE=;
        b=Kw8Kf2xFbtBGBdbWZ9uSC7TiGUCYKFfaM0LEgI7jmkTxlyN1COkyNLgU2iXfiv729l
         yAw8XkBO0tn6MYqsMLk8018CM/QKsbOXVaf6tKJaqISbTDIwSKMwDpb/FSH6Q4ptS7O5
         zEvogIa3VqW7ooz3zbHFs84q8Xfra6+MHLp3sCWXGiYZ1EVput2kEOLsw80xUgxSFbRY
         EVit7j+pFy6KvP+BzI0WYtbcjadCpWSA/0dw5TOvUfR8DbBjTzvvxznY9s06i7XipLgL
         y4+LQeL2Sm5a33F73zIKrJ6sQO/8QiOxo6A7T5PuBfLcgPoIh+sw2njaWElB2rh5xfl3
         TCFA==
X-Gm-Message-State: AOJu0Yz+V+NNbRN6zUtF54tmfG/2EWU2BCxtU2ZAy4Deiwrye8PW60u8
        rT7LvBfKf+Th5yCFGMTUF9GHVw==
X-Google-Smtp-Source: AGHT+IFk7vjIEklI72YfVhtP3+bOj+LPS0CVkNSGaWn6qlYyy7hlM3KbxfKPXYk+F5DUBE/ZxPVx0g==
X-Received: by 2002:a17:90a:1918:b0:27c:fb63:9c89 with SMTP id 24-20020a17090a191800b0027cfb639c89mr521631pjg.0.1698347632103;
        Thu, 26 Oct 2023 12:13:52 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:51 -0700 (PDT)
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
Subject: [PATCH v4 4/7] dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Thu, 26 Oct 2023 12:09:13 -0700
Message-ID: <20231026191343.3345279-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231026191343.3345279-1-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add makomo sku0 and sku1 which uses different audio codec.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v3->v4: remove error const.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4fe58cfe6f1b..c937f49ba3b4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -251,6 +251,13 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
+        items:
+          - enum:
+              - google,makomo-sku0
+              - google,makomo-sku1
+          - const: google,makomo
+          - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.42.0.820.g83a721a137-goog

