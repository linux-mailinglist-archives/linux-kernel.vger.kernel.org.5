Return-Path: <linux-kernel+bounces-123119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B389025D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB80B23DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034CE12BEBE;
	Thu, 28 Mar 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hlwUv/1I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912481E48C;
	Thu, 28 Mar 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637731; cv=none; b=pELeYOcHZ/qu3yMURgNbY/idB94VvNfBN2T/0pF+ExmWlIO2ClDdk/dJ0LZikuKyDDi6SepioheKD1R5IjqFzlork5sF5tNPp350FJt2PORqFeGR9RnrIrAIbsNzAjoEZGuR2hcZLBYB5BVgjVFD9EP0u4279suSSoLzd5DkgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637731; c=relaxed/simple;
	bh=N1Hlh0/nQyHFsmO9kXfMBpqfOjJKnBxxQzST5ZvMFGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=COSlVt72JtdkwknvsGtLln1LGxaJS+iOASefJOeuDWxTmF6IlYjfHry/boLJpufOdYCHim+jcdb4+56vidb24f7fY3NAykdYQlRbfE9Hk6F0O2cGLp7dnIImW1dUeEakezbWXWLvSYwB8oHKKH3inxYwVJdPv1pm5F8XmlHsraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hlwUv/1I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SBA2M6023688;
	Thu, 28 Mar 2024 14:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JQTagzTLA0ahr+zdqFFccuIih+ODyT0fmJmBoKrjDoo=; b=hl
	wUv/1IeIk8g5cFNiLFj7Si3KibGei4qTmHufiufhKKa07Mn33fC03xh9dcZqz8q2
	Bf/YFRU8YKzm1n3qGJCqGa5NPMum3hP4ayG+SF5IxdiJhnMz3RplOeYofD5+xywY
	GEd7WyIefrXm+3kCRXdh8cZiy0izTXPj5nZDOEOs3YkOCm4dFEV5ha6WDy/JfNu5
	wwIEYCldKb6TqRGhK0yIM4fQp8AMKBY0JtI1DOQf+giSqFvQiu5TDUe/9p0ruQr7
	bMcFzNpGTffCakh4zbYRicgffIXSDKMGjwyb/NL/3DkrKsaqZdSxgbQe9hyvg8lp
	2K5K/UsBVIpuFHnUHVFw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u203ptv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 14:55:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SEtMnc027055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 14:55:22 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 07:55:19 -0700
Message-ID: <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
Date: Thu, 28 Mar 2024 20:25:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: <patchwork-bot+bluetooth@kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9N6dvkzbmne6emHvKabkk5wZfoBqHh1i
X-Proofpoint-ORIG-GUID: 9N6dvkzbmne6emHvKabkk5wZfoBqHh1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1011 mlxlogscore=821 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280102

Hi Johan,
We made this change to configure the device which supports persistent memory for the BD-Address
So to make device functional in both scenarios we are adding a new property in dts file to distinguish persistent and non-persistent support of BD Address and set HCI_QUIRK_USE_BDADDR_PROPERTY bit accordingly

On 3/26/2024 9:00 PM, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Thu, 14 Mar 2024 09:44:12 +0100 you wrote:
>> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
>>
>> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
>> storage for the Bluetooth address and must therefore start as
>> unconfigured to allow the user to set a valid address unless one has
>> been provided by the boot firmware in the devicetree.
>>
>> [...]
> 
> Here is the summary with links:
>    - Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
>      https://git.kernel.org/bluetooth/bluetooth-next/c/ac0cf3552972
> 
> You are awesome, thank you!

Thanks,
Janaki Ram

