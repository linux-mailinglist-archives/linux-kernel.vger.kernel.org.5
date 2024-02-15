Return-Path: <linux-kernel+bounces-67823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74185716F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366C228610B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B556145B1C;
	Thu, 15 Feb 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d/jRp3X4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A90145347;
	Thu, 15 Feb 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038903; cv=none; b=O/tSUgNEcp01CRdbNcBMMBGYHsPGDP8g98DXNlZVItG055VCjO/N+BaLqfIrATk58jNVaTfNGlWG/N/JghD8j/SmmVOOqC7/jELBbL6Vj2KwPdsAbp9jv+0NBFxHdjbL7lOpC0X6htk0Bu/Y88L0tjPtQE8r3bjdSteb9P8XeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038903; c=relaxed/simple;
	bh=kkZuiXaGXL2NSvfp8TJT78LlVMJc9yfD6NIst999GXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j9yWDTCX0kla6w6wo1lzG3+pCqi6JwgwdSNu+w0Saj/RvUDwFQyHMOALcSuJAEIWm22NbSYWFx6e+Ua+8NsaVJdrpDJAabxi6haCOjwBcwAPNdWWRc9Cx6KSg4btadjyNqWyoYpwssBEtsC4JbEAJtzXzCT0ha0oFEY+G0AAlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d/jRp3X4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FLtRte015246;
	Thu, 15 Feb 2024 23:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Na4yrg3jGMm98wMfTbdkHUipcrGpYs/jVPo+b9B+2cc=; b=d/
	jRp3X498SH8HoZ9EfAEw8BNKLiPBqy6BVUdYNTrNGkhwNhg3nWLVlo6wApMDNrPz
	JjrgCMGapru4PZ8etfeSOQGIonbrVTB+lcjPVn0WstxlP7g4K1pVNeH/faXHY0JT
	nIaYXxy7auATAyE0gAfEkKPrCmZ5KE7hdBBBw8WyzNpy5aUGZTDR9I5zLSvRL75y
	qyzwP9qhfZUdJA64nxJzviWJR5AvV2B3deiQk93GPvEkeNLP5VgMhrz9EfDiDARe
	7Bd7pI9MnNkeV6fMCtFMv6Ljvh2ajFLfSad5/270LT8yrwLKKVmq2SJXtjbr6fRz
	yKbY1WJI3vS3pC7e8qvw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9gv7hyn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FNEohb007846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:50 GMT
Received: from [10.110.53.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 15:14:47 -0800
Message-ID: <6172a734-3bbd-4aa9-a20b-b7b95bb166aa@quicinc.com>
Date: Thu, 15 Feb 2024 15:14:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: Add skb user timestamp flag to
 distinguish between timestamps
Content-Language: en-US
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
References: <20240215215632.2899370-1-quic_abchauha@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240215215632.2899370-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eIEaMGK0myUHwb0FiO-Rxgx53PbkdrJS
X-Proofpoint-ORIG-GUID: eIEaMGK0myUHwb0FiO-Rxgx53PbkdrJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=807
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150181

On 2/15/2024 1:56 PM, Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Note:- I am a little skeptical of using bool inside the skbuff
> structure as no one today has used bool so far in the struct.
> (Expecting some comments from upstream for sure) 

there are a large number of u8 <flag>:1 bitfields -- suggest you do the same


