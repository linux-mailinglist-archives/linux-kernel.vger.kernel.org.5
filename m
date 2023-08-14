Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE977BE75
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjHNQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjHNQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCDE63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so7405403e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032027; x=1692636827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Po0Cjg3C1rN8c8fqj5mDXBBf8xDUIggifQYVVJsMcc=;
        b=w1UOXqObfAMFLB09Q3Lt0JtqeCqRPT+N1r45p8TTwa2i7mO/Mao97+9nAb9dVm2U/v
         Orpd/BBvtlV3q64+IGHchVfWwiampHYMLasI40yjng22tREwD3Jg9HByAsqi0YiX7AbZ
         5vT0qlGfoXRvwrUy5O0g+un4qDeKBh4QSxxt9v36BfJJxYHti+0Fzm/FqnuaLFy21Sln
         E3VloSEgymvE0rjAnqsjY4PUidQWf/0fmL1+mqJQeOB069PhvQvhcIp6BUjUwqou71Cj
         xbvC+ptXGT4RXYBQRSshT4Mffp55/J5z4EyhasTgdZSVP/zEmPR1x95QT8AG10y4uD8n
         YC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032027; x=1692636827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Po0Cjg3C1rN8c8fqj5mDXBBf8xDUIggifQYVVJsMcc=;
        b=Xry8vgbHx0j9T9dAuT3gt0B/dlg/HTKzlrBILAo6EPkxwJ3rQSevbuYrkT+nHo00zr
         2VERPosz9g0jVRjSk6d+Fof9dwvqAhlvkGksbdogmfEsjbEQHflyS5GZbla36RMQbA5T
         zKXVrdO+Wc0SZTh8A2G1L3RXqzG6I9MJn7GA+47jlzZs9S4LqILG2w0XMX/A/i7cc8qg
         BMqFgfAsMClMRwn0YkP7WJ/W0SOT7RLZNX7k0vk1WU8kZbXlrm4FPx5oYPgi/BIe5B38
         +pdwTNAYqOiFmmnkog1X61J0Y74YCv0c7+tMDqkxvBP6Lr0KsVLC8WfbvSYEr+KQPL/+
         J9cA==
X-Gm-Message-State: AOJu0YzbmoXRq9nCXGAz0LOkKNqiL95nRX/mLCj0sh6Hpa6Qul8vHAcI
        GMp2uZhp2z9YPMIyrsUfF4+O25JvC3M/wp4MxuA=
X-Google-Smtp-Source: AGHT+IGusrJFCkBPfUoi53ILIV1GM0b/yC1BFXTxqypKDFQ9JxC2/hW2S+04/h7QFOMbGwbwnP8T2w==
X-Received: by 2002:a05:6512:1295:b0:4fe:7df0:41ab with SMTP id u21-20020a056512129500b004fe7df041abmr7897013lfs.17.1692032027443;
        Mon, 14 Aug 2023 09:53:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Richard Alpe <richard@bit42.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
Date:   Mon, 14 Aug 2023 17:52:41 +0100
Message-Id: <20230814165252.93422-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Alpe <richard@bit42.se>

Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.

Signed-off-by: Richard Alpe <richard@bit42.se>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
new file mode 100644
index 000000000000..df826b40d8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ eFuse support
+
+maintainers:
+  - Richard Alpe <richard@bit42.se>
+
+description:
+  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: fsl,t1023-sfp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@e8000 {
+        compatible = "fsl,t1023-sfp";
+        reg = <0xe8000 0x1000>;
+    };
+...
-- 
2.25.1

