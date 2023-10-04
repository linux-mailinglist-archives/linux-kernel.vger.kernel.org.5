Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5E7B83EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbjJDPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbjJDPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:43:40 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC3BD;
        Wed,  4 Oct 2023 08:43:37 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57bc2c2f13dso1275490eaf.2;
        Wed, 04 Oct 2023 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434216; x=1697039016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHNexQjEWqwmHrfiry0buaBQbrLt3wpcuExz+BRupW0=;
        b=RGe8Bj3soUScS1IDg7Le2LCbewwmiNWE7lvQbnc9vCjDPGqPrj9aaHVS2wE4GNqS5/
         3tVlRf/0gI7WwYmi0861fSM0D+G5FECU4pe3Cuj2F/aN0nXbA++odzkBLO3zRQSQXnKR
         ABoOF0HmmbSaUC/ThPS0GKA4Ac2t0Lz0WeGkN5gjMnU0dfRxSgt5rYuzQsc+5jvVK1x8
         0JVPLwuHTku0YTmVHiMQQdoaPGFARNFLzcHwdr5PpR3nszs40aZgodUZtlm9s2mx7uUh
         SaApmmsPrKvf4ZCHGJefa8iopTk+9BeIscPnMybBxDjDV7yhWM4doDwrkOL3wf44P3ZZ
         ASng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434216; x=1697039016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHNexQjEWqwmHrfiry0buaBQbrLt3wpcuExz+BRupW0=;
        b=WebXiz4fqxYH6Ocj6swYb4NVQbdPWDlao4RC46xWsQHfgjn7NmStt69SJAH2fOgBqT
         oMK6rkjKoGpFRdPxZFbfRmhWTlHa51fdZBCClawoA25a/WZQI7eteKYoutG+v/NU1ICo
         B4rJbZg7HcxcqWABA4ArV5uPIlr6Eu3fa0D8Hi0OVMwE0WKYERbcJsNoy9swmp04tVmu
         a4rdwfw3CGcQzUw0V8SoNnh3NPC9+gxLfG+TfAbUT95BSsyfcvSYdRsA5JnuiIAv3BSZ
         rB05nrHmiB6XwYqPy616qZiVDQgN1z8WFqbtO8NlgAWEfdv8in/n+Q6NwCD8oGvowQwp
         1HRA==
X-Gm-Message-State: AOJu0YzKCSN+U57xxYM/5jP2vA7BbuxCsj3BMNtEzBDsCTEsQ9N643zu
        +//l4NDcvARr/lVcGJ3GaN0=
X-Google-Smtp-Source: AGHT+IF6r0Nf92b8yMVSXzfb//2cKp9M6wexeSeiIG3LAk4U7LnHo3090pI0Juj4ICyo7zS2BWchyQ==
X-Received: by 2002:a4a:d2dc:0:b0:571:1a1d:f230 with SMTP id j28-20020a4ad2dc000000b005711a1df230mr2546119oos.9.1696434216397;
        Wed, 04 Oct 2023 08:43:36 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id m1-20020a4aab81000000b00573fb6178a6sm654637oon.44.2023.10.04.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:43:36 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 06/10] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Wed,  4 Oct 2023 23:43:28 +0800
Message-Id: <6e48cbe5e60f9ada2fd1fe58e803e127f1a678e5.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inochi Amaoto <inochiama@outlook.com>

The clint of Sophgo's sg2042 is based off IP designed by T-HEAD, but
Sophgo changes this IP layout to fit its cpu design and is incompatible
with the standard sifive clint. The timer and ipi device are on the
different address, and can not be handled by the sifive,clint dt-bindings.

If we use the same compatible string for mswi and timer of the sg2042
clint like sifive,clint, the DT may be like this:

mswi: interrupt-controller@94000000 {
	compatible = "sophgo,sg2042-clint", "thead,c900-clint";
	interrupts-extended = <&cpu1intc 3>;
	reg = <0x94000000 0x00010000>;
};

timer: timer@ac000000 {
	compatible = "sophgo,sg2042-clint", "thead,c900-clint";
	interrupts-extended = <&cpu1intc 7>;
	reg = <0xac000000 0x00010000>;
};

Since the address of mswi and timer are different, it is hard to merge
them directly. So we need two DT nodes to handle both devices.
If we use this DT for SBI, it will parse the mswi device in the timer
initialization as the compatible string is the same, so will mswi.
As they are different devices, this incorrect initialization will cause
the system unusable.

There is a more robust ACLINT spec. can handle this situation, but
the spec. seems to be abandoned and will not be frozen in the predictable
future.

So it is not the time to add ACLINT spec in the kernel bindings. Instead,
using vendor bindings is more acceptable.

Add new vendor specific compatible strings to identify timer of sg2042
clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../timer/thead,c900-aclint-mtimer.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
new file mode 100644
index 000000000000..fbd235650e52
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/thead,c900-aclint-mtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CLINT Timer
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2042-aclint-mtimer
+      - const: thead,c900-aclint-mtimer
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    timer@ac000000 {
+      compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+      reg = <0xac000000 0x00010000>;
+    };
+...
-- 
2.25.1

