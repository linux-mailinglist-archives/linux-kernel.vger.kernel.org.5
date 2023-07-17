Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1775622C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGQL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGQL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:59:00 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959EE6;
        Mon, 17 Jul 2023 04:58:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1517805|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.325954-0.000438573-0.673608;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.TvogKzJ_1689595133;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.TvogKzJ_1689595133)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 19:58:53 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.co,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
Subject: [PATCH V1 5/5] ASoC: dt-bindings: Add schema for "awinic,aw88261"
Date:   Mon, 17 Jul 2023 19:58:45 +0800
Message-ID: <20230717115845.297991-6-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717115845.297991-1-wangweidong.a@awinic.com>
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add a DT schema for describing Awinic aw88261 audio amplifiers. They are
controlled using I2C.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 .../bindings/sound/awinic,aw88261.yaml        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw88261.yaml

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88261.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88261.yaml
new file mode 100644
index 000000000000..a0f3e3418c1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88261.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/awinic,aw88261.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW88261 Smart Audio Amplifier
+
+maintainers:
+  - Weidong Wang <wangweidong.a@awinic.com>
+
+description:
+  The Awinic AW88261 is an I2S/TDM input, high efficiency
+  digital Smart K audio amplifier with an integrated 10.25V
+  smart boost convert.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw88261
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@34 {
+            compatible = "awinic,aw88261";
+            reg = <0x34>;
+            #sound-dai-cells = <0>;
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.41.0

