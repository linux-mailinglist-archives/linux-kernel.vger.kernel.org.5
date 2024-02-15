Return-Path: <linux-kernel+bounces-66238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C898558EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F2B228CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D604409;
	Thu, 15 Feb 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O6tI4cfT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904F184E;
	Thu, 15 Feb 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963144; cv=none; b=l9XWeLpfoBn8NE/ee9ZGaJ2DFzplqSjpFS3zZ+9R1D4sbbQKMPqTYIYoC2XVyO7hWEWcC8+/ScRBq9XeL7V2B/LfuTl0WFVHioGvfaZQfYezHk6NuYgJ3pGqAVNzWntxI3mhiwGzAbXXA/7fUk2lBghDan6oiGvv+YHThXqZ8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963144; c=relaxed/simple;
	bh=ewTPk57Oq+tWnySACn1qJU4IQLQWTno0sVk1wOLRR10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ipaH2dhfwWXc9MsB6knvLC5TdN20n/sm+d9tougQNfNo7nUwG77cT3hmY8F1n+miPFo1tJtBmIp7dqchaP7NZj9/rr+ZGJnjXGVzfstJJsk1QRndS3RklhAGgKxMpnOxjbmW1zh+UgzRkKYVGxDgCDDVqVYqTxg33Gf9DF62QT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O6tI4cfT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F2A2Op019521;
	Thu, 15 Feb 2024 02:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vNV6gUn87PAObdD1pIV9VlqS91LimTvXgPFC6zvbh2E=; b=O6
	tI4cfTD2XGQKJGitF5yPmLjTBumwRdzBblhixIKxkuakwippgsY2gK/6WLMUyKKJ
	uldxYHa+p9dIfs0yaJdaiOO0jMkWPQueiwmb6V2SU95gZ/L5L3Mv42C6Mtsg8Y5j
	MjY6g4UGOtNLHIPhhsKs+Uerdve0WceIEvgqaSVQJmSw60WkPm8SNYfifY1ogAik
	uvuloqhaZqe+XC4+CwOpl61gApVXeLM1NoUZmKlfiQVa+YImpFrCX30EtGe0iEzf
	s4S3gl50hVvGVxmAJlzvlsi0fjKdpPNsSWHHrV8t1P7hzJr5ZaFCDPXl/hGleUwo
	aznTCPRvMkIwXS44sO4A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8ennb573-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 02:12:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41F2C9Vn002548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 02:12:09 GMT
Received: from [10.253.12.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 18:12:06 -0800
Message-ID: <4a124dff-f92d-4f2e-a6bf-bd7ad75a08df@quicinc.com>
Date: Thu, 15 Feb 2024 10:12:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Rob Herring <robh@kernel.org>
CC: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Tao
 Zhang" <quic_taozha@quicinc.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
 <20240213222957.GA2502642-robh@kernel.org>
 <c70df5a6-20af-4cee-b147-5847751fa36b@arm.com>
 <CAL_JsqKdAzPEGh941S05kraTjOcEpsPCnDRkppNkb8pBCpZu6g@mail.gmail.com>
 <729a4c17-9e86-467f-85cf-652c503fa14e@arm.com>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <729a4c17-9e86-467f-85cf-652c503fa14e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e9G6bCh0f_EvdqNHgGIomNzYQTtaHin0
X-Proofpoint-ORIG-GUID: e9G6bCh0f_EvdqNHgGIomNzYQTtaHin0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150016


On 2/15/2024 12:18 AM, Suzuki K Poulose wrote:
> On 14/02/2024 16:03, Rob Herring wrote:
>> On Wed, Feb 14, 2024 at 9:56 AM Suzuki K Poulose 
>> <suzuki.poulose@arm.com> wrote:
>>>
>>> On 13/02/2024 22:29, Rob Herring wrote:
>>>> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>>>>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>>>>> bit.
>>>>
>>>> That may be, but this is an ABI and you are stuck with it. Unless, you
>>>> can justify why that doesn't matter. (IIRC, this is new, so maybe no
>>>> users yet?)
>>>
>>> This was added and support queued in v6.8. This change won't make it to
>>> v6.8 (given it has to go via two levels and is technically not a fix).
>>
>> I'd argue it is a fix. But given no users yet, delaying is fine.
>
> I agree it is a fix, but not something that maintainers would like to
> pull it during an rc cycle. As you said, since there are no real users
> for this yet (and given it is all under a single vendor), it may be fine
> to queue this if the DT maintainers are OK with this.
>
>
>>
>>> As James also pointed out, it doesn't matter what the name is (now that
>>> it has been published).
>>
>> v6.8 final is what we consider published.
>
> I can't send this to Greg as a fix. For v6.8. We can fix it for v6.9 
> cycle.
>
> Suzuki
>
Thanks all for the comments. I will update the commit message and fix 
the warning.

Thanks
Jinlong Mao

>>
>> Rob
>

