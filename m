Return-Path: <linux-kernel+bounces-10910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9281DEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E2E1C210C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB14CA7A;
	Mon, 25 Dec 2023 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HBzubLw7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73176FCC;
	Mon, 25 Dec 2023 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP6lSeX015547;
	Mon, 25 Dec 2023 06:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=IKLgXNv991Vf
	x+bNTtQtVZrVZWVJB4T23nFUdmom0Ec=; b=HBzubLw7S/f+Td8v4HraRpNeBNoU
	Am6TCx5//mCsaYT74vQNX/OjnG9ygwKXO818rXKad8ykOI9V7uacp2/kTN+zQZuW
	wUDw4Xbx2fDc/ERWFcmc/oKz/qYCyAk6UTqiltaPn1AazXGc+Bk9vE39RmB8F+FB
	QowxOBe4oJ1vjBY/THB3Dvzyge+pj2gUE5lkFhuYC3bjYPIsMvSde7i6UZD6AOfZ
	Xgofwil9jm16LatCOmoqwoAjWFQxNmkd71K7ee03WF41k7yAAaS6bS6NllvBjWaU
	HjGTUpam/b+XvAB0Rko/Dt5yQJoc5vPRETP6lHvQNzVS7uU22ym0gBdbfg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5rqrb0tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 06:47:27 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BP6lPcR019278;
	Mon, 25 Dec 2023 06:47:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3v5rmktkam-1;
	Mon, 25 Dec 2023 06:47:25 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BP6lOxf019270;
	Mon, 25 Dec 2023 06:47:25 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3BP6lOd7019268;
	Mon, 25 Dec 2023 06:47:24 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
	id 9D10620A8A; Sun, 24 Dec 2023 22:47:24 -0800 (PST)
From: Can Guo <quic_cang@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        vkoul@kernel.org, abel.vesa@linaro.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org
Cc: linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 RESEND 0/2] Enable HS-G5 support on SM8550
Date: Sun, 24 Dec 2023 22:47:20 -0800
Message-Id: <1703486842-36621-1-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2zPRn2rpvUKrjsPwtNturvM0F8aOjoHx
X-Proofpoint-ORIG-GUID: 2zPRn2rpvUKrjsPwtNturvM0F8aOjoHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250049
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series enables HS-G5 support on SM8550.

Please note that the changes to drivers/ufs/ have been picked up, resending this
series for the remaining two changes to UFS PHY.

This series is rebased on below changes from Mani -
https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/

This series is tested on below HW combinations -
SM8550 MTP + UFS4.0
SM8550 QRD + UFS3.1
SM8450 MTP + UFS3.1 (for regression test)
SM8350 MTP + UFS3.1 (for regression test)

Note that during reboot test on above platforms, I occasinally hit PA (PHY)
error during the 2nd init, this is not related with this series. A fix for
this is mentioned in below patchwork -

https://patchwork.kernel.org/project/linux-scsi/patch/1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com/

Also note that on platforms, which have two sets of UFS PHY settings are
provided (say G4 and no-G4, G5 and no-G5). The two sets of PHY settings are
basically programming different values to different registers, mixing the
two sets and/or overwriting one set with another set is definitely not
blessed by UFS PHY designers. For SM8550, this series will make sure we
honor the rule. However, for old targets Mani and I will fix them in
another series in future.

v8 -> v9:
Rebased two changes to UFS PHY to the phy/next tree

v7 -> v8:
In "scsi: ufs: ufs-qcom: Add support for UFS device version detection", fixed a BUG introduced from v6 -> v7. The spare register is added since HW ver 5, although reading the spare register on HW ver 4 is just getting 0x0, to be on the safe side, we are exluding HW ver 4.

v6 -> v7:
1. Rebased on linux-next, based SM8650 PHY settings are merged there, no changes to patches for UFS driver
2. Addressed comments from Mani

v5 -> v6:
1. Rebased on scsi-queue-6.8
2. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c

v4 -> v5:
Removed two useless debug prints in patch #9

v3 -> v4:
Used .tbls_hs_overlay array instead of adding more tables with different names like .tbls_hs_g5

v2 -> v3:
1. Addressed comments from Andrew, Mani and Bart in patch #1
2. Added patch #2 as per request from Andrew and Mani
3. Added patch #4 to fix a common issue on old targets, it is not necessary
   for this series, but put in this series only because it would be easier
   to maintain and no need to rebase
4. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c

v1 -> v2:
1. Removed 2 changes which were exposing power info in sysfs
2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
3. Added one new change (the 1st one) to clean up usage of ufs_dev_params based on comments from Mani
4. Adjusted the logic of UFS device version detection according to comments from Mani:
	4.1 For HW version < 0x5, go through dual init
 	4.2 For HW version >= 0x5
		a. If UFS device version is populated, one init is required
		b. If UFS device version is not populated, go through dual init

Can Guo (2):
  phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
  phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
    SM8550

 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 ++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 186 ++++++++++++++++++---
 4 files changed, 175 insertions(+), 27 deletions(-)

-- 
2.7.4


