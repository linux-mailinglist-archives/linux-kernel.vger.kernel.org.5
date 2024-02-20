Return-Path: <linux-kernel+bounces-73051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAE85BCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC11F21DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568E69E1F;
	Tue, 20 Feb 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwc4M9lK"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A496A345
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433990; cv=none; b=AaHstkneXBdvD2AG0P0UXL54BWzyxE6+DfZSrRcCp9nWTgsj7bOic/NRdN8u6qjYzlEM8+qu4iJmqGnNKa7bdmMNVZccfDPeyeiKbIWVEzG/Xd2BV8jTE1yKE7U0OkZDgBtpB7h1x/wJg5767PT40eh+2cZqeNzBXbEW/xwXfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433990; c=relaxed/simple;
	bh=nayKkuhvG1Dli/fXM3yzhraHyVpFQwyP32fuBFL+G2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlJu0FqfZDLrgSWaydvgJ6m+cHpmZTLYupPJ+k4y7VHR8oAKAYaNArr59R3JGDiUjsdiCOkTzPfE5vaBT9GdmXAhTtcF10Cc7Ekf86fwfdta+HcL5mG25tFROkvw6ELfR2J94YGQ2ll6kfb6n/ZvYD5my1Qka7RSxFH3VLYUQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mwc4M9lK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso7628684a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708433983; x=1709038783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9OrK6S3zQq0bQPjr/h/eXyHiGvgQFDhwyWwZmeLScA=;
        b=Mwc4M9lK+VzOl9F5U7NMg+o6H9cahhvgKjN7zrQ+BKlKmUS3NQbPjADhE4O6iYDn0m
         /AlwAr3aReOeLmoS+94EUQu15oYS1OTTh7NkrXkerRJzRk7LVfkbnQImu1k0eG+YKVsd
         I3lFrV5GN2p86kfH5q9Hy5AEjzRGJNJXvGS2sz7VF10kJu57Mye3ofX1QEsp5OaeGxzv
         FZICSGCuBI/gbRJwvw06/8SzsuuPVKDb/SbQ9FIqDqQwbEHno29Eo/otXRWSUqf278qy
         xl9zoiLXWnJb0tqzd0PtnF+UGOFpC+eRvc52DnRwhRPqtmPs11bzGy97VjNTz9HD2DgR
         Skrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708433983; x=1709038783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9OrK6S3zQq0bQPjr/h/eXyHiGvgQFDhwyWwZmeLScA=;
        b=Z0RoDftXFdm+LeRKpG7OMgoNZ611pDHUP8qLazgs+pwaC/nSBdj+EsnLuRot8ioi2F
         eFh+w+9vB76bdX7yK6IhwV8VL3jOpm0WvFXmpbY+CATr5ZwNAOrAMlg/Jwr8x1wLe4Bt
         /kfz++H9Rb6tfY5Vs/eDUx3iJYz6Q2GR+pNjzmKR28Nt+UoOAQNcyd6OxJarjd9hZQ9M
         nBxNP0hA7bQgc5eRW/ccNnnjzk/cCQ9SdDw/XUiQuOzFJUojB9PaXNPz6SYkEtIcndMr
         Kzqx6wWMJOkI2cfhKhoPyuXm4gK/OIy5GZiweZpDuZpiPGGU+GT50WK3VLCIkkIB6ur+
         OXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVDsux4slo6F8kMFspVT1LCnMmqHxtfET/VDXs//7bUb5nIUCFSJpA7IgKlyMi4JYuCgGay7rKyiJBFUDmOQL88npAYhgrxYhoOMZRs
X-Gm-Message-State: AOJu0Yz2K4GoHiGLTYTZ+9zWfLdRqRRk7yWyvz9upsKawvA0BudO3Ap2
	xj5wso+gX01ycz31c5qdizfVKCPCRWy7HIHglqgr0N1lH6uBeKjTqg+XvZ4V+Qw=
X-Google-Smtp-Source: AGHT+IGVa7K9p7S/jB+3ceWu4bIkOFaByNylaYItPSpvFDpcAZ/ms5kMnr8frmyvZz1wne4vkIx94g==
X-Received: by 2002:a17:906:743:b0:a3d:ca8e:d98d with SMTP id z3-20020a170906074300b00a3dca8ed98dmr9074701ejb.43.1708433983079;
        Tue, 20 Feb 2024 04:59:43 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id rf23-20020a1709076a1700b00a3ce36ce4f9sm3948802ejc.83.2024.02.20.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:59:42 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 14:59:24 +0200
Subject: [PATCH RFC v4 4/4] spmi: pmic-arb: Add multi bus support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-spmi-multi-master-support-v4-4-dc813c878ba8@linaro.org>
References: <20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org>
In-Reply-To: <20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=54951; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=nayKkuhvG1Dli/fXM3yzhraHyVpFQwyP32fuBFL+G2o=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1KI2wnFtUDezR1eDOEX5hley/6tPxO0SET847
 rYaOeDvH7qJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdSiNgAKCRAbX0TJAJUV
 Vl8oD/9AZarTczMrzB5tEqoo/srDAN+bqdFnDxmc3+7FZzVPCPJoo8l6ODLuoeWB1DdlWVKQIlx
 Ia3b06tjZ4guRZH9VjFOFDYN7PZzLNdwPUZF4QaurIONPCQsA6Grou1EjLMeD6hS8J5L7cwb8Ha
 ZegKHLUx5TG8/HIxmBwoXWPPRHzRVsVeAj+TRQ5QCLjh8SQYTK938M3NQ0b+vHxCKkzadcXQ44K
 i1Qqjo5sXijk+eVUVLGpllgzJkCOugRGiuPiJcDJ9EKBQib0ZD4uxeRZBKNoKiZoBplfTvQ+4Lb
 v3r+BLYdA6UQQQYBNjnmedbM6k42uILQmuutaLDE9ltl+3L1nXNBjpaAx2gUva50g3rnvReqbjD
 uSt3nDMwTz15qY0aiJe5QpdHXpOybGSH+skkerV1e9CEzFXBq2VklrvJfs7zVZLvZdSyghoOx4P
 4nvWLhmbPlEofy3Gj+MPsO6eo3qhVKwA7Z9KOhgIyn6zjk4cuSwu0xjGB+lUrkrWr2u9BXc/1rf
 xphnRLpWxTyCCje/0+fEIl1iBv5Zc8MUHPcvgMNtS5qqDBU0QD6yT8bkJKAxuJ/5jfjBysYLEnx
 MSTpTGxginWcwfPvXo+TXXjK2pQ5kLLpt+znzKbmmxyikfcgXUlj/QbGL6YCqwD101tZTgxJDGZ
 AMT7XCf1PXZtyCA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Starting with HW version 7, there are actually two separate buses
