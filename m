Return-Path: <linux-kernel+bounces-19954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE601827752
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7781F23AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518454FB0;
	Mon,  8 Jan 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pqpNI8Rj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6454F9C;
	Mon,  8 Jan 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408IHepa024137;
	Mon, 8 Jan 2024 18:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=uHY3fQLsNHWDaKV+dXru0
	SBvr/s3dbPl29fFLxwGtjg=; b=pqpNI8Rjihhn5C/FPeVII7fBTbYbpwp9BkbEf
	B1v9CFO1Xl5uLWoR9Ulo7ijKPYf75Xa8OOBGMFdROFV5J3GBVG82JkJdmIpJi3rL
	KPjlELd95b5sJBojSZp0ClrQYEfdl8U+tfeXSwEsKo4/Wd4SYowsEkuehmILglCU
	Wo5I6G9TV5GGIwTuSD8aK74Q4UmeW4d1NGuX0eAKEdfbmWGq6UrqFoyCenTQq9zE
	+ejwKDOK9Ld6MAyNsWSQ+9WuoJyz1bw2aEz0ji74Qku0Dz6PoFlAlxae5/5gk8bH
	jRgGeUi3tfMcwX3uCwCHhZx1Ug86Bc6fkzyLvFsBJWqTMf45g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgfwjry3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 18:23:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408INApm012620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 18:23:10 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 10:23:09 -0800
Date: Mon, 8 Jan 2024 10:23:08 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 3/8] clk: qcom: gpucc-sc8280xp: Add external supply
 for GX gdsc
Message-ID: <20240108182308.GL1315173@hu-bjorande-lv.qualcomm.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-3-4763246b72c0@quicinc.com>
 <0d20be70-7db2-4d8b-aecb-5256a42ba62e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d20be70-7db2-4d8b-aecb-5256a42ba62e@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AWHDRG9Pdm-ZMgbxBVL6ZrxrNndmMuFG
X-Proofpoint-GUID: AWHDRG9Pdm-ZMgbxBVL6ZrxrNndmMuFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=778
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080154

On Wed, Dec 27, 2023 at 02:07:52AM +0100, Konrad Dybcio wrote:
> On 22.12.2023 05:39, Bjorn Andersson wrote:
> > On SA8295P and SA8540P the GFX rail is powered by a dedicated external
> > regulator, instead of the rpmh-controlled "gfx.lvl".
> > 
> > Define the "vdd-gfx" as the supply regulator for the GDSC, to cause the
> > gdsc logic to look for, and control, this external power supply.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> Worth noting the regulator framework will create a virtual supply
> for the normal 8280
> 

You're right. No functional harm, but that's not very nice.

I don't think we have any benefit from having a dummy supply, if the DT
author failed to provide a proper one, so it seems reasonable to switch
gdsc to devm_regulator_get_optional().

Regards,
Bjorn

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

