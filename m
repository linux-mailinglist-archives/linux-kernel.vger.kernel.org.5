Return-Path: <linux-kernel+bounces-143779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2A8A3D65
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79281F2191C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1342956457;
	Sat, 13 Apr 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a1lVrdYq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB955E7B;
	Sat, 13 Apr 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021718; cv=none; b=Q6A3Gkp8fkKm6vGW+amjdsPfnlFDWEoQXZnbLtu77ozh00KOe4XUOrHGfHSOIW7SRh3ohtfbdNKYNHKUSw664tq0UqlBTIS7cvAFudNxekzs6qu1RT3m7f7JRKV9QLxZYDKXvsYi7kJ3QPomA2Nz/JC8aa8c5kb937r+SX5G87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021718; c=relaxed/simple;
	bh=c9eDdMrKl056YGymza5L9S9Pn3xL4m/t4iyVlX04qmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQMPKV2mqmnNfrm9Hdj+5xRpnDoVGvmi5MB03pA9uEv013sTeZfZLfeEjahtt8UAK56F+8zyNhZ0e+OCKNW8CbIi+aVbl6KH9WdnLV+FheFT5h87r+vayxazM2h8BglP3E2oHcnlcp37ltlHko9Tet5/uPn1d1+AkLI3EUcYXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a1lVrdYq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DF1DW2005229;
	Sat, 13 Apr 2024 15:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vJl3dvcJIhlAU4N3mv5fA7wSeRtwykn2KSHZ5dN1QWQ=; b=a1
	lVrdYqhFt3WPl1UcjVzftsn8uH3hWzLXhW9rCDbJnTb0om4sx9Np446RvzqJ2vuT
	KtqOOJj4pLZ4S/QD3cT+TTfrAGXrw3e3G+SknFBUXWDp7zWFdTgItCQYTnNx69we
	zCcNlOXzA9zgNn+i4ZxAawDxQHN8/4njogfwYyxeQv45ilkN6BLlgcHUash8GFxJ
	mgf3dWRbROGV3Q4LzR6oMO8bvEpnp/gXssW6/tJzqhjonHG51luQ+dLWXvbRfXu8
	INcjTiwwU5ATtjTCaQSGFIYZogMUyyt7/neIVf0d8eZ6TcqTkLkEOsAxSwWZyO5K
	6SfV7mKXzBCAa0gO6TmQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xffrk8spu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DFLlGF008305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:47 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 13 Apr 2024 08:21:39 -0700
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
Subject: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on V6
Date: Sat, 13 Apr 2024 20:50:13 +0530
Message-ID: <20240413152013.22307-6-quic_jkona@quicinc.com>
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
X-Proofpoint-ORIG-GUID: gS3QYZk-ujMa-Bn-Xpmais0jv_HfJYtu
X-Proofpoint-GUID: gS3QYZk-ujMa-Bn-Xpmais0jv_HfJYtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130113

The Venus driver requires vcodec GDSC to be ON in SW mode for clock
operations and move it back to HW mode to gain power benefits. Earlier,
as there is no interface to switch the GDSC mode from GenPD framework,
the GDSC is moved to HW control mode as part of GDSC enable callback and
venus driver is writing to its POWER_CONTROL register to keep the GDSC ON
from SW whereever required. But the POWER_CONTROL register addresses
are not constant and can vary across the variants.

Also as per the HW recommendation, the GDSC mode switching needs to be
controlled from respective GDSC register and this is a uniform approach
across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
controls GDSC mode switching using its respective GDSC register.

In venus V6 variants, the vcodec gdsc gets enabled in SW mode by default
with new HW_CTRL_TRIGGER flag and there is no need to switch it to SW
mode again after enable, hence add check to avoid switching gdsc to SW mode
again after gdsc enable. Similarly add check to avoid switching GDSC to HW
mode before disabling the GDSC, so GDSC gets enabled in SW mode in the next
enable.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../media/platform/qcom/venus/pm_helpers.c    | 39 +++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 502822059498..4ce76ce6dd4d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -412,10 +412,9 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 	u32 val;
 	int ret;
 
-	if (IS_V6(core)) {
-		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
-		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
-	} else if (coreid == VIDC_CORE_ID_1) {
+	if (IS_V6(core))
+		return dev_pm_genpd_set_hwmode(core->pmdomains->pd_devs[coreid], !enable);
+	else if (coreid == VIDC_CORE_ID_1) {
 		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
 		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
 	} else {
@@ -451,9 +450,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 
 		vcodec_clks_disable(core, core->vcodec0_clks);
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
+			if (ret)
+				return ret;
+		}
 
 		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
@@ -467,9 +468,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 
 		vcodec_clks_disable(core, core->vcodec1_clks);
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
+			if (ret)
+				return ret;
+		}
 
 		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
@@ -488,9 +491,11 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret < 0)
 			return ret;
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, true);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, true);
+			if (ret)
+				return ret;
+		}
 
 		ret = vcodec_clks_enable(core, core->vcodec0_clks);
 		if (ret)
@@ -506,9 +511,11 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret < 0)
 			return ret;
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, true);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, true);
+			if (ret)
+				return ret;
+		}
 
 		ret = vcodec_clks_enable(core, core->vcodec1_clks);
 		if (ret)
-- 
2.43.0


