Return-Path: <linux-kernel+bounces-73013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EA85BC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5714B2284A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E86996E;
	Tue, 20 Feb 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RgTXfMzu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840C65BDF;
	Tue, 20 Feb 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432106; cv=none; b=Uq0em/fgSnBtZutqXt/yZt+HUfDCiZGyaJ7c1PtS0Oko84y2z49safef28FeJWQYk4lqf9tH7SCdCBfc0LBZJ83TYoe7p/ifn+eF4hxHNwoiPHmX0EDtvugbVp+GVmoTEB7p533cG+3HQ/V1gbXXeGlcL2SK7fP4Qnkdie2Ahpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432106; c=relaxed/simple;
	bh=kogTKqIaNyTjBUM7x5FnLesGtt8VNECuM8HWVn67DyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4PC6YHN6WWzJ1Hbe9ylFx2ogVJuOgoexFSf67JSaa8Ju605dgM90EvBExDT6AU1TGSVDHWoRcistIAOGApwiKrVzdiy+GuZzLlNvHgdnnq/2zYrW/gHZ+VGHLCqr7hx6nwYd1UPDGm78pok6DPF7rDHhN3k+0trW0eKQ74eI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RgTXfMzu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K46GpV030024;
	Tue, 20 Feb 2024 12:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=SWPeOrQ
	+8S6jdrU+QkJVQNUKhh5nmk5KlDjNIu9xuEU=; b=RgTXfMzuiQWGAONw16cdUuS
	Zt4EHCsWWczmBj6it9Zl2YglDi/4wUbQRnsdjCbKXBtqQqisamKihhyAuWj/SMrq
	yWWdSMkfO9eqtZW7yGKEoXknD6mIbgIXp6Qxezf3u5V75lJIQfST+lnrW//PSC9f
	PrGUD0tdHTjUZOhf7g0Pmqly8nyVyUqJlXTid7bpWzcA/Be2El3xWE0ngXm9h2RJ
	aTOt0UeNroTOVIk+pSTKdXMtYsDRQnnrpyBtSq9xGEy+r5N3hmhNsTPf47aRGjzn
	Et9mzNwyujG2GZaSYQR9fmkTxIKccd/zftTmLPpoWpKyjvVXx554/5TQ/oEaCRg=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcmqp8wke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:28:21 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCSK95002183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:28:20 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 04:28:18 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH] soc: qcom: llcc: Add llcc device availability check
Date: Tue, 20 Feb 2024 17:58:04 +0530
Message-ID: <20240220122805.9084-1-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
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
X-Proofpoint-GUID: f7qnyPcZYDYCTKt9waKZdcd9mg2FSQQR
X-Proofpoint-ORIG-GUID: f7qnyPcZYDYCTKt9waKZdcd9mg2FSQQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200090

When llcc driver is enabled  and llcc device is not
physically there on the SoC, client can get
-EPROBE_DEFER on calling llcc_slice_getd() and it
is possible they defer forever.

Let's add a check device availabilty and set the
appropriate applicable error in drv_data.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..cb336b183bba 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -769,6 +769,27 @@ static const struct qcom_sct_config x1e80100_cfgs = {
 };
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
+static DEFINE_MUTEX(dev_avail);
+
+static bool is_llcc_device_available(void)
+{
+	static struct llcc_drv_data *ptr;
+
+	mutex_lock(&dev_avail);
+	if (!ptr) {
+		struct device_node *node;
+
+		node = of_find_node_by_name(NULL, "system-cache-controller");
+		if (!of_device_is_available(node)) {
+			pr_warn("llcc-qcom: system-cache-controller node not found\n");
+			drv_data = ERR_PTR(-ENODEV);
+		}
+		of_node_put(node);
+		ptr = drv_data;
+	}
+	mutex_unlock(&dev_avail);
+	return (PTR_ERR(ptr) != -ENODEV) ? true : false;
+}
 
 /**
  * llcc_slice_getd - get llcc slice descriptor
@@ -783,7 +804,7 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
 	struct llcc_slice_desc *desc;
 	u32 sz, count;
 
-	if (IS_ERR(drv_data))
+	if (!is_llcc_device_available() || IS_ERR(drv_data))
 		return ERR_CAST(drv_data);
 
 	cfg = drv_data->cfg;
-- 
2.43.0.254.ga26002b62827


