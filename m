Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F07BC5D1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjJGHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjJGHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:55:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C3B9;
        Sat,  7 Oct 2023 00:55:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c4c594c0eeso1943085a34.0;
        Sat, 07 Oct 2023 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665306; x=1697270106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryYe+4hTs/lT5K6FlfyObupupFe/pcvu0b9Q5/wUL1M=;
        b=ZNUUriHe+8eJFi5oTUiWyE4jGvPD0cRVU/Qa+r0b87XK76VQA7ITbcptxGgfs1AS3o
         miuJKJWAZ9eK5WUZzyf/9SqdpaVbOmIHGpQjvc2hKEtVN4QrSaGouuCT5JB5u8A3ToI4
         ZXpmdbl2yXxS0GFbHE5u8ZbSiclifw/DW8hjYwz4KED6hbX8VPK60OAMnsZ4YRHmzC5F
         1W7HsgjY61lqAcFKXn9GLfyowIPOB9ImeoTScKQDglgZoWFD0qPkjqchKdSuoSuXx6+L
         1DbekN0bw9rxnxG5imxfcilVNbGPuVm3vcSMs+vnzoDMf/7Ymtl1ikVuS8AG21tXfjSO
         S8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665306; x=1697270106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryYe+4hTs/lT5K6FlfyObupupFe/pcvu0b9Q5/wUL1M=;
        b=ZrOvNuHVLipoQM6SYcu8GF87IeBIlAD6SNiAB5TAtbbnEk3mv8kKLka4nCZxV+wU8A
         xGk2MA2zErG9yIdXMys2V3EL3belFUxXhABNG191XzuNPcoX3g6nMoBZKRS6I5eRJJMd
         nIa51iGCXgv899/ojwm2SbmQyaakySP3rYqsCt6L1dwVrRhygFLMLWErC6/xCo9fA2aG
         wftimaHG8+FpRwdp70FEP/6L3NWsTTaZvQ4SdW509gSb9TOVdYtSoBStcmA2wMkOEXPS
         vh1yFnms3kA9XH3wngV0I9tO+vK7PvEDKPLvwrZ1loRNuvwEsNToqIUG8FsBanD3Z+B7
         thAg==
X-Gm-Message-State: AOJu0YwWGTU5MLDSqnEnEEbeO9UMpPLn/+ti9BpkkIfqUtEiPyP4Yhir
        allUrBxYaD4Mn5fwQ+vCvGc=
X-Google-Smtp-Source: AGHT+IG0oGie2gn1UZAZKInf1Muw6xUGB/yyMzA0RALsvPDE58pt/DOR+AOGCHdfPBUuqoth2Xt6gg==
X-Received: by 2002:a9d:638f:0:b0:6c0:ef3c:5ab4 with SMTP id w15-20020a9d638f000000b006c0ef3c5ab4mr11091996otk.0.1696665306434;
        Sat, 07 Oct 2023 00:55:06 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id l6-20020a0568301d6600b006ba864f5b37sm830853oti.12.2023.10.07.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:55:06 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 03/10] dt-bindings: riscv: add sophgo sg2042 bindings
Date:   Sat,  7 Oct 2023 15:54:59 +0800
Message-Id: <230fa937009078bfda56a2f84392d20b848d9944.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add DT binding documentation for the SOPHGO's SG2042 Soc [1] and the
Milk-V Pioneer board [2].

Link: https://en.sophgo.com/product/introduce/sg2042.html [1]
Link: https://milkv.io/pioneer [2]

Acked-by: Chao Wei <chao.wei@sophgo.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
new file mode 100644
index 000000000000..8adb5f39ca53
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SoC-based boards
+
+maintainers:
+  - Chao Wei <chao.wei@sophgo.com>
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  Sophgo SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - milkv,pioneer
+          - const: sophgo,sg2042
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..97cb8abcfeee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20063,6 +20063,12 @@ F:	drivers/char/sonypi.c
 F:	drivers/platform/x86/sony-laptop.c
 F:	include/linux/sony-laptop.h
 
+SOPHGO DEVICETREES
+M:	Chao Wei <chao.wei@sophgo.com>
+M:	Chen Wang <unicorn_wang@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
+
 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.com>
-- 
2.25.1

