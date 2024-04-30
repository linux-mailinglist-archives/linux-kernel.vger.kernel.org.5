Return-Path: <linux-kernel+bounces-163315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE68B6956
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6031C213BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053912B79;
	Tue, 30 Apr 2024 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SUo28tdh"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C372101C5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450118; cv=none; b=T5TR9nxDbY1Ug4PZ2tMSQMofRaVfBCuvONdJM8erSZjaQmW3r2Ma+ccIokNr/fy2rj9BzRCS7G2epEUE3I9UJvgTW0XeVWQkvywRBLG//iLom5hj130dbmmu9fJuDiS+Hqbhh8URP1dX6Abyei0+HKayeZ1hdYjxDmKtlLbbvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450118; c=relaxed/simple;
	bh=tG0gR3luXw6co1uV9l6dsdMa/PsBDGFgb76VFuZxDFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PFQbxIj6aJ8uDXowl2lZsio+ZTCpM1z68URQkHouf1/D7Vzq89IwjVdMeA9qiRanIm/fv4sv1zzZq2JlU85aqxwmL9W41K6P0+jF7qJ0oLxltL4/13FccXuAmRZXUZnx/MiAIBMUnYM6LE63s48dH1tmxDHru6qiblJUF5aH1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SUo28tdh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61be4b9869dso9180667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714450114; x=1715054914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCslZkcQd5RtLXYuX+Nd2JyjWr4Wgb6SjvGmoz0L3zE=;
        b=SUo28tdhAw0hJRAOpxEmJPb9T4IQL0OQxKfDiiNkLYszBj/tMy6A5IfUEM+a50jiqr
         9VwpxQAaxNEtDLE6D01YMjPzEp0FP9v9NrGQ63oCAO3PBP/VxoB/hPu3sd/ECX/HsWxr
         ff/2z6aZ08hBy8zJtmLLk3zjLX7eaSKRIHyUbT4yzjAap/zwHfVSAmmHATYlMCPlLtgl
         KFyy7AvRFNBN6YEBp1ZYQuJuKiJbe5iBtX3Eby0X/rplxuDSqnIBaNxoV7rXXHFWawWh
         KUFTdIrwdGhjrcfwcBHjzK4npeiL5NieLn31xI48OUrxzBFjc0YziAVt1aK6CIK8rN9l
         DbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714450114; x=1715054914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCslZkcQd5RtLXYuX+Nd2JyjWr4Wgb6SjvGmoz0L3zE=;
        b=KzFje53/Ng09ykjZ0pmFqtxkrxrJR7nq4AfHkSnpTQr9SbAmRPk7qVFOLTk7U7ANnU
         +/8Lr3bfbhvME+mXOpntC5Q7lstYfCPE4+yZTxmlVsysTDNWQFkOTnoiA1wAdUclLgSP
         +O0HEJAMTmc4zu3YXFbRqruWClQ9LSncdmIeb5xqD+b4yq0qdLOnzz/52UmE21YUk5th
         KNvlt1IrvS5MERzCeZf/nwFm2VKUEjLNwVq/fKq7Ef7nX92Gnv6P4LOHG2Duw2GLUV3A
         wKiZl46dFwKHoYVs+azhPMMidCUCXq/db9bj7nI6nDliN1HMQXBlUi1N9lZ4gc1yrAwd
         dHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNcrUZK0qQHvp8FTKk1uXhPp+fwtW5+ES36fTeb8anoDb3+PZBx2QaS+srYuIkDi/yp470wo4HPXj1gObvUE0Uh7A6cLYSsCv/Ujet
X-Gm-Message-State: AOJu0YzfmzK2NiavDobCirZ+8ho3MJVDnINY8vaNTCPYBdjWOIVoG7ja
	tyuVREsTenxEIP5tZOeKElL/18i0NphJmTBWzp1GnRffwu7hfl139Yg0dut56Ns=
X-Google-Smtp-Source: AGHT+IFwAJsZsr7vaGkLxE1T7x6+TzNPPDBiFljXpmorJhrntyhYM0B3aRKRclxB5YSlsfW2NRqwOw==
X-Received: by 2002:a05:690c:6d03:b0:615:8c1:d7ec with SMTP id iv3-20020a05690c6d0300b0061508c1d7ecmr11997230ywb.33.1714450113146;
        Mon, 29 Apr 2024 21:08:33 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id i190-20020a0dc6c7000000b00618876dc75fsm5694002ywd.27.2024.04.29.21.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 21:08:32 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3] of: property: Add fw_devlink support for interrupt-map property
Date: Tue, 30 Apr 2024 09:38:22 +0530
Message-Id: <20240430040822.1133339-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the PCI controllers (such as generic PCI host controller)
use "interrupt-map" DT property to describe the mapping between
PCI endpoints and PCI interrupt pins. This the only case where
the interrupts are not described in DT.

Currently, there is no fw_devlink created based on "interrupt-map"
DT property so interrupt controller is not guaranteed to be probed
before PCI host controller. This affects every platform where both
PCI host controller and interrupt controllers are probed as regular
platform devices.

This creates fw_devlink between consumers (PCI host controller) and
supplier (interrupt controller) based on "interrupt-map" DT property.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
Changes since v2:
- No need for a loop to find #interrupt-cells property value
- Fix node de-reference leak when index is greater than number
  of entries in interrupt-map property
Changes since v1:
- Updated commit description based on Rob's suggestion
- Use of_irq_parse_raw() for parsing interrupt-map DT property
---
 drivers/of/property.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a6358ee99b74..7326ca07adfe 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1311,6 +1311,55 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
+static struct device_node *parse_interrupt_map(struct device_node *np,
+					       const char *prop_name, int index)
+{
+	const __be32 *imap, *imap_end, *addr;
+	struct of_phandle_args sup_args;
+	u32 addrcells, intcells;
+	int i, imaplen;
+
+	if (!IS_ENABLED(CONFIG_OF_IRQ))
+		return NULL;
+
+	if (strcmp(prop_name, "interrupt-map"))
+		return NULL;
+
+	if (of_property_read_u32(np, "#interrupt-cells", &intcells))
+		return NULL;
+	addrcells = of_bus_n_addr_cells(np);
+
+	imap = of_get_property(np, "interrupt-map", &imaplen);
+	if (!imap || imaplen <= (addrcells + intcells))
+		return NULL;
+	imap_end = imap + imaplen;
+
+	sup_args.np = NULL;
+	while (imap < imap_end) {
+		addr = imap;
+		imap += addrcells;
+
+		sup_args.np = np;
+		sup_args.args_count = intcells;
+		for (i = 0; i < intcells; i++)
+			sup_args.args[i] = be32_to_cpu(imap[i]);
+		imap += intcells;
+
+		if (of_irq_parse_raw(addr, &sup_args))
+			return NULL;
+
+		if (!index)
+			return sup_args.np;
+
+		of_node_put(sup_args.np);
+		sup_args.np = NULL;
+		imap += sup_args.args_count + 1;
+		index--;
+	}
+
+	return NULL;
+}
+
 static struct device_node *parse_remote_endpoint(struct device_node *np,
 						 const char *prop_name,
 						 int index)
@@ -1359,6 +1408,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_msi_parent, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
+	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.34.1