(with two separate sets of wires). So in order to support both
buses, we need to register a separate spmi controller for each one.
Add a separate compatible for v7 only, but allow the legacy platforms
that have v7 to still work with the old one, for DT backwards
compatibility.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 727 +++++++++++++++++++++++++------------------
 1 file changed, 430 insertions(+), 297 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5aad188a3db2..1fe95e96c045 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spmi.h>
@@ -94,6 +96,8 @@ enum pmic_arb_channel {
 	PMIC_ARB_CHANNEL_OBS,
 };
 
+#define PMIC_ARB_MAX_BUSES		2
+
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
 #define PMIC_ARB_MAX_PERIPHS_V7		1024
@@ -125,58 +129,68 @@ struct apid_data {
 	u8		irq_ee;
 };
 
+struct spmi_pmic_arb;
+
 /**
- * struct spmi_pmic_arb - SPMI PMIC Arbiter object
+ * struct spmi_pmic_arb_bus - SPMI PMIC Arbiter Bus object
  *
- * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
- * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
  * @intr:		address of the SPMI interrupt control registers.
  * @cnfg:		address of the PMIC Arbiter configuration registers.
- * @lock:		lock to synchronize accesses.
- * @channel:		execution environment channel to use for accesses.
- * @irq:		PMIC ARB interrupt.
- * @ee:			the current Execution Environment
- * @bus_instance:	on v7: 0 = primary SPMI bus, 1 = secondary SPMI bus
- * @min_apid:		minimum APID (used for bounding IRQ search)
- * @max_apid:		maximum APID
+ * @domain:		irq domain object for PMIC IRQ domain
  * @base_apid:		on v7: minimum APID associated with the particular SPMI
  *			bus instance
  * @apid_count:		on v5 and v7: number of APIDs associated with the
  *			particular SPMI bus instance
  * @mapping_table:	in-memory copy of PPID -> APID mapping table.
- * @domain:		irq domain object for PMIC IRQ domain
- * @spmic:		SPMI controller object
- * @ver_ops:		version dependent operations.
  * @ppid_to_apid:	in-memory copy of PPID -> APID mapping table.
- * @last_apid:		Highest value APID in use
  * @apid_data:		Table of data for all APIDs
+ * @last_apid:		Highest value APID in use
+ * @irq:		PMIC ARB interrupt.
+ */
+struct spmi_pmic_arb_bus {
+	struct spmi_pmic_arb	*pmic_arb;
+	struct irq_domain	*domain;
+	void __iomem		*intr;
+	void __iomem		*cnfg;
+	struct spmi_controller	*spmic;
+	u16			base_apid;
+	int			apid_count;
+	u32			*mapping_table;
+	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
+	u16			*ppid_to_apid;
+	u16			last_apid;
+	struct apid_data	*apid_data;
+	u16			min_apid;
+	u16			max_apid;
+	int			irq;
+	u8			id;
+};
+
+/**
+ * struct spmi_pmic_arb - SPMI PMIC Arbiter object
+ *
+ * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
+ * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
+ * @lock:		lock to synchronize accesses.
+ * @channel:		execution environment channel to use for accesses.
+ * @ee:			the current Execution Environment
+ * @min_apid:		minimum APID (used for bounding IRQ search)
+ * @max_apid:		maximum APID
+ * @ver_ops:		version dependent operations.
  * @max_periphs:	Number of elements in apid_data[]
  */
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
 	void __iomem		*wr_base;
-	void __iomem		*intr;
-	void __iomem		*cnfg;
 	void __iomem		*core;
 	resource_size_t		core_size;
 	raw_spinlock_t		lock;
 	u8			channel;
-	int			irq;
 	u8			ee;
-	u32			bus_instance;
-	u16			min_apid;
-	u16			max_apid;
-	u16			base_apid;
-	int			apid_count;
-	u32			*mapping_table;
-	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
-	struct irq_domain	*domain;
-	struct spmi_controller	*spmic;
 	const struct pmic_arb_ver_ops *ver_ops;
-	u16			*ppid_to_apid;
-	u16			last_apid;
-	struct apid_data	*apid_data;
 	int			max_periphs;
+	struct spmi_pmic_arb_bus buses[PMIC_ARB_MAX_BUSES];
+	int			buses_available;
 };
 
 /**
@@ -204,21 +218,21 @@ struct spmi_pmic_arb {
 struct pmic_arb_ver_ops {
 	const char *ver_str;
 	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
-	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
-	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
+	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
+	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
-	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			enum pmic_arb_channel ch_type);
+	int (*offset)(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+		      enum pmic_arb_channel ch_type);
 	u32 (*fmt_cmd)(u8 opc, u8 sid, u16 addr, u8 bc);
 	int (*non_data_cmd)(struct spmi_controller *ctrl, u8 opc, u8 sid);
 	/* Interrupts controller functionality (offset of PIC registers) */
-	void __iomem *(*owner_acc_status)(struct spmi_pmic_arb *pmic_arb, u8 m,
+	void __iomem *(*owner_acc_status)(struct spmi_pmic_arb_bus *bus, u8 m,
 					  u16 n);
-	void __iomem *(*acc_enable)(struct spmi_pmic_arb *pmic_arb, u16 n);
-	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
-	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
+	void __iomem *(*acc_enable)(struct spmi_pmic_arb_bus *bus, u16 n);
+	void __iomem *(*irq_status)(struct spmi_pmic_arb_bus *bus, u16 n);
+	void __iomem *(*irq_clear)(struct spmi_pmic_arb_bus *bus, u16 n);
 	u32 (*apid_map_offset)(u16 n);
-	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
+	void __iomem *(*apid_owner)(struct spmi_pmic_arb_bus *bus, u16 n);
 };
 
 static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
