Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AFB7EB1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjKNONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjKNONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:13:39 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427E7E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:36 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778a25cad6dso14498685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971215; x=1700576015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkOxZJ0AR04vpaXdb9zeN8RXHX4RQvWz8fPabjRmmO0=;
        b=VnYyclTziqw/v901eO6D0yTjatw233rwn+9V4wpYt/27Q3kzJzJVsKQHpm6A2OgdPn
         Re0cqEJUKWnK9dCUIJOl8W1sfhgi+Lys2WTVISsER+LBNdta6gPDOxfqe6Sn4HpLjd97
         x1iBQs5YeXSja1Gn2oP8FiaGDs/Eq6Zm3ZuSHdGUzB3xDY7OAwN516NzBbb9WC0yiofU
         YpxRulJeh4SKb2Uf02fJdwWHgKx9WQexnpFkrOgtxF/VGJhCsags2HOMHk/Xfg2MF19a
         d1U7Wft6Oxgnaf+nCDTwAdYRmuUX/lzNguJPakdVEPEA5n+LuWvKTWUa/Te1tXP67UlQ
         8FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971215; x=1700576015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkOxZJ0AR04vpaXdb9zeN8RXHX4RQvWz8fPabjRmmO0=;
        b=sYTR8SAPHqfHlP7ha37FnB+zTyg9dumIQRBX1u0MJBzkWmunQMk2PScva18Kqo8NvD
         XEcOC7TrLHy9SLr6D28L7kXOI6VJymToXgxODHePY52GrZx1xBibXlMjOrFbxt+Fz9Ar
         LJaDm7odbQCHG6lxCdzHFdCLbfw6GOsFddX1RIiRHW53Ez9p8ot1zWMEetnhQkbbIAd6
         3p3MgRNGjpgHBAhmefxyO4sjFPhwnyVFjnxQz27gN/eRle29ZpwwNAfh6/9cdBf57fGR
         ybzGfilpuLQ5DaBrpyqJrNxs1wh7rRx07jZPbH4hvGUP/T3SKUBxkVJiS+XAlCGdHaxo
         ElGg==
X-Gm-Message-State: AOJu0YwnPrV+1pSGElWChhEVT/N1pVtXYTGjvmRHASODX3WT42of1D0E
        jIXflQd8Ze1UxNRK5uZ1TJCyCg==
X-Google-Smtp-Source: AGHT+IF1vTtQmZmjoesEJZrqkYgP/y3LHSOgrezoy4k2OY+Q9+3+C9SJphKPSqsypKeip90h5fH/aw==
X-Received: by 2002:a05:620a:1a83:b0:76f:1846:2f6b with SMTP id bl3-20020a05620a1a8300b0076f18462f6bmr2662819qkb.1.1699971215392;
        Tue, 14 Nov 2023 06:13:35 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:34 -0800 (PST)
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
Subject: [PATCH v4 04/20] riscv: hwprobe: add support for scalar crypto ISA extensions
Date:   Tue, 14 Nov 2023 09:12:40 -0500
Message-ID: <20231114141256.126749-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the following scalar crypto extensions through hwprobe:

- Zbkb
- Zbkc
- Zbkx
- Zknd
- Zkne
- Zknh
- Zksed
- Zksh
- Zkt

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 27 +++++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  9 +++++++++
 arch/riscv/kernel/sys_riscv.c         | 10 ++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3f71da935a65..3a18a31e32c3 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -83,6 +83,33 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZBC` The Zbc extension is supported, as defined
        in version 1.0 of the Bit-Manipulation ISA extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKB` The Zbkb extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKC` The Zbkc extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZBKX` The Zbkx extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKND` The Zknd extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKNE` The Zkne extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKNH` The Zknh extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKSED` The Zksed extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKSH` The Zksh extension is supported, as
+       defined in version 1.0 of the Scalar Crypto ISA extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZKT` The Zkt extension is supported, as defined
+       in version 1.0 of the Scalar Crypto ISA extensions.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index aca5abc7ebee..624abd5cde29 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -31,6 +31,15 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
 #define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
 #define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
+#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
+#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
+#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
+#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
+#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
+#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
+#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
+#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
+#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 7a40145e9628..43aa66e71418 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -163,6 +163,16 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZBS);
 		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZBC);
+
+		EXT_KEY(ZBKB);
+		EXT_KEY(ZBKC);
+		EXT_KEY(ZBKX);
+		EXT_KEY(ZKND);
+		EXT_KEY(ZKNE);
+		EXT_KEY(ZKNH);
+		EXT_KEY(ZKSED);
+		EXT_KEY(ZKSH);
+		EXT_KEY(ZKT);
 #undef EXT_KEY
 	}
 
-- 
2.42.0

