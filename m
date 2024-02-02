Return-Path: <linux-kernel+bounces-49073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2984658B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40BF1C24576
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156C48824;
	Fri,  2 Feb 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pL4vnHty"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB48839;
	Fri,  2 Feb 2024 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838539; cv=none; b=XVZMNk+dxkYpY24fUtujvg1bRDzt7Rq0XkcomRdr0j+uMtjtB48GeE9ULyjcmE7ScMf2KbOjlQI+7lhEXOhTIKsLwSDOuHtFnwz/QKtDWOx+ur2qMPB7Ct3cEiM4kg+lapQywQdnkg2IFa+3DsFoRJnvqlu7HkGPmnaCAq+u6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838539; c=relaxed/simple;
	bh=t2VzDvF6TangOq9V3ZVS8s5uYOKw7gMnyady5bpTOdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHtbV4PhUnKdTmNNw5nMkq1RVqkqqs1jJ85z7Hz4WzYi6Be+Hr/QlYP0LLjx7USrieBgnavYwfwKSFr//SiZ+qTGxB8esrph7JO6cizbPHltfymtM9n+qVmTKroH2chYuuYGmVoaELeET0F0IvVKGZvpjDBBNU6aJJWgS1jI5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pL4vnHty; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121cq4s016916;
	Fri, 2 Feb 2024 01:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=QdehPjN9OO5PimvJSvft
	qqYLkTtrjenONFsvhvIOV6k=; b=pL4vnHtyRuUUtQnVdQYtjcZk31NJ5u/5tJXG
	wYn1v93kYbwOzPNMsUB6ZYrlLDjgthA6kRakc3LRGcbwNTcNvGxvgRvs/9IEXfJm
	MV6W8VxZA57zUNhAzi5aIU6k2lpaeWhdE2eqqnAhoH+So57xQdfB8CBWg7zeYwDx
	yzDHBx8UOof5j618ZQHyoIEsdZTt4Ql7t6bp3Tpf2ac3OkkdIliKjd5tFQKcfhMC
	iA9Zo8QmtfoZBqfXWX3pnBc5keL8KztmbrS76vDtWXwXElk8SBuiHi+Tb7etmxz3
	wY/owMkIJs5LMwcpK5YkjyBFVgwKOIT3OaziQQMjgw3tMRd06w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm00kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 01:48:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4121mq2V003005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 01:48:52 GMT
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
Subject: [PATCH 1/2] interconnect: qcom: sm8650: Use correct ACV enable_mask
Date: Thu, 1 Feb 2024 17:48:05 -0800
Message-ID: <20240202014806.7876-2-quic_mdtipton@quicinc.com>
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
X-Proofpoint-GUID: dK60EMLfTj2O9iUkgE0CBhK8X1Dpxi7D
X-Proofpoint-ORIG-GUID: dK60EMLfTj2O9iUkgE0CBhK8X1Dpxi7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=796
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020010

The ACV enable_mask is historically BIT(3), but it's BIT(0) on this
target. Fix it.

Fixes: c062bcab5924 ("interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC")
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---
 drivers/interconnect/qcom/sm8650.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index b83de54577b6..b962e6c233ef 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -1160,7 +1160,7 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
-	.enable_mask = BIT(3),
+	.enable_mask = BIT(0),
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
-- 
2.17.1


