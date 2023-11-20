Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC37F1946
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKTRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKTRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:06:13 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D5CD;
        Mon, 20 Nov 2023 09:06:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C04F9E0004;
        Mon, 20 Nov 2023 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700499968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e4jB34Kjsk2UhhZjV+mvo2m7UoKK5NW1KZZ6R6IxOQ=;
        b=cqDuf8RNFW1EIuNkivfh/7YHzcXWzE3RlLaDdCkEnyQgoOrbKlktlJzBPBcsgnzQZPwHTF
        qz4DTkmFhScyDDAHK9IMH8OKsOpHbWoKWa6zXy+jgSfFx/KlqsZ/ZuOsQZrtH+VOVbz6Yj
        lIo3gidp5cPwrxrR2Ng5s2CO4lWcoayR00h9GDgZTSrlHGwsZPeQdzXuVVDhCJ6Xrc2AQa
        zGclxzuN3hL7ZzQ61Y4rBO6C7SNfR9C1pDm/8KG+A5JPARYyP3+gwUiC4SZpW9n5H0MZw4
        sYRMW8mXzFYCQRAtifg6QcCYIaokeK5diiZbtPqVXQtKhqySHRPaLjsRit7OWw==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Mon, 20 Nov 2023 18:06:01 +0100
Subject: [PATCH v2 1/7] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231120-j7200-usb-suspend-v2-1-038c7e4a3df4@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
In-Reply-To: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Thomas Petazzoni thomas.petazzoni"@bootlin.com,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this platform, the controller & its wrapper are reset on resume. This
makes it have a different behavior from other platforms.

We allow using the new compatible with a fallback onto the original
ti,j721e-usb compatible. We therefore allow using an older kernel with
a more recent devicetree.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 95ff9791baea..69a222dfd9ff 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -12,11 +12,15 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - const: ti,j7200-usb
       - const: ti,j721e-usb
       - const: ti,am64-usb
       - items:
           - const: ti,j721e-usb
           - const: ti,am64-usb
+      - items:
+          - const: ti,j721e-usb
+          - const: ti,j7200-usb
 
   reg:
     maxItems: 1

-- 
2.42.0

