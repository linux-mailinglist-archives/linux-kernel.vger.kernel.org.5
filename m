Return-Path: <linux-kernel+bounces-65671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C799855042
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E191C21FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5A127B47;
	Wed, 14 Feb 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="E1YIRe4g"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD684FA0;
	Wed, 14 Feb 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931405; cv=none; b=rhv2G2+a9nmMSMHkFmnuVJCBuMuzoPQ6tEl+FX6pPnT3U2joWYf+oJO/EYSLOPq3qQ92xcHirgxNrR63OQWcgkcwypTyqjYAoGUr46/i2D2YnR9FNaq7Gub7Lxa8TDqujjPLKQ6BQex+jvUmV2IFkNQhO8u4sORqC4CP1FXNPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931405; c=relaxed/simple;
	bh=83FYFITJxZ0ToyIf4Cort5eRKEEZpBch36s5bpwbgko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQYvgHA4n8YeUPD/lAP0m2HHUAwf3Nxy3fB+NQBhWeyOFo2vzbler312ssHGDh0HuZJZzMGAUryWcw/EN1yUECXr/ypmuk/jZA4m/vKM6RMtb9PF7a5slMRRoilSPy1jIhFSP30OM76+jSMRqwsBhs/JeIiv9VYM8g3rHxW8ijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=E1YIRe4g; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EHEGZl026396;
	Wed, 14 Feb 2024 18:23:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=c2yeVpc3MZbl0q16caO2boLot7TbDyFbU6polZTQNW0=; b=E1
	YIRe4geOgTlnVbLobG5AGMxz1beN9c2eAI21IzPJHM+jnLA2KW4RQm2nIQoxZR3V
	QaJ8/yT9vjGCN58BuypGE3Zv2TP/V/3qIG83Ejb3l0FK97dhoY2AUsSpGklK0u/G
	4ZTSDxfWEwdtw3BgcK3NpreepMqDnRpnlELYXrFkjq8C1FxyPXtQhi2XhhA5//n4
	x6085imLiYi4qt3lnxHl59KK6rKb2rbkgKiCdApY0cf2fCeV8Sy4ENZGz/oRPloE
	Xdjny4hY9ngyegILyOWrFW1hc0EHszGcJTkPCr8pGdHJSeUmacmnzA69vuvlAE/0
	Tw4IWsAwtZPll6txZuEQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4wwef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:23:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 841CB4002D;
	Wed, 14 Feb 2024 18:23:05 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 129D42CA550;
	Wed, 14 Feb 2024 18:21:37 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:36 +0100
Received: from localhost (10.201.20.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:36 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 7/7] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
Date: Wed, 14 Feb 2024 18:21:27 +0100
Message-ID: <20240214172127.1022199-8-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02

The new TEE remoteproc device is used to manage remote firmware in a
secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
introduced to delegate the loading of the firmware to the trusted
execution context. In such cases, the firmware should be signed and
adhere to the image format defined by the TEE.

A new "to_attach" field is introduced to differentiate the use cases
"firmware loaded by the boot stage" and "firmware loaded by the TEE".

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
V2 to V3 update:
- remove stm32_rproc_tee_elf_sanity_check(), stm32_rproc_tee_elf_load()
  stm32_rproc_tee_elf_find_loaded_rsc_table() and  stm32_rproc_tee_start() that are bnow unused
- use new rproc::alt_boot field to sepcify that the alternate fboot method is used
- use stm32_rproc::to_attach field to differenciate attch mode from remoteproc tee boot mode.
- remove the used of stm32_rproc::fw_loaded
---
 drivers/remoteproc/stm32_rproc.c | 85 +++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index fcc0001e2657..9cfcf66462e0 100644
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
+	bool to_attach;
+	struct tee_rproc *trproc;
 	void __iomem *rsc_va;
 };
 
@@ -253,10 +259,30 @@ static int stm32_rproc_release(struct rproc *rproc)
 			return err;
 		}
 	}
+	ddata->to_attach = false;
 
 	return err;
 }
 
+static int stm32_rproc_tee_attach(struct rproc *rproc)
+{
+	/* Nothing to do, remote proc already started by the secured context. */
+	return 0;
+}
+
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err = tee_rproc_stop(rproc);
+	if (err)
+		return err;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
@@ -637,10 +663,14 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 {
 	struct stm32_rproc *ddata = rproc->priv;
 	struct device *dev = rproc->dev.parent;
+	struct tee_rproc *trproc = ddata->trproc;
 	phys_addr_t rsc_pa;
 	u32 rsc_da;
 	int err;
 
+	if (trproc && !ddata->to_attach)
+		return tee_rproc_get_loaded_rsc_table(rproc, table_sz);
+
 	/* The resource table has already been mapped, nothing to do */
 	if (ddata->rsc_va)
 		goto done;
@@ -693,8 +723,20 @@ static const struct rproc_ops st_rproc_ops = {
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
+static const struct rproc_ops st_rproc_tee_ops = {
+	.prepare	= stm32_rproc_prepare,
+	.start		= tee_rproc_start,
+	.stop		= stm32_rproc_tee_stop,
+	.attach		= stm32_rproc_tee_attach,
+	.kick		= stm32_rproc_kick,
+	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
+	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
+	.load		= tee_rproc_load_fw,
+};
+
 static const struct of_device_id stm32_rproc_match[] = {
-	{ .compatible = "st,stm32mp1-m4" },
+	{.compatible = "st,stm32mp1-m4",},
+	{.compatible = "st,stm32mp1-m4-tee",},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -853,6 +895,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np = dev->of_node;
+	struct tee_rproc *trproc = NULL;
 	struct rproc *rproc;
 	unsigned int state;
 	int ret;
@@ -861,12 +904,33 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
-	if (!rproc)
-		return -ENOMEM;
+	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
+		/*
+		 * Delegate the firmware management to the secure context.
+		 * The firmware loaded has to be signed.
+		 */
+		trproc = tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
+		if (IS_ERR(trproc)) {
+			dev_err_probe(dev, PTR_ERR(trproc),
+				      "signed firmware not supported by TEE\n");
+			return PTR_ERR(trproc);
+		}
+	}
 
-	ddata = rproc->priv;
+	rproc = rproc_alloc(dev, np->name,
+			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
+			    NULL, sizeof(*ddata));
+	if (!rproc) {
+		ret = -ENOMEM;
+		goto free_tee;
+	}
 
+	ddata = rproc->priv;
+	ddata->trproc = trproc;
+	if (trproc) {
+		rproc->alt_boot = true;
+		trproc->rproc = rproc;
+	}
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
@@ -881,8 +945,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	if (state == M4_STATE_CRUN)
+	if (state == M4_STATE_CRUN) {
 		rproc->state = RPROC_DETACHED;
+		ddata->to_attach = true;
+	}
 
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
@@ -916,6 +982,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+free_tee:
+	if (trproc)
+		tee_rproc_unregister(trproc);
+
 	return ret;
 }
 
@@ -923,6 +993,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct stm32_rproc *ddata = rproc->priv;
+	struct tee_rproc *trproc = ddata->trproc;
 	struct device *dev = &pdev->dev;
 
 	if (atomic_read(&rproc->power) > 0)
@@ -937,6 +1008,8 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+	if (trproc)
+		tee_rproc_unregister(trproc);
 }
 
 static int stm32_rproc_suspend(struct device *dev)
-- 
2.25.1


