Return-Path: <linux-kernel+bounces-109795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C098855CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4107F282C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D556759;
	Thu, 21 Mar 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R3xXvejV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385E5645B;
	Thu, 21 Mar 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009983; cv=none; b=N3TtetauolqClfgpppYchUKqpaa+YjbX28VdSN+kHrHlwfi+Gq/6t23zKOrl77L3JT8BwEMV9SYriYYLjypD/oseu122rhY4gspRlhWaFwdsYFmM14sFEs5olp/nh0Uk6jDIC6RqBMmVprROYnvPAQKdMeP60udFlhBK1bQbhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009983; c=relaxed/simple;
	bh=vx2vwBCl0vH0JYk/uQOxu5ro861vYZpASDGOQB/yfR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9dgr0e+LRS0BH0/iL250kO35DixIckvEdICjzspm8iQAhSX3yj6257qEfAouZ1wt5ukb4Ky9sQzsrgvKQcxgbqJrsS1rkcanIdR8fEb87yvl91W0K6BLnhrPpH9wM14am1uPVWjqqUwrtX1KvHeWuinGyIfo1b6jd4oU/DhPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R3xXvejV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L7ocJL013044;
	Thu, 21 Mar 2024 08:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IGaNZqa/I3mj/VFA3aJv
	ae8DPRo039rcBSepgeW3wT0=; b=R3xXvejVuSDo4uy6zxrr+GsJDyffCQGlpo1/
	eQPsxE+D0TzPqziqqN/HthQpmKbSUwLfSjsXywOVaxUz6gyAq6NjT9A/YgL/T5j/
	Q5m0louIybEPE5JBnssevgO5g52Ft7xNG3rt0M4tywIbcTYzFfw6uWB7qXBLadUo
	i8Oe0IZttkPtPCmrpYOTUZPzFU7drCJ4ieBvYJRA/j1OD/hTRzlenGwkMDaejE6A
	1LVp1PWE4V10zgyC6fT5cNW2RU2iVzNy/8obJ+jTa0lY48A8+0lCyWHPTT9EjzYN
	fi+kdfhqB0C9yqJ6OsSp8s5yy37Qz8DAPnq8paC/Sm0+1UKCmg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0ba10pwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L8WoDN000565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:50 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 01:32:45 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH 4/4] coresight-tpda: Add support multi-port input on TPDA
Date: Thu, 21 Mar 2024 16:32:07 +0800
Message-ID: <1711009927-17873-5-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hhH7l2_2HQApscZ2O8blWgoDCff1rfuV
X-Proofpoint-GUID: hhH7l2_2HQApscZ2O8blWgoDCff1rfuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210056

Since the funnel supports multi-port output scenarios, there may
be more than one TPDM connected to one TPDA input port.  In this
way, when reading the element size of the TPDM, TPDA driver needs
to find the correct TPDM corresponding to the input port. When
TPDA finds a TPDM on an input port, it read the device tree of
the TPDM and finds the configured TPDA input port number. If it
is the same as the input port number passed into the function,
then it is the correct TPDM that needs to be found.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 27 +++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 52b0201090fb..ba71e1ff18e3 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -84,6 +84,26 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	return rc;
 }
 
+/*
+ * Check if the parameter of the input port number in "tpda_get_element_size"
+ * is the same as the property of the TPDA input port number defined in the device
+ * tree.
+ * Return true if they are the same or the property is not read.
+ * Otherwise, return false.
+ */
+static bool is_tpda_inport_matched(struct coresight_device *csdev, u32 tpda_inport)
+{
+	int rc = -EINVAL;
+	u32 inport_nr;
+
+	rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
+			"qcom,tpda-input-port", &inport_nr);
+	if (!rc)
+		return (inport_nr == tpda_inport);
+
+	return true;
+}
+
 /*
  * Search and read element data size from the TPDM node in
  * the devicetree. Each input port of TPDA is connected to
@@ -99,6 +119,10 @@ static int tpda_get_element_size(struct tpda_drvdata *drvdata,
 	int rc = 0;
 	int i;
 	struct coresight_device *in;
+	static u32 tpda_inport;
+
+	if (inport != -1)
+		tpda_inport = inport;
 
 	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
 		in = csdev->pdata->in_conns[i]->src_dev;
@@ -110,7 +134,8 @@ static int tpda_get_element_size(struct tpda_drvdata *drvdata,
 		    csdev->pdata->in_conns[i]->dest_port != inport)
 			continue;
 
-		if (coresight_device_is_tpdm(in)) {
+		if (coresight_device_is_tpdm(in) &&
+				(is_tpda_inport_matched(in, tpda_inport))) {
 			if (drvdata->dsb_esize || drvdata->cmb_esize)
 				return -EEXIST;
 			rc = tpdm_read_element_size(drvdata, in);
-- 
2.17.1


