Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632227E3A80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjKGK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjKGK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22DC11F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-408ffb55b35so3564955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354569; x=1699959369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3TrfnxPBusbuENWlTFkbo4q1loDmWY4mGc5/+ZWfWU=;
        b=edHZw4OJwgjMnYBrSWlbEhdsIZ+SaiwPqS2r1+BZnJmxDi7/L1CgKsk2pXSDC/i0K5
         cDI8PDtnM5d0W36e/ohJL8T1GXUKl0BRY1Fmx+KsV8oykdvvUFGNeNGz2xU9LRcEsS4b
         mCsxUav6u6SJYlzSw1HyhDkitF52jfNw3/enFrXQeizaa+q3AgqxVS7m9eA3vZjpbP/a
         2Akf/peEiMT0BlTPNX6gDN0w5e6f785lUD9ajqqH4F+bVZz8t2iT+NrDNNf/kfy261zT
         K+N8ODtIrv7MlvW7AHlZtSry27IYO10yZpzeU4TVE0b97ZwD6n9OAteO/WunufdQlzPU
         F0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354569; x=1699959369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3TrfnxPBusbuENWlTFkbo4q1loDmWY4mGc5/+ZWfWU=;
        b=dGmQngFUfyFpDWwehh2/qKLM7n6ljY9krz7hbGEQVFk+u6f/8V3qjaXzyRpLVG2rjb
         fj/HPqYiTWNyj75UHkrvYoEHMGygyD2wXdc8d+2MSbixtTCSTJ4/5PVQHZBG3cmHfwmk
         HlUWxOCZw0BZzPBmC7iCZhxtrXMoEkt5YDsfGOSX6cDRLDK6DwAw1eBtb0EuKsLbnnJ/
         Z+Z7uam0TnskPDJ80NGbg8kH3WGWAJFNFLGx1iJtgWvTcp+OO3EdaYBCSlzcyIbICDiC
         UGJVOEHf4hMRGwuHru+HfoLnop/2/wL0Gp+RJa9BTxTbby+vcfbP6lDA3ofDgTdRXutW
         W/eQ==
X-Gm-Message-State: AOJu0YwZH0DQLvJ8fGMbG0W6W2NP7pQgyV0TmrGOJVIJ7BMnIziBU5sM
        QLprYNFuIxiOSrVZOJcmceaHWcHVO8zbgF1+HB38ww==
X-Google-Smtp-Source: AGHT+IHnxDz0Lcs+nSF4fhyZmX4N1apZiK61SiS26CL6G/o5AoZ2KehCJD/kPki3vD5ZYO3oxb3qIw==
X-Received: by 2002:a05:600c:3d95:b0:408:3ea2:1220 with SMTP id bi21-20020a05600c3d9500b004083ea21220mr25869592wmb.1.1699354568713;
        Tue, 07 Nov 2023 02:56:08 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:08 -0800 (PST)
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
Subject: [PATCH v3 07/20] riscv: hwprobe: export vector crypto ISA extensions
Date:   Tue,  7 Nov 2023 11:55:43 +0100
Message-ID: <20231107105556.517187-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
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
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 30 +++++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++++++
 arch/riscv/kernel/sys_riscv.c         | 13 ++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b020b2d35a99..2183fa6d2fc1 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
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
index 10bf543de3ce..1b85386f276b 100644
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
index bb44592707a5..8e1d26659e14 100644
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

