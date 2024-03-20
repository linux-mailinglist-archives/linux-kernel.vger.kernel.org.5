Return-Path: <linux-kernel+bounces-109060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB0881421
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA95B1C213BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1650A64;
	Wed, 20 Mar 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1p0M6VQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78D4EB45;
	Wed, 20 Mar 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947214; cv=none; b=oA/Tlz8kMQSGGt/iVHQqPEefzmywdsJwsQCXUeam0Pw3/vgUUf8FKa6w2WSNMI8wfb4YxuwklLSQ1DhmI0zfWsJMdn5L1ySRrVuMNLLri00oTjkbHTSs9RJWCXcvX9Yd8VbP9BF4wOBJX3ZUKDCg0TXca7nH91NT/EKETV3KWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947214; c=relaxed/simple;
	bh=FjEc5K6JHS8LKKyVemeyIYqMJ/r1Vz8wxcxipv9vHes=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ESyPa7KfSqY8AKGuT/bIiQWECkqA+HGxzTu4GxXXVWqocU0BWx9xmC+x8AZBtyxI0T1BiUhC94qDWFt1rjgiB8YFu4RPlA/Wrj5AOzLAVJbnJgonNhjie/yUcpOp8G7XAScKVXqE8ts1/FIK2ubQq/SctY8ULtKupm7SfdIDJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1p0M6VQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEkBGt005328;
	Wed, 20 Mar 2024 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ftYAxfkICjzayR6na3uXUiysjfTJYLrKXjK/TKVeJNE=; b=L1
	p0M6VQ5XRXBs2KBPs51l7VHXL21Kc9/UhAOV6am/LeGt5TNjvNMw0K2Mml/6ZvUo
	mSfbifa4aJBUp7NJSJOJS0McCWVtBKMNQaReJemK5ytYVR1UhZtkycM4iBQGBLZ/
	g8ylZ17tkav0qYVzrzc2SGUC87oYrlCkSS9/ZfrgnG0Wngd8MY4hJVEuaPui6X/S
	OK026MFHM7OKePUfB8Wt2j+WfSkDCmzEthYyiBYMGbE+navwbmwWhlCHMsIE1sl3
	lr/wjPLwhG1RuaaMH7M0/Bi/jjM20rQiz9aff4r8mdnUgdm3mj8E4anPXLVmaE8u
	/V5aksc+MJdjBC9enOSA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq1gy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:06:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KF6V5D031726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:06:31 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 08:06:30 -0700
Message-ID: <bd9a0575-c7e0-4443-9417-7a998e1ae123@quicinc.com>
Date: Wed, 20 Mar 2024 08:06:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allocate dummy net_device dynamically
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <kuba@kernel.org>,
        <keescook@chromium.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)"
	<linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS
 DRIVER" <ath11k@lists.infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240319185735.1268980-1-leitao@debian.org>
 <871q85as8e.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <871q85as8e.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AxPF9uDyi_6B6ePxD4VeAmyI9iZYg6Y_
X-Proofpoint-GUID: AxPF9uDyi_6B6ePxD4VeAmyI9iZYg6Y_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200120

On 3/20/2024 7:32 AM, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> Embedding net_device into structures prohibits the usage of flexible
>> arrays in the net_device structure. For more details, see the discussion
>> at [1].
>>
>> Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
>> into a pointer. Then use the leverage alloc_netdev() to allocate the
>> net_device object at ath11k_ahb_config_ext_irq() for ahb, and
>> ath11k_pcic_ext_irq_config() for pcic.
>>
>>  The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
>> case, and ath11k_pcic_free_ext_irq() for the pcic case.
>>
>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> This crashes on my nuc x86 test box with WCN6855 hw2.0 when running
> rmmod, stacktrace below. I used tag ath-202403201010 from my ath.git
> tree as the baseline. Sorry that I'm not able to debug this further
> right now.

It seems to maintain the logic of the original that we should not use
alloc_netdev() and free_netdev() but instead should just use kmalloc()/kfree().