@@ -266,13 +280,14 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 				  void __iomem *base, u8 sid, u16 addr,
 				  enum pmic_arb_channel ch_type)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u32 status = 0;
 	u32 timeout = PMIC_ARB_TIMEOUT_US;
 	u32 offset;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr, ch_type);
+	rc = pmic_arb->ver_ops->offset(bus, sid, addr, ch_type);
 	if (rc < 0)
 		return rc;
 
@@ -284,21 +299,21 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 
 		if (status & PMIC_ARB_STATUS_DONE) {
 			if (status & PMIC_ARB_STATUS_DENIED) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction denied (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction denied (%#x)\n",
+					__func__, bus->id, sid, addr, status);
 				return -EPERM;
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction failed (%#x) reg: 0x%x\n",
+					__func__, bus->id, sid, addr, status, offset);
 				WARN_ON(1);
 				return -EIO;
 			}
 
 			if (status & PMIC_ARB_STATUS_DROPPED) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction dropped (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction dropped (%#x)\n",
+					__func__, bus->id, sid, addr, status);
 				return -EIO;
 			}
 
@@ -307,8 +322,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 		udelay(1);
 	}
 
-	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
-		__func__, sid, addr, status);
+	dev_err(&ctrl->dev, "%s: %#x %#x %#x: timeout, status %#x\n",
+		__func__, bus->id, sid, addr, status);
 	return -ETIMEDOUT;
 }
 
@@ -316,12 +331,13 @@ static int
 pmic_arb_non_data_cmd_v1(struct spmi_controller *ctrl, u8 opc, u8 sid)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[0];
 	unsigned long flags;
 	u32 cmd;
 	int rc;
 	u32 offset;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, 0, PMIC_ARB_CHANNEL_RW);
+	rc = pmic_arb->ver_ops->offset(bus, sid, 0, PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
 		return rc;
 
@@ -357,20 +373,21 @@ static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 	return pmic_arb->ver_ops->non_data_cmd(ctrl, opc, sid);
 }
 
-static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 sid,
+static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb_bus *bus, u8 opc, u8 sid,
 				 u16 addr, size_t len, u32 *cmd, u32 *offset)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u8 bc = len - 1;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
+	rc = pmic_arb->ver_ops->offset(bus, sid, addr,
 				       PMIC_ARB_CHANNEL_OBS);
 	if (rc < 0)
 		return rc;
 
 	*offset = rc;
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
-		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
+		dev_err(&bus->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
 			PMIC_ARB_MAX_TRANS_BYTES, len);
 		return  -EINVAL;
 	}
@@ -394,7 +411,8 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 				      u32 offset, u8 sid, u16 addr, u8 *buf,
 				      size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u8 bc = len - 1;
 	int rc;
 
@@ -416,12 +434,13 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 			     u16 addr, u8 *buf, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	unsigned long flags;
 	u32 cmd, offset;
 	int rc;
 
-	rc = pmic_arb_fmt_read_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+	rc = pmic_arb_fmt_read_cmd(bus, opc, sid, addr, len, &cmd,
 				   &offset);
 	if (rc)
 		return rc;
@@ -433,21 +452,22 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	return rc;
 }
 
-static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc,
+static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb_bus *bus, u8 opc,
 				  u8 sid, u16 addr, size_t len, u32 *cmd,
 				  u32 *offset)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u8 bc = len - 1;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
+	rc = pmic_arb->ver_ops->offset(bus, sid, addr,
 					PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
 		return rc;
 
 	*offset = rc;
 	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
-		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
+		dev_err(&bus->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
 			PMIC_ARB_MAX_TRANS_BYTES, len);
 		return  -EINVAL;
 	}
@@ -473,7 +493,8 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 				      u32 offset, u8 sid, u16 addr,
 				      const u8 *buf, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u8 bc = len - 1;
 
 	/* Write data to FIFOs */
@@ -492,12 +513,13 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 			      u16 addr, const u8 *buf, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	unsigned long flags;
 	u32 cmd, offset;
 	int rc;
 
-	rc = pmic_arb_fmt_write_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+	rc = pmic_arb_fmt_write_cmd(bus, opc, sid, addr, len, &cmd,
 				    &offset);
 	if (rc)
 		return rc;
@@ -513,18 +535,19 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
 				 const u8 *buf, const u8 *mask, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u32 read_cmd, read_offset, write_cmd, write_offset;
 	u8 temp[PMIC_ARB_MAX_TRANS_BYTES];
 	unsigned long flags;
 	int rc, i;
 
