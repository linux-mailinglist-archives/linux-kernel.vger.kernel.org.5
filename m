Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589AA76DA69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHBWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjHBWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:05:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF72D68
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691013890;
        bh=976oAWEftBsRkwMjPTbFB3UtoI/M6tZEJ6rNW67Luq0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=GO4LoYDa3XVSXuaH2w6eS+KTVgjKXgAe22k24zjor6RARrB/iHbyVC7RO95crWKQr
         7cuR4GoaSJrMMen/gpoMgAFSTkvDCAznriqRYi6PNIOJ+S03GcFVGVyiOJiIWMICi+
         DekWXGdo2HKjK76219icwEWNdBT04b1gH/lEsD2k=
X-QQ-mid: bizesmtp89t1691013844tij6nfv5
Received: from TimeMachine.lan ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 06:03:50 +0800 (CST)
X-QQ-SSF: 01400000008000301000B00A0000000
X-QQ-FEAT: 7QbCsSX/jDbRB3RSNooPd9E0zelZpwCw368EFFYl6HIsec7BtASdxgoFCsgoT
        AneDl1YMpkFadEFPSXmDVNpLMBTantXAJZpTvAGaH3KRrOgHgG92QXufHJCZPCSiauPu7wO
        0oPUSJMBicGvcCsIjK0NUANCuePeiYq3ae/e9FoB3earSBQYOTqx+Kn7zSXVTEhVwQJUl0u
        YFutYywN8mBupYN4oVSrOhhYkXMuSHtlLJeqMUnji86cboT2oElUczXIPMB5y7NPUTk2SNW
        7J8scdWNibwgOsuxhH6f9GoENmBgTTsq0TvNh7tyHPxylGiKt9myI9TqRvny0gSpwzmXu2I
        bbicVwifN+hjRAAevNRbpqUhh0XFpK+6MA1YKQW
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2859940852076240057
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
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] dt-bindings: arm: sunxi: Add BigTreeTech CB1
Date:   Thu,  3 Aug 2023 00:02:35 +0200
Message-ID: <54C66F97A81FBC29+20230802220309.163804-3-martin@biqu3d.com>
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

Add a name & compatible for BigTreeTech CB1 SoM

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ee8fdd2da869..5ae1b81af6fc 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -151,6 +151,11 @@ properties:
           - const: roofull,beelink-x2
           - const: allwinner,sun8i-h3
 
+      - description: BigTreeTech CB1 SoM
+        items:
+          - const: bigtreetech,cb1
+          - const: allwinner,sun50i-h616
+
       - description: Chuwi V7 CW0825
         items:
           - const: chuwi,v7-cw0825
-- 
2.41.0

