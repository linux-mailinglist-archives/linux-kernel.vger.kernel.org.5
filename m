Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F77D7585
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjJYUZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjJYUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:24:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890610DE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so129349b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265489; x=1698870289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bjA2IFkbvQ+cjwZ90V9r6vmNOzBSbezE1qJqMO1A+c=;
        b=eJujG6QRF1LoqNfAqafA4JP/kq7hTbjci2TIo9bHxvPUlxqdX/zQcNl0n6qfWEyjut
         5CtQ2sPrekj/5bfbgo8qQK9MGC8/B0e5NtB5BDxQbRXVnc4aIb/tweaYpQf6JKA/BIJb
         rucTEkR+rs0lOGJoWuWG7sgy2LZLnlxlmgrSClK2IHBzB+v2H9jFLHJpbXASppyFAVcK
         kj0G3gqmO40Aqlxj8Z4LKnqmiq/z8GKI6UQkv1Y1w5a8dJoXoly0r4CGsRZy4dYotPjo
         IyYFZIytQmcY2z3HDtKnJYF2xaGF509bS6t9YxW/zPkRmcEtCrGGA/Ol7rBIFQjWmuIe
         EFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265489; x=1698870289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bjA2IFkbvQ+cjwZ90V9r6vmNOzBSbezE1qJqMO1A+c=;
        b=ah0pN2JjhKYBWYUVgm6p7dZsSdzZSwi6zk36OvPbKje6hJhnS9cXt7QBPCNYaqzHwV
         yw5K9ZKKHTI72AAEa7E1E1eTZ7iPp+iV8UGdtRzn5eCFwFBe5qsePr5okY1drDvgbAn5
         zwERAhKVHlCZjQ9rcFa0FTRnHzEkjqPahhV2/QxSshetF4CI/82Z40+AM/CNQZEykIjQ
         N6GyJ/27oeZ0BZBuzcDbLbyPtPgKadrbtxbPxvoVrZS9FPjCkRhKiAxpGMoNtWQUTbwL
         pgJc19T1qxdWyefD/wclKXb8k3pjY5suMCvzzMOHfUU4e3uNsMXSjnE7xycOLbrtTIwm
         VfYg==
X-Gm-Message-State: AOJu0YwE7RfxY1nGxHp4ChyvKjEak0QCejjzZlQpvkyaxkkz5Mdx9pBz
        b8X6glkQdmpBABiQWnKilgwlIQ==
X-Google-Smtp-Source: AGHT+IG0SpgdyiZkoMurZXPLkoY/g9K3mifAR/RprvidWByJ+cvRjgFm+eLWR/dX/aORh+7WvaUdiA==
X-Received: by 2002:a05:6a21:33a4:b0:17b:3cd6:b1bc with SMTP id yy36-20020a056a2133a400b0017b3cd6b1bcmr8121322pzb.14.1698265489371;
        Wed, 25 Oct 2023 13:24:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/21] serial: 8250_pnp: Add support for deferred probe
Date:   Thu, 26 Oct 2023 01:53:30 +0530
Message-Id: <20231025202344.581132-8-sunilvl@ventanamicro.com>
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

With pnp_irq() able to return error code, enhance the serial pnp driver
to support deferred probing. Return -EPROBE_DEFER when pnp_irq() returns
the same so that the driver probe is deferred.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..dcb3daf7c816 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -8,6 +8,7 @@
  *
  *  Ported to the Linux PnP Layer - (C) Adam Belay.
  */
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pnp.h>
@@ -443,8 +444,21 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
+	if (pnp_irq_valid(dev, 0)) {
+		ret = pnp_irq(dev, 0);
+		if (ret == -EPROBE_DEFER) {
+			struct resource r;
+
+			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), 0, &r);
+			if (!ret)
+				uart.port.irq = r.start;
+			else
+				return ret;
+		} else {
+			uart.port.irq = ret;
+		}
+	}
+
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
 		uart.port.iotype = UPIO_PORT;
-- 
2.39.2

