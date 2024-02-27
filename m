Return-Path: <linux-kernel+bounces-83225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335C869079
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9FD281CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C514534C;
	Tue, 27 Feb 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A8pnxTAZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2171420D0;
	Tue, 27 Feb 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036708; cv=none; b=cfAdZfJyNSKCnnIYVqhbT3DtTxurkuCDDzgDvPQEu8SzLihFvCwKl90cKXq5NFxnujfqijuzUVuFOQQZEP9YqgJKRrRMtWizn4opLpfZxDYucLuwOCJXr3Zsz4M3kPgSvig8vuALR1PxD5y77J8BHuS528wOaLhGxWIpvsXo6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036708; c=relaxed/simple;
	bh=XeUDhYwfKyIrFsiSilOuXCvNQYsw/Z3DS1lqznlROSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpuCCc1wAe0ZLLtbUsSgi9U0shrQ5XOMe57fDpis9UJMfy0bf5eNlmd3SYWazc+IEuPklsfhPTbgDlHEpCCr6diIsGMno1tUXabaBTry0Fk5GEFPP1OpC+S+C6AxWd0lIWSCY6nuC75F57jSqRLtyhsS25mKLIr/MprnzNVSfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A8pnxTAZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Z2tc022578;
	Tue, 27 Feb 2024 12:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iP4HXAhBSoCDbMAjubDNFtX+UM+R9muPZP2UiKZRe7g=; b=A8
	pnxTAZAwacWyH5Zb6csFnMhzRs1yZ6pmf7KT2yRljpn6pSnet1OCldlYOSfx9lTR
	Da0OpVYLVP1UErV3xkO0uU9Fvuypt5IoeB5jXGm5izKll+NCp1hllCBw/nK7G2rv
	ydEVLRmzUNgZJbqe5wfSY63Ya7O8EUyuSha6AoK/y1t4lThAJR52eUOUH0DCoivP
	1ZVMz5uk2OY/z6Ubww77/+ZHbGuC6x1IyDfhlYY768M6me3wXWRvOM2F8u3jeLLk
	UGXqiPj90lqPQtZDQ46StO8wBiTypy2T2Nwa1eeQKW4MA/gUlF/ulF2uFoa5ZnX1
	P+XXd66hfKk3w9p/aS9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh5079bes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RCP0K9013505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:00 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 04:24:57 -0800
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH 6/9] media: qcom: camss: Designate lite subdevices in resources
Date: Tue, 27 Feb 2024 14:24:12 +0200
Message-ID: <20240227122415.491-7-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227122415.491-1-quic_grosikop@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NoZKTdDIa7r5DvHUkvQjs6jXQEVvhBcM
X-Proofpoint-GUID: NoZKTdDIa7r5DvHUkvQjs6jXQEVvhBcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270097

From: Milen Mitkov <quic_mmitkov@quicinc.com>

VFE/CSID may have full-fledged or lite versions. Use a variable
in the subdev resources for differentiating between these,
instead of figuring it out by id.

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss-vfe.c |  1 +
 drivers/media/platform/qcom/camss/camss.c     | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 4e0a8b2bb737..8d9be0a8e1bb 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1491,6 +1491,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		return -EINVAL;
 
 	vfe->res = &res->vfe;
+
 	vfe->res->hw_ops->subdev_init(dev, vfe);
 
 	/* Power domain */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index eea6f050db64..fc9940e883c5 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -713,6 +713,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.interrupt = { "csid0" },
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
+			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
 			.formats = &csid_formats_gen2
 		}
@@ -738,6 +739,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.interrupt = { "csid1" },
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
+			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
 			.formats = &csid_formats_gen2
 		}
@@ -792,7 +794,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
 			.line_num = 4,
-			.has_pd = true,
+			.is_lite = false,
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
 			.formats_pix = &vfe_formats_pix_845
@@ -820,7 +822,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
 			.line_num = 4,
-			.has_pd = true,
+			.is_lite = false,
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
 			.formats_pix = &vfe_formats_pix_845
@@ -846,8 +848,8 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 		.interrupt = { "vfe_lite" },
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
-			.is_lite = true,
 			.line_num = 4,
+			.is_lite = true,
 			.hw_ops = &vfe_ops_170,
 			.formats_rdi = &vfe_formats_rdi_845,
 			.formats_pix = &vfe_formats_pix_845
@@ -956,6 +958,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.interrupt = { "csid0" },
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
+			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
 			.formats = &csid_formats_gen2
 		}
@@ -973,6 +976,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.interrupt = { "csid1" },
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
+			.is_lite = false,
 			.hw_ops = &csid_ops_gen2,
 			.formats = &csid_formats_gen2
 		}
@@ -1034,6 +1038,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
 			.line_num = 3,
+			.is_lite = false,
 			.has_pd = true,
 			.pd_name = "ife0",
 			.hw_ops = &vfe_ops_480,
@@ -1061,6 +1066,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
 			.line_num = 3,
+			.is_lite = false,
 			.has_pd = true,
 			.pd_name = "ife1",
 			.hw_ops = &vfe_ops_480,
@@ -1086,8 +1092,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.interrupt = { "vfe_lite0" },
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
-			.is_lite = true,
 			.line_num = 4,
+			.is_lite = true,
 			.hw_ops = &vfe_ops_480,
 			.formats_rdi = &vfe_formats_rdi_845,
 			.formats_pix = &vfe_formats_pix_845
@@ -1111,8 +1117,8 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 		.interrupt = { "vfe_lite1" },
 		.type = CAMSS_SUBDEV_TYPE_VFE,
 		.vfe = {
-			.is_lite = true,
 			.line_num = 4,
+			.is_lite = true,
 			.hw_ops = &vfe_ops_480,
 			.formats_rdi = &vfe_formats_rdi_845,
 			.formats_pix = &vfe_formats_pix_845
-- 
2.17.1


