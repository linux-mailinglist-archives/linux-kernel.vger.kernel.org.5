Return-Path: <linux-kernel+bounces-29999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC283167F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828061F235D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38115208AD;
	Thu, 18 Jan 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Wh0BVPmU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F742030E;
	Thu, 18 Jan 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572591; cv=none; b=KgSFni/qzI1Gd1gXyB2Dj26gTqG0OniolqSmwIF+Hc07x0El1rQ3cACaG5u2llmweVaL/6C63/dSVatxTYubdhwJrjBk54uUD3lxpcXIiS5+R00+mEgdU5fE68OmgEA2c19ebRQrDGwTbYLCGtdueempADDYWarqgMk89Om1BuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572591; c=relaxed/simple;
	bh=92ItJwOBecwjoQPK3gZ/6rdqrX12HFuollhqbYBbjs4=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-Proofpoint-Virus-Version; b=kDjpqhXQhsE7idNLCNrnewFD1z0we/Yrw2m5DIXntm0SNeiaForpe5ebQ6jS5rMLCEVlybAdwJptX2Yiac2OTge85XFJFlw9GpLELqB6L97aFKnWRg2iDP8sOqfVJZN9xKej+xJHGZrM453IsMXWFdvZa8Ukcf9+IcAAtiC7T00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Wh0BVPmU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I3xc3Y005633;
	Thu, 18 Jan 2024 11:09:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=SD1hzU/kFO4VdLwZk4y4ZTVUMXYz1/5Le65Cg8rPuEE=; b=Wh
	0BVPmUg0eetfcNjgDZvqPld81yD8fRbSGtwzwqZIbpib9h1CGJ2/65EGPtvIgh/3
	vz5/6Lxdebh+/XKeXmOQhxiEWuUCntDl20/nulcwRz4aYeg/jsOLPylUGfA0xb3q
	tQa5vdt6wyyqY+RsAd50EoJL+3IJ4wmKHDDry1gRtdWB3g/NjcbyWcQj+GFn7UAt
	R0ObE7hULHC7zuO7DbnLsIomDsNrU9rQ00nW7AOTu1rqFKJfUpi2W/FqpyVvWPcd
	DnW6yYMt6BTZqxNoX6NOTcNt3tUsUCbMzijyt8shcSbtjMITVtd3Dgivh6zGUdK9
	VCs9xGCvzAQZ8SxcYH9g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y560eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:09:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E000610007D;
	Thu, 18 Jan 2024 11:09:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D624821A237;
	Thu, 18 Jan 2024 11:09:26 +0100 (CET)
Received: from localhost (10.201.20.75) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 18 Jan
 2024 11:09:26 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
Date: Thu, 18 Jan 2024 11:04:33 +0100
Message-ID: <20240118100433.3984196-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_05,2024-01-17_01,2023-05-22_02

The new TEE remoteproc device is used to manage remote firmware in a
secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
introduced to delegate the loading of the firmware to the trusted
execution context. In such cases, the firmware should be signed and
adhere to the image format defined by the TEE.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V1 to V2 update:
- remove the select "TEE_REMOTEPROC" in STM32_RPROC config as detected by
  the kernel test robot:
     WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
     Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
     Selected by [y]:
     - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]
- Fix initialized trproc variable in  stm32_rproc_probe
---
 drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index fcc0001e2657..cf6a21bac945 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -20,6 +20,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/tee_remoteproc.h>
 #include <linux/workqueue.h>
 
 #include "remoteproc_internal.h"
@@ -49,6 +50,9 @@
 #define M4_STATE_STANDBY	4
 #define M4_STATE_CRASH		5
 
+/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */
+#define STM32_MP1_M4_PROC_ID    0
+
 struct stm32_syscon {
 	struct regmap *map;
 	u32 reg;
@@ -90,6 +94,8 @@ struct stm32_rproc {
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
 	bool hold_boot_smc;
+	bool fw_loaded;
+	struct tee_rproc *trproc;
 	void __iomem *rsc_va;
 };
 
@@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc *rproc)
 	return err;
 }
 
