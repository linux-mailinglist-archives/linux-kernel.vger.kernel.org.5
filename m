Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD608073F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379408AbjLFPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbjLFPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:46:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A874C9;
        Wed,  6 Dec 2023 07:46:32 -0800 (PST)
Date:   Wed, 06 Dec 2023 15:46:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701877590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJX0tYjAGn3fmFE3b1w7KCi39uVImecXHrOoY8+UCxM=;
        b=iyYKexP/+hGZ8oaSAqHfbblBJOlJ3tOp6QkFqwu/S7o0WmT8aMN+Ig9Qn4k+fG+L0dkYlE
        gu+j59DqBbZEQUUPW7iB2uM9IUiT4We/X4aKYMVp9eO7veFjvJbn6WfFvpByldJZ0F3g5f
        QLDGnq77vv1ZFyI4WL/VpHdM7RD4WU/+k4EWQkoE4bta3A+Ys3IJ8JDq3lg8qEyBbhIEd+
        Pm6xG+dleVWJwagmAEmElLbSA5wCA/rfTLEFzlJAIwEHdU7vPQ22vTZzbLXJXhwtkG5MMy
        u3hEOLv6GKKxDJv1G+e5Ef1Pp9D/iBt4AmAZyF7pPoTuNscveTokC9fNV/suyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701877590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJX0tYjAGn3fmFE3b1w7KCi39uVImecXHrOoY8+UCxM=;
        b=/A+ku8YxTnzHCtc/3htQm5bdFSmXaDn0U1sNWyoWW95PSPqEVOvQUCHKq22iN0XgwSWgBM
        nK9IqYLfAjawvNBg==
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove unused CPU hotplug states
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231124121615.1604-1-yuzenghui@huawei.com>
References: <20231124121615.1604-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <170187758879.398.12515486860339710758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     15bece7bec0df91a8ed1c185483d67708425ca8e
Gitweb:        https://git.kernel.org/tip/15bece7bec0df91a8ed1c185483d67708425ca8e
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Fri, 24 Nov 2023 20:16:15 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Dec 2023 16:31:03 +01:00

cpu/hotplug: Remove unused CPU hotplug states

There are unused hotplug states which either have never been used or the
removal of the usage did not remove the state constant.

Drop them to reduce the size of the cpuhp_hp_states array.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231124121615.1604-1-yuzenghui@huawei.com
---
 include/linux/cpuhotplug.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b..af6c21a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -66,15 +66,12 @@ enum cpuhp_state {
 	CPUHP_PERF_POWER,
 	CPUHP_PERF_SUPERH,
 	CPUHP_X86_HPET_DEAD,
-	CPUHP_X86_APB_DEAD,
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_IBMVNIC_DEAD,
 	CPUHP_SLUB_DEAD,
 	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
-	/* Must be after CPUHP_MM_VMSTAT_DEAD */
-	CPUHP_MM_DEMOTION_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
@@ -96,7 +93,6 @@ enum cpuhp_state {
 	CPUHP_NET_DEV_DEAD,
 	CPUHP_PCI_XGENE_DEAD,
 	CPUHP_IOMMU_IOVA_DEAD,
-	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
 	CPUHP_AP_DTPM_CPU_DEAD,
@@ -118,7 +114,6 @@ enum cpuhp_state {
 	CPUHP_XEN_EVTCHN_PREPARE,
 	CPUHP_ARM_SHMOBILE_SCU_PREPARE,
 	CPUHP_SH_SH3X_PREPARE,
-	CPUHP_NET_FLOW_PREPARE,
 	CPUHP_TOPOLOGY_PREPARE,
 	CPUHP_NET_IUCV_PREPARE,
 	CPUHP_ARM_BL_PREPARE,
@@ -151,18 +146,14 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-	CPUHP_AP_IRQ_RISCV_STARTING,
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
-	CPUHP_AP_PERF_X86_CQM_STARTING,
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
-	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
@@ -179,7 +170,6 @@ enum cpuhp_state {
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_TEGRA_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
-	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
@@ -217,9 +207,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
 	CPUHP_AP_PERF_X86_RAPL_ONLINE,
-	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
-	CPUHP_AP_PERF_X86_IDXD_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
@@ -252,8 +240,6 @@ enum cpuhp_state {
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
-	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
-	CPUHP_AP_MM_DEMOTION_ONLINE,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
 	CPUHP_AP_ACTIVE,
