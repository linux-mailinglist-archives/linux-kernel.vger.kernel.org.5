Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC77C51B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbjJKLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjJKLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D64B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso10032685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023156; x=1697627956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IIANjo80zFqhbyLhR/zqKY0ZEpCfYarjbj4J5oFHCU=;
        b=EyJoq/pX4QSeF/AhVnio1RBlLrkrSHENsqPTJCwKYFgEgJiLkEonaeVnFQBAGFmDrD
         BYZaxIJAj1mVIiRNoHrA8bFdkUQ5JIo3ZTk0GKVt3UIf3TvkgYp/n9IIe2qo5giK5KbC
         jEzJlfxJvrF+rO560o0cwmJ223Iloqckc/6Kq+43ryrv3NBl+LmLBk+D/fFo7DtCO2g+
         sbfO3huHpBtmbaGPjokeEgwm/dsGK7ZRNy3XXVwy18AEdSQ4lqAyqp4sBwpQwo+/xdAP
         mbNqoFTvBzd9zcFs+Zy/eWyNPkNY8wAFSz6baOa+1gu1htFZ5cpNfiRI4m7MqNcVlBnZ
         6p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023156; x=1697627956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IIANjo80zFqhbyLhR/zqKY0ZEpCfYarjbj4J5oFHCU=;
        b=umeitMuCV0X0N58GoHpO+L9zChYdOzk4K/Nrd0UeBqe88xTm4LRDnOrnCikrZ/3Rgp
         DHO2w3K8sMnaxnMPH55WvsXYQDdMfdhBd+eVeT8qPUF7o1yooyNvzoyxlEmohPAnF3bg
         HqXI4SNS6/HPOwYzFvjtjjsDwLrIkkXUmLTOhwwAoQry2m2weiZtz6ok8CmjZ5JPJY80
         Qgtuw3kkGsZIcmEHM8yK+lv9KfybOqJBUutCajXAC1s6guMoLS4Xtr9LiQVLvpgMUfhK
         IS4yrVaBGvrQFJqdlcn2HWQmAM9fDDQajIkzqoOjofhkBEi3bjY0E8elTQBtq0KWTDK9
         DxmA==
X-Gm-Message-State: AOJu0YwG6LkMFUQPLLEZQSZoDqdUpS9u5YUhPFnhNuTPHKkNstobJpys
        gAVaJeFw6RQnds7F9v+4Hill9w==
X-Google-Smtp-Source: AGHT+IG/DnLus+yEPlI6bYFmkh9ll2Q+J+N/2Mo1GvXrndFzK7mO/7rr0oVK3NtPpfUMi8b7II3bfA==
X-Received: by 2002:a7b:cc99:0:b0:401:7d3b:cc84 with SMTP id p25-20020a7bcc99000000b004017d3bcc84mr18354424wma.0.1697023155672;
        Wed, 11 Oct 2023 04:19:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:15 -0700 (PDT)
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
Subject: [PATCH v1 02/13] riscv: add ISA extension probing for Zv* extensions
Date:   Wed, 11 Oct 2023 13:14:27 +0200
Message-ID: <20231011111438.909552-3-cleger@rivosinc.com>
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

Add probing of some Zv* ISA extensions that are mentioned in "RISC-V
Cryptography Extensions Volume II" [1]. These ISA extensions are the
following:

- Zvbb: Vector Basic Bit-manipulation
- Zvbc: Vector Carryless Multiplication
- Zvkb: Vector Cryptography Bit-manipulation
- Zvkg: Vector GCM/GMAC.
- Zvkned: NIST Suite: Vector AES Block Cipher
- Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
- Zvksed: ShangMi Suite: SM4 Block Cipher
- Zvksh: ShangMi Suite: SM3 Secure Hash
- Zvkn: NIST Algorithm Suite
- Zvknc: NIST Algorithm Suite with carryless multiply
- Zvkng: NIST Algorithm Suite with GCM.
- Zvks: ShangMi Algorithm Suite
- Zvksc: ShangMi Algorithm Suite with carryless multiplication
- Zvksg: ShangMi Algorithm Suite with GCM.
- Zvkt: Vector Data-Independent Execution Latency.

[1] https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/view

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 16 ++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..4e46981ac6c8 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,22 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZVBB		43
+#define RISCV_ISA_EXT_ZVBC		44
+#define RISCV_ISA_EXT_ZVKB		45
+#define RISCV_ISA_EXT_ZVKG		46
+#define RISCV_ISA_EXT_ZVKN		47
+#define RISCV_ISA_EXT_ZVKNC		48
+#define RISCV_ISA_EXT_ZVKNED		49
+#define RISCV_ISA_EXT_ZVKNG		50
+#define RISCV_ISA_EXT_ZVKNHA		51
+#define RISCV_ISA_EXT_ZVKNHB		52
+#define RISCV_ISA_EXT_ZVKS		53
+#define RISCV_ISA_EXT_ZVKSC		54
+#define RISCV_ISA_EXT_ZVKSED		55
+#define RISCV_ISA_EXT_ZVKSH		56
+#define RISCV_ISA_EXT_ZVKSG		57
+#define RISCV_ISA_EXT_ZVKT		58
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..859d647f3ced 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -174,6 +174,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
+	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
+	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
+	__RISCV_ISA_EXT_DATA(zvkn, RISCV_ISA_EXT_ZVKN),
+	__RISCV_ISA_EXT_DATA(zvknc, RISCV_ISA_EXT_ZVKNC),
+	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
+	__RISCV_ISA_EXT_DATA(zvkng, RISCV_ISA_EXT_ZVKNG),
+	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
+	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
+	__RISCV_ISA_EXT_DATA(zvks, RISCV_ISA_EXT_ZVKS),
+	__RISCV_ISA_EXT_DATA(zvksc, RISCV_ISA_EXT_ZVKSC),
+	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
+	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
+	__RISCV_ISA_EXT_DATA(zvksg, RISCV_ISA_EXT_ZVKSG),
+	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
-- 
2.42.0