+static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
+					    const struct firmware *fw)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	unsigned int ret = 0;
+
+	if (rproc->state == RPROC_DETACHED)
+		return 0;
+
+	ret = tee_rproc_load_fw(ddata->trproc, fw);
+	if (!ret)
+		ddata->fw_loaded = true;
+
+	return ret;
+}
+
+static int stm32_rproc_tee_elf_load(struct rproc *rproc,
+				    const struct firmware *fw)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	unsigned int ret;
+
+	/*
+	 * This function can be called by remote proc for recovery
+	 * without the sanity check. In this case we need to load the firmware
+	 * else nothing done here as the firmware has been preloaded for the
+	 * sanity check to be able to parse it for the resource table.
+	 */
+	if (ddata->fw_loaded)
+		return 0;
+
+	ret = tee_rproc_load_fw(ddata->trproc, fw);
+	if (ret)
+		return ret;
+	ddata->fw_loaded = true;
+
+	/* Update the resource table parameters. */
+	if (rproc_tee_get_rsc_table(ddata->trproc)) {
+		/* No resource table: reset the related fields. */
+		rproc->cached_table = NULL;
+		rproc->table_ptr = NULL;
+		rproc->table_sz = 0;
+	}
+
+	return 0;
+}
+
+static struct resource_table *
+stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
+					  const struct firmware *fw)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+
+	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
+}
+
+static int stm32_rproc_tee_start(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+
+	return tee_rproc_start(ddata->trproc);
+}
+
+static int stm32_rproc_tee_attach(struct rproc *rproc)
+{
+	/* Nothing to do, remote proc already started by the secured context. */
+	return 0;
+}
+
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err = tee_rproc_stop(ddata->trproc);
+	if (err)
+		return err;
+
+	ddata->fw_loaded = false;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
@@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 
 static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
-	if (rproc_elf_load_rsc_table(rproc, fw))
+	struct stm32_rproc *ddata = rproc->priv;
+	int ret;
+
+	if (ddata->trproc)
+		ret = rproc_tee_get_rsc_table(ddata->trproc);
+	else
+		ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret)
 		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
 
 	return 0;
@@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops = {
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
+static const struct rproc_ops st_rproc_tee_ops = {
+	.prepare	= stm32_rproc_prepare,
+	.start		= stm32_rproc_tee_start,
+	.stop		= stm32_rproc_tee_stop,
+	.attach		= stm32_rproc_tee_attach,
+	.kick		= stm32_rproc_kick,
+	.parse_fw	= stm32_rproc_parse_fw,
+	.find_loaded_rsc_table = stm32_rproc_tee_elf_find_loaded_rsc_table,
+	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
+	.sanity_check	= stm32_rproc_tee_elf_sanity_check,
+	.load		= stm32_rproc_tee_elf_load,
+};
+
 static const struct of_device_id stm32_rproc_match[] = {
-	{ .compatible = "st,stm32mp1-m4" },
+	{.compatible = "st,stm32mp1-m4",},
+	{.compatible = "st,stm32mp1-m4-tee",},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np = dev->of_node;
+	struct tee_rproc *trproc = NULL;
 	struct rproc *rproc;
 	unsigned int state;
 	int ret;
@@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
-	if (!rproc)
-		return -ENOMEM;
+	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
+		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
+		if (IS_ERR(trproc)) {
+			dev_err_probe(dev, PTR_ERR(trproc),
+				      "signed firmware not supported by TEE\n");
+			return PTR_ERR(trproc);
+		}
+		/*
+		 * Delegate the firmware management to the secure context.
+		 * The firmware loaded has to be signed.
+		 */
+		dev_info(dev, "Support of signed firmware only\n");
+	}
+	rproc = rproc_alloc(dev, np->name,
+			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
+			    NULL, sizeof(*ddata));
+	if (!rproc) {
+		ret = -ENOMEM;
+		goto free_tee;
+	}
 
 	ddata = rproc->priv;
+	ddata->trproc = trproc;
+	if (trproc)
+		trproc->rproc = rproc;
 
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
@@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+free_tee:
+	if (trproc)
+		tee_rproc_unregister(trproc);
+
 	return ret;
 }
 
@@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+	if (ddata->trproc)
+		tee_rproc_unregister(ddata->trproc);
 }
 
 static int stm32_rproc_suspend(struct device *dev)
-- 
2.25.1


