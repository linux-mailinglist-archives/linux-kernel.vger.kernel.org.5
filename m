Return-Path: <linux-kernel+bounces-21188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3669828B80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CFF1F25D82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F403C472;
	Tue,  9 Jan 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="No63c6/+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8873BB38;
	Tue,  9 Jan 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Ganr4012230;
	Tue, 9 Jan 2024 17:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=TK4R7YjpOoaeJp
	gRenwcUYToruwgnjKAjGG59bKhVmI=; b=No63c6/+71OXrBOUAd49ylbKGmzR5l
	InSaddKxZuMc0ObnboxU0CB90wwKJ9vflhDeiAwl+qfz9nYp/hmZ/S0VldcYCvqW
	EUYRTRimPQ79lgzXC/zfQcIOqgyY75L4dn1KW2hyC4whdIYgt+saX5+5buSgxBG0
	arT9JKFSQDOE6qdwhI0lFYEgt4snjNoyvkTTu0U+D+2VcbeJ0g7jigTcAb8KiSCD
	U4B5Evlf/C/SPdhSz7EqLDOH/bhB0bGoFD0Ed45uQvnYk8yxRgWEUFfyp1Ms3S2Z
	oPlpp/aZVYuLaMwJk12XJeXcEPeMjIaSVrdn02eBEh1ifKYMg+IOC/XQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9ta05rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 17:51:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Hp73K032020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 17:51:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 09:51:06 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Cleanup QMI messaging functions
Date: Tue, 9 Jan 2024 09:51:02 -0800
Message-ID: <20240109-qmi-cleanup-v1-0-607b10858566@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIaHnWUC/23MSw6CMBSF4a2QO7bmtoJWRu7DMIA+5CbSQiuNh
 nTvVsYO/5Ocb4NoApkIbbVBMIkieVeCHypQY+8ehpEuDQJFjRwbtkzE1NP0bp0ZIvKr0rWVgkN
 5zMFYeu/avSs9Unz58NnxxH/rfydxhsxeBin10OAZT7dlJUVOHZWfoMs5fwEL643VqAAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FpIzD3PGQrvo8NqJ0xSwp665X4LN4-h5
X-Proofpoint-ORIG-GUID: FpIzD3PGQrvo8NqJ0xSwp665X4LN4-h5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=279
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090144

Correct some issues in the QMI messaging functions found during code
review.

---
Jeff Johnson (3):
      wifi: ath12k: Remove unnecessary struct qmi_txn initializers
      wifi: ath12k: Add missing qmi_txn_cancel() calls
      wifi: ath12k: Use initializers for QMI message buffers

 drivers/net/wireless/ath/ath12k/qmi.c | 63 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 37 deletions(-)
---
base-commit: e7ab40b733094dfc50dad58bbce81f544af1d8cc
change-id: 20240105-qmi-cleanup-00019cd4f821


