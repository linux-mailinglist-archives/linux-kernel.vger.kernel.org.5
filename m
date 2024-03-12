Return-Path: <linux-kernel+bounces-100198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAE87936C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041501F22633
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78C79DCD;
	Tue, 12 Mar 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GH56+UCn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557B79B98;
	Tue, 12 Mar 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244668; cv=none; b=O55A/LkpzdZusg6hmlqCel7jT7q0UZDWe51Fw5AtgsloM441EPQN06rrcYInk8yeyPPrja7FPzusI/d7AOjE3JuJD/5mNdl96HnOCoXmhroMwvRYPVDIEYgJZIVhrmit0T1/COLz3ChvGrw1KRxE37hT1ZnbZrqn3FpgGJov0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244668; c=relaxed/simple;
	bh=+t8UEzwjg1gh9MQTmugwtHkRz7qico7Re1/u3PLM6z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MwsXIgrXofqgc9HxZQHC5qOdyC5HYxnFJpJASU7Oxp1N3EBTU4Y2wfREsTNBlHau3qE/JSczR4sgXUUhIzvftSiTe1yeRFCEO6FlC60lwZf0VkzISL/tvYbvv2dO5QyHIuPSLGGt9MqfKEpbQDZr2NDXQWIDa4XIZrzrvjmmxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GH56+UCn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C6MQb7019699;
	Tue, 12 Mar 2024 11:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=whJgnMZzCKzVfkvwi9z1YK1I831EqEvbrV4/D7c8Jj0=; b=GH
	56+UCny1g1lHJgmLejDRY1CNehYX+JtfMRNujri37NSrZ+A2/KBZ3ZfHehqU1lE0
	1GJ3nKO9vyo0knsbBppSxIz89R/5b0ashBg7T9/4PT4LeIzGt5lSs0rjYOGZsDcW
	8/+93MIyKvfONEExx49wAUc9D8fFD3PLKCXRt454Y/PPFGsq7UGa48PDo70Dro44
	br0/AbsnrIleMiUQEUoMiw17Q7xo5EOKAnPPC18sH4m0Mwb6sla2kTiXLOwIXufm
	ItPxCydpKsVXtk8OAT9Xgsl9dwm/zGok7NhBiduovhx9OaQ+1eb6pGCTg517eEv5
	8faKJMwvoKHiHwahBrIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wthqfrmbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 11:57:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CBvdrx022098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 11:57:39 GMT
Received: from [10.251.45.43] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 04:57:36 -0700
Message-ID: <3c4199fe-c2b8-444c-9910-606cfa9f0c4e@quicinc.com>
Date: Tue, 12 Mar 2024 13:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Move camss version related defs in to resources
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
 <5800231f-633d-44f1-a056-58f87f1d5c67@linaro.org>
 <65accffc-e9ec-49c4-867a-6fd51a44f1c7@linaro.org>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)" <quic_grosikop@quicinc.com>
In-Reply-To: <65accffc-e9ec-49c4-867a-6fd51a44f1c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: srQiL_-4eHmowWTurOCPRsYgVK6Q7Vyd
X-Proofpoint-ORIG-GUID: srQiL_-4eHmowWTurOCPRsYgVK6Q7Vyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=771 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120092

Hi Bryan,

On 3/11/2024 6:23 PM, Bryan O'Donoghue wrote:
> On 11/03/2024 16:22, Bryan O'Donoghue wrote:
>> On 27/02/2024 12:24, Gjorgji Rosikopulos wrote:
>>> The different resources required for different camss versions are
>>> split in to two groups:
>>
>> Pardon me for not getting back to you on this earlier.
>>
>> Would appreciate if you could post this series rebased on sc8280xp
>> patches which are @ v6 and ready for merge already.
>>
>> I will find time this week to test your patches on rb3, rb5 and x13s
>> with the SoftISP patches on libcamera.
>>
>> ---
>> bod
>>
> 
> These patches
> 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/sc8280xp-v6.8-rc4-camss?ref_type=heads

Thanks i will re-base and post the patches on top of sc8280xp.

~Gjorgji

