Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40FD760F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGYJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGYJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:40:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFDC1;
        Tue, 25 Jul 2023 02:40:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668730696a4so2947790b3a.1;
        Tue, 25 Jul 2023 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690278040; x=1690882840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jtmgg1Ul52XyBeA44Um0gDLsoyDM5m9GSMdFf61R4o=;
        b=TjBnxI1H4mPYSC/luID974TQJUoerHRcbkMmbUBrfOl06tSJ2z1jze7+VHCyydasfc
         grrNHXhCjqlxmPEXv2fg0R8CgTeaAdEQcB/+MVmJDrPb4/POKyDF7qBOOyxHkWrIz89E
         iiK0hurojvVndZfzhAnnAxgM32FNcV/RM2ZDfwpj0hysq6oDkgZDSAVfkvAi1sLAMRwR
         ZNsdldfQGcHe/NpleP7Xp1QoR0fYO0vhcFIgHoD5E5IF/47iRRfbvcP3tPemi9YW+C0x
         Cyx2KOobjKT9CFgICQsvmBFtcMEbSrQgT9rcMfDhD97zOPhw3cIV1X/hf/F/COzDJIuk
         y2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278040; x=1690882840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jtmgg1Ul52XyBeA44Um0gDLsoyDM5m9GSMdFf61R4o=;
        b=SG3mBzoFsq/gtN+SodbS8J1sUf3RbxbYgm1SjwywssXOx4spdLAb03a4DBqWu58FrO
         4dozVEmyVUXpPc+x1jncOv6qU4u06Uga3XfrGDh80KTOcPeH68s/U5FhZkzhdiK5MHez
         2puWNXYy903S7kX6NZUZgmWWj2bh+n8QCrlFDDyC5bAfW701zXl3UXN27xcjqpFk7OCP
         PXPc4dY2Hp/F4W0qJPGleMMF0eKFYH3sC9k/qSdtiQH0ZExv/wQqyCv68FS0DveGWG64
         GXAU7tDpqFkiKcqb7vV7CGaUiuqTiDQ12SmqcY2HOhwCCc8R8hUgkyPksTN832cE8L1I
         5hYQ==
X-Gm-Message-State: ABy/qLa27e5Xa1RN2ZJB/wfvODCsyd4NefYtuFSN3jaG3A1fA72nRvQC
        SmMEIpCemOGVZiUf3S8ythY=
X-Google-Smtp-Source: APBJJlFaZleiC0lP8KIns1t7a+vAaiVfELM/adM4AwdT65RfuXj3FIo5olSLXatRA9kENM0O49l/3g==
X-Received: by 2002:a05:6a20:7d87:b0:10f:f672:6e88 with SMTP id v7-20020a056a207d8700b0010ff6726e88mr13581013pzj.4.1690278040274;
        Tue, 25 Jul 2023 02:40:40 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm9121132pff.219.2023.07.25.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:40:40 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2 1/3] dt-bindings: rtc: Add Nuvoton ma35d1 rtc
Date:   Tue, 25 Jul 2023 09:40:28 +0000
Message-Id: <20230725094030.32877-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725094030.32877-1-ychuang570808@gmail.com>
References: <20230725094030.32877-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation describing the Nuvoton ma35d1 rtc controller.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
new file mode 100644
index 000000000000..5e4ade803eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,ma35d1-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Real Time Clock
+
+maintainers:
+  - Min-Jen Chen <mjchen@nuvoton.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    rtc@40410000 {
+        compatible = "nuvoton,ma35d1-rtc";
+        reg = <0x40410000 0x200>;
+        interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk RTC_GATE>;
+    };
+
+...
-- 
2.34.1

