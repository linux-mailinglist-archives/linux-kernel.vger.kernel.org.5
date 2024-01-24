Return-Path: <linux-kernel+bounces-36422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156F83A08D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD89328A777
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD4417550;
	Wed, 24 Jan 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hcAtaGu7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA8BE5C;
	Wed, 24 Jan 2024 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070331; cv=none; b=fVbsxE+BvrFmsOkF4qf0BIlxDqYHaSN6BWokuxpWQmOWfVo0AKzO/RRdOAUfrlmOPPTAF7yBkmqJGIoqOB4fncj4pEm5LEKYBLNhd1OryTjSA6uV5hLcdKrsFkVv+9h7+iYWMXIO8vAya3Xo8/vHIZIhuh7r8bOE3z+oFmEssds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070331; c=relaxed/simple;
	bh=XqG6SvzlCntF+3+Nx+hVAQgPWgQW/RVb0t9LmLHIY+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N71KdW/6p/EP2s/e/CrJQJcZ6v/uUHN3Lysf9oEuspjQT/ZOFJ+fV7JW+brVRHBGwvD+iEfMPgCSoBpJjl5QTcDZ277FpcB9dJ5GqUSLdov+gQQvUEhKqvliDx5xKBGcTCDpvyFYNk2XnlvIVsAxKHk+/MR64l4Us7Er7Uvyev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hcAtaGu7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O42p5b021218;
	Wed, 24 Jan 2024 04:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ZMlir0J/FxMSwVAPbsGBDxQdkacIBRKuJrcSmKp/nJU
	=; b=hcAtaGu7xPMOdNsugv4yr65TR1Rk69wCBf6xIXiDJQtxodA5wYvF2dzaHhG
	G2gkmKdlxcVEF7QsrfSCtClw752yFPMhwVfgAiA/vwziuBchqTUOAOyfKZJhSuWb
	NpSxqDAmgTJ8BAEYVNfmOux2Dica+SEAoSr+YFDe3SVAYPR8JTZBQdK657vU9xD7
	uR4gEW9Aira8VJQ8R++kK0w2AGbHckZzgrBz4/ucV/0ISQRa66CdjsXC3UfXqv+X
	xvdLfhJRGdUmuqZHchxKFVI9nRFMhDjHkvszQn2cN+7HIS4ISkd0zW3ul+IFZlY5
	gaUMDybmTdh6mg2T11kwzSCUK7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgxgr0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PHLf030418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 20:25:17 -0800
Subject: [PATCH v3 3/8] clk: qcom: gpucc-sc8280xp: Add external supply for
 GX gdsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-sa8295p-gpu-v3-3-d5b4474c8f33@quicinc.com>
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
 Andersson" <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070315; l=958;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=XqG6SvzlCntF+3+Nx+hVAQgPWgQW/RVb0t9LmLHIY+4=;
 b=u4/AFoCpUVtO52XXos7nssA9jQBvn0vVle4wsFjFGjHCC0NTzxl66RkzwrPkTon6cz3cOp0Y/
 QZ/I0BI386GBBVjOsWJSl22so0HkfV6iA+i3CPF8KTdPmUNwLqbShqM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GZO3L0p5uXCgM4yiguc_zP8Xyzo5xffP
X-Proofpoint-GUID: GZO3L0p5uXCgM4yiguc_zP8Xyzo5xffP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=998 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

On SA8295P and SA8540P the GFX rail is powered by a dedicated external
regulator, instead of the rpmh-controlled "gfx.lvl".

Define the "vdd-gfx" as the supply regulator for the GDSC, to cause the
gdsc logic to look for, and control, this external power supply.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..e2b3bc000c71 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -399,6 +399,7 @@ static struct gdsc gx_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
+	.supply = "vdd-gfx",
 };
 
 static struct gdsc *gpu_cc_sc8280xp_gdscs[] = {

-- 
2.25.1


