Return-Path: <linux-kernel+bounces-57473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629784D981
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B61C23097
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCE67A0F;
	Thu,  8 Feb 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Px45P5S3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361D67A07;
	Thu,  8 Feb 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707369534; cv=none; b=kq25GMA1fFskls56hzsZytki6i3eNIvb8+27ZTE3A8HOszIy4iEoekkOor6DYFHInlQwKPkvF4TVNM05ALxXqF08oMETaJEYYCJXauTkhWnhXz7LNLgvds3gRJbCLbb/9AxfCahztWVOtj88kiWC3ONWvL1tTCgoy+ewTS7cXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707369534; c=relaxed/simple;
	bh=iivgMn/eZNoH9LLlfm9hxbr5iUHDmqmWjt66U1kf5qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ONcuz7TpCN0Iof4aLd/OmXtmQAjhetgApjkp1sZAEjSK2cmFBJ4u0NpUn+IARx17Dud70zss/jNvLhY4F9LJ//miOcJVZaBW69UNyge7giMAIgVBtMBn1h1UTIRFR6KzeaIad13e7TegBVYwd7bsxesc0ev71JvCokfWDGpjprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Px45P5S3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4183s3oa031299;
	Thu, 8 Feb 2024 05:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iivgMn/eZNoH9LLlfm9hxbr5iUHDmqmWjt66U1kf5qE=; b=Px
	45P5S3WXfrsEN4qDVQvkopGMe3KpSmiqelSlVz2XcrQiujk0Qvk+FK5cQ41YDk9e
	C/2tJCdZoefgIZUcbhEE8KONRPtGBh5T+iQEmm7eSr7ol388jfnmauQoWu1sneSl
	yZHp/sY+oXlxTJ0hq/MtG8gtKNPbF9JMTsro7ZJb3JRAs31UgbmgZrVF6R0PhsU/
	hB8sXZ431C2D4pW9ued8URwuby8TdQNx4NAw7ex3G9wBZHx4bRbA1fsPkktZWQZn
	+2aEO9+CEvF/5Dd/ceBvJMMznxO09Yj+epf6VBmXYcRRojbks/CBd2oqxIajPflj
	/G40K8fivBbXqvhLrAqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4pavg84h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 05:18:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4185IlYq024107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 05:18:47 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 21:18:42 -0800
Message-ID: <69250065-2168-0159-2ef9-986716d3adf8@quicinc.com>
Date: Thu, 8 Feb 2024 10:48:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
 <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
 <d31a52fc-9073-483d-b84b-1f02a5698a89@linaro.org>
 <77903574-696b-90f9-f136-be5c5d219ba1@quicinc.com>
 <5ae84692-b05d-4a43-aabb-4d2e7d9926d5@linaro.org>
 <04788b2c-a212-b8a2-1124-d904f2f61f5d@quicinc.com>
 <6fdde54e-12cb-442c-9dea-d1d6cbca340b@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <6fdde54e-12cb-442c-9dea-d1d6cbca340b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4TrP1OWOFRi7t024bkfVVs_bzsyXq1wC
X-Proofpoint-GUID: 4TrP1OWOFRi7t024bkfVVs_bzsyXq1wC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080025


On 2/5/2024 5:03 PM, Konrad Dybcio wrote:
> On 5.02.2024 09:37, Satya Priya Kakitapalli (Temp) wrote:
>> On 1/25/2024 3:25 PM, Konrad Dybcio wrote:
>>>
>>> On 1/25/24 06:49, Satya Priya Kakitapalli (Temp) wrote:
>>>> On 1/23/2024 11:17 PM, Konrad Dybcio wrote:
>>>>>
>>>>> On 1/23/24 17:34, Satya Priya Kakitapalli wrote:
>>>>>> Add active_only support for gcc_parents_0, this is needed because
>>>>>> some of the clocks under it are critical which would vote on xo
>>>>>> blocking the suspend.
>>>>>>
>>>>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>>>>> ---
>>>>> Is there a need to keep gcc_cpuss_ahb_clk_src around? Do we do any
>>>>> ratesetting on it? Should we ever turn it off?
>>>>>
>>>> The branch clocks under gcc_cpuss_ahb_clk_src are critical clocks, which are running at 19.2Mhz causing vote on XO during suspend. As of now no rate setting is happening but this rcg is useful to get the exact rates from debugfs. Hence this change is needed to avoid XO shutdown issues.
>>> So, if I underderstood you correctly, this clock serves no purpose other
>>> than getting rate?
>>>
>>> In this case, I'd say we should de-register it from the clock driver and
>>> use debugcc [1] (contributions welcome!) for precise measurements.
>>>
>> Although currently there is no rate-setting happening now, its better to keep the rcg modelling as is, considering that it might be needed if some use case arises in future.
> We don't tend to solve imaginary problems, please lay out what it would be
> used for, if at all. Then, we can assess whether it's necessary.


Okay, I'll de-register this RCG.


