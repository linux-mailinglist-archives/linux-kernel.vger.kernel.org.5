Return-Path: <linux-kernel+bounces-48097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869F84572B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACFE1C24932
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64B15DBAB;
	Thu,  1 Feb 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="os6lLrQH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C015D5AC;
	Thu,  1 Feb 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789782; cv=none; b=Y6NF7KkRVH+2yyM0mUsLXD/FWpXelHOtsqJGCPQTuWLPXmPZSIa/FldRV/qlCVZfpzvVue98B8xfXkfSmraSP33Rvt9IwNAmbjUw5vMEraOPvwyhTH3PTwYauZFT5gPOthXotZoEdhmvR9CXJCz1fpO3c0wIq6wUqiKvTKfHlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789782; c=relaxed/simple;
	bh=TSzIbTeOrk6MinK0jK9UY4K2VHCBEWaWMO4AazYPk5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UIdFhD0HN3S46PhjLL3Pgp8HLgjwoi9ApxZWn2YF4dw5d6znu9c2xphDKKVNF2hBuML/Yl1D1/qbuLQQBbUZoHWx0crIZlJpDPgKbPe3rxLouurPP54GPHZ1S+piIWw9/Yg9mjQncOnUr4g2Skl5O0l/53/4TgA2BFI/RHUdbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=os6lLrQH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411A5sFi022240;
	Thu, 1 Feb 2024 12:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YBhryowGq7ORWcrXKD22IGklJiK+Oa541dbapXH3IfA=; b=os
	6lLrQHi72rQGEFh4e00KPYyuUmbdd/eVtKpB2egKkBlO/i9byH/YxIMMg/0Ugl93
	iP+2KMU2svJEQhnjjjEN1jMmh9JA++F7PTWXwXW6kzxt11RdisdVwIPOIbt/PrHN
	H3qwZtAwNmeynTnGFYaeGIWBiLzfStQDf4WVLSRNs9i52fESXsOaLx/h6vXePPRG
	ZEWAhglZAv+7zPQG1IZK9pt571rLvFV7kLR/1zbQQtZlgIMkcW/eabZx/WT7i0TE
	XXDOMLhapPIN/gz6Nz1Ip6MWgwD8yw7e17u6/OkuF2OUpdkkUAaFOlNnBP+AM44A
	Wg2FXwWfENHcvnCfpSyg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w098c08dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 12:16:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411CGGBt028037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 12:16:16 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 04:16:10 -0800
Message-ID: <012bb387-2472-4bcb-ba87-3bf75dd88d64@quicinc.com>
Date: Thu, 1 Feb 2024 20:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Qiang Yu
	<quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
 <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
 <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
 <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
 <3e3cbc36-2f3f-4295-9325-90757f0d77ce@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <3e3cbc36-2f3f-4295-9325-90757f0d77ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KsnaJU3JSL86mUpeS5GG0EXpM-B1cu7H
X-Proofpoint-GUID: KsnaJU3JSL86mUpeS5GG0EXpM-B1cu7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=482
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010098



On 2/1/2024 8:03 PM, Krzysztof Kozlowski wrote:
> On 01/02/2024 12:49, Tengfei Fan wrote:
>>>>> This should be probably TX SWR_INPUT1.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> I will double check this with related team and I will update this.
>>>>
>>>
>>> I will apply "TX SWR_INPUT1" on audio-routing node in the next patch
>>> series.
>>>
>>
>> This patch series has been sent for nearly two weeks. do you think it is
>> better to modify the patch series acording to the current comments and
>> submit a new patch series, or continue to wait for your review comments
>> on the current path series?
> 
> Hi,
> 
> Whom do you ask?
> 
> Best regards,
> Krzysztof
> 

Sorry Krzysztof, can you give sone guidance on whether I should update 
patch and submit a new patch series, or do you need time to review 
current patch series?


-- 
Thx and BRs,
Tengfei Fan

