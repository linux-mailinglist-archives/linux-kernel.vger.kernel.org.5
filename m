Return-Path: <linux-kernel+bounces-49276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD0846821
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51161C234D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E017988;
	Fri,  2 Feb 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UbtUVvGD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E71774A;
	Fri,  2 Feb 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855974; cv=none; b=goEr/ylk76ekOPVrDWatF33xhLf7OGHvMsx2RQClQVq0qhK0yOIom/pcfkQmc5ZI1hc0odT/emVCIQfhVDI5aSNX/qJqQUXVLNJTBgTxpPj+kUlQ+kK1mjWaV42WqqskaHOk6c4aoH1E/RpJdr879/YYHOaAVkJMNu/sBC95GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855974; c=relaxed/simple;
	bh=+uwWgROn7xwCpYK73AuMgwmLjp+IXPeINgrWeDo7rvA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qJB1+h+43+dG+OsymGUwJ+RFTqvyTmOIMJEd9AXIsEBGObDIxIWhLe41/Bqk/wbURjS/11DC5Oes2JcyLyN6NOG+rEc9p90YjvE3B4dIRaZsEYSoxZiZPIbq1Db8/z+69qBz34RkzAzOcWq3vXueQga0cvNpxYtlaWhjG8tr4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UbtUVvGD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124UMOb028383;
	Fri, 2 Feb 2024 06:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=bFOdQ4cUclMz
	twQO9lzol9OV1vF0GcInILFfiyet5KA=; b=UbtUVvGDpaZVn9fQ8nycIhpciosI
	CdN4/BYrYzNit6AOkD/VbJnFEhsPoJ6SArEbMKK9CrHQl5JKxhDGxiTDg3jXEDjL
	sh5aLSjepbDNxY554b01jkmK0lA/3zNgJ4wS6bEmJ7ePWE6cqN/YY7mj7OlujXsg
	UCU5YDqfA6GHLJx98qW7HaqM4RBQ3kxYSeXmEKyIqK1NQYEVKnY9q0lryqDU7K2T
	jEeewIYB1UnBh7swdpjXJBDkSfHkgvVSfaWw8JlKAHEiFQFINIyUll0QzBl8nxTN
	CbOzqUQdctCe+cCFLgf8Nz06Fc0zboN1jWUfnLNUbt5VCF4KdbxMQTC53Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc0n02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:39:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4126dMEZ016344;
	Fri, 2 Feb 2024 06:39:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vvtwmrta2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 02 Feb 2024 06:39:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4126dM0c016337;
	Fri, 2 Feb 2024 06:39:22 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-audityab-hyd.qualcomm.com [10.147.244.159])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4126dLi6016335;
	Fri, 02 Feb 2024 06:39:22 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 207879)
	id 0EF625001C2; Fri,  2 Feb 2024 12:09:21 +0530 (+0530)
From: Auditya Bhattaram <quic_audityab@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Auditya Bhattaram <quic_audityab@quicinc.com>
Subject: [PATCH v1] soc: qcom: mdt_loader: Add Upperbounds check for program header access
Date: Fri,  2 Feb 2024 12:09:19 +0530
Message-Id: <20240202063919.23780-1-quic_audityab@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0xG4ksmH8z3ZGJJQgs-7X-AIcXxE1MuM
X-Proofpoint-ORIG-GUID: 0xG4ksmH8z3ZGJJQgs-7X-AIcXxE1MuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
is found. Add an upperbound check to phdrs to access within elf size.

Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
---
Added error prints for Invalid access.
Link for previous discussion https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
---
 drivers/soc/qcom/mdt_loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6f177e46fa0f..61e2377cc5c3 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	if (phdrs[0].p_type == PT_LOAD)
 		return ERR_PTR(-EINVAL);

+	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
+		dev_err(dev, "Invalid phdrs access: %s\n", fw_name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	for (i = 1; i < ehdr->e_phnum; i++) {
 		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
 			hash_segment = i;
--
2.17.1