-	rc = pmic_arb_fmt_read_cmd(pmic_arb, SPMI_CMD_EXT_READL, sid, addr, len,
+	rc = pmic_arb_fmt_read_cmd(bus, SPMI_CMD_EXT_READL, sid, addr, len,
 				   &read_cmd, &read_offset);
 	if (rc)
 		return rc;
 
-	rc = pmic_arb_fmt_write_cmd(pmic_arb, SPMI_CMD_EXT_WRITEL, sid, addr,
+	rc = pmic_arb_fmt_write_cmd(bus, SPMI_CMD_EXT_WRITEL, sid, addr,
 				    len, &write_cmd, &write_offset);
 	if (rc)
 		return rc;
@@ -567,25 +590,25 @@ struct spmi_pmic_arb_qpnpint_type {
 static void qpnpint_spmi_write(struct irq_data *d, u8 reg, void *buf,
 			       size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
+	if (pmic_arb_write_cmd(bus->spmic, SPMI_CMD_EXT_WRITEL, sid,
 			       (per << 8) + reg, buf, len))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
+		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
 }
 
 static void qpnpint_spmi_read(struct irq_data *d, u8 reg, void *buf, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, sid,
+	if (pmic_arb_read_cmd(bus->spmic, SPMI_CMD_EXT_READL, sid,
 			      (per << 8) + reg, buf, len))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
+		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
 }
 
@@ -593,47 +616,49 @@ static int qpnpint_spmi_masked_write(struct irq_data *d, u8 reg,
 				     const void *buf, const void *mask,
 				     size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 	int rc;
 
-	rc = pmic_arb_masked_write(pmic_arb->spmic, sid, (per << 8) + reg, buf,
+	rc = pmic_arb_masked_write(bus->spmic, sid, (per << 8) + reg, buf,
 				   mask, len);
 	if (rc)
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
+		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
 				    d->irq, rc);
 	return rc;
 }
 
-static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
+static void cleanup_irq(struct spmi_pmic_arb_bus *bus, u16 apid, int id)
 {
-	u16 ppid = pmic_arb->apid_data[apid].ppid;
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	u16 ppid = bus->apid_data[apid].ppid;
 	u8 sid = ppid >> 8;
 	u8 per = ppid & 0xFF;
 	u8 irq_mask = BIT(id);
 
-	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
-			__func__, apid, sid, per, id);
-	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
+	dev_err_ratelimited(&bus->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
+			    __func__, apid, sid, per, id);
+	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(bus, apid));
 }
 
-static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
+static int periph_interrupt(struct spmi_pmic_arb_bus *bus, u16 apid)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	unsigned int irq;
 	u32 status, id;
 	int handled = 0;
-	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
-	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
+	u8 sid = (bus->apid_data[apid].ppid >> 8) & 0xF;
+	u8 per = bus->apid_data[apid].ppid & 0xFF;
 
-	status = readl_relaxed(pmic_arb->ver_ops->irq_status(pmic_arb, apid));
+	status = readl_relaxed(pmic_arb->ver_ops->irq_status(bus, apid));
 	while (status) {
 		id = ffs(status) - 1;
 		status &= ~BIT(id);
-		irq = irq_find_mapping(pmic_arb->domain,
-					spec_to_hwirq(sid, per, id, apid));
+		irq = irq_find_mapping(bus->domain,
+				       spec_to_hwirq(sid, per, id, apid));
 		if (irq == 0) {
-			cleanup_irq(pmic_arb, apid, id);
+			cleanup_irq(bus, apid, id);
 			continue;
 		}
 		generic_handle_irq(irq);
@@ -645,16 +670,17 @@ static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 
 static void pmic_arb_chained_irq(struct irq_desc *desc)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_desc_get_handler_data(desc);
+	struct spmi_pmic_arb_bus *bus = irq_desc_get_handler_data(desc);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int first = pmic_arb->min_apid;
-	int last = pmic_arb->max_apid;
+	int first = bus->min_apid;
+	int last = bus->max_apid;
 	/*
 	 * acc_offset will be non-zero for the secondary SPMI bus instance on
 	 * v7 controllers.
 	 */
-	int acc_offset = pmic_arb->base_apid >> 5;
+	int acc_offset = bus->base_apid >> 5;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
@@ -665,7 +691,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = first >> 5; i <= last >> 5; ++i) {
-		status = readl_relaxed(ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offset));
+		status = readl_relaxed(ver_ops->owner_acc_status(bus, ee, i - acc_offset));
 		if (status)
 			acc_valid = true;
 
@@ -679,9 +705,9 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 				continue;
 			}
 			enable = readl_relaxed(
-					ver_ops->acc_enable(pmic_arb, apid));
+					ver_ops->acc_enable(bus, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-				if (periph_interrupt(pmic_arb, apid) != 0)
+				if (periph_interrupt(bus, apid) != 0)
 					handled++;
 		}
 	}
@@ -690,19 +716,19 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	if (!acc_valid) {
 		for (i = first; i <= last; i++) {
 			/* skip if APPS is not irq owner */
-			if (pmic_arb->apid_data[i].irq_ee != pmic_arb->ee)
+			if (bus->apid_data[i].irq_ee != pmic_arb->ee)
 				continue;
 
 			irq_status = readl_relaxed(
-					     ver_ops->irq_status(pmic_arb, i));
+					     ver_ops->irq_status(bus, i));
 			if (irq_status) {
 				enable = readl_relaxed(
-					     ver_ops->acc_enable(pmic_arb, i));
+					     ver_ops->acc_enable(bus, i));
 				if (enable & SPMI_PIC_ACC_ENABLE_BIT) {
-					dev_dbg(&pmic_arb->spmic->dev,
+					dev_dbg(&bus->spmic->dev,
 						"Dispatching IRQ for apid=%d status=%x\n",
 						i, irq_status);
-					if (periph_interrupt(pmic_arb, i) != 0)
+					if (periph_interrupt(bus, i) != 0)
 						handled++;
 				}
 			}
@@ -717,12 +743,13 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 
 static void qpnpint_irq_ack(struct irq_data *d)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u8 irq = hwirq_to_irq(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u8 data;
 
-	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
+	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(bus, apid));
 
 	data = BIT(irq);
 	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &data, 1);
