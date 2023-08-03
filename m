Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2676F154
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjHCSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjHCSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:03:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC554221
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:01:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f8614ce5so1119541b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085709; x=1691690509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F92frfK1dVqJ4xjy+nPCRdMbjnNZ2BaLZfo5RMrgYGc=;
        b=nb8MJ8FxfTXSyHfmc46NJ78oznoJARBEyZYQLu78F886UEH05u96pGX7PrrDE+ABPy
         g7Q9FL6hPeKgIvk1x1g1QIiXUI+eSCTn4U5OllRWdrxcoVajrrjHY50vfrwXSfjJ56rj
         kDL+iKNMiAcr3+BY7DKMcKwbrcyTolBMjohszwHk8Iqo0oHT6OJUhtHPMDjrZMpsSVf8
         do6JnoL+oBRfutMZgfrvxiD/OLmiQhPDP+a9oLSuKJQQ+mEjyNMxYQbZ5QXaBFSdRNqr
         cB+pEseV+eVkFLVS2cVDEpQHb3FQjnP4sNhw8f1RnohhupWYwX5f1MNKLJwhFIFeh8bb
         Vzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085709; x=1691690509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F92frfK1dVqJ4xjy+nPCRdMbjnNZ2BaLZfo5RMrgYGc=;
        b=fhvjriz++IYfpfaA2HhKSBfhb8k7gY54/lPjqB9jje3Vi7QlAB0wotwU6nJLqui1Hp
         KGBZf7uSkoOhXEWf3BKYD8VdyBe4Sz1OMPiJbA0YWJUEfaJs8yMghizTxZk9V5TFzfll
         MGBKRst5tJnI8pNzv0G/EgUvOAZ4OkAiEDntd7ihOAb8BXMX9EJVyt773DStLB5HqThZ
         63iIo0Fz5OKWWFmv62s/hhIzyyt0ErsNE/ifcUk2zIEv7ECTpPvO1VdhGTze6l3QK7vY
         kTmPYmQOiovu7fOVnb2IMqLaEfY58oIzl57AidQpyenAqeJoUFkhsW7IEngjwITumaeT
         yMiA==
X-Gm-Message-State: ABy/qLYRakBkviFgp2TBk2//37+mkDUh09RpLFfgjGYZ3jiWSV4ZTyEA
        JSN/twV/apOXL0bqlFDP0EfYTA==
X-Google-Smtp-Source: APBJJlF693fygn/wN+Kw+cdkTi4UZipebFggWTsaaGrmDPSMtSqjJpJsaZGp1ItDXnGYwlZwJ/3sSA==
X-Received: by 2002:a05:6a00:1887:b0:687:7a30:deb with SMTP id x7-20020a056a00188700b006877a300debmr6591488pfh.15.1691085709034;
        Thu, 03 Aug 2023 11:01:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:48 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 18/21] irqchip/irq-riscv-aplic-msi: Add ACPI support
Date:   Thu,  3 Aug 2023 23:29:13 +0530
Message-Id: <20230803175916.3174453-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Search and configure the MSI domain for the APLIC
on ACPI based systems.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 086d00e0429e..1948444c9e0c 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
+#include <asm/acpi.h>
 
 #include "irq-riscv-aplic-main.h"
 
@@ -178,6 +179,8 @@ static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 int aplic_msi_setup(struct device *dev, void __iomem *regs)
 {
 	const struct imsic_global_config *imsic_global;
+	struct irq_domain *msi_domain = NULL;
+	struct fwnode_handle *msi_fwnode;
 	struct irq_domain *irqdomain;
 	struct aplic_priv *priv;
 	struct aplic_msicfg *mc;
@@ -261,8 +264,17 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 		 * IMSIC and the IMSIC MSI domains are created later through
 		 * the platform driver probing so we set it explicitly here.
 		 */
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev->fwnode)) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_fwnode = acpi_riscv_get_msi_fwnode(dev);
+			if (msi_fwnode)
+				msi_domain = irq_find_matching_fwnode(msi_fwnode,
+								      DOMAIN_BUS_PLATFORM_MSI);
+
+			if (msi_domain)
+				dev_set_msi_domain(dev, msi_domain);
+		}
 	}
 
 	/* Create irq domain instance for the APLIC MSI-mode */
-- 
2.39.2

