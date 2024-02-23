Return-Path: <linux-kernel+bounces-78044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB5860E58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04040286C03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38C5CDD2;
	Fri, 23 Feb 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jOl95ikZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86F22EF5;
	Fri, 23 Feb 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681269; cv=none; b=sZxLp6HhH2HhIyoaVzLGe3rDQ7xbif1jLjoz+WorNuV7BeAU00Vx3/CEWKxL94vAZWFNv8/t65BfjXj+OhSyHOkxoQ5t9NxegZ/5G/ZNRmh5YMswFs8Puwee538b3T9JgpwBwew4dOghTz8LpJl/7OLWbsMU30OMRoz90YEt+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681269; c=relaxed/simple;
	bh=Y43HSQ9Wo88uXt3uxGimbfx8JjZTF/WiQipb+UBy0eo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXYlCiA1e6Y1Z+WRPbF6isNOuXkfnpU2QCe+7DwBr0kvjSycoMYO4iZ5g1yoDZDlRPiJziMPrYssio20A3t6Nd+x5Du2ElpQgdfXVPxHPUyoUHnH72hf+RQ+zkurhveX9IBZ6wNWI8Y2vG5qqT1+cMERhTyTtlH3uJZn7DEF6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jOl95ikZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8t1bH006239;
	Fri, 23 Feb 2024 09:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=ZEiMePE578rbncSKCGn9/0AKvjfDfwffZayqVnGyV9o=; b=jO
	l95ikZv5aPMV/HZtNStm2SHFR28H+EFQu++eS0GcUsKVYtuXlKXb3iaGEVb9222i
	IzYM+HYuNH/YdjKhNaeSNWMM5J4nfdXguHecR4Tk+JAsZySE6SiOwgWiDbpuW1i+
	LoR2AtV0LRw9esmW/aNyczFbW78g0Fss3PbytziRkKNzK0g8Gfy8W5HBlN4yj1qq
	tafPqFu2bMVRSd5d6jr0RomEbjvBK6UHcZjUgbdWaNyQIMjK4gRlLbg3LCtJ53+Y
	8o4WKsOxF3m59Jt4RWPIamKNAQ7qhh1tdmTGHxIs9zdddwVXB+o+s8aB5h8J+xRi
	PcO+ACQqq79T/oiXFmBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wer8mr2t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:40:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N9etiG022307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:40:55 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 01:40:52 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: <stable@vger.kernel.org>
CC: Charan Teja Kalla <quic_charante@quicinc.com>,
        Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, Nikhil V <quic_nprakash@quicinc.com>
Subject: [PATCH] iommu: Avoid races around default domain allocations
Date: Fri, 23 Feb 2024 15:10:23 +0530
Message-ID: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: juVgrq4OEirmf8B-ClsuUbDISik7YfOq
X-Proofpoint-ORIG-GUID: juVgrq4OEirmf8B-ClsuUbDISik7YfOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 mlxlogscore=996 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230067

From: Charan Teja Kalla <quic_charante@quicinc.com>

This fix is applicable for LTS kernel, 6.1.y. In latest kernels, this race
issue is fixed by the patch series [1] and [2]. The right thing to do here
would have been propagating these changes from latest kernel to the stable
branch, 6.1.y. However, these changes seems too intrusive to be picked for
stable branches. Hence, the fix proposed can be taken as an alternative
instead of backporting the patch series.
[1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
[2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/

Issue:
A race condition is observed when arm_smmu_device_probe and
modprobe of client devices happens in parallel. This results
in the allocation of a new default domain for the iommu group
even though it was previously allocated and the respective iova
domain(iovad) was initialized. However, for this newly allocated
default domain, iovad will not be initialized. As a result, for
devices requesting dma allocations, this uninitialized iovad will
be used, thereby causing NULL pointer dereference issue.

Flow:
- During arm_smmu_device_probe, bus_iommu_probe() will be called
as part of iommu_device_register(). This results in the device probe,
__iommu_probe_device().

- When the modprobe of the client device happens in parallel, it
sets up the DMA configuration for the device using of_dma_configure_id(),
which inturn calls iommu_probe_device(). Later, default domain is
allocated and attached using iommu_alloc_default_domain() and
__iommu_attach_device() respectively. It then ends up initializing a
mapping domain(IOVA domain) and rcaches for the device via
arch_setup_dma_ops()->iommu_setup_dma_ops().

- Now, in the bus_iommu_probe() path, it again tries to allocate
a default domain via probe_alloc_default_domain(). This results in
allocating a new default domain(along with IOVA domain) via
__iommu_domain_alloc(). However, this newly allocated IOVA domain
will not be initialized.

- Now, when the same client device tries dma allocations via
iommu_dma_alloc(), it ends up accessing the rcaches of the newly
allocated IOVA domain, which is not initialized. This results
into NULL pointer dereferencing.

Fix this issue by adding a check in probe_alloc_default_domain()
to see if the iommu_group already has a default domain allocated
and initialized.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b3897239477..83736824f17d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1741,6 +1741,9 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 {
 	struct __group_domain_type gtype;
 
+	if (group->default_domain)
+		return;
+
 	memset(&gtype, 0, sizeof(gtype));
 
 	/* Ask for default domain requirements of all devices in the group */
-- 
2.17.1