@@ -738,14 +765,15 @@ static void qpnpint_irq_mask(struct irq_data *d)
 
 static void qpnpint_irq_unmask(struct irq_data *d)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	u8 irq = hwirq_to_irq(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u8 buf[2];
 
 	writel_relaxed(SPMI_PIC_ACC_ENABLE_BIT,
-			ver_ops->acc_enable(pmic_arb, apid));
+			ver_ops->acc_enable(bus, apid));
 
 	qpnpint_spmi_read(d, QPNPINT_REG_EN_SET, &buf[0], 1);
 	if (!(buf[0] & BIT(irq))) {
@@ -802,9 +830,9 @@ static int qpnpint_irq_set_type(struct irq_data *d, unsigned int flow_type)
 
 static int qpnpint_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
 
-	return irq_set_irq_wake(pmic_arb->irq, on);
+	return irq_set_irq_wake(bus->irq, on);
 }
 
 static int qpnpint_get_irqchip_state(struct irq_data *d,
@@ -826,17 +854,18 @@ static int qpnpint_get_irqchip_state(struct irq_data *d,
 static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 				       struct irq_data *d, bool reserve)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u16 periph = hwirq_to_per(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u16 sid = hwirq_to_sid(d->hwirq);
 	u16 irq = hwirq_to_irq(d->hwirq);
 	u8 buf;
 
-	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
-		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
+	if (bus->apid_data[apid].irq_ee != pmic_arb->ee) {
+		dev_err(&bus->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
 			sid, periph, irq, pmic_arb->ee,
-			pmic_arb->apid_data[apid].irq_ee);
+			bus->apid_data[apid].irq_ee);
 		return -ENODEV;
 	}
 
@@ -863,15 +892,16 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 					unsigned long *out_hwirq,
 					unsigned int *out_type)
 {
-	struct spmi_pmic_arb *pmic_arb = d->host_data;
+	struct spmi_pmic_arb_bus *bus = d->host_data;
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u32 *intspec = fwspec->param;
 	u16 apid, ppid;
 	int rc;
 
-	dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
+	dev_dbg(&bus->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
 		intspec[0], intspec[1], intspec[2]);
 
-	if (irq_domain_get_of_node(d) != pmic_arb->spmic->dev.of_node)
+	if (irq_domain_get_of_node(d) != bus->spmic->dev.of_node)
 		return -EINVAL;
 	if (fwspec->param_count != 4)
 		return -EINVAL;
@@ -879,37 +909,38 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 		return -EINVAL;
 
 	ppid = intspec[0] << 8 | intspec[1];
-	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	rc = pmic_arb->ver_ops->ppid_to_apid(bus, ppid);
 	if (rc < 0) {
-		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
-		intspec[0], intspec[1], intspec[2], rc);
+		dev_err(&bus->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
+			intspec[0], intspec[1], intspec[2], rc);
 		return rc;
 	}
 
 	apid = rc;
 	/* Keep track of {max,min}_apid for bounding search during interrupt */
-	if (apid > pmic_arb->max_apid)
-		pmic_arb->max_apid = apid;
-	if (apid < pmic_arb->min_apid)
-		pmic_arb->min_apid = apid;
+	if (apid > bus->max_apid)
+		bus->max_apid = apid;
+	if (apid < bus->min_apid)
+		bus->min_apid = apid;
 
 	*out_hwirq = spec_to_hwirq(intspec[0], intspec[1], intspec[2], apid);
 	*out_type  = intspec[3] & IRQ_TYPE_SENSE_MASK;
 
-	dev_dbg(&pmic_arb->spmic->dev, "out_hwirq = %lu\n", *out_hwirq);
+	dev_dbg(&bus->spmic->dev, "out_hwirq = %lu\n", *out_hwirq);
 
 	return 0;
 }
 
 static struct lock_class_key qpnpint_irq_lock_class, qpnpint_irq_request_class;
 
-static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
+static void qpnpint_irq_domain_map(struct spmi_pmic_arb_bus *bus,
 				   struct irq_domain *domain, unsigned int virq,
 				   irq_hw_number_t hwirq, unsigned int type)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	irq_flow_handler_t handler;
 
-	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu, type = %u\n",
+	dev_dbg(&bus->spmic->dev, "virq = %u, hwirq = %lu, type = %u\n",
 		virq, hwirq, type);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -928,7 +959,7 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq, unsigned int nr_irqs,
 				    void *data)
 {
-	struct spmi_pmic_arb *pmic_arb = domain->host_data;
+	struct spmi_pmic_arb_bus *bus = domain->host_data;
 	struct irq_fwspec *fwspec = data;
 	irq_hw_number_t hwirq;
 	unsigned int type;
@@ -939,20 +970,22 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 		return ret;
 
 	for (i = 0; i < nr_irqs; i++)
-		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i,
+		qpnpint_irq_domain_map(bus, domain, virq + i, hwirq + i,
 				       type);
 
 	return 0;
 }
 
-static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
+static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb_bus *bus)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+
 	/*
 	 * Initialize max_apid/min_apid to the opposite bounds, during
 	 * the irq domain translation, we are sure to update these
 	 */
-	pmic_arb->max_apid = 0;
-	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
+	bus->max_apid = 0;
+	bus->min_apid = pmic_arb->max_periphs - 1;
 
 	return 0;
 }
@@ -970,43 +1003,44 @@ static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
 	return 0;
 }
 
-static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
+static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus, int index)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u32 *mapping_table;
 
 	if (index) {
-		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
 			index);
 		return -EINVAL;
 	}
 
-	mapping_table = devm_kcalloc(&pmic_arb->spmic->dev, pmic_arb->max_periphs,
+	mapping_table = devm_kcalloc(&bus->spmic->dev, pmic_arb->max_periphs,
 				     sizeof(*mapping_table), GFP_KERNEL);
 	if (!mapping_table)
 		return -ENOMEM;
 
-	pmic_arb->mapping_table = mapping_table;
+	bus->mapping_table = mapping_table;
 
-	return pmic_arb_init_apid_min_max(pmic_arb);
+	return pmic_arb_init_apid_min_max(bus);
 }
 
-static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb_bus *bus, u16 ppid)
 {
-	u32 *mapping_table = pmic_arb->mapping_table;
+	u32 *mapping_table = bus->mapping_table;
 	int index = 0, i;
 	u16 apid_valid;
 	u16 apid;
 	u32 data;
 
-	apid_valid = pmic_arb->ppid_to_apid[ppid];
+	apid_valid = bus->ppid_to_apid[ppid];
 	if (apid_valid & PMIC_ARB_APID_VALID) {
 		apid = apid_valid & ~PMIC_ARB_APID_VALID;
 		return apid;
 	}
 
 	for (i = 0; i < SPMI_MAPPING_TABLE_TREE_DEPTH; ++i) {
-		if (!test_and_set_bit(index, pmic_arb->mapping_table_valid))
-			mapping_table[index] = readl_relaxed(pmic_arb->cnfg +
+		if (!test_and_set_bit(index, bus->mapping_table_valid))
+			mapping_table[index] = readl_relaxed(bus->cnfg +
 						SPMI_MAPPING_TABLE_REG(index));
 
 		data = mapping_table[index];
@@ -1016,9 +1050,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 				index = SPMI_MAPPING_BIT_IS_1_RESULT(data);
 			} else {
 				apid = SPMI_MAPPING_BIT_IS_1_RESULT(data);
-				pmic_arb->ppid_to_apid[ppid]
+				bus->ppid_to_apid[ppid]
 					= apid | PMIC_ARB_APID_VALID;
-				pmic_arb->apid_data[apid].ppid = ppid;
+				bus->apid_data[apid].ppid = ppid;
 				return apid;
 			}
 		} else {
@@ -1026,9 +1060,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 				index = SPMI_MAPPING_BIT_IS_0_RESULT(data);
 			} else {
 				apid = SPMI_MAPPING_BIT_IS_0_RESULT(data);
-				pmic_arb->ppid_to_apid[ppid]
+				bus->ppid_to_apid[ppid]
 					= apid | PMIC_ARB_APID_VALID;
-				pmic_arb->apid_data[apid].ppid = ppid;
+				bus->apid_data[apid].ppid = ppid;
 				return apid;
 			}
 		}
