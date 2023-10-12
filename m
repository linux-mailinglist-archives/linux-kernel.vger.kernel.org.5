Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C77C7A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443104AbjJLXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443085AbjJLXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DAF2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso12701375ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697151780; x=1697756580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIH+YvGCzBPNtKNlT8wLBn/0tQkDSpCAQdxybdH6cwo=;
        b=Ky/YuNs1FNez3PueN1yU5xUOODqzPkZO4mpDCeH8r2lRRbYzUjOcJtxB/TlyW78SeD
         ZyF/QFKYJCMsHqykS8Pdz+Bs9h5rmoBrzSa9oWwOkgKdtxMHQfGUofJu1fO0KHoAidxF
         uq0F0Ak343S8kRBVyUS/SxTgjMx0ZM3wBeELk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151780; x=1697756580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIH+YvGCzBPNtKNlT8wLBn/0tQkDSpCAQdxybdH6cwo=;
        b=LWuBjZ1AMcrTPycztiyRWHNJBtnE2EdxPRmH8vDMhRVkqjDatx3+UOEPf59BQ+pQAG
         Ee6exIIQnZ7/ZF7GAdC+ZKxwYYln33iS2b0ujkD19/B4/bJljzIDuTTpvb56VPUEiYcD
         AkmxKTB4a6Fuzg2cVW0X8eEUM7NWMstAI0YaZgidzGAcoqJb0sdejThog7hIGKed429e
         lWZ3Zi2hdUXy0giowqKB/HM5Jhr6ZEdRCPDdhaiSe6cB1wr653jPd7GsrRzjZVDbv/zJ
         I1ojtw/Izz1kxohPoIlSZaJk3XnEtLMaedubKK5Lgbh00UxZYqNdFC+xbaW3PGfGBq3/
         Kx8Q==
X-Gm-Message-State: AOJu0Yxy+mtn/XH7n6eb0p9HdospcDAVjf6q3b7bGZNY41z/ESpeGg9e
        q0b079cdC54uJVmGZAgw7wy5Kg==
X-Google-Smtp-Source: AGHT+IFBHMMkJoSakpp1N70bOiH3PMSzDjXVxC2bq1hCrP6zNIw/kZcHm0z6MEySLozadGI5ljy7GA==
X-Received: by 2002:a17:902:f2d3:b0:1c9:ec98:217 with SMTP id h19-20020a170902f2d300b001c9ec980217mr1142980plc.41.1697151780553;
        Thu, 12 Oct 2023 16:03:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7397:2561:ed13:bac8])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001c613091aeasm2494390plt.297.2023.10.12.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:03:00 -0700 (PDT)
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
Subject: [PATCH 5/9] dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
Date:   Fri, 13 Oct 2023 07:02:31 +0800
Message-ID: <20231012230237.2676469-6-wenst@chromium.org>
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

Add entries for the MT8186 based Chromebooks, also collectively known
as the Lenovo IdeaPad Slim 3 Chromebook (14M868). It is also based on
the "Steelix" design. Being a laptop instead of a convertible device,
there is no touchscreen or stylus, which is similar to Rusty. However
Magneton does not have ports on the right side of the device.

Three variants are listed separately. These use different touchscreen
controllers, or lack a touchscreen altogether.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/arm/mediatek.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 5e5834d9865f..a4541855a838 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -206,6 +206,24 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393216
+          - const: google,steelix-sku393219
+          - const: google,steelix
+          - const: mediatek,mt8186
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393217
+          - const: google,steelix-sku393220
+          - const: google,steelix
+          - const: mediatek,mt8186
+      - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
+        items:
+          - const: google,steelix-sku393218
+          - const: google,steelix-sku393221
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196608
-- 
2.42.0.655.g421f12c284-goog

