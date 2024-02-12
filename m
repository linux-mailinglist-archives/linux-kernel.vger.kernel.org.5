Return-Path: <linux-kernel+bounces-62077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4E851B19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F61F28E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2B3F9CE;
	Mon, 12 Feb 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xd6FE4uF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF83F8E0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758192; cv=none; b=Jhd8eiklqoXMacNH0nYSnGn1iksOoxNaensG/BxCwaeY25rAgJw25zO567atXoYfrSz0A3q4H2OAbhOEZKofR1scJmhQWc7odt5UAvZvCLPZcJbXywaWUbW4S/bs3vTMiFfPFLH7BTzrhVhwyoSXKU68Jw1NPFLcypE79/mT++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758192; c=relaxed/simple;
	bh=6v1DdYDJd/9HrTqqMe/Lpv3ivtOuBC3ajeN4UvB9vfY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oWd2cww6nQhfI/qwUiJnCxa202NKj9OnXL2cQ6eHeCTpzx/a73y7HJECZH/UHFE/RdGnXQ5RaxvkIBKHCuva2n1G8ourjrGsDkYOiKLImwU6DyhIXrCBmYvnSWCX42gsKhuqVljGzdJ/J1Eo95EQWkzVhoM6uAvjI+jy6j8i8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xd6FE4uF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CFUUeM023329;
	Mon, 12 Feb 2024 17:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=5BMQBc54Nw0OsPDx56wkKy9H9W0WUx+kCq5xigT5rxU=;
 b=Xd6FE4uF04HkzBCC4NyJLesXb4FPcyBSLjtGv1foCjkmxMX0ZOcOs99M+iqJDQnN3CL1
 qZKIWsmV5HWK+gXt9j7DCv2b/xvoevjg9s+/wYbjR6rXr3MRRhieTAGwodNif+xruyR/
 pNv+XNMLwnkhx2QfNBzuDS9+j/tf6PNq7xbkTQtCtF4cD5Fwbl+UDqtiIRpkjEwCF4v6
 lEgtKm/CEIe6GoYeLcDbC/vLpEi1Yn1wGO/xZuvIG1brLOjQBvpHlia53uxalG8FLOqd
 hZ7shWB+Bdf1Wc8wlyVprv8cvJZz2svuQxniBNxuEkg09ntzrOaOs1PXMdygE2xuOasL eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7p1h0art-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGjS8S031535;
	Mon, 12 Feb 2024 17:16:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk620dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGFC8019216;
	Mon, 12 Feb 2024 17:16:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk620cq-1;
	Mon, 12 Feb 2024 17:16:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/3] flush workers on suspend
Date: Mon, 12 Feb 2024 09:16:11 -0800
Message-Id: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=646 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120131
X-Proofpoint-GUID: X4LGCSodfvHsxk2D8W-gCm6OREZ7EbHJ
X-Proofpoint-ORIG-GUID: X4LGCSodfvHsxk2D8W-gCm6OREZ7EbHJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Flush to guarantee no workers are running when suspend returns,
for vdpa, vpa_sim, and vduse.  (mlx5 already does so, via the path
mlx5_vdpa_suspend -> unregister_link_notifier -> flush_workqueue.)

Steve Sistare (3):
  vhost-vdpa: flush workers on suspend
  vduse: suspend
  vdpa_sim: flush workers on suspend

 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 13 +++++++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vdpa.c               |  3 +++
 3 files changed, 40 insertions(+)

-- 
2.39.3


