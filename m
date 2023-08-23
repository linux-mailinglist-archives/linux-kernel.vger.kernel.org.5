Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC178538B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjHWJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjHWJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:07:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C31B0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13104846a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780762; x=1693385562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMAzBQ2JWtyTS8mD8e3Fxmu2d91tt0ITlswZAkxTIh4=;
        b=OxEp5de1cW3arQOc7FTUhnrwD2M3065uhbMylGGIzlaSBIYnfSpA2ScRQUycl3Fn2I
         6HQpegZ5L6O93HqxZhbsUxzYXnwfwPusJEGQqvIt+JzP/r9Wl3gCKmrQMqUK6kLf3iwP
         02Df7eU/vgdF4o97ikufrsUegyIy3efwxfLmZ0a1j3QZWMpNOnoBOG+RcljTrKWtyy3i
         P6sfFz+3NjFugVMhVprxslhMJXJt20YozDgBAmr37O8iVlowk5LSPo3f3pLZw3ke6qmI
         Vn3ctXAiQKF8eawIwY5SOok00/fIvlpDXFETu2pLpx6jJKE+wSA3CE+Q4auY6vkqU3nP
         Ymwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780762; x=1693385562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMAzBQ2JWtyTS8mD8e3Fxmu2d91tt0ITlswZAkxTIh4=;
        b=DLij1wGe54bJC+CG6RRPTGWO6lrMPmM3Ydng9Mir1QOfUznYE1W7tLauAlm2Rr0+m/
         7kAZm7yiQaEvG3nhDUEroLcQp8wwfSqgI7nunPjFcWAGnOa/kXnlBDukeExa610c9TRc
         q6jMxb1jWe5TUaLqtioS9xV3wJipegB8i+8uiBg2ampQwyeIYreEZIyfh0deF66lSxmg
         3WQVQe23A3rZEWHno+CxTAZ6MK7CigZSZYY3ds8zJN8rfXJH07lJAXMqF2F/bQhz5NDc
         FxfXwdLAo12pAewSq434w1rCFQL1B7PanQHGqB1yXBvmCuosT/f6PYQIZCiyPoKS117v
         fiQQ==
X-Gm-Message-State: AOJu0YzQ/Rb9Tsk6FCElqcArEme1/gWNe0yBCqH0WOf+Y/u4xiOY2tVK
        B3I1tFd53JqR1PIS/RR5IOxpbA==
X-Google-Smtp-Source: AGHT+IEZWFRQo+JFnpF1qlyr688eDH49YjAZuwvCYmHF+GBS3mKDm8CMK03WV266B3Bq58Lqb+bM7g==
X-Received: by 2002:a17:906:28c:b0:99d:fcb7:60db with SMTP id 12-20020a170906028c00b0099dfcb760dbmr14077749ejf.16.1692780762254;
        Wed, 23 Aug 2023 01:52:42 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8665633ejr.164.2023.08.23.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:52:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:52:38 +0200
Message-Id: <20230823085238.113642-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rebased on next-20230822, so might not apply cleanly.  What does not
apply, can be skipped and I will fix it after next RC.
---
 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi     | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts  | 2 +-
 .../boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts    | 2 +-
 .../boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts    | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts      | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts           | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts      | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts               | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi                    | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts         | 2 +-
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi                   | 2 +-
 arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi                | 2 +-
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi               | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
index 9b03fca2444c..ed7b12e65a10 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 / {
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
index 8785de3c9224..3a2c3281eb88 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
index 4df8ffb71561..711450ffb602 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include "sun20i-d1-lichee-rv-86-panel.dtsi"
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
index 1874fc05359f..b217799e6166 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include "sun20i-d1-lichee-rv-86-panel.dtsi"
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
index 6cc7dd0c1ae2..10116fb3935a 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include "sun20i-d1-lichee-rv.dts"
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
index 52b91e1affed..08cf716328a0 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
index d60a0562a8b1..204da82a5dc6 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
index f2e07043afb3..e2bb6bc16c13 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index 4ed33c1e7c9c..8dbe717c79ce 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 /*
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
index 97e7cbb32597..b18f368e06e0 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 #include "sun20i-d1s.dtsi"
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
index e6d924f671fd..1a7d6ef33f17 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977..450387265469 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 #define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
index b7156123df54..3b077dc086ab 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 / {
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 822f022eec2d..5a9d7f5a75b4 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
 
 #include <dt-bindings/clock/sun6i-rtc.h>
-- 
2.34.1

