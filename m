Return-Path: <linux-kernel+bounces-4512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754E817EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB511F241F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546DA42;
	Tue, 19 Dec 2023 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n4gcTTj5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD69387;
	Tue, 19 Dec 2023 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BINlqaQ010864;
	Tue, 19 Dec 2023 00:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dGXSqUx9e0/zV1axVohzeeNVwd6d8r2agKMGrqkSKyM=; b=n4
	gcTTj5Vlc6L39T6Ms9D8eSRtYV2x4fSlDpJQ8quPX2dspeekRmWCNy5X3QIoIH0n
	pzUoabugakx/R1pBigJbCh5/JxSYEDUzDcEQcVfeY2DIoM8zV+k0qtY+jBdAOgqd
	NzUnt3ILSz8vT8JmkXfTqwtz1v1jqJlMnBbcrHSVNz2OXrLScv/vH9/FqpqeYHI4
	j6V4buStE3Srtg2w3LUDfPXukdBSZJvop/wMAekjlsPlP+L21mGpM8pmQkkRkW8f
	R4JyyPO7c93n8XtWsqh6wZPvPo/aYlK1cXVU80rJ7IZAXkJDwOOH2+1WpxFrMRuR
	ywvFYUqY7re+bBQ88QXA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2vhrge8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:14:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0EkeD019235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:14:46 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 16:14:41 -0800
Message-ID: <cdde7597-2c1c-4570-a604-91b87eef9455@quicinc.com>
Date: Tue, 19 Dec 2023 08:14:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: Add support for CMB element size
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio
	<konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-2-git-send-email-quic_taozha@quicinc.com>
 <270d759f-74b3-42f0-96ec-f97bee7116b8@linaro.org>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <270d759f-74b3-42f0-96ec-f97bee7116b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ddVfqoYWTLaRBv0Pas59xQ8gSFcofQzn
X-Proofpoint-GUID: ddVfqoYWTLaRBv0Pas59xQ8gSFcofQzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxlogscore=724
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190000


On 11/21/2023 3:24 PM, Krzysztof Kozlowski wrote:
> On 21/11/2023 03:24, Tao Zhang wrote:
>> Add property "qcom,cmb-elem-size" to support CMB(Continuous
>> Multi-Bit) element for TPDM. The associated aggregator will read
>> this size before it is enabled. CMB element size currently only
>> supports 32-bit and 64-bit.
>
>>     qcom,dsb-msrs-num:
>>       description:
>>         Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
>> @@ -110,4 +119,23 @@ examples:
>>         };
>>       };
>>   
>> +    tpdm@6c29000 {
>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +      reg = <0x06c29000 0x1000>;
>> +      reg-names = "tpdm-base";
>> +
>> +      qcom,cmb-element-size = /bits/ 8 <64>;
> One new property usually does not justify new example. Why it cannot be
> added to existing example?

Because the existing example tpdm "tpdm@684c000" which only supports dsb 
sub-unit.  Most

TPDMs only support one type of sub-unit.

>
> Anyway, I prefer not to take any new Qualcomm Coresight bindings or
> Qualcomm SoC DTS nodes with Coresight till we fix all existing warnings.
> I don't know how to fix them, so I need help with them. No such fixing
> happened so far from Qcom, so pushback is my only way to get any attention.
>
> I already commented on this in other email thread.

Jinlong has fixed the warnings from coresight bindings. I will prepare 
my next patch

series soon.


Best,

Tao

>
> Best regards,
> Krzysztof
>

