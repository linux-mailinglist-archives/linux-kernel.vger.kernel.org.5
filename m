Return-Path: <linux-kernel+bounces-63269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E97852D17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F022282CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67CA39FE1;
	Tue, 13 Feb 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jjB0/Tk6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECE39FDA;
	Tue, 13 Feb 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817883; cv=none; b=t8hFjpcLfQ2mmK0f4G/MMdqL+mD/q8ySKPej/a75YJ0kj2bw35aN7FmAtuqMeel3JU8TREoZrTItgtjXkB3+QmP6ZLflt0AUz8awn6O+dhx4kzn8TH4zD4hRn0KASQw+aqaGZlTDbzw94dRsyL6DlDFOHXy2i7agfQHOoRAzscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817883; c=relaxed/simple;
	bh=9lRUh6+nf6rRUkRuDEgbxLNFISG29zSAHH9fpqqsAIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OFuv2vr9l/4OrFGJxJuY52A2bkTHFes109ByRs5VGPeBoQO+UxDKiT6VLTAkVP68F1rU5mw/5Sop38fMw30RmYy9mDzn1EcyZWV13iLWnWGxcjvv9jgt8Y5Tw+Rjx9OwQ5cvyjny5iiKRXd2ZUHngzUaGiJkcnPUtYI1jKQbpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jjB0/Tk6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D9VqQE029331;
	Tue, 13 Feb 2024 09:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bf69VGDVwFoPu6tmc5FcL69h7xGtSS3ikkJnZ40Cf78=; b=jj
	B0/Tk6G/5Qy0zNCmQZ7qXL51XM+xYlWvn0/nR1WYjOclvnnL8I91flDfdmGGg4V2
	3Ine9FtzkTjEGFEzXQ/rg06h6nUtpURlQeq8acvikzy7JrDHsrYryRoB3DooZogU
	FFyLQ/2hmXTOz5D35yDuw2oOHumvSShbVJfBLYyD7kBsApII7gCeiiLqrvxdQGcO
	lLlJGeF/pcpJNzaemIgRZv5axWU12GNUR6G8gCim36Cup+Cv3V8aElXbBVeqc5Wm
	pATsYrANOboq26jgltP7mfGeEn2UwXsB2H1Z5g/OtaDlCdwP1ohWUlitzNo35jBG
	t+Plh83Z7BmklnBQdEFQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju7abv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:51:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D9pHuZ031528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:51:17 GMT
Received: from [10.218.34.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 01:51:13 -0800
Message-ID: <6c7dc71c-9251-4c84-a134-82104b5f924e@quicinc.com>
Date: Tue, 13 Feb 2024 15:21:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
To: Mukesh Ojha <quic_mojha@quicinc.com>,
        Subbaraman Narayanamurthy
	<quic_subbaram@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
 <20240213035203.2492516-1-quic_subbaram@quicinc.com>
 <9ad7967f-0a6a-96ed-1433-832f76752059@quicinc.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <9ad7967f-0a6a-96ed-1433-832f76752059@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rVDi3cE8v9WeVVlNZehbWNcaF_IJ1OOi
X-Proofpoint-GUID: rVDi3cE8v9WeVVlNZehbWNcaF_IJ1OOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=732 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130076

Hi,

On 2/13/2024 11:24 AM, Mukesh Ojha wrote:
> 
> 
> On 2/13/2024 9:22 AM, Subbaraman Narayanamurthy wrote:
>> Hi Maulik,
>>
>>> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
>>> +{
>>
>> <snip>
>>
>>> +    if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
>>> +        && VRM_ADDR(addr1) == VRM_ADDR(addr2))
>>> +        return true;
>>> +    else if (addr1 == addr2)
>>> +        return true;
>>> +    else
>>> +        return false;
>>
>> Minor..it would be better if you modify it as following.
>>
>> +    if (addr1 == addr2)
>> +        return true;
>> +    else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
>> +        && VRM_ADDR(addr1) == VRM_ADDR(addr2))
>> +        return true;
>> +
>> +    return false;
> 
> Even better if it becomes one statement for true rest with
> false..

Thanks for the review.

I will fix in v4, will wait for sometime if there are any other comments 
to take care along with this.

Thanks,
Maulik


