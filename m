Return-Path: <linux-kernel+bounces-57060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1A84D38B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918E91F26B19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC456129A69;
	Wed,  7 Feb 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g+UAQ7K5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BE12881A;
	Wed,  7 Feb 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340590; cv=none; b=E/Kq0EUb620eLdakU6rqHcZ8LKn2+adP8EXqOK57OeQe+f0EsJ/9U7+8dHiFFMqvkIyP0sn68OX14NKNEXN7P+3xCqyqY2CDUq7m+a/4Kbr+OAi+AreOQwHG+fLn3xraiJqEdmfwtK/5iNc/FgUnza9n4RYpNSgxiiBoWSlKDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340590; c=relaxed/simple;
	bh=NdgrDHJpLDF/ugk+67xpDsIiQ2CmRjjcJSAiiY+4BmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MKsHgTS7g1eO5gaa9u5XvwwpCE2Uc2dRZkEzO6a06lSZI7v0W07RVjtSDJ5ZtRXUh9lE99cMVLb8CvuHDASkhif68uD+Xm/PdGWusjgIl7UPdPGvb89QbhCq0186oW/hV0aYJCMrLkDKddb8MuIIf/0TUZxUCsFQTULMBB32AH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g+UAQ7K5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417GdhB8026353;
	Wed, 7 Feb 2024 21:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xssBXkIFwp8Qc3VsHMHlqjCSLrjp9Hn0rPQpY0OO7jw=; b=g+
	UAQ7K50KKZY5xiv7eHQ5hf/R1cNchFamM23bua3c7xtaivZiRAHqWY6OFQWElYUa
	bscr8eQzsHi6qtSohkT6gOCTkoKVsO9e+cV5k6UnAhs4anc2Vgi+DrEMyU2XPhRX
	vsf4yqqzb8ZLdS84/cw2NzEFgGcfmJP4DHVuTlFBDTk0CoAHWzQeNWaQW2IToSpN
	fVQJn6/VEz6VG8m9Y+BzT2/fvHaMpkLrJEMMgUEfgHgw8bs+foijwcqrEmTY0Y+U
	WJgp5YTFvjPcYsPmgszbJqhnFG0y1kk+f9HF1LSfooC9TrF3spQMfL82o9+e1hlb
	l9T7/8hpOKHqZLyf21lg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ud2tx28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 21:13:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417LDH5a008164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 21:13:17 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 13:13:14 -0800
Message-ID: <c9c3c7a0-9699-496e-a277-a1be6142ceb8@quicinc.com>
Date: Wed, 7 Feb 2024 13:13:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] Dynamic allocation of reserved_mem array.
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
 <20240131000710.GA2581425-robh@kernel.org>
 <51dc64bb-3101-4b4a-a54f-c0df6c0b264c@quicinc.com>
 <20240201194653.GA1328565-robh@kernel.org>
 <d98288ed-a0d9-4fc1-87bc-d79cb528778c@quicinc.com>
 <20240202152908.GA4045321-robh@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240202152908.GA4045321-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _IZmLyVlnj2XpqbBn-yQcHXlUIf1zv8L
X-Proofpoint-GUID: _IZmLyVlnj2XpqbBn-yQcHXlUIf1zv8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=883 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070156


