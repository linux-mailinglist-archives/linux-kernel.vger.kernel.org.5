Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1F7CC45F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbjJQNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbjJQNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0756EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c52289e900so3532211fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548542; x=1698153342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtPMZdfKNirfdqr6CT25Ry/Z9PXKAMnWV/SarPOTmxE=;
        b=vUzuwDjFpK8zXlw7NNPao3q6RfPmFGKv5CB8ColfSfqcO/TziBYC1RV6RSloiJ15v/
         1InahkhlsDf4ELmPB5Ys/kuCZBZw/FM4bUs27hJTR6c9ySP72CMNfSOxuZqIBDQtaCxt
         v7uCEdUu3t7oauDrxqm8BN3fNEmU2pn/QWf8gSsL+5tRefjqTFMgo8/o8chp2oGt28wS
         /+9OxX/oElkvQ55VUCiwLv4ohYMqFRUFJdlj8TLL3b31rLc/1BrX9sWrv98RIsxO0AbA
         Ubvqgt5mK32umIAnUW5UaR8nbLV6oX3i9x/+tuyiO5uIkOYxxuEuzTbW5qu5hbYSZq81
         aM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548542; x=1698153342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtPMZdfKNirfdqr6CT25Ry/Z9PXKAMnWV/SarPOTmxE=;
        b=PrVGRxQsxVsDvgB44V7a5QqpfaS2a0aNkwPj6vWiJSi1wDXv6tA9abV2ThMNGKU5+q
         5/3C1ZUXstPC22FKzcoMuJTj5Zz2Pd7whPGfBQNm6K0O5DkxiK4VfBhSAExuPhYEeK87
         h36KkBl1nO1Y1QAHrjhsZLKaEt264zJGQTE8aWs099qYEgs0yImuvylcputlWLRXwo2y
         NuZhwF2EPrMpglGcYeg3SENCH/7a/iArfEiHK5AfihA4CfGtxPDgANn3UDshpxosW9Tl
         2GEOm7CjcCafDU7tAanQvCJte9rH+87oKwwRb0ii4tdKyLcBkjGl6Sq4C5kMQbJmZMn7
         cjrg==
X-Gm-Message-State: AOJu0YxkSxwnxZDMvPgvTOLs7LRcACW1uzOXeJ7uXHUZGpHVbCR7rpRa
        wJ5t3SkZjf3ZYonPQZc5GhKfEA==
X-Google-Smtp-Source: AGHT+IExgz+Jty8kJFWoAX6Xk7Uc1rKCCTHS2Tyfw+6sRSdA20AS2nN44InvEEqP/AyJZhlfjEW/6w==
X-Received: by 2002:a2e:8745:0:b0:2b6:cd7f:5ea8 with SMTP id q5-20020a2e8745000000b002b6cd7f5ea8mr1903128ljj.1.1697548542173;
        Tue, 17 Oct 2023 06:15:42 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:41 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 16/19] dt-bindings: riscv: add Zvfh[min] ISA extension description
Date:   Tue, 17 Oct 2023 15:14:53 +0200
Message-ID: <20231017131456.2053396-17-cleger@rivosinc.com>
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

Add description for Zvfh[min] ISA extension[1] which can now be
reported through hwprobe for userspace usage.

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index eb4c77b319fb..07678564f11d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -354,6 +354,18 @@ properties:
             instructions, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        - const: zvfh
+          description:
+            The standard Zvfh extension for vectored half-precision
+            floating-point instructions, as ratified in commit e2ccd05
+            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
+
+        - const: zvfhmin
+          description:
+            The standard Zvfhmin extension for vectored minimal half-precision
+            floating-point instructions, as ratified in commit e2ccd05
+            ("Remove draft warnings from Zvfh[min]") of riscv-v-spec.
+
         - const: zvkb
           description:
             The standard Zvkb extension for vector cryptography bit-manipulation
-- 
2.42.0

