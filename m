Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277EE781F20
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjHTSBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHTSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:01:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD5120;
        Sun, 20 Aug 2023 10:57:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7920f16433fso41793839f.1;
        Sun, 20 Aug 2023 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692554226; x=1693159026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXY/Krf60fo7q+81YL5YMclpFtMXwbOMF3FlcrEqWFo=;
        b=mhZ2LEg+30bcqlPupOeWQyaJcyeOtTdxUUQByAJUQ0ZzU4l6oZzyLsY2N02UlVU/Le
         twL5BuPsuNJK32HF1G5daDI/Oynwul+3RXyhYJK3+XyXx6t24IaeWyFwS9PTdlEZyYi5
         8zSeZF3Nw8SN1hVXKRTEkgc9Rf2c6RyZJ4V3Sys+XwE2OmegtUwEFdPElE00Q0gQjYk1
         /RAz9/zLVdwOy0+vQugkySE13Rk7Yr8txyddPRS12525+ZsjYiu+uWdxtrvlyInFpkGV
         Gm/+RVQDcVtymWL0Grn0HXATp3g0EO5IdM90xMsw7SMwRM6IHwMo+khGCVGTsFKmmxhj
         FFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692554226; x=1693159026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXY/Krf60fo7q+81YL5YMclpFtMXwbOMF3FlcrEqWFo=;
        b=J3ssvUCNl1Pc8KT1wPNSP/vNKFD/UqjWIKbtl7HApEKUXfA0U0u7TVQwMFoga0KJLq
         vimoPE58xOwMZdI4M7bviZdnwdX3xbdty8ynPBab1p6kjRewRnwpmsef2tJixZdxnn/+
         ZyQQlH27LbLj0v/Kz1UYvb9+lCdQbl79e0xPJIKfpS8ydD+1AVRHuz74fJGyy8tGTt6m
         capD31oZDZso+yAXkw1NIEd+yF3eb9UYepS/5y+fVfLiIMAVphHo9d04PxkNvq5GMfPy
         wKDSl4NnL2G+pgSDwxFn3ZT2/KEuV8qwuFyioaYXx5D+taXQ1U+qQScN34MHonXI7xqG
         eP4A==
X-Gm-Message-State: AOJu0YzovFuSyAfZrESKOOch/qxbo+40dxomUZbDC87sGl56YGQVtmht
        /w72QbtvhfLIUraxszBM0Tehqs0ICto=
X-Google-Smtp-Source: AGHT+IFrfP5c5XIMgf3S3xbbTbPNs+f9WD+0g5o9TE7WqZLcxF+SnWESznNvSWXbIC4K02+UoMwEPg==
X-Received: by 2002:a05:6e02:1be9:b0:34a:9320:b7c4 with SMTP id y9-20020a056e021be900b0034a9320b7c4mr5584188ilv.6.1692554226129;
        Sun, 20 Aug 2023 10:57:06 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:4e93:5643:7a4:7606])
        by smtp.gmail.com with ESMTPSA id gn16-20020a0566382c1000b0042b3a328ee0sm692448jab.166.2023.08.20.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 10:57:05 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
Date:   Sun, 20 Aug 2023 12:56:53 -0500
Message-Id: <20230820175655.206723-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP appears to have the same easrc support as the Nano, so
add imx8mp as an option with a fallback to imx8mn.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index bdde68a1059c..2d53b3b10f2c 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -14,7 +14,11 @@ properties:
     pattern: "^easrc@.*"
 
   compatible:
-    const: fsl,imx8mn-easrc
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8mp-easrc
+          - const: fsl,imx8mn-easrc
 
   reg:
     maxItems: 1
-- 
2.39.2

