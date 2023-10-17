Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BBA7CC45D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjJQNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbjJQNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6798211B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so18306305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548541; x=1698153341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HAW94BWBN5i9ceq6FqY8wdNnvu4aG0cSFSkPmGNLOw=;
        b=L1oyLJWZhrk/cE3FkrHFuJhb2oHjFDDui8MA9/Vulh75w3b1tR2iGxG4jwsnS2LfK9
         V6qqbnQ+l+H3i6nDZDtzcVtH7AYmF1zTQkg4kCJR2+gSGVpDHG4x/74Ju7AmoaiTaFfd
         Yw6sNfvxbKpV2yz4olFOLyAfvRwqHE4LAaRDICvSCh+UkOXKz1obUPdmVsT+GROeuVPt
         eI7WIRJf35X574I1JnFPbj9dInfJWHIuevO43OQohKU5jBKT+u0uGgiArSjPDTW1heDq
         C53njOksvltnuR22SRVTqoyA10YOqL1suFrQRCf7GgFUBgI+H3Cyk00DCLnjyinK8VyY
         l7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548541; x=1698153341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HAW94BWBN5i9ceq6FqY8wdNnvu4aG0cSFSkPmGNLOw=;
        b=ol4k6Ft0DUTbHiPoy1zIzUeGoutSnf8Wr4nGaTebQWGyO2MGWqGCA0IodkdrV3+lEu
         GpJc2jv1H7s4Z2Df1FeGsc105Tvy7XU4XaLePXJyFX7W8bLJ+P5ABRA3UY91WBGMzL2z
         YqaLyH7ETgkdBSW5n01NcdQ8WXKKtHty0VHZgb5kZ0x2fKSAAlqVU/agBuKBX4k+2Ftw
         BOeU2FmXuZOdp8wq42JfwxUe4wN0erydkUzxCapj4tj+vFuPAn1JkrkT4p9hFOyTISar
         Q9Rb2+vDSdSY5VRqAN3RrxfAnl/nq7yWNUaWPD5qw4oJl7ht8XS73lGI0bj6Qs35cAO/
         K7Jw==
X-Gm-Message-State: AOJu0Yw961tiWXAbWWd8mN9Hh7ZrberVwI2ItOBOa+JMJxqeayTZxSHH
        tUhNsNicPrQ7UXjYf/FSjijHGA==
X-Google-Smtp-Source: AGHT+IGbBB2bpP6DKx5jv6ntXm18AdT9vWp/ruxSD4Q9u2qImyTRJFK6ZXveoHMW47E7zhir096qKw==
X-Received: by 2002:a05:600c:2145:b0:406:513d:738f with SMTP id v5-20020a05600c214500b00406513d738fmr1640603wml.2.1697548540446;
        Tue, 17 Oct 2023 06:15:40 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:40 -0700 (PDT)
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
Subject: [PATCH v2 14/19] riscv: add ISA extension parsing for Zvfh[min]
Date:   Tue, 17 Oct 2023 15:14:51 +0200
Message-ID: <20231017131456.2053396-15-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
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

Add parsing for Zvfh[min] ISA extension[1] which were ratified in
june 2023 around commit e2ccd0548d6c ("Remove draft warnings from
Zvfh[min]") in riscv-v-spec[2].

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Link: https://github.com/riscv/riscv-v-spec/commits/e2ccd0548d6c [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index a9aea62b6c6f..d9fb782f198d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -82,6 +82,8 @@
 #define RISCV_ISA_EXT_ZFH		64
 #define RISCV_ISA_EXT_ZFHMIN		65
 #define RISCV_ISA_EXT_ZIHINTNTL		66
+#define RISCV_ISA_EXT_ZVFH		67
+#define RISCV_ISA_EXT_ZVFHMIN		68
 
 #define RISCV_ISA_EXT_MAX		128
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0a74b2cdcacf..c70885f5014b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -266,6 +266,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
+	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
 	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
 	__RISCV_ISA_EXT_BUNDLE(zvkn, riscv_zvkn_bundled_exts),
-- 
2.42.0

