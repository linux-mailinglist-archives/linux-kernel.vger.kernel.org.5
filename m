Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701181102A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378098AbjLMLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLMLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD9F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c1e8458b9so11300185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702467197; x=1703071997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ7qFvLPI16XitLVU7jac70czdbEyCJmCnGlh/kcFn4=;
        b=ldWMEEcskgoxwTZ2P3sw0LVoHH117VtNo3HnAAcqFCCNj6LUh5XOcI7ZkH5WEsgz/B
         yNJDQXh6tpS4gZ4ZWFyWLfTsn1tAZT23uhxsBlXvxqpyRY9xV7Qgnv90X4UvBcK0cptR
         fQUIoQ7tFy55U0RzRmDo29JYdd6APD37uWJY6GYg2pb3F01ojLZpyePGYYD6wAJ7xXUF
         bT3YMzRZQ9cLj7RBAcwzyKJDyee5LPeEcItbEPNYJlkhIf6LM6zPYdQVRRCIpqm/j2Iz
         GMP1Advf5CA2Egd9nzsbt8lAT6sanyuWbAka+hFjUgqgbS5jCYLi88uRkWqAH5931y/7
         go+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467197; x=1703071997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ7qFvLPI16XitLVU7jac70czdbEyCJmCnGlh/kcFn4=;
        b=Qdr0IXkLi/0utSbflj0ZoGlOX88mbkhHvoWgv1Q9KteFmYYPTL9nrrsjWHekuYoCpO
         S53CjlTW6dXzx93JAXUscn4EENRG5kSX3TKJS4opLMhPVoFuaRGqFv3DkyiMcngcIBMV
         Pd67A2KOBJ2F4qxhg6rKmfM5f4P8XWT6YK516tJ//c2S4X12Ep9cytERCTY/WL8T+QFR
         MShZb6WPiYl5pGN1ZPcZ8oqsDuVL6hf3QDV+9KXj6xW9XJ60jXzCtez6LfpXMUx3FJbV
         /ADBlZsm9+j+agF14TC2FnYkuxSCbt3wwQDJ1AJYSee93hcEjBVzmrHOzmU0rPl1aXjB
         ksQQ==
X-Gm-Message-State: AOJu0YxPipIApg4wpQ1VWkBLWDOi+AZih4DgCpuTaLDN4dCFlBMEzqtP
        zmFjJwMtfydfDkP+25J/k8dNcg==
X-Google-Smtp-Source: AGHT+IFSZAznHPSK5PUles9w0ak3hYXLoPc4Qu5KPjMvXQBkR/ftanO0CSh3prHsJkQveJSFnBCRzQ==
X-Received: by 2002:a05:600c:1d9b:b0:40c:2960:9603 with SMTP id p27-20020a05600c1d9b00b0040c29609603mr9614366wms.3.1702467197077;
        Wed, 13 Dec 2023 03:33:17 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c564:f167:d072:5672])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm22433137wms.30.2023.12.13.03.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:16 -0800 (PST)
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
Subject: [PATCH 4/9] riscv: add ISA extension parsing for Zam
Date:   Wed, 13 Dec 2023 12:33:00 +0100
Message-ID: <20231213113308.133176-5-cleger@rivosinc.com>
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

Add parsing for Zam ISA extension which is part of the riscv-isa manual
but was not added to ISA parsing up to now.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 3b31efe2f716..016faa08c8ba 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -85,6 +85,7 @@
 #define RISCV_ISA_EXT_ZVFHMIN		70
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
+#define RISCV_ISA_EXT_ZAM		73
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3eb48a0eecb3..e999320398b7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -259,6 +259,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zam, RISCV_ISA_EXT_ZAM),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
-- 
2.43.0

