Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBA802DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjLDImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjLDIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:42:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D3124
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:42:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2865742e256so1510612a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701679348; x=1702284148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wldu9pXjNyIoX3DoG7mDhf3kQNOoAJ2MdYX0EVUOaU=;
        b=nu/zG4220bD1pvpdU20ZMmQlxJdtutiFJ/U8+c6BlJFEbkgM/dtWIE61/iQBTd027Y
         Zh0ITNxBKFTRcBHt2/l61WgwLbyBLF07Ivgge1fJDrpFvkrm38qSM5BvLK0JmthaJ58t
         TBnpP58ltvdvGeHadDwe7v+t2htxIWzZ32ZKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679348; x=1702284148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wldu9pXjNyIoX3DoG7mDhf3kQNOoAJ2MdYX0EVUOaU=;
        b=ZlgBiNy24H6hNIZFjbhMv5s5PUmNhwoiiEffls240a8bHKMtvg3Q4IL+2gzC41Yvfb
         VJ2lllf6GgshzlsobNxTn0i2O4km+8JwQ28pWB+24RxAGeh60/A1R044gKafEEQoSYo5
         hVnu99V36en/9qxcMqEnAPLTS1wfLW4fclvxuUj0fB4twVlbxoVPs6tNPoLtaL6i6/B6
         pPJskqyHUFg7a4zpGJIDKaH172vdxQ3EQIQDRQK3dZQehk/mWNndsQrHkyrtPqKqOvbA
         EUf7S8FNUHHwc3LuafaeG1VAvHYRY/93/WzXEoIfdS3/ZsXEhddTnhf9ucpzT8I+K9QG
         Bcyg==
X-Gm-Message-State: AOJu0Yy1E7smuP2I69FkS2vcWrk9w/ckOowvx1awSpSZiOn/U9hg3jtq
        +M1dPVoj2L61d13Ygtqzgnfa7g==
X-Google-Smtp-Source: AGHT+IHjP/Qz9KwXm+qsjE9MAMvFkbEOBOOQnl7A/qRz7yN22jPCAKlx5OMx/9Xzixd9HImd+rjxFg==
X-Received: by 2002:a17:90b:4b4d:b0:286:a27a:f244 with SMTP id mi13-20020a17090b4b4d00b00286a27af244mr607210pjb.22.1701679348562;
        Mon, 04 Dec 2023 00:42:28 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6084:72e2:9ac2:f115])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cfc3f73927sm7871795plo.9.2023.12.04.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:42:28 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
Date:   Mon,  4 Dec 2023 16:40:06 +0800
Message-ID: <20231204084012.2281292-5-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204084012.2281292-1-wenst@chromium.org>
References: <20231204084012.2281292-1-wenst@chromium.org>
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

Add an entry for the MT8186 based Rusty Chromebook, also known as the
Lenovo 100e Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- Picked up Conor's ack

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

