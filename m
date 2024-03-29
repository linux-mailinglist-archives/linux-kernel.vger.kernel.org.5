Return-Path: <linux-kernel+bounces-125300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED78923B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34111C21FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372F313B2A4;
	Fri, 29 Mar 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMmwwoWl"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1813AA59
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738496; cv=none; b=JF4eJLtkmomHT0ZnDsaYlUVjniDhe15nzf7p7g1Xki9AFqrTotbAQ8NA3fVfvKmxVFxXOnvUTMZdYvKw6DiV6G4MXIOxZgsKHiaqcM0LOWCLNUk9jf0XP9hmUC8balnvQ4MMI3VXWfnsp6tSgCgAfn+ezZefFq75WlO6WmbJs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738496; c=relaxed/simple;
	bh=kiFNbFrr2cHRGI8Y32geRObZcge4BmsO3+tXioPlQw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEj81ADJUtBbSsoeuzgssuEJbjqUKj1FAP4IJcLgaJ2Ujm0h1KPPV1vJFqB5PV0K5ucmWTjizNR9w5yQLQnabxgWvJfPX/dj5yjqdkAAuIW5otAzYKrwAPcW85T6GcTyfHGqgbUwY+UnVzIqzpuDKY6Yam0LxZkcPsXWdzaYxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMmwwoWl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso2741843a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711738492; x=1712343292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDWmNiwFaDyG4eVDcOJIipMcHBjPEMX/8w3VIoSj37Y=;
        b=CMmwwoWlrFp/xdb4Q33XMk+aQ8PL7meSZKfVUtlIbWBdEUew9ag2hejot+wQgxxetB
         xKjW7imndMs981JHAJkAgqUJz9DU7Xemgyui1uJ6kLAE6D3DPz9GROI1TbKNJ6SY2Dhc
         gZAcjg+ntTInO8ILcEyUobhxb6hhqPDMiDN5IDzkHtPf4Xv7QmmzOW/FrB4BWsjAAdWT
         byEcVFQUay9zrPu1YidcV0JNGHMUrg0PLOk1lzz7xFQ6+oUSD1LNqZcSWYGAwh3+SpQt
         E6/MiaTwzd5pyGwrxhC+wYhw6HjqX6QMD0gPvd+aU0wdwz+W61/Hygb2E/q4BUt5wfhm
         uatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738492; x=1712343292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDWmNiwFaDyG4eVDcOJIipMcHBjPEMX/8w3VIoSj37Y=;
        b=NGNYZ/GCZFuMoVzBQU1axM/3TyyF2ipyVAEHDStWtef2UWWOgHA9ESbr5qoXYYw9dl
         uL8Xt08iiXbYYlqPPGw+LcZA1f+my8fjnXsxE0cC09dOluAQLUBIlsxMzteVQIBQioQe
         lOEAmVZ4Gqfj1rszziuk2P9A72jIeD3rAW1I9W0XtlSLVVVQsTedWDMiJ4S6k7VFdWWO
         MUnHp75VyfMPtu5u8VrPs1OFeIOSQpFWlQYXK/JU+sEsd/tT4oq0VhIePOoEFdjeoVaW
         9y0yp6tkmNMH0azZvJ7ZV5KexKgOHLgJlIJmmulcGcK6WvsOtUMxOnvkf2C6c4sIgQjo
         SccQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2mKwSyGn4GXkjqHA52P76i3+EjEJOjiPkqZvNehhMOHZpgzfCi9t0x40bPMugmoG2A7XQrJ4CPdNXRdSA8qiARQtAFI6lecXWUBeZ
X-Gm-Message-State: AOJu0YxCRegauKvFws2kcba2oo3vEfnKkI0UNAv4V7QZHgE7omr20aHM
	Is9pJe0otToPN711LKbMmwbrTBQtnAyBj4XyMFYTLCnnUXotF4+QQuQc6pMVadU=
X-Google-Smtp-Source: AGHT+IEtKEI1LK9lS1mHVw1CNmNQ33IUOsSWQyQtYl0YqK2TB+8vPQKsER18RfjFqRKtZmrSueU3Tw==
X-Received: by 2002:a17:907:7248:b0:a4e:4350:3b3a with SMTP id ds8-20020a170907724800b00a4e43503b3amr604914ejc.60.1711738492180;
        Fri, 29 Mar 2024 11:54:52 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm2235618ejb.148.2024.03.29.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:54:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 29 Mar 2024 20:54:23 +0200
