Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B77F62F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbjKWP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346123AbjKWP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:27:19 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCD10D2;
        Thu, 23 Nov 2023 07:27:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AC7720003;
        Thu, 23 Nov 2023 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700753227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqcWJwc1AByHKusITSkSLKzXeuC6sREuOa9GwKxdEz4=;
        b=cA8gnk4c2ebNPLlE8xjCOmR+nRVjZEhrf0LPTWqZdJbEDnaMVSzbKN00sa5f52u0+4Gjzc
        NbemReqzCxWY/T8kRf2dw4W7qVw7g07Wz0LmzmXpMQMsOPRvoB2QpzFh6hrUZFuZlHifOp
        TxqLHM0rXC6PFF2AFVEKocSqPfe8RlZM1ZCvOFlsI7QyMgnbZg6thVFeKZU5eMdx821F+j
        EV8gSpmtJmzEi64NYyGaxNfApr2fkiPZd4vdEoF33ywDfJIyYYKtX1XQLNu3ZgYz28GuLT
        zCkVXL9fdf3yI2mePjZMU03utdaWzuRZDmmpsEg29BYvJosyXQCy0eFuW2TaGw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 16/21] dt-bindings: mips: Add bindings for Mobileye SoCs
Date:   Thu, 23 Nov 2023 16:26:33 +0100
Message-ID: <20231123152639.561231-17-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123152639.561231-1-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
supported

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/mips/mobileye.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml

diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Documentation/devicetree/bindings/mips/mobileye.yaml
new file mode 100644
index 0000000000000..5201cf19f43ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/mobileye.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye SoC series
+
+maintainers:
+  - Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+
+description:
+    Boards with a Mobileye SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+
+  compatible:
+    oneOf:
+      - description: Boards with Mobileye EyeQ5 SoC
+        items:
+          - enum:
+              - mobileye,eyeq5-epm5
+          - const: mobileye,eyeq5
+
+additionalProperties: true
+
+...
-- 
2.42.0

