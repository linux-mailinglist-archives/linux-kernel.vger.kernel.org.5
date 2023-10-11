Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BED7C51BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjJKLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346190AbjJKLTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA8E1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so19944915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023166; x=1697627966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDxU+S/2S9Zyokkzv2m0SOvysTHMfn1aGA6JYhknF4k=;
        b=P4jJhMMZ6ZNxm2Izz+fUqWMv9qSRjyYHIfHGSozkxI2BbWtIG9LpgxqLaSrMz3jQty
         drsToi4H3/tpUyukuHxT18zwVn/Ff38bte1ux2BW+0pQxZOV+s+T/aXzUhiOiUObQ/7M
         lAyTjYy6nJSKL+es7SJhVRaPfZdZc5sEgkqLcvdUAdRdEepLzN9c/CsvkaqGYI2JZ/cu
         iuRjZyBXDLu5egzSugkUwkJgxYOYeS4KIv6FHkh2Jb3Oi7BMx0qVspcqy4WRpGc1f7SE
         6CcWqjvZOwNtiEBirV8qxwclfAPBlATTapQBi8JiU7o3vnAuRGDuQr8BUWiJguIdFybY
         e95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023166; x=1697627966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDxU+S/2S9Zyokkzv2m0SOvysTHMfn1aGA6JYhknF4k=;
        b=wXi6oxqm/ZguHJhAU77B7j61DECC8uqWsGopdLFgcb08oLHWPUAX7bdBtR6MXuw5E2
         w2Oa5oLdiS/H67QMbu9KMHlgiYfYwf3Ka1h0wSR3lWDeXRcRSaIX7ghHkGB/SO+KCxZ+
         i34ZyDtkZmw9FiwK3QQL3twupIlZBKpZ/9eQNurXKdC26tj068gyoXEnVbJrFnouerjV
         WL+CDwGMXRR61B4/cOOY+llD3nsMWA8TQ5PcANCamxZgYFsSpdrwSWs6dzP96DSbHszE
         e6uXIuicaFrvj7s7dcbCqUKmvmc0DFKZcIn+6fMKMstUx0Zf0mxskFxjg1Ae/vcWNoxw
         fQyQ==
X-Gm-Message-State: AOJu0YyEqTQA9lLXSzDGIkWHIiYWUrHd3FpQtLEXEfQdz1r+2ycjUw1s
        VwHsIElw29D9ce75rCpdkLVZxw==
X-Google-Smtp-Source: AGHT+IFL8F9ISrFJv94kKo0D+DqyUmKI3p+OtOo8OtLvqm7OkyywkV6XfNe2K2nOJgZP+i+4KXShHQ==
X-Received: by 2002:a05:600c:3ca1:b0:405:3cc1:e115 with SMTP id bg33-20020a05600c3ca100b004053cc1e115mr18775209wmb.3.1697023166187;
        Wed, 11 Oct 2023 04:19:26 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:25 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v1 12/13] riscv: hwprobe: export Zvfh[min] ISA extensions
Date:   Wed, 11 Oct 2023 13:14:37 +0200
Message-ID: <20231011111438.909552-13-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zvfh[min] ISA extension[1] through hwprobe.

[1] https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_riscv.c         | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index a577b1d72dff..c2c3588891d1 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -134,6 +134,14 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
        is supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFH`: The Zvfh extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFHMIN`: The Zvfhmin extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 3c4aa5d01f93..ee68eb90d4c7 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -48,6 +48,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZFH		(1 << 22)
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 23)
 #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 24)
+#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 25)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 26)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index ca17829f3e16..63e123314524 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -175,6 +175,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			CHECK_ISA_EXT(ZVKSH);
 			CHECK_ISA_EXT(ZVKSG);
 			CHECK_ISA_EXT(ZVKT);
+			CHECK_ISA_EXT(ZVFH);
+			CHECK_ISA_EXT(ZVFHMIN);
 		}
 
 		if (has_fpu()) {
-- 
2.42.0

