Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26587CC443
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJQNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjJQNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CCCEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bbbe81185dso14808321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548533; x=1698153333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSjULynk4axu/lQueuStT5Cc6po8Eg43A5EArhYri7c=;
        b=W4GIkHEFe8TH3gBbpUC93lUMRqWVvKJfJBzs33kK6On1QIlrm0LA1cYZEcN6+6VuwB
         2i0ne5k5LM2uaGd29Wep3h43PYJGTs8A9+wCbwGtfBKExx5ibCLfNBlnsFhxClRY7JqN
         kgR9qG+JCFeCY8Gzf4khU0oa/MhF7iygIjvDGo+SovPTmDgoL4FoLFqExzrXhIA9TQEb
         Ndu+myeetHqIeXKuNf7muZWdVmqpwk5U6aN0mHRYo6oKPV3xAdJiw+3Ne8V3asp2Oi6F
         59m85dRpljUfglHTIGr1pQN7QSXS4V+qPXUxTheJEG658oCEhVMEB28Xp4OlM1WA7Yb6
         M9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548533; x=1698153333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSjULynk4axu/lQueuStT5Cc6po8Eg43A5EArhYri7c=;
        b=X9KtJ6VRxEt0mFNNc0WlzcmhLzULjWCUCI7v2jrblbrKNKS+OsVnUfCaGHnIGQ/XKd
         rjLqNw/3kAK8FzgYZSexVbTSS7HDYaQzecACUFNClpRaokMboCMND7L8qzCduB5HN1IR
         mMHdjqT9PZjzyvsZXEAxAs2OTkxov+by5cQeoU+YIkdk9x7Lc8LZh4MXV00gFVQYbPlT
         Xpov+0KrlePaFACCg6bJW8bpFBjdBVtNHQEzv/cJZymoazWh99pqbBx0fK6h40yKdCfO
         7ZvioBmdKbMwAINuSnL1XbuwTRqMXS3LHy3bknDkoeT2i3ak+fiuc7SePTjcot0+xRgN
         Oqhg==
X-Gm-Message-State: AOJu0Yw3Q9kvYG2F7u9QrTXq4vPkQLw9klVKMw/3W7STDo2SMS4wkc2d
        7vjNLGZSrsobf9R6XWIG9jWN7Q==
X-Google-Smtp-Source: AGHT+IHqDLYBet1B3FL9I2Io23hZaqRlzAfShCE8ZthuzQfc3iPmaq8AoMjB8iTpQd9gVBVYyXJlCw==
X-Received: by 2002:a2e:7309:0:b0:2c0:7d6:1349 with SMTP id o9-20020a2e7309000000b002c007d61349mr1828090ljc.0.1697548532200;
        Tue, 17 Oct 2023 06:15:32 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:31 -0700 (PDT)
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
Subject: [PATCH v2 06/19] riscv: hwprobe: export vector crypto ISA extensions
Date:   Tue, 17 Oct 2023 15:14:43 +0200
Message-ID: <20231017131456.2053396-7-cleger@rivosinc.com>
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

Export Zv* vector crypto ISA extensions that were added in "RISC-V
Cryptography Extensions Volume II" specification[1] through hwprobe.
This adds support for the following instructions:

- Zvbb: Vector Basic Bit-manipulation
- Zvbc: Vector Carryless Multiplication
- Zvkb: Vector Cryptography Bit-manipulation
- Zvkg: Vector GCM/GMAC.
- Zvkned: NIST Suite: Vector AES Block Cipher
- Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
- Zvksed: ShangMi Suite: SM4 Block Cipher
- Zvksh: ShangMi Suite: SM3 Secure Hash
- Zvknc: NIST Algorithm Suite with carryless multiply
- Zvkng: NIST Algorithm Suite with GCM.
- Zvksc: ShangMi Algorithm Suite with carryless multiplication
- Zvksg: ShangMi Algorithm Suite with GCM.
- Zvkt: Vector Data-Independent Execution Latency.

Zvkn and Zvks are ommited since they are a superset of other extensions.

Link: https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 30 +++++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++++++
 arch/riscv/kernel/sys_riscv.c         | 13 ++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 968895562d42..8681fb601500 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -107,6 +107,36 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZKT` The Zkt extension is supported, as defined
        in version 1.0 of the Scalar Crypto ISA extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVBB`: The Zvbb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVBC`: The Zvbc extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKB`: The Zvkb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKG`: The Zvkg extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNED`: The Zvkned extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHA`: The Zvknha extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHB`: The Zvknhb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKSED`: The Zvksed extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKSH`: The Zvksh extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKT`: The Zvkt extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 89d0e37a01e9..2529cee323db 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -39,6 +39,16 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZKSED		(1 << 13)
 #define		RISCV_HWPROBE_EXT_ZKSH		(1 << 14)
 #define		RISCV_HWPROBE_EXT_ZKT		(1 << 15)
+#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 16)
+#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 17)
+#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 18)
+#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 19)
+#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 20)
+#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 21)
+#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 22)
+#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 23)
+#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 24)
+#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 25)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 2b50c661da90..25d35800809f 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -172,6 +172,19 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		CHECK_ISA_EXT(ZKSED);
 		CHECK_ISA_EXT(ZKSH);
 		CHECK_ISA_EXT(ZKT);
+
+		if (has_vector()) {
+			CHECK_ISA_EXT(ZVBB);
+			CHECK_ISA_EXT(ZVBC);
+			CHECK_ISA_EXT(ZVKB);
+			CHECK_ISA_EXT(ZVKG);
+			CHECK_ISA_EXT(ZVKNED);
+			CHECK_ISA_EXT(ZVKNHA);
+			CHECK_ISA_EXT(ZVKNHB);
+			CHECK_ISA_EXT(ZVKSED);
+			CHECK_ISA_EXT(ZVKSH);
+			CHECK_ISA_EXT(ZVKT);
+		}
 #undef CHECK_ISA_EXT
 	}
 
-- 
2.42.0

