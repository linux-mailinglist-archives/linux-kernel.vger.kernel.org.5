Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943B57BA3B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbjJEP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjJEP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E83158F9;
        Thu,  5 Oct 2023 06:57:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB11C4AF6B;
        Thu,  5 Oct 2023 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696511860;
        bh=FvFYza5x9SIIDMnc6LuiyfJJi2ON+p3o+hoKtpoSL5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qi5hmaZIDtPlhx2c4ALDQ6HJp7a6DS5QaACOaPvXm9Peip64ktVO7rkq7sY2CqBLH
         3jhSX7WGpwuu/CeP5gJMMec9URMsQS1vHw+aeLnGPuQMN5OPgiQe7H1/q2Q+FcGCVA
         tPpIPk780sm0c0ffpNso4bodCzRqQs5DO7KygBy4di0vd8D5FUfdH71YXKpgdSQ2PF
         l9wNoJRynwa13m9nISzrrenPgZINkDcbosYmPMdpKfuyWIBK37dCoJ0FZyBf8Z3mfZ
         d8DzQCpSkWnppxRoKJ8+qoJRNkZw2wIXuqT65slTyuz+SpqEeZa4T+TE+R9IKYDYS9
         jqDcq92N4O8Qw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: pwm: Add T-HEAD PWM controller
Date:   Thu,  5 Oct 2023 21:05:18 +0800
Message-Id: <20231005130519.3864-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231005130519.3864-1-jszhang@kernel.org>
References: <20231005130519.3864-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used
to control the LCD backlight, fan and so on.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pwm/thead,th1520-pwm.yaml        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
new file mode 100644
index 000000000000..e75d8e9f24c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/thead,th1520-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 PWM
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
+    const: 3
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
+        #pwm-cells = <3>;
+    };
-- 
2.40.1

