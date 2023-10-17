Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B227CC45A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjJQNQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjJQNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E3F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c504a51a18so12430551fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548538; x=1698153338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XveLx1BmE1GvU06WU0o1GpTCvis6fOoE2R2208YLJcc=;
        b=EviRm+5Q+1FbwvWL5F6/kvhGQNmfrI1A/MaocosEettqksG4vfmDk77kLysmPeX8f/
         fLfIqg1mIpt09P1nZJfAgcz7g4SEAet/0YHZ8/niL/RAPhbrOLW87X88Hwd/o6Q5o2vT
         uEM/IfPe3yXvCPt/zXsSf+l0uIpAoXd1IMYvB5V3xpEVvXfvYJyIs3wuCyArriPnZi7M
         uj1N5SWEgPNeINCU/5efh6a7/LwI31f7nKClMR7Rnq61+jRHRJCDXkLniC+F5AFZUh+0
         gZX/ZylPy1ouWUMKfK/rvuWWZS9WUt4HZgVD/wQFXjvb5ScBU0topvc5O8g2JUlyYGY7
         RmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548538; x=1698153338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XveLx1BmE1GvU06WU0o1GpTCvis6fOoE2R2208YLJcc=;
        b=NReyPxL9l7/6qLPTjwdBevf3P8pOJrYiCttnulzk1V2P3cxlb9SYQGsXPSERRCPyGM
         WuCj+tqQBxyP9XNvdHHyfYH/M3RXsqwAzOEl8lbPm0lZRZlCEVF4CSAXeaJl6oI0AwqJ
         +tf4r8EY9RJyN+4jQRDmLPf7w5r0YB5Y1HugRlJx0FzQtF+vJ/5pZFiomcCSwDjDt5gf
         JWeY4dVuSjPJD7/JbuuhG4/rMFOufG86CwN5B7OHfFOk0u7rObupzj2z6WRjsLusfBgs
         oq5iZM4kZ/G/CIAfAabPJLJr8n9px+UDXMJF6G4WK8KDAZ9tkP4MP3CUA2+ruoT8MZ0N
         IsKg==
X-Gm-Message-State: AOJu0YygMVSWe3Gs12No4BcmUB6o1U4/JXi5688wC2l/GOWqfYcBvhKT
        VzXZKQ59TYT6xgpf+OLf8XhMKA==
X-Google-Smtp-Source: AGHT+IF7LXN/FgZqOq/N2FVm/bEsUOoHif69CbGwt+OOKA9MLmQwAsroiCAxGTIPT5U1tiT7cTKbGw==
X-Received: by 2002:a2e:9b49:0:b0:2c0:1959:fe59 with SMTP id o9-20020a2e9b49000000b002c01959fe59mr1644747ljj.3.1697548537405;
        Tue, 17 Oct 2023 06:15:37 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v2 11/19] riscv: add ISA extension parsing for Zihintntl
Date:   Tue, 17 Oct 2023 15:14:48 +0200
Message-ID: <20231017131456.2053396-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zihintntl ISA extension[1] that was ratified in commit
0dc91f5 ("Zihintntl is ratified") of riscv-isa-manual[2].

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Link: https://github.com/riscv/riscv-isa-manual/commit/0dc91f505e6d [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index bead05cb0df2..a9aea62b6c6f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZVKT		63
 #define RISCV_ISA_EXT_ZFH		64
 #define RISCV_ISA_EXT_ZFHMIN		65
+#define RISCV_ISA_EXT_ZIHINTNTL		66
 
 #define RISCV_ISA_EXT_MAX		128
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 68914b5e2df9..0a74b2cdcacf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -242,6 +242,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
+	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.42.0

