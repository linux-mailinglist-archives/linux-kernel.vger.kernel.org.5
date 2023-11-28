Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28417FC8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbjK1Vr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjK1Vr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:47:56 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E998;
        Tue, 28 Nov 2023 13:48:03 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d7eca548ccso3449624a34.3;
        Tue, 28 Nov 2023 13:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208082; x=1701812882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tY859mgZuixEXsQXpxoxdofdHWsZ/aGJN72aWxxZ5dQ=;
        b=qXCDnFAZWQAmzBbgOS5s8g6UUc2mCDm/AXW/1mOWdbKPHbVDZwFaIEx+0rr4TzAGR7
         P7K5DIWyXlIr0KfY8KE/HSPkzaixwpzlZSEs+kGSejslAhsOGcx9XJ8zQjP9Y2G9IXkg
         2DJ0lPJVvmbdhWsVG0sscwwred8Rwy35zt//i4fCAyXwZO3X61AjYpD93E5fMlBBN6l8
         9ieWZcW7N0tuKnV7Br/k5+SDAZD0gSgwmea7TL/F48iNA8xPk1rdjI5jMz+d6bLRGth4
         QbVzapp6AadeGJvyfzTmlZp8pjqVxxBSQvA3hFaLGuOkwaOw66DE+uof2sdjdMe0CPAz
         oI/Q==
X-Gm-Message-State: AOJu0YyJSQmC9SgdLKX6F5CHuTi+yiOHsCg29cFAB8Syr9O0TWOhjz4c
        nLInS/j40mcrkJ/8kjbqg6PUORRRbQ==
X-Google-Smtp-Source: AGHT+IG3MhdI/KC/5pcMn9+h7mJSK+hnGWJUirDvj5cEw3pKREm4LBbTIwkWueAPZns7pEIbVfOTuQ==
X-Received: by 2002:a05:6870:248e:b0:1fa:1c89:c656 with SMTP id s14-20020a056870248e00b001fa1c89c656mr14173684oaq.56.1701208082608;
        Tue, 28 Nov 2023 13:48:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a056870385400b001fa2823dc13sm1930073oal.0.2023.11.28.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:48:01 -0800 (PST)
Received: (nullmailer pid 3975504 invoked by uid 1000);
        Tue, 28 Nov 2023 21:48:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: hisilicon,hi3660-reset: Drop providers and consumers from example
Date:   Tue, 28 Nov 2023 15:47:58 -0600
Message-ID: <20231128214759.3975428-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding examples should generally only cover what the binding covers. A
provider binding doesn't need to show consumers and vice-versa. The
hisilicon,hi3660-reset binding example has both, so let's drop them.

This also fixes an undocumented (by schema) compatible warning for
"hisilicon,hi3660-iomcu".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../reset/hisilicon,hi3660-reset.yaml         | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
index cdfcf32c53fa..e4de002d6903 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
@@ -50,32 +50,9 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/hi3660-clock.h>
-
-    iomcu: iomcu@ffd7e000 {
-        compatible = "hisilicon,hi3660-iomcu", "syscon";
-        reg = <0xffd7e000 0x1000>;
-    };
-
-    iomcu_rst: iomcu_rst_controller {
+    iomcu_rst_controller {
         compatible = "hisilicon,hi3660-reset";
         hisilicon,rst-syscon = <&iomcu>;
         #reset-cells = <2>;
     };
-
-    /* Specifying reset lines connected to IP modules */
-    i2c@ffd71000 {
-        compatible = "snps,designware-i2c";
-        reg = <0xffd71000 0x1000>;
-        interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-        clock-frequency = <400000>;
-        clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
-        resets = <&iomcu_rst 0x20 3>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
-    };
 ...
-- 
2.42.0

