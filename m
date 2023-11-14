Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BB7EB1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjKNONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjKNONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:13:41 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09C10D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:37 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-779f81223ebso9061285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971216; x=1700576016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj3F7r4bXKdKcLl3zXhsKyMtAAaQ3OyO+btxNZcVTGo=;
        b=KQovk5T3zyZjqWs9fop4fBE8ix/blBR8Kp4r6eow32o3h3UwbFOoHpKfWHMaotKX+j
         OyQ9xMQI5CpH0UItqcK2k/+E6z3aS4yY2IoalqEQiQ51IwXfCooi71tU2pY6TGdQxDxG
         DJjZK/J6lmUqJU5L5zjcvNrMEb8iCKKF/QgLNqANVrQYv/4xmFPKp/513cXhUTEKJbi4
         Y5EL6ywCf71XfDA+KyOYc1a20FvsRoDk/DJ7t497g8AFQw+2h0HAGyc9CDa595aWxKuR
         r9V1TfSKkZmlWyphFH7M49fmUgduPkWJwNIgLq8OwplbjYor/a3kiaROi7Ka4KhYo5Tn
         2eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971216; x=1700576016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj3F7r4bXKdKcLl3zXhsKyMtAAaQ3OyO+btxNZcVTGo=;
        b=lfmTKFidLqV9RH+SK+11z9cltpLgg/+w6MlGPVocxUyr6ms7Ln3ZYCczzE30APZcYL
         YsUzUSMBEpihbKObr4WC4fud6Ihat/NsSBUAyliPmmHHBGjXxQTXefyz5RSr08YHLbRX
         piPwkw8VlM9kMFQd68I2oz2dT6gkUGpXYB3rsNjlE0TMFTGXQzxpLiEajNNuvVChKhNi
         rp0UTz6LP3DgPgmajYIIoDeVob1TnDwXM3IVfNWBK/2/VhWV+NZVXgfFgLgbJZKJ77CN
         gCzOPGQ4L74KC6M+8Bs6GC+pV9MxEThpq351UquFfEVyG2R9gCkI4/vI5OxxdVMALaWR
         cQuA==
X-Gm-Message-State: AOJu0YzUjN7I1ZOBY88ep7wr3d9pYLeq10abTRjhtEOqOg8KTMglWr6J
        KnMjXjE+hovA/RIYQd5Q8uSCsg==
X-Google-Smtp-Source: AGHT+IFh0Kg7TsQGIegnmes1+Kqf8PJcacK9no05PQKvW4IVexEI0Bnw1hLpRCsL4VG1Y2MfFWnXFQ==
X-Received: by 2002:a05:620a:460f:b0:777:7178:ebf0 with SMTP id br15-20020a05620a460f00b007777178ebf0mr2719131qkb.5.1699971216721;
        Tue, 14 Nov 2023 06:13:36 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:36 -0800 (PST)
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
Subject: [PATCH v4 05/20] dt-bindings: riscv: add scalar crypto ISA extensions description
Date:   Tue, 14 Nov 2023 09:12:41 -0500
Message-ID: <20231114141256.126749-6-cleger@rivosinc.com>
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

Add description for scalar crypto ISA extensions:

- Zbkb
- Zbkc
- Zbkx
- Zknd
- Zkne
- Zknh
- Zkr
- Zksed
- Zksh
- Zkt

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index c91ab0e46648..a3803b22cf4f 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -190,12 +190,92 @@ properties:
             multiplication as ratified at commit 6d33919 ("Merge pull request
             #158 from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zbkb
+          description:
+            The standard Zbkb bitmanip instructions for cryptography as ratified
+            in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zbkc
+          description:
+            The standard Zbkc carry-less multiply instructions as ratified
+            in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zbkx
+          description:
+            The standard Zbkx crossbar permutation instructions as ratified
+            in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
         - const: zbs
           description: |
             The standard Zbs bit-manipulation extension for single-bit
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zk
+          description:
+            The standard Zk Standard Scalar cryptography extension as ratified
+            in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zkn
+          description:
+            The standard Zkn NIST algorithm suite extensions as ratified in
+            version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zknd
+          description: |
+            The standard Zknd for NIST suite: AES decryption instructions as
+            ratified in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zkne
+          description: |
+            The standard Zkne for NIST suite: AES encryption instructions as
+            ratified in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zknh
+          description: |
+            The standard Zknh for NIST suite: hash function instructions as
+            ratified in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zkr
+          description:
+            The standard Zkr entropy source extension as ratified in version
+            1.0 of RISC-V Cryptography Extensions Volume I specification.
+            This string being present means that the CSR associated to this
+            extension is accessible at the privilege level to which that
+            device-tree has been provided.
+
+        - const: zks
+          description:
+            The standard Zks ShangMi algorithm suite extensions as ratified in
+            version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
+        - const: zksed
+          description: |
+            The standard Zksed for ShangMi suite: SM4 block cipher instructions
+            as ratified in version 1.0 of RISC-V Cryptography Extensions
+            Volume I specification.
+
+        - const: zksh
+          description: |
+            The standard Zksh for ShangMi suite: SM3 hash function instructions
+            as ratified in version 1.0 of RISC-V Cryptography Extensions
+            Volume I specification.
+
+        - const: zkt
+          description:
+            The standard Zkt for data independent execution latency as ratified
+            in version 1.0 of RISC-V Cryptography Extensions Volume I
+            specification.
+
         - const: zicbom
           description:
             The standard Zicbom extension for base cache management operations as
-- 
2.42.0

