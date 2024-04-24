Return-Path: <linux-kernel+bounces-156205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDF8AFF77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAEB22321
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCEF13340B;
	Wed, 24 Apr 2024 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q53fMSz/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FD947E;
	Wed, 24 Apr 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928927; cv=none; b=h9JbQHA4cDsMkLyfrR961YgxOggcMH+MCwPDXjSMxYsZ2w5cZBLk8gslBjKGytoOVm7Eca/h2ToB4ivqQnYDRPgAsGuwZxd/WxqkrCC+K/XRtK//a4yGfWSa2yLwkVKxoB2CXnkuTekF21xDq6BUuOWJzvd4bNy9AMfQhKBDCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928927; c=relaxed/simple;
	bh=R1mueC9SUcpU6A8TYOzL4KkjjbUjUGBMieumGsYzqD8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=G+rhlDf4JQ5NkqXBXW74RaNsvWDrump4V1QMhbYa76V/Uy9z858tfJoCGpRDeN0fpQ6eabdOYjpLZ56YjG6ICLuYD78EqCAHUnlWxDynxt0exQFP5SPAcbN29eNZ1Dn02pa78Doe9eCXWL7OZmW2PgeIsU4JpzNk4Krhm+87PV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q53fMSz/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O32IjH002198;
	Wed, 24 Apr 2024 03:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=MuZUX7Ht1E8K
	IROZNKFvqsRnZXOXGpGWf3Y/osE8/uQ=; b=Q53fMSz/qaQkzWwwamfM/1Ak/MWy
	S75tvwD/txYX8fg5vLoicEyyic39f6oEtFinOESmS6lcqD3zPAD1qpM+cdfCIG/W
	dH1ueX9y5fyzWHd9WVUVeP8j5LyaL5/fE0d82jd5UY+J4fJr1F3txdjy+/xIo2Uw
	aNYX0xsI/jkn8DrDuUMFNgbp/o+tDAw7yS2Yrlc7F2Qpb3W9Ao6kwaf0vzI8PA3g
	afyid6mo2+Sy/OeOHwyELNDVPQHmSW3OyjHq3VKTyYRXlC3F+0ygl9d755sM+up3
	fQVJaYW/IZR7sEucScq/1TQHpDAZQgeBN1gOAEdlolZshxvMz1n/70nj1A==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpapmjrcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 03:22:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O3M08G024079;
	Wed, 24 Apr 2024 03:22:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xm6skh29k-1;
	Wed, 24 Apr 2024 03:22:00 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O3M0xL024074;
	Wed, 24 Apr 2024 03:22:00 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43O3M0AR024072;
	Wed, 24 Apr 2024 03:22:00 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 8113A5B1C; Wed, 24 Apr 2024 11:21:59 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 0/3] Add sysfs entry to EDL mode
Date: Wed, 24 Apr 2024 11:21:52 +0800
Message-Id: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OPDHaBT4SW0C-ko7R442X_ztgV4OIU_D
X-Proofpoint-GUID: OPDHaBT4SW0C-ko7R442X_ztgV4OIU_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=762 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240014
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add EDL sysfs entry for mhi controller that provides edl_trigger callback.
Add mhi_pci_generic_edl_trigger for qualcomm sdx55,sdx65 and sdx75 as
edl_trigger callback.

v4->v5:
1. Add a blank line before the #endif in patch[2/3].

2. Add reviewed-by tag.

v3->v4:
1. Modify some comments, commit message and sysfs entry description.

2. Add error cleanups if get channel doorbell offset fail.

3. s/force_edl/trigger_edl

4. s/mhi_get_channel_doorbell/mhi_get_channel_doorbell_offset

5. Use mhi_get_channel_doorbell_offset in mhi_init_mmio()

v2->v3:
1. Update Documentation/ABI/stable/sysfs-bus-mhi with description of
   force_edl sysfs entry.

2. Add comments about edl_trigger callback in mhi_controller struct.

3. Follow reverse christmas tree in mhi_pci_generic_edl_trigger.

4. Add a new API in MHI to allow controller to get CHDB address and avoid
   duplicating the definition of CHDBOFF.

v1->v2:
1. Move all process needed by qualcomm sdx55,sdx65,sdx75 to enter EDL into
   mhi_pci_generic_edl_trigger() as the callback to edl_trigger.

2. MHI stack creates EDL sysfs entry to invoke edl_trigger callback so
   that devices need different mechanism to enter EDL can provide its own
   edl_trigger callabck.

Qiang Yu (3):
  bus: mhi: host: Add sysfs entry to force device to enter EDL
  bus: mhi: host: Add a new API for getting channel doorbell address
  bus: mhi: host: pci_generic: Add edl callback to enter EDL

 Documentation/ABI/stable/sysfs-bus-mhi | 13 ++++++++++
 drivers/bus/mhi/host/init.c            | 39 ++++++++++++++++++++++++++---
 drivers/bus/mhi/host/main.c            | 16 ++++++++++++
 drivers/bus/mhi/host/pci_generic.c     | 45 ++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                    |  9 +++++++
 5 files changed, 118 insertions(+), 4 deletions(-)

-- 
2.7.4


