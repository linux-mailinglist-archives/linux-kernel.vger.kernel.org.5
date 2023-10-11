Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74F7C51B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbjJKLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346089AbjJKLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232CC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406532c49dcso17186335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023165; x=1697627965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELrfmr7/+eL4h+O/hGMHN5n5h58B6vu8kUgBEeprKDM=;
        b=JwV/jeoRE8dXiEwdRSx01ibal7orBV/WcFAnPyz7D5Y/HBzKwGwfDbqrr07JeRe3cA
         gxWqDxydGrs7Fku6fkli/Rp19klM9dD5EfzZPlidAd/LV+SdSjJpgs/7dPh0eWikXKzD
         JIN3gZNnjtrWeEnSVFMpzJ0QCgcGPIoCZp8aH7Vxb+f9LQ/ASkH0JeCdCwFw1M0ydT0B
         v7im0MlJhGLIbSqXO/GQ9GQUGtWwKlkzmJd9voK8qiqnbuV/eIeyyBvh1y66J/61o+xt
         u0NUsKnJreqUM1yXVqP9yoHXZ2aADJSj+f7zf5+pC6XgzN0YTn5Muafwiqa4FAYTJzAZ
         G34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023165; x=1697627965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELrfmr7/+eL4h+O/hGMHN5n5h58B6vu8kUgBEeprKDM=;
        b=KeqsG9xof56Gxouos3JvgPY7MLsxooeIN5A7cBuEnzxhxiutejfUmm8b7od9VsGwPq
         CmCvDm1UegJlAxa0QZb9To8NBBIEXmELssnvRqXGvY5ubzeLQsIIIcAFqgRRu5F6cALX
         UcCJQWYGksB+m8B710qJDBD3hRUojDy6GyrdUW9Y+OtMPCj4WotfjQFZ38SbrtF783ix
         uH7G2RHPoRaOwGjk0+tz3ah4orkMtC4edAMyAwIaAwsqWWDtj6J7KbhD1QnfpokBrMTX
         xUFNdkmGl738M5ouWj9hBS6grmTtILdtwcrsN+Kbj5I5+My54dFtHS6qqVd/8Ny/uc3V
         nO5g==
X-Gm-Message-State: AOJu0YyMdLCyD4Yq8fJGWq9hXuoK2I/xhobiVOid1QP/2V2bgHeHJoGj
        pcSHmUJ7VnU68qsTYIwTv8dZbA==
X-Google-Smtp-Source: AGHT+IE2y/iGfOk9x0FcfGmLs9von/gSyi9IxV8X3T9o1LjNrBHKENRhq76JY7LxinEZmPIgMRylzA==
X-Received: by 2002:a05:600c:5114:b0:405:4127:f471 with SMTP id o20-20020a05600c511400b004054127f471mr18363952wms.1.1697023165036;
        Wed, 11 Oct 2023 04:19:25 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:24 -0700 (PDT)
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
Subject: [PATCH v1 11/13] riscv: add ISA extension probing for Zvfh[min]
Date:   Wed, 11 Oct 2023 13:14:36 +0200
Message-ID: <20231011111438.909552-12-cleger@rivosinc.com>
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

Add probing for Zvfh[min] ISA extension[1] which were ratified in
june 2023 around commit e2ccd0548d6c ("Remove draft warnings from
Zvfh[min]") in riscv-v-spec[2].

[1] https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view
[2] https://github.com/riscv/riscv-v-spec/commits/e2ccd0548d6c

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 1f09b8b3da2a..ea141cfb8f9c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -77,6 +77,8 @@
 #define RISCV_ISA_EXT_ZFH		59
 #define RISCV_ISA_EXT_ZFHMIN		60
 #define RISCV_ISA_EXT_ZIHINTNTL		61
+#define RISCV_ISA_EXT_ZVFH		62
+#define RISCV_ISA_EXT_ZVFHMIN		63
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 136e90263ba2..f17b9aca5fba 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -179,6 +179,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
 	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
+	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
 	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
 	__RISCV_ISA_EXT_DATA(zvkn, RISCV_ISA_EXT_ZVKN),
-- 
2.42.0

