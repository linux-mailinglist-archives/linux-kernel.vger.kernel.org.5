Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607767CC44C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjJQNQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbjJQNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF7F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so18306115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548534; x=1698153334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR5zOKPIIXQcPWK7Zwi8IMehempNxAt19rgFARaEstc=;
        b=GteNGw0RyWD1HuywyBU6lGdXgWwjSMmPz29vOwc5ZrGHlIXHkjILVC4xB2YK0ClVvk
         lisCpEVBhIBS9usDRQI4TYmIKjfIp7nJTp91u01Ign+hpxpgxcJrTHfshw1jRQ8MAxPL
         NTL2eV7XIqX7rZJS4Jm23Uer25LMLMBQsIiqqvOOqdSnVFB4TdtUETT7TI2hOAqlGzkm
         MwWR5/Rzuw2Wnq5i+z303MLPuibrZ5LVyRBbJlYh/PyHOwVk9Pi/NEenW2RQ4Af/t8hI
         diinzbTnqdxI7pz3KtcaRXr3/d4BkOx1qQzZ8TIfF/5SqkIuos21CpcRYxwaNB4x7HW5
         jV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548534; x=1698153334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR5zOKPIIXQcPWK7Zwi8IMehempNxAt19rgFARaEstc=;
        b=Dsevra3yd0oVyMk5otdboJdxpv3AjQyMm5tiw68zmRYWz9d3yiNhdChdxib/d3OqbY
         ekcqe+D0RLlRmqQPuX+07qyqtgBkSC+aBK9WXhCOhF5mqDlniFPZAh/kJj8rTOlYnNAa
         ssRn5atCBL8eL0a/EgnNmK95mG9KyNi5f49UigUCT9uCSNt7+m0T7iOzmhjekqSusBmz
         jRw3KUiLlqIwLQX8MwDW0cUSG+87RSyi6x5y358tpVrCygEyNkdoGjZyfQpzPFBHxS8M
         IGzmR46tLWpY+0I3k28UCy5r8JBQM2i0eejbN/13eOucDC4Pi1iuzw/Lla+EbS+QDM3K
         M9Ig==
X-Gm-Message-State: AOJu0Yy+LZnb5SlgepEGtEQjL6KvvtKChkdG+fEd3jSpiJYyadmVuX1h
        20WHKxww/Trj2d3PjSBV3+POIw==
X-Google-Smtp-Source: AGHT+IGuYusZwm6bjTLUUAItFdrqDbC+bP3ybiFs6S3KZJ9w+kFoW0BT9EJNwe19ok8MCE/47d64Qg==
X-Received: by 2002:a05:600c:2145:b0:406:513d:738f with SMTP id v5-20020a05600c214500b00406513d738fmr1640332wml.2.1697548534165;
        Tue, 17 Oct 2023 06:15:34 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:33 -0700 (PDT)
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
Subject: [PATCH v2 08/19] riscv: add ISA extension parsing for Zfh/Zfhmin
Date:   Tue, 17 Oct 2023 15:14:45 +0200
Message-ID: <20231017131456.2053396-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zvfh/Zfhmin ISA extensions[1].

Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 4 +++-
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index a2fac23b0cc0..bead05cb0df2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -79,8 +79,10 @@
 #define RISCV_ISA_EXT_ZVKSED		61
 #define RISCV_ISA_EXT_ZVKSH		62
 #define RISCV_ISA_EXT_ZVKT		63
+#define RISCV_ISA_EXT_ZFH		64
+#define RISCV_ISA_EXT_ZFHMIN		65
 
-#define RISCV_ISA_EXT_MAX		64
+#define RISCV_ISA_EXT_MAX		128
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 8cf0b8b442ae..68914b5e2df9 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -244,6 +244,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
+	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.42.0

