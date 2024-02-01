Return-Path: <linux-kernel+bounces-47922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7D8454B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1860F287427
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5E15B969;
	Thu,  1 Feb 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fLfpZRTS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4F4DA19;
	Thu,  1 Feb 2024 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781601; cv=none; b=uFYN02pONOp6wWMkwYSkuNz96LjpN7+6LMNEdoWGtbw7SYcuW6MWep/jBECB3Nvkv4K9FXnWEwBTaldHEcNpsY0iiIUQSpjw1yK5HFuCw1IBPgJ2Zp1qOrGzM5erWG2YXI5xF6fa7aEl3hFOzHVmbDZoMSEnS1TqxHuzhye86jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781601; c=relaxed/simple;
	bh=MMcoYgAB2ObHPsGOhaFR/VarWNf9nlQOm0soMsGMKs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XdD+lV++i1lpMkx39t1DdhTWNQsi7rV7YoF9U9yxSr/beGzH1EUzhjI76aA4VMv6Ty96YyV8q8PuNVqB68FMYhQ1diORksEjni8bjS+rYmf0hHwIbjrRQoQlhNxwzTX0FjzPk6EMlZVHIxYf1ntitqo5YMEGdhokQhwOCjU/bGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fLfpZRTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4116Q4P3017276;
	Thu, 1 Feb 2024 09:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d/00M8Lg8HizPWB0AUqNUF9SIyclE0Lad3IoN8XDVEY=; b=fL
	fpZRTSoiXw2uIGpnIRe1xrtx2fZGfrooXtvm1yD9YAm12k14EyNuDsxtgzdD3Ptb
	okIQek/5Eo2UPr2oY8mRYZqY9oT0KfDoSzE+/T4XC4jUqrKcWo0uS+kDyeJ79jAr
	05rNnuEJpVYzvUJM4Qc03dxWP9MgLY4n9tPQVnpyQO9QCi6cAz7cBv5ppgwPjeBN
	KtaYJZyeN/L3eWwI8MpG1oquGRYfJ7JqWXHpfQ3mntjc551rwgrLmyKipTbSF16v
	y0/vdS8u1ap4I7xdXP8ABA3AAn/jjkZlCuFGgXo6XXvL/AT7TAes8bIAGabZvl9C
	WoXhbOrVm2vKPuhF6ZjA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0619gkma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 09:55:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4119tU2P003675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 09:55:30 GMT
Received: from [10.218.47.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 01:55:20 -0800
Message-ID: <a0bcca80-e91b-4b97-a548-b53ea2fe4cb5@quicinc.com>
Date: Thu, 1 Feb 2024 15:25:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] arm64: dts: qcom: sm8550: add hwkm support to
 ufs ice
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Gaurav Kashyap
	<quic_gaurkash@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-16-quic_gaurkash@quicinc.com>
 <CAA8EJpr5fLYR1v64-DtjOigkUy3579tx_gwHpFWr9k0GyGajGw@mail.gmail.com>
Content-Language: en-US
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <CAA8EJpr5fLYR1v64-DtjOigkUy3579tx_gwHpFWr9k0GyGajGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iH40zl2IaJawsG1TZcdGaShFIfYH7kZ-
X-Proofpoint-ORIG-GUID: iH40zl2IaJawsG1TZcdGaShFIfYH7kZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=643 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010079



On 1/28/2024 6:31 AM, Dmitry Baryshkov wrote:
> On Sun, 28 Jan 2024 at 01:28, Gaurav Kashyap <quic_gaurkash@quicinc.com> wrote:
>>
>> The Inline Crypto Engine (ICE) for UFS/EMMC supports the
>> Hardware Key Manager (HWKM) to securely manage storage
>> keys. Enable using this hardware on sm8550.
>>
>> This requires two changes:
>> 1. Register size increase: HWKM is an additional piece of hardware
>>     sitting alongside ICE, and extends the old ICE's register space.
>> 2. Explicitly tell the ICE driver to use HWKM with ICE so that
>>     wrapped keys are used in sm8550.
>>
>> NOTE: Although wrapped keys cannot be independently generated and
>> tested on this platform using generate, prepare and import key calls,
>> there are non-kernel paths to create wrapped keys, and still use the
>> kernel to program them into ICE. Hence, enabling wrapped key support
>> on sm8550 too.
>>
>> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index ee1ba5a8c8fc..b5b41d0a544c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -1977,7 +1977,8 @@ ufs_mem_hc: ufs@1d84000 {
>>                  ice: crypto@1d88000 {
>>                          compatible = "qcom,sm8550-inline-crypto-engine",
>>                                       "qcom,inline-crypto-engine";
>> -                       reg = <0 0x01d88000 0 0x8000>;
>> +                       reg = <0 0x01d88000 0 0x10000>;
> 
> Does the driver fail gracefully with the old DT size? At least it
> should not crash.
When adding  qcom,ice-use-hwkm property, DT size needs to be updated.
Without any DT change, there will be know issue.

> 
>> +                       qcom,ice-use-hwkm;
>>                          clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> 

