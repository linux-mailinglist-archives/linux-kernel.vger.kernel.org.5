Return-Path: <linux-kernel+bounces-48576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDAD845E53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC531F24F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605BD163A8F;
	Thu,  1 Feb 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g4DUvqZp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD3163A91;
	Thu,  1 Feb 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807914; cv=none; b=RmpLs68dLppyPawEw80saYMaqiPf0xavKf7NSQJcuXrWP5oPaEbGR52KQr3jqSf8DMPifN8M7V7+mp4qt5mTAUX4fvJms2/Ll2IPiSRhDrTincXPyr4C0s6ePb9D1KbAldE0j0Uq8mIOlx8+1N5MsJHX/DXGgPDQ/aJJCaS6D+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807914; c=relaxed/simple;
	bh=j29KBmrWDKi6C4ArKnJXeiiV1GRkkIhDu+YuavJwdgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KQ1j2aibeoa2sTPGSJowyIMMAfS9AVAbaTOXkMji5onUsFV5P5pOpWlSqGKZz2EBED3SIhWpIWrxjLt15P40MTMNcxwCzZpMWH77GWPXXse8+7z7jWMF9zIREBw/Wk7m+5GCXjd9RNxyb9SZpEBv6sieTUXAPophkMlQ1hHd1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g4DUvqZp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411FE2Cb012758;
	Thu, 1 Feb 2024 17:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EokvtWFKF9p+6K+LLGGEOH+NzHrsaf5dZDactxwkGh8=; b=g4
	DUvqZpVo7QGRA8HwZfmFEaHg8iYBazk3QFTTiPwQetruYteENEU1z1SkleHkNQUR
	bb5qOaJU6tpuoVibDJn0qpUjZLehxDMcqsjuufNGX+lIx8ouy84q42pa5D12UPDy
	PcYYWw4Tp3sM/Nvc3FVkVSyXtgEm+5Ss8PtWWQP1YKmmSOxso+5tIJyYJGd7eOiM
	LOSu0QcpiJfsto9bd2LOd1aIlH4vRItXZho0Je8FdA8P+ytaU0xoOr8Awwy8tcy5
	qE0vE6DJmlCCJMkIwccY3ufOGspxV0mdnXR7PSRVF92Xb7TgGTGAibIRiO1gIBWB
	xmdet9MifVvKUtV7hz8g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w098c0xy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:17:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411HHeao003126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 17:17:40 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 09:17:36 -0800
Message-ID: <c1d00213-bc4c-4f1a-b577-2cc95b62d7f9@quicinc.com>
Date: Thu, 1 Feb 2024 09:17:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/46] Loongarch: reserved_mem: Implement the new
 processing order for reserved memory
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
 <20240126235425.12233-8-quic_obabatun@quicinc.com>
 <20240131152709.GA1272666-robh@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240131152709.GA1272666-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s4q9nQ0OHCwdDY9FArS65vm-M1vH3e5N
X-Proofpoint-GUID: s4q9nQ0OHCwdDY9FArS65vm-M1vH3e5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=669
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010134


On 1/31/2024 7:27 AM, Rob Herring wrote:
> On Fri, Jan 26, 2024 at 03:53:46PM -0800, Oreoluwa Babatunde wrote:
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
>> early_fdt_scan_reserved_mem() since memblock allocated memory should
>> already be writable at this point.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  arch/loongarch/kernel/setup.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index edf2bba80130..72b164d3ace0 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/libfdt.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/of_reserved_mem.h>
>>  #include <linux/of_address.h>
>>  #include <linux/suspend.h>
>>  #include <linux/swiotlb.h>
>> @@ -390,8 +391,9 @@ static void __init arch_mem_init(char **cmdline_p)
>>  
>>  	check_kernel_sections_mem();
>>  
>> -	early_init_fdt_scan_reserved_mem();
>> +	early_fdt_scan_reserved_mem();
> Looking at the loongarch code, there's an existing problem with the 
> order of init. This is done after unflattening and copying the DT. That 
> means the kernel could freely allocate memory for the DT in a reserved 
> region.
>
> Rob
Same here, I think we should be able to move the call to
early_init_fdt_scan_reserved_mem() higher in the init
sequence without having any issues.

Will try this out and see.

Regards,
Oreoluwa


