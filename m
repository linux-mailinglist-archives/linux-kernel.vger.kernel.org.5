Return-Path: <linux-kernel+bounces-65661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33406855028
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92FD28F788
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868B129A69;
	Wed, 14 Feb 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1Pl/ii5H"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994684047;
	Wed, 14 Feb 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931361; cv=none; b=sJ3M3j7y88MmTr5A71omdjBgU7bzvhJF632fR+Zez95HSdYiBRIDWWfkg70hgABpVuq1YyLY2By/HebhNruDiHOxy8f8qWkGQJ65SB3+dGSO2odY7iRbuWcx6jpnOKE4h3vfqloT9vXrPUGVfuRH+LHU7l7Ep3hGOvegVvCdSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931361; c=relaxed/simple;
	bh=CRyc1Zow9q2eOb3Vup4ogTxRj24JHuvpDHUTFQSCXCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/qErHQdhz+VdPwjBzoTwLh02VvxAT/Q07QwG4fRWWZLBJ0ddz+wAJyBBhHHDjuMbQvNJhl15fu3EnBDOUgRAIDF0OWZ7puJ+63Fu3LstKPKCQJteENklvwfGL75unj4EXo28OFRdHPTX04HFt3max8m/JwloFL2gpLkovpvfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1Pl/ii5H; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EGZZKW017077;
	Wed, 14 Feb 2024 18:22:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=QJGdR7T1RAMulvzBV6KzWPdgGJO8ZLSH7zr0wo/PFu0=; b=1P
	l/ii5HQj2gOqq+CGCFTkUZ2WXCEN/8WgQ+2XBiQtKIf+dPkpMiTzJkKF/lcUkgd0
	ywbeRiFmkJ+euWbOmhMGFy5gh+aWk8B3wuSfHFWT2kGmVbbm4rvdbwShcyAuB9Es
	38cogwrNL4ZjzqF6VVvbRnAlSofSgDupp3XHjdjFz5mUTozKpuZb1JtX6RTQusQM
	fL+DluvQVfmQ2Pj3TAnGVxHVMvqzD/YX5ai8fVcaTQA0a6K7AhyF5i9UYBTmwNUL
	VRmzXZ1bci/xJ/ZRXHXXGRlvXzmi83zEMWi0aXsIz6uWZDtKSmpv0P7Fgapj+aap
	h1afNitzJr9tCRBJUmDA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62shywsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:22:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 392D840047;
	Wed, 14 Feb 2024 18:22:19 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91F852CA54D;
	Wed, 14 Feb 2024 18:21:34 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:34 +0100
Received: from localhost (10.201.20.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:34 +0100
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
Subject: [PATCH v3 4/7] remoteproc: core: Implement the support of an alternative boot
Date: Wed, 14 Feb 2024 18:21:24 +0100
Message-ID: <20240214172127.1022199-5-arnaud.pouliquen@foss.st.com>
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

Implement a new method to load a firmware and start the remote processor.
In this method the firmware is loaded first and then the loaded resource
table is obtained.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 86 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  2 +
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 34b0093689da..47956e07365e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -38,6 +38,7 @@
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
 #include <linux/platform_device.h>
+#include <linux/tee_remoteproc.h>
 
 #include "remoteproc_internal.h"
 
@@ -1493,6 +1494,86 @@ static int rproc_set_rsc_table(struct rproc *rproc)
 	return 0;
 }
 
+/*
+ * Alternative method to load a firmware and boot a remote processor with it.
+ * Similar to rproc_fw_boot but the resource table is obtained and parsed only after loading the
+ * firmware.
+ */
+static int rproc_alt_fw_boot(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	const char *name = rproc->firmware;
+	int ret;
+
+	dev_info(dev, "Booting a private format image %s, size %zd\n", name, fw->size);
+
+	/*
+	 * if enabling an IOMMU isn't relevant for this rproc, this is
+	 * just a nop
+	 */
+	ret = rproc_enable_iommu(rproc);
+	if (ret) {
+		dev_err(dev, "can't enable iommu: %d\n", ret);
+		return ret;
+	}
+
+	/* Prepare rproc for firmware loading if needed */
+	ret = rproc_prepare_device(rproc);
+	if (ret) {
+		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
+		goto disable_iommu;
+	}
+
+	/* load the image to memory */
+	ret = rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret = rproc_set_rsc_table(rproc);
+	if (ret) {
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		goto unprepare_device;
+	}
+
+	/* reset max_notifyid */
+	rproc->max_notifyid = -1;
+
+	/* reset handled vdev */
+	rproc->nb_vdev = 0;
+
+	/* handle fw resources which are required to boot rproc */
+	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
+	if (ret) {
+		dev_err(dev, "Failed to process resources: %d\n", ret);
+		goto clean_up_resources;
+	}
+
+	/* Allocate carveout resources associated to rproc */
+	ret = rproc_alloc_registered_carveouts(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
+			ret);
+		goto clean_up_resources;
+	}
+
+	ret = rproc_start(rproc, fw);
+	if (ret)
+		goto clean_up_resources;
+
+	return 0;
+
+clean_up_resources:
+	rproc_resource_cleanup(rproc);
+unprepare_device:
+	/* release HW resources if needed */
+	rproc_unprepare_device(rproc);
+disable_iommu:
+	rproc_disable_iommu(rproc);
+	return ret;
+}
+
 static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
 {
 	struct resource_table *table_ptr;
@@ -1957,7 +2038,10 @@ int rproc_boot(struct rproc *rproc)
 			goto downref_rproc;
 		}
 
-		ret = rproc_fw_boot(rproc, firmware_p);
+		if (rproc->alt_boot)
+			ret = rproc_alt_fw_boot(rproc, firmware_p);
+		else
+			ret = rproc_fw_boot(rproc, firmware_p);
 
 		release_firmware(firmware_p);
 	}
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..ba219a77e055 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -544,6 +544,7 @@ enum rproc_features {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @alt_boot flag to indicate if remoteproc should use the alternate boot method.
  * @features: indicate remoteproc features
  */
 struct rproc {
@@ -585,6 +586,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	bool alt_boot;
 	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
-- 
2.25.1


