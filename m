Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C77E3A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjKGK5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjKGK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:57:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54910FD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50799fe3422so1178723e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354583; x=1699959383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPj7UJhNk4bEKBTXmbiQszNoP65XhPNjIiphPr/bFIg=;
        b=MP36DyflZOKAPqiiUO4zOTIblkY+I3R4Mx6kqJp51cjNnh2IqwlrKCfjDMsDJ7kEb5
         5itall+Eq0m98N2YBS1nXxsuGQoNb+1+RUkrxmI3xYCil+xuyBnEaJOX45o7EQa/lJDx
         9hbi94GfOavnhEYLeamIWM5e2PetTy86ozGev662HSLrK0l3wnr6CSDBDffq8T8N87JL
         SVnONHKpNLfCxRgu9p4wgVBCxvhOfXLcpSYOzUJZvl725+MjEqFyDZbbnx0/9NDDdvQA
         z5RToGxqRAieqQ35yFlbXP56X23Xqf0f3BjzuymXt/qAs+/cN9lzh/RhFJVvDPQqH/mD
         +D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354583; x=1699959383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPj7UJhNk4bEKBTXmbiQszNoP65XhPNjIiphPr/bFIg=;
        b=brPkfGr+Z4qb/Tnrugowrw4FXUKoFymQHM0CO4RApOxywSgMM3wod3l8oHtcRhEOnD
         sLERGVmf/g4cX40WObZj2CejNu0cQXiZ/gmYS0CV4IQAa73KI1SCXUzQzCU6xSMomU0E
         BSXZntIC91IKdmT7ze8qWInI6EhezwlsKptCWTphf2BeXrm/bObPypItE3RsXnX/eaiM
         VxkQSuMelG0zdEOu+ej+K2fv7fVBlP2XI8xndH7skwt0sqZOSzjgEWGH3Ux6uZnWopZg
         lEkzSq0ZHS4Q58YMWyilxpRbMAxknbErZRl9cCP0N0JyBjFPuhq1vDHI+MZClpUWb75P
         3pmg==
X-Gm-Message-State: AOJu0YyRKPpkIlwkpwbYITpX4ie8zed0PJaMdHHlpmJuDSMofMsURnPA
        GosHvUu+GCv1Or3XoJC1JO5lNQ==
X-Google-Smtp-Source: AGHT+IGRA2Jq7n60JiFQFoG9YMwZlINwiDybS35zq6fryGJBSKL1K+FHC6LMZd0w5ZY6D/nx95IeyA==
X-Received: by 2002:a05:6512:3196:b0:502:af44:21c2 with SMTP id i22-20020a056512319600b00502af4421c2mr23556282lfe.5.1699354583017;
        Tue, 07 Nov 2023 02:56:23 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:22 -0800 (PST)
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
Subject: [PATCH v3 18/20] riscv: add ISA extension parsing for Zfa
Date:   Tue,  7 Nov 2023 11:55:54 +0100
Message-ID: <20231107105556.517187-19-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zfa ISA extension [1] which were ratified in commit
056b6ff467c7 ("Zfa is ratified") of riscv-isa-manual[2].

Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
Link: https://github.com/riscv/riscv-isa-manual/commits/056b6ff467c7 [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 752be910e7c3..3fceae60ca39 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZIHINTNTL		68
 #define RISCV_ISA_EXT_ZVFH		69
 #define RISCV_ISA_EXT_ZVFHMIN		70
+#define RISCV_ISA_EXT_ZFA		71
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0b9d16ea71f1..d58c8e9ceb05 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -261,6 +261,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
-- 
2.42.0

