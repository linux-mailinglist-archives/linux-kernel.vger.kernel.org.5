Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11887B83F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbjJDPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjJDPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:44:37 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269DF2;
        Wed,  4 Oct 2023 08:44:33 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57de6e502fcso1305881eaf.3;
        Wed, 04 Oct 2023 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434272; x=1697039072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEYw2MwRgnbPGTuXNbUSjhb+9OMbJ8g3XCkSkGYa9LM=;
        b=DdnRfCBXtEOGk+02r9HXJPaLLJlSQvpSPkJeYgsZhz/6VQSCEFWliW9yogz1BKWZjR
         IYEoOrEmhAq2nCxe7EvSAnoY9UHsicgXCJilNH3DYKrocFQ2Z0U987c/N2vca+Y/fxGz
         qXSk90aA4ISkwnU+6w0lJSb4xJyy92vt8cODFOlDiotdMabl7V36CCvHbhmkEOfFyYtZ
         stIIpelA8wdj10zSUs1utlFCaCedY8zvGeKiN6WeAoRH/jENz6FlRd9dAlJFFhraGLsG
         0Y507oXcqEI18u0mUVFFf3sfxr/U7VgkKTuZOjO2bKjbQEC+qFky+yXuoMlyRL0s5CSS
         69nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434272; x=1697039072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEYw2MwRgnbPGTuXNbUSjhb+9OMbJ8g3XCkSkGYa9LM=;
        b=l1gM6QncnYdb6wgpBq5ja1THCKUmk5DXorkifTUOD60XjdNzLWxWGR9ugTv6AuZQLm
         mKhOFGMKFmr/xcdOdeIvoqJH7K8ht6dy1kMyfCo6sRyNSzqwBBQMkeeOV02NL6U4mv8R
         hLgZ15+F+WKLKFcbNYpnNMHEvwTah4Zwm/GUTcXuiKB5wDih5d9IrdLaYuQG7W05ubU+
         mLFvvwhnY9qWqPw0WPqTrtKH+6Hg96ulSm7bTeLi2Ylb3UI1Uf65jzPYUraG1xzLs6QV
         CLrHLsNpipnpH22ow69XNEbQ6XzYX6rKHnxIj0YGED/tJKTmuj06eoWHpr1zcC9xmXFL
         02lw==
X-Gm-Message-State: AOJu0YxqL6WvYQaGjLrT3sFwa+yYlxzdQyCgoFY9JEYEVgWS0WO6pFWA
        iIsy6G/8uF68KQL4ZFGnPVI=
X-Google-Smtp-Source: AGHT+IGwxMht30LRWeQkhFmIXPWfU23TWH0ZTFV2frJ2G6HIKcbZwDKeU6DkkHGrz2R0nrFioeVCZg==
X-Received: by 2002:a4a:8081:0:b0:57b:6a40:8a9e with SMTP id z1-20020a4a8081000000b0057b6a408a9emr2314916oof.7.1696434272377;
        Wed, 04 Oct 2023 08:44:32 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id q74-20020a4a334d000000b0057b6bae1e31sm673615ooq.7.2023.10.04.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:44:32 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v4 09/10] riscv: dts: sophgo: add Milk-V Pioneer board device tree
Date:   Wed,  4 Oct 2023 23:44:25 +0800
Message-Id: <9a5b3499ad6ae76d1dfccc6f9cf5eb954e2fc2b2.1696433229.git.unicorn_wang@outlook.com>
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

From: Chen Wang <unicorn_wang@outlook.com>

Milk-V Pioneer [1] is a developer motherboard based on SG2042
in a standard mATX form factor.

Currently only support booting into console with only uart
enabled, other features will be added soon later.

Link: https://milkv.io/pioneer [1]

Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f60a280abb15..72030fd727af 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -4,6 +4,7 @@ subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
+subdir-y += sophgo
 subdir-y += starfive
 subdir-y += thead
 
diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
new file mode 100644
index 000000000000..5a471b19df22
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
+
diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
new file mode 100644
index 000000000000..49b4b9c2c101
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
+ */
+
+#include "sg2042.dtsi"
+
+/ {
+	model = "Milk-V Pioneer";
+	compatible = "milkv,pioneer", "sophgo,sg2042";
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1

