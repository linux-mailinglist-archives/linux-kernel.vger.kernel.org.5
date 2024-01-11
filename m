Return-Path: <linux-kernel+bounces-23960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDE82B47E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A87C1F24B46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727605576F;
	Thu, 11 Jan 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fLoQ5pKt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7E537F3;
	Thu, 11 Jan 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDBViZ029340;
	Thu, 11 Jan 2024 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=M5IsFLVWoaIOBf
	bWdK4konAtXheWq+0SyN45h3LMVcg=; b=fLoQ5pKtlBUZKib6qJ+A6DBzvj0Se/
	LWyiBz5+OHceNhzCXx4okXSEWtKJJ0rb7zTOf+2AyrVJvJG3AmaE6D51hiM4BOv2
	VIHwhrTbw2VIFt4KlA+uLzhKdqC8tOW2uf1QpVdQDAHCAv0FgOXtl91f25HBZh2a
	wAwrlhIDL74qtL83rc2OAQboPqCwZMiowweqT020wJfshY8lnfHKUAg9XAKiStlK
	eFDhhUcH19KIjY41ZuoXPsdryyg5CDjZorkK2OUcykEIQpIjXh/0ImJ/hBwqbbn5
	DWegDMGtmewmL29PT0La7vKGTSICBj5h5ZF05z/2okdNIBw73RkbdhGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj6c8j64j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BI5gOR003813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 10:05:41 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Cleanup QMI messaging functions
Date: Thu, 11 Jan 2024 10:05:29 -0800
Message-ID: <20240111-qmi-cleanup-v2-0-53343af953d5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOktoGUC/22M0Q6CIBRAf8XxHO1CgthT/9F8UIS8W6JCuprj3
 0PXS6vHc7ZzVhKMRxPIOVuJNwsGHFwCfsiI7mp3MxTbxIQDz4GBoFOPVN9N7eaRAgArdZtbxRl
 JxeiNxed+u1aJOwyPwb/2+cI2+/+zMArUFo1SbSNAwukyzajR6aMe+m38qcrfSkLRMFBCCSm/q
 irG+AaDG/8S3gAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CAmqVnNDzDkrVCYTJsOsl46omAaFBruC
X-Proofpoint-GUID: CAmqVnNDzDkrVCYTJsOsl46omAaFBruC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=269 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110142

Correct some issues in the QMI messaging functions found during code
review.

---
Changes in v2:
- Fixed rookie mistake -- added S-O-B to all patches
- Link to v1: https://lore.kernel.org/r/20240109-qmi-cleanup-v1-0-607b10858566@quicinc.com

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


