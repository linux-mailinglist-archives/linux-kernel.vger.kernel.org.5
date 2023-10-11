Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D517C51B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbjJKLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17CB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso18558375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023161; x=1697627961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1iP2iExuR7IS677Qe2UFfmGvnhfXBRfGhWxe/84qUE=;
        b=FtzyWwHLdVl19Qm0uB4F6Ikpk+6kODJHbGZd1t91pnFPAXJ/5QFcXwDH9zGjWKEKmN
         Da+xtBBDjwDWzvCv4LRyxyXpyUNVR9FYVJYbQmaBK83GbzaGNrGIOfAxo6Zk3CM4ZdfQ
         5mmK6Z9CSVnknCH7xMGc547s9J/b185OAYt5gjpVpiYPZbUEtgtLVr+JMH+6BY2Hd9LZ
         RI53SYul7NPHUQb8A1xHAUK+b//YbBWYlThPZFWKCpLg7xZe9gQeozHDun302zOOcAWv
         KOGAd9z15K4VA8vmd8Plpjn8GT0UZzuA84BWKRb05GHkxvEzNGNZ269YkYvGH4ZUEK83
         4iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023161; x=1697627961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1iP2iExuR7IS677Qe2UFfmGvnhfXBRfGhWxe/84qUE=;
        b=QUnH+v1jBdwHKxJgVMn/6e4Tg6ZN3kc/VrPloiTr/eGU3moVtlNtcnJHADyHK9Ymtu
         yn4Tzw32T0DGlZ0RzZZtyWkpDryB1FLi2C2vOnTM0QNAu1nfr5QkyXoq0yvufbtpHSXW
         b1eO2YlUR5SmY5l15gk9Tcym6Wrjuy9gpOjoDAwTdnsiE62VA9IsJtesImcYcCM5dmHz
         Rsn9JcMXuyG3Di0pzby0o0SlF0vua9+CWSiVzh3i7VE+6HkjYy4589qfo47UIUSWi/F9
         hIn60jUvk6FfVKXrRce+VQ/M+QXF7tSjqIk/wu9syo4bLI3w9EpQj+5bTGy0AGl6KxTm
         RA8Q==
X-Gm-Message-State: AOJu0YwgXAOZ/K3zDkfE7R4Z7rM1/dTIKdjpZnucOi0ITkIFmSsUUx42
        hy+RuBuVC+REuaL6WpFl7Lu0NA==
X-Google-Smtp-Source: AGHT+IHN1jrPE5e/OFNBPSwpg81Ym2JZZudWxgKZK78wyWJftAy9XEh6ziseuRa2e9MUXZKDACfVXQ==
X-Received: by 2002:a05:600c:511d:b0:401:b53e:6c3e with SMTP id o29-20020a05600c511d00b00401b53e6c3emr18807477wms.1.1697023160607;
        Wed, 11 Oct 2023 04:19:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:20 -0700 (PDT)
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
Subject: [PATCH v1 07/13] dt-bindings: riscv: add Zfh/Zfhmin ISA extensions description
Date:   Wed, 11 Oct 2023 13:14:32 +0200
Message-ID: <20231011111438.909552-8-cleger@rivosinc.com>
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

Add description of Zfh and Zfhmin ISA extensions[1] which can now be
reported through hwprobe for userspace usage.

[1] https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 4002c65145c9..4c923800d751 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -190,6 +190,19 @@ properties:
             instructions as ratified at commit 6d33919 ("Merge pull request #158
             from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
 
+        - const: zfh
+          description:
+            The standard Zfh extension for 16-bit half-precision binary
+            floating-point instructions, as ratified in commit 64074bc ("Update
+            version numbers for Zfh/Zfinx") of riscv-isa-manual.
+
+        - const: zfhmin
+          description:
+            The standard Zfhmin extension which provides minimal support for
+            16-bit half-precision binary floating-point instructions, as ratified
+            in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
+            riscv-isa-manual.
+
         - const: zicbom
           description:
             The standard Zicbom extension for base cache management operations as
-- 
2.42.0