@@ -1038,24 +1072,26 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 }
 
 /* v1 offset per ee */
-static int pmic_arb_offset_v1(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v1(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return 0x800 + 0x80 * pmic_arb->channel;
 }
 
-static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static u16 pmic_arb_find_apid(struct spmi_pmic_arb_bus *bus, u16 ppid)
 {
-	struct apid_data *apidd = &pmic_arb->apid_data[pmic_arb->last_apid];
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	struct apid_data *apidd = &bus->apid_data[bus->last_apid];
 	u32 regval, offset;
 	u16 id, apid;
 
-	for (apid = pmic_arb->last_apid; ; apid++, apidd++) {
+	for (apid = bus->last_apid; ; apid++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(apid);
 		if (offset >= pmic_arb->core_size)
 			break;
 
-		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(bus,
 								     apid));
 		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 		apidd->write_ee = apidd->irq_ee;
@@ -1065,14 +1101,14 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 			continue;
 
 		id = (regval >> 8) & PMIC_ARB_PPID_MASK;
-		pmic_arb->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
+		bus->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
 		apidd->ppid = id;
 		if (id == ppid) {
 			apid |= PMIC_ARB_APID_VALID;
 			break;
 		}
 	}
-	pmic_arb->last_apid = apid & ~PMIC_ARB_APID_VALID;
+	bus->last_apid = apid & ~PMIC_ARB_APID_VALID;
 
 	return apid;
 }
@@ -1106,21 +1142,22 @@ static int pmic_arb_get_core_resources_v2(struct platform_device *pdev,
 	return pmic_arb_get_obsrvr_chnls_v2(pdev);
 }
 
-static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb_bus *bus, u16 ppid)
 {
 	u16 apid_valid;
 
-	apid_valid = pmic_arb->ppid_to_apid[ppid];
+	apid_valid = bus->ppid_to_apid[ppid];
 	if (!(apid_valid & PMIC_ARB_APID_VALID))
-		apid_valid = pmic_arb_find_apid(pmic_arb, ppid);
+		apid_valid = pmic_arb_find_apid(bus, ppid);
 	if (!(apid_valid & PMIC_ARB_APID_VALID))
 		return -ENODEV;
 
 	return apid_valid & ~PMIC_ARB_APID_VALID;
 }
 
-static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
+static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb_bus *bus)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	struct apid_data *apidd;
 	struct apid_data *prev_apidd;
 	u16 i, apid, ppid, apid_max;
@@ -1142,9 +1179,9 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 	 * where N = number of APIDs supported by the primary bus and
 	 *       M = number of APIDs supported by the secondary bus
 	 */
-	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
-	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
-	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
+	apidd = &bus->apid_data[bus->base_apid];
+	apid_max = bus->base_apid + bus->apid_count;
+	for (i = bus->base_apid; i < apid_max; i++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(i);
 		if (offset >= pmic_arb->core_size)
 			break;
@@ -1155,19 +1192,18 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
 		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
 
-		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
-								     i));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(bus, i));
 		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 
 		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
 
-		valid = pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
-		apid = pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
-		prev_apidd = &pmic_arb->apid_data[apid];
+		valid = bus->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
+		apid = bus->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
+		prev_apidd = &bus->apid_data[apid];
 
 		if (!valid || apidd->write_ee == pmic_arb->ee) {
 			/* First PPID mapping or one for this EE */
-			pmic_arb->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
+			bus->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
 		} else if (valid && is_irq_ee &&
 			   prev_apidd->write_ee == pmic_arb->ee) {
 			/*
@@ -1178,42 +1214,43 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		}
 
 		apidd->ppid = ppid;
-		pmic_arb->last_apid = i;
+		bus->last_apid = i;
 	}
 
 	/* Dump the mapping table for debug purposes. */
-	dev_dbg(&pmic_arb->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
+	dev_dbg(&bus->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
 	for (ppid = 0; ppid < PMIC_ARB_MAX_PPID; ppid++) {
-		apid = pmic_arb->ppid_to_apid[ppid];
+		apid = bus->ppid_to_apid[ppid];
 		if (apid & PMIC_ARB_APID_VALID) {
 			apid &= ~PMIC_ARB_APID_VALID;
-			apidd = &pmic_arb->apid_data[apid];
-			dev_dbg(&pmic_arb->spmic->dev, "%#03X %3u %2u %2u\n",
-			      ppid, apid, apidd->write_ee, apidd->irq_ee);
+			apidd = &bus->apid_data[apid];
+			dev_dbg(&bus->spmic->dev, "%#03X %3u %2u %2u\n",
+				ppid, apid, apidd->write_ee, apidd->irq_ee);
 		}
 	}
 
 	return 0;
 }
 
-static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_arb_bus *bus, u16 ppid)
 {
-	if (!(pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
+	if (!(bus->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
 		return -ENODEV;
 
-	return pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
+	return bus->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
 }
 
 /* v2 offset per ppid and per ee */
-static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v2(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u16 apid;
 	u16 ppid;
 	int rc;
 
 	ppid = sid << 8 | ((addr >> 8) & 0xFF);
-	rc = pmic_arb_ppid_to_apid_v2(pmic_arb, ppid);
+	rc = pmic_arb_ppid_to_apid_v2(bus, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1221,33 +1258,34 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
 }
 
-static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
+static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus, int index)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	int ret;
 
 	if (index) {
-		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
 			index);
 		return -EINVAL;
 	}
 
-	pmic_arb->base_apid = 0;
-	pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+	bus->base_apid = 0;
+	bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
 					   PMIC_ARB_FEATURES_PERIPH_MASK;
 
-	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
-		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
-			pmic_arb->base_apid + pmic_arb->apid_count);
+	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
+		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
+			bus->base_apid + bus->apid_count);
 		return -EINVAL;
 	}
 
-	ret = pmic_arb_init_apid_min_max(pmic_arb);
+	ret = pmic_arb_init_apid_min_max(bus);
 	if (ret)
 		return ret;
 
-	ret = pmic_arb_read_apid_map_v5(pmic_arb);
+	ret = pmic_arb_read_apid_map_v5(bus);
 	if (ret) {
-		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
 			ret);
 		return ret;
 	}
