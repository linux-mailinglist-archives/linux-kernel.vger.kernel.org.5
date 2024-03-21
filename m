Return-Path: <linux-kernel+bounces-110669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC9886215
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8480C1F216E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548091350DE;
	Thu, 21 Mar 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O7q7Q7zo"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA172134730;
	Thu, 21 Mar 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054317; cv=none; b=VOO1Ox50Q+DUhMoxoMoIBBJVFbMcbD64JH+Z9mYgDA276bzXOyD1sIEkeXsiKvD5aM7tafiIEXoAif8wxWUWWPq1j/a9fXY+YwqrDSmm195a/yFB2MEU1Dv9eeqWxaUwTXbrjXmtLmlf/BZzbaAlFmHcGpK1caK+8jmtqwuRJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054317; c=relaxed/simple;
	bh=EWSQZbLKltA576F0v2LDL1XaSY1RWR9Zmz8vBywoEnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r/qvKxHU3RYmUuNl2iXUS/lTP6alNRC50PAvw/NHDtUQFj8sih2jQ1DqhDe94MfbnxbvpcxP2Rnax9Adt3noJ4LAyo51wKd2ctdGfKF3TbATtpUuUJu9Ckak7ChJSUcyVrrwF9Q98+2GlViFyYFLg+WV9VTYojmaOLrufpdM95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O7q7Q7zo; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LG6ego008433;
	Thu, 21 Mar 2024 20:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pps0720;
 bh=0VF6Qsbgvi5kvAOR9Hh2Jqp04LsybsA0VMD0vaxRCE0=;
 b=O7q7Q7zoNSgkvd8FJMztFBnBerjqwNG1HuuFs4lU7meo23/+l6szSSAn7j1MBObabZP4
 ZAzEV/x2cwDSdbEQ2Ld3+foa1xLeuJWE5HbBd9PL0uoNGPbziLoWiW/0iFLhBFYEC3Ls
 Wx62Y9OCAvubfGPmrbWboPeuQysIQ/ihgZnh5JFsrOFR+GJCVQsQpeKsYE4qvd0vfYSr
 EVakBkoXsiGp58UozYnvfd1CW8FtAYPnN6W24wsQtiHE68r8Wz6ccPg16rQaGBiAz6y5
 U/XwKEP+RqK16gtzYt5vakGwsyDYbVw7ZMdAlShi6/RX/YGR6fcBaZq69YOkYhSkID1V 9A== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x0r4ct9h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:51:01 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 10649295D6;
	Thu, 21 Mar 2024 20:51:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id F30F3800E99;
	Thu, 21 Mar 2024 20:50:50 +0000 (UTC)
Date: Thu, 21 Mar 2024 15:50:46 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>, iommu@lists.linux.dev,
        Dimitri Sivanich <sivanich@hpe.com>
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Message-ID: <Zfydpp2Hm+as16TY@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: 1TYOXf80qN3aNDTwnTnVvmqsqVakvS-2
X-Proofpoint-GUID: 1TYOXf80qN3aNDTwnTnVvmqsqVakvS-2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403210156

The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
vectors on the boot cpu.  On large systems with high DMAR counts this
results in vector exhaustion, and most of the vectors are not initially
allocated socket local.

Instead, have a cpu on each node do the vector allocation for the DMARs on
that node.  The boot cpu still does the allocation for its node during its
boot sequence.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
---

v2: per Thomas Gleixner, implement this from a DYN CPU hotplug state, though
    this implementation runs in CPUHP_AP_ONLINE_DYN space rather than
    CPUHP_BP_PREPARE_DYN space.

 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 drivers/iommu/intel/dmar.c    | 9 +++++++--
 drivers/iommu/irq_remapping.c | 5 ++++-
 drivers/iommu/irq_remapping.h | 2 +-
 include/linux/dmar.h          | 2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f482aab420f7..410c360e7e24 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -33,7 +33,7 @@ int amd_iommu_prepare(void);
 int amd_iommu_enable(void);
 void amd_iommu_disable(void);
 int amd_iommu_reenable(int mode);
-int amd_iommu_enable_faulting(void);
+int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e7a44929f0da..4782f690ed97 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3389,7 +3389,7 @@ int amd_iommu_reenable(int mode)
 	return 0;
 }
 
-int __init amd_iommu_enable_faulting(void)
+int __init amd_iommu_enable_faulting(unsigned int cpu)
 {
 	/* We enable MSI later when PCI is initialized */
 	return 0;
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..7644a42f283c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2122,7 +2122,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	return ret;
 }
 
-int __init enable_drhd_fault_handling(void)
+int enable_drhd_fault_handling(unsigned int cpu)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
@@ -2132,7 +2132,12 @@ int __init enable_drhd_fault_handling(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
+		int ret;
+
+		if (iommu->irq || iommu->node != cpu_to_node(cpu))
+			continue;
+
+		ret = dmar_set_interrupt(iommu);
 
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index ee59647c2050..2f7281ccc05f 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -151,7 +151,10 @@ int __init irq_remap_enable_fault_handling(void)
 	if (!remap_ops->enable_faulting)
 		return -ENODEV;
 
-	return remap_ops->enable_faulting();
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "dmar:enable_fault_handling",
+			  remap_ops->enable_faulting, NULL);
+
+	return remap_ops->enable_faulting(smp_processor_id());
 }
 
 void panic_if_irq_remap(const char *msg)
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 8c89cb947cdb..0d6f140b5e01 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -41,7 +41,7 @@ struct irq_remap_ops {
 	int  (*reenable)(int);
 
 	/* Enable fault handling */
-	int  (*enable_faulting)(void);
+	int  (*enable_faulting)(unsigned int);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e34b601b71fd..499bb2c63483 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -117,7 +117,7 @@ extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
 				 int count);
 /* Intel IOMMU detection */
 void detect_intel_iommu(void);
-extern int enable_drhd_fault_handling(void);
+extern int enable_drhd_fault_handling(unsigned int cpu);
 extern int dmar_device_add(acpi_handle handle);
 extern int dmar_device_remove(acpi_handle handle);
 
-- 
2.35.3


