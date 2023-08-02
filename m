Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416C876DA6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHBWGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjHBWFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:05:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D02D68
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691013905;
        bh=29xBkderLMxMmkFQAQeIhhv9F/k2g15pds8ZdS3Czo4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=ThGU9CSDKiY7vBfW3e0j4CFhMj/BreOXelL2GbjOstZewi9T8NArpBqvmQqGAfrle
         t0DKanrHgptZMNZr4d6d+vwavjQ0wRw6LS0VWDPbfkGiP/QEwsEks4TzUX8YHACygl
         azBPq9Y/iabH59OoxcCv86jqRWSxee/Zniz8rKfA=
X-QQ-mid: bizesmtp89t1691013860tn2navoo
Received: from TimeMachine.lan ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 06:04:06 +0800 (CST)
X-QQ-SSF: 01400000008000301000B00A0000000
X-QQ-FEAT: SFhf6fKhx/+5VhPi357MDf5bfAuP/szlvfnkpxvaNDFTzBRvMvCQpY/5Z8FVS
        erHW4bGC9MNIg1WgtBU10WKRAVkT151IkzeoX77iWhnJyDxGeVElVgNlueOtPufTD+V8rUt
        NvaKzyTup4ylG0ruhlQKq0G2aeeI0OD9JFTebOy+44TrezReqjfMsWYDjecDmy0dfMEiqeD
        iGJ2G5WvAIUsa9M343zoWdzKiZeNdx3CUY54SRzkVROtdVG5/zVxW7wXXG4J4YJ7aclXEYz
        CzNlzvsUamHuO+OVKuUAazr6+7vuzH574X2zmN3LHoORTvxJoC0chb1+ZabLVUktLnGnv4o
        wh+6XMQvoXFE1+Kssw1LYhTEVo7oOR12Rsu3mNNmab6/lzufdc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17632365392127534354
From:   Martin Botka <martin@biqu3d.com>
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
Subject: [PATCH v1 3/6] dt-bindings: arm: sunxi: Add BigTreeTech Manta board
Date:   Thu,  3 Aug 2023 00:02:36 +0200
Message-ID: <222684DD3067C1E9+20230802220309.163804-4-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802220309.163804-1-martin@biqu3d.com>
References: <20230802220309.163804-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

Add name & compatible for BigTreeTech Manta boards

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 5ae1b81af6fc..e9e46434dd1a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -155,6 +155,12 @@ properties:
         items:
           - const: bigtreetech,cb1
           - const: allwinner,sun50i-h616
+          
+      - description: BigTreeTech Manta M4/8P
+        items:
+          - const: bigtreetech,cb1-manta
+          - const: bigtreetech,cb1
+          - const: allwinner,sun50i-h616
 
       - description: Chuwi V7 CW0825
         items:
-- 
2.41.0

