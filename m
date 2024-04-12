Return-Path: <linux-kernel+bounces-142582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3E8A2D70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C69281CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0754BDB;
	Fri, 12 Apr 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CIjFB/Wj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEC502AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921383; cv=none; b=GGprfhYt45929C5YoyVHvOHgH4+BFjEf92aKc7v4Dev3QgMCKw1USEq/4DcuGGFjs2sah5MABuCgTEvgZET4sIBhhAaWw5Ks1frQuA6Rs8kLtshvalfeEbe1PRxYU1kr2mnix9S3kLw1n/68cqGIquGPntACtCipLyaxSn3Td3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921383; c=relaxed/simple;
	bh=I3CV3FO9RlyUKYSIF3yGSQYqWWM3IOLuY86OeqBrCKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6q9qe4QDk1yMvIs3UtzE/LH45sIommh0ZnhrXCBLUxofkMcvSYzpNf5R900NSohfqHyvpolC14MNiLvKshtmSYKFOJTLHNX1m73zBKvoCUP5GN+FXlGjJuQ8OUIwpflf0wGMgqbprhRpg09MRO+CapmhV1ln4uE1Ex+upsgMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CIjFB/Wj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed32341906so855852b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712921381; x=1713526181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TANC/O7vA+JiKQebAKkUVF/9/SWuImLeD8ZhsV9CTg=;
        b=CIjFB/Wji2Ce4wUiE7CNuAa5JGmMBujoIDYcpP4TNt8WXoPKA5XaL1lvtpwkjOyXyy
         EAJ4s4d5ixodCY/tjjHhVvQsdCH0NIp/ACX0kMxzshrG/jpw1tnKAWfF+ha1qzWElBEs
         Yc1Dn3Zqy8PNrueCPPyyGhf7Rd8LJZDQ8oAE3j6/Tje8NLe81F5qL11qYDNg542+U0Wh
         075LwEEZBWkhqmmUrSmnj0MXCxQ9/Ip5RgT/X0IgtmVfeVhu4C00YhKqgbzoQXqmy7pj
         3NIY8gFhFM0fHxJuKTUolfCU6rzrsj5eab1FUfCtoV4j/Xb6GT0jdlnm59aRHggtdUD7
         LyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921381; x=1713526181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TANC/O7vA+JiKQebAKkUVF/9/SWuImLeD8ZhsV9CTg=;
        b=Ygoe4YqvKLR4Em+C376zzTkbfeyS/HidJ3znetfPwfDfNgMTQZ2Rlz7mSKmJ+qQAZ+
         Nnjei1td90IxlHqXW5k9qMsh1wqOHEMS3pnBasiqgr+issfAdAzq6y6ZNrRYSfB8BCIe
         9TKj0lkBqkuQ5IblgopBnKyU082jcPEPz/LUsQtAJqOLWJslPsIXOGbh/E7hosmJ+P7E
         Ztuzn+CPc/nbw7e+wVedCDNcb0VyFLGgDd9lRZcyRK5qtW9zALIr5lIKuPvy2Ui6/Non
         h1/CmZ0WrUxOTjbRzrQczGsR4UnBdG2Z8PVLuDZRzBQIjTb3ASN8RtW7UDpNRwAUcODl
         a+yg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwHRfn8MJ7XyT72xCt9g8rIrIhpZDzzRgL7DNF4zXq6na1vjZPkgTua3w7k0DqKvSpTjW8HkA7DJK6b1YJTnxs1MkQxkOWl0QK1uq
X-Gm-Message-State: AOJu0YxCo8y6TmW6o/oevK1Kyw8E4lP+SFbGu1qRyNhOA3VxME68nZR+
	cq2Dh9XuzW8MZcichPuN+RD++xb2kpHQ49GMhkPFbZSJVC3S87YqM5C9S2ZbX5Q=
X-Google-Smtp-Source: AGHT+IHY387bs/fjhRwu7PR3437O21AK+7fM8+la7npbiGwsFsFXlYS6TqYUTcepY2PQZxgsLVeTfA==
X-Received: by 2002:a05:6a21:3395:b0:1a9:9664:ef12 with SMTP id yy21-20020a056a21339500b001a99664ef12mr2609342pzb.43.1712921381190;
        Fri, 12 Apr 2024 04:29:41 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id i89-20020a17090a3de200b002a005778f51sm2832846pjc.50.2024.04.12.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:29:40 -0700 (PDT)
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
Subject: [PATCH] of: property: Add fw_devlink support for interrupt-map property
Date: Fri, 12 Apr 2024 16:59:31 +0530
Message-Id: <20240412112931.285507-1-apatel@ventanamicro.com>
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
PCI endpoints and PCI interrupt pins.

Currently, there is no fw_devlink created based on "interrupt-map"
DT property so interrupt controller is not guaranteed to be probed
before PCI host controller. This mainly affects RISC-V platforms
where both PCI host controller and interrupt controllers are probed
as regular platform devices.

This creates fw_devlink between consumers (PCI host controller) and
supplier (interrupt controller) based on "interrupt-map" DT property.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/of/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a6358ee99b74..ccbbb651a89a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1311,6 +1311,58 @@ static struct device_node *parse_interrupts(struct device_node *np,
 	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
+static struct device_node *parse_interrupt_map(struct device_node *np,
+					       const char *prop_name, int index)
+{
+	struct device_node *tn, *ipar, *supnp = NULL;
+	u32 addrcells, intcells, cells;
+	const __be32 *imap, *imap_end;
+	int i, imaplen;
+
+	if (!IS_ENABLED(CONFIG_OF_IRQ))
+		return NULL;
+
+	if (strcmp(prop_name, "interrupt-map"))
+		return NULL;
+
+	ipar = of_node_get(np);
+	do {
+		if (!of_property_read_u32(ipar, "#interrupt-cells", &intcells))
+			break;
+		tn = ipar;
+		ipar = of_irq_find_parent(ipar);
+		of_node_put(tn);
+	} while (ipar);
+	if (!ipar)
+		return NULL;
+	addrcells = of_bus_n_addr_cells(ipar);
+	of_node_put(ipar);
+
+	imap = of_get_property(np, "interrupt-map", &imaplen);
+	if (!imap || imaplen <= (addrcells + intcells))
+		return NULL;
+	imap_end = imap + imaplen;
+
+	for (i = 0; i <= index && imap < imap_end; i++) {
+		if (supnp)
+			of_node_put(supnp);
+
+		imap += addrcells;
+		imap += intcells;
+
+		supnp = of_find_node_by_phandle(be32_to_cpu(imap[0]));
+		if (!supnp)
+			return NULL;
+		imap += 1;
+
+		if (of_property_read_u32(supnp, "#interrupt-cells", &cells))
+			return NULL;
+		imap += cells;
+	}
+
+	return supnp;
+}
+
 static struct device_node *parse_remote_endpoint(struct device_node *np,
 						 const char *prop_name,
 						 int index)
@@ -1359,6 +1411,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_msi_parent, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
+	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.34.1


