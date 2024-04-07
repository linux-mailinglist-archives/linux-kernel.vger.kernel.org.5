Return-Path: <linux-kernel+bounces-134550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24E89B2EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F32B21669
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6562405DB;
	Sun,  7 Apr 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5S3bNEO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8333F9F6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507036; cv=none; b=lgqHhJm+9GYlkcesAC1zN2D17k4dFOTKzrHam0UkLydyPsYQdxVFy7lNliHNwu8XviaOw/WP4vajW/dmx++jCmTuisX/egtq5A0QHkuCGYOfiY83L5eBEPd48vuzmZfAZ5zmeN5lu9f+8FA/jhIxrmmh/xix7w0uXFeoIybTYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507036; c=relaxed/simple;
	bh=OwopASy2ep6ZJbpGz0J2byN74JuY3NnqdRzQJbZ3tiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYxQVVfxQiwjnhM6NzjjLCl8rfLw096bul58ln2GEPnGrvZbPodjzckY87pAvVQanZ91wJNePtUmrSU0AAXOmsBzs/4lbNUfIpuw45Dz8Ny21DFu67xJHHTfvk2RBBVXODtZgQRTr8p0BCoLPYh6C7lnxMySE2qNIpuFTlxMOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5S3bNEO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so5834232e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712507031; x=1713111831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAkOVNyT/5Ra+pwmZNT4qvTP2RlUxHwJBHeF7p1Ce+Q=;
        b=g5S3bNEO8RTPgal2s7dhn0IyI1GNH6IE1+Iq9jEy5IVpu0MDbntXvpfnCV863V8Wmh
         QkdpvvzvCna6TbdxgsOL7Dz1ahkek323iRBZWUwIptuugPNreIViMUAWFenMcmLiJ04V
         SygXOkkknlQm30P025W8Jt+7fofdS26AFWthRlkm3BAqAUZuKfLRqyK8nniH+AxBQ8Ff
         jjIsTpXUDlkDapHigYo2fhN14kzX3KERMkO14/lDxk7XldDSOY4RM0PpfX8hKlGGXg7g
         6LmmxP6AhkU60nxvLIlnadNtnA/kYPkI6EZ4lUaMJPKSSl22otqG05s7mFPT2OTHFzV7
         ArXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712507031; x=1713111831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAkOVNyT/5Ra+pwmZNT4qvTP2RlUxHwJBHeF7p1Ce+Q=;
        b=PZa0bmXnQY0s7/isLN4NptJGnYqCiP6YkXIpESkA0xqusow4nqtNYf/NrvnbnRctC0
         3Mh+q0TAY/C0bMJUHnyC3zImvcFaOTfpNn0PFnsSsuhLsPljP6WBuq075WWWJATtMWKT
         iFrk3JlU2MfekRj0YrAN4T0GHQgSP1LiaMUOgeIOAhsJVshYSRZvDa+4TSF5bH4cco6K
         9WybuE/aIrQO5BW3KEGS8hWodjpQaZHuK9vC7vnriFETE47VCiYUylaFWHC1WmbSsKFL
         lVNBFOWU3FE6hcbKMRBASM5QLSceOihLyJnXpQiY1GIzbipvBUnCZpVBeYn/A+vSBzPZ
         /clw==
X-Forwarded-Encrypted: i=1; AJvYcCUJliyOajj62FFGUwgw9UsM3KfnbaUp7e97KC+pIWhpo78n6wQ8V4uiSEHIbDxnm6ihM/Ywe858YtnRqaimz5jBOMtbfWOL3t+7SePa
X-Gm-Message-State: AOJu0Yw4sDtUjAuzFt/eNREWuUoGW5/iI8seg/t6/w7SHAIhcty9wS9D
	cfbTXGbh14afkK4AAAn5aFMA4dMoBCLXZxyOGgnzGNnv6RuK4sfdA5tI5gVqkNw=
X-Google-Smtp-Source: AGHT+IH1HsGV1ldOAKDQoqhT13xpNckBzeKGKJPta87ZCijRA5qKH1kHRssbvltw7UyD8xrUB9swTA==
X-Received: by 2002:a19:f70a:0:b0:513:e14d:15e1 with SMTP id z10-20020a19f70a000000b00513e14d15e1mr4752107lfe.57.1712507031492;
        Sun, 07 Apr 2024 09:23:51 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a51bed388a4sm1811626ejc.139.2024.04.07.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 09:23:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sun, 07 Apr 2024 19:23:27 +0300