Subject: [PATCH v7 6/6] spmi: pmic-arb: Add multi bus support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-spmi-multi-master-support-v7-6-7b902824246c@linaro.org>
References: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
In-Reply-To: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9932; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=kiFNbFrr2cHRGI8Y32geRObZcge4BmsO3+tXioPlQw4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmBw5wmKqlBnGcmeFRd+VPQ2FIeVnh7xAj2hE5P
 1xfqvfLhuaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgcOcAAKCRAbX0TJAJUV
 VgttD/4xWJelpoSyHqTyDbdFlLRkyQUAcHCnevhPtmBJNrAdG8olNyVCTHD8Zgmkwi2hTO/INbP
 6aVYK9UMhvBAjLxEizLYZJOJj8h841CPzHCyQUFnPwDpgtHLfTSSqViD2UR9k3kNvqOEg2fdTt4
 dF5bm4JgWn8Q6IvvqbHFFSjNWf84xwABYNuZeFhyMZKJx/Q9mQXKs57U92Q4H/Yz141LHavtbgb
 AQIEm7n3CcsVFuEt27D1wam5E8BIbR4kr3njpm+mLKR3yjD2o5lHwA0fCmzdqxonx71xF1hYp8D
 T4tuqf76OrXHGIISJUFvo4zmoadjRJ0iVb1Lxfm2X8u3hYnMA9uJKRPoIv3CD9SG3hyayc6507A
 pDsIvgQ6mMv5BGZvxQGPZAF5BN3G5gZrUTRnEnCzDZLghtgj34FCinwS3dkjb4IztalXTeE4+F7
 pruaIcNfhkHMXvRBU0v0UuvgckIu66dpmmo1t/eDqet98NkVyQrNQ2wfmDc+BL5ngPYRP85SeV0
 ey9Cs1RL1t8ysKAk1fHGyG7g6tSU9ZfDP3ZKpi5z5tioJ8fUgoj0G0nSwKblO7ZLcCVZt8zXRir
 eSzYb+Di00H1+UlltQl6SGuSsNlefLZ9KMy/JvFPPfOq5p7qnJrA9F/uVtZs+MQhG4XeLnQLg4K
 IZ9bCoWuAgLrZjw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Starting with HW version 7, there are actually two separate buses
(with two separate sets of wires). So add support for the second bus.
The first platform that needs this support for the second bus is the
Qualcomm X1 Elite, so add the compatible for it as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 138 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 18 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 19ff8665f3d9..56f2b3190d82 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -95,6 +96,8 @@ enum pmic_arb_channel {
 	PMIC_ARB_CHANNEL_OBS,
 };
 
+#define PMIC_ARB_MAX_BUSES		2
+
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
 #define PMIC_ARB_MAX_PERIPHS_V7		1024
@@ -148,6 +151,7 @@ struct spmi_pmic_arb;
  * @min_apid:		minimum APID (used for bounding IRQ search)
  * @max_apid:		maximum APID
  * @irq:		PMIC ARB interrupt.
