Return-Path: <linux-kernel+bounces-63068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D3852A60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A801F22959
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68117BA8;
	Tue, 13 Feb 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eva6ASnJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46917983;
	Tue, 13 Feb 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811223; cv=none; b=cc839eTCAGy4QtkcqYBUkREXNAJMM/j2IxFY9qWN7dp15xKJ3E9EroWaoEWPkERKZWERDwwnHnyu/joOZN7v8X48GVU+bAQ4jFjNgWb1fSXePXSkM+jqkWhpUPj8ndVKkxBs6Tao/8gZssHyUIZqeunwy4Yf6fGoLSLx3sbBfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811223; c=relaxed/simple;
	bh=VoMnRaSamnWIppKxRAr8QX4lMcoE34DxAKai2ygPKGQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=toqHhpLYA5ADOfmOY2qeGUv8PvSKHwN+Ma2z1BbD71bi3YsUIIGxjUJILRORrzxE8Pq/b3deYJQybXQniUgEBb5NUfaOvKCG7uQkpxoe080Sk1JDv+jyUGbkVOK9/V+IDv+8djp+QAJVm1eHWS+/9v3f7NU8i3JJE5hmfhJ11BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eva6ASnJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6P2xg017338;
	Tue, 13 Feb 2024 08:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=cVkgK/2fBVNS
	K//CdIwIUFNslMWRKP83ena1wl35pqw=; b=Eva6ASnJ/+uvxdORYUlhxc75S/EE
	RnyOk3YRMDJK4/Uf80JnPJZ5lsUJkdXCRubMKEdiInYGu/YfI7+O8IkBZCkqyhoW
	vQj/eyRClAI5eUtHaYPDYInEDRs8pOuyq61P2657HBg/ZwVL51yQxnAP5Q15s3k0
	ZNsBEn09upuLzpDlMhNfQJ7Lmbhw0Hd+ZOHs1oCcpWtPqHNTrHNdDV+YznwTe3Eq
	oOiNkWQ3Mg8AyENhy63isacTlswZ6LFg2R+O1qOwQXJ1cUI6qsYFOP+igYDjtrxH
	X0bF+Br5yuP0LKeOZt25jvvqMLucTasFecAkRIJAd+jmwU6kvzE3YapP8Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7tans0eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:00:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41D7w88S023112;
	Tue, 13 Feb 2024 08:00:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3w627kkfnn-1;
	Tue, 13 Feb 2024 08:00:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D80Dqk025478;
	Tue, 13 Feb 2024 08:00:13 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-audityab-hyd.qualcomm.com [10.147.244.159])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 41D80DOw025473;
	Tue, 13 Feb 2024 08:00:13 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 207879)
	id 38B835001A8; Tue, 13 Feb 2024 13:30:12 +0530 (+0530)
From: Auditya Bhattaram <quic_audityab@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Auditya Bhattaram <quic_audityab@quicinc.com>
Subject: [PATCH v4] soc: qcom: mdt_loader: Add Upperbounds check for program header access
Date: Tue, 13 Feb 2024 13:30:10 +0530
Message-Id: <20240213080010.16924-1-quic_audityab@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8CyY1HOmZj5bcnTO8AYUO7CFp0KxC2eU
X-Proofpoint-ORIG-GUID: 8CyY1HOmZj5bcnTO8AYUO7CFp0KxC2eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130061
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
is found. Add an upperbound check to phdrs to access within elf size.

Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
Cc: <stable@vger.kernel.org>
Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v4:
 - Added additional prints incase of Invalid access.
Link to v3 https://lore.kernel.org/stable/1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com
Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
---
 drivers/soc/qcom/mdt_loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6f177e46fa0f..1a79a7bba468 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -145,6 +143,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	if (phdrs[0].p_type == PT_LOAD)
 		return ERR_PTR(-EINVAL);

+	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
+		dev_err(dev,
+			"Invalid phdrs access for fw: %s, e_phnum: %u, fw->size: %zu\n",
+			fw_name, ehdr->e_phnum, fw->size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	for (i = 1; i < ehdr->e_phnum; i++) {
 		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
 			hash_segment = i;
--
2.17.1