Subject: [PATCH v9 7/7] spmi: pmic-arb: Add multi bus support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-spmi-multi-master-support-v9-7-fa151c1391f3@linaro.org>
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
In-Reply-To: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
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
 Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9935; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=OwopASy2ep6ZJbpGz0J2byN74JuY3NnqdRzQJbZ3tiM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmEsiJ1Ak8LJuvVIKzYNyokqaiGiZPIqyXZTIta
 t3/AdmDABmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZhLIiQAKCRAbX0TJAJUV
 VtuvEACHl01n9Aezub7b02hLPqlu93+YNOpAGNKbLLPe+qeEReS8jTtzJ17yQE3TfTDmSco+8Vj
 dWv4Rem+75b3eSB8bPpIH+tSm8r8Z+ejPMfrEYvDDp3o/GFfhwNK0tC51Rd4Xe7YUzvLL3cBFgC
 ioKhy1W1KagpJw6lsYsD9+rV1LTEcgF1kWNb8+1VztQUeaVQzVNNrAUJRfAKAjXIV82bDA/0Twz
 Hegq575hfzG9nC4sIzZgFq+WTzYxwuz13f9gHzNMfQRY+yrEFbs6gnGHiokM1Ov3FQ3Ns4dZxp9
 FpXcVRHBS8G1++5elE8Tc7RPje41xqGHeeSxAXORDnAe9wYy++672ZE5TcWXAH6wF1Gx65MKpE/
 t19K26gdlu4WWyllbJH52H5cpfNNv+QcrZpKmBLSqZGEbrrv71IzcHl28UYRaeUWO7+3xSUZOaQ
 BP9eZ8U8zalS5fEk/N2DdRsSdy/GLdEHR046cBEln7AjIZBtODK72I6Rq7QcO1lZEynn4uiasO7
 p0RgyDjrHqWFYAILIeWaGyqH5Qe41CdhJzms8YERcQs7eFdZcbCS6GhZTT+UTNXB9FmHvckpebZ
 jhs/wtYjXi/MZcznkY705O3yD1VBgSwiZAe3Jm1zsn77QfT8ONcqgiibbnIHJkEfLtJYl/Q1yej
 lTM6cES61MkTarA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Starting with HW version 7, there are actually two separate buses
(with two separate sets of wires). So add support for the second bus.
The first platform that needs this support for the second bus is the
Qualcomm X1 Elite, so add the compatible for it as well.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 138 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 18 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 65d8f45da24b..cfa8ec21cd56 100644
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
@@ -149,6 +152,7 @@ struct spmi_pmic_arb;
  * @min_apid:		minimum APID (used for bounding IRQ search)
  * @max_apid:		maximum APID
  * @irq:		PMIC ARB interrupt.
+ * @id:			unique ID of the bus
  */
 struct spmi_pmic_arb_bus {
 	struct spmi_pmic_arb	*pmic_arb;
@@ -167,6 +171,7 @@ struct spmi_pmic_arb_bus {
 	u16			min_apid;
 	u16			max_apid;
 	int			irq;
+	u8			id;
 };
 
 /**
@@ -180,7 +185,8 @@ struct spmi_pmic_arb_bus {
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
@@ -220,7 +227,7 @@ struct spmi_pmic_arb {
 struct pmic_arb_ver_ops {
 	const char *ver_str;
 	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
-	int (*init_apid)(struct spmi_pmic_arb_bus *bus);
+	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
 	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
 	int (*offset)(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
@@ -309,8 +316,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x) reg: 0x%x\n",
+					__func__, sid, addr, status, offset);
 				WARN_ON(1);
 				return -EIO;
 			}
@@ -326,8 +333,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 		udelay(1);
 	}
 
-	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
-		__func__, sid, addr, status);
+	dev_err(&ctrl->dev, "%s: %#x %#x %#x: timeout, status %#x\n",
+		__func__, bus->id, sid, addr, status);
 	return -ETIMEDOUT;
 }
 
@@ -1003,11 +1010,17 @@ static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
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
@@ -1250,11 +1263,17 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
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
@@ -1326,6 +1345,50 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
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
@@ -1578,7 +1641,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.ver_str		= "v7",
 	.get_core_resources	= pmic_arb_get_core_resources_v7,
-	.init_apid		= pmic_arb_init_apid_v5,
+	.init_apid		= pmic_arb_init_apid_v7,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v7,
@@ -1602,6 +1665,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 				  struct device_node *node,
 				  struct spmi_pmic_arb *pmic_arb)
 {
+	int bus_index = pmic_arb->buses_available;
 	struct spmi_pmic_arb_bus *bus;
 	struct device *dev = &pdev->dev;
 	struct spmi_controller *ctrl;
@@ -1620,7 +1684,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 
 	bus = spmi_controller_get_drvdata(ctrl);
 
-	pmic_arb->bus = bus;
+	pmic_arb->buses[bus_index] = bus;
 
 	raw_spin_lock_init(&bus->lock);
 
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
+	for (i = 0; i < pmic_arb->buses_available; i++) {
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
@@ -1760,21 +1864,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
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


