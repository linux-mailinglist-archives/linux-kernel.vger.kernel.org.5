Return-Path: <linux-kernel+bounces-143778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3478A3D60
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C430C1F217F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31C54FB7;
	Sat, 13 Apr 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SBhqfAKG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE6548FA;
	Sat, 13 Apr 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021710; cv=none; b=K0GM0cTPgyg107aluSRhRPs/JYAZ7YsBx8EPDFaIX3TrJKN69lLRKdb+NIISYMi+j8ftdVBe8aoVVKdCRg9VLCt5veOeFXiEAlh2ujEQhQZOFb7FVTHo10CNImkeqSgqshCS7imRnuDUSw3JaxsSxCa3yLsAm37d8mhcmyKk3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021710; c=relaxed/simple;
	bh=L6QBOEmbjLNDR+6iEWPhrA19yzupcoLILRLXUmIQ3Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEBw+W7Q5sDbflhO1N8/3LaKuTdvEf3wmGxtXUVTA+ButoH6bwZ31JeKunJXYyrAnReTaqhaG1RJT4oPl6vsuXaaObJRtZDAiKBt2RsQ5HI394zBiHtpeXEJhC/BDgGp34WLL2sMt+SeFbBCgtPxJNgFRfG0gcaxYXGbEi+/Q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SBhqfAKG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DFAj7O030102;
	Sat, 13 Apr 2024 15:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=47F97nRJ7yTuVM2FeJ7FtAVve6WE+PitYBORY6KFVIM=; b=SB
	hqfAKG+QhKG9JY7ET/ukP5ONfxnWsrr51V4LxdIbkcKfi/eXMxlG9XxFHUYvf/wA
	kbKa9hFsHmqf5AfsluhInlba6uHuMQmGDgQonlup+4vS8U53eEejL66rHK2Nj+HL
	+t4ob7znUik1+2OIw8l3Jn+4JI9FIiULtxiigzBNqq/YpfwXAr3ThwBI9sEH941/
	24QZhNQMq0s2ZUWhBm6JaibJsqQFE3xE6anQTD99/afrHmWZdpn3ygpaD9PJ2Xdy
	wz8uI0YzIJNukLIG8RaZVVrs5V9Pq+iA3OYWtRGpC5q7cnjAXfhVfHo90zVUp1bo
	Zk7FnDeMIlncvwq5Ne4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfk7q0j4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DFLduK004496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:39 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 13 Apr 2024 08:21:31 -0700
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
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
Subject: [PATCH V5 RESEND 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
Date: Sat, 13 Apr 2024 20:50:12 +0530
Message-ID: <20240413152013.22307-5-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: 3DXniXkrodQ0A75wy7JAPvqahevGiH64
X-Proofpoint-ORIG-GUID: 3DXniXkrodQ0A75wy7JAPvqahevGiH64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130113

The HW_CTRL_TRIGGER flag provides flexibility to switch the GDSC
mode as per the consumers requirement compared to HW_CTRL flag which
directly switches the GDSC mode as part of gdsc enable/disable.
Hence use HW_CTRL_TRIGGER flag for vcodec GDSC's to allow venus driver
to switch the vcodec GDSC to HW/SW control modes at runtime using
dev_pm_genpd_set_hwmode() API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index cdd59c6f60df..d55613a47ff7 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
 		.name = "mvs0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mvsc_gdsc = {
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 016b596e03b3..cac10ccd362e 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
 	.pd = {
 		.name = "mvs0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
 	.pd = {
 		.name = "mvs1_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-- 
2.43.0


