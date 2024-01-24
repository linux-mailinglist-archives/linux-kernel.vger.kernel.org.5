Return-Path: <linux-kernel+bounces-36425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBAD83A096
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3558929195E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E4C8EC;
	Wed, 24 Jan 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oT7qZipJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C60BE74;
	Wed, 24 Jan 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070358; cv=none; b=BbcRbNPmQajuBKznUxcCJvaZFzgPaKU4yD30JSWI64Da0u8ubGqUjEFjd/t5v6TjaKBUkJVzZQvxZJSDKlY5SWpYwX0BXattvqtxQUQz9oxzwZU4Th7FLaxFbkXOwScMfkS2jAAvTCL8wfHcUKI4AAxlddGulMuobI0/zoZ/B4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070358; c=relaxed/simple;
	bh=7ZWW+8qHDNDoQXk/hD+0GuH82VHOG4uW2aOnjSqYjh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NkBvf5dMOwmF5Piq4wbax5lLh7TkXTjck5YS9/g5F0gpLtHhfAVwdwThxTKZOTlabHwAM4Q1SNnhdpHJb+qC+6LojMuw4zLglxgtCOcCklvSiPS7XBZ14N4Jr1oQSzHCknVKITPAqMsk14NDgNCh912HCk8kcAbl0/AnKa/Ger0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oT7qZipJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O41Y6p020644;
	Wed, 24 Jan 2024 04:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=vtJobCucxjhRKCLo3qeZp87nG4VsdWwAweQjG0KAvcE
	=; b=oT7qZipJnO6R855AUZhdV5jx1Ga9e19xKIwIwgswa554p7uXTZl7kzpHK+g
	SC2CVP+5Wag0AO9lOtNS+hHZHDMi+NWgGndvyt794oMhEDYmw3anRJGwuzDtGn6v
	luCP4wOcL0yI5uJ+/BTbBDrnr0qHK+Bp/ggciLc5usUGbN5Z2fBGwAzTq+OdKuCX
	vJ79ys46QiqlOLEyKt6fnWWcMrza/Lrv8OB/DekwZBjoxasUmWbFIgP0y0yGg3xV
	V4cHyK/5wm5YdPgOu2IX4HFGviczTKF3UkJAheGk0jO+u3gH8/NrD9ipkMCTryfy
	zAPjYAUyfiXb41e1ZeJOC4CktOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmmegqr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PGQe030413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 20:25:16 -0800
Subject: [PATCH v3 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-sa8295p-gpu-v3-2-d5b4474c8f33@quicinc.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
In-Reply-To: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070315; l=1360;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=7ZWW+8qHDNDoQXk/hD+0GuH82VHOG4uW2aOnjSqYjh0=;
 b=Ytv5aKLPjCbdZqOMtasS50BWZ4k4OZvAlWurSVggSYMUGJkOBm9KJN7NJA5JKc8RFi9JUo6MZ
 XQZHm7rvW8cCuTijAmK/fj5R/wI0SqYNTqq/OLsqJqOiRAHy+NNa5qg
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WfxGJpnezKWqMoEl91iD932uD15vmf-I
X-Proofpoint-ORIG-GUID: WfxGJpnezKWqMoEl91iD932uD15vmf-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=937
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

The GX GDSC is modelled to aid the GMU in powering down the GPU in the
event that the GPU crashes, so that it can be restarted again. But in
the event that the power-domain is supplied through a dedicated
regulator (in contrast to being a subdomin of another power-domain),
something needs to turn that regulator on, both to make sure things are
powered and to match the operation in gdsc_disable().

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gdsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..e7a4068b9f39 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -557,7 +557,15 @@ void gdsc_unregister(struct gdsc_desc *desc)
  */
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 {
-	/* Do nothing but give genpd the impression that we were successful */
-	return 0;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret = 0;
+
+	/* Enable the parent supply, when controlled through the regulator framework. */
+	if (sc->rsupply)
+		ret = regulator_enable(sc->rsupply);
+
+	/* Do nothing with the GDSC itself */
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);

-- 
2.25.1