+ * @id:			unique ID of the bus
  */
 struct spmi_pmic_arb_bus {
 	struct spmi_pmic_arb	*pmic_arb;
@@ -165,6 +169,7 @@ struct spmi_pmic_arb_bus {
 	u16			min_apid;
 	u16			max_apid;
 	int			irq;
+	u8			id;
 };
 
 /**
@@ -179,7 +184,8 @@ struct spmi_pmic_arb_bus {
  * @ee:			the current Execution Environment
  * @ver_ops:		version dependent operations.
  * @max_periphs:	Number of elements in apid_data[]
- * @bus:		per arbiter bus instance
+ * @buses:		per arbiter buses instances
+ * @buses_available:	number of buses registered
  */
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
@@ -191,7 +197,8 @@ struct spmi_pmic_arb {
 	u8			ee;
 	const struct pmic_arb_ver_ops *ver_ops;
 	int			max_periphs;
-	struct spmi_pmic_arb_bus *bus;
+	struct spmi_pmic_arb_bus *buses[PMIC_ARB_MAX_BUSES];
+	int			buses_available;
 };
 
 /**
@@ -219,7 +226,7 @@ struct spmi_pmic_arb {
 struct pmic_arb_ver_ops {
 	const char *ver_str;
 	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
-	int (*init_apid)(struct spmi_pmic_arb_bus *bus);
+	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
 	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
 	int (*offset)(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
@@ -308,8 +315,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x) reg: 0x%x\n",
+					__func__, sid, addr, status, offset);
 				WARN_ON(1);
 				return -EIO;
 			}
@@ -325,8 +332,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 		udelay(1);
 	}
 
-	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
-		__func__, sid, addr, status);
+	dev_err(&ctrl->dev, "%s: %#x %#x %#x: timeout, status %#x\n",
+		__func__, bus->id, sid, addr, status);
 	return -ETIMEDOUT;
 }
 
@@ -1005,11 +1012,17 @@ static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
 	return 0;
 }
 
-static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus)
+static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus, int index)
 {
 	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	u32 *mapping_table;
 
+	if (index) {
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
 	mapping_table = devm_kcalloc(&bus->spmic->dev, pmic_arb->max_periphs,
 				     sizeof(*mapping_table), GFP_KERNEL);
 	if (!mapping_table)
@@ -1252,11 +1265,17 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
 	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
 }
 
-static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus)
+static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus, int index)
 {
 	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 	int ret;
 
+	if (index) {
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
 	bus->base_apid = 0;
 	bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
 					   PMIC_ARB_FEATURES_PERIPH_MASK;
@@ -1328,6 +1347,50 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
 	return pmic_arb_get_obsrvr_chnls_v2(pdev);
 }
 
+/*
+ * Only v7 supports 2 buses. Each bus will get a different apid count, read
+ * from different registers.
+ */
+static int pmic_arb_init_apid_v7(struct spmi_pmic_arb_bus *bus, int index)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	int ret;
+
+	if (index == 0) {
+		bus->base_apid = 0;
+		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else if (index == 1) {
+		bus->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						  PMIC_ARB_FEATURES_PERIPH_MASK;
+		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else {
+		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
+			bus->id);
+		return -EINVAL;
+	}
+
+	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
+		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
+			bus->base_apid + bus->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_min_max(bus);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v5(bus);
+	if (ret) {
+		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * v7 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
@@ -1580,7 +1643,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.ver_str		= "v7",
 	.get_core_resources	= pmic_arb_get_core_resources_v7,
-	.init_apid		= pmic_arb_init_apid_v5,
+	.init_apid		= pmic_arb_init_apid_v7,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v7,
@@ -1604,6 +1667,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 				  struct device_node *node,
 				  struct spmi_pmic_arb *pmic_arb)
 {
+	int bus_index = pmic_arb->buses_available;
 	struct spmi_pmic_arb_bus *bus;
 	struct device *dev = &pdev->dev;
 	struct spmi_controller *ctrl;
@@ -1622,7 +1686,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 
 	bus = spmi_controller_get_drvdata(ctrl);
 
-	pmic_arb->bus = bus;
+	pmic_arb->buses[bus_index] = bus;
 
 	bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
 					 sizeof(*bus->ppid_to_apid),
@@ -1665,12 +1729,13 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 	bus->cnfg = cnfg;
 	bus->irq = irq;
 	bus->spmic = ctrl;
+	bus->id = bus_index;
 
-	ret = pmic_arb->ver_ops->init_apid(bus);
+	ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
 	if (ret)
 		return ret;
 
-	dev_dbg(&pdev->dev, "adding irq domain\n");
+	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
 
 	bus->domain = irq_domain_add_tree(dev->of_node,
 					  &pmic_arb_irq_domain_ops, bus);
@@ -1683,14 +1748,53 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 					 pmic_arb_chained_irq, bus);
 
 	ctrl->dev.of_node = node;
+	dev_set_name(&ctrl->dev, "spmi-%d", bus_index);
 
 	ret = devm_spmi_controller_add(dev, ctrl);
 	if (ret)
 		return ret;
 
+	pmic_arb->buses_available++;
+
 	return 0;
 }
 
+static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
+					struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *child;
+	int ret;
+
+	/* legacy mode doesn't provide child node for the bus */
+	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
+		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
+
+	for_each_available_child_of_node(node, child) {
+		if (of_node_name_eq(child, "spmi")) {
+			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
+			if (ret)
+				return ret;
+		}
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
+		struct spmi_pmic_arb_bus *bus = pmic_arb->buses[i];
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
@@ -1761,21 +1865,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 	pmic_arb->ee = ee;
 
-	return spmi_pmic_arb_bus_init(pdev, dev->of_node, pmic_arb);
+	return spmi_pmic_arb_register_buses(pmic_arb, pdev);
 }
 
 static void spmi_pmic_arb_remove(struct platform_device *pdev)
 {
 	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
-	struct spmi_pmic_arb_bus *bus = pmic_arb->bus;
 
-	irq_set_chained_handler_and_data(bus->irq,
-					 NULL, NULL);
-	irq_domain_remove(bus->domain);
+	spmi_pmic_arb_deregister_buses(pmic_arb);
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
 	{ .compatible = "qcom,spmi-pmic-arb", },
+	{ .compatible = "qcom,x1e80100-spmi-pmic-arb", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);

-- 
2.34.1


