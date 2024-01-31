Return-Path: <linux-kernel+bounces-46326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBA843E08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CB51C25811
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57E78689;
	Wed, 31 Jan 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XEYs3V5f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20877D3F5;
	Wed, 31 Jan 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699437; cv=none; b=gwNSMPzvwsjp/XiJMfwWHFQ3JUbSr6j8OrWZe+xG4ARKgK3Nh7wA8WJZEBr3OPfivTlUsjoB+s1r7hjex4n133+nayVAZM3jOxAjpaRgA3KHVxtUGb9+HkPsU06bCNN206gJywAsMChxJMoAsxh8wjsgZgNjXZzG/Ds5HNuq2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699437; c=relaxed/simple;
	bh=1ZxZNZCM1dcA+Ma7AiD7q3Mt0qj7DACwdROPA6/w67o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFhFK022H0fgiMtEsILCLH+Do0dLUdT5UhJ8KeawHYhIXbGN9ZjLsMBCgjUO7K2N0XnuzHz/I3SxTa1go8/BJI6aI4kHDsVe19r25ahWYAvZJSxCv87372PQQXHaukHfn5oXSFbkqQj2VAWAFPVQtzHlf1yuoI0CvdrnR+Ya6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XEYs3V5f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77Ptj006138;
	Wed, 31 Jan 2024 11:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+9dhGTuTrvDtNIxH7q5czr/K4CZ1+Dif8CoPgq5i65c=; b=XE
	Ys3V5fea3aPXd0nlGhRr8D6HJynYVcwwTObEOhqXL6gK9aCbZlnAGcLXf/M3QMAx
	Ha/0WFeMThoorYL0kvK0uBJUAMuY3hdhyohhIcjzlQDpXzXReyTqsbwkgFoatMaT
	MUQ47QaA4KQte4UYYEQczEC9RDbtU4f6iGdRjEGDgKBs6fC8gOn1LzLTsBRN1QF4
	R+pGUfClGSL7KN4TCdYbm9Je6+9HpUUgFu3OnswnJLaZLJ91mkmlL70ghuLn43aS
	owHbS7xefK0xOeSfCaWUzBxGsXFFm7k26OFnXKO6Q76P5K58H5fAzwBRts/NIHfS
	/TYTQ8orDjg+nhhj6lWg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9nk9myw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VB9vEV029469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:09:57 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 03:09:48 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v8 08/10] pstore/ram: Add dynamic ramoops region support through commandline
Date: Wed, 31 Jan 2024 16:38:35 +0530
Message-ID: <20240131110837.14218-9-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131110837.14218-1-quic_mojha@quicinc.com>
References: <20240131110837.14218-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJms8reXROJQi96M27V1G5W0C5FueIDu
X-Proofpoint-ORIG-GUID: pJms8reXROJQi96M27V1G5W0C5FueIDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310085

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This may not be
required for something like Qualcomm's minidump which is interested
in knowing addresses of ramoops region but it does not put hard
requirement of address being fixed as most of its SoC does not
support warm reset and does not use pstorefs at all instead it has
firmware way of collecting ramoops region if it gets to know the
address and register it with apss minidump table which is sitting
in shared memory region in DDR and firmware will have access to
these table during reset and collects it on crash of SoC.

So, add the support of reserving ramoops region to be dynamically
allocated early during boot if it is request through command line
via 'dyn_ramoops_size=<size>' and fill up reserved resource structure
and export the structure, so that it can be read by ramoops driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/admin-guide/ramoops.rst | 23 +++++++++-
 fs/pstore/Kconfig                     | 15 ++++++
 fs/pstore/ram.c                       | 66 +++++++++++++++++++++++++--
 include/linux/pstore_ram.h            |  5 ++
 init/main.c                           |  3 ++
 5 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f85142182d..6de61002f9e9 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
 Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
 which enables full cache on it. This can improve the performance.
 
+Ramoops supports its memory to be allocated dynamically during early boot
+for plaforms that do not have support for warm boot i.e., no assurance
+that Ram content will be preserved across boot and for these platforms
+giving static Ramoops memory is not necessary as it has separate backend
+mechanism to retrieve ramoops content on system failure. More about
+how to enable Dynamic ramoops in ``Setting the parameters`` A.b section.
+
 The memory area is divided into ``record_size`` chunks (also rounded down to
 power of two) and each kmesg dump writes a ``record_size`` chunk of
 information.
@@ -59,7 +66,7 @@ Setting the parameters
 
 Setting the ramoops parameters can be done in several different manners:
 