@@ -1259,15 +1297,16 @@ static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
  * v5 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
  */
-static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v5(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u16 apid;
 	int rc;
 	u32 offset = 0;
 	u16 ppid = (sid << 8) | (addr >> 8);
 
-	rc = pmic_arb_ppid_to_apid_v5(pmic_arb, ppid);
+	rc = pmic_arb_ppid_to_apid_v5(bus, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1277,8 +1316,8 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 		offset = 0x10000 * pmic_arb->ee + 0x80 * apid;
 		break;
 	case PMIC_ARB_CHANNEL_RW:
-		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
-			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
+		if (bus->apid_data[apid].write_ee != pmic_arb->ee) {
+			dev_err(&bus->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
 				sid, addr);
 			return -EPERM;
 		}
@@ -1305,38 +1344,39 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
  * Only v7 supports 2 buses. Each bus will get a different apid count, read
  * from different registers.
  */
-static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
+static int pmic_arb_init_apid_v7(struct spmi_pmic_arb_bus *bus, int index)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	int ret;
 
 	if (index == 0) {
-		pmic_arb->base_apid = 0;
-		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+		bus->base_apid = 0;
+		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
 						   PMIC_ARB_FEATURES_PERIPH_MASK;
 	} else if (index == 1) {
-		pmic_arb->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+		bus->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
 						  PMIC_ARB_FEATURES_PERIPH_MASK;
-		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
+		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
 						   PMIC_ARB_FEATURES_PERIPH_MASK;
 	} else {
-		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
-			index);
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
+			bus->id);
 		return -EINVAL;
 	}
 
-	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
-		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
-			pmic_arb->base_apid + pmic_arb->apid_count);
+	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
+		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
+			bus->base_apid + bus->apid_count);
 		return -EINVAL;
 	}
 
-	ret = pmic_arb_init_apid_min_max(pmic_arb);
+	ret = pmic_arb_init_apid_min_max(bus);
 	if (ret)
 		return ret;
 
-	ret = pmic_arb_read_apid_map_v5(pmic_arb);
+	ret = pmic_arb_read_apid_map_v5(bus);
 	if (ret) {
-		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
 			ret);
 		return ret;
 	}
@@ -1348,15 +1388,16 @@ static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
  * v7 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
  */
