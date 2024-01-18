Return-Path: <linux-kernel+bounces-30000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC72831682
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72511F2391C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA282033F;
	Thu, 18 Jan 2024 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mfdyn01O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B4200A7;
	Thu, 18 Jan 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572787; cv=none; b=IBF0EpSN15E5qDOG8FUtO6zQT0Dw0IU/etryDG5UT2vfwdmvxUod4O1u/YgRhM4XmFPLuJOXlcQmNktxszJPdpWAgJ54u9e4bH7WekJuoNzfWr5ZQWFCr3m3WO5ES4ot/fB2ogHKx31J69FAsxATpynJqyCpryXSTG3vp3CiPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572787; c=relaxed/simple;
	bh=aR9iggWrqegK4iK+CU/EgaaD7QBYJOxWwW7c454H4b4=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=k1+/k2pR9bEaKUj2Dfdy9kTSfkwLP5c6zzpxTXClv9HXifIs/jacBBtznevGhuN9j+FGMN3CU337SKFM10fMsLetgXluBCYDVDESElSthkGMpduSIif1VHpuQH3sZICUoFXv1F66BLNzRKeHcX3fYXNrYENhrXTc3XC9REjqTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mfdyn01O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I61KGb010626;
	Thu, 18 Jan 2024 10:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=RuaFKQb1UAAXKpqx9oDws1B14UeArsMm4KTygjOf4Gg=; b=mf
	dyn01OLfAhgoQshgbB9w9mY6oU7ci9p0M1pzSo6mDHE2VeDmAby/s1rKH31hnaa6
	Mk0rUH8m66uaXIXatgaSHPTWGjxCbOvT+7wr53JxJwky1Tx8+TGOiIq/5CVQUup3
	28BGt6u/GyCZAwrrV56mmGT3CmFFhfv4WPlA48R9Ue/G6QGJflE4NvngeXuN/Lb/
	p5FdLzvhtqWYj2kcYJggH1zniqWTbupiGFxZjbM6z0l3HYsRluDPWFjowPTgTcGZ
	f6VAsiQP+1uzOGWNsqL1p7KSesqGe1zzz+7d/nmA3jH7WfhnrI86KOu+EEYnjAwq
	mrWu5yEjx58j1ISTz8cw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpxasrhtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 10:12:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IACVkv014865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 10:12:31 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 02:12:28 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>
CC: Charan Teja Kalla <quic_charante@quicinc.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Nikhil V <quic_nprakash@quicinc.com>
Subject: [PATCH 1/1] iommu: Avoid races around default domain allocations
Date: Thu, 18 Jan 2024 15:41:58 +0530
Message-ID: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
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
X-Proofpoint-GUID: 9zH25RLWqBLmbNGxiVTIbWaAvx_DHwRR
X-Proofpoint-ORIG-GUID: 9zH25RLWqBLmbNGxiVTIbWaAvx_DHwRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180074

From: Charan Teja Kalla <quic_charante@quicinc.com>

This fix is applicable for 6.1 kernel. In latest kernels, this race
issue is fixed by the patch series [1] and [2]. This fix can be taken
as alternative instead of backporting the series of patches as these
seems too intrusive to be picked for stable branches.
[1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
[2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/

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

Fix this issue by adding a check in iommu_group_alloc_default_domain()
to see if the iommu_group already has a default domain allocated
and initialized.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b3897239477..99f8cd5af497 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1594,6 +1594,9 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 {
 	struct iommu_domain *dom;
 
+	if (group->default_domain)
+		return 0;
+
 	dom = __iommu_domain_alloc(bus, type);
 	if (!dom && type != IOMMU_DOMAIN_DMA) {
 		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
-- 
2.17.1


