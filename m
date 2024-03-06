Return-Path: <linux-kernel+bounces-93506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DA8730CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C32B2204B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50985D8E7;
	Wed,  6 Mar 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E0K8AJR1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502B5D474;
	Wed,  6 Mar 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713985; cv=none; b=TGnNmGXrwohrAQq0iXDEUCTC/S/d7tEyiIn2xOFRbH2dZrtbDNCiS31TTLuEmSpUQdl7VIBSEtQRDwqev3TBnE9+eSxXG2ut/8uHnivRZSUFmIgr6YqMSYic9fzJqzKodhr8kuNisejGKz1GCNWGN5Y7+1w9FeZRaJKcCmLd3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713985; c=relaxed/simple;
	bh=UnIKCfpRywsmooXz+n9fMtoH0j9SzJw+eCtg2L2wY+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fSsL9ssLHTbh6IsR7IN/mC+gINnzk1bANDmCWwEOwOnGzmomfM1bbjWtrROjlMA9LK4GjrwSq503JhcSqnG516swQGGfo8PMGHGRb/t0f1fTMZ2I+hgTygS1xVCSARZeYslCz0FvFkSUHSoc1hgHVNn2gwTqVPR07l6L+ov0Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E0K8AJR1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4266eJpC005782;
	Wed, 6 Mar 2024 08:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UnIKCfpRywsmooXz+n9fMtoH0j9SzJw+eCtg2L2wY+k=; b=E0
	K8AJR1jP9x0GVqfJlanI4u24R/W9cCEMcR1sTj6FvajQ5mF/8r2eLfD30vwR+Ujy
	22g8wnfBBbhlQjlKK7esDLcjvrRd9+6A1U7kZ0DADfzyDcw700EqdtzVw9+vLU1/
	SOVDfL5Oln6e+BzSsb/bfcq9zjn1IqlxCvTSxKAR6+pAJd36AiLDEJZqru3P64Wg
	IaxSLbsxLEi6nlxagEPr5i0QA8XHbN6twWsiRuQFJwPSFfEYzJ1sIy68UsuEOUse
	EylN0R6bluvfsexLDTIXgP0vGCFuoi9o7Rd3EYU+kHLN9uxa8IMS9ai3pBUpnjC+
	VAYi9VIX9vONXgxR0Z0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpke387ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 08:32:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4268WPLn013366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 08:32:25 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 00:32:19 -0800
Message-ID: <e98bdda6-3da5-689c-f8fe-7f64131707a8@quicinc.com>
Date: Wed, 6 Mar 2024 14:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add camera clock controller for
 sm8150
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-5-8c28c6c87990@quicinc.com>
 <6620b011-933e-40cd-98e1-a4d39cc96346@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <6620b011-933e-40cd-98e1-a4d39cc96346@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O8eQnkyqs70RVInPJby50HT0ZqxhjcdH
X-Proofpoint-GUID: O8eQnkyqs70RVInPJby50HT0ZqxhjcdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=901 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060067


On 3/2/2024 9:45 PM, Bryan O'Donoghue wrote:
> On 29/02/2024 5:38 a.m., Satya Priya Kakitapalli wrote:
>> +            clocks = <&gcc GCC_CAMERA_AHB_CLK>, <&rpmhcc RPMH_CXO_CLK>;
>
> <&rpmhcc ..> should go on a separate line
>

Okay, I'll fix this in v2.


> ---
> bod