-static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v7(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u16 apid;
 	int rc;
 	u32 offset = 0;
 	u16 ppid = (sid << 8) | (addr >> 8);
 
-	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	rc = pmic_arb->ver_ops->ppid_to_apid(bus, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1366,8 +1407,8 @@ static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
 		break;
 	case PMIC_ARB_CHANNEL_RW:
-		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
-			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
+		if (bus->apid_data[apid].write_ee != pmic_arb->ee) {
+			dev_err(&bus->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
 				sid, addr);
 			return -EPERM;
 		}
@@ -1389,104 +1430,110 @@ static u32 pmic_arb_fmt_cmd_v2(u8 opc, u8 sid, u16 addr, u8 bc)
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v1(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v1(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x20 * m + 0x4 * n;
+	return bus->intr + 0x20 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v2(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v2(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x100000 + 0x1000 * m + 0x4 * n;
+	return bus->intr + 0x100000 + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v3(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v3(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x200000 + 0x1000 * m + 0x4 * n;
+	return bus->intr + 0x200000 + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
+	return bus->intr + 0x10000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
+	return bus->intr + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v1(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0x200 + 0x4 * n;
+	return bus->intr + 0x200 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0x1000 * n;
+	return bus->intr + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v5(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v1(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0x600 + 0x4 * n;
+	return bus->intr + 0x600 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0x4 + 0x1000 * n;
+	return bus->intr + 0x4 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v5(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v1(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0xA00 + 0x4 * n;
+	return bus->intr + 0xA00 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->intr + 0x8 + 0x1000 * n;
+	return bus->intr + 0x8 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v5(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
 }
 
@@ -1506,9 +1553,9 @@ static u32 pmic_arb_apid_map_offset_v7(u16 n)
 }
 
 static void __iomem *
-pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_apid_owner_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->cnfg + 0x700 + 0x4 * n;
+	return bus->cnfg + 0x700 + 0x4 * n;
 }
 
 /*
@@ -1517,9 +1564,9 @@ pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
  * 0.
  */
 static void __iomem *
-pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_apid_owner_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 {
-	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
+	return  bus->cnfg + 0x4 * (n - bus->base_apid);
 }
 
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
@@ -1609,29 +1656,160 @@ static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
 	.translate = qpnpint_irq_domain_translate,
 };
 
+static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
+				  struct device_node *node,
+				  struct spmi_pmic_arb *pmic_arb)
+{
+	int bus_index = pmic_arb->buses_available;
+	struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[bus_index];
+	struct device *dev = &pdev->dev;
+	struct spmi_controller *ctrl;
+	void __iomem *intr;
+	void __iomem *cnfg;
+	int index, ret;
+	u32 irq;
+
+	ctrl = devm_spmi_controller_alloc(dev, sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	ctrl->cmd = pmic_arb_cmd;
+	ctrl->read_cmd = pmic_arb_read_cmd;
+	ctrl->write_cmd = pmic_arb_write_cmd;
+
+	bus = spmi_controller_get_drvdata(ctrl);
+	bus->spmic = ctrl;
+
+	bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
+					 sizeof(*bus->ppid_to_apid),
+					 GFP_KERNEL);
+	if (!bus->ppid_to_apid)
+		return -ENOMEM;
+
+	bus->apid_data = devm_kcalloc(dev, pmic_arb->max_periphs,
+				      sizeof(*bus->apid_data),
+				      GFP_KERNEL);
+	if (!bus->apid_data)
+		return -ENOMEM;
+
+	index = of_property_match_string(node, "reg-names", "cnfg");
+	if (index < 0) {
+		dev_err(dev, "cnfg reg region missing");
+		return -EINVAL;
+	}
+
+	cnfg = devm_of_iomap(dev, node, index, NULL);
+	if (IS_ERR(cnfg))
+		return PTR_ERR(cnfg);
+
+	index = of_property_match_string(node, "reg-names", "intr");
+	if (index < 0) {
+		dev_err(dev, "intr reg region missing");
+		return -EINVAL;
+	}
+
+	intr = devm_of_iomap(dev, node, index, NULL);
+	if (IS_ERR(intr))
+		return PTR_ERR(intr);
+
+	irq = of_irq_get_byname(node, "periph_irq");
+	if (irq < 0)
+		return irq;
+
+	bus->pmic_arb = pmic_arb;
+	bus->intr = intr;
+	bus->cnfg = cnfg;
+	bus->irq = irq;
+	bus->id = bus_index;
+
+	ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
+
+	bus->domain = irq_domain_add_tree(dev->of_node,
+					  &pmic_arb_irq_domain_ops, bus);
+	if (!bus->domain) {
+		dev_err(&pdev->dev, "unable to create irq_domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(bus->irq,
+					 pmic_arb_chained_irq, bus);
+
+	bus->spmic->dev.of_node = node;
+	dev_set_name(&bus->spmic->dev, "spmi-%d", bus_index);
+
+	ret = devm_spmi_controller_add(dev, bus->spmic);
+	if (ret)
+		return ret;
+
+	pmic_arb->buses_available++;
+
+	return 0;
+}
+
+static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
+					struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *child;
+	int ret;
+
+	/* legacy mode doesn't provide child node for the bus */
+	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb-v7")) {
+		for_each_available_child_of_node(node, child) {
+			if (of_node_name_eq(child, "spmi")) {
+				ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
+				if (ret)
+					return ret;
+			}
+		}
+	} else {
+		ret = spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
+	}
+
+	return ret;
+}
+
+static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
+{
+	int i;
+
+	for (i = 0; i < PMIC_ARB_MAX_BUSES; i++) {
+		struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[i];
+
+		irq_set_chained_handler_and_data(bus->irq,
+						 NULL, NULL);
+		irq_domain_remove(bus->domain);
+	}
+}
+
 static int spmi_pmic_arb_probe(struct platform_device *pdev)
 {
 	struct spmi_pmic_arb *pmic_arb;
-	struct spmi_controller *ctrl;
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 	void __iomem *core;
 	u32 channel, ee, hw_ver;
 	int err;
 
-	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*pmic_arb));
-	if (IS_ERR(ctrl))
-		return PTR_ERR(ctrl);
-
-	pmic_arb = spmi_controller_get_drvdata(ctrl);
-	pmic_arb->spmic = ctrl;
+	pmic_arb = devm_kzalloc(dev, sizeof(*pmic_arb), GFP_KERNEL);
+	if (!pmic_arb)
+		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
-	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
+	core = devm_ioremap(dev, res->start, resource_size(res));
 	if (IS_ERR(core))
 		return PTR_ERR(core);
 
 	pmic_arb->core_size = resource_size(res);
 
+	platform_set_drvdata(pdev, pmic_arb);
+	raw_spin_lock_init(&pmic_arb->lock);
+
 	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
 
 	if (hw_ver < PMIC_ARB_VERSION_V2_MIN)
@@ -1645,30 +1823,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	else
 		pmic_arb->ver_ops = &pmic_arb_v7;
 
-	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
-		 pmic_arb->ver_ops->ver_str, hw_ver);
-
 	err = pmic_arb->ver_ops->get_core_resources(pdev, core);
 	if (err)
 		return err;
 
-	err = pmic_arb->ver_ops->init_apid(pmic_arb, 0);
-	if (err)
-		return err;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
-	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->intr))
-		return PTR_ERR(pmic_arb->intr);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cnfg");
-	pmic_arb->cnfg = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->cnfg))
-		return PTR_ERR(pmic_arb->cnfg);
-
-	pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
-	if (pmic_arb->irq < 0)
-		return pmic_arb->irq;
+	dev_info(dev, "PMIC arbiter version %s (0x%x)\n",
+		 pmic_arb->ver_ops->ver_str, hw_ver);
 
 	err = of_property_read_u32(pdev->dev.of_node, "qcom,channel", &channel);
 	if (err) {
@@ -1697,46 +1857,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 	pmic_arb->ee = ee;
 
-	platform_set_drvdata(pdev, ctrl);
-	raw_spin_lock_init(&pmic_arb->lock);
-
-	ctrl->cmd = pmic_arb_cmd;
-	ctrl->read_cmd = pmic_arb_read_cmd;
-	ctrl->write_cmd = pmic_arb_write_cmd;
-
-	dev_dbg(&pdev->dev, "adding irq domain\n");
-	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
-					 &pmic_arb_irq_domain_ops, pmic_arb);
-	if (!pmic_arb->domain) {
-		dev_err(&pdev->dev, "unable to create irq_domain\n");
-		return -ENOMEM;
-	}
-
-	irq_set_chained_handler_and_data(pmic_arb->irq, pmic_arb_chained_irq,
-					pmic_arb);
-	err = spmi_controller_add(ctrl);
-	if (err)
-		goto err_domain_remove;
-
-	return 0;
-
-err_domain_remove:
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
-	return err;
+	return spmi_pmic_arb_register_buses(pmic_arb, pdev);
 }
 
 static void spmi_pmic_arb_remove(struct platform_device *pdev)
 {
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
-	spmi_controller_remove(ctrl);
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+
+	spmi_pmic_arb_deregister_buses(pmic_arb);
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
 	{ .compatible = "qcom,spmi-pmic-arb", },
+	{ .compatible = "qcom,spmi-pmic-arb-v7", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);

-- 
2.34.1


