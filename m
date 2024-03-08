Return-Path: <linux-kernel+bounces-97016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700A876472
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B0728350D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56301AACA;
	Fri,  8 Mar 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BsOhAUd8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED11401F;
	Fri,  8 Mar 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901657; cv=none; b=F119plIxYpgOXgYGHBEx12vzl6aZcjOj8EMZkX5NlFDdArn5VwD1bxrXLpS98X1zKcqixBYlkK+XMGrqeCZBTsDVanbOq86/Wj6wGcMvrLXAytj7LJIqP62OHHAGWEpEG4ReHi2ZmhO5IQM963RMNM+G5uAZk3n0TGw9kguu1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901657; c=relaxed/simple;
	bh=TXQf43677jxUXlB4nvGLV0dNq6iBGC44IlQLToNFB3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WE5g4/uP9Bb4qp8KIh/qSlRdCFl28XXZCZiHkZT3oQervv4jHTt50bfl2ZBY4GnYPDq6ShdeHRXPhTcL2ynygCEHu7qs7leSMXNcMh8Rx1fGNWUZ3ZY60tQL2Zd2TqGKUUClVhKtDYYWAsaOzXL+vBU0UXLC6HLLOP6ZaykR7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BsOhAUd8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428CcZ1F014971;
	Fri, 8 Mar 2024 12:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Sq/Zwrv+WazCGKEBJzRevR1V5zj7d0L8M5WVZMEXUkc=; b=Bs
	OhAUd8tAczaLhHnCnsNKjPHPfPvmN39vbv2CCVie2Vqd4qHTOjsQcJ+MLUIraCMR
	jx9DvWzkLp9pavQVVn9XMEytclP6ciWZouSSExTN5pYCUsWhLbr8rLP7fTMBsZaO
	qdBVWECkm6vwnDXcgVaNWdSq45DdL8/jymbHjA1ocCbqJUVsc9RD+DrpXFt8AF9/
	dwF5bHB0AAbx8q8tSPVGzkPhAlPI87z4/cjWoNwDVltmzzej6ICqOz/CnF9Aybai
	pEb8BtnEFrl+pMgul49uY5cE+JI1ZrEIKJWFUx8gg6/EscDT+niPwqNrjJLzfo2E
	s1VgLt+opQhYYG70WVqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr2v28035-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:40:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428CeMgG005063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 12:40:22 GMT
Received: from [10.216.7.18] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 04:40:17 -0800
Message-ID: <c892f773-7716-4736-3499-5c8254e3618e@quicinc.com>
Date: Fri, 8 Mar 2024 18:10:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for
 SM8150
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
 <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
 <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
 <83fd1995-a06e-b76a-d91b-de1c1a6ab0ea@quicinc.com>
 <4817a5b0-5407-4437-b94a-fc8a1bfcd25d@linaro.org>
 <e2627a99-307f-1e10-abfd-ce688cc2ec03@quicinc.com>
 <d893e8f8-66a7-4460-9468-0f3a359cece7@linaro.org>
 <35a7ad40-aaf4-476e-8582-b83bac284881@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <35a7ad40-aaf4-476e-8582-b83bac284881@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gj0eWI-wLGhCwWHvz_uph5XFsLxreoND
X-Proofpoint-ORIG-GUID: gj0eWI-wLGhCwWHvz_uph5XFsLxreoND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=856 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080101


On 3/8/2024 4:29 PM, Bryan O'Donoghue wrote:
> On 08/03/2024 10:58, Bryan O'Donoghue wrote:
>> On 08/03/2024 10:46, Satya Priya Kakitapalli (Temp) wrote:
>>>>
>>>> Not if you mark it critical
>>>>
>>>
>>> Marking the clock as critical keeps the associated power domain 
>>> always-on which impacts power. For this reason we are not using 
>>> CLK_IS_CRITICAL and instead making them always on from probe.
>>
>> How does the clock do anything _useful_ if the power-domain gets 
>> switched off ?
>>
>> ---
>> bod
>
> i.e. the clock can't be running "always-on" if it has no power..
>

If BIT(0) is set from probe, during any active usecase, the clock gets 
turned ON automatically when the power domain is turned ON.

But when we use CLK_IS_CRITICAL flag, the framework keeps the power 
domain ON and doesn't let the power domain to turn off even when there 
is no active usecase.



