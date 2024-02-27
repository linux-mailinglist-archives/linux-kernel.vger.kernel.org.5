Return-Path: <linux-kernel+bounces-83547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D1869B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4528A289D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5849146908;
	Tue, 27 Feb 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NpZBAkLR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE291474B0;
	Tue, 27 Feb 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049217; cv=none; b=NbYEMzAZKdHhuHKFpwTGudBDl6xYmWfN/6vs8AfD20ZqE9gPtFTHTBmHSz3SiD2N2RtXQ+gOAHdmfYwKErIJu5YbhTZdd/4yMxAY+tzwlCoQxke+IqyFHIWn7V4qFSCT8an+y8HIFBn3iWa9l+2uy6q9tvMYZdFxVwvTwbVHBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049217; c=relaxed/simple;
	bh=sQ2CJTGlHNoB9WmLGpGyTeqk7Y9gIegE3u6Fo9P3dpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwfX7iXW9bijG/iKReOPWXo59T80pmoIdobQSsFCx/zwSCzRNWQbtA4tlYMZOs7bYlAPjPXwgWV8go1e7HqbJCdCeEJwq7rTTrsHcTBKczDg1o73yzeKwjgWAnv+7dSmxU07Oa1CG+gY+q3ql7G2KlBiPkzhee+1yOStw3+4p98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NpZBAkLR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9XvuI030790;
	Tue, 27 Feb 2024 15:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=CY0FaMU4wnVsLsp43Ffy9Z005ivffcYHL55Q9T5ds0I=; b=Np
	ZBAkLRKQPHL+rMvc8JN7dZZkQV9HtRU10KNyuMxJcdj82No1iSgVKKCRBt+ELkU8
	XoOnEGSQDM75/zgrrd3tIsWEIEcBjARNePMNhFcKWiEfu+x+GWtFYEGrQ68cvqlp
	K7+YnTIx1OasNHjvOOWc7GoPSFNaHr8QM2D8QP+zDlTynmL6ZNlT11HJKjiO9CwF
	7DzulVGXpZzp/fpWUefJt1VhN7hdf8B1xmeO7ntv2X23Eyg/743AoO5vp+FRYIb0
	jHYFe3M3PCmsjN1ygEUjTim5/Y2E+CJ1j/nggchstG5XENARbDVSnTKgbOUlC4Qz
	caqrlBmFdkRLtphramtg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrhqvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrVOF028519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:31 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:28 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 1/9] firmware: qcom: scm: Rename scm_query_lock to scm_lock
Date: Tue, 27 Feb 2024 21:23:00 +0530
Message-ID: <20240227155308.18395-2-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: 4n1UIskjC0S9WQu48wQhmjLTyl4s4iLX
X-Proofpoint-ORIG-GUID: 4n1UIskjC0S9WQu48wQhmjLTyl4s4iLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270123

scm_query_lock is global spin lock and only used for query
purpose with trustzone and that too for one time to get the
convention of scm communication. It is possible that, it
can reused for other purpose.

Rename scm_query_lock to scm_lock.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..2d0ba529cf56 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -193,7 +193,7 @@ static void qcom_scm_bw_disable(void)
 }
 
 enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
-static DEFINE_SPINLOCK(scm_query_lock);
+static DEFINE_SPINLOCK(scm_lock);
 
 static enum qcom_scm_convention __get_convention(void)
 {
@@ -250,14 +250,14 @@ static enum qcom_scm_convention __get_convention(void)
 
 	probed_convention = SMC_CONVENTION_LEGACY;
 found:
-	spin_lock_irqsave(&scm_query_lock, flags);
+	spin_lock_irqsave(&scm_lock, flags);
 	if (probed_convention != qcom_scm_convention) {
 		qcom_scm_convention = probed_convention;
 		pr_info("qcom_scm: convention: %s%s\n",
 			qcom_scm_convention_names[qcom_scm_convention],
 			forced ? " (forced)" : "");
 	}
-	spin_unlock_irqrestore(&scm_query_lock, flags);
+	spin_unlock_irqrestore(&scm_lock, flags);
 
 	return qcom_scm_convention;
 }
-- 
2.43.0.254.ga26002b62827


