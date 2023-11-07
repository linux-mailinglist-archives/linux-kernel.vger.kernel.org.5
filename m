Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8097E3A97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjKGK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjKGK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:23 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F5D79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c52407516bso12182561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354577; x=1699959377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4s/6qoHBJWx8IDkipxLTMx5qIdSuDP9Fhxnx/OaR4U=;
        b=vPmItZM7nGGK6tzGcRAfDMCs8+OzzYEq9jsUudufmqf1/Wu5Edle1cnt3fIZ0F6XRz
         HLtyB92zp8Ol8LNLrEmHEhxS63jSEpLZkLrVH8oY2EBcpzHun4F+OCvM+yZxi6FnpAnC
         fGCNLBNI6Ka0hhwfeQtBjkT7S8IhtB4nCeWQa46bCCaIY6wLTeJGpnYkm/EOX3DRa1jS
         f2SlStsC+PrN0/AoK3gkVFndmljVuCWeK9/R721y8YXbTkdbAK5pBoOouqEHTsRcILyn
         6TF6creSbONg4plKxqYvYZpqOOBQ1M32FA2bITa91nEBIUKyicOA1gb2CvKHrM9HupcG
         448w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354577; x=1699959377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4s/6qoHBJWx8IDkipxLTMx5qIdSuDP9Fhxnx/OaR4U=;
        b=aMpj0kdUM2ab3EPRvr4Ndua20zvLgT6pIyg3uwMs2w6jQ1RIPBhoeJlZIkXM55DojM
         HU3qszouEXmWjN/m6Ht6R06pNNLpUDKv+zzMazTE8gW2Lq5aVPoNQsqzaQmJgjrQzD7c
         9zuXdDRx5NT+hzLAWCMJUzFqHiebo9al5FN+0Lz6jXpsJlp9bwMQY+eawYKD6vILshwl
         TWfBfnhnZUn8NfEq3xMXevX38s2KnHEp7WtaZ3Udy2vVc2Pu2SqrnPUK8kK1qscESOdb
         Rq/lTPIvR4Vjgy+hDmm3z5LM/1ocSsP5GUv1GdPrkuwGZgBVOdihBLycBH0Jy8a+170I
         WH1Q==
X-Gm-Message-State: AOJu0YxUYjxMEdcS0+iVMHegTgLBeUpT38lE4A7KZ4y+CAKJ0glc0dfY
        TvQ8ZRHXFRdm5xFXJRjsM+0+0A==
X-Google-Smtp-Source: AGHT+IHavrKs5gCTfWWE/t+GviSN/fOuRjyg21bPxGHplb1KOZPOkEuhUgKCY8nRPYJZqATj3n1jgw==
X-Received: by 2002:a2e:9f10:0:b0:2c5:6ab:b817 with SMTP id u16-20020a2e9f10000000b002c506abb817mr22837219ljk.5.1699354576498;
        Tue, 07 Nov 2023 02:56:16 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:15 -0800 (PST)
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
Subject: [PATCH v3 13/20] riscv: hwprobe: export Zhintntl ISA extension
Date:   Tue,  7 Nov 2023 11:55:49 +0100
Message-ID: <20231107105556.517187-14-cleger@rivosinc.com>
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

Export Zihintntl extension[1] through hwprobe.

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_riscv.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index ce0490e3130c..2f37b26d27da 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -143,6 +143,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZFHMIN`: The Zfhmin extension version 1.0 is
        supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
+       is supported as defined in the RISC-V ISA manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 12680081c602..36c8d073c987 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -51,6 +51,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVKT		(1 << 25)
 #define		RISCV_HWPROBE_EXT_ZFH		(1 << 26)
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 27)
+#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 28)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 486e053a0797..af2b01b0a5b6 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -172,6 +172,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		CHECK_ISA_EXT(ZKSED);
 		CHECK_ISA_EXT(ZKSH);
 		CHECK_ISA_EXT(ZKT);
+		CHECK_ISA_EXT(ZIHINTNTL);
 
 		if (has_vector()) {
 			CHECK_ISA_EXT(ZVBB);
-- 
2.42.0

