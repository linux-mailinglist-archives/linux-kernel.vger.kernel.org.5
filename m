Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE167702DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHDOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHDOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:22:12 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC811B;
        Fri,  4 Aug 2023 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691158932;
  x=1722694932;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=ZtJ3bXPIlnWx6DFOh5ulkUULF7Fw7PR66If1RP7R/hg=;
  b=CfrGpCHCJpc8pAY+rLwxgb+uUW0JUKfpreMO/OW6QuR8P0oY3Fh+mzH/
   AZt7mEiXbiHA7a7+mmhOL0RidGxfPaLW6Pf8zrhS9q6JVfB2lC8L3mXeB
   H8zYpfJd2bY8zAadXzL+Mak0JCzSfsuXB1A9TuTlU56XXC+JGAg80ztrL
   ljkEvttcKQIamiaZ2d8r5ibCCaHnLErU0OIEo2sdCCUrxhJNFTiNMh6Dw
   ZCbTLJtNuFDgFsW/Wd/X0aC69QCt/xLkxItFno+ZENSX6HMY2BHIijeix
   Mt7mScJxHL2puErzZkJW5OEl9d2jMhfVKYzDGNw+1QsCYQR1wAj4Aarek
   w==;
References: <cover.1691158774.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: rtc: Add Epson RX8111
In-Reply-To: <cover.1691158774.git.waqar.hameed@axis.com>
Date:   Fri, 4 Aug 2023 16:19:34 +0200
Message-ID: <864b398918e99773f6cbd5ffe5b1f0dc33e4d6d1.1691158774.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Epson RX8111 is an RTC with timestamp functionality. Add devicetree
bindings requiring the compatible string and I2C slave address (reg).

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../devicetree/bindings/rtc/epson,rx8111.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8111.yaml

diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8111.yaml b/Documentation/devicetree/bindings/rtc/epson,rx8111.yaml
new file mode 100644
index 000000000000..e6f077a32582
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/epson,rx8111.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/epson,rx8111.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Epson RX8111 Real-Time Clock
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description: |
+  RTC with timestamp functionality.
+
+  https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en
+
+properties:
+  compatible:
+    const: epson,rx8111
+
+  reg:
+    const: 0x32
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@32 {
+            compatible = "epson,rx8111";
+            reg = <0x32>;
+        };
+    };
+...
-- 
2.30.2

