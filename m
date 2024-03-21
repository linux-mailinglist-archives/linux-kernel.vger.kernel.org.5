Return-Path: <linux-kernel+bounces-110216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30DF885B96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F86C1C2206B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55328625F;
	Thu, 21 Mar 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q8Rp0buc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8D85943;
	Thu, 21 Mar 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034677; cv=none; b=V4eAHFQW43RAvGgnvrowWuzVochjAVhoJtxqicLAyYdMWq4dGKNkTi7hnhipi7Tjdz4pgRMskBgzh3hbzN6rP3cAgx3aGqw04nekcpgTfOcE9CBPIqd2+ZRzzK4kHIzp/3nK7HOsRqQb9z0g8SVIUoxJ3WNkhFkfE1ccz+6W/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034677; c=relaxed/simple;
	bh=yrNAWirQ0B17+shzAS4Bp9GlLe3+bJ10ejmklivgc8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXQxb8XX1bxT6HxrYaZXm4j1uzAg8wPmizUzPYvfja2qrZDTXGWMfdxuRpDyYVRtqvvDlyd0ktxG0pZuZUlmiMPtfqwxBAb5axfCZ2gZp4dHcO7E3mDhRpcC4i89QYF3KJY0WS7N61ehuk2cOFFroU8R4VULe0vBnrnGGYVgdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q8Rp0buc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LCrXAA010504;
	Thu, 21 Mar 2024 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=62b78Z4V7ZL5ojA+avLb
	RJBYsfV20bwFiMnNTgYR+kA=; b=Q8Rp0bucw7iRyPxHPxZU320fFHuNHzi5NZYD
	AurkcIzizD3df7WLmJWtyHwguiPTnndtVokOS3GnYLcspneYQk22dth4VoIccNHM
	cViCpqH+1bzcCh2OQE4g27HuvLrwPkFgGj/uTgJVZ9VwppFotAQhQYTl6ib35+QG
	K+ZwAUpLdlv1kjt/brXaY+q8uUirZz7Uil9NqbBjDyv+o1GWL2gWwhzKCVbb7P1F
	j8fDTGKhWkh3fyLk07RitAxXo899ssuesjq0BF435RyZfERQytuHt+eMKqjjS8Q1
	7xZ/mkrNLmgSOyiXlJZnEWlqlJVtVtd1XLYgVh9t4Xt77kmhFw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0n9ugek6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LFOM4h000618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:24:22 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 08:24:19 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 3/4] firmware: qcom: scm: Rework dload mode availability check
Date: Thu, 21 Mar 2024 20:54:01 +0530
Message-ID: <1711034642-22860-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wqex-Pu7p6JVOwUv0hxpbrRNv-N0Y_SN
X-Proofpoint-GUID: wqex-Pu7p6JVOwUv0hxpbrRNv-N0Y_SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210111

QCOM_SCM_BOOT_SET_DLOAD_MODE scm command is applicable for very
older SoCs where this command is supported from firmware and
for newer SoCs, dload mode tcsr registers is used for setting
the download mode.

Currently, qcom_scm_set_download_mode() checks for availability
of QCOM_SCM_BOOT_SET_DLOAD_MODE command even for SoCs where this
is not used. Fix this by switching the condition to keep the
command availability check only if dload mode registers are not
available.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
Changes in v2: https://lore.kernel.org/lkml/20240227155308.18395-5-quic_mojha@quicinc.com/
 - Reworded the commit text.

 drivers/firmware/qcom/qcom_scm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index d9153204cba3..e238ebe21099 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -495,17 +495,14 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 
 static void qcom_scm_set_download_mode(bool enable)
 {
-	bool avail;
 	int ret = 0;
 
-	avail = __qcom_scm_is_call_available(__scm->dev,
-					     QCOM_SCM_SVC_BOOT,
-					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
-	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
-	} else if (__scm->dload_mode_addr) {
+	if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+					 enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+	} else if (__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_BOOT,
+						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
+		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.7.4


