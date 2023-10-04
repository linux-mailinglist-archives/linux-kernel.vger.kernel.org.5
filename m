Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA47B83EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbjJDPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJDPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:43:58 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761EABD;
        Wed,  4 Oct 2023 08:43:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af5fda8f6fso1506294b6e.3;
        Wed, 04 Oct 2023 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434235; x=1697039035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2EWhyzfVF0SlezT75W8p2BMfVzvHlK5TEMrrV+47aA=;
        b=MjxyCQxwEcFAAyRNO1QPHonIpp3UW393FmR724nIzEbV/9m+ReOiCIE2n621QJHKfS
         KPgLRl8FLlQUcdD+oAhazJozqpqDJKCn5fR5zIUPc+KS2Fs+7xDhkcljHWqWwGxA6GUe
         9G9cXIuT4uTyfv7bjjnndCjpUwfHKMMYm+J8XW9qLIyC76d6w1AknKnzi0zlanZ7ac1L
         9NlcpTEkmMIF8SWxl76bLVhdoj02EuxCqgN6dHGo3oVkkbmPKuKZxzmfN+7FCvgRJf7t
         HAQj8sjObXzg9izh4sWlyWiT3BHs5AkLexl7p0IcxVl39RN3paI0uHQRBeCGij9lkA+x
         LYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434235; x=1697039035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2EWhyzfVF0SlezT75W8p2BMfVzvHlK5TEMrrV+47aA=;
        b=j6f7utBMKTfP7DdPGNnlpeuqn8Ko/PO6Y6Jf3BzviwjdUHNd/jbgd860SvkMQWP9o8
         q2YWSVnBBJhB/hc5ay2HI/7g+VW2BZfCousaBI5ud6mZkh0XBFcz/MGBBAAT9c6SkMi2
         ARQUbCyrUrEbb4X8lBJs5Nq13cgwI3zA4JDw2oVWH1nlrDdaf5US6ZLRpjqxvzUfg4HP
         GyWiedcrhyZURC6wmzgpKiiB2gEdg+KxKN/sJevhs+/QJgnAmBjdU0PU4TZafjLFwUVY
         mSKRIy0JYSJX1xBrpetJoBqgfU2iKz0fimJ05SCxfeoUq2Q/0NyMXCQOnadjcHs6US57
         sOGw==
X-Gm-Message-State: AOJu0YxyOHLICfeOfIusPAwBgrN5mKaJGGUzlES7sg/4a5f903blkpa3
        Ic4+MEPPxxskwEwMNMFT0no=
X-Google-Smtp-Source: AGHT+IGwkJtwzLLVYekkJ9/PQRsEmxCyJwvLSlS+rvJ2gPE/qFblO0doSz/FckJv67w4WvQe5Y+C6Q==
X-Received: by 2002:a05:6808:9a2:b0:3ad:f6ad:b9d2 with SMTP id e2-20020a05680809a200b003adf6adb9d2mr2679866oig.16.1696434234754;
        Wed, 04 Oct 2023 08:43:54 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s14-20020a05680810ce00b003af5f6e40d7sm537597ois.15.2023.10.04.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:43:54 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 07/10] dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
Date:   Wed,  4 Oct 2023 23:43:47 +0800
Message-Id: <1f6b82a1864477a51db33d3f295889ff985b497b.1696433229.git.unicorn_wang@outlook.com>
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

Add new vendor specific compatible strings to identify mswi of sg2042
clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../thead,c900-aclint-mswi.yaml               | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
new file mode 100644
index 000000000000..065f2544b63b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-mswi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo sg2042 CLINT Machine-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2042-aclint-mswi
+      - const: thead,c900-aclint-mswi
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
+    interrupt-controller@94000000 {
+      compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
+      interrupts-extended = <&cpu1intc 3>,
+                            <&cpu2intc 3>,
+                            <&cpu3intc 3>,
+                            <&cpu4intc 3>;
+      reg = <0x94000000 0x00010000>;
+    };
+...
-- 
2.25.1

