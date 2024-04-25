Return-Path: <linux-kernel+bounces-158729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECE8B243F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A424F285C19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334514A4EA;
	Thu, 25 Apr 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h1I2HmzP"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFED1494BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056162; cv=none; b=Nu2NdJEuKOXpZPNPY8ShZ8ueFBlgWhFjVqjPViRLV0ObIbtqfAmS2TwhYc/n0GeFQhcrHU6nXCoIJxNLTrLdZFdTyjTTyLrB1RDzJyjDRReTibR/QDwGLLmgA3trC9Nt7veZrovibyWtB5YH0F0gVDCsFXhpx30ByboeuajgWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056162; c=relaxed/simple;
	bh=1Q39ooJCtCdZ42SEdijjI3QfTDUMYcoSf0TS9OtWyMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4U/9z0nr3HiAGN5w+mVD46lpQ/OneZPdJPOdnthNmJhZGZwtbxv6Fqf8ThotehnANjsyFwFkMyLM1BkZJOko0FVv4OKgdTMYovZlsNmNpDrmYQZo/sdyiBaUSFEBCAmIzuqCOlppW7l5A1a/h+JnZByryhr+AfRDZO2HQtizcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=h1I2HmzP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P87NXd011560;
	Thu, 25 Apr 2024 07:42:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=YypH+pGp
	IYpH7WBXp4Imc9+sq/Tm4UKy97IIMOK/RmE=; b=h1I2HmzPehkCQA8VqgZ2uRpM
	CNdbcdzsWEscAb6q/QQG+uemI3EWCJubtfmLGWEHAhmWw6L8gBPWuSo/pvnLeaky
	boeFe7mYAikMbpV0T+exSJ4AtVJDDLRmKViaqN48Ilh+v82zS9q0nzMzeRtwh4n7
	4Iu7RKQQ9UtevKSG9pCL+0Vlio6DO+z28bDu4nou8t3u0HwL4YWTikf2Tv1OsaGD
	PCjuu9vGjIK3YiTQS4fyZXsfAoe+v9zXFhKwc+JbYLyc5ciL9jEhf+outlA21jn4
	0mvgghEzS0/ko8IaJbHgpF+GNllcv24RkGiu53vz1UKsii0seDMen/6an9lWhQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1gh38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 07:42:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 07:42:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Apr 2024 07:42:07 -0700
Received: from cn10ka.sclab.marvell.com (unknown [10.106.49.40])
	by maili.marvell.com (Postfix) with ESMTP id 5A78E3F705F;
	Thu, 25 Apr 2024 07:42:07 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <nicolinc@nvidia.com>, <mshavit@google.com>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <set_pte_at@outlook.com>, <smostafa@google.com>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>, <jcm@jonmasters.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register mode 
Date: Thu, 25 Apr 2024 07:41:50 -0700
Message-ID: <20240425144152.52352-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QhpJ5mRwvPbdKsHu3Utpc3UIhtEWJvg4
X-Proofpoint-ORIG-GUID: QhpJ5mRwvPbdKsHu3Utpc3UIhtEWJvg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02

Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
support for SMMU ECMDQ feature.

Tested this feature on a Marvell SoC by implementing a smmu-test driver.
This test driver spawns a thread per CPU and each thread keeps sending
map, table-walk and unmap requests for a fixed duration.

Using this test driver, we compared ECMDQ vs SMMU with software batching
support and saw ~5% improvement with ECMDQ. Performance numbers are
mentioned below:

                   Total Requests  Average Requests  Difference
                                      Per CPU         wrt ECMDQ
-----------------------------------------------------------------
ECMDQ                 239286381       2991079
CMDQ Batch Size 1     228232187       2852902         -4.62%
CMDQ Batch Size 32    233465784       2918322         -2.43%
CMDQ Batch Size 64    231679588       2895994         -3.18%
CMDQ Batch Size 128   233189030       2914862         -2.55%
CMDQ Batch Size 256   230965773       2887072         -3.48%


v2 --> v3:
1. Rebased on linux 6.9-rc5

v1 --> v2:
1. Drop patch "iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for
non-shared ECMDQ" in v1
2. Drop patch "iommu/arm-smmu-v3: Add support for less than one ECMDQ
per core" in v1
3. Replace rwlock with IPI to support lockless protection against the
write operation to bit
   'ERRACK' during error handling and the read operation to bit 'ERRACK'
during command insertion. 
4. Standardize variable names.
-	struct arm_smmu_ecmdq *__percpu	*ecmdq;
+	struct arm_smmu_ecmdq *__percpu	*ecmdqs;

5. Add member 'iobase' to struct arm_smmu_device to record the start
physical
   address of the SMMU, to replace translation operation
(vmalloc_to_pfn(smmu->base) << PAGE_SHIFT)
+	phys_addr_t			iobase;
-	smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);

6. Cancel below union. Whether ECMDQ is enabled is determined only based
on 'ecmdq_enabled'.
-	union {
-		u32			nr_ecmdq;
-		u32			ecmdq_enabled;
-	};
+	u32				nr_ecmdq;
+	bool				ecmdq_enabled;

7. Eliminate some sparse check warnings. For example.
-	struct arm_smmu_ecmdq *ecmdq;
+	struct arm_smmu_ecmdq __percpu *ecmdq;


Zhen Lei (2):
  iommu/arm-smmu-v3: Add support for ECMDQ register mode
  iommu/arm-smmu-v3: Ensure that a set of associated commands are
    inserted in the same ECMDQ

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 261 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 +++
 2 files changed, 286 insertions(+), 8 deletions(-)

-- 
2.34.1


