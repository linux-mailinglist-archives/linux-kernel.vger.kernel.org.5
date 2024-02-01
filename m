Return-Path: <linux-kernel+bounces-48575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFB845E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B821C232B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D70161B68;
	Thu,  1 Feb 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f1SvHe3b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C2161B51;
	Thu,  1 Feb 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807790; cv=none; b=Bo8qAt9un7Qvz3JZdSKFen9B7Iz4fSWe6uwYAU8z3fkc4WIzCd/rtpXmGcoU7cK2JxusSW3xMdy+esG4Wb8RGnEjlfVSuUzvP2W8YauDL309mHJcQSWXa8JiwBuUZmIxFOQgmt8Io6BFHQ2AMZlC3qQMEz4zIeJAOjyZtfLhS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807790; c=relaxed/simple;
	bh=VvxKRjY5URgw1fonF5xTUVugF0jSJ5unaPiJg2Jfuv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YykcdvJjtFgBNR86DvaFCq9JejRLbFb0zxQkCy8KGfXJvGYCNbmxOOrvHUdgYuG/oEQT6L3iomG7ElV5xiNUHEQjP9WRtmSYnlVKMzzReTG4kDXQa7OABUPMU+WFuEz36ey76o4uL0jnNT03b9mCKjTwqk8YqSq949gyQ6GNMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f1SvHe3b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411DiuCY028022;
	Thu, 1 Feb 2024 17:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=adC2fIak5lQrRyvRWaiA1UjeuwiIqWh2wGfcH9ogayM=; b=f1
	SvHe3bwQDbssL/ib2RWDqwLLYnRJfOv/qDRFTCq2VAxepcNg4lPDL1bimO8TjCMM
	fYiJydqWRqByBm4bjt7RS/kYZppzW0wkAkOm3Za/2sKGNvCC1oKr66VRECYc6DY+
	V1JSqvRAzQOK3t3NBaKd+8/jjedAElGkN1USYngqCo4Y93WiJ2vazHPY4uSWUkrE
	lXmKRHnsOOK41DZJh74Jb0swkHMRH7z1ttdZfffEKt7gdadhI0+k5gx1VnNIGu7k
	PZZVS8PtMwehjOA0vu6t5ud2QAZhymt0Tabw2WtCV+460EJ/Y1ActF66B7gCCduS
	Zmb9FsiB5Txy0Pxo3Q7g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b1qrrja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:15:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411HFOQf005006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 17:15:24 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 09:15:20 -0800
Message-ID: <a574e6ac-1ac7-4c27-b6eb-58225033262c@quicinc.com>
Date: Thu, 1 Feb 2024 09:15:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/46] sh: reserved_mem: Implement the new processing
 order for reserved memory
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <frowand.list@gmail.com>,
        <vgupta@kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <guoren@kernel.org>, <monstr@monstr.eu>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
 <20240126235425.12233-15-quic_obabatun@quicinc.com>
 <20240131154130.GA1336725-robh@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240131154130.GA1336725-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 57ZCB5dDQL9PJqTKF3G1hDlE0WM_uOzf
X-Proofpoint-GUID: 57ZCB5dDQL9PJqTKF3G1hDlE0WM_uOzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=450 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010134


On 1/31/2024 7:41 AM, Rob Herring wrote:
> On Fri, Jan 26, 2024 at 03:53:53PM -0800, Oreoluwa Babatunde wrote:
>> Call early_fdt_scan_reserved_mem() in place of
>> early_init_fdt_scan_reserved_mem() to carry out the first stage of the
>> reserved memory processing only.
>>
>> The early_fdt_scan_reserved_mem() function is used to scan through the
>> DT and mark all the reserved memory regions as reserved or nomap as
>> needed, as well as allocate the memory required by the
>> dynamically-placed
>> reserved memory regions.
>>
>> The second stage of the reserved memory processing is done by
>> fdt_init_reserved_mem(). This function is used to store the information
>> of the statically-placed reserved memory nodes in the reserved_mem
>> array as well as call the region specific initialization function on all
>> the stored reserved memory regions.
>>
>> The call to fdt_init_reserved_mem() is placed right after
>> early_fdt_scan_reserved_mem() because memblock allocated memory should
>> already be writable at this point.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  arch/sh/boards/of-generic.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
>> index f7f3e618e85b..7bec409f077c 100644
>> --- a/arch/sh/boards/of-generic.c
>> +++ b/arch/sh/boards/of-generic.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_clk.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/of_reserved_mem.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/irqchip.h>
>>  #include <asm/machvec.h>
>> @@ -110,7 +111,8 @@ static int noopi(void)
>>  static void __init sh_of_mem_reserve(void)
>>  {
>>  	early_init_fdt_reserve_self();
>> -	early_init_fdt_scan_reserved_mem();
>> +	early_fdt_scan_reserved_mem();
>> +	fdt_init_reserved_mem();
> Looking at the sh code, there's an existing problem with the order of
> init. This is called from paging_init() and is done after unflattening
> and copying the DT. That means the kernel could freely allocate memory
> for the DT in a reserved region.
>
> Rob

Hi Rob,

Yes I agree! I can try to restructure the code to address
this. I think we should be able to move the call to
early_init_fdt_scan_reserved_mem() higher in the init
sequence without having any issues.

Will try this out and see.

Regards,
Oreoluwa


