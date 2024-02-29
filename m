Return-Path: <linux-kernel+bounces-87668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA586D796
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BEC2869AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793A74C07;
	Thu, 29 Feb 2024 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jfncczdU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C76D528;
	Thu, 29 Feb 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248529; cv=none; b=jO6SOf0LOgTerFGH5ZsDwPjPN4Ge1BmbGABIzaguR88Sv8IV0AEUrotlSzUF698k4nRXrh4Vlh9k4DCfnqNf9LlxHLKrTOz6FACVfbaP1EryHvXNJmdZpKipTZWw2dLLhA2VvEWl7YOhs5wudObSmWQEQiwt8Vjfexk8frt/yww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248529; c=relaxed/simple;
	bh=eQSQRmoukqRbwmwbbD7/gGKavZkYvNoKAs7cayL9etU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RIKaKVD0JJEpcgTcsj4lgudvGfjxGlkoT5MJevNE9TM3dd2kaS2hKudCOo7/k5El/vGRRW6UTh8hyuRvKCT/pmO2uSYDJPw9ylOEj1YMPMWyTBUR0ldLxNud1TQsrtRou29zxjFBdnmgaDCRriYEtf5GmTOo0+tIZ8R83lw5P4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jfncczdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TMrj3x028916;
	Thu, 29 Feb 2024 23:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LO8ZHY0Ynu0zrZXt4D0P9flaCPbTF1zd0Tdg6VfkvPs=; b=jf
	ncczdUBsEnMtFfsiVQc3Kt+sD0F1YcqD9b/ucZcntTK8Ph6WI2pNmOClwcywkKwb
	ZReE4XHG8dtQPxmpg8bqSKx5jNEsyUW+B+Yif17Zr98DpqvZn7o4R52BzRVN20Y2
	oI7b4gxYoBWPdUjH3NsG0d5SwXru+kUQ257M0unHW3AZJs+uZ/piP/d28tbqmtNY
	8/bxL13y7GxhKCttJ+KzqDQM1x3RcZJKBOObFoJBbBWAuRAIsuk+Z74QtKpv1Evw
	hYmzCXkPEg3k86TVwbaEpvLqj7i3BGVg5ih4Dt3PpB1O6OQiWtw4FPrTWibenxZZ
	i0nikibO8bccSWtYqvvw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjx9y0xjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:15:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TNF93h013382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 23:15:09 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 15:15:05 -0800
Message-ID: <a43feb58-5fa2-4b39-8aa1-04085cd5a8d6@quicinc.com>
Date: Thu, 29 Feb 2024 15:15:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney
	<ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
CC: <kernel@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <2fc6a4f7ea0308626cfd06d95564486d187b16e0.camel@redhat.com>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <2fc6a4f7ea0308626cfd06d95564486d187b16e0.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rzryWo_RpJZbtw8qkxFBNMUpiyQ_SWJB
X-Proofpoint-ORIG-GUID: rzryWo_RpJZbtw8qkxFBNMUpiyQ_SWJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=649
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290183



On 2/29/2024 1:30 AM, Paolo Abeni wrote:
> On Tue, 2024-02-27 at 17:12 -0800, Abhishek Chauhan wrote:
>> Bridge driver today has no support to forward the userspace timestamp
>> packets and ends up resetting the timestamp. ETF qdisc checks the
>> packet coming from userspace and encounters to be 0 thereby dropping
>> time sensitive packets. These changes will allow userspace timestamps
>> packets to be forwarded from the bridge to NIC drivers.
>>
>> Existing functionality of mono_delivery_time is not altered here
>> instead just extended with userspace tstamp support for bridge
>> forwarding path.
>>
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> 
> Since this is touching a quite sensitive code path, I think v3 would
> deserve some paired self-tests.
> 

I did verify the existing so_txtime selftest for the same which does FQ 
and ETF tests which sends/recieve packets with both mono and tai clocks. 

OK. All tests passed (so_txtime.sh) 
Sometimes i saw resource temporarily unavailable in RX which i believe is a 
known issue 
https://www.mail-archive.com/linux-kselftest@vger.kernel.org/msg06792.html

Along with this i also did mqprio + etf offload testing on internal platform. 
1. iperf3 best effort testing UDP/TCP 
2. Sent ETF packets from userspace application just like so_txtime.c but 
with SO_PRIORITY and added dumpstack to check the flow of packets. I saw no
issues on internal platform.  
3. I will mention all the testing in Tx/Rx path done for v3 patch. 

> Thanks!
> 
> Paolo
> 

