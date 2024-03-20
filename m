Return-Path: <linux-kernel+bounces-108957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA85881281
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCF11C21EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73333482C1;
	Wed, 20 Mar 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Teysl2V6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666F43154;
	Wed, 20 Mar 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942176; cv=none; b=ZsQPfXMdE/z8RsgDgXeR6dCLkKou/6q3BwV4XSnrarnPQPtOEJcI5dzxlPdym4T05G8B0DjupQse20Ym2YeZY5kO/gopMsY8v8QjIwHKgzGkBeMwUGfREiBOm1wPHT1zlSxz9xZXftPLTv0E0r6imdWMSzUwrnMe9oLuyUrRvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942176; c=relaxed/simple;
	bh=Va03ZUxbbz51yCWnpPZsPDEwDl8kD420jlyH6swzV+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjpO9qP3fVeVZQ3GCAcvf483jNni2Bg0vvpKzcb8Z3n/LzNC/+halksD3gvqDcY7n8gh2qpZXk2C3rLHHvVdPCji5j/9D9sd2TQ+P2ADLnGLLOjckDOj9GtXeoqfbIxani4sWxllvGzGX67YjoRfr7rCgH6MUpGWCMxTGUCaF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Teysl2V6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K7qYUC012912;
	Wed, 20 Mar 2024 13:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v6pNyRmUfU9+7OKzKGP0
	wgRaZBJdk/SqtsxZ7zd1x6A=; b=Teysl2V6gPsSjs2zlKEP1M0oibZnG2Nk2l0x
	NG6OySqXaHrntZxK1wRd3yXWbqIqxPd5SE72Oy1nXW1W3QdTJ2v3V4mLlK6RgmWW
	2L+vYJ9WqK3dw3EQyBCxDl2nOgCT9aaa4aXWuoYgeNQapOe9k0Tt25rSj+KAdQFy
	fJKGQxkNybRITUTzZCOBpmY1HKOOW66FR9Rh9vuPnQMLzxFNxiFGfCUvru6CkOxe
	hqDqpdnlA3TX7NWJZMYufCVfBkp9EFDOd5aYygDJP1v4OZb35l7fb40BORlIjovh
	nJ2THARNk7byGD8m4audDe86LGWgdFPjx0zS1bBIwWWtPFESSQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyh8e1y0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDgo4V016886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:42:50 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:42:47 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 1/8] media: qcom: camss: Add CAMSS_8550 enum
Date: Wed, 20 Mar 2024 19:12:20 +0530
Message-ID: <20240320134227.16587-2-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320134227.16587-1-quic_depengs@quicinc.com>
References: <20240320134227.16587-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lz0rLIKpqY4QWPjOAY4EDCPAX8j39U-l
X-Proofpoint-GUID: lz0rLIKpqY4QWPjOAY4EDCPAX8j39U-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=856 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200107

From: Yongsheng Li <quic_yon@quicinc.com>

Adds a CAMSS SoC identifier for the sm8550.

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index ac15fe23a702..2f63206a8463 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -78,6 +78,7 @@ enum camss_version {
 	CAMSS_845,
 	CAMSS_8250,
 	CAMSS_8280XP,
+	CAMSS_8550,
 };
 
 enum icc_count {
-- 
2.17.1


