Return-Path: <linux-kernel+bounces-62078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52A851B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B347B263AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D583F9D3;
	Mon, 12 Feb 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xj3o1k5l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17953F8E6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758192; cv=none; b=Kxn0wpaXsoEd7MT/o5vemINW60pp9flJ/M5dZ8YR3I05DWKgUripF3rVFbSeP0hMUruM0JC68Xam9SZZLg7hLeX3yeddcWbgcBD8+JQOG3YK+iWHYZ/wsME0lZaNS9RhTEchB0/ZtP2iz0UNu6uO3s6UNpTrj+j8IjYqA14ZHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758192; c=relaxed/simple;
	bh=lKOoSfquQ5BHu7gGPJmq/4K7O6V6JxFx1vc1Dz1AbPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UaUkzWMyKC3y48PHD4im9Ae7VNGSRj+L6UnyaMhEFFX+3KfPGFdw1Co2FUGq1PHW/3ZcVOJxVfQMxupTBOF3s8uOMTC2lDFQifP+GUXXKNaDQaiw3+ftJ2Y/BYuHFlkXnEdsi9GO6MK+MoIIO3yi6iEADZBm9NRHXyWTqGUUuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xj3o1k5l; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGfroU006118;
	Mon, 12 Feb 2024 17:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=z8GvELFSi4mPAmel/pOmBem7/ZTWt0q7f0l9+QlF1TI=;
 b=Xj3o1k5lw0ACxxscwFQ9znTd2gThmj55+a0xwMZlA7s8ugCvocYX/9WjaJYwqwabFgOv
 W9BPy32rEvJKloMMQMYt7fZUaqXJXncVmyr/BvmeIiUc1KymdN7EPT7UoTp6tt4abKPn
 j56T97bqP7viDDHa2cVPDi2J0EtsmM6XBeQBU7jp17uSPfQRCnpSQk8ZxuSHANmeXEcl
 joFeooAj/ndpLWL6R+tMBJSUFMr6B2xYGTSw6SbiOfwePmxNdQB0Tsj93sZXtVOyqrq/
 2aRm+35EgXvNfsQCwr+5uX/9ZyQy3EhsY8pMV0UjyPWRdliep2hf3DdAZu1lI90s7HGw GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7q2y030b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGaHwX031332;
	Mon, 12 Feb 2024 17:16:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk620ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGFCA019216;
	Mon, 12 Feb 2024 17:16:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk620cq-2;
	Mon, 12 Feb 2024 17:16:17 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/3] vhost-vdpa: flush workers on suspend
Date: Mon, 12 Feb 2024 09:16:12 -0800
Message-Id: <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120131
X-Proofpoint-ORIG-GUID: c--00v5-y9I_0B3lmrLq1lXsXSRP_zgm
X-Proofpoint-GUID: c--00v5-y9I_0B3lmrLq1lXsXSRP_zgm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Flush to guarantee no workers are running when suspend returns.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..a3b986c24805 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -594,10 +594,13 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	int ret;
+	struct vhost_dev *vdev = &v->vdev;
 
 	if (!ops->suspend)
 		return -EOPNOTSUPP;
 
+	vhost_dev_flush(vdev);
+
 	ret = ops->suspend(vdpa);
 	if (!ret)
 		v->suspended = true;
-- 
2.39.3


