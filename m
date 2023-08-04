Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F030276FCD6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHDJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHDJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:06:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AA4EF6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691139773;
        bh=JgVNZzIhlR6H9gFXmbCf8H3Qt2YzotlwqrsJXwmccCo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=A0Ai0juRZcD+mX+0pFlu3RxVK3Q4uJWRvp1KZTn1Lnmcn/TM8W7+Ca8fohlt0OPGw
         vHa1/OJnXUABwN78JRhlK4qdGcROYQedocdT04Lvrq/L/Vdc9ZddmflON00c9YZ+wS
         CyJZoRbPfxbV4c96Im/wiAzvXFe51WVhALIFuENI=
X-QQ-mid: bizesmtp65t1691139730to70lhm5
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 17:01:54 +0800 (CST)
X-QQ-SSF: 01400000000000404000000A0000000
X-QQ-FEAT: bhet8yMU7vnuaKYQvQUAFldXCMttqStdUfNe0fI+vevf21iJgX6Wayc84GUXt
        +uw0N5BbrA0/8LtvzWgTmd9CV/6OsJfOaYKX7Hjs9i3yF4wyESfhn//IUYV8QfGXeUSHt40
        HMAeNP/VRFqWvSmNQNsWwjPwe/fY9MoO6wcQOMLzykEWIIdAjYLdDpBfU1QgbzcC37Mp4W3
        Op2I1V07yB4rpnuAuPsGd/iGDTRhD6ThMfc0n5ucWeTAp96ctfmEqdweB647obnRf5qX8wG
        T+wqxccTYeDAwXSDWsbVA5wKvAvuZUn1et7rWznIf6KVas6wOtInyCPQbsAY/7izjCqyfD3
        3a8RP4K/T3NVfxoRmZ19kMJwwix035x+y2hOrPOmjyh219jgKE2vN+q7rGWNBWNL6ODcdcl
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7036281750618526681
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
Date:   Fri,  4 Aug 2023 11:00:30 +0200
Message-ID: <7029E91796EC6A20+20230804090102.273029-3-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804090102.273029-1-martin@biqu3d.com>
References: <20230804090102.273029-1-martin@biqu3d.com>
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
---
Changes in V2:
    - Remove CB1 SoM as its own entry
    - Squash BTT Pi and manta patches into 1

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