On 2/2/2024 7:29 AM, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 01:10:18PM -0800, Oreoluwa Babatunde wrote:
>> On 2/1/2024 11:46 AM, Rob Herring wrote:
>>> On Thu, Feb 01, 2024 at 09:08:06AM -0800, Oreoluwa Babatunde wrote:
>>>> On 1/30/2024 4:07 PM, Rob Herring wrote:
>>>>> On Fri, Jan 26, 2024 at 03:53:39PM -0800, Oreoluwa Babatunde wrote:
>>>>>> The reserved_mem array is used to store data for the different
>>>>>> reserved memory regions defined in the DT of a device.  The array
>>>>>> stores information such as region name, node, start-address, and size
>>>>>> of the reserved memory regions.
>>>>>>
>>>>>> The array is currently statically allocated with a size of
>>>>>> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
>>>>>> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
>>>>>> will not have enough space to store the information for all the regions.
>>>>>>
>>>>>> Therefore, this series extends the use of the static array for
>>>>>> reserved_mem, and introduces a dynamically allocated array using
>>>>>> memblock_alloc() based on the number of reserved memory regions
>>>>>> specified in the DT.
>>>>>>
>>>>>> Some architectures such as arm64 require the page tables to be setup
>>>>>> before memblock allocated memory is writable.  Therefore, the dynamic
>>>>>> allocation of the reserved_mem array will need to be done after the
>>>>>> page tables have been setup on these architectures. In most cases that
>>>>>> will be after paging_init().
>>>>>>
>>>>>> Reserved memory regions can be divided into 2 groups.
>>>>>> i) Statically-placed reserved memory regions
>>>>>> i.e. regions defined in the DT using the @reg property.
>>>>>> ii) Dynamically-placed reserved memory regions.
>>>>>> i.e. regions specified in the DT using the @alloc_ranges
>>>>>>     and @size properties.
>>>>>>
>>>>>> It is possible to call memblock_reserve() and memblock_mark_nomap() on
>>>>>> the statically-placed reserved memory regions and not need to save them
>>>>>> to the reserved_mem array until memory is allocated for it using
>>>>>> memblock, which will be after the page tables have been setup.
>>>>>> For the dynamically-placed reserved memory regions, it is not possible
>>>>>> to wait to store its information because the starting address is
>>>>>> allocated only at run time, and hence they need to be stored somewhere
>>>>>> after they are allocated.
>>>>>> Waiting until after the page tables have been setup to allocate memory
>>>>>> for the dynamically-placed regions is also not an option because the
>>>>>> allocations will come from memory that have already been added to the
>>>>>> page tables, which is not good for memory that is supposed to be
>>>>>> reserved and/or marked as nomap.
>>>>>>
>>>>>> Therefore, this series splits up the processing of the reserved memory
>>>>>> regions into two stages, of which the first stage is carried out by
>>>>>> early_init_fdt_scan_reserved_mem() and the second is carried out by
>>>>>> fdt_init_reserved_mem().
>>>>>>
>>>>>> The early_init_fdt_scan_reserved_mem(), which is called before the page
>>>>>> tables are setup is used to:
>>>>>> 1. Call memblock_reserve() and memblock_mark_nomap() on all the
>>>>>>    statically-placed reserved memory regions as needed.
>>>>>> 2. Allocate memory from memblock for the dynamically-placed reserved
>>>>>>    memory regions and store them in the static array for reserved_mem.
>>>>>>    memblock_reserve() and memblock_mark_nomap() are also called as
>>>>>>    needed on all the memory allocated for the dynamically-placed
>>>>>>    regions.
>>>>>> 3. Count the total number of reserved memory regions found in the DT.
>>>>>>
>>>>>> fdt_init_reserved_mem(), which should be called after the page tables
>>>>>> have been setup, is used to carry out the following:
>>>>>> 1. Allocate memory for the reserved_mem array based on the number of
>>>>>>    reserved memory regions counted as mentioned above.
>>>>>> 2. Copy all the information for the dynamically-placed reserved memory
>>>>>>    regions from the static array into the new allocated memory for the
>>>>>>    reserved_mem array.
>>>>>> 3. Add the information for the statically-placed reserved memory into
>>>>>>    reserved_mem array.
>>>>>> 4. Run the region specific init functions for each of the reserve memory
>>>>>>    regions saved in the reserved_mem array.
>>>>> I don't see the need for fdt_init_reserved_mem() to be explicitly called 
>>>>> by arch code. I said this already, but that can be done at the same time 
>>>>> as unflattening the DT. The same conditions are needed for both: we need 
>>>>> to be able to allocate memory from memblock.
>>>>>
>>>>> To put it another way, if fdt_init_reserved_mem() can be called "early", 
>>>>> then unflattening could be moved earlier as well. Though I don't think 
>>>>> we should optimize that. I'd rather see all arches call the DT functions 
>>>>> at the same stages.
>>>> Hi Rob,
>>>>
>>>> The reason we moved fdt_init_reserved_mem() back into the arch specific code
>>>> was because we realized that there was no apparently obvious way to call
>>>> early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem() in the correct
>>>> order that will work for all archs if we placed fdt_init_reserved_mem() inside the
>>>> unflatten_devicetree() function.
>>>>
>>>> early_init_fdt_scan_reserved_mem() needs to be
>>>> called first before fdt_init_reserved_mem(). But on some archs,
>>>> unflatten_devicetree() is called before early_init_fdt_scan_reserved_mem(), which
>>>> means that if we have fdt_init_reserved_mem() inside the unflatten_devicetree()
>>>> function, it will be called before early_init_fdt_scan_reserved_mem().
>>>>
>>>> This is connected to your other comments on Patch 7 & Patch 14.
>>>> I agree, unflatten_devicetree() should NOT be getting called before we reserve
>>>> memory for the reserved memory regions because that could cause memory to be
>>>> allocated from regions that should be reserved.
>>>>
>>>> Hence, resolving this issue should allow us to call fdt_init_reserved_mem() from
>>>> the  unflatten_devicetree() function without it changing the order that we are
>>>> trying to have.
>>> There's one issue I've found which is unflatten_device_tree() isn't 
>>> called for ACPI case on arm64. Turns out we need /reserved-memory 
>>> handled in that case too. However, I think we're going to change 
>>> calling unflatten_device_tree() unconditionally for another reason[1]. 
>>>
>>> [1] https://lore.kernel.org/all/efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org/
>>>
>>>> I will work on implementing this and send another revision.
>>> I think we should go with a simpler route that's just copy the an 
>>> initial array in initdata to a properly sized, allocated array like the 
>>> patch below. Of course it will need some arch fixes and a follow-on 
>>> patch to increase the initial array size.
>>>
>>> 8<--------------------------------------------------------------------
>>> From: Rob Herring <robh@kernel.org>
>>> Date: Wed, 31 Jan 2024 16:26:23 -0600
>>> Subject: [PATCH] of: reserved-mem: Re-allocate reserved_mem array to actual
>>>  size
>>>
>>> In preparation to increase the static reserved_mem array size yet again,
>>> copy the initial array to an allocated array sized based on the actual
>>> size needed. Now increasing the the size of the static reserved_mem
>>> array only eats up the initdata space. For platforms with reasonable
>>> number of reserved regions, we have a net gain in free memory.
>>>
>>> In order to do memblock allocations, fdt_init_reserved_mem() is moved a
>>> bit later to unflatten_device_tree(). On some arches this is effectively
>>> a nop.
> [...]
>
>> Hi Rob,
>>
>> One thing that could come up with this is that  memory
>> for the dynamically-placed reserved memory regions
>> won't be allocated until we call fdt_init_reserved_mem().
>> (i.e. reserved memory regions defined using @alloc-ranges
>> and @size properties)
>>
>> Since fdt_init_reserved_mem() is now being called from
>> unflatten_device_tree(), the page tables would have been
>> setup on most architectures, which means we will be
>> allocating from memory that have already been mapped.
>>
>> Could this be an issue for memory that is supposed to be
>> reserved? 
> I suppose if the alloc-ranges region is not much bigger than the size 
> and the kernel already made some allocation that landed in the region, 
> then the allocation could fail. Not much we can do other than alloc the 
> reserved regions as soon as possible. Are there cases where that's not 
> happening?
Correct, the best thing we can do here is to make sure we allocate the
reserved memory regions as soon as possible to avoid other users from
allocating from these regions.
>
> I suppose the kernel could try and avoid all alloc-ranges until they've 
> been allocated, but that would have to be best effort. I've seen 
> optimizations where it's desired to spread buffers across DRAM banks, so 
> you could have N alloc-ranges for N banks that covers all of memory.
ack
>
> There's also the issue that if you have more fixed regions than memblock 
> can handle (128) before it can reallocate its arrays, then the 
> page tables themselves could be allocated in reserved regions.
True, this is also a limitation on the side of memblock, and there is
not much else we can do on this front as well.
> [ . . . ]
> 'no-map' is a hint, not a guarantee. Arm32 ignores it for regions 
> within the kernel's linear map (at least it used to). I don't think 
> anything changes here with it.
Anyone adding the "no-map" property to a reserved region is specifying that the region must not be mapped into the kernel page tables so that that there is no access from other users, not even speculative accesses.

This can be seen in the description of no-map here: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79

I'm not sure about the arm32 architecture taking no-map as a hint, but I ran some tests on the arm64 architecture which I am currently testing on, and when a region is marked as no-map, it is excluded from the kernel page mappings (which is the correct behavior from the description of no-map above). But if we wait until after the page tables are setup to initialize reserved memory regions that are marked as no-map, then those regions would already be part of the page tables. And this defeats the purpose of users specifying no-map for their reserved memory. Hence, I think it is important to prioritize marking all nomap reserved memory regions as nomap before the page tables are setup so that this functionality is preserved. And we are able to achieve this with the code re-ordering that is being done in [PATCH 01/46] of this series. Regards, Oreoluwa

