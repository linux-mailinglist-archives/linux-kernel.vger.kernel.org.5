Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F680F31E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376447AbjLLQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjLLQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048011F;
        Tue, 12 Dec 2023 08:35:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAA3CFF805;
        Tue, 12 Dec 2023 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702398936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hweC77A4qTiukJmzDsKWoV1ZESOCwoXMkWKMnWM/4uQ=;
        b=eAcAYqpzCyJ6Pgu0gB32DTZHOIYSBLAyhc646XLgwPTGHNzKongQHmhlVesMLH0SsgyT+J
        nsQSuadYTIlRbwtM97Bj/47XIURU5ssOyakg6ujAVKxiCAbumXK9LL0AQ0V80IKgoVVduk
        rK7SOEQDgi7+w3m5U59cs3E6AEg2AVPUkrQs2jsCpTX/8mM1gEzA9J9Vg3HyydvqexJ/cD
        mGDXL+5dScpK9HK8HQ6i/laAQCSAcMFmH8Ve8+EcWdzx6Wzlr9LiaivdspI8FX0yz1R2Pg
        D7r+S72+4wEgj/aUMuidO4v0unvHtnh5ltu9kYdbsgEGPpatgyWSYxEdXY5Epw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 15/22] dt-bindings: mips: cpus: Sort the entries
Date:   Tue, 12 Dec 2023 17:34:47 +0100
Message-ID: <20231212163459.1923041-16-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212163459.1923041-1-gregory.clement@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entries were nearly sorted but there were still some entries at
the wrong places. Let's fix it.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index cf382dea3922c..9bc47868d28b6 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -23,22 +23,22 @@ properties:
       - brcm,bmips4380
       - brcm,bmips5000
       - brcm,bmips5200
-      - ingenic,xburst-mxu1.0
       - ingenic,xburst-fpu1.0-mxu1.1
       - ingenic,xburst-fpu2.0-mxu2.0
+      - ingenic,xburst-mxu1.0
       - ingenic,xburst2-fpu2.1-mxu2.1-smt
       - loongson,gs264
       - mips,m14Kc
-      - mips,mips4Kc
-      - mips,mips4KEc
-      - mips,mips24Kc
+      - mips,mips1004Kc
       - mips,mips24KEc
+      - mips,mips24Kc
+      - mips,mips4KEc
+      - mips,mips4Kc
       - mips,mips74Kc
-      - mips,mips1004Kc
       - mti,interaptiv
-      - mti,mips24KEc
       - mti,mips14KEc
       - mti,mips14Kc
+      - mti,mips24KEc
 
   reg:
     maxItems: 1
-- 
2.42.0

