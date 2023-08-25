Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29932788293
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjHYIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjHYIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECEF2118;
        Fri, 25 Aug 2023 01:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C552467515;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E52EC433CA;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692953024;
        bh=oBoRKFjVyni9Ea4krJclsUMLSRnqH1PsiC8kmB3XndY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=LR6gzN7bf3PXdS7QVJQBC/9sPWnRvb50mDo/dIi65SIpDVmG3K7sPt85RxJWQPMDT
         OcJZ3X65L2FauWy6akFwidXB98y5WXj18dWIUD/hI6eLpmD2HSXDKNdJ913PKrAls7
         ruz+/R1WHvbYIp22xQfrVis0XY5DDYhL23YAKINxD8yZumAS4Bf1ycNmfdZFsbHmp3
         y3HYOL6U7voY2n9/SWXmRkUViAvWoCGQvFA4MKjbpMm8fqOHMesjz+SbGXtrprWPMw
         kjqtiEk2xSuPA6Y+XYiCMuwaptY6/+3rNZUDoslXbsIfSTZ2VpU9eM9b9AkIeBmJHV
         YnOG/Lk71b+Qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02EC3DA6F;
        Fri, 25 Aug 2023 08:43:44 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 25 Aug 2023 11:43:25 +0300
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add ST M48T86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-m48t86_device_tree-v2-1-21ff275f949d@maquefel.me>
References: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
In-Reply-To: <20230823-m48t86_device_tree-v2-0-21ff275f949d@maquefel.me>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692953023; l=1415;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=MnFLUVNbKTyfZ50U0UaB3bgdv9grXe+OsjVQV5/9QnA=; =?utf-8?q?b=3DLVnK3jIdYHtY?=
 =?utf-8?q?hQ3q83ARey1BgIv2Hx+r3atUv8MPpTSm8UfB/QWN+DKaalJjZLk4kAUWxvNk6uJq?=
 sQOt5Nr3BYuZXkJKNVQQFlKwAaeGH12su8puRDMKqPxfQOvaJM2n
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/lkml/61b9e036-7864-65c6-d43b-463fff896ddc@linaro.org/
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/rtc/st,m48t86.yaml         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/st,m48t86.yaml b/Documentation/devicetree/bindings/rtc/st,m48t86.yaml
new file mode 100644
index 000000000000..e3e12fa23380
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/st,m48t86.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/st,m48t86.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST M48T86 / Dallas DS12887 RTC with SRAM
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: rtc.yaml
+
+properties:
+  compatible:
+    enum:
+      - st,m48t86
+
+  reg:
+    items:
+      - description: index register
+      - description: data register
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@10800000 {
+      compatible = "st,m48t86";
+      reg = <0x10800000 0x1>, <0x11700000 0x1>;
+    };
+
+...

-- 
2.39.2

