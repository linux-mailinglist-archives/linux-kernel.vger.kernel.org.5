Return-Path: <linux-kernel+bounces-92864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B086872730
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD91C20922
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04222EF2;
	Tue,  5 Mar 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dn9JJQPI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAC1B26E;
	Tue,  5 Mar 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665208; cv=none; b=qEUO9HbQmG0Vt2y/W8oX36IbTCMnqj/XAD80enmM3V62rYiOhg/mgqEETAIAZ6mB1QVMjAcid9PFtZeo8KZx+fDcCy8OywpOyVAQtrjWVJkWRxHYe6It6G3CgPhU2+38IYEI8khZimMQM/fX4ETq1by9NiYy4+TlAcLzO5PJeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665208; c=relaxed/simple;
	bh=4qkJBm4gkwtI+rJ9ehfIMvBznLFDSZW3rxdS4otCPPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kWPFAEhp1kRnkMTLKFpD0fuFEN4BwbO6NHZgycS8CLCG4pjao8WSB5u0PoSsQyRNBNiYDnwljvriQcyF1AsIlz8BDcPzG6l0y5jMJtIO5vEWKNnF8HRJx6L5ax9aYIHU3fDhfJoes9/jvia40x1sM015iO1P/lB+YhjbI4sshBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dn9JJQPI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4258tQh7001427;
	Tue, 5 Mar 2024 18:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JGG8vIlqUux9Ze8A1exSbeSM6qeUkyMclht+somW8Ic=; b=dn
	9JJQPI2zIj8ksEvox7sikiFO6e/lGx6WDZdokvMoLavGD1IxVMAfH0My10+pZ1Et
	uwX1R6JrzdwL0G+Y3+10AHm0pOsTHyj0K2A/GTDEJCJEDh6zvBgP2C541Gf7VPzn
	4gvunfr+MfchRaBwuj5TLPM0Qe2sKGkXB0b4+DycBDP333BRioWqbPplPvEBwKJq
	lx5mCfguTFZc6i4c4aXzHIbxyPEtfokaczfWsAenoq8GEEdnR+R23D0nd+/fZ4AP
	sbrTxo3dXaTT/SK9MDPDoCAILi066eMKRxUjF8NjDyd+Zw7sYPolddzf+Hg+PCEa
	/plorgR4PnsQYCR3XWgg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp00x1bak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:59:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425IxUCC028680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:59:30 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 10:59:27 -0800
Message-ID: <467b8479-dfd8-43a4-92eb-d19dc65989cd@quicinc.com>
Date: Tue, 5 Mar 2024 10:59:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Restructure init sequence to set aside reserved
 memory earlier
To: <chenhuacai@kernel.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC: <linux-openrisc@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <kernel@quicinc.com>
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CB9Kpu3dCVofJSSAHKIFdpa3x8HFPqVI
X-Proofpoint-GUID: CB9Kpu3dCVofJSSAHKIFdpa3x8HFPqVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_16,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxscore=0 mlxlogscore=675
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050152


On 2/9/2024 4:29 PM, Oreoluwa Babatunde wrote:
> The loongarch, openric, and sh architectures allocate memory from
> memblock before it gets the chance to set aside reserved memory regions.
> This means that there is a possibility for memblock to allocate from
> memory regions that are supposed to be reserved.
>
> This series makes changes to the arch specific setup code to call the
> functions responsible for setting aside the reserved memory regions earlier
> in the init sequence.
> Hence, by the time memblock starts being used to allocate memory, the
> reserved memory regions should already be set aside, and it will no
> longer be possible for allocations to come from them.
>
> I am currnetly using an arm64 device, and so I will need assistance from
> the relevant arch maintainers to help check if this breaks anything from
> compilation to device bootup.
>
> Oreoluwa Babatunde (3):
>   loongarch: Call arch_mem_init() before platform_init() in the init
>     sequence
>   openrisc: Call setup_memory() earlier in the init sequence
>   sh: Call paging_init() earlier in the init sequence
>
>  arch/loongarch/kernel/setup.c | 2 +-
>  arch/openrisc/kernel/setup.c  | 6 +++---
>  arch/sh/kernel/setup.c        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
Hello,

Loongarch patch has already merged for this, but review is still pending
from openrisc and sh architectures.
Could someone please comment on these?

Regards,

Oreoluwa

