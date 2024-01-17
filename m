Return-Path: <linux-kernel+bounces-29361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101C830D42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F7E1C21DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A6249F1;
	Wed, 17 Jan 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTp+AzDc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33988249E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519417; cv=none; b=OZyzhav1L6nA757ub2us5CFQbLSpkXcn0BVokprKHrE+0yp7+5Rt/Tm7F40WHUu2AZJa2sfsnpFCpg8L9QnrY9DOC9aULO6/+Hb0tqtBaezyp/t6jO5hZ5oZo31pnkhrRaSH+q00M+8T2IcDWorpVQKSVk1LFSrWPzd0muIvjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519417; c=relaxed/simple;
	bh=0fv+js9Ew/OTGfUYa+DH+CiU24lWx9f36G6rrkUfZ3Y=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID; b=Kwqehen5eDSG8wScZMkGPmxs0vH3v7wEJTd62gvIkXQVITD9EkqwF4hUgY+VZiSgtQUgsSC8mlN54nGdPhn3kGhdbGYpK88akRr8Ch1EcGSjEk0Z1E6QODXoIykMbfkHZGREckIUvO4me+Ds/v8Ry91YW7XU6sHjhNlhNgxKHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTp+AzDc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HFxD5c029237;
	Wed, 17 Jan 2024 19:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=1F1h/D8LY/Y+1NEma8ji2AuKUSI4RrgJpl+4EbcQmBw=;
 b=MTp+AzDcOvpBseUjiPQLpAM3Y0Lk3pa7KbOQbFBlajVh/L4hOW3O7lq7tH8m/zBdP3l6
 HK11YX8rFt0HzJob5wCtDYEq0LdP+5Ei/tiXvgwMkTdQ3kn0hQkRfNJKgFdzX1LBd444
 KJBUXGfPccv6AVJ0FlgPdPS9L2EK+SABDo9UZ1boe0Sxyd2zFO+Jfwa37ew6VTFmwZd5
 nq8YYi9XrwgDFYlBaGmeVQijLR2Leu+Jr40Ee9GWAKZoPMS06f4Yvov7+pWdTO5ZOtCO
 oe31viNVnAeu/o2GEszuQWSVj+5Mh82OTZi09okViyykp+iXReF9YzvGRbX81kBPBm6m zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3gtfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:23:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HIPjZW020404;
	Wed, 17 Jan 2024 19:23:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyaxk7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:23:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HJNPUk009185;
	Wed, 17 Jan 2024 19:23:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyaxk4u-1;
	Wed, 17 Jan 2024 19:23:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1] vdpa_sim: reset must not run
Date: Wed, 17 Jan 2024 11:23:23 -0800
Message-Id: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170141
X-Proofpoint-GUID: IotjSuzEKsbpCZn2C3_nMGOXBDpen5g5
X-Proofpoint-ORIG-GUID: IotjSuzEKsbpCZn2C3_nMGOXBDpen5g5

vdpasim_do_reset sets running to true, which is wrong, as it allows
vdpasim_kick_vq to post work requests before the device has been
configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
is set.

Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..6304cb0b4770 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 		}
 	}
 
-	vdpasim->running = true;
+	vdpasim->running = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
+	vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
 	mutex_unlock(&vdpasim->mutex);
 }
 
-- 
2.39.3


