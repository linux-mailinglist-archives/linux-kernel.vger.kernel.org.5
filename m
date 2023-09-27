Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2347B03BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjI0MRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjI0MRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:17:07 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326519A;
        Wed, 27 Sep 2023 05:17:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1384065|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.302725-0.000405716-0.696869;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=30;RT=30;SR=0;TI=SMTPD_---.Upkf3CJ_1695817013;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Upkf3CJ_1695817013)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 20:17:01 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        shumingf@realtek.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, harshit.m.mogalapalli@oracle.com,
        liweilei@awinic.com, yang.lee@linux.alibaba.com,
        u.kleine-koenig@pengutronix.de, yijiangtao@awinic.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH V5 2/8] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Date:   Wed, 27 Sep 2023 20:16:28 +0800
Message-ID: <20230927121634.94822-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927121634.94822-1-wangweidong.a@awinic.com>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add a DT schema for describing awinic aw87390 audio amplifiers.
They are controlled using I2C.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/awinic,aw87390.yaml        | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw87390.yaml

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml b/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
new file mode 100644
index 000000000000..ba9d8767c5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/awinic,aw87390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic Aw87390 Audio Amplifier
+
+maintainers:
+  - Weidong Wang <wangweidong.a@awinic.com>
+
+description:
+  The awinic aw87390 is specifically designed to improve
+  the musical output dynamic range, enhance the overall
+  sound quallity, which is a new high efficiency, low
+  noise, constant large volume, 6th Smart K audio amplifier.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw87390
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  awinic,audio-channel:
+    description:
+      It is used to distinguish multiple PA devices, so that different
+      configurations can be loaded to different PA devices
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - awinic,audio-channel
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@58 {
+            compatible = "awinic,aw87390";
+            reg = <0x58>;
+            #sound-dai-cells = <0>;
+            awinic,audio-channel = <0>;
+        };
+    };
-- 
2.41.0

