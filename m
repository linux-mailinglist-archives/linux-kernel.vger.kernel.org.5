Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30787A72DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjITGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjITGiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:38:04 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABAAAD;
        Tue, 19 Sep 2023 23:37:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ade5687e97so903654b6e.1;
        Tue, 19 Sep 2023 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191878; x=1695796678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV+65pRBVYc+OiZ4eNCts7KcqWJoy+uloTJChETlmhw=;
        b=RV6sPU2nTo4EjyTIe0rvXiDIffom52dbFDrNMoDe/Iuenj2KmMq/gVog3DCVxcUH3L
         5/zxfxl85iAdxqT19Dk38qnN11l/ZRs1NvlYt6lRsdGC5fHYSgKT302MAs7lw4OUrxNF
         zY945MqWa1ys5b5oSB38q83IAijsCUCCoTf6DtUqBqrWVV7AAxh9O7A46qbIU9g+kCEz
         iiBCiinbYhQuZPDKY57nkCtVQD86j4LEDGqma8biEwrJkgYA7tbJh/jsPaVIEiWouMFy
         wcpiZDGxbouDyBCutxFDZCtZJuRGNQ+pvew5r3rnA1R1IC7XCsOUb957HC2hxvCtJzOn
         nt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191878; x=1695796678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV+65pRBVYc+OiZ4eNCts7KcqWJoy+uloTJChETlmhw=;
        b=viOG2DJis+lDgjvN8BKDX2cl/8MKqVWDf6LgCENzHYBiz2/k+3oWY+9V+gsFGM6m3l
         x97r8uYSroSUB7xgKpauIWF/5rXMkdcalScr30oB0d9gM0D/IuEfuBqeFpNTWcAuJFV7
         I1hN6l7cMJXGhQ1xNyQHBNRWqJAsfn+sk9I2+G8QnvB0C0BvgPFPjJBO57fPx3X5/TCH
         61hPsNbSlqUiDjwrF4ZgYD68A72csbWSRr8g2ljxIe+wXYu+OqZs1GKGbOnin6suPctH
         GS6ArJ0HzdQOz4NIqOx+eEtQh7IyYOBT3lnV07YRC1JbgxAW4CdpGfR6Qni7qbx8IWiz
         f/HA==
X-Gm-Message-State: AOJu0Yw7vYfUB35lWjs362SJHAVyNl8zGrTyZuaBBG2zubkwnHK9hjuq
        dc4OVPNT8ecffdSY27a8qFM=
X-Google-Smtp-Source: AGHT+IEWvN+C7f9ImWH0k3icxa3OXfImJNQPSPMfPOdPEqIsb7AlzEs3DRJNpMw5aUd0c4iMLMcPNA==
X-Received: by 2002:a05:6808:1ab3:b0:3a4:225f:a15b with SMTP id bm51-20020a0568081ab300b003a4225fa15bmr1266910oib.31.1695191878115;
        Tue, 19 Sep 2023 23:37:58 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id b19-20020aca2213000000b003a724566afdsm2775185oic.20.2023.09.19.23.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:37:57 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
Date:   Wed, 20 Sep 2023 14:37:51 +0800
Message-Id: <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
Milk-V Pioneer board [2].

[1]: https://en.sophgo.com/product/introduce/sg2042.html
[2]: https://milkv.io/pioneer

Acked-by: Chao Wei <chao.wei@sophgo.com>
Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
new file mode 100644
index 000000000000..82468ae915db
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
+  - Xiaoguang Xing <xiaoguang.xing@sophgo.com>
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
index 90f13281d297..b74d505003e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20063,6 +20063,13 @@ F:	drivers/char/sonypi.c
 F:	drivers/platform/x86/sony-laptop.c
 F:	include/linux/sony-laptop.h
 
+SOPHGO DEVICETREES
+M:	Xiaoguang Xing <xiaoguang.xing@sophgo.com>
+M:	Chao Wei <chao.wei@sophgo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
+F:	arch/riscv/boot/dts/sophgo/
+
 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.com>
-- 
2.25.1

