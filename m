Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50CD7EB1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjKNOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjKNOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:16 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70919A3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:53 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77891670417so55612985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971232; x=1700576032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kebr+ZAQxQeA9gxwXsENChkHynJvuQ8x6phPFJllrto=;
        b=VqDU5v+BES95H5PeKJaA4YrnF18y6tW7P9PqO+cRuxpKxMk9UB2ppbpX4Y683vlm3T
         UjyJinfL4HCs8Ifz4uICuKxNdRQPd2YR/Gky2neggpG9gAXT+sVKN7tnQ550MeA8mopH
         VXMePpJkCRnFg4oHrt4OeiDO3HZM+4oCWDSLBsfpQcz5cuJBHCci2RYXxe4lW679UvfW
         KVd9pEjGm1M0LD8H2FjGC6DUC1exfoC35HVQslmnDJx1UvIKrNpTj4XgRFHWqx2bIx9i
         Wg9HwPaMjEnEt7YdGsGL+z0+vF0BXszjCGQwVYWmZj6WBAH2RShD8WBGlVzWfDaFxGNG
         IzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971232; x=1700576032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kebr+ZAQxQeA9gxwXsENChkHynJvuQ8x6phPFJllrto=;
        b=DF5lSxWQnmNBIi7DiG2UIy/tjsBB5DvWGr2mcOh1V37FaI1eK0HBTkpExEwwE7naDc
         nDfTSzuT1CTmWs9+H5+D6tT79qekcKNnyTYF7HKATdi92SSTL2TcvBejGdFHbUXAw+Lh
         7fsmP0dY5VkeVXFQPoByHV7/IVy+o44nMDl8M1EOuc/Z4nWtuEewRuNNXPBDRLI9iRhf
         7aZvR8Ipc0ce1LF/QtatIHjRbomosy63uldijM68N1d/vqC5WBQTqohJWU7faclXOsyt
         bSjDx70SfY86lXAXt0JAM0Pw97/XLo7qevX3pe9rlfiN0TP918TX4CmXmLD3HgB1aR95
         bfAg==
X-Gm-Message-State: AOJu0YwjdxrO3crPSx5wwHezHLo0kVKwU+wDQCPB1cpiLUbBb8287PD2
        41/s38w5ABuI0uUanQkZvBP64w==
X-Google-Smtp-Source: AGHT+IGUNDzsVyRn1cI8Qi+AL4zww1R/UAkdwGtV1FRdekOhhWQiL5gaf+3isCeURHwpf2kxBnYCXw==
X-Received: by 2002:a05:620a:461f:b0:774:17d6:31f1 with SMTP id br31-20020a05620a461f00b0077417d631f1mr2492322qkb.4.1699971232036;
        Tue, 14 Nov 2023 06:13:52 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:50 -0800 (PST)
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
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 15/20] riscv: add ISA extension parsing for Zvfh[min]
Date:   Tue, 14 Nov 2023 09:12:51 -0500
Message-ID: <20231114141256.126749-16-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zvfh[min] ISA extension[1] which were ratified in
june 2023 around commit e2ccd0548d6c ("Remove draft warnings from
Zvfh[min]") in riscv-v-spec[2].

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Link: https://github.com/riscv/riscv-v-spec/commits/e2ccd0548d6c [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 97d106fa0f54..103d4f0aaf15 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,8 @@
 #define RISCV_ISA_EXT_ZFH		66
 #define RISCV_ISA_EXT_ZFHMIN		67
 #define RISCV_ISA_EXT_ZIHINTNTL		68
+#define RISCV_ISA_EXT_ZVFH		69
+#define RISCV_ISA_EXT_ZVFHMIN		70
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e73ee4cfd84a..623a5fa48cf4 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -280,6 +280,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
+	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
 	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
 	__RISCV_ISA_EXT_BUNDLE(zvkn, riscv_zvkn_bundled_exts),
-- 
2.42.0

