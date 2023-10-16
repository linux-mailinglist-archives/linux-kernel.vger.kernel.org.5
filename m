Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88D87CB118
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjJPRJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:09:50 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D0FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:09:48 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57f02eeabcaso2992951eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697476188; x=1698080988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6AuZhMJdIdvOw1LD4IXAZJtQuk3yEBuC1IpwOZAs8Q=;
        b=EBV9mw4OOf3rs3uBrSRun1VhzjHHXFUpNg9lieAM1nZnqLvLpquXkXICkE9wrAH/j1
         wGMQkZ3Q9p2FCBALM4SPP320yKDJuPuUlqMbjJDUFPdQy6BvqnD+pVY2wT31Hs2cfE5f
         xTh7LkIkY97CxL558hresqy8AD4sIefOnmJrYE5rj8nbHPS7mGu5BhU0eemGAET8uH5X
         7oQyFq3v5HORLN98H6+SPc2RFatspukNICLlF9eRieV+auvsgFXp4q7lGkJI3P8OdcIm
         V7/XbUVax3wJyduLg59LdexEIO13mGBoJTj4vVRiJ5PcDGNxSbT+Dd3mhF18hzxoipCV
         MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476188; x=1698080988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6AuZhMJdIdvOw1LD4IXAZJtQuk3yEBuC1IpwOZAs8Q=;
        b=aYwPC7F31OOIEBHgQRvRgS/OlV6mYjPs6QSF2LSu8NSOmseIPP+WBbmnQE58pNDVa6
         TFtJRuG6Rtj5mZuTmWhVffRVRZCxu+W2wyCTrsV4QHOVHqtGszAAX+NNPow6bX8cR9xB
         tRp5t0rRiwB6DQC6PIqPhbCD/7EaLEGqy28Bkb/E6RfpcayqYJbaXb6iaAd3TMqijI0S
         vu0rrhVPA0oL3z0zRnuBs50ka1/KFeW4MogUu3YkDNwnfCk2s22iw6J+KwJ03fKsY6lV
         n7fu4XC4NRd7Akh/R9F11zyosrDDDAHEPvfu0xL/coBszIesDUBEzM0lWMpuAwyWYjr7
         fTkw==
X-Gm-Message-State: AOJu0YxcBEBmgsZtrs9pXPwfLG/KtqcJ+Sb4ptC0+k4vFRex2bpNY9co
        e9EAQeKTNXTPVhfNowPj/whiZA==
X-Google-Smtp-Source: AGHT+IGSbX9vMK3agaj90fIsWAJz/6r105PRLFK5J/Ls+bVX9/obgE1QyAyGTBKmK/HRo7fgNP4HWQ==
X-Received: by 2002:a05:6359:6604:b0:166:d143:36c9 with SMTP id sm4-20020a056359660400b00166d14336c9mr75146rwb.0.1697476187978;
        Mon, 16 Oct 2023 10:09:47 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id f64-20020a625143000000b00690fe1c928csm145888pfb.147.2023.10.16.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:09:47 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] ACPI: irq: Fix the incorrect return value in acpi_register_gsi()
Date:   Mon, 16 Oct 2023 22:39:39 +0530
Message-Id: <20231016170939.1192260-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_register_gsi() should return negative value in case of failure.
Currently, it returns the return value from irq_create_fwspec_mapping().
However, irq_create_fwspec_mapping() returns 0 for failure. Fix the issue
by returning -EINVAL if irq_create_fwspec_mapping() returns zero.

Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/irq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c2c786eb95ab..403f33df66af 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -57,6 +57,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int rc;
 
 	fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
 	if (WARN_ON(!fwspec.fwnode)) {
@@ -68,7 +69,11 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	rc = irq_create_fwspec_mapping(&fwspec);
+	if (!rc)
+		return -EINVAL;
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
2.39.2

