Return-Path: <linux-kernel+bounces-156333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9F8B0157
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC191C22B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67730156880;
	Wed, 24 Apr 2024 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a1mNkCqv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54856139CEB;
	Wed, 24 Apr 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937876; cv=none; b=hoCxGY8AamYTqrn1ndSPMNhC4982Oag+xQ0HSE9uXfOZKA/b1LAtN3VlUv2juvDWVkZLuz4Q24MeyY76QszCiqPaNt3m5sGjy8KVMy5HsUkrge0EyFTcGuadsE+DNJpCDq8Pub6y2nCibXh5kPF2t190DVHeQisgLJ7291/sg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937876; c=relaxed/simple;
	bh=l2vWxvOw5UfkFOPYULi7WDW9p3pD3FL3o5F3q7jgeKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NfF0OdN4Z9cLEhzAZcOaULULsN6/fU5CT47M3VjHNBEib+3oBMiYqr1yhIVCy4Nuz0FkXwXhG7A895RNq9/ubYkKH1DVci4IM2AsZZWE2EL1+3Smddz05GnIXfe8JpfkrXTPN56SqswwxtZOQ9dqgSxcEv0HbnY8d++p/r7yzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a1mNkCqv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O5oRPD020478;
	Wed, 24 Apr 2024 05:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zPelWUZ4e8QErU4lsY21zWyZw6ld5HftWCm4DKBygrE=; b=a1
	mNkCqvHUScqb0UsKZVA6hlc8DuBpInO7TQBYjgg6bszWlYaLPiz+l094UrPPm7q8
	220m8/4T8DXWmSXG4/EFFIK8LAoWz0icmN0ByL64axdsFSBOATiDF+evCYEXr99e
	FxKEnc+goLXClWVhwhkADLnKMSzAUbKwI0KV3WZfrMCHd1wevDzcP2wrcuoiV7+I
	qC/KtDwGZBDVbhKXzTBU/vgjgGfcIFw2QSoeJcv7gxRstH7flLYxEXFq+Tp3Cs2/
	jqo1OFIsm/1J5yzKUhb3+KGwiSH4zIhH5sirvV1bIgpKaoRmiY+p8+GJb0w+n2gE
	0HsrCgDtZ7YW4UWZEi4g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pg01w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 05:51:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O5pALr007227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 05:51:10 GMT
Received: from [10.216.52.243] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 22:51:06 -0700
Message-ID: <a2b28091-2b9a-4a0d-9d98-6226a2dafd58@quicinc.com>
Date: Wed, 24 Apr 2024 11:21:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup
 node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_anupkulk@quicinc.com>
References: <20240416105059.1167-1-quic_vdadhani@quicinc.com>
 <CAA8EJprzdhDvmZdVXdHEJHpNA_Pj3=77v=y41EajFVe8LmAOnQ@mail.gmail.com>
 <CAA8EJpob60Kog7ppTO=LZuJgn5Z91dwqyZ845gX8UXwrOqvZjQ@mail.gmail.com>
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <CAA8EJpob60Kog7ppTO=LZuJgn5Z91dwqyZ845gX8UXwrOqvZjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jb1KpcqkyYA7y3QlMGAwlBU_-5fZEkSY
X-Proofpoint-ORIG-GUID: Jb1KpcqkyYA7y3QlMGAwlBU_-5fZEkSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_03,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=568 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240024



On 4/16/2024 6:04 PM, Dmitry Baryshkov wrote:
> On Tue, 16 Apr 2024 at 15:32, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Tue, 16 Apr 2024 at 13:51, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>>>
>>> Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
>>> busses usecase on RB3 platform.
>>>
>>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Well, actually:
> 
> Unreviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Please place the gpi_dmaN nodes where they belong rather than sticking
> them right before the qup nodes. The file should be sorted.
> 

Updated in v2.

