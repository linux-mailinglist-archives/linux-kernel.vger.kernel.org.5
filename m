Return-Path: <linux-kernel+bounces-46957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A28446E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53AB28DAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E181339B4;
	Wed, 31 Jan 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pko4Vmzm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3612FF7A;
	Wed, 31 Jan 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724611; cv=none; b=BZBlsWuRDpKc4dr6K46MsHYyzhAnBjKfEiJ+K6gU3BeTGY8HTLnf5hNiIaM+s/xPc9G4QhM2u2iuUt0y5AyeBAD52yL+bNmOHjoJQxeXyZGSxrVkopY6mEejt5cscsfVJ2WMJ6+NltRjqAbLkfDZUEO8HwcNQGC8GeCExPd9q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724611; c=relaxed/simple;
	bh=IgVxSdA6UejGJQUV3K09v14DNp71/yDWI/ktI4EBOp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tnEwjvB8/VKl0QV98oxBky8kgjPm63JalZUEk9+pRwObYtPtLRYc+GAfwl+4QgAclSij77xPVRF/lWoR0Oa13heik0VgJe+VqIFnKxttKr1ZTUVRgFaMsTNACHL5lfOXGJ1Oc86CkVMhIWxQLfQRxz3qSxVyL6WWpgjcNwt0FG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pko4Vmzm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VHmbK3002795;
	Wed, 31 Jan 2024 18:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fVqh++2apwc/aSahkYZMFZdFH2hOC+/mSzUKyfXrQJs=; b=pk
	o4Vmzmsg2DCJis5iDzMbIw/AcphzCMFhj5OHajI0PnX8/jbEiOuodztsIeE/onyq
	w4rqZEXWwQIFEgEcqkxdPsCiLBKJ46F7fzyyAkp4TNownJBaJ0s6vEDvxM6D9MvQ
	PWOhGbkOT2+j3pxZkzJo3xJgcX/stVXwn5jO7A7RdZhArRufMslMaqs4w5OfRT9J
	sJDfkunbPR6OxfX8yfjy+4P0nv2TStunF+ZoAOzx3ELkBX7FuSywnmgz2qJWRITP
	XftmkDBXgLoyT6JJcGx+ASm4qQ3RvN5H5GKv7Qju3DxlKL49lgobJUnEuy7Mh1ul
	gw2fTWDDl1WgfgDvi0KA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vypaq0rx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 18:10:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VIA5Nj019333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 18:10:05 GMT
Received: from [10.216.50.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 10:10:01 -0800
Message-ID: <dd0025d2-fc1f-488e-8899-a94d321b492c@quicinc.com>
Date: Wed, 31 Jan 2024 23:40:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
 <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
 <CANP3RGeQ0-2vg0OeOHCuUzgeRRH4JyPw511Eoyy=HA-M9YAX2A@mail.gmail.com>
 <CANP3RGebjQhjCMVg5h936kp2mcCFcRvwzwi+84vxzFeUnmQwCQ@mail.gmail.com>
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGebjQhjCMVg5h936kp2mcCFcRvwzwi+84vxzFeUnmQwCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l8PP6uVYgcb0XiwqQzbDAxMkUSpWBWIc
X-Proofpoint-GUID: l8PP6uVYgcb0XiwqQzbDAxMkUSpWBWIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=1 suspectscore=0
 malwarescore=0 spamscore=1 mlxlogscore=218 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310140



On 1/31/2024 10:48 PM, Maciej Żenczykowski wrote:

>>
>> Also since this is a fix, it should probably have a Fixes tag
>> (possibly on some original sha1 that added the driver, since I think
>> it's always been broken) or at least a commit title that more clearly
>> flags it as a 'fix' or cc stable...
>>
>> (something like 'usb: gadget: ncm: fix rare win11 packet discard')
>>
>> We definitely want this to hit LTS...
> 
> One more thing: the 'goto done' and 'done' label are not needed -
> that's already the natural code flow...
> So the 'goto' could just be replaced with a comment or perhaps with
> --to_process.

ACK. I thought getting out of the function was better than doing a NOP 
calculation. Either ways is fine by me. Will make this change in v3.

Regards,
Krishna,

