Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B37BC5CD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjJGHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjJGHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:53:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40279A6;
        Sat,  7 Oct 2023 00:53:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af5b26d599so2086692b6e.2;
        Sat, 07 Oct 2023 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665191; x=1697269991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPLzD2hkD9MU2klabOh84epBZjDrW7CkWhrvlEFMKtk=;
        b=DInLP+lp1kwWJLfCfavmUva5aCiPaIhNomt7/kZYuSsmVCbj6pq1RLdAf1KjTa1XFf
         cDqAx5BK/62hu3uONRHoIoe4Xz7QRcUGMtRT4xrvd/+RCQZ6CEA2kwfMG/ojUFNPgmBE
         zBzOdu5bcVNPZ2hOqMFXlgx9lDKus/z4Ppj9zbRHV5XAL2uCPEbjO1aVW8tYbGL0ifDv
         2awXEtyoW9boq3MsKWuLdoD7ZozBFS1PopjZpDUzxz0BZRHRTLx/rDDqCLsqmrSvFpJ+
         UoUArmN3XUtctIshCLqrDUYcfHTXVzxlGNdlMbsEDEFdiIOKBZgY+kWxXeT12RCledGv
         l1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665191; x=1697269991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPLzD2hkD9MU2klabOh84epBZjDrW7CkWhrvlEFMKtk=;
        b=d6PyqPbvdvYPLhAe6zsVOK61Ti/2G4cDD/inDZVuL91QM985aveLaG9PeyxS1tB/dR
         ZYfu5jS+y5J9MGLhabnagCUBEuEpBwRUr8IJVv8LZCUyJ7ywhOa+qXOmvn8pvjWY1Vqk
         7waSFnyq2Fz75JDtGKi4940xXYSFHNx6NsbuTXu1FsnE1cTnk3OCTt/veEtN9ZiaKe1N
         Lwp8vrt8LZOT2HQvf44iBJ59b1pFjxN9xAByiM7yEh4gS0ot/5qMd5tT2kZiI5Y3igT7
         0pUVeeyUF/ehFW5vuKS7bDr3qA5yr2wC9JNHHOXfswknRtj2DceNOUapmvM/6rR6EGNp
         yOnw==
X-Gm-Message-State: AOJu0YziS1XciF/zGFs5gHYBndfuN7tiq+NQJFoHvDh3uFXOuVu8FZMI
        qvRhgB1g8OlavLe8KOkJl68=
X-Google-Smtp-Source: AGHT+IF90SEF/9uAJDyn7auQaHMcJBrhzHwtye3fd7EXka+UYbPfkQHg+Q2+JN9512tghxsVKCg9Ow==
X-Received: by 2002:a05:6808:1309:b0:3ac:f107:52b with SMTP id y9-20020a056808130900b003acf107052bmr13272546oiv.2.1696665191524;
        Sat, 07 Oct 2023 00:53:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id i1-20020a056808030100b003a9a2362f66sm871601oie.16.2023.10.07.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:53:11 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 01/10] riscv: Add SOPHGO SOC family Kconfig support
Date:   Sat,  7 Oct 2023 15:53:04 +0800
Message-Id: <15d8e87c4595c30b3b55522de9894b352c2b58e8.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6833d01e2e70..d4df7b5d0f16 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,11 @@ config SOC_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	help
+	  This enables support for Sophgo SoC platform hardware.
+
 config ARCH_STARFIVE
 	def_bool SOC_STARFIVE
 
-- 
2.25.1

