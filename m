Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40B7C51B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjJKLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJKLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5AB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so19944445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023158; x=1697627958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v10+31krjXZc/qlT0HyTU3dzvB5HQq7PuU+rQhdNiSY=;
        b=JwBfh4gkgMG/XlwmLTCpBEirYpCPCxa2tV/WJzLxb4QHnuvhUvsrdrXOIKU1B1ECVI
         lhaxgC/YoxzzvOAWaLZfdMGrP+1L4GkxWJK1O4vI+SRbZ2aBv9MWyvCrCKKKCE8XiXTg
         AFMTIEC7WRSd6nxy5oJbqQMZ3wzrmqQXHHtVLhU1nxef+sqAPj9MNTl59hFbCxuPVy1l
         5NF/MJWY//JDTvuK86kbtnOpkRBB49j5dn66dMf2iacvxYW5rqRSy9wsFKQWsyf2fvYh
         Da6wgGcmpVQOTznMsQ7epvrNmgSGnCedrDmAk8BXM7TEPQRGDqidwDptMxfb2q9kJPze
         0fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023158; x=1697627958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v10+31krjXZc/qlT0HyTU3dzvB5HQq7PuU+rQhdNiSY=;
        b=M2Wh96jg/Q4nKPUgKkw7U3eOIh0T+fZuC9u+gLUlltdLL4DySL7P6RD9QXgeybDPOi
         Trv9vBpQkZ8UoGrD+pPqPQj3gZa0cy1EDHPWHKkCJ7rjlCd3XpJnBovhE3UCBQa4oUkw
         DGHS9QPc84nnGWbuB6QZfP1iuZ6RmHAeegCq1WBJzSsD+AF4FUCNuNJQu16FhoDDXnRI
         3oEcVqABtsa9ilR7cRbfrpNTVu8+ITXg4UAl8xz0xayrloUvg0jKHpl1TYphZk500lFl
         EeZDeiclHiZ5UcU8HTz4Pm+csTAC1MCVhG+7Hmi0O/3u1MXFGsXBt26+OiwzKPjHxAT7
         u8zg==
X-Gm-Message-State: AOJu0Yzd3SxX+7QOogzNZW2P00F+NUB5H2WQ/AxQbC6a6ndbFlAoS0mv
        pM1j/fzaLJIaUuzAZtu8IlV2Cg==
X-Google-Smtp-Source: AGHT+IFNRKBFCJ+sq9h6X2aRCAID+o1DHOTC+J5HSWPZUWo4633mGqFeaz/hdUQyMTe8ebdkfymsdA==
X-Received: by 2002:a05:600c:214f:b0:406:513d:738f with SMTP id v15-20020a05600c214f00b00406513d738fmr18787455wml.2.1697023157473;
        Wed, 11 Oct 2023 04:19:17 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:17 -0700 (PDT)
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
Subject: [PATCH v1 04/13] dt-bindings: riscv: add Zv* ratified crypto ISA extensions description
Date:   Wed, 11 Oct 2023 13:14:29 +0200
Message-ID: <20231011111438.909552-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Zv* vector crypto extensions that were added in "RISC-V Cryptography
Extensions Volume II" specificationi[1]:

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
 .../devicetree/bindings/riscv/extensions.yaml | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cc1f546fdbdc..4002c65145c9 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -246,5 +246,101 @@ properties:
             in commit 2e5236 ("Ztso is now ratified.") of the
             riscv-isa-manual.
 
+        - const: zvbb
+          description:
+            The standard Zvbb extension for vectored basic bit-manipulation
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvbc
+          description:
+            The standard Zvbc extension for vectored carryless multiplication
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvkb
+          description:
+            The standard Zvkb extension for vector cryptography bit-manipulation
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvkg
+          description:
+            The standard Zvkg extension for vector GCM/GMAC instructions, as
+            ratified in commit 56ed795 ("Update riscv-crypto-spec-vector.adoc")
+            of riscv-crypto.
+
+        - const: zvkn
+          description:
+            The standard Zvkn extension for NIST algorithm suite instructions, as
+            ratified in commit 56ed795 ("Update riscv-crypto-spec-vector.adoc")
+            of riscv-crypto.
+
+        - const: zvknc
+          description:
+            The standard Zvknc extension for NIST algorithm suite with carryless
+            multiply instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvkned
+          description:
+            The standard Zvkned extension for Vector AES block cipher
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvkng
+          description:
+            The standard Zvkng extension for NIST algorithm suite with GCM
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvknha
+          description: |
+            The standard Zvknha extension for NIST suite: vector SHA-2 secure,
+            hash (SHA-256 only) instructions, as ratified in commit
+            56ed795 ("Update riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvknhb
+          description: |
+            The standard Zvknhb extension for NIST suite: vector SHA-2 secure,
+            hash (SHA-256 and SHA-512) instructions, as ratified in commit
+            56ed795 ("Update riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvks
+          description:
+            The standard Zvks extension for ShangMi algorithm suite
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvksc
+          description:
+            The standard Zvksc extension for ShangMi algorithm suite with
+            carryless multiplication instructions, as ratified in commit 56ed795
+            ("Update riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvksed
+          description: |
+            The standard Zvksed extension for ShangMi suite: SM4 block cipher
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvksh
+          description: |
+            The standard Zvksh extension for ShangMi suite: SM3 secure hash
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvksg
+          description:
+            The standard Zvksg extension for ShangMi algorithm suite with GCM
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
+        - const: zvkt
+          description:
+            The standard zvkt extension for vector data-independent execution
+            latency, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
 additionalProperties: true
 ...
-- 
2.42.0

