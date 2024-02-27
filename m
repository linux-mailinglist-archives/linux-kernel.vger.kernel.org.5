Return-Path: <linux-kernel+bounces-83550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B535C869B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3161B2F302
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F03149DE6;
	Tue, 27 Feb 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnPC7Qmc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA57149000;
	Tue, 27 Feb 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049227; cv=none; b=rm7XwQTeiI72bnT9PSfO/RBJu7trW+UeBk12piJSym/CvlNYbLS8j/b/P2UhzG+tLG+9BDJCUuxFHM2/a11o9MnbfWYv2kIaYGV2ExS4n0MhkAig5tF6AvYIqKb2ajb/hWW4ktcSue9wbjl659LpsRbQRsm4Sqx6P78WV4FnL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049227; c=relaxed/simple;
	bh=TH+CWOIlbfz9/WAFIq4BowoDplJ8YIN+rxj14bUJarY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFjq1C5oBW2Rwl8mkfihLdUf7p4UNARmhy3htv6bDV25Ck76XbsUfvfY8Zs4EU3/Z7j0ncGN5wabz4kY8t5c2qo62RTOOEPGYlZl2GPgOBZYrvJqYyKaEcQOOk7fQd0Fyue2HEEKMkZmlQH6O4eW4IMdnxW9bAVpCVg2ijBnZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FnPC7Qmc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9rqVE030907;
	Tue, 27 Feb 2024 15:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=w8c41ad81/MRv0zfE48SHuFTPr0UWUHFxzg7N35gGnc=; b=Fn
	PC7QmcxKks7u/OlBJ8WldJIiM2QYVFfecpEEEdcInQiidTqRbKTSgKSADP55A1/Q
	b537NfwpX9XadD5Hzx6Td3Q0QFJqam2GwO4a27HKv8nf/VcMQG2LSOezalbXbczp
	wDOLUO751vPA+lRJSZcV3bHzWMfXMKy+1a+I8z9YQkKjfcPCH3fTgc3ovnbIQAlh
	8IofalxmzHqPn9HlMdu2yVE3g3Dp+9lq8XjjEc803qKsCGB5tgPU7woPOMj8KMAQ
	WcO+bBk8vBv8MZxR/oLSaMSpXV4UG6sbNdmlrMBfolDkPB3Vyg08cKFGtdOzqPZC
	izvbmjkULpKvJd50/QhA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t1hrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrec7032743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:40 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:38 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v12 4/9] firmware: qcom: scm: Rework dload mode availability check
Date: Tue, 27 Feb 2024 21:23:03 +0530
Message-ID: <20240227155308.18395-5-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240227155308.18395-1-quic_mojha@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _uvA-hwPGXA3AiF7huwTShQtsp5GOOGL
X-Proofpoint-GUID: _uvA-hwPGXA3AiF7huwTShQtsp5GOOGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270123

QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
target and firmware and for recent targets there is dload
mode tcsr registers available to set the download mode.

So, it is better to keep it as fallback check instead of
checking its availability and failing it always.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index bd6bfdf2d828..3fd89cddba3b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -540,18 +540,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 static void qcom_scm_set_download_mode(bool enable)
 {
 	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
-	bool avail;
 	int ret = 0;
 
-	avail = __qcom_scm_is_call_available(__scm->dev,
-					     QCOM_SCM_SVC_BOOT,
-					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
-	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
-	} else if (__scm->dload_mode_addr) {
+	if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
 				      QCOM_DLOAD_MASK,
 				      FIELD_PREP(QCOM_DLOAD_MASK, val));
+	} else if (__qcom_scm_is_call_available(__scm->dev,
+						QCOM_SCM_SVC_BOOT,
+						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
+		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.43.0.254.ga26002b62827


