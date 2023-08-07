Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACA772864
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjHGO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHGO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:58:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323491989
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691420251;
        bh=Jyye8EVP4I8JQtjOX3N+dUgxG8gf4AwQwkaCdt4e9RU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=Nm42/xYPDwWuihsCz9q/cW3Rpqk+FvTWW91ME8k+drz9ZWw9VbpzK8rXPStmRo27n
         gNKU/BxZws/hFOK9huQX2kqPjeG2g6DADdoAEoQoSMfyqHg7Nhsjgl+MrRNfluOab3
         ihtF8na7cV3DhTJvy8UZ+UacifJ7Hc9tgl8LwrZo=
X-QQ-mid: bizesmtp83t1691420139t9jsluoy
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 22:55:25 +0800 (CST)
X-QQ-SSF: 01400000000000803000000A0000000
X-QQ-FEAT: znfcQSa1hKYrlJk2vfoU6p7I5RENz/QyNkC04VYca2SlernB/eTf4lylYUJGb
        YprNRAvuh1jJF59jnyDexL1Y6C7cP4k+P2pJ6ZUWVz2g7VdiFFw9wmMMMAawvX3bQedYJVg
        waONU6shDAmkKvE5EFAXziNmYG44Dz/jIk+A7ul6Kp5OWwS5qIq7AijKlzJDe4x0UjGcbqu
        j9z9xDDGM1z6CaG2QgQKz7pQMB3AvY5LlC/fe30d93smIPFndJ4AfpjxWqTwlWQpl5AfA86
        Q8FGZonPFcyS612uBEMq7n2YUGyX9r++QzoMX26wv0a3md4jFI7+RHPlz0yj/GGx+JR0x0C
        27oKCbsc8NzrgNc/vcwMqLAoeZD7bjxmoBOFD6N5asvrHn6HELGOsOJCCQyXfZUyS38TdHZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13198854249523945476
From:   Martin Botka <martin@biqu3d.com>
To:     Martin Botka <martin.botka1@gmail.com>
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
        Icenowy Zheng <uwu@icenowy.me>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
Date:   Mon,  7 Aug 2023 16:53:22 +0200
Message-ID: <309C7C26158AF852+20230807145349.2220490-3-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807145349.2220490-1-martin@biqu3d.com>
References: <20230807145349.2220490-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
Changes in V3,V4: none

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

