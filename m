Return-Path: <linux-kernel+bounces-4819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C88818270
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71702869A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E3C2C2;
	Tue, 19 Dec 2023 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fTBXd50U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB3134A8;
	Tue, 19 Dec 2023 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ6K8LY014275;
	Tue, 19 Dec 2023 07:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yp6RWtDoV2j3b8mxLghDZOl3JyvNPA3+RXwJY4lD/Ro=; b=fT
	BXd50U3DQYl/zrS2hVhvxdUuSq0kN+GgREdhdzOVpYjX4lrFuCD0uiAv9XJ8q2O6
	xw7pCfmkGWYUkqwvspJwXf98vg8m8pepFcX29tRIMvewzqZy+lTBzUMK5rv/hAq9
	yyTEBtUfJsa0f/gUJKs/yw53FVCA3XaaIsdIR2AzjxMWJQCmIRaovZn+ggTrf8oX
	z9GKh4ALwl1mJNfJEa+WtaGUi8LymBjI+OqSPOSGet0VExdZRU5hcFCbNKqHzrJG
	AJdsvlbLkPVML3SttwK/cgnFiDfFU51RC3HQd1T7Olx/fA97B0Z2DIF6ZA4Njjj0
	01htM59Npl03a7n2fWeQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tm86x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 07:42:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ7gQXS030665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 07:42:26 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 23:42:16 -0800
Message-ID: <ff46b1a7-36ec-4ebd-9f48-2a5ae50a3180@quicinc.com>
Date: Tue, 19 Dec 2023 15:42:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5Hal6jKyqJjgE_HTFxl0WKdAskbp7D0B
X-Proofpoint-ORIG-GUID: 5Hal6jKyqJjgE_HTFxl0WKdAskbp7D0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=556
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190055



在 12/19/2023 3:17 PM, Krzysztof Kozlowski 写道:
> On 19/12/2023 01:31, Tengfei Fan wrote:
>> The address/size-cells in mdss_dsi1 node have not ranges and child also
>> have not reg, then this leads to dtc W=1 warnings:
> 
> I cannot parse it. Address/size cells never have ranges or children.
> They cannot have. These are uint32 properties.
> 
>>
>>    sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>      unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> 
> I disagreed with the patch before. You resubmit it without really
> addressing my concerns.
> 
> I am not sure if this is correct fix and I want to fix all of such
> errors (there are multiple of them) in the same way. Feel free to
> propose common solution based on arguments.
> 
> I don't really want to NAKit but since you are resending without
> finishing the discussion, which is quite impolite, then let's be like that:
> 
> NAK
Hi Krzysztof,
Have sent this patch series before finding your latest comments in the 
previous patch series.
I sincerely apologize to you! This is my fault, please ignore this patch 
series before solve your concerns.
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

