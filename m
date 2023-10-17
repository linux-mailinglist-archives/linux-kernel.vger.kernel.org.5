Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C67CC438
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjJQNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjJQNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E5101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651b22977so10009715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548530; x=1698153330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqzQqudrOmKdgPr+5kkAbNTAOkDmuCSsNahqqxSrIB4=;
        b=kn3DEV2GYB7zgpXEIRbqMnlCKTY5Tds8RYlpLDdEXiNVrLTT5NPrMnW6srz8VdPV82
         yK0jLXad9pkY21CBfb6lBYZ6ShVkwgnN+6xye5YOCzp5iF/Mvej+TvUIMvy7cc+ZwL24
         Jj5bsq8U/yMFYNCZ9/00SHL5lhntwoCoYhrHiuondGQN2AsgDlpFAGnpZ3gP2Xb2k9y0
         kggdw0Ujh3FTun859X1Jvhv4K3SPpHgiXKjJc7Wkx1NymKc5QS9uGO/U3XDreX6KqZ+m
         wNav1FltW4UuSUZjrZiyACgR1RCG7ugaSfd8hxmnTvrH+QRSFiUZgtmbwXP/lo+F+RUg
         FbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548530; x=1698153330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqzQqudrOmKdgPr+5kkAbNTAOkDmuCSsNahqqxSrIB4=;
        b=TAkfiqlPAa2RgkexBU04K5OF7E9C8h4xxm83ONEY9YrtSv62dFpaPis0wDePMtAIXt
         LHg52891jyAIwka0CaJjfqBp7vocbYjH4nn0RP4pMFPFttPDePD5pRaRPBksX7eDb8nE
         nRPW1aRLzkvo4x9uV9iI7LMgAYDOOI/BomuiPsgo4PuOFzlGWW902Ii/w9PrIgcgAJEt
         Xu5+XrlIG6DiqPjDpe57xvM34K538NNBfIj5XesQerkHInZYTTT7fd8cchdFtbAiOhvC
         1zcBsFZDI5Q8nTEFs0AB25ZVlwWnnkKw2K1rSWhMr4SkFoucqwMphOq3Ulk4KJp5KM6u
         WleA==
X-Gm-Message-State: AOJu0Yxmm+FV9UUQ4r3uQ2LAZJ9OrvjpTYthwRmuK+LGg22mo8iAb0ag
        QzBE76LsYeYbPfTNDpPDIBwqSw==
X-Google-Smtp-Source: AGHT+IFuiK0BscipghK4RYkQzti/mPrcDXl70SOegEbHvKn4LGsMNFWB7Gd04l4vTX5sw5MKMQyeFw==
X-Received: by 2002:a7b:c44c:0:b0:407:52f0:b01a with SMTP id l12-20020a7bc44c000000b0040752f0b01amr1637775wmi.2.1697548530461;
        Tue, 17 Oct 2023 06:15:30 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:30 -0700 (PDT)
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
Subject: [PATCH v2 04/19] dt-bindings: riscv: add scalar crypto ISA extensions description
Date:   Tue, 17 Oct 2023 15:14:41 +0200
Message-ID: <20231017131456.2053396-5-cleger@rivosinc.com>
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

Add description for scalar crypto ISA extensions which can now be
reported through hwprobe for userspace usage. These extensions are the
following:

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
 .../devicetree/bindings/riscv/extensions.yaml | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cc1f546fdbdc..96ed3d22d3c4 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -184,12 +184,89 @@ properties:
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

