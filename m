Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C207981102D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378668AbjLMLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377447AbjLMLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879312D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso10694015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702467200; x=1703072000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSyk12PGgNh6ZiEbOULW7RPQKbPPPMGsxhdUj3Rl3fw=;
        b=dbtjg5igt6+QL9XNlD/CQQCAi//+3rRvDDG38AGTrAOAa0XN62sUZZqJ10vWn+Flse
         zhVGcViymdSlnPN6dlESEmSqtcehaYdIHP5d8cskhCTqDxWc5Hne1KbRbVsUGTnme46b
         UzeZDJ2Y8bruodbRbH0jTdqYXLN5Udz0nXyj7pjBIZo1guCRs7+AQ+eKZPGbk8cKH0Zj
         bxZlzRmMh1qi0IA+5BsNhinM6pM150LVihzoIz5xZNtrREOdGlYGuupJbbtBgCyDYZmy
         AQVP7T+AqDBJA41f4UpCqxumXT84rSJfON6c3v5eQWwJl4kRvPTS+SPZrMZyKQKEflWR
         hxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467200; x=1703072000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSyk12PGgNh6ZiEbOULW7RPQKbPPPMGsxhdUj3Rl3fw=;
        b=T5nrm1QO7bF2/HaBMGAIpcwTUpOgP4aN3SalgXdJxSMz0av5v2FuI/w2R6thHR7IDO
         ZFnKalALgF8W86/FQsZSq/yLMGOLe+CFjbdsQL8dsLu+cRyMsv+3Vb4V9IuYlBmSNT+A
         assH+P9wGLG6O4afhZuIXCt2/tgrmK+NroDcDjyztZlYpo8jGtV98lCoICwLS/xI91Vp
         bWomT9HEfTRKbo4mOR4KXRKT49R+0Y7UPW1WEcrZT1rUuFD4Iqq3aRhkR+0BVu5J3z+z
         GBNChclw1qR7ezMuqY+dH7VjQbjWuZM4eLu92lhscWG6zRKQhfIWm3bugRkX9gQbXT+6
         GwgQ==
X-Gm-Message-State: AOJu0Yw4DpzH0Aek35l5XtceFr97wkbj8xFFMdaw3lii+eiNkLvI0PyO
        isC/Apg8b3s1wwK8H6IHZcyvsg==
X-Google-Smtp-Source: AGHT+IGpaCx+D5ojXDBVQxpZqQUYiYfjlRdA9ehLOCWbM5XAh+lwFxnI5yxd/Hyl3z3Rfp/Vdi/pXA==
X-Received: by 2002:a05:600c:3b23:b0:40c:2631:7c3d with SMTP id m35-20020a05600c3b2300b0040c26317c3dmr9593738wms.2.1702467199960;
        Wed, 13 Dec 2023 03:33:19 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c564:f167:d072:5672])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm22433137wms.30.2023.12.13.03.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:19 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH 7/9] riscv: add ISA extension parsing for Zacas
Date:   Wed, 13 Dec 2023 12:33:03 +0100
Message-ID: <20231213113308.133176-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213113308.133176-1-cleger@rivosinc.com>
References: <20231213113308.133176-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zacas ISA extension which was ratified recently in the
riscv-zacas manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 016faa08c8ba..8aee032f092f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZAM		73
+#define RISCV_ISA_EXT_ZACAS		74
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e999320398b7..62443cd632b8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -259,6 +259,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zam, RISCV_ISA_EXT_ZAM),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.43.0

