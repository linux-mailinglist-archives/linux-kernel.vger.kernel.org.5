Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544DE7B0AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjI0RAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjI0RAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:46 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4D11D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-573912a7b14so5885113eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834043; x=1696438843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG1tzQTVssTuSgiTai6pnkMjirZbD31EyyHGMhy1at0=;
        b=oz8YwNkXzxa/AUErObOaWGyGXiDiswFNYN7Fwl9q0a7MfldAH9jO+WT96ROcPmvn6s
         efXi40i9PnfRhzmjv3P/q53voqkGwj+o6qgCBEPIAs3eLFrfz+XqrTvsPaD+mHQ36iBz
         8LTMRVWs6xbi3s0No1yJlJPhR9ORfDZ4G9TMoiolkqMiXZeigkdZrukz+XYkuTqAjklt
         /po9aampApisNVfsIqu9r84988GEy4GFbvrHzsJDce+9SBMTn1/zV+Y5kUL8S0RW6W0H
         8iWUfhYS/8xrrAwLv3kJMQFA7vx6PgQzBn9w6NkcWZdjTBM9erO0utKDmns/pBWZMnzd
         gchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834043; x=1696438843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG1tzQTVssTuSgiTai6pnkMjirZbD31EyyHGMhy1at0=;
        b=cx6If4VRU6mPQd01LXVf1bDWT0N1jEyv2HfV+1tKnX2U1n1cBpepU3xc6sRvPf7Ohc
         2Z4v/3J43zCqSc408Z+ofBNkU3hrcvmIX3Gr8SWK7riYgScCelioH7zaDJ/hNnMSLkW6
         kv6TwhZIjyLMmyOnOAnIH893UXJCYQdBiOZylhlZZ6hpnpgRpWzTW+lcbvx8uOrYphK7
         BhBQXlef0AM8E6yVMO6jxzvgLibozpvNKD/ymh9p+wPB8TyULKjL82EFSoG9rGS9pZFQ
         xk72NIb1+GIedwYnWeQyhaRzYGdZsfxcx8H25vUphAYIZjwb1NuH70OqIqDC+ikudG6n
         aaog==
X-Gm-Message-State: AOJu0YxGCbQOcplzvh0JutcxkYDw5XU07lpvjhffJOqrxpseOGwY3GA0
        Xl9u7eNaxr83ZqTB0p73W95qeA==
X-Google-Smtp-Source: AGHT+IH2up4xMxljyN4RO8Rex07vnVaVsd5wurJeyXI53/ysue+JrRu8yCN5i5l+jkbhAsdY+6qfwg==
X-Received: by 2002:a05:6358:7e84:b0:135:47e8:76e2 with SMTP id o4-20020a0563587e8400b0013547e876e2mr2445601rwn.4.1695834043334;
        Wed, 27 Sep 2023 10:00:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:42 -0700 (PDT)
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
Subject: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu
Date:   Wed, 27 Sep 2023 22:30:15 +0530
Message-Id: <20230927170015.295232-5-sunilvl@ventanamicro.com>
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

The timer capability to wakeup the cpu irrespective of its idle state is
provided by the flag in RHCT. Update the timer code to set this flag.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 9c8f3e2decc2..06f5bad3c3e0 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
 #ifdef CONFIG_ACPI
 static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
 {
+	struct acpi_table_rhct *rhct = (struct acpi_table_rhct *)table;
+
+	riscv_timer_cannot_wake_cpu = rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU;
+
 	return riscv_timer_init_common();
 }
 
-- 
2.39.2

