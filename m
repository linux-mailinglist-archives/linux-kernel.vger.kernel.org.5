Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738827853AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjHWJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjHWJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2449CE;
        Wed, 23 Aug 2023 02:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC73C65A0F;
        Wed, 23 Aug 2023 09:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B961C433C9;
        Wed, 23 Aug 2023 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692781412;
        bh=8fCdzcn2VcvnUQp2D6Fuk/QxfB3MwobNYAHefW+j36I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=DiwUuH5Xi6vpIS+dIGw3WmrIlUG7alGvSDvTvRo90RlmiGT2DFC7bxQmy/FSR4JqW
         VwLmnAR/+HB6NNq1A6gh92kLJ0b/fw2NFZ7mo1eNT2wBjOfecftAirU9z09kucnC3Y
         eYdHeiBy701XWVtyt6busWkyAeqBiMmJdubCmu4A5UBvA5wf+cm1eP59XpSWgG5DvV
         ApYFINdRqa9sqoghA+d7gmHYMD0tjj0Zch8bAl+9D9g3GPh8Va3GpL6cVwRRTqBDmt
         /+WvOOpPxqLX2ZxLDs5ToBEgie2zxct1A+kTF5FhWxqiNjhJVpQKftwM6iuE5gkeDL
         8gn1e6OyfsFHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DBE8EEE49B5;
        Wed, 23 Aug 2023 09:03:31 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 23 Aug 2023 12:03:14 +0300
Subject: [PATCH 1/2] dt-bindings: rtc: Add ST M48T86
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-m48t86_device_tree-v1-1-240023b435ac@maquefel.me>
References: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
In-Reply-To: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692781413; l=1263;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=y7M/fGH6tMQwq76PE+jI5ZilaSmr5fjvvIAr9uMS3jI=; =?utf-8?q?b=3D6ZM/ryKuE1kI?=
 =?utf-8?q?jbSn+grM9CJPE9556P+3Zkt0S3hhK6elKCVNruOuML8tlO/RAOBu70/OWOyP1gtw?=
 CRnSBYApBXosWIWOmiy3JHWSO2GWXUipnEjB5qKk1+Y7zKYwlaGO
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.

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

