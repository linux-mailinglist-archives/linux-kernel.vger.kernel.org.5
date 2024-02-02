Return-Path: <linux-kernel+bounces-49075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943F846590
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186321F23B89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67588C14E;
	Fri,  2 Feb 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EIHIbq4M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4A8C08;
	Fri,  2 Feb 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838540; cv=none; b=HfL2xiVnDArHOZ5GKUImaL/mDjk2e6iH8ShUTQESR5187JOtggWOg3MSc1bCDkMJUzD/NITzqvinzDJ8zyzO3MxNfZ3dVjnJFKbVsbJk+mS723GbBaX6QmX1FZZLQH8OQgsreD9ieGnnxAYuI+q2BiIiz+EwpXVEYJeVq79i0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838540; c=relaxed/simple;
	bh=300mRTpVBKdVL02WYT2MCQqRQRQJwlhnk9YDweXgRH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWLZ441QFhgPpuLOFjWeeF73x4+eoERN1TGjlbbKXv1xlO8X4R9DD7QbmoMEuGndIaPPvgTDz6IL+vhF253kWHw/hlb10UHSubXRARof/nr602w1uB1gENRHkHu2gm+5uQgjgnUr1XpwdR/Hh3OzhMYh5Jc2pxH1YIFop23/HTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EIHIbq4M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121cZwl016204;
	Fri, 2 Feb 2024 01:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=E3doFnL1WgDxi/4NsTKz
	ZqMaAvfcL+TJ+uGrIup/UYY=; b=EIHIbq4MkPG83nIQn762nse5m7IIb3P8TG1V
	kR568LsUpxJxyg2XtkxRt9OmmnfojJUxo10+lJtan6RoYDAcGoj66lLjpb+0R5By
	dXgbAJzZ2ylOiXxx9ni+UEHT4WWveD+BQYfic3EOXNXuCsARhTA+kgvV3HOLAR98
	yrzBdcbmqKdaGim4AZytTR3ParqdNPtwKZmz5eSsSGF/4vVIPnOzDSZGdL8xoZqI
	qWE9cWfkQZpRbZkLT9CohdTxIS4VyEPNBFH8VpBCcFj6TvEXPprH80mjqvCVk5NQ
	3fEA11zLuYVLOvWHrCi+muu/vv/5ds1CRqeflYHT7FvWxS14BQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm00kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 01:48:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4121mrK8011422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 01:48:53 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 17:48:52 -0800
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>
CC: <neil.armstrong@linaro.org>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 2/2] interconnect: qcom: x1e80100: Add missing ACV enable_mask
Date: Thu, 1 Feb 2024 17:48:06 -0800
Message-ID: <20240202014806.7876-3-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
References: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TaxKVm5y0PbA9-8dDeGpFQB00XXBhTG9
X-Proofpoint-ORIG-GUID: TaxKVm5y0PbA9-8dDeGpFQB00XXBhTG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=733
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020010

The ACV BCM is voted using bitmasks. Add the proper mask for this
target.

Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/interconnect/qcom/x1e80100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 5b2de9c3a1d6..281295a9a077 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1372,6 +1372,7 @@ static struct qcom_icc_node qns_aggre_usb_south_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
-- 
2.17.1


