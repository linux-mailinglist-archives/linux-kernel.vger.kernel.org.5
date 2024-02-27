Return-Path: <linux-kernel+bounces-83552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B3869B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C008B28391E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DD146E78;
	Tue, 27 Feb 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L9V4CRZk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468B149000;
	Tue, 27 Feb 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049231; cv=none; b=d85P2rMXvjKomIi8yAONaoctulm5v5xgv8j9pB0hBCBQn8O4M3WWRoVGrBwp5AghvF/XNMJlR9Tmhjac3b9xPyqLLAB+Y6XN8Uda8u63JTW1fG3ZXatdMF3pouVWAKpc/b0Qeo79ueVXRiC7xArZcO0AxalkfDkxVj5QOQ6d1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049231; c=relaxed/simple;
	bh=CQNAuyTRM2K+tQB53tmQS1x2t4PZd2hpfvo2JMyAks4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdP523hjL14aoiPxOt7Jc9W+Py01soZk1QrdPMx9nNoVgdIxsss7UurcvUHapaxdyadWTwMp0Ark6C5HvDwpNhF82wg0+HNE/xqoI7quAmy7dQqBv8+z2LWD/VpN+RfBpOfk2x689c8kibrS7IPtBHdJpuzSWMeIk6vVqcxGnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L9V4CRZk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RERJCL026934;
	Tue, 27 Feb 2024 15:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=gwUiJkIqL4nokAQI8FJ5IuA+Yowem9nNNMwwaK+yUv0=; b=L9
	V4CRZk+oaqcDMn7an5oUVFDfcwIYMeqOh1+0wKtypphLYg+L5sEwvBragnbx+rUC
	cELrpLFThv6OktS5an2Zu3/7gjIbT+SXHTEjIKeuidQg9GbMph+/Xil/VSaHWZ6x
	qwbvC1DzoRtkPAexVhg/ZyOHt+B6qn7QsUfwEDB+Co5CjQvfDFgeJ/fcxsPDQOr7
	l1lKqIleYKqhoIvOslZMwmdjQIItR/ym/HG2gbDt/vZd5n5Hqngby9kVlXAba+a4
	yWGTKqhAwalWAi26MI/fumeWyoKyUM/cKEnTHaEZ6xzKW/fdFsYh8uU8liPEi717
	ZbNXl94DS+Qff1DjjY9g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auhhy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrkrY012029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:46 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:43 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 6/9] firmware: qcom: scm: Remove log reporting memory allocation failure
Date: Tue, 27 Feb 2024 21:23:05 +0530
Message-ID: <20240227155308.18395-7-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PQ9POfKZ2x1o9oeNxfAkbq-US4XAGcss
X-Proofpoint-GUID: PQ9POfKZ2x1o9oeNxfAkbq-US4XAGcss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270122

Remove redundant memory allocation failure.

WARNING: Possible unnecessary 'out of memory' message
+       if (!mdata_buf) {
+               dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3fd89cddba3b..6c252cddd44e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -598,10 +598,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-	if (!mdata_buf) {
-		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
+	if (!mdata_buf)
 		return -ENOMEM;
-	}
+
 	memcpy(mdata_buf, metadata, size);
 
 	ret = qcom_scm_clk_enable();
-- 
2.43.0.254.ga26002b62827


