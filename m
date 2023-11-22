Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32957F530A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKVWMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:12:43 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDDCB9;
        Wed, 22 Nov 2023 14:12:40 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35937f2fadeso858685ab.2;
        Wed, 22 Nov 2023 14:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691159; x=1701295959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQrmqAZcdIuXmqszFM5kR+KdU7shYUbjsm44jbecVtk=;
        b=HmmXPwzc50joKTkOWtAw3+vfvwRiCJwUxb66bn0t0RkrnwXrWSRk3c6b5Shvdoh2sU
         1Ws/58s/BN2eTAn9XZvjg6u01uhbmcGAOH7EnsT+kTbG2DIzyuyoxcgEUpJSXFmnJePk
         QQFX+2Kc5fgSuinpVmNBN0WU84ER/oosxaKkNnMFeDluUotIq3Bd6gjBQR3ybPRhwEjb
         3YjUYSLEYZ36hbpwG01KySCr8IpTslGHW3dGY/IF9WMA4uRhuAgeCglzQNyCJgSACRSa
         P63Vid7B+ctDcka/yhDiQzEvFAXyWjeYu/OLlYTrWUwkdQoXBUUVmXBRHUsORX3WYomF
         TyAA==
X-Gm-Message-State: AOJu0YwUMbJYNNiUHMB89pLYoBA7II/J2cjO01l4lvOT9QyA4sONZp2z
        KAWDU3LqmPgemTxsBpStKA==
X-Google-Smtp-Source: AGHT+IGj21a13xz1WqdS/H6Nqa3rnnJqU98fDkeH4YoBfe8sZRN0UwRgSamoEKVV6rR3nWw7fbCw5w==
X-Received: by 2002:a92:c5cb:0:b0:35b:110f:8127 with SMTP id s11-20020a92c5cb000000b0035b110f8127mr3639999ilt.26.1700691159445;
        Wed, 22 Nov 2023 14:12:39 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a056e02119100b0035b19b773b8sm159259ili.59.2023.11.22.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:12:38 -0800 (PST)
Received: (nullmailer pid 2753842 invoked by uid 1000);
        Wed, 22 Nov 2023 22:12:33 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Nov 2023 15:12:35 -0700
Subject: [PATCH v2 4/4] arm/arm64: dts: samsung: Always enable extra W=1
 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-dtc-warnings-v2-4-bd4087325392@kernel.org>
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
In-Reply-To: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung platforms are clean of W=1 dtc warnings, so enable the warnings
by default. This way submitters don't have to remember to run a W=1
build of the .dts files and the grumpiness of the maintainers can be
reduced.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Use new variable name
---
 arch/arm/boot/dts/samsung/Makefile  | 3 +++
 arch/arm64/boot/dts/exynos/Makefile | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/Makefile b/arch/arm/boot/dts/samsung/Makefile
index 7becf36656b1..fffc5c45d441 100644
--- a/arch/arm/boot/dts/samsung/Makefile
+++ b/arch/arm/boot/dts/samsung/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+KBUILD_EXTRA_WARN_DTC=1
+
 dtb-$(CONFIG_ARCH_EXYNOS3) += \
 	exynos3250-artik5-eval.dtb \
 	exynos3250-monk.dtb \
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 6e4ba69268e5..9cb188ef470d 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+KBUILD_EXTRA_WARN_DTC=1
+
 dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos5433-tm2.dtb		\
 	exynos5433-tm2e.dtb		\

-- 
2.42.0

