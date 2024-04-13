Return-Path: <linux-kernel+bounces-143775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DC8A3D54
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883FC1C20CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF64E1A2;
	Sat, 13 Apr 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J7VpVJvV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18F47F45;
	Sat, 13 Apr 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021697; cv=none; b=MBM509qH5JMs/t/aPgHIhpulV+a0v7+2kGaHub84yixbpLrHUE7Sqwwv2c1x2KybHqrSPsqDBefd37jzmPM4JAZhxnVzzdNMWYNkNtNVfgoZpTgO70E+QdRKoU5AgRvt0zLetAr0exF+iUlSS3bzn7kRuoiY7aJcXmJSphgysxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021697; c=relaxed/simple;
	bh=CXLgWD/uO470UcKLJmanR9iqaxhsVKJIEdE2vI2u1Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGEoSY2ePlYWwTY2uI+B4wOhuB1H5PTzn/v5+brgA4YOvAVgIqJcb2G+wIK5p747Hs8eUNolkC7fdmZZVAhkeHFaWeM3ClXKucdRTMX/h/DyinXNTHhk/3wEuNmx6dMqb8ioBuf96WG5bVZRfkkAmv/0jiQnitczVk1jCs9v5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J7VpVJvV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DF0D2J009509;
	Sat, 13 Apr 2024 15:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HWhvB7+B3iH9M758/lEFDSW5cbVB3Ca111rsOI8nuJE=; b=J7
	VpVJvVsu2p0h9BdRt/sDRcEaFuxCJmyMF+4OeaRo0UG0IlG5fGvlrL3ZZY9nqHnU
	wwBDc+gR2t6Sm0B8G2MEginMlyOTdClxS3Y36HFtnZU40nybvIxxnOV3107PIw/v
	bDvGsna2AsXjZS3B6T9Q6qJC7og0Zywl5LOjPRbFX1HbfVpbOaw54kToAMS4pg4i
	jXnzXLoCyl5VxJhqpWhxoADtEchtk95WcflrcV0BTQ9NRKOnWRZ49aRAaxD1Rq2G
	G/yNhRovMRfJRBCW3901YFydBX32yNZvy5rPm8CcEFTDJNAb0ViOROYYEIuYwHPf
	qrXJ2B0OUxyBC+LDWZ9w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfk7q0j4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DFLOuh027263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:24 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 13 Apr 2024 08:21:16 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V5 RESEND 2/5] PM: domains: Add the domain HW-managed mode to the summary
Date: Sat, 13 Apr 2024 20:50:10 +0530
Message-ID: <20240413152013.22307-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413152013.22307-1-quic_jkona@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: JhKMZujB3oWZs0CZJ1SA0rx3_cK6reu1
X-Proofpoint-ORIG-GUID: JhKMZujB3oWZs0CZJ1SA0rx3_cK6reu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130113

From: Abel Vesa <abel.vesa@linaro.org>

Now that genpd supports dynamically switching the control for an
attached device between hardware- and software-mode, let's add this
information to the genpd summary under managed by column in debugfs.

Suggested-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 70d8634dd9e8..18a101215c9c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3173,6 +3173,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
+static void mode_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
+}
+
 static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -3231,6 +3240,7 @@ static int genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
+		mode_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3247,8 +3257,8 @@ static int summary_show(struct seq_file *s, void *data)
 	int ret = 0;
 
 	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "    /device                                             runtime status                           managed by\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.43.0


