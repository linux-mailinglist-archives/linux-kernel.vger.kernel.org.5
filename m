Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2F789AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjH0Ccm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjH0CcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:32:13 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DE612A;
        Sat, 26 Aug 2023 19:32:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34ca192f8feso7206215ab.3;
        Sat, 26 Aug 2023 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103526; x=1693708326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApeSjM7hw/lG6tW2IMrrknm0IVFEfBtJMdeIIJl4q+Q=;
        b=PvFJv7DEd1JHac6VnvYdrQq9eNmK4cH2NHSseTh4VxMV4wpUJxwtFwAC7lWr6k1x1I
         /SKDR8ny/Jz6m9FjH0T4IruqOrpi/jD+kU8xlAW9LOp7uXRef/jCFGzoDZB4RY5GZ8xq
         zgf9jEaBzyuIxhfcJG3I5lDdA8R6y48h07JPnw7rdGgh6mOgPbukw/o0wCDmV+5daXQz
         RU++xsHclF2B2F4okWRXbL1EB7OD2MxsZ6XpgU2+r9h54qk2ZiscHRV4hZsBriGS43pD
         Wko3azTms95mvDdn/QNYzatzvfh2VlOjwgE/TlXz1mz8FaQt6aV5JFuFAsxYnJ2AHahA
         vuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103526; x=1693708326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApeSjM7hw/lG6tW2IMrrknm0IVFEfBtJMdeIIJl4q+Q=;
        b=ID9YFLeSzb2QJQicESfjBtyIKZ9XE+uuAq2L1eU+Ipv9MRkK/YxiecxrgfZaJn6Xvh
         VqKcOcTno//geNDlpZET+nuI6cCHWwVGB+IpZ/CAOssbsk9/5CrnX0IWcy5RUTDZViu7
         7YobjZzYfhyx6VbOQivWsv0XzojbXiz6h9mAd+iBw/zy2DWggqzvpcMmhPnZt+Byba3z
         9qZOqvLI41TTEYiLBce/XoJ9LPu32ybVlA/3IN2BBP92QanaiEISdaA71tGBRjsb63DC
         JHkRNFIZCPMOIq01++5WK+M6/XtZSOUfBTVWG4jTRft2o/VKB92xTaB2E187994D1cUs
         FHLg==
X-Gm-Message-State: AOJu0Yy2gzUhFq9jlcf+JNkoQe9FBrj78wYJlOhLvOVMVhi46OeBcYyR
        S9WWS0NU6LBg47yzqDIrG7U=
X-Google-Smtp-Source: AGHT+IF9EVO8eUJZilq7N7KAL3LWOobH19T0XMaJmOkjuahDbmBpbwBT4CoIif1djlm2lsBZ5/NWbQ==
X-Received: by 2002:a05:6e02:1646:b0:348:add7:f8e1 with SMTP id v6-20020a056e02164600b00348add7f8e1mr15709100ilu.30.1693103526337;
        Sat, 26 Aug 2023 19:32:06 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:80ee:1859:87ec:6d31])
        by smtp.gmail.com with ESMTPSA id n18-20020a056e0208f200b0034202d05fadsm1581533ilt.72.2023.08.26.19.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:32:05 -0700 (PDT)
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
Subject: [PATCH V2 1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
Date:   Sat, 26 Aug 2023 21:31:53 -0500
Message-Id: <20230827023155.467807-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP appears to have the same easrc support as the Nano, so
add imx8mp as an option with a fallback to imx8mn.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fixed errors:
     ['fsl,imx8mn-easrc'] is too short
      'fsl,imx8mn-easrc' is not one of ['fsl,imx8mp-easrc']
        
diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index bdde68a1059c..a680d7aff237 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -14,7 +14,13 @@ properties:
     pattern: "^easrc@.*"
 
   compatible:
-    const: fsl,imx8mn-easrc
+    oneOf:
+      - enum:
+          - fsl,imx8mn-easrc
+      - items:
+          - enum:
+              - fsl,imx8mp-easrc
+          - const: fsl,imx8mn-easrc
 
   reg:
     maxItems: 1
-- 
2.39.2

