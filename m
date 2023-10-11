Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F837C49F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbjJKGPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbjJKGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:15:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDF0D8;
        Tue, 10 Oct 2023 23:15:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id D2963E0008;
        Wed, 11 Oct 2023 06:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697004910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p22HMMIKMFQbh6/HiMaCltDimc7HD++LcS5qhfEDNEc=;
        b=DQDga1XAYLTeGTH8hZn8OTuHijqJ5cD9JhSvmiT7m3j0cWt7U30Icdpt2U8bkZkfb/q/BO
        pqM6lfT9A1Dk3zgIHpAZeKTUiu14gsPrO8woV9fWCeC31pP2/nloqnJyqfz5WFIX2vJGhW
        0584b6y8MMSmNe6PTz/y/QI9BBi+LgzlLes2q1wU8gW8K12AbOpMkUFJSbAPFeOyUoKsPS
        xi4WbP7ix685hUXFat38euN5sWht7p6/gPixSoa1rSdzlfGFBKKuF7owenh4oFenYMrqdP
        u8JjAC8Uvh7wQUvsUqoP18mst0BiQv2lKHZg3/TQfYWExjtlYOL6yC+i5Z/bxg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 06/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Fix example property name
Date:   Wed, 11 Oct 2023 08:14:10 +0200
Message-ID: <20231011061437.64213-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061437.64213-1-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The given example mentions the 'fsl,mode' property whereas the
correct property name, the one described, is 'fsl,operational-mode'.

Fix the example to use the correct property name.

Fixes: a9b121327c93 ("dt-bindings: soc: fsl: cpm_qe: Add QMC controller")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml           | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
index ec888f48cac8..450a0354cb1d 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
@@ -137,7 +137,7 @@ examples:
         channel@16 {
             /* Ch16 : First 4 even TS from all routed from TSA */
             reg = <16>;
-            fsl,mode = "transparent";
+            fsl,operational-mode = "transparent";
             fsl,reverse-data;
             fsl,tx-ts-mask = <0x00000000 0x000000aa>;
             fsl,rx-ts-mask = <0x00000000 0x000000aa>;
@@ -146,7 +146,7 @@ examples:
         channel@17 {
             /* Ch17 : First 4 odd TS from all routed from TSA */
             reg = <17>;
-            fsl,mode = "transparent";
+            fsl,operational-mode = "transparent";
             fsl,reverse-data;
             fsl,tx-ts-mask = <0x00000000 0x00000055>;
             fsl,rx-ts-mask = <0x00000000 0x00000055>;
@@ -155,7 +155,7 @@ examples:
         channel@19 {
             /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
             reg = <19>;
-            fsl,mode = "hdlc";
+            fsl,operational-mode = "hdlc";
             fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
             fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
         };
-- 
2.41.0

