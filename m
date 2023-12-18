Return-Path: <linux-kernel+bounces-3940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC6817553
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A3B22556
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1F3A1D9;
	Mon, 18 Dec 2023 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQ24PMGu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D293D54D;
	Mon, 18 Dec 2023 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsWg9018798;
	Mon, 18 Dec 2023 15:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=Ow5SPTTNB88V
	cAirt4L0hAseb2z31VaLkP7mDGOMQDA=; b=iQ24PMGu8XqJCIvZjt2R/W/gBFtI
	wsvbFvOzqZvsRYEaqykLSNPv17pH72X1hRHJjbv2zAIvMwtNHqMc0TWcbjBJZzix
	4AiFwvbfRC9Mc8tpVsTJCcpMD1pDLXbfay7hUK3uKCiBY5AX/y0FVc6SGtQ2aiYz
	pd0qtHJmfvc27Uwz5ZVh1/w3m2ZpQIEMs0LXlXU99SLonXxlVufA8bbTS9K/dqOP
	xaWP/BsVWRKYsQYkz928wfO9ftfNOg8jsv+b37tPMiFyYlH9z6CaQ5LMWvYOC7EV
	BG9Ufw+PhTMarXdqfy5lJQ3DEMJ9Gv3uqH2hkKQT0Gqhqvj+e8vQRCWrUQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mfe0n99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 15:33:53 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIFWXT3029489;
	Mon, 18 Dec 2023 15:33:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3v14ykw605-1;
	Mon, 18 Dec 2023 15:33:52 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIFXqos031583;
	Mon, 18 Dec 2023 15:33:52 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3BIFXpFx031579;
	Mon, 18 Dec 2023 15:33:52 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
	id AE92E20A6B; Mon, 18 Dec 2023 07:33:51 -0800 (PST)
From: Can Guo <quic_cang@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: core: Let the sq_lock protect sq_tail_slot access
Date: Mon, 18 Dec 2023 07:32:17 -0800
Message-Id: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2x7iaMGGHfK-tl-wx8Yqxco24rlFPNO4
X-Proofpoint-GUID: 2x7iaMGGHfK-tl-wx8Yqxco24rlFPNO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180114
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If access sq_tail_slot without the protection from the sq_lock, race
condition can have multiple SQEs copied to duplicate SQE slot(s), which can
lead to multiple incredible stability issues. Fix it by moving the *dest
initialization, in ufshcd_send_command(), back under protection from the
sq_lock.

Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")
Signed-off-by: Can Guo <quic_cang@quicinc.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae9936f..2994aac 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2274,9 +2274,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 	if (is_mcq_enabled(hba)) {
 		int utrd_size = sizeof(struct utp_transfer_req_desc);
 		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
-		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
+		struct utp_transfer_req_desc *dest;
 
 		spin_lock(&hwq->sq_lock);
+		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
 		memcpy(dest, src, utrd_size);
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
-- 
2.7.4


