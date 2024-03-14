Return-Path: <linux-kernel+bounces-102676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A423D87B5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D83B2865CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BC29AB;
	Thu, 14 Mar 2024 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D1orgEvB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC188BEA;
	Thu, 14 Mar 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376657; cv=none; b=ayVdXBKjyKlHwlj93oyNUfTw76Vpx2phPIp12y9YmtwLBI/E43JGZ3lWSgbS/isOMnQf2IiHKyYfKEOwR1tPYQTOXTxPX3sRt2gZPQFeR0BrjdPEaq28POXc7oDnRL1Iyp4sK+aRtX484DYImM3wIHv+2B2ZXzSetSCcfA3wmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376657; c=relaxed/simple;
	bh=1d0zgavVG3HuEPLnvQnvyiWVM0IDIJcLBIZ5ZUMvKQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XFLFaIC6G7GtpwabwmpqGg3O7Henxb0sRmX8Mv0M1TwbRC/tFiDzHJtzKDStmGBNrIxPKwb+kMR+zZHKBYvyo32l4TVWPrrm6StSwMeSHZEMGD89Ahvg7H1MrWp9rotzgZmjpopqwS8PrzZ2Fc3ec0SsOtU5AUEO5h6S0GyNhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D1orgEvB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DNW70s007440;
	Thu, 14 Mar 2024 00:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u8ydzRm0r66owe3d7mYdN5MVRd4EsoHiZjLgFN6728M=; b=D1
	orgEvBATetLfZadAW29ZXuEJ6x+1qlKsJeXl/KUCSCLlMa5myDMmhYhDy+Po5hQ6
	Ng1OHvF61N2f4Pnl0FTzitzMUCITshesbKI901Nmk04oVRvU3Uok5M9AOtw8Upww
	9z3UGfz2YbcsHWs0NDNeqbNn9U3bo63dFBBe2gZaZgr4ax954amS1ggP+oUR8EVC
	c1thAFdCUgyDOkyVHAqTQWnVWaAHZVx2MCrO77WwhILinvXREyaeE8hWcqhjUtGD
	H585X6LywbYY7yH9rHoNMvz9Q6gKXBvytDYEaM4d7MxfkPZALuSkCNlv6K/X8qV0
	Z9CpKRQ0h3JHOXSEHRww==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuapeht06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 00:37:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E0bEOn027253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 00:37:14 GMT
Received: from [10.110.34.216] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 17:37:10 -0700
Message-ID: <eb6094d1-0d36-4e28-9a5f-df33466778f0@quicinc.com>
Date: Wed, 13 Mar 2024 17:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney
	<ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel@quicinc.com>
References: <20240313235003.1354814-1-quic_abchauha@quicinc.com>
 <20240313171623.51ebb7bd@kernel.org>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240313171623.51ebb7bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6h5Elw_gh58SRe5EkBdxqp5TdVIRknIK
X-Proofpoint-GUID: 6h5Elw_gh58SRe5EkBdxqp5TdVIRknIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140002



On 3/13/2024 5:16 PM, Jakub Kicinski wrote:
> On Wed, 13 Mar 2024 16:50:03 -0700 Abhishek Chauhan wrote:
>> Subject: [PATCH net-next v1] Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"
>> Date: Wed, 13 Mar 2024 16:50:03 -0700
>> X-Mailer: git-send-email 2.25.1
>>
>> This reverts commit 30bb896b98fce7d823a96fc02cd69be30384a5cc.
>>
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>> Reason for revert - 
>> https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> 
>> 1. Fallback to design proposed in version 1 to have a seperate user_delivery_time
>> bit 
>> 2. Keep mono_delivery_time as ease
>> 3. Add user_delivery_time as a new bitfield will be a seperate patch 
>> 4. do not reset the time if either mono_delivery_time or user_delivery_time is set
>> 5. we will need a user_delivery_time bit and use that to look at sk_clockid
> 
> Could you please spell this out a bit more in the commit message and
> add the link as a:
> 

Certainly i can do that and explain more in the Revert commit message and point a link as mentioned 
below as why we need to fall back to design 1 proposal for adding an extra bit. 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> 
> in the commit message rather than the "throw away notes" ?
> 
> (feel free to repost asap, without usual netdev's 24h)

