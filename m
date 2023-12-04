Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6A802DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjLDIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjLDImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:42:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA3100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:42:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfabcbda7bso18807005ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701679346; x=1702284146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qOBfJHT1+5PjLRRaf9qTSuTN75gznyCQLWs4A+G1fg=;
        b=f5cFI+JPUTacsJVpLQ6J8Z9BoPQdVjeaa4bGVfUvdaas+RiLvoXKSE/Jk0pVtUNEmt
         mei1+NOEJbEsy8iW5jphnrNEacqexJsO1TGYeP/y320gFZFu6xyMchvHzTR7Ft8q/1II
         D3+Z9W4ym6nAITEiZx2wI3QfhMgVWCEwZ6W/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679346; x=1702284146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qOBfJHT1+5PjLRRaf9qTSuTN75gznyCQLWs4A+G1fg=;
        b=K7YTvXvUOkFa4WBu8cgtw6jb6zBqswhqyLUHa045j7lVOUw5i4Hcr8FltSXVspDpPu
         o+B9enOedRFQlKh1gj/kqQjraToNOhl2d1rAsljEa59j3GdL97oUBXnPepr4UnGXdDGb
         sTLdkfwKw29+U/doFuQqISnyJYLfM740v2AkZajpl94pvmzAnLUiv2ujcN+OiTuVWeXL
         3oWhyVYRMSynnrQFx6Nj52XP/nTIv01sapxpvrTiDBnW6hsgCSjjT3Vs0P5G5ieRFcyJ
         1y8reC99MeiZgTc+bcfNvckytrB0VQBwt4v5+QsaaRakGNebl9SR3aa1JoT6DwlNSFzg
         P1PQ==
X-Gm-Message-State: AOJu0YxuRRK5cgYvPWxrafto5jQdH8i4QLkfud5kmAhJZuoyZd6Ao+cA
        S5CcBROezjKpbx+PzVU2ju1R0w==
X-Google-Smtp-Source: AGHT+IH3r/F4nbYXPOG1kQenYe0KwmiblO2QhUP+W7XTVCgN8GlIr5u5FdgB35I5wSnpXh/9x+QlNw==
X-Received: by 2002:a17:902:aa48:b0:1d0:6ffd:6120 with SMTP id c8-20020a170902aa4800b001d06ffd6120mr3339981plr.66.1701679346161;
        Mon, 04 Dec 2023 00:42:26 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6084:72e2:9ac2:f115])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cfc3f73927sm7871795plo.9.2023.12.04.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:42:25 -0800 (PST)
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
Subject: [PATCH v3 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
Date:   Mon,  4 Dec 2023 16:40:05 +0800
Message-ID: <20231204084012.2281292-4-wenst@chromium.org>
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

Add an entry for the MT8186 based Steelix Chromebook, also known as the
Lenovo 300e Yoga Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- Picked up Conor's ack
Changes since v1:
none

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

