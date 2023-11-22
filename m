Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87337F5391
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjKVWoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKVWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:13 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BA1BE;
        Wed, 22 Nov 2023 14:44:09 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35afe2bfecdso1079745ab.0;
        Wed, 22 Nov 2023 14:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693049; x=1701297849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiTed5vR1rJNl1vKggefixTkkrQwZelbJ3TG1M33LMM=;
        b=qUwYziaY4I26kt0iZH5QdfFSqLiYyA/ID8mZ/YlHnBeramKywd5hMhp3ZCsaSDHHqN
         MS/9H0MQG8X2gx2Nj2eN7MZD6Cz4GaznjdXixmid9cNqEpKLMIc3mjX5TNAAiuw46Opm
         eiCg5fy/YaaNSixdV8Se5AZY48SpWxYLCsH7biQerB8Ia0Ayu+tyjaSaFic1IpvSEWcu
         ZBTG45oPk520xefaTS6lUh+Um+ic1n5lowRK9Gh7hIi6QA1omHlomqy0AipGML8EH8D3
         0d9o/k3rzucuSm4sTFL4HakjlSiZXFxxyukQwZLL2tJ8Vz5YUBRU0MbfpQlU+vWlo9Xk
         BdUA==
X-Gm-Message-State: AOJu0YyC3uYQh3MeDsCCEpkEK9P2ZlOLEOpbB0232MXV/Pd9stRAtMvR
        U3TpVU3ve3xRsrr/l92s1Q==
X-Google-Smtp-Source: AGHT+IF5nkW6uFAF3era+SxmqvM7V7nmOcX8+bkqmnlNp1CtvAeePvj2MNCRGnB7//674xk291yueQ==
X-Received: by 2002:a05:6e02:1be4:b0:35b:3849:6f2e with SMTP id y4-20020a056e021be400b0035b38496f2emr4451116ilv.8.1700693048622;
        Wed, 22 Nov 2023 14:44:08 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y11-20020a92090b000000b0035b0b56e0e1sm176061ilg.53.2023.11.22.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:08 -0800 (PST)
Received: (nullmailer pid 2808951 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: imx-src: Simplify compatible schema and drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:04 -0700
Message-ID: <20231122224404.2808838-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible schema can be simplified to a single enum for all the cases
with "fsl,imx51-src" fallback compatible.

In addition, the compatible strings are redundantly quoted. Drop unneeded
quotes over simple string values to fix a soon to be enabled yamllint
warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/fsl,imx-src.yaml           | 31 ++++++-------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
index b11ac533f914..f5ec1d54aa51 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
+++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
@@ -28,28 +28,17 @@ description: |
 properties:
   compatible:
     oneOf:
-      - const: "fsl,imx51-src"
+      - const: fsl,imx51-src
       - items:
-          - const: "fsl,imx50-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx53-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx6q-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx6sx-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx6sl-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx6ul-src"
-          - const: "fsl,imx51-src"
-      - items:
-          - const: "fsl,imx6sll-src"
-          - const: "fsl,imx51-src"
+          - enum:
+              - fsl,imx50-src
+              - fsl,imx53-src
+              - fsl,imx6q-src
+              - fsl,imx6sx-src
+              - fsl,imx6sl-src
+              - fsl,imx6ul-src
+              - fsl,imx6sll-src
+          - const: fsl,imx51-src
 
   reg:
     maxItems: 1
-- 
2.42.0