- A. Use the module parameters (which have the names of the variables described
+ A.a  Use the module parameters (which have the names of the variables described
  as before). For quick debugging, you can also reserve parts of memory during
  boot and then use the reserved memory for ramoops. For example, assuming a
  machine with > 128 MB of memory, the following kernel command line will tell
@@ -68,6 +75,20 @@ Setting the ramoops parameters can be done in several different manners:
 
 	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
 
+ A.b  Ramoops memory can be also be dynamically reserved by Kernel and in such
+ scenario ``mem_address`` i.e., Ramoops base address can be anywhere in the RAM
+ instead of being fixed and predefined. A separate command line option
+ ``dyn_ramoops_size=<size>`` and kernel config CONFIG_PSTORE_DYNAMIC_RAMOOPS
+ are provided to facilitate Dynamic Ramoops memory reservation during early boot.
+ The command line option and the config should only be used in the presence of
+ separate backend which knows how to recover Dynamic Ramoops region otherwise
+ regular ramoops functionality will be impacted.
+ ``mem_size`` should not be used if Dynamic Ramoops support is requested and if
+ both are given ``mem_size`` value is overwritten with ``dyn_ramoops_size`` value
+ i.e., Dynamic Ramoops takes precedence::
+
+	dyn_ramoops_size=2M ramoops.console_size=2097152
+
  B. Use Device Tree bindings, as described in
  ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
  For example::
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..b8bdbd2f0e73 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,21 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_DYNAMIC_RAMOOPS
+	bool "Reserve ramoops region dynamically"
+	select PSTORE_RAM
+	help
+	  This enables the dynamic reservation of ramoops region for a special case
+	  where there is no need to access the logs from pstorefs on next boot;
+	  instead there is separate backend mechanism like minidump present which has
+	  awareness about the dynamic ramoops region and can recover the logs. This is
+	  enabled via command line parameter dyn_ramoops_size=<size> and should not be
+	  used in absence of separate backend which knows how to recover this dynamic
+	  region.
+
+	  Note whenever this config is selected ramoops driver will be built statically
+	  into kernel.
+
 config PSTORE_ZONE
 	tristate
 	depends on PSTORE
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 88b34fdbf759..1faf0835700b 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 
 #include "internal.h"
@@ -103,6 +104,59 @@ struct ramoops_context {
 };
 
 static struct platform_device *dummy;
+static struct resource dyn_ramoops_res = {
+	.name  = "ramoops",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_NONE,
+};
+static int dyn_ramoops_size;
+
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
+static int __init parse_dyn_ramoops_size(char *p)
+{
+	char *tmp;
+
+	dyn_ramoops_size = memparse(p, &tmp);
+	if (p == tmp) {
+		pr_err("ramoops: memory size expected\n");
+		dyn_ramoops_size = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
+
+/*
+ * setup_dynamic_ramoops() - Reserve memory for dynamic ramoops
+ *
+ * Enables dynamic reserve memory support for ramoops through
+ * command line.
+ */
+void __init setup_dynamic_ramoops(void)
+{
+	unsigned long long ramoops_base;
+	unsigned long long ramoops_size;
+
+	if (!dyn_ramoops_size)
+		return;
+
+	ramoops_base = memblock_phys_alloc_range(dyn_ramoops_size, SMP_CACHE_BYTES,
+						 0, MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!ramoops_base) {
+		pr_err("cannot allocate ramoops dynamic memory (size:0x%llx).\n",
+			ramoops_size);
+		dyn_ramoops_size = 0;
+		return;
+	}
+
+	dyn_ramoops_res.start = ramoops_base;
+	dyn_ramoops_res.end = ramoops_base + dyn_ramoops_size - 1;
+	insert_resource(&iomem_resource, &dyn_ramoops_res);
+}
+#endif
 
 static int ramoops_pstore_open(struct pstore_info *psi)
 {
@@ -915,13 +969,19 @@ static void __init ramoops_register_dummy(void)
 
 	/*
 	 * Prepare a dummy platform data structure to carry the module
-	 * parameters. If mem_size isn't set, then there are no module
-	 * parameters, and we can skip this.
+	 * parameters.
+	 *
+	 * dyn_ramoops_size takes precedence over mem_size if it is
+	 * enabled and valid.
 	 */
-	if (!mem_size)
+	if (!dyn_ramoops_size && !mem_size)
 		return;
 
 	pr_info("using module parameters\n");
+	if (dyn_ramoops_size) {
+		mem_size = dyn_ramoops_size;
+		mem_address = dyn_ramoops_res.start;
+	}
 
 	memset(&pdata, 0, sizeof(pdata));
 	pdata.mem_size = mem_size;
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9d65ff94e216..1efff7a38333 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -39,4 +39,9 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
+void __init setup_dynamic_ramoops(void);
+#else
+static inline void __init setup_dynamic_ramoops(void) {}
+#endif
 #endif
diff --git a/init/main.c b/init/main.c
index ef3ce41b8fc5..3d74241bcb2b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,8 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/moduleloader.h>
+#include <linux/pstore_ram.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -890,6 +892,7 @@ void start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_dynamic_ramoops();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.43.0.254.ga26002b62827


