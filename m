Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782997B237F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjI1RPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:15:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFCCE5;
        Thu, 28 Sep 2023 10:15:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81242C433D9;
        Thu, 28 Sep 2023 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921300;
        bh=kPaMMTfGtPFnEBE78lki4GvEmVbGnWmgp2jahe8ssow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRIO/tqPvZZaLyfasZtL28uvq5784eqAJZHcQYoLpV/QWRMlqYEZPmusgmDFmcur/
         CySTWyS6IQMcCj1MMI8ET0MKNq9W0t/1YMHDLjBKHWJRjMNHjISuSAItaLEO3rSp14
         BIPx0K6rTDH87+f6C2DJtRvJ8fOnvuGb97qCl8SaaZDFH9aamtbJ2FQFtK6thH6S55
         y5G+Yo82NsmELSWy/pWHcVr2+qR+rSZtUeal/kObh9B2z9/UK/L4KvK/OHScqLKKnX
         kYXsuk3igncpknX7/H46rJALXCnpnD3MWNlSF6QsU1SCCt2T4WZTgA6M8aV1ss1AQS
         SF9IVmNxLclZQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: pwm: Add T-HEAD PWM controller
Date:   Fri, 29 Sep 2023 01:02:53 +0800
Message-Id: <20230928170254.413-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230928170254.413-1-jszhang@kernel.org>
References: <20230928170254.413-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used
among other things to control the LCD backlight, fan and so on.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-thead.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-thead.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-thead.yaml b/Documentation/devicetree/bindings/pwm/pwm-thead.yaml
new file mode 100644
index 000000000000..8a7cf7129321
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-thead.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-thead.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD PWM
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - thead,th1520-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+
+    pwm@ec01c000 {
+        compatible = "thead,th1520-pwm";
+        reg = <0xec01c000 0x1000>;
+        clocks = <&clk 1>;
+        #pwm-cells = <2>;
+    };
-- 
2.40.1

