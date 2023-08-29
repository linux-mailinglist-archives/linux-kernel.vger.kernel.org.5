Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211978C458
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjH2MgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjH2Mfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:35:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11DC5C9;
        Tue, 29 Aug 2023 05:35:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxuOgg5u1ktcIcAA--.23054S3;
        Tue, 29 Aug 2023 20:35:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCMb5u1kE3dmAA--.31948S3;
        Tue, 29 Aug 2023 20:35:43 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] gpio: dt-bindings: add more loongson gpio chip support
Date:   Tue, 29 Aug 2023 20:35:23 +0800
Message-Id: <20230829123524.17291-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230829123524.17291-1-zhuyinbo@loongson.cn>
References: <20230829123524.17291-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCMb5u1kE3dmAA--.31948S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
dt-bindings support in yaml file.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/gpio/loongson,ls-gpio.yaml       | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
index fb86e8ce6349..cf3b1b270aa8 100644
--- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
@@ -11,9 +11,22 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - loongson,ls2k-gpio
-      - loongson,ls7a-gpio
+    oneOf:
+      - enum:
+          - loongson,ls2k-gpio
+          - loongson,ls2k0500-gpio0
+          - loongson,ls2k0500-gpio1
+          - loongson,ls2k2000-gpio0
+          - loongson,ls2k2000-gpio1
+          - loongson,ls2k2000-gpio2
+          - loongson,ls3a5000-gpio
+          - loongson,ls7a-gpio
+      - items:
+          - const: loongson,ls2k1000-gpio
+          - const: loongson,ls2k-gpio
+      - items:
+          - const: loongson,ls7a1000-gpio
+          - const: loongson,ls7a-gpio
 
   reg:
     maxItems: 1
@@ -49,7 +62,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     gpio0: gpio@1fe00500 {
-      compatible = "loongson,ls2k-gpio";
+      compatible = "loongson,ls2k1000-gpio", "loongson,ls2k-gpio";
       reg = <0x1fe00500 0x38>;
       ngpios = <64>;
       #gpio-cells = <2>;
-- 
2.20.1

