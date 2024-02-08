Return-Path: <linux-kernel+bounces-57526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0684DA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931381F22DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509D692F1;
	Thu,  8 Feb 2024 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bFDTUXl6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4583F9DB;
	Thu,  8 Feb 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374269; cv=none; b=AVrxmqZuOAKGpUoj/dT2G3ScvShmZntYzH3rVdK6tTAQExeo3yPWu/k+dHkwRLOeCcPCOlYevrZi082iz1s5r7kvvvNiMx4aPIvB57H59fS4m1p7en2fzYipKa4/KG+TrvOQqlrMsUL8ojKxIpWzs62LzT565OEM3xrNOaYp6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374269; c=relaxed/simple;
	bh=lpXhkHZbuArCIRnXjztrmiKSWD1vpZgicgPTWP2akM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HnM39Eb3/IdvScht3HrbeHBbqjXLFBsF6qE6SZwW0D+vOR4xNqQF3n48vE4axXoytOAlU1LW0Jy53pnfI63cikssSlU6oPtSiIyZg8FsZBjH4Qcc2WFOdaNDz7WPEacN7kYMdYNp0SYcqrPbjaI2Rl2oqZIRu8ki635CTAOyntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bFDTUXl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185D5hi006412;
	Thu, 8 Feb 2024 06:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s8qbuSFNjJuBlNttAu8PtvH2rwU4SiJ0wONp6iuuAsI=; b=bF
	DTUXl6pS058Zz31ygL7EmXWx/gXfk03IPrT5hJ0DtzzRY6xpWbVb0p0vgiASyd97
	Vrb657EcD8ZopFRaiVtaGkwIG4MQphQzTCQ5Ju7ZOkblvNOJHQDy6nGvnnNlYRTC
	G1IJvq2rK6nBjZ+g61Dg6qVIiMEiFlDaM6MNvt7ewV3lZxRYnLrBvWaMmKv9+s0z
	GOPWag4Rj2Ihic6cP9MVK8jTUJcxeGIUXQYu273jy8yudzux7fzBKv700W5Ajjq5
	gN5YsiE9XtjGBtupEXgbacfUQqgEOs5Y1K6XV+IULNcVYIhH1T9lSJaVxgxrXmh/
	eKZEkPCAV/VZikGa4Rrw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4862tbfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 06:37:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4186bWpL021127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 06:37:32 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 22:37:28 -0800
Message-ID: <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>
Date: Thu, 8 Feb 2024 14:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>,
        Vijayanand Jitta
	<quic_vjitta@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Faiyaz Mohammed <quic_faiyazm@quicinc.com>, <karahmed@amazon.de>,
        <qperret@google.com>, <robh@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
 <Yu1t8TpXT1f372v/@kernel.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <Yu1t8TpXT1f372v/@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q-G5v7MzFic47PyoNP9mknXqO5nMNrSC
X-Proofpoint-GUID: q-G5v7MzFic47PyoNP9mknXqO5nMNrSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080034



On 8/6/2022 3:22 AM, Mike Rapoport wrote:
> Hi Vijay,
> 
> On Wed, Aug 03, 2022 at 04:27:33PM +0530, Vijayanand Jitta wrote:
>>
>> On 5/9/2022 5:12 PM, Mike Rapoport wrote:
>>> On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
>>>>
>>>> On 5/5/2022 10:24 PM, Mike Rapoport wrote:
>>>>> On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
>>>>>> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
>>>>>>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
>>>>>>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
>>>>>>>> memory region")' is keeping the no-map regions in memblock.memory with
>>>>>>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
>>>>>>>> but during the initialization sparse_init mark all memblock.memory as
>>>>>>>> present using for_each_mem_pfn_range, which is creating the memmap for
>>>>>>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
>>>>>>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
>>>>>>>> ~11MB memory for ~612MB carve out.
>>>>>>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
>>>>>>> really don't like the idea if adding more implicit assumptions about how
>>>>>>> NOMAP memory may or may not be used in a generic iterator function.
>>>>>> Sorry for delayed response.
>>>>>> Yes, it is possible that implicit assumption can create
>>>>>> misunderstanding. How about adding command line option and control the
>>>>>> no-map region in fdt.c driver, to decide whether to keep "no-map" region
>>>>>> with NOMAP flag or remove?. Something like below
>>>>> I really don't like memblock_remove() for such cases.
>>>>> Pretending there is a hole when there is an actual DRAM makes things really
>>>>> hairy when it comes to memory map and page allocator initialization.
>>>>> You wouldn't want to trade system stability and random memory corruptions
>>>>> for 11M of "saved" memory.
>>>>
>>>> Creating memory map for holes memory is adding 11MB overhead which is
>>>> huge on low memory target and same time 11MB memory saving is good enough
>>>> on low memory target.
>>>>
>>>> Or we can have separate list of NOMAP like reserved?.
>>>>
>>>> Any other suggestion to address this issue?.
>>>
>>> Make your firmware to report the memory that Linux cannot use as a hole,
>>> i.e. _not_ report it as memory.
>>>   
>>
>> Thanks, Mike for the comments.
>>
>> Few concerns with this approach.
>>
>> 1) One concern is, even if firmware doesn't report these regions as
>> memory, we would need addresses for these to be part of device tree so
>> that the clients would be able to get these addresses. Otherwise there
>> is no way for client to know these addresses.
>>
>> 2) This would also add a dependency on firmware to be able to pass these
>> regions not as memory, though we know that these regions would be used
>> by the clients. Isn't it better to have such control within the kernel ?
> 
> If it is memory that is used by the kernel it should be reported as memory
> and have the memory map.
> If this is a hole in the memory layout from the kernel perspective, then
> kernel should not bother with this memory.
Hi Mike,

We've put effort on bootloader side to implement the similar suggestion 
of os bootloader to convey the reserved memory by omit the hole from 
/memory@0{reg=[]} directly.
While there is a concern from device tree spec perspective, link [1]: "A 
memory device node is required for all devicetrees and describes the 
physical memory layout for the system. "
Do you have any idea on this pls?

[1] 
https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst
> 
> And I'm not buying "low memory target" argument if you have enough memory
> to carve out ~600M for some mysterious clients.
Just for your information, for low memory target, the carve out can be 
more than ~60M out of 128M in total.
>   
>> Let me know your comments on these.
>>
>> Thanks,
>> Vijay
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

