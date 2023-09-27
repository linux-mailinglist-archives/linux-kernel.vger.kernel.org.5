Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23F7B0AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjI0RAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjI0RAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374B136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8198ca891fso12986713276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834038; x=1696438838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMRAaYbpAL9AMr/u9386eJc3P6IZIKKW5n+xTVSQNsU=;
        b=Mh7SszRtl5oB5ZhDY6oUv6VoramUgJr2e6VFqqApdiB7mY3jrbUk0r5giPalv0LK1X
         BhtZGFJGBG6U8IrVy1k6A0XyGeBFuNK72SnWSZVHcVWac+UwW08PqcN4vXXMhX24MDoC
         uZU56FE6kvWc7c4GWGhKlpfY9RdY1S+2g4tDmOPiJ50zpGzZQ7siUvK82YvN+vUBjGM+
         ZnRjDPH8w6ZFx1yUEDKOLq4wUOmmhGaWBQmG4+8Gvd4eJ0646t4ZVEhR7EFoUFTJ/yf8
         naQPTgTe6+fUsYrtmdoxCPsYu4gAIuIFoMhpepV4AsmZKvoYRjxNI4+XBEvlVzTXJ/VZ
         vYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834038; x=1696438838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMRAaYbpAL9AMr/u9386eJc3P6IZIKKW5n+xTVSQNsU=;
        b=odeT8SOIekmjZJzylw9IuQQZPeVkF/7xYhAitiTkDNwzRCq9xOPgnvmeSLvTQwJQBT
         F7KKgk9u2yNFXwPq5PemLZGJP+HDoCjV1uvCxfNyeiN42bM41jdTfJhCgjZ/mPeyWkXO
         kdW/29iZyV74OgtHfGT2ErBU85XhbGYT9fgLdzC12NC611AMy7vQu8+f6GxD2mjN7CBj
         NdKeYOmxsKVUsDw3fqC9NqQO21jwM95WpYnXbNXICOgWprNrKAcxdAPOYTgDA2MCBfAV
         ahgtKpT9wK1s4gXxeJnwu/rJCdGZu2fOm6G49M2/ZYcvPwGjG08u75/AlQMu52c489nR
         izig==
X-Gm-Message-State: AOJu0YzQUTYLNnPc2t1w0hbv5qBXn+1+PLdUZ+BIqhNx2MnerppRudvZ
        esHRMfW5F8M35oyz5zp2vrZcKQ==
X-Google-Smtp-Source: AGHT+IGIJjabTi91p7r9FbrKe/nbsuosloqVsE93l/TK2lD4q6KXezQH+Jjl+BXIXV4t5YLkLYlm6A==
X-Received: by 2002:a25:6b4e:0:b0:d86:a964:a47e with SMTP id o14-20020a256b4e000000b00d86a964a47emr2382069ybm.63.1695834038194;
        Wed, 27 Sep 2023 10:00:38 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:37 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
Date:   Wed, 27 Sep 2023 22:30:14 +0530
Message-Id: <20230927170015.295232-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927170015.295232-1-sunilvl@ventanamicro.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using new interface to get the CBO block size information in RHCT,
initialize the variables on ACPI platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index f1387272a551..8e59644e473c 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -3,7 +3,9 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
 	unsigned long cbom_hartid, cboz_hartid;
 	u32 cbom_block_size = 0, cboz_block_size = 0;
 	struct device_node *node;
+	struct acpi_table_header *rhct;
+	acpi_status status;
+	unsigned int cpu;
+
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
 
-	for_each_of_cpu_node(node) {
-		/* set block-size for cbom and/or cboz extension if available */
-		cbo_get_block_size(node, "riscv,cbom-block-size",
-				   &cbom_block_size, &cbom_hartid);
-		cbo_get_block_size(node, "riscv,cboz-block-size",
-				   &cboz_block_size, &cboz_hartid);
+	for_each_possible_cpu(cpu) {
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (!node) {
+				pr_warn("Unable to find cpu node\n");
+				continue;
+			}
+
+			/* set block-size for cbom and/or cboz extension if available */
+			cbo_get_block_size(node, "riscv,cbom-block-size",
+					   &cbom_block_size, &cbom_hartid);
+			cbo_get_block_size(node, "riscv,cboz-block-size",
+					   &cboz_block_size, &cboz_hartid);
+		} else {
+			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
+						&cboz_block_size, NULL);
+		}
 	}
 
+	if (!acpi_disabled && rhct)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	if (cbom_block_size)
 		riscv_cbom_block_size = cbom_block_size;
 
-- 
2.39.2

