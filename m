Return-Path: <linux-kernel+bounces-29367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A82830D50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B5C1C21349
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72D249F0;
	Wed, 17 Jan 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KC9fgn+y"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E1249E0;
	Wed, 17 Jan 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520144; cv=none; b=XULUPQEipaGUOt537HzxU7X99a3tv0UN0d9UJ7ZG1RBj33mIDumX0hX3PQSmQkx2UgI4pvhSrzFyiM8y+hH9kSTdxyoVvVdXSjyPfQqmsAJOvDFIqZJ6oympEMh5BrdIV3Z7Rr6dKbk7CzlmihV6LySbrbcKPncipUebwxPYWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520144; c=relaxed/simple;
	bh=8O6ZpuJktfG7PP+qpivWRnoX8s1X5AAm7DEcq/yXN3A=;
	h=Received:DKIM-Signature:Received:Received:Received:Date:From:To:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-HPE-SCL:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=tEQ5IOY+OM9917u+zTHuJVB/TgrDNq/uGRWgf7irMcLezIiDXstWV/arW85srGVoRwYNqfd40L0B3P1yYyVu/BGX5j3MyWcHQfi2xD0O/dKiYeOTlEaNpYWxFMn4/27uoLKErv6f7SCFTEIG0FDrcNJq4fvvJAKsdXiv8NHxRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KC9fgn+y; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HH0uDr020284;
	Wed, 17 Jan 2024 19:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=pps0720;
 bh=5NEj7FBKtmppNrd48cW0AoeV3qh+diVhVYhI4Gm/3pA=;
 b=KC9fgn+yBrtzXiYmu2c4kPQavGuUpPlwe1whyYZX0+gVFHcWseD7Eny7wbDBvHgXPXPV
 +3/IjU4YGo6i/S4o5mzQBPRdijP34GgNYRuTxfMysAJh6U0O66osoNF7VGFJt+INMY3k
 F8d71PxjYedjO67tJwXSF8J5Q0DfiA61vIPj6r6NDoZ3Ne3HDymb5HRsjFmKwmjf6EMv
 MhAIHZn4xmKlNFhQrbCdxoQHOd+PB2wpuGI8antb5EM3hBcTMqmSEGSOQXO4SXBoS+t5
 6Z59sbhMYUk5rX0IRglIIsnhXCrBJfSHMJ1CtQxTJhwpvNINlmWJzSnphBcc1MCdX22u Yw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3vphs7agry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 19:35:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 37D908005DA;
	Wed, 17 Jan 2024 19:35:02 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id A33308005FE;
	Wed, 17 Jan 2024 19:34:53 +0000 (UTC)
Date: Wed, 17 Jan 2024 13:34:51 -0600
From: Dimitri Sivanich <sivanich@hpe.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: DMAR interrupt reservations exceed available resources on 32s Intel
 SPR
Message-ID: <Zagr2/NXow4Ptv22@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: O8L5LhUTcRVdzynEi5H33LOHC3iCxqM7
X-Proofpoint-ORIG-GUID: O8L5LhUTcRVdzynEi5H33LOHC3iCxqM7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=877 bulkscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170142

We currently are running Sapphire Rapids systems with 32 sockets. We have
noticed that on systems of this size we see the following warnings:
    DMAR-IR: Enabled IRQ remapping in x2apic mode
    Interrupt reservation exceeds available resources
    DMAR: Can't request irq
    DMAR: DRHD 97bfc000: failed to enable fault, interrupt, ret -28

There are 10 DMAR units per socket on these systems, so 320 DMAR units.  It
appears that each is being allocated its own vector on the first cpu, as this
happens prior to other cpus being started.  At the time that the DMAR vector
allocations begin, cpu 0 has 186 vectors available (as does the global set),
and that is the number of DMAR fault interrupts that show up as allocated
(/proc/interrupts) after boot.

As a simple experiment, I patched the kernel to only allocate node 0 DMAR fault
interrupt vectors while only the boot cpu is running, then to allocate fault
interrupt vectors for the rest of the DMAR units as cpus on their respective
nodes are coming up.  With that change, all 320 interrupts were allocated, and
the interrupt affinity was set to the first cpu on each DMAR's respective node.

Does this seem like a sensible approach to fixing this, or is there another
avenue that we should be looking at?

For illustrative purposes, here's the patch for the experiment described above:

Index: linux/drivers/iommu/intel/dmar.c
===================================================================
--- linux.orig/drivers/iommu/intel/dmar.c
+++ linux/drivers/iommu/intel/dmar.c
@@ -2055,6 +2055,38 @@ int dmar_set_interrupt(struct intel_iomm
 	return ret;
 }
 
+int __init enable_remaining_drhd_fault_handling(int node)
+{
+        struct dmar_drhd_unit *drhd;
+        struct intel_iommu *iommu;
+
+        /*
+         * Enable fault control interrupt.
+         */
+        for_each_iommu(iommu, drhd) {
+                u32 fault_status;
+                int ret;
+                if (iommu->node != node)
+                        continue;
+                ret = dmar_set_interrupt(iommu);
+
+                if (ret) {
+                        pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
+                               (unsigned long long)drhd->reg_base_addr, ret);
+                        return -1;
+                }
+
+                /*
+                 * Clear any previous faults.
+                 */
+                dmar_fault(iommu->irq, iommu);
+                fault_status = readl(iommu->reg + DMAR_FSTS_REG);
+                writel(fault_status, iommu->reg + DMAR_FSTS_REG);
+        }
+
+        return 0;
+}
+
 int __init enable_drhd_fault_handling(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -2065,7 +2097,10 @@ int __init enable_drhd_fault_handling(vo
 	 */
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
+		int ret;
+		if (iommu->node != 0)
+			continue;
+		ret = dmar_set_interrupt(iommu);
 
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
Index: linux/arch/x86/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86/kernel/smpboot.c
+++ linux/arch/x86/kernel/smpboot.c
@@ -210,6 +210,7 @@ static void smp_callin(void)
 	cpumask_set_cpu(cpuid, cpu_callin_mask);
 }
 
+extern int __init enable_remaining_drhd_fault_handling(int cpu);
 static int cpu0_logical_apicid;
 static int enable_start_cpu0;
 /*
@@ -263,6 +264,7 @@ static void notrace start_secondary(void
 
 	x86_cpuinit.setup_percpu_clockev();
 
+	enable_remaining_drhd_fault_handling(cpu_to_node(smp_processor_id()));
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }

