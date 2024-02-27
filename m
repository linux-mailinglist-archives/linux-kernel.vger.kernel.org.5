Return-Path: <linux-kernel+bounces-83738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAA869DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431841C20F55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602014A081;
	Tue, 27 Feb 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2e/OWr7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEE149DF2;
	Tue, 27 Feb 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055318; cv=none; b=WNSSRE6XUWEbB5NB8PxjGhYPiT7z8RaSRSPsmUd+Ar8XHw4AktlpOK0p3ZOHtep9PaiX/BcHLY9vvaTOWVbjLcnKBdNbVIdpKJn4/k3OY7swMjIGWo2o8sEAbcJtMerVOBsnYLkGyr9jxOu6MFgspDPUpS2Kr4Fv9vWe/MbK7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055318; c=relaxed/simple;
	bh=KhxBN8jWvG5UmM5Eex/uDjN8Et+tbE8+N7z+H/1VdYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2OnnzcoDrvDifoAwolvhAIlhBL0GzTWbw0JF8SciJZZg7eDtuZtqzOFirvoolvzmnnydK2iAXfRhU22YHU9A649nj7Us7YkmDVcn7KXycO091dj2IY9rWW91t3UrQQsV5oGfuq8dQWzrEj2iaGmPs+/zTCRR9hZbCQiNW4NUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2e/OWr7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RCd4e9024377;
	Tue, 27 Feb 2024 17:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=t5MMzmXBYwNKQ5AoEvIhLimv77ikFX8sq/LandotN24=; b=a2
	e/OWr73q2h+7ahRV7H4gcb/PL5F+JGm82kajRetwBGO4bo/yY0Hlmx0Og3gauKtU
	0IBmpuyIymodRnpIPBA5DMUw9lT4Cq3rrbWqFAQdSjVOG+GBLQ3+n1mfjdeFgFUi
	AxEiEXzjdELT+kdoVJzMoPLRZxZFVcUc3Amv36Eb1NwPYaP+9zLE82RFUccYboy5
	ChlOHVn34S5Tae10wU6CwhyEpCjTwiZsr7snn/BvbbsM8SrwXv8cwNkvNsXqT0Va
	vlmHcqlxguNkCgR+28VGvyj0MDq8DNpsFUINtbg2o5iw/FuVtgJ7oA63vm6IGLD8
	iZI3bVaUNAZHMw7uO2hg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh85qsssb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHZ7Zr016603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:07 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 09:35:02 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V2 1/3] OPP: Extend dev_pm_opp_data with turbo support
Date: Tue, 27 Feb 2024 23:04:32 +0530
Message-ID: <20240227173434.650334-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227173434.650334-1-quic_sibis@quicinc.com>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SR3vycA0r6i9rU-cGCgXh2je7e1WWqGq
X-Proofpoint-GUID: SR3vycA0r6i9rU-cGCgXh2je7e1WWqGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270135

Let's extend the dev_pm_opp_data with a turbo variable, to allow users to
specify if it's a boost frequency for a dynamically added OPP.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Document boost flag. [Lukasz]

 drivers/opp/core.c     | 1 +
 include/linux/pm_opp.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c4e0432ae42a..e233734b7220 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2065,6 +2065,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	/* populate the opp table */
 	new_opp->rates[0] = data->freq;
 	new_opp->level = data->level;
+	new_opp->turbo = data->turbo;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f1ac8bde09cb..065a47382302 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -88,12 +88,14 @@ struct dev_pm_opp_config {
 
 /**
  * struct dev_pm_opp_data - The data to use to initialize an OPP.
+ * @turbo: Flag to indicate whether the OPP is to be marked turbo or not.
  * @level: The performance level for the OPP. Set level to OPP_LEVEL_UNSET if
  * level field isn't used.
  * @freq: The clock rate in Hz for the OPP.
  * @u_volt: The voltage in uV for the OPP.
  */
 struct dev_pm_opp_data {
+	bool turbo;
 	unsigned int level;
 	unsigned long freq;
 	unsigned long u_volt;
-- 
2.34.1


