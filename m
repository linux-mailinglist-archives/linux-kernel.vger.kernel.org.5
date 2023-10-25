Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA07D75B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjJYU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjJYU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:27:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BE1FD6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:26:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b497c8575aso141146b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265570; x=1698870370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0XhMD4JA6OaCaDrqm344212wQ/hTWt0yHku4ySQPd8=;
        b=ELhgUiqSO15ijqtkNKo8gXyIs2v3nYH3ycMzF2PVLmICPjlm1NWHhdl7Vl7SZPfGhz
         LrEoQsHj7yKFnxBZP8T5llSb5Z29QWyblBkI1vhxBXK/RsjGk1lwHw/5a14nl2pmeFu0
         hJcvfHS2YU3L3rXU4G1cmC2rG+QrJ+fMPpAe/JAhsrmhUYA4h1uV94h/Cmrov5CciGf2
         u5o5JqWD0qhP6EVmPPIgiHDWnnaHvxsp3DA12oCFt++0cc7gaCWWsDgfk0QMrA4Tud13
         O11sJn5eAdNgKmRb0zbqRAlIBufxckv4kvgDcXbxeU6HUQ1NRXLujxPOj9liKRb1doN9
         Yfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265570; x=1698870370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0XhMD4JA6OaCaDrqm344212wQ/hTWt0yHku4ySQPd8=;
        b=wY1qTQBl49vCqPNoK5nukiox93SrVX76bo5if1fq3eqnlfTflIl3Qe6P9WfthTvzmO
         Ez++42o4WmK5NFbceIgYfJZOdwyXqC1r2svRGUYyHRO+/0nqLWipZ8WS3XGTmf5jbvtP
         VxPgDRYRaHIPY091zmkStIbUzEHLQRMvDrYUqzIkt8H03mbSkT3REsckX8+mM/1Zvo28
         jyczXTpQswYxezjEBnyqAaFyUNOfjtjhLXmo2Bv2ov5hHXKe3yMUxD94W9OU8g6mAbW6
         iYpQIGl50/iODqguvSdpSO3MEYco1+bmV/XaUVARQYR9BdojbjC/A1fALJw/DdW+PJOb
         OmPw==
X-Gm-Message-State: AOJu0YwMon80AVQxvRa7dNyhVvDlsVpqgjWHpVGVgm5yz/28t614Nmlt
        pEqBpEnev6Oj/EjFC/hFTE5shg==
X-Google-Smtp-Source: AGHT+IFjlmAHmkBC51cPzJaQWPRY6g5oe+6V9CmrTCMV9Y5zgvaJjhr+jA6O8yL6wxa5uTMIhaBuRw==
X-Received: by 2002:a05:6a00:15cf:b0:6b1:b5c4:a8b0 with SMTP id o15-20020a056a0015cf00b006b1b5c4a8b0mr19858459pfu.23.1698265570741;
        Wed, 25 Oct 2023 13:26:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:26:10 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 21/21] ACPI: RISC-V: Create PLIC platform device
Date:   Thu, 26 Oct 2023 01:53:44 +0530
Message-Id: <20231025202344.581132-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since PLIC needs to be a platform device, probe the MADT and create
platform devices for each PLIC in the system.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c |  1 +
 drivers/acpi/riscv/init.h |  1 +
 drivers/acpi/riscv/irq.c  | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index e7eff7ab1474..c6fd4097e8ae 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -11,4 +11,5 @@
 void __init acpi_riscv_init(void)
 {
 	riscv_acpi_aplic_platform_init();
+	riscv_acpi_plic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 17bcf0baaadb..b4b305d83b3a 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -3,3 +3,4 @@
 
 void __init riscv_acpi_imsic_platform_init(void);
 void __init riscv_acpi_aplic_platform_init(void);
+void __init riscv_acpi_plic_platform_init(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index fbccecdcbf8b..90b0738e2b9f 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -104,3 +104,17 @@ void __init riscv_acpi_aplic_platform_init(void)
 {
 	acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0);
 }
+
+static int __init plic_parse_madt(union acpi_subtable_headers *header,
+				  const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	return irqchip_add_platform_device("riscv-plic", plic->id, plic->base_addr,
+					   plic->size, header);
+}
+
+void __init riscv_acpi_plic_platform_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, plic_parse_madt, 0);
+}
-- 
2.39.2

