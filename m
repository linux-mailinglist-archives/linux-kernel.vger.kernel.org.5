Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A700770EDB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjHEIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHEIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:38:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7801BD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691224710;
        bh=FgjqXuH69Dl1m7UxLC+Td4fABd9U51qmILllzA/jBBo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=g5KMUcO/hX75yURJaoSMZDsltFG6IlFIdXUbTkl2bjCYYDv/8zPAqmr/Fk/6OHu16
         Nd6RYaVQKvYwpILRTiuIEkaJoU8srdEaBHZr3IFz/VZyMhI7qWBtty4h9yugY1Od5J
         V4d6+dee5g4Mm4GwB2fsWlEEEbt9c+Yo334YXIlg=
X-QQ-mid: bizesmtp83t1691224667tcoiqse1
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 16:37:33 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: QityeSR92A2buxPbqLS21ggHMOq2gDQqn/OrBSPbUeC9mW940X4gmjKY28PtU
        dkAdx/MZuZaB9ZYF5GsjkS9mFVbKf3WBqlyf4tqLp74MXUakczWrqz+BZ6WkF94feQPoMDk
        YsKs9kJCUC5hp5CFNs1vCQlI/apXaUkp1tEHCqFPdjkQ8SF2me1uPrvJSTZ9KTyd3EX2ZNU
        C5tbjlEZzqMIO4c5ygKX/PCCio4wjCg8nlf5GAEa3GxDhsu2pr3VgGlGmK0KAjJzVaPBSXk
        Tma75OQa9fKxVrKFYpR4b+vxR/i3vcBe44oLXPs3jeuBzawz++f5lXs7SjZpP+O3oim85/F
        +r08RKaWypwGZzgI6vVgc/t6kni0UM4dOASOITpltOhghBA317thO4lzm3sC/cVDbt0h1IY
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4559950550026644883
From:   Martin Botka <martin@biqu3d.com>
To:     martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
Date:   Sat,  5 Aug 2023 10:36:05 +0200
Message-ID: <85B937A9BFFA4720+20230805083636.788048-3-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805083636.788048-1-martin@biqu3d.com>
References: <20230805083636.788048-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

Add name & compatible for BigTreeTech Manta boards and
BigTreeTech Pi

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in V2:
    - Remove CB1 SoM as its own entry
    - Squash BTT Pi and manta patches into 1
Changes in V3: none

 Documentation/devicetree/bindings/arm/sunxi.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ee8fdd2da869..b90d2a7dbe2d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -151,6 +151,17 @@ properties:
           - const: roofull,beelink-x2
           - const: allwinner,sun8i-h3
 
+      - description: BigTreeTech Manta M4/8P
+        items:
+          - const: bigtreetech,cb1-manta
+          - const: bigtreetech,cb1
+          - const: allwinner,sun50i-h616
+
+      - description: BigTreeTech Pi
+        items:
+          - const: bigtreetech,pi
+          - const: allwinner,sun50i-h616
+
       - description: Chuwi V7 CW0825
         items:
           - const: chuwi,v7-cw0825
-- 
2.41.0

