Return-Path: <linux-kernel+bounces-140332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A398A12E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035001C216B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10202148306;
	Thu, 11 Apr 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o/VNHZV+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B113BC33;
	Thu, 11 Apr 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834633; cv=none; b=OZiBYcIpsJZs1G1xBTUnT9I/K+i7L/+Gt2TvDXVSIbPlvdPC1K9kWh7rsTq7IgcpfICJHy+L3vSv6wDWodW3Dc6uzK2wZwIthIZGBVMzOJKMPMYs5d7uoZPk0Tjl9E6ZLhVipbRX8EHamSFt+Roeq5VXFXmoqABAxTWsciTKRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834633; c=relaxed/simple;
	bh=Sw/8LCKgD4CWZon5IHvfbD8ji7b2G+eyIbQZeE+Po1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dspfQeILqiSt3bXQZngIz+I/b26Uo+F/zBCeAkhWZvp0t39UvA+JU4OSsyXzrcrqyZ7iJjmvIrgtx4GBD4ykZwk6fbuSC2Wdc7crOietrPupEEXxCJ7sT2dqSFPTV8sDeyQ12n+lNUXHqZAK+VeCjpRXDy8oWTnJZ0jOpDj7wvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o/VNHZV+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B8NXpX007621;
	Thu, 11 Apr 2024 11:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lBNpdyE9SdRnA12ZknqnrRm+EDCD9cxh+l5Im7UQVsg=; b=o/
	VNHZV+brOLJTR0sqQMshoRKcGD5ZSVTADK0WKgPrdqJJZY12aF37AET+Aobvu2uK
	QkLdTOWmDQ0vl9/hRrueUSSvEUB3/NKAWxY9vorTbYrHaqJ5M5AGe14umdv+pb5F
	nuX+URNr4KPKzdsVArIVCDtfhZ70ukR1H9adATRkQfUctGXwZbEXcTlJDwEnrTtd
	tI+ek0jTpVGG72kC0gG9gCfzwrlemt/zNzSUD6w6hTzrfRAGREOiF0s5A8/IS+yQ
	PQ50ubC3PA+vT15fMH8o0mbaa7iLEsN7gQ4ulviFXJOeh5RG5QU8vXyiYDnn+tHE
	E7Z9qiTWQ4o3SESIm8Mw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebq1rwpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:23:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BBNj41028492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:23:45 GMT
Received: from [10.216.18.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 04:23:42 -0700
Message-ID: <46c0d72d-d629-429b-94ec-d21f719db348@quicinc.com>
Date: Thu, 11 Apr 2024 16:53:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] clk: qcom: clk-rcg2: introduce support for
 multiple conf for same freq
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
 <a70e7219-5fd8-4797-be43-199f8995409b@quicinc.com>
 <5fc87d10b06f8b5b3024ac6c5674b18b.sboyd@kernel.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <5fc87d10b06f8b5b3024ac6c5674b18b.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mzOIeadyFYbzxdddQ0eRp0Lph8iZ0Lu8
X-Proofpoint-GUID: mzOIeadyFYbzxdddQ0eRp0Lph8iZ0Lu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110082



On 4/11/2024 10:31 AM, Stephen Boyd wrote:
> Quoting Kathiravan Thirumoorthy (2024-01-22 09:46:23)
>>
>>
>> On 12/21/2023 3:47 AM, Christian Marangi wrote:
>>> This small series fix a current problem with ipq8074 where the 2 uniphy
>>> port doesn't work in some corner case with some clk configuration. The
>>> port to correctly work require a specific frequency, using the wrong one
>>> results in the port not transmitting data.
>>>
>>> With the current code with a requested freq of 125MHz, the frequency is
>>> set to 105MHz. This is caused by the fact that there are 2 different
>>> configuration to set 125MHz and it's always selected the first one that
>>> results in 105MHz.
>>>
>>> In the original QSDK code, the frequency configuration selection is
>>> different and the CEIL FLOOR logic is not present. Instead it's used a
>>> BEST approach where the frequency table is checked and then it's checked
>>> if there are duplicate entry.
>>>
>>> This proposed implementation is more specific and introduce an entire new
>>> set of ops and a specific freq table to support this special configuration.
>>>
>>> A union is introduced in rcg2 struct to not duplicate the struct.
>>> A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
>>> of frequency table.
>>>
>>
>>
>> Bjorn / Stephen Boyd,
>>
>> I would like to know if there are any comments on this series. To enable
>> the clocks required for the Ethernet interfaces on the IPQ platforms,
>> these patches are needed. If no concerns, can this be picked up for v6.9?
>>
> 
> I'm fine if Bjorn wants to pick it up.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>


Thanks Stephen. Bjorn, can this series picked up for v6.10, if no 
concerns from your side?

Thanks,
Kathiravan.

