Return-Path: <linux-kernel+bounces-90487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596E86FFFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAB2819E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC43839A;
	Mon,  4 Mar 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NXenhUgW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98B46AD;
	Mon,  4 Mar 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550703; cv=none; b=rLWkQUI80yxuJKsEiqd4DeCKWgOqwAl8zGTtym++ttr6Ce7lILK48zGSyuwOx+bO1v/z12TrlkBIauRavK4YYT/LXvt9dR2x5QOGW0IKKcoVZLM2zLXfr0equ3hAgBSdFEWniy5qGou1Og2+DW8Kq6bi7qhpWSxb8wIVm2bwP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550703; c=relaxed/simple;
	bh=xVSkuAeo4D9ZElgt/IODeSW5ZINrq3fTsbkPSDyPGmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yb+OvbtWbJRcZ3Nf41HH5F7ii6SAnMexh8NfzBLBPAeta6Yh7RgaAocgSipaLum9H+7tNjhRw14W70bYvX4Q8S+NkSSclMu/zV4tLvMIdZTs7wLu+QR0UP/JkT05F6emSxNZbdCarr1xpUMBSOLQ0RA87etTa2BlyM+Fl5KelW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NXenhUgW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424AsnYr019049;
	Mon, 4 Mar 2024 11:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=250lxiVyVhWgGkynbsvy556K2WPzHaat5nPoNu3o7uI=; b=NX
	enhUgWz8BXddC9wB3akbZsUu/sCKYGBo4ZvPuYtT2dgnp+RKp7J3YCgArmuBpMyN
	FlqDYq8+U5O641XmzJZ9pXrrsHgL8SpYnAgzWYNxTK2k1RmJJUKHMA+wsh5nwDsy
	U9CFeB2UTAjzhyfJVs1DJ0EcfNLn074DFeKTyCLRUMGAb8Iyu5EM2DS9moZlpyeg
	nKnkn/Nfvxwau4DGVBinA4WtVqjTeXdshYl3AP3QOmrFuYCHtpiNDTGeBbZnqBeP
	wrwhRRrV8H8ZItyy/nyDHhqkZ9GDkBOk7QycbceyaJHcgyczqf2UsYbFtT6xp89u
	swbxvW+3vTgZm7Pd0U2Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkvb739ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:11:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424BBUT4007051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 11:11:30 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 03:11:27 -0800
From: Nikhil V <quic_nprakash@quicinc.com>
To: 
CC: Charan Teja Kalla <quic_charante@quicinc.com>,
        Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, Nikhil V <quic_nprakash@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH RESEND STABLE v6.1] iommu: Avoid races around default domain allocations
Date: Mon, 4 Mar 2024 16:40:50 +0530
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
X-Proofpoint-GUID: yz3Nelq0fOTemW5jQPryH1pxnJWCrhqt
X-Proofpoint-ORIG-GUID: yz3Nelq0fOTemW5jQPryH1pxnJWCrhqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040084

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

Cc: <stable@vger.kernel.org> # see patch description, fix applicable only for 6.1.y
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


