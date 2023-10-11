Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7897C4A07
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbjJKGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbjJKGPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:15:31 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33726181;
        Tue, 10 Oct 2023 23:15:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 627BFE0007;
        Wed, 11 Oct 2023 06:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697004917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exqU44vp0OQhVVoPYW7chAWLNAw8ghblo4zFam/LWAs=;
        b=f7/2qCp1mhBlrLQ4l+8UzRH/WMbDRVk2s6szpLassj6vhw0vYTWFo01Ipv8eavUsGzjdty
        L1L5/wvRmvkT5R1OB6wLsLS1sx+V5U6lnjS0agj8JAD4wkGF6WcE7hATLQ8mgPCHeBm/64
        jnP+5wXVFc3Uojq1HCBi8RFkwfMIdCWcWeDCpx4pzqSGPiac0I+d12Qzhq468kS1gkebb2
        CS068cPoaXJeH59rNhnDII0j6sSrvd3I3jnrO0QwOYYpBxrM9UdygnLVKBpccGbvkMYLmA
        t7jvjuPpMPlaPLhmIeoYtZ8lvpMSFHz/Mj8Wx3BAG2Ch5QIg6cKF6EwweQFFAA==
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 08/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add support for QMC HDLC
Date:   Wed, 11 Oct 2023 08:14:12 +0200
Message-ID: <20231011061437.64213-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061437.64213-1-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMC (QUICC mutichannel controller) is a controller present in some
PowerQUICC SoC such as MPC885.
The QMC HDLC uses the QMC controller to transfer HDLC data.

Additionally, a framer can be connected to the QMC HDLC.
If present, this framer is the interface between the TDM bus used by the
QMC HDLC and the E1/T1 line.
The QMC HDLC can use this framer to get information about the E1/T1 line
and configure the E1/T1 line.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
index 82d9beb48e00..e802e25923aa 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
@@ -101,6 +101,32 @@ patternProperties:
           Channel assigned Rx time-slots within the Rx time-slots routed by the
           TSA to this cell.
 
+      compatible:
+        items:
+          - enum:
+              - fsl,mpc885-scc-qmc-hdlc
+              - fsl,mpc866-scc-qmc-hdlc
+          - const: fsl,cpm1-scc-qmc-hdlc
+          - const: fsl,qmc-hdlc
+
+      fsl,framer:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          phandle to the framer node. The framer is in charge of an E1/T1 line
+          interface connected to the TDM bus. It can be used to get the E1/T1 line
+          status such as link up/down.
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              not:
+                contains:
+                  const: fsl,qmc-hdlc
+        then:
+          properties:
+            fsl,framer: false
+
     required:
       - reg
       - fsl,tx-ts-mask
@@ -155,9 +181,13 @@ examples:
 
         channel@19 {
             /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
+            compatible = "fsl,mpc885-scc-qmc-hdlc",
+                         "fsl,cpm1-scc-qmc-hdlc",
+                         "fsl,qmc-hdlc";
             reg = <19>;
             fsl,operational-mode = "hdlc";
             fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
             fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
+            fsl,framer = <&framer>;
         };
     };
-- 
2.41.0

