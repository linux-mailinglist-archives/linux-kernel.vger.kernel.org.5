Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C754775038
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjHIBPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjHIBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:15:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6C19A8;
        Tue,  8 Aug 2023 18:15:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so40486105ad.3;
        Tue, 08 Aug 2023 18:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691543750; x=1692148550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpAcRisUyrskcWS9AV1ql1Z9KFMGwKdSa1ZIJWKbDtE=;
        b=Y+o78R/URs32r1pS7ksTcEFv//2BRTVRggUQkZSo36ouTaXxU1SiXWbmxGNMMrlmKr
         1cyLi7js8C9amqoFCUPXQUrl3ad0KLTCt2Frj/r7NbIJCVdCnLnFOM1h8Y6I17izvcp/
         zn8rzBr5SWhrg5gNP6v0f1N2HvuleGjhd0/v6yVRIQFufs6eCz5Yubz2HI0lQy2NyIGU
         CwOkG10vWYzjW5DzCoLE+QZtJOlR6vb9qN9iJvB/8/+X41SIlj+4g0ReEkW7bg2xgogf
         DilCh6w2RFjgoa/mNuKcDxD4lUmHJHstpuKmIFNnX4wkq6fI4SJ2WBqi5p2bD3V3fDks
         x/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543750; x=1692148550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpAcRisUyrskcWS9AV1ql1Z9KFMGwKdSa1ZIJWKbDtE=;
        b=SQEQsND3TQwvdRNyyDffdzeop7kwj514S5pp/aiRkWGHhkwzdZdBGZOoozxSEUOIbo
         ZcVJBpPmhOl2bjoSBYORbbB9cHGJ1toH3xuGgTt9xiTDj/jFxFVH15NffdEXYoT+m6hn
         ppzPJDFWq+S41OvsxuwWDbYs/iBarxrp/MEAGsR0UdDEOIjzf2/1RkYeuRKQyw8mWHJz
         h/Ig9n2ZmlK8y7w6N9Vc2Yozqh0Xx3WdHGved7vGWVmUD4xIyYp8Q9wO0OLXMRrVw4Qh
         3MnWe3JEd5BpZtg2ERJiGtGKKzkmVHTAUnPw6+qNoF/kwcT4sROSXukjGBpe83lrl7kX
         fufQ==
X-Gm-Message-State: AOJu0YxMiPog/Bxy/PqqYRn3wKvmF5pFHzu98cpM1g1Q1Pkhk6fFXHmO
        I98nCirDVYPnPSrKD1i5sPgpCFBIvns=
X-Google-Smtp-Source: AGHT+IGc564GPnpp2ZAgbOs+wh+yI70UOwt148b6UgsbAT88NsGzbYAwsKXCaqj84G2bdev6Sx2+0w==
X-Received: by 2002:a17:902:eccd:b0:1b8:2a4d:3eb9 with SMTP id a13-20020a170902eccd00b001b82a4d3eb9mr1151662plh.34.1691543750502;
        Tue, 08 Aug 2023 18:15:50 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm5730449plo.142.2023.08.08.18.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:15:50 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 1/3] dt-bindings: rtc: Add Nuvoton ma35d1 rtc
Date:   Wed,  9 Aug 2023 01:15:40 +0000
Message-Id: <20230809011542.429945-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809011542.429945-1-ychuang570808@gmail.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation describing the Nuvoton ma35d1 rtc controller.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

