Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D37AF91E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjI0EOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjI0EN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:13:26 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FC768E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:40:17 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id lH7JqXfBMbK1VlLPMqE78J; Wed, 27 Sep 2023 03:40:16 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id lLPKqhTioRWADlLPLqOqXj; Wed, 27 Sep 2023 03:40:16 +0000
X-Authority-Analysis: v=2.4 cv=YsAc+qUX c=1 sm=1 tr=0 ts=6513a420
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=CKMxHAookNUaJbGn3r6bzg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=zNV7Rl7Rt7sA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=gEfo2CItAAAA:8
 a=Qu2vfR6uo-DFy1VMMD0A:9 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lzpfUKeOlMjR4u8RI1mQy7KKH3egOPPROjgjVulaF8Q=; b=H72hZSSTuZh6Ui1BBqvrgG7yHF
        CPn3wbIacGqsGbTLcepoVMWige5PXe+g516or9oimXoCM5pva1ggBNAL1b3aGkPYILukTQ2PNbVDp
        JQ0wFYubiBpbxdeZ2RyQVthxnLt2yy4MVQAuacL2ergEqWAyjHNwrF5jW1hLGeKmB97ZSSaBFL3PZ
        kVSt0826727Uv4NF0Nu668celgiB/stYQ6a5hz0Uoj/Op4qSfQsnxKPWYR7E77RGAcTcvtOYeEtFO
        sUL9pJP3Kf6S6UcwYhzeed7LNs06owTWPtRNY+Q0DBGdqLYxK5FeRhRuUXmCeY+LybrQF1FpzdwEd
        lZxk7e2A==;
Received: from [103.163.95.214] (port=59728 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <saravanan@linumiz.com>)
        id 1qlLPJ-000tFx-29;
        Wed, 27 Sep 2023 09:10:13 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 2/3] regulator: dt-bindings: Add mps,mpq2286 power-management IC
Date:   Wed, 27 Sep 2023 09:09:52 +0530
Message-Id: <20230927033953.1503440-3-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033953.1503440-1-saravanan@linumiz.com>
References: <20230927033953.1503440-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.163.95.214
X-Source-L: No
X-Exim-ID: 1qlLPJ-000tFx-29
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.163.95.214]:59728
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 25
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP7kVjoVOvLA/PWt08+3XpSj+L3whP1zaaccXRMkpAz5MbszRgYmyZaGcyhamhYe7HYAzXGfXO+kSmKEwi48M057BHCQ5IumY9eJDBEjnUNPwOjdY3Nt
 /ZG8TJwW1Z2srevBfOndByZD9SJJ6dOPHhBGbzwXyLEBIY19iI8OQYPKVIXia86CYw3z8txsUHirIV+v1wl2jFoCzyWWKN5aUuY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document mpq2286 power-management IC

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
new file mode 100644
index 000000000000..594b929fe4b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ2286 PMIC
+
+maintainers:
+  - Saravanan Sekar <saravanan@linumiz.com>
+
+properties:
+  compatible:
+    enum:
+      - mps,mpq2286
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      buck0:
+        type: object
+        $ref: regulator.yaml#
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3 {
+            compatible = "mps,mpq2286";
+            reg = <0x3>;
+
+            regulators {
+                buck0 {
+                    regulator-name = "buck0";
+                    regulator-min-microvolt = <1600000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
+...
-- 
2.34.1

