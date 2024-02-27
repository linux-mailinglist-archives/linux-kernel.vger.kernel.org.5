Return-Path: <linux-kernel+bounces-83555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF7E869B55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6541C23EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBA51482F3;
	Tue, 27 Feb 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H4czaRNT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8414CACB;
	Tue, 27 Feb 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049239; cv=none; b=D+aj+BFHdR0nNHqM9ToaA36NEZqu9mYUGAlgd7wtKmVxdncnz8mFPBxUOg1bzrw6ZbfCoZlPyaTtAOyY3mM+4hcXldD9qKQdPEAzka7u9R3t1W7oL32A4Mp7UOCdkQjBNw5tgtBeJZ2niwReLvW82Xy85BHAz9FlPhV6PwoXMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049239; c=relaxed/simple;
	bh=a6HqBkmx/YMzLwbBaE70Z4ncxL4+fd7dFK32oyoWxZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmdSBuczMyqP+qd+kDOuGg82L71KzzOgnJC/DAI34NcWqUQBAgQwHDwAkSD2E9rFTUuM1eH7IvaCdLeZdcEu/6XLmthwqiFDVSOoYh0DSZebUIQdWkwhnzAPwUJ6nNmCfrbXD4rV1XPTaqIMsgrbArC/q5Lnx2z4NLOw2+43VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H4czaRNT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RAuNdb009670;
	Tue, 27 Feb 2024 15:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=oyNGVgf749RGIPNshcfIDi9wFWrNfE/UUoZx08FK340=; b=H4
	czaRNTwEwgV1VPz8gpWMANM7SE0ArcnKq8Q8RMJQNLSXCF0cZv22iCsf4/4w3Htu
	rqyaUp3OXCjgapmZH2XdTWFkj5lqiNj2OYPCmJ1QnpS/3j72QoKsY3nlqKLUZLFh
	YrV7EuaUF5+btol18t7Uv8SPfr5xcVMcQqT7B7Tb6yNYiOybINRuNnz5sqyVbJ7l
	GVbypcD5ZxZZkfc3OAEowq28eF9AjZMjUbtFe/Aa375niF0R9mab07atV3Q1wubi
	13FJSRS3f4TQ8+gBoZWQYdJOrWIed/W1seGoYUiUgnnPBJnSeYDs5gVK0dEOJ4IG
	gYA/f0IrnE83RxaWBJzg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whedvrr88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrsDc011850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:54 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:52 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 9/9] firmware: scm: Remove redundant scm argument from qcom_scm_waitq_wakeup()
Date: Tue, 27 Feb 2024 21:23:08 +0530
Message-ID: <20240227155308.18395-10-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: C_3KrFfEdNVvreYXkud8SuXx7N98pwtA
X-Proofpoint-ORIG-GUID: C_3KrFfEdNVvreYXkud8SuXx7N98pwtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=947 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270122

Remove unused scm argument from qcom_scm_waitq_wakeup().

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index a1dce417e6ec..d91f5872e003 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1853,7 +1853,7 @@ int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
 	return 0;
 }
 
-static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
+static int qcom_scm_waitq_wakeup(unsigned int wq_ctx)
 {
 	int ret;
 
@@ -1885,7 +1885,7 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 			goto out;
 		}
 
-		ret = qcom_scm_waitq_wakeup(scm, wq_ctx);
+		ret = qcom_scm_waitq_wakeup(wq_ctx);
 		if (ret)
 			goto out;
 	} while (more_pending);
-- 
2.43.0.254.ga26002b62827


