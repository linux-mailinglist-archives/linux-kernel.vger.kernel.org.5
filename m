Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DD7CC45C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbjJQNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjJQNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFE112
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c506d1798eso10177971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548539; x=1698153339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1rHWB6wPm7iXDYEGbhbD+aT0XqxKs0nvsJfpQIGqGo=;
        b=jkN1Ogm7S6sQdClJBzy0QES9thVqUxfXiF9F2SYGnmanBU5tfPG36FJg87aAKWukLe
         5wypRc07Igqnye9M3t62M/ZsFIl5QU/PBpVHshXKdMoMwznzg3m6FkqCWlAwVGyJYOgV
         m9z0vwpYu1U94jVUN8FcJRvHPqe9TOpTGDFFb4eLcw41eOw3WHbl6Y0WK+/7e3n139Zk
         7Zr54o1ds4x11TzFOy4OeFn50kKQsmZZzSCscD6/ra9L9H2+x80Huqzcx6gIS2l4PS0v
         dY79f0SevdFzRBrpvdznCEyLORMkf+DQWnag4MT1fb/MTOYjuj1yt63O+7UzHMEHl4Ls
         PnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548539; x=1698153339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1rHWB6wPm7iXDYEGbhbD+aT0XqxKs0nvsJfpQIGqGo=;
        b=GChwovtWFh5o+dY0VxkaJJuBOf1xbvWzN+75z9oDRTHHX3vEAiykfwa2oabw5FwVzk
         byUz9EtnMOSWeKTIbCd3t5uqJygp46KdLzuNq3OZhScoFI5RCR3jo81gpcaa6FwA2REU
         kNMxBBQrCGxcaJA+ApY+cJ62m/mQM+Qr3dGxvT2D71vC8O4ognmkCajkalykY0+1nbqM
         GKxqvlhyC1GJKKtm25QoVxaf/L7K2+1/tRNS/Udzs85t/ucKWmoWbhcUd7DhqWlAG9oj
         ybyj4Bh51qms8EsuheWTG5qfT4A4T97oPRJwBUdzNbhh5485XMHqSTJBo8L7gDpnE3SM
         H9tA==
X-Gm-Message-State: AOJu0YwOgbTE1gdg84XxN4mzUHP4Ozil8eMXK6uptGLbXHps3BJGr5Id
        fKoM/ykFsmCVaNfUkVZ6vXW8+A==
X-Google-Smtp-Source: AGHT+IE8o+inTRSVUnhN0nXkjkUhZnyVP1Kvn8PbG9YD2TzCATvewF2se7oUMFMIdsxNUL5t0bXQaA==
X-Received: by 2002:a2e:9b4b:0:b0:2b9:e10b:a511 with SMTP id o11-20020a2e9b4b000000b002b9e10ba511mr1660431ljj.0.1697548538766;
        Tue, 17 Oct 2023 06:15:38 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.37
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
Subject: [PATCH v2 12/19] riscv: hwprobe: export Zhintntl ISA extension
Date:   Tue, 17 Oct 2023 15:14:49 +0200
Message-ID: <20231017131456.2053396-13-cleger@rivosinc.com>
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

Export Zihintntl extension[1] through hwprobe.

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_riscv.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 35aedfff5049..9c909e0d5316 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -143,6 +143,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZFHMIN`: The Zfhmin extension version 1.0 is
        supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
+       is supported as defined in the RISC-V ISA manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 390805c49674..dc4eaa978ad1 100644
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
index 4cca8b982a7a..84daaf6ed4a1 100644
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

